Received: from eggs.gnu.org ([2001:4830:134:3::10]:33044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dXsAg-0006jX-R4
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:50:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dXsAd-0001ai-Na
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:49:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dXsAd-0001aJ-DQ
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:49:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E5A231D8C7
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 16:49:54 +0000 (UTC)
Date: Wed, 19 Jul 2017 17:49:45 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170719164945.GH3500@work-vm>
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-8-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170717134238.1966-8-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 07/17] migration: Create multifd
 migration threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, berrange@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> Creation of the threads, nothing inside yet.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> --
> 
> Use pointers instead of long array names
> Move to use semaphores instead of conditions as paolo suggestion
> 
> Put all the state inside one struct.
> Use a counter for the number of threads created.  Needed during cancellation.
> 
> Add error return to thread creation
> 
> Add id field
> 
> Rename functions to multifd_save/load_setup/cleanup
> ---
>  migration/migration.c |  14 ++++
>  migration/ram.c       | 192 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  migration/ram.h       |   5 ++
>  3 files changed, 211 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index ff3fc9d..5a82c1c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -288,6 +288,7 @@ static void process_incoming_migration_bh(void *opaque)
>      } else {
>          runstate_set(global_state_get_runstate());
>      }
> +    multifd_load_cleanup();
>      /*
>       * This must happen after any state changes since as soon as an external
>       * observer sees this event they might start to prod at the VM assuming
> @@ -348,6 +349,7 @@ static void process_incoming_migration_co(void *opaque)
>          migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>                            MIGRATION_STATUS_FAILED);
>          error_report("load of migration failed: %s", strerror(-ret));
> +        multifd_load_cleanup();
>          exit(EXIT_FAILURE);
>      }
>      mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
> @@ -358,6 +360,11 @@ void migration_fd_process_incoming(QEMUFile *f)
>  {
>      Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, f);
>  
> +    if (multifd_load_setup() != 0) {
> +        /* We haven't been able to create multifd threads
> +           nothing better to do */
> +        exit(EXIT_FAILURE);
> +    }
>      qemu_file_set_blocking(f, false);
>      qemu_coroutine_enter(co);
>  }
> @@ -860,6 +867,7 @@ static void migrate_fd_cleanup(void *opaque)
>          }
>          qemu_mutex_lock_iothread();
>  
> +        multifd_save_cleanup();
>          qemu_fclose(s->to_dst_file);
>          s->to_dst_file = NULL;
>      }
> @@ -2049,6 +2057,12 @@ void migrate_fd_connect(MigrationState *s)
>          }
>      }
>  
> +    if (multifd_save_setup() != 0) {
> +        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> +                          MIGRATION_STATUS_FAILED);
> +        migrate_fd_cleanup(s);
> +        return;
> +    }
>      qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
>                         QEMU_THREAD_JOINABLE);
>      s->migration_thread_running = true;
> diff --git a/migration/ram.c b/migration/ram.c
> index 1b08296..8e87533 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -356,6 +356,198 @@ static void compress_threads_save_setup(void)
>      }
>  }
>  
> +/* Multiple fd's */
> +
> +struct MultiFDSendParams {
> +    uint8_t id;
> +    QemuThread thread;
> +    QemuSemaphore sem;
> +    QemuMutex mutex;
> +    bool quit;
> +};
> +typedef struct MultiFDSendParams MultiFDSendParams;
> +
> +struct {
> +    MultiFDSendParams *params;
> +    /* number of created threads */
> +    int count;
> +} *multifd_send_state;
> +
> +static void terminate_multifd_send_threads(void)
> +{
> +    int i;
> +
> +    for (i = 0; i < multifd_send_state->count; i++) {
> +        MultiFDSendParams *p = &multifd_send_state->params[i];
> +
> +        qemu_mutex_lock(&p->mutex);
> +        p->quit = true;
> +        qemu_sem_post(&p->sem);
> +        qemu_mutex_unlock(&p->mutex);

I don't think you need that lock/unlock pair - as long as no one
else is currently going around setting them to false; so as long
as you know you're safely after initialisation and no one is trying
to start a new migration at the moment then I think it's safe.

> +    }
> +}
> +
> +void multifd_save_cleanup(void)
> +{
> +    int i;
> +
> +    if (!migrate_use_multifd()) {
> +        return;
> +    }
> +    terminate_multifd_send_threads();
> +    for (i = 0; i < multifd_send_state->count; i++) {
> +        MultiFDSendParams *p = &multifd_send_state->params[i];
> +
> +        qemu_thread_join(&p->thread);
> +        qemu_mutex_destroy(&p->mutex);
> +        qemu_sem_destroy(&p->sem);
> +    }
> +    g_free(multifd_send_state->params);
> +    multifd_send_state->params = NULL;
> +    g_free(multifd_send_state);
> +    multifd_send_state = NULL;

I'd be tempted to add a few traces around here, and also some
protection against it being called twice.  Maybe it shouldn't
happen, but it would be nice to debug it when it does.

> +}
> +
> +static void *multifd_send_thread(void *opaque)
> +{
> +    MultiFDSendParams *p = opaque;
> +
> +    while (true) {
> +        qemu_mutex_lock(&p->mutex);
> +        if (p->quit) {
> +            qemu_mutex_unlock(&p->mutex);
> +            break;
> +        }
> +        qemu_mutex_unlock(&p->mutex);
> +        qemu_sem_wait(&p->sem);

Similar to above, I don't think you need those
locks around the quit check.

> +    }
> +
> +    return NULL;
> +}
> +
> +int multifd_save_setup(void)
> +{
> +    int thread_count;
> +    uint8_t i;
> +
> +    if (!migrate_use_multifd()) {
> +        return 0;
> +    }
> +    thread_count = migrate_multifd_threads();
> +    multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
> +    multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
> +    multifd_send_state->count = 0;
> +    for (i = 0; i < thread_count; i++) {
> +        char thread_name[16];
> +        MultiFDSendParams *p = &multifd_send_state->params[i];
> +
> +        qemu_mutex_init(&p->mutex);
> +        qemu_sem_init(&p->sem, 0);
> +        p->quit = false;
> +        p->id = i;
> +        snprintf(thread_name, sizeof(thread_name), "multifdsend_%d", i);
> +        qemu_thread_create(&p->thread, thread_name, multifd_send_thread, p,
> +                           QEMU_THREAD_JOINABLE);
> +        multifd_send_state->count++;
> +    }
> +    return 0;
> +}
> +
> +struct MultiFDRecvParams {
> +    uint8_t id;
> +    QemuThread thread;
> +    QemuSemaphore sem;
> +    QemuMutex mutex;
> +    bool quit;
> +};
> +typedef struct MultiFDRecvParams MultiFDRecvParams;
> +
> +struct {
> +    MultiFDRecvParams *params;
> +    /* number of created threads */
> +    int count;
> +} *multifd_recv_state;
> +
> +static void terminate_multifd_recv_threads(void)
> +{
> +    int i;
> +
> +    for (i = 0; i < multifd_recv_state->count; i++) {
> +        MultiFDRecvParams *p = &multifd_recv_state->params[i];
> +
> +        qemu_mutex_lock(&p->mutex);
> +        p->quit = true;
> +        qemu_sem_post(&p->sem);
> +        qemu_mutex_unlock(&p->mutex);
> +    }
> +}
> +
> +void multifd_load_cleanup(void)
> +{
> +    int i;
> +
> +    if (!migrate_use_multifd()) {
> +        return;
> +    }
> +    terminate_multifd_recv_threads();
> +    for (i = 0; i < multifd_recv_state->count; i++) {
> +        MultiFDRecvParams *p = &multifd_recv_state->params[i];
> +
> +        qemu_thread_join(&p->thread);
> +        qemu_mutex_destroy(&p->mutex);
> +        qemu_sem_destroy(&p->sem);
> +    }
> +    g_free(multifd_recv_state->params);
> +    multifd_recv_state->params = NULL;
> +    g_free(multifd_recv_state);
> +    multifd_recv_state = NULL;
> +}
> +
> +static void *multifd_recv_thread(void *opaque)
> +{
> +    MultiFDRecvParams *p = opaque;
> +
> +    while (true) {
> +        qemu_mutex_lock(&p->mutex);
> +        if (p->quit) {
> +            qemu_mutex_unlock(&p->mutex);
> +            break;
> +        }
> +        qemu_mutex_unlock(&p->mutex);
> +        qemu_sem_wait(&p->sem);
> +    }
> +
> +    return NULL;
> +}
> +
> +int multifd_load_setup(void)
> +{
> +    int thread_count;
> +    uint8_t i;
> +
> +    if (!migrate_use_multifd()) {
> +        return 0;
> +    }
> +    thread_count = migrate_multifd_threads();
> +    multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
> +    multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
> +    multifd_recv_state->count = 0;
> +    for (i = 0; i < thread_count; i++) {
> +        char thread_name[16];
> +        MultiFDRecvParams *p = &multifd_recv_state->params[i];
> +
> +        qemu_mutex_init(&p->mutex);
> +        qemu_sem_init(&p->sem, 0);
> +        p->quit = false;
> +        p->id = i;
> +        snprintf(thread_name, sizeof(thread_name), "multifdrecv_%d", i);
> +        qemu_thread_create(&p->thread, thread_name, multifd_recv_thread, p,
> +                           QEMU_THREAD_JOINABLE);
> +        multifd_recv_state->count++;
> +    }
> +    return 0;
> +}
> +

(It's a shame there's no way to wrap this boiler plate up to share
between send/receive threads).

However, all the above is minor, so:


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>  /**
>   * save_page_header: write page header to wire
>   *
> diff --git a/migration/ram.h b/migration/ram.h
> index c081fde..93c2bb4 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -39,6 +39,11 @@ int64_t xbzrle_cache_resize(int64_t new_size);
>  uint64_t ram_bytes_remaining(void);
>  uint64_t ram_bytes_total(void);
>  
> +int multifd_save_setup(void);
> +void multifd_save_cleanup(void);
> +int multifd_load_setup(void);
> +void multifd_load_cleanup(void);
> +
>  uint64_t ram_pagesize_summary(void);
>  int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len);
>  void acct_update_position(QEMUFile *f, size_t size, bool zero);
> -- 
> 2.9.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
