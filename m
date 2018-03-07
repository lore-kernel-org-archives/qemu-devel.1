Received: from eggs.gnu.org ([2001:4830:134:3::10]:47140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etXw1-0008HE-8R
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:12:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etXvx-0002Xu-Uz
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:12:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45828 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1etXvx-0002Xi-Ou
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:12:37 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D6F7C40252F0
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 12:12:33 +0000 (UTC)
Date: Wed, 7 Mar 2018 12:12:27 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180307121227.GT20201@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180307110010.2205-1-quintela@redhat.com>
	<20180307110010.2205-23-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180307110010.2205-23-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v10 22/24] migration: Create
 ram_multifd_page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On Wed, Mar 07, 2018 at 12:00:08PM +0100, Juan Quintela wrote:
> The function still don't use multifd, but we have simplified
> ram_save_page, xbzrle and RDMA stuff is gone.  We have added a new
> counter.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> --
> Add last_page parameter
> Add commets for done and address
> Remove multifd field, it is the same than normal pages
> Merge next patch, now we send multiple pages at a time
> Remove counter for multifd pages, it is identical to normal pages
> Use iovec's instead of creating the equivalent.
> Clear memory used by pages (dave)
> Use g_new0(danp)
> define MULTIFD_CONTINUE
> now pages member is a pointer
> Fix off-by-one in number of pages in one packet
> Remove RAM_SAVE_FLAG_MULTIFD_PAGE
> ---
>  migration/ram.c        | 144 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  migration/trace-events |   3 +-
>  2 files changed, 144 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 4efac0c20c..df9646ed2e 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -54,6 +54,7 @@
>  #include "migration/block.h"
>  #include "sysemu/sysemu.h"
>  #include "qemu/uuid.h"
> +#include "qemu/iov.h"
>  
>  /***********************************************************/
>  /* ram save/restore */
> @@ -397,7 +398,19 @@ static void compress_threads_save_setup(void)
>  
>  /* Multiple fd's */
>  
> +typedef struct {
> +    /* number of used pages */
> +    uint32_t used;
> +    /* number of allocated pages */
> +    uint32_t allocated;
> +    /* global number of generated multifd packets */
> +    uint32_t seq;
> +    struct iovec *iov;
> +    RAMBlock *block;
> +} multifd_pages_t;
> +
>  struct MultiFDSendParams {
> +    /* not changed */
>      uint8_t id;
>      char *name;
>      QemuThread thread;
> @@ -405,8 +418,15 @@ struct MultiFDSendParams {
>      QemuSemaphore sem;
>      QemuMutex mutex;
>      bool running;
> +    /* protected by param mutex */
>      bool quit;
>      bool sync;
> +    multifd_pages_t *pages;
> +    /* how many patches has sent this channel */
> +    uint32_t packets_sent;
> +    /* protected by multifd mutex */
> +    /* has the thread finish the last submitted job */
> +    bool done;
>  };
>  typedef struct MultiFDSendParams MultiFDSendParams;
>  
> @@ -416,8 +436,31 @@ struct {
>      int count;
>      /* syncs main thread and channels */
>      QemuSemaphore sem_main;
> +    QemuMutex mutex;
> +    QemuSemaphore sem;
> +    multifd_pages_t *pages;
>  } *multifd_send_state;
>  
> +static void multifd_pages_init(multifd_pages_t **ppages, size_t size)
> +{
> +    multifd_pages_t *pages = g_new0(multifd_pages_t, 1);
> +
> +    pages->allocated = size;
> +    pages->iov = g_new0(struct iovec, size);
> +    *ppages = pages;
> +}
> +
> +static void multifd_pages_clear(multifd_pages_t *pages)
> +{
> +    pages->used = 0;
> +    pages->allocated = 0;
> +    pages->seq = 0;
> +    pages->block = NULL;
> +    g_free(pages->iov);
> +    pages->iov = NULL;
> +    g_free(pages);
> +}
> +
>  static void terminate_multifd_send_threads(Error *errp)
>  {
>      int i;
> @@ -464,10 +507,14 @@ int multifd_save_cleanup(Error **errp)
>          qemu_sem_destroy(&p->sem);
>          g_free(p->name);
>          p->name = NULL;
> +        multifd_pages_clear(p->pages);
> +        p->pages = NULL;
>      }
>      qemu_sem_destroy(&multifd_send_state->sem_main);
>      g_free(multifd_send_state->params);
>      multifd_send_state->params = NULL;
> +    multifd_pages_clear(multifd_send_state->pages);
> +    multifd_send_state->pages = NULL;
>      g_free(multifd_send_state);
>      multifd_send_state = NULL;
>      return ret;
> @@ -516,6 +563,7 @@ static void *multifd_send_thread(void *opaque)
>          terminate_multifd_send_threads(local_err);
>          return NULL;
>      }
> +    qemu_sem_post(&multifd_send_state->sem);
>  
>      while (true) {
>          qemu_sem_wait(&p->sem);
> @@ -530,9 +578,23 @@ static void *multifd_send_thread(void *opaque)
>              qemu_mutex_unlock(&p->mutex);
>              break;
>          }
> +        if (p->pages->used) {
> +            p->pages->used = 0;
> +            qemu_mutex_unlock(&p->mutex);
> +
> +            trace_multifd_send(p->id, p->pages->seq, p->pages->used);
> +            /* ToDo: send page here */
> +
> +            qemu_mutex_lock(&multifd_send_state->mutex);
> +            p->done = true;
> +            p->packets_sent++;
> +            qemu_mutex_unlock(&multifd_send_state->mutex);
> +            qemu_sem_post(&multifd_send_state->sem);
> +            continue;
> +        }
>          qemu_mutex_unlock(&p->mutex);
>      }
> -    trace_multifd_send_thread_end(p->id);
> +    trace_multifd_send_thread_end(p->id, p->packets_sent);
>  
>      return NULL;
>  }
> @@ -571,7 +633,10 @@ int multifd_save_setup(void)
>      multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
>      atomic_set(&multifd_send_state->count, 0);
>      qemu_sem_init(&multifd_send_state->sem_main, 0);
> -
> +    qemu_mutex_init(&multifd_send_state->mutex);
> +    qemu_sem_init(&multifd_send_state->sem, 0);
> +    multifd_pages_init(&multifd_send_state->pages,
> +                       migrate_multifd_page_count());
>      for (i = 0; i < thread_count; i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>  
> @@ -579,6 +644,8 @@ int multifd_save_setup(void)
>          qemu_sem_init(&p->sem, 0);
>          p->quit = false;
>          p->id = i;
> +        p->done = true;
> +        multifd_pages_init(&p->pages, migrate_multifd_page_count());
>          p->name = g_strdup_printf("multifdsend_%d", i);
>          socket_send_channel_create(multifd_new_send_channel_async, p);
>      }
> @@ -586,6 +653,50 @@ int multifd_save_setup(void)
>      return 0;
>  }
>  
> +static void multifd_send_page(RAMBlock *block, ram_addr_t offset,
> +                                  bool last_page)
> +{
> +    int i;
> +    static int next_channel = 0;
> +    MultiFDSendParams *p = NULL; /* make happy gcc */
> +    multifd_pages_t *pages = multifd_send_state->pages;
> +
> +    if (!pages->block) {
> +        pages->block = block;
> +    }
> +
> +    pages->iov[pages->used].iov_base = block->host + offset;
> +    pages->iov[pages->used].iov_len = TARGET_PAGE_SIZE;
> +    pages->used++;
> +
> +    if (!last_page) {
> +        if (pages->used < pages->allocated) {
> +            return;
> +        }
> +    }
> +
> +    qemu_sem_wait(&multifd_send_state->sem);
> +    qemu_mutex_lock(&multifd_send_state->mutex);
> +    for (i = next_channel;; i = (i + 1) % migrate_multifd_channels() ) {
> +        p = &multifd_send_state->params[i];
> +
> +        if (p->done) {
> +            p->done = false;
> +            next_channel = (i + 1) % migrate_multifd_channels();
> +            break;
> +        }
> +    }
> +    qemu_mutex_unlock(&multifd_send_state->mutex);
> +    qemu_mutex_lock(&p->mutex);
> +    p->pages->used = 0;
> +    p->pages->seq = pages->seq + 1;
> +    p->pages->block = NULL;
> +    multifd_send_state->pages = p->pages;
> +    p->pages = pages;
> +    qemu_mutex_unlock(&p->mutex);
> +    qemu_sem_post(&p->sem);
> +}
> +
>  struct MultiFDRecvParams {
>      uint8_t id;
>      char *name;
> @@ -1220,6 +1331,31 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
>      return pages;
>  }
>  
> +static int ram_multifd_page(RAMState *rs, PageSearchStatus *pss,
> +                            bool last_stage)
> +{
> +    int pages;
> +    uint8_t *p;
> +    RAMBlock *block = pss->block;
> +    ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
> +
> +    p = block->host + offset;
> +
> +    pages = save_zero_page(rs, block, offset);
> +    if (pages == -1) {
> +        ram_counters.transferred +=
> +            save_page_header(rs, rs->f, block,
> +                             offset | RAM_SAVE_FLAG_PAGE);
> +        multifd_send_page(block, offset, rs->migration_dirty_pages == 1);
> +        qemu_put_buffer(rs->f, p, TARGET_PAGE_SIZE);
> +        ram_counters.transferred += TARGET_PAGE_SIZE;
> +        pages = 1;
> +        ram_counters.normal++;
> +    }
> +
> +    return pages;
> +}
> +
>  static int do_compress_ram_page(QEMUFile *f, RAMBlock *block,
>                                  ram_addr_t offset)
>  {
> @@ -1648,6 +1784,8 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
>          if (migrate_use_compression() &&
>              (rs->ram_bulk_stage || !migrate_use_xbzrle())) {
>              res = ram_save_compressed_page(rs, pss, last_stage);
> +        } else if (migrate_use_multifd()) {
> +            res = ram_multifd_page(rs, pss, last_stage);
>          } else {
>              res = ram_save_page(rs, pss, last_stage);
>          }
> @@ -3047,6 +3185,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>      if (!migrate_use_compression()) {
>          invalid_flags |= RAM_SAVE_FLAG_COMPRESS_PAGE;
>      }
> +
>      /* This RCU critical section can be very long running.
>       * When RCU reclaims in the code start to become numerous,
>       * it will be necessary to reduce the granularity of this
> @@ -3166,6 +3305,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>                  break;
>              }
>              break;
> +
>          case RAM_SAVE_FLAG_EOS:
>              /* normal exit */
>              multifd_recv_sync_main();
> diff --git a/migration/trace-events b/migration/trace-events
> index db88fa699f..f6ab2c7bcb 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -80,9 +80,10 @@ ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: 0
>  multifd_send_sync_main(void) ""
>  multifd_recv_sync_main(void) ""
>  multifd_send_thread_start(int id) "%d"
> -multifd_send_thread_end(int id) "%d"
> +multifd_send_thread_end(char id, uint32_t packets) "channel %d packets %d"
>  multifd_recv_thread_start(int id) "%d"
>  multifd_recv_thread_end(int id) "%d"
> +multifd_send(char id, int seq, int num) "channel %d sequence %d num pages %d"

Drop this, and just set 'id' to be 'uint8_t' in the earlier patches

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
