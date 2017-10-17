Received: from eggs.gnu.org ([2001:4830:134:3::10]:49856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e4PiS-0000Ya-T5
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e4PiK-0004uh-Hd
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:07:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e4PiK-0004u7-8C
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:07:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5FC8537E74
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 11:07:11 +0000 (UTC)
Date: Tue, 17 Oct 2017 12:07:05 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171017110705.GA2326@work-vm>
References: <20171004104636.7963-1-quintela@redhat.com>
	<20171004104636.7963-8-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171004104636.7963-8-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v9 07/12] migration: Create thread
 infrastructure for multifd recv side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> We make the locking and the transfer of information specific, even if we
> are still receiving things through the main thread.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> --
> 
> We split when we create the main channel and where we start the main
> migration thread, so we wait for the creation of the other threads.
> 
> Use multifd_clear_pages().
> Don't remove object_unref()
> We use correctly the channel numbres
> ---
>  migration/migration.c |  7 +++---
>  migration/migration.h |  1 +
>  migration/ram.c       | 60 +++++++++++++++++++++++++++++++++++++++++++++++----
>  migration/socket.c    |  3 +++
>  4 files changed, 64 insertions(+), 7 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index ee98c50d8c..1e7c537954 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -388,7 +388,7 @@ static void migration_incoming_setup(QEMUFile *f)
>      qemu_file_set_blocking(f, false);
>  }
>  
> -static void migration_incoming_process(void)
> +void migration_incoming_process(void)
>  {
>      Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, NULL);
>      qemu_coroutine_enter(co);
> @@ -406,9 +406,10 @@ void migration_ioc_process_incoming(QIOChannel *ioc)
>  
>      if (!mis->from_src_file) {
>          QEMUFile *f = qemu_fopen_channel_input(ioc);
> -        migration_fd_process_incoming(f);
> +        migration_incoming_setup(f);
> +        return;
>      }
> -    /* We still only have a single channel.  Nothing to do here yet */
> +    multifd_new_channel(ioc);
>  }
>  
>  /**
> diff --git a/migration/migration.h b/migration/migration.h
> index cc196cc87f..a3db60a2a1 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -158,6 +158,7 @@ void migrate_set_state(int *state, int old_state, int new_state);
>  
>  void migration_fd_process_incoming(QEMUFile *f);
>  void migration_ioc_process_incoming(QIOChannel *ioc);
> +void migration_incoming_process(void);
>  
>  bool  migration_has_all_channels(void);
>  
> diff --git a/migration/ram.c b/migration/ram.c
> index 288201e360..745da2971d 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -597,13 +597,18 @@ static uint16_t multifd_send_page(uint8_t *address, bool last_page)
>  }
>  
>  struct MultiFDRecvParams {
> +    /* not changed */
>      uint8_t id;
>      char *name;
>      QemuThread thread;
>      QIOChannel *c;
> +    QemuSemaphore ready;
>      QemuSemaphore sem;
>      QemuMutex mutex;
> +    /* proteced by param mutex */
>      bool quit;
> +    multifd_pages_t pages;
> +    bool done;
>  };
>  typedef struct MultiFDRecvParams MultiFDRecvParams;
>  
> @@ -613,6 +618,7 @@ struct {
>      int count;
>      /* Should we finish */
>      bool quit;
> +    multifd_pages_t pages;
>  } *multifd_recv_state;
>  
>  static void terminate_multifd_recv_threads(Error *errp)
> @@ -634,6 +640,7 @@ static void terminate_multifd_recv_threads(Error *errp)
>          p->quit = true;
>          qemu_sem_post(&p->sem);
>          qemu_mutex_unlock(&p->mutex);
> +        multifd_clear_pages(&p->pages);
>      }
>  }
>  
> @@ -658,6 +665,7 @@ int multifd_load_cleanup(Error **errp)
>      }
>      g_free(multifd_recv_state->params);
>      multifd_recv_state->params = NULL;
> +    multifd_clear_pages(&multifd_recv_state->pages);
>      g_free(multifd_recv_state);
>      multifd_recv_state = NULL;
>  
> @@ -668,12 +676,20 @@ static void *multifd_recv_thread(void *opaque)
>  {
>      MultiFDRecvParams *p = opaque;
>  
> +    qemu_sem_post(&p->ready);
>      while (true) {
>          qemu_mutex_lock(&p->mutex);
>          if (p->quit) {
>              qemu_mutex_unlock(&p->mutex);
>              break;
>          }
> +        if (p->pages.num) {
> +            p->pages.num = 0;

This could do with some TODO comments in - since this code
doesn't do anything useful yet and is confusing, but gets clearer
when you add the filling in the later patches.

Dave

> +            p->done = true;
> +            qemu_mutex_unlock(&p->mutex);
> +            qemu_sem_post(&p->ready);
> +            continue;
> +        }
>          qemu_mutex_unlock(&p->mutex);
>          qemu_sem_wait(&p->sem);
>      }
> @@ -714,13 +730,21 @@ void multifd_new_channel(QIOChannel *ioc)
>      }
>      qemu_mutex_init(&p->mutex);
>      qemu_sem_init(&p->sem, 0);
> +    qemu_sem_init(&p->ready, 0);
>      p->quit = false;
>      p->id = msg.id;
> +    p->done = false;
> +    multifd_init_pages(&p->pages);
>      p->c = ioc;
>      multifd_recv_state->count++;
>      p->name = g_strdup_printf("multifdrecv_%d", msg.id);
> +    object_ref(OBJECT(ioc));

It would be good to comment to say where that gets unref'd.

Dave

> +
>      qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
>                         QEMU_THREAD_JOINABLE);
> +    if (multifd_recv_state->count == migrate_multifd_channels()) {
> +        migration_incoming_process();
> +    }
>  }
>  
>  int multifd_load_setup(void)
> @@ -735,6 +759,7 @@ int multifd_load_setup(void)
>      multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
>      multifd_recv_state->count = 0;
>      multifd_recv_state->quit = false;
> +    multifd_init_pages(&multifd_recv_state->pages);
>      return 0;
>  }
>  
> @@ -743,6 +768,36 @@ int multifd_created_channels(void)
>      return multifd_recv_state->count;
>  }
>  
> +static void multifd_recv_page(uint8_t *address, uint16_t fd_num)
> +{
> +    int thread_count;
> +    MultiFDRecvParams *p;
> +    multifd_pages_t *pages = &multifd_recv_state->pages;
> +
> +    pages->iov[pages->num].iov_base = address;
> +    pages->iov[pages->num].iov_len = TARGET_PAGE_SIZE;
> +    pages->num++;
> +
> +    if (fd_num == MULTIFD_CONTINUE) {
> +        return;
> +    }
> +
> +    thread_count = migrate_multifd_channels();
> +    assert(fd_num < thread_count);
> +    p = &multifd_recv_state->params[fd_num];
> +
> +    qemu_sem_wait(&p->ready);
> +
> +    qemu_mutex_lock(&p->mutex);
> +    p->done = false;
> +    iov_copy(p->pages.iov, pages->num, pages->iov, pages->num, 0,
> +             iov_size(pages->iov, pages->num));
> +    p->pages.num = pages->num;
> +    pages->num = 0;
> +    qemu_mutex_unlock(&p->mutex);
> +    qemu_sem_post(&p->sem);
> +}
> +
>  /**
>   * save_page_header: write page header to wire
>   *
> @@ -3060,10 +3115,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>  
>          case RAM_SAVE_FLAG_MULTIFD_PAGE:
>              fd_num = qemu_get_be16(f);
> -            if (fd_num != 0) {
> -                /* this is yet an unused variable, changed later */
> -                fd_num = fd_num;
> -            }
> +            multifd_recv_page(host, fd_num);
>              qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
>              break;
>  
> diff --git a/migration/socket.c b/migration/socket.c
> index 22fb05edc8..debe972ee8 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -186,6 +186,9 @@ out:
>      if (migration_has_all_channels()) {
>          /* Close listening socket as its no longer needed */
>          qio_channel_close(ioc, NULL);
> +        if (!migrate_use_multifd()) {
> +            migration_incoming_process();
> +        }
>          return G_SOURCE_REMOVE;
>      } else {
>          return G_SOURCE_CONTINUE;
> -- 
> 2.13.5
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
