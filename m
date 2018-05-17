Received: from eggs.gnu.org ([2001:4830:134:3::10]:41273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJFUI-0000E0-Dd
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJFUE-00075o-Ba
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:46:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57182 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fJFUE-00075a-6U
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:46:14 -0400
Date: Thu, 17 May 2018 17:46:04 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180517094604.GA26089@xz-mi>
References: <20180517085927.24925-1-peterx@redhat.com>
	<20180517085927.24925-10-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180517085927.24925-10-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 09/12] intel-iommu: maintain per-device
 iova ranges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Tian Kevin <kevin.tian@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, Jason Wang <jasowang@redhat.com>

On Thu, May 17, 2018 at 04:59:24PM +0800, Peter Xu wrote:

[...]

> +    /* Update local IOVA mapped ranges */
> +    if (entry->perm) {
> +        if (mapped) {
> +            /* If it's exactly the same translation, skip */
> +            if (!memcmp(mapped, &target, sizeof(target))) {
> +                trace_vtd_page_walk_one_skip_map(entry->iova, entry->addr_mask,
> +                                                 entry->translated_addr);
> +                return 0;
> +            } else {
> +                /*
> +                 * Translation changed.  This should not happen with
> +                 * "intel_iommu=on,strict", but it can happen when
> +                 * delayed flushing is used in guest IOMMU driver
> +                 * (when without "strict") when page A is reused
> +                 * before its previous unmap (the unmap can still be
> +                 * queued in the delayed flushing queue).  Now we do

This comment is wrong.  We can ignore above comments for now since as
I explained in the other thread Linux IOVA deferred flushing won't
free IOVA range until the unmap is flushed.  But still, below comment
is valid.

Regards,

> +                 * our best to remap.  Note that there will be a small
> +                 * window that we don't have map at all.  But that's
> +                 * the best effort we can do, and logically
> +                 * well-behaved guests should not really using this
> +                 * DMA region yet so we should be very safe.
> +                 */
> +                IOMMUAccessFlags cache_perm = entry->perm;
> +                int ret;
> +
> +                /* Emulate an UNMAP */
> +                entry->perm = IOMMU_NONE;
> +                trace_vtd_page_walk_one(info->domain_id,
> +                                        entry->iova,
> +                                        entry->translated_addr,
> +                                        entry->addr_mask,
> +                                        entry->perm);
> +                ret = hook_fn(entry, private);
> +                if (ret) {
> +                    return ret;
> +                }
> +                /* Drop any existing mapping */
> +                iova_tree_remove(as->iova_tree, &target);
> +                /* Recover the correct permission */
> +                entry->perm = cache_perm;
> +            }
> +        }
> +        iova_tree_insert(as->iova_tree, &target);
> +    } else {
> +        if (!mapped) {
> +            /* Skip since we didn't map this range at all */
> +            trace_vtd_page_walk_one_skip_unmap(entry->iova, entry->addr_mask);
> +            return 0;
> +        }
> +        iova_tree_remove(as->iova_tree, &target);
> +    }
> +
>      trace_vtd_page_walk_one(info->domain_id, entry->iova,
>                              entry->translated_addr, entry->addr_mask,
>                              entry->perm);

-- 
Peter Xu
