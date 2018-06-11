Received: from eggs.gnu.org ([2001:4830:134:3::10]:58392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSQh6-0003ug-44
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSQh3-0004rk-G7
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:33:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42816 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fSQh3-0004rR-AK
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:33:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BDB9CBD9E
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 17:33:24 +0000 (UTC)
Date: Mon, 11 Jun 2018 18:33:21 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180611173321.GL2661@work-vm>
References: <20180523111817.1463-1-quintela@redhat.com>
	<20180523111817.1463-9-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523111817.1463-9-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v13 08/12] migration: Create
 ram_save_multifd_page
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
> s/multifd_pages_t/MultiFDPages_t/
> ---
>  migration/ram.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 3e99d48123..28f5cea4d8 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -55,6 +55,7 @@
>  #include "sysemu/sysemu.h"
>  #include "qemu/uuid.h"
>  #include "savevm.h"
> +#include "qemu/iov.h"
>  
>  /***********************************************************/
>  /* ram save/restore */
> @@ -804,8 +805,65 @@ struct {
>      QemuSemaphore sem_sync;
>      /* global number of generated multifd packets */
>      uint32_t seq;
> +    /* send channels ready */
> +    QemuSemaphore channels_ready;
>  } *multifd_send_state;
>  
> +static void multifd_send_pages(void)
> +{
> +    int i;
> +    static int next_channel;
> +    MultiFDSendParams *p = NULL; /* make happy gcc */
> +    MultiFDPages_t *pages = multifd_send_state->pages;
> +
> +    qemu_sem_wait(&multifd_send_state->channels_ready);
> +    for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
> +        p = &multifd_send_state->params[i];
> +
> +        qemu_mutex_lock(&p->mutex);
> +        if (!p->pending_job) {
> +            p->pending_job++;
> +            next_channel = (i + 1) % migrate_multifd_channels();
> +            break;
> +        }
> +        qemu_mutex_unlock(&p->mutex);
> +    }
> +    p->pages->used = 0;
> +    multifd_send_state->seq++;
> +    p->seq = multifd_send_state->seq;
> +    p->pages->block = NULL;
> +    multifd_send_state->pages = p->pages;
> +    p->pages = pages;

This function *really* needs a fat comment about the flow of ->pages
because it's pretty hard to follow.

Other than that;


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> +    qemu_mutex_unlock(&p->mutex);
> +    qemu_sem_post(&p->sem);
> +}
> +
> +static void multifd_queue_page(RAMBlock *block, ram_addr_t offset)
> +{
> +    MultiFDPages_t *pages = multifd_send_state->pages;
> +
> +    if (!pages->block) {
> +        pages->block = block;
> +    }
> +
> +    if (pages->block == block) {
> +        pages->offset[pages->used] = offset;
> +        pages->iov[pages->used].iov_base = block->host + offset;
> +        pages->iov[pages->used].iov_len = TARGET_PAGE_SIZE;
> +        pages->used++;
> +
> +        if (pages->used < pages->allocated) {
> +            return;
> +        }
> +    }
> +
> +    multifd_send_pages();
> +
> +    if (pages->block != block) {
> +        multifd_queue_page(block, offset);
> +    }
> +}
> +
>  static void multifd_send_terminate_threads(Error *err)
>  {
>      int i;
> @@ -860,6 +918,7 @@ int multifd_save_cleanup(Error **errp)
>          g_free(p->packet);
>          p->packet = NULL;
>      }
> +    qemu_sem_destroy(&multifd_send_state->channels_ready);
>      qemu_sem_destroy(&multifd_send_state->sem_sync);
>      g_free(multifd_send_state->params);
>      multifd_send_state->params = NULL;
> @@ -877,12 +936,17 @@ static void multifd_send_sync_main(void)
>      if (!migrate_use_multifd()) {
>          return;
>      }
> +    if (multifd_send_state->pages->used) {
> +        multifd_send_pages();
> +    }
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>  
>          trace_multifd_send_sync_main_signal(p->id);
>  
>          qemu_mutex_lock(&p->mutex);
> +        multifd_send_state->seq++;
> +        p->seq = multifd_send_state->seq;
>          p->flags |= MULTIFD_FLAG_SYNC;
>          p->pending_job++;
>          qemu_mutex_unlock(&p->mutex);
> @@ -937,6 +1001,7 @@ static void *multifd_send_thread(void *opaque)
>              if (flags & MULTIFD_FLAG_SYNC) {
>                  qemu_sem_post(&multifd_send_state->sem_sync);
>              }
> +            qemu_sem_post(&multifd_send_state->channels_ready);
>          } else if (p->quit) {
>              qemu_mutex_unlock(&p->mutex);
>              break;
> @@ -996,6 +1061,7 @@ int multifd_save_setup(void)
>      atomic_set(&multifd_send_state->count, 0);
>      multifd_send_state->pages = multifd_pages_init(page_count);
>      qemu_sem_init(&multifd_send_state->sem_sync, 0);
> +    qemu_sem_init(&multifd_send_state->channels_ready, 0);
>  
>      for (i = 0; i < thread_count; i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
> @@ -1713,6 +1779,23 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
>      return pages;
>  }
>  
> +static int ram_save_multifd_page(RAMState *rs, RAMBlock *block,
> +                                 ram_addr_t offset)
> +{
> +    uint8_t *p;
> +
> +    p = block->host + offset;
> +
> +    ram_counters.transferred += save_page_header(rs, rs->f, block,
> +                                                 offset | RAM_SAVE_FLAG_PAGE);
> +    multifd_queue_page(block, offset);
> +    qemu_put_buffer(rs->f, p, TARGET_PAGE_SIZE);
> +    ram_counters.transferred += TARGET_PAGE_SIZE;
> +    ram_counters.normal++;
> +
> +    return 1;
> +}
> +
>  static int do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
>                                  ram_addr_t offset, uint8_t *source_buf)
>  {
> @@ -2116,6 +2199,8 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
>       */
>      if (block == rs->last_sent_block && save_page_use_compression(rs)) {
>          return compress_page_with_multi_thread(rs, block, offset);
> +    } else if (migrate_use_multifd()) {
> +        return ram_save_multifd_page(rs, block, offset);
>      }
>  
>      return ram_save_page(rs, pss, last_stage);
> -- 
> 2.17.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
