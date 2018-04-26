Received: from eggs.gnu.org ([2001:4830:134:3::10]:51569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBbYq-0000Nn-SS
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 03:43:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBbYn-0003UP-Oc
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 03:43:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32814 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fBbYn-0003Tr-IY
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 03:43:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 00B1342709F0
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 07:43:20 +0000 (UTC)
Date: Thu, 26 Apr 2018 15:43:10 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180426074310.GS9036@xz-mi>
References: <20180425112723.1111-1-quintela@redhat.com>
	<20180425112723.1111-18-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180425112723.1111-18-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v12 17/21] migration: Create
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

On Wed, Apr 25, 2018 at 01:27:19PM +0200, Juan Quintela wrote:

[...]

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

Nits: could we avoid the recursive call here?  E.g.:

multifd_queue_page()
{
  /* flush pages if necessary */
  if (pages->block && (pages->block != block ||
                       pages->used >= pages->allocated))
    multifd_send_pages();

  if (!pages->block)
    pages->block = block;

  pages->offset[pages->used] = ...
  pages->iov[pages->used].iov_base = ...
  pages->iov[pages->used].iov_len = ...
  pages->used++;
}

> +    }
> +}
> +
>  static void multifd_send_terminate_threads(Error *err)
>  {
>      int i;
> @@ -746,6 +804,7 @@ int multifd_save_cleanup(Error **errp)
>          g_free(p->packet);
>          p->packet = NULL;
>      }
> +    qemu_sem_destroy(&multifd_send_state->channels_ready);
>      qemu_sem_destroy(&multifd_send_state->sem_sync);
>      g_free(multifd_send_state->params);
>      multifd_send_state->params = NULL;
> @@ -763,12 +822,17 @@ static void multifd_send_sync_main(void)
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
> @@ -824,6 +888,7 @@ static void *multifd_send_thread(void *opaque)
>              if (flags & MULTIFD_FLAG_SYNC) {
>                  qemu_sem_post(&multifd_send_state->sem_sync);
>              }
> +            qemu_sem_post(&multifd_send_state->channels_ready);
>          } else if (p->quit) {
>              qemu_mutex_unlock(&p->mutex);
>              break;
> @@ -883,6 +948,7 @@ int multifd_save_setup(void)
>      atomic_set(&multifd_send_state->count, 0);
>      multifd_pages_init(&multifd_send_state->pages, page_count);
>      qemu_sem_init(&multifd_send_state->sem_sync, 0);
> +    qemu_sem_init(&multifd_send_state->channels_ready, 0);
>  
>      for (i = 0; i < thread_count; i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
> @@ -1576,6 +1642,31 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
>      return pages;
>  }
>  
> +static int ram_multifd_page(RAMState *rs, PageSearchStatus *pss,
> +                            bool last_stage)
> +{

Maybe name it as ram_send_multifd_page()? :)

So that it can be aligned with the rest like ram_save_page() and
ram_save_compressed_page().

> +    int pages;
> +    uint8_t *p;
> +    RAMBlock *block = pss->block;
> +    ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
> +
> +    p = block->host + offset;
> +
> +    pages = save_zero_page(rs, block, offset);

I suspect the series will need to rebase to Dave's next pull request
(or after its merging) since Guangrong's work should have refactored
this part in the coming pull request...

Thanks,

> +    if (pages == -1) {
> +        ram_counters.transferred +=
> +            save_page_header(rs, rs->f, block,
> +                             offset | RAM_SAVE_FLAG_PAGE);
> +        multifd_queue_page(block, offset);
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
> @@ -2004,6 +2095,8 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
>          if (migrate_use_compression() &&
>              (rs->ram_bulk_stage || !migrate_use_xbzrle())) {
>              res = ram_save_compressed_page(rs, pss, last_stage);
> +        } else if (migrate_use_multifd()) {
> +            res = ram_multifd_page(rs, pss, last_stage);
>          } else {
>              res = ram_save_page(rs, pss, last_stage);
>          }
> -- 
> 2.17.0
> 

-- 
Peter Xu
