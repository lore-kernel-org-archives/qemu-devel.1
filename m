Received: from eggs.gnu.org ([2001:4830:134:3::10]:57547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eAa7G-0007js-Vv
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eAa7D-00085J-SS
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:26:26 -0400
Received: from www262.sakura.ne.jp ([2001:e42:101:1:202:181:97:72]:58635)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eAa7D-00080f-FP
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:26:23 -0400
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <1509696786-1597-1-git-send-email-wei.w.wang@intel.com>
	<1509696786-1597-5-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1509696786-1597-5-git-send-email-wei.w.wang@intel.com>
Message-Id: <201711032025.HJC78622.SFFOMLOtFQHVJO@I-love.SAKURA.ne.jp>
Date: Fri, 3 Nov 2017 20:25:32 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Qemu-devel] [PATCH v17 4/6] virtio-balloon: VIRTIO_BALLOON_F_SG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wei.w.wang@intel.com, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

Wei Wang wrote:
> @@ -164,6 +284,8 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
>  			break;
>  		}
>  
> +		if (use_sg && xb_set_page(vb, page, &pfn_min, &pfn_max) < 0)

Isn't this leaking "page" ?

> +			break;
>  		balloon_page_push(&pages, page);
>  	}
>  



> @@ -184,8 +307,12 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
>  
>  	num_allocated_pages = vb->num_pfns;
>  	/* Did we get any? */
> -	if (vb->num_pfns != 0)
> -		tell_host(vb, vb->inflate_vq);
> +	if (vb->num_pfns) {
> +		if (use_sg)
> +			tell_host_sgs(vb, vb->inflate_vq, pfn_min, pfn_max);

Please describe why tell_host_sgs() can work without __GFP_DIRECT_RECLAIM allocation,
for tell_host_sgs() is called with vb->balloon_lock mutex held.

> +		else
> +			tell_host(vb, vb->inflate_vq);
> +	}
>  	mutex_unlock(&vb->balloon_lock);
>  
>  	return num_allocated_pages;



> @@ -223,7 +353,13 @@ static unsigned leak_balloon(struct virtio_balloon *vb, size_t num)
>  		page = balloon_page_dequeue(vb_dev_info);
>  		if (!page)
>  			break;
> -		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
> +		if (use_sg) {
> +			if (xb_set_page(vb, page, &pfn_min, &pfn_max) < 0)

Isn't this leaking "page" ?

If this is inside vb->balloon_lock mutex (isn't this?), xb_set_page() must not
use __GFP_DIRECT_RECLAIM allocation, for leak_balloon_sg_oom() will be blocked
on vb->balloon_lock mutex.

> +				break;
> +		} else {
> +			set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
> +		}
> +
>  		list_add(&page->lru, &pages);
>  		vb->num_pages -= VIRTIO_BALLOON_PAGES_PER_PAGE;
>  	}
