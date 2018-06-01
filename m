Received: from eggs.gnu.org ([2001:4830:134:3::10]:56861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fObFO-000436-Lm
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 00:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fObFK-0003ph-Ol
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 00:01:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59890 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fObFK-0003on-Ig
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 00:00:58 -0400
Date: Fri, 1 Jun 2018 12:00:49 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180601040049.GG14867@xz-mi>
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
	<1524550428-27173-4-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1524550428-27173-4-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v7 3/5] migration: API to clear bits of
 guest free pages from the dirty bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, pbonzini@redhat.com, nilal@redhat.com

On Tue, Apr 24, 2018 at 02:13:46PM +0800, Wei Wang wrote:
> This patch adds an API to clear bits corresponding to guest free pages
> from the dirty bitmap. Spilt the free page block if it crosses the QEMU
> RAMBlock boundary.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Juan Quintela <quintela@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/migration/misc.h |  2 ++
>  migration/ram.c          | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 4ebf24c..113320e 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -14,11 +14,13 @@
>  #ifndef MIGRATION_MISC_H
>  #define MIGRATION_MISC_H
>  
> +#include "exec/cpu-common.h"
>  #include "qemu/notify.h"
>  
>  /* migration/ram.c */
>  
>  void ram_mig_init(void);
> +void qemu_guest_free_page_hint(void *addr, size_t len);
>  
>  /* migration/block.c */
>  
> diff --git a/migration/ram.c b/migration/ram.c
> index 9a72b1a..0147548 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2198,6 +2198,50 @@ static int ram_init_all(RAMState **rsp)
>  }
>  
>  /*
> + * This function clears bits of the free pages reported by the caller from the
> + * migration dirty bitmap. @addr is the host address corresponding to the
> + * start of the continuous guest free pages, and @len is the total bytes of
> + * those pages.
> + */
> +void qemu_guest_free_page_hint(void *addr, size_t len)
> +{
> +    RAMBlock *block;
> +    ram_addr_t offset;
> +    size_t used_len, start, npages;

Do we need to check here on whether a migration is in progress?  Since
if not I'm not sure whether this hint still makes any sense any more,
and more importantly it seems to me that block->bmap below at [1] is
only valid during a migration.  So I'm not sure whether QEMU will
crash if this function is called without a running migration.

> +
> +    for (; len > 0; len -= used_len) {
> +        block = qemu_ram_block_from_host(addr, false, &offset);
> +        if (unlikely(!block)) {
> +            return;

We should never reach here, should we?  Assuming the callers of this
function should always pass in a correct host address. If we are very
sure that the host addr should be valid, could we just assert?

> +        }
> +
> +        /*
> +         * This handles the case that the RAMBlock is resized after the free
> +         * page hint is reported.
> +         */
> +        if (unlikely(offset > block->used_length)) {
> +            return;
> +        }
> +
> +        if (len <= block->used_length - offset) {
> +            used_len = len;
> +        } else {
> +            used_len = block->used_length - offset;
> +            addr += used_len;
> +        }
> +
> +        start = offset >> TARGET_PAGE_BITS;
> +        npages = used_len >> TARGET_PAGE_BITS;
> +
> +        qemu_mutex_lock(&ram_state->bitmap_mutex);

So now I think I understand the lock can still be meaningful since
this function now can be called outside the migration thread (e.g., in
vcpu thread).  But still it would be nice to mention it somewhere on
the truth of the lock.

Regards,

> +        ram_state->migration_dirty_pages -=
> +                      bitmap_count_one_with_offset(block->bmap, start, npages);
> +        bitmap_clear(block->bmap, start, npages);

[1]

> +        qemu_mutex_unlock(&ram_state->bitmap_mutex);
> +    }
> +}
> +
> +/*
>   * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
>   * long-running RCU critical section.  When rcu-reclaims in the code
>   * start to become numerous it will be necessary to reduce the
> -- 
> 1.8.3.1
> 
> 

-- 
Peter Xu
