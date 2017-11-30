Received: from eggs.gnu.org ([2001:4830:134:3::10]:35845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eKMFR-0003QS-QP
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 05:39:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eKMFM-0007KG-TN
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 05:39:17 -0500
Received: from www262.sakura.ne.jp ([2001:e42:101:1:202:181:97:72]:28325)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eKMFM-0007ID-1K
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 05:39:12 -0500
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>
	<1511963726-34070-8-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1511963726-34070-8-git-send-email-wei.w.wang@intel.com>
Message-Id: <201711301935.EHF86450.MSFLOOHFJtFOQV@I-love.SAKURA.ne.jp>
Date: Thu, 30 Nov 2017 19:35:55 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Qemu-devel] [PATCH v18 07/10] virtio-balloon:
 VIRTIO_BALLOON_F_SG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wei.w.wang@intel.com
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com

Wei Wang wrote:
> +static inline int xb_set_page(struct virtio_balloon *vb,
> +			       struct page *page,
> +			       unsigned long *pfn_min,
> +			       unsigned long *pfn_max)
> +{
> +	unsigned long pfn = page_to_pfn(page);
> +	int ret;
> +
> +	*pfn_min = min(pfn, *pfn_min);
> +	*pfn_max = max(pfn, *pfn_max);
> +
> +	do {
> +		ret = xb_preload_and_set_bit(&vb->page_xb, pfn,
> +					     GFP_NOWAIT | __GFP_NOWARN);

It is a bit of pity that __GFP_NOWARN here is applied to only xb_preload().
Memory allocation by xb_set_bit() will after all emit warnings. Maybe

  xb_init(&vb->page_xb);
  vb->page_xb.gfp_mask |= __GFP_NOWARN;

is tolerable? Or, unconditionally apply __GFP_NOWARN at xb_init()?

  static inline void xb_init(struct xb *xb)
  {
          INIT_RADIX_TREE(&xb->xbrt, IDR_RT_MARKER | GFP_NOWAIT);
  }

> +	} while (unlikely(ret == -EAGAIN));
> +
> +	return ret;
> +}
> +



> @@ -172,11 +283,18 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
>  	vb->num_pfns = 0;
>  
>  	while ((page = balloon_page_pop(&pages))) {
> +		if (use_sg) {
> +			if (xb_set_page(vb, page, &pfn_min, &pfn_max) < 0) {
> +				__free_page(page);
> +				break;

You cannot "break;" without consuming all pages in "pages".

> +			}
> +		} else {
> +			set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
> +		}
> +
>  		balloon_page_enqueue(&vb->vb_dev_info, page);
>  
>  		vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE;
> -
> -		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
>  		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
>  		if (!virtio_has_feature(vb->vdev,
>  					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))



> @@ -212,9 +334,12 @@ static unsigned leak_balloon(struct virtio_balloon *vb, size_t num)
>  	struct page *page;
>  	struct balloon_dev_info *vb_dev_info = &vb->vb_dev_info;
>  	LIST_HEAD(pages);
> +	bool use_sg = virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_SG);

You can pass use_sg as an argument to leak_balloon(). Then, you won't
need to define leak_balloon_sg_oom(). Since xbitmap allocation does not
use __GFP_DIRECT_RECLAIM, it is safe to reuse leak_balloon() for OOM path.
Just be sure to pass use_sg == false because memory allocation for
use_sg == true likely fails when called from OOM path. (But trying
use_sg == true for OOM path and then fallback to use_sg == false is not bad?)

> +	unsigned long pfn_max = 0, pfn_min = ULONG_MAX;
>  
> -	/* We can only do one array worth at a time. */
> -	num = min(num, ARRAY_SIZE(vb->pfns));
> +	/* Traditionally, we can only do one array worth at a time. */
> +	if (!use_sg)
> +		num = min(num, ARRAY_SIZE(vb->pfns));
>  
>  	mutex_lock(&vb->balloon_lock);
>  	/* We can't release more pages than taken */



> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index 343d7dd..37780a7 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -34,6 +34,7 @@
>  #define VIRTIO_BALLOON_F_MUST_TELL_HOST	0 /* Tell before reclaiming pages */
>  #define VIRTIO_BALLOON_F_STATS_VQ	1 /* Memory Stats virtqueue */
>  #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
> +#define VIRTIO_BALLOON_F_SG		3 /* Use sg instead of PFN lists */

Want more explicit comment that PFN lists will be used on OOM and therefore
the host side must be prepared for both sg and PFN lists even if negotiated?
