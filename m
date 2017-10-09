Received: from eggs.gnu.org ([2001:4830:134:3::10]:40120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e1ZrQ-0000yR-BX
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:20:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e1ZrK-0006Ci-Pq
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:20:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e1ZrK-0006CN-J3
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:20:46 -0400
Date: Mon, 9 Oct 2017 18:20:30 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171009181612-mutt-send-email-mst@kernel.org>
References: <1506744354-20979-1-git-send-email-wei.w.wang@intel.com>
	<1506744354-20979-4-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1506744354-20979-4-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v16 3/5] virtio-balloon: VIRTIO_BALLOON_F_SG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On Sat, Sep 30, 2017 at 12:05:52PM +0800, Wei Wang wrote:
> +static inline void xb_set_page(struct virtio_balloon *vb,
> +			       struct page *page,
> +			       unsigned long *pfn_min,
> +			       unsigned long *pfn_max)
> +{
> +	unsigned long pfn = page_to_pfn(page);
> +
> +	*pfn_min = min(pfn, *pfn_min);
> +	*pfn_max = max(pfn, *pfn_max);
> +	xb_preload(GFP_KERNEL);
> +	xb_set_bit(&vb->page_xb, pfn);
> +	xb_preload_end();
> +}
> +

So, this will allocate memory

...

> @@ -198,9 +327,12 @@ static unsigned leak_balloon(struct virtio_balloon *vb, size_t num)
>  	struct page *page;
>  	struct balloon_dev_info *vb_dev_info = &vb->vb_dev_info;
>  	LIST_HEAD(pages);
> +	bool use_sg = virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_SG);
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

And is sometimes called on OOM.


I suspect we need to

1. keep around some memory for leak on oom

2. for non oom allocate outside locks


-- 
MST
