Received: from eggs.gnu.org ([2001:4830:134:3::10]:38446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dY8iU-0003Yt-Fh
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 06:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dY8iP-0004mF-Is
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 06:29:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dY8iP-0004kn-9U
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 06:29:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E4E3FC058EDE
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 10:29:51 +0000 (UTC)
Date: Thu, 20 Jul 2017 11:29:46 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170720102945.GC2101@work-vm>
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-14-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170717134238.1966-14-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 13/17] migration: Create thread
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
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, berrange@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> We make the locking and the transfer of information specific, even if we
> are still receiving things through the main thread.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 60 insertions(+), 8 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index ac0742f..49c4880 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -49,6 +49,7 @@
>  #include "migration/colo.h"
>  #include "sysemu/sysemu.h"
>  #include "qemu/uuid.h"
> +#include "qemu/iov.h"
>  
>  /***********************************************************/
>  /* ram save/restore */
> @@ -527,7 +528,7 @@ int multifd_save_setup(void)
>      return 0;
>  }
>  
> -static int multifd_send_page(uint8_t *address)
> +static uint16_t multifd_send_page(uint8_t *address, bool last_page)
>  {
>      int i, j;
>      MultiFDSendParams *p = NULL; /* make happy gcc */
> @@ -543,8 +544,10 @@ static int multifd_send_page(uint8_t *address)
>      pages.iov[pages.num].iov_len = TARGET_PAGE_SIZE;
>      pages.num++;
>  
> -    if (pages.num < (pages.size - 1)) {
> -        return UINT16_MAX;
> +    if (!last_page) {
> +        if (pages.num < (pages.size - 1)) {
> +            return UINT16_MAX;
> +        }
>      }

This doesn't feel like it should be in a recv patch.

>      qemu_sem_wait(&multifd_send_state->sem);
> @@ -572,12 +575,17 @@ static int multifd_send_page(uint8_t *address)
>  }
>  
>  struct MultiFDRecvParams {
> +    /* not changed */
>      uint8_t id;
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

The params between Send and Recv keep looking very similar; I wonder
if we can share them.

> @@ -629,12 +637,20 @@ static void *multifd_recv_thread(void *opaque)
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
> +            p->done = true;
> +            qemu_mutex_unlock(&p->mutex);
> +            qemu_sem_post(&p->ready);
> +            continue;
> +        }
>          qemu_mutex_unlock(&p->mutex);
>          qemu_sem_wait(&p->sem);
>      }
> @@ -679,8 +695,11 @@ gboolean multifd_new_channel(QIOChannel *ioc)
>      }
>      qemu_mutex_init(&p->mutex);
>      qemu_sem_init(&p->sem, 0);
> +    qemu_sem_init(&p->ready, 0);
>      p->quit = false;
>      p->id = id;
> +    p->done = false;
> +    multifd_init_group(&p->pages);
>      p->c = ioc;
>      atomic_set(&multifd_recv_state->params[id], p);
>      qemu_thread_create(&p->thread, "multifd_recv", multifd_recv_thread, p,
> @@ -709,6 +728,42 @@ int multifd_load_setup(void)
>      return 0;
>  }
>  
> +static void multifd_recv_page(uint8_t *address, uint16_t fd_num)
> +{
> +    int thread_count;
> +    MultiFDRecvParams *p;
> +    static multifd_pages_t pages;
> +    static bool once;
> +
> +    if (!once) {
> +        multifd_init_group(&pages);
> +        once = true;
> +    }
> +
> +    pages.iov[pages.num].iov_base = address;
> +    pages.iov[pages.num].iov_len = TARGET_PAGE_SIZE;
> +    pages.num++;
> +
> +    if (fd_num == UINT16_MAX) {
> +        return;
> +    }
> +
> +    thread_count = migrate_multifd_threads();
> +    assert(fd_num < thread_count);
> +    p = multifd_recv_state->params[fd_num];
> +
> +    qemu_sem_wait(&p->ready);
> +
> +    qemu_mutex_lock(&p->mutex);
> +    p->done = false;
> +    iov_copy(p->pages.iov, pages.num, pages.iov, pages.num, 0,
> +             iov_size(pages.iov, pages.num));
> +    p->pages.num = pages.num;
> +    pages.num = 0;
> +    qemu_mutex_unlock(&p->mutex);
> +    qemu_sem_post(&p->sem);
> +}
> +
>  /**
>   * save_page_header: write page header to wire
>   *
> @@ -1155,7 +1210,7 @@ static int ram_multifd_page(RAMState *rs, PageSearchStatus *pss,
>          ram_counters.transferred +=
>              save_page_header(rs, rs->f, block,
>                               offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
> -        fd_num = multifd_send_page(p);
> +        fd_num = multifd_send_page(p, rs->migration_dirty_pages == 1);

I think that belongs in the previous patch and probably answers one of
my questions.

>          qemu_put_be16(rs->f, fd_num);
>          ram_counters.transferred += 2; /* size of fd_num */
>          qemu_put_buffer(rs->f, p, TARGET_PAGE_SIZE);
> @@ -3020,10 +3075,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
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
> -- 
> 2.9.4
> 

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
