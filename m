Received: from eggs.gnu.org ([2001:4830:134:3::10]:43348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1e1sRm-0004kU-Bw
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 07:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1e1sRh-000232-D6
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 07:11:38 -0400
Received: from www262.sakura.ne.jp ([2001:e42:101:1:202:181:97:72]:42614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1e1sRg-0000YQ-V1
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 07:11:33 -0400
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <1506744354-20979-1-git-send-email-wei.w.wang@intel.com>
	<1506744354-20979-4-git-send-email-wei.w.wang@intel.com>
	<20171009181612-mutt-send-email-mst@kernel.org>
	<59DC76BA.7070202@intel.com>
In-Reply-To: <59DC76BA.7070202@intel.com>
Message-Id: <201710102008.FIG57851.QFJLMtVOFOHFOS@I-love.SAKURA.ne.jp>
Date: Tue, 10 Oct 2017 20:08:37 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Qemu-devel] [PATCH v16 3/5] virtio-balloon: VIRTIO_BALLOON_F_SG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wei.w.wang@intel.com, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

Wei Wang wrote:
> On 10/09/2017 11:20 PM, Michael S. Tsirkin wrote:
> > On Sat, Sep 30, 2017 at 12:05:52PM +0800, Wei Wang wrote:
> >> +static inline void xb_set_page(struct virtio_balloon *vb,
> >> +			       struct page *page,
> >> +			       unsigned long *pfn_min,
> >> +			       unsigned long *pfn_max)
> >> +{
> >> +	unsigned long pfn = page_to_pfn(page);
> >> +
> >> +	*pfn_min = min(pfn, *pfn_min);
> >> +	*pfn_max = max(pfn, *pfn_max);
> >> +	xb_preload(GFP_KERNEL);
> >> +	xb_set_bit(&vb->page_xb, pfn);
> >> +	xb_preload_end();
> >> +}
> >> +
> > So, this will allocate memory
> >
> > ...
> >
> >> @@ -198,9 +327,12 @@ static unsigned leak_balloon(struct virtio_balloon *vb, size_t num)
> >>   	struct page *page;
> >>   	struct balloon_dev_info *vb_dev_info = &vb->vb_dev_info;
> >>   	LIST_HEAD(pages);
> >> +	bool use_sg = virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_SG);
> >> +	unsigned long pfn_max = 0, pfn_min = ULONG_MAX;
> >>   
> >> -	/* We can only do one array worth at a time. */
> >> -	num = min(num, ARRAY_SIZE(vb->pfns));
> >> +	/* Traditionally, we can only do one array worth at a time. */
> >> +	if (!use_sg)
> >> +		num = min(num, ARRAY_SIZE(vb->pfns));
> >>   
> >>   	mutex_lock(&vb->balloon_lock);
> >>   	/* We can't release more pages than taken */
> > And is sometimes called on OOM.
> >
> >
> > I suspect we need to
> >
> > 1. keep around some memory for leak on oom
> >
> > 2. for non oom allocate outside locks
> >
> >
> 
> I think maybe we can optimize the existing balloon logic, which could 
> remove the big balloon lock:
> 
> It would not be necessary to have the inflating and deflating run at the 
> same time.
> For example, 1st request to inflate 7G RAM, when 1GB has been given to 
> the host (so 6G left), the
> 2nd request to deflate 5G is received. Instead of waiting for the 1st 
> request to inflate 6G and then
> continuing with the 2nd request to deflate 5G, we can do a diff (6G to 
> inflate - 5G to deflate) immediately,
> and got 1G to inflate. In this way, all that driver will do is to simply 
> inflate another 1G.
> 
> Same for the OOM case: when OOM asks for 1G, while inflating 5G is in 
> progress, then the driver can
> deduct 1G from the amount that needs to inflate, and as a result, it 
> will inflate 4G.
> 
> In this case, we will never have the inflating and deflating task run at 
> the same time, so I think it is
> possible to remove the lock, and therefore, we will not have that 
> deadlock issue.
> 
> What would you guys think?

What is balloon_lock at virtballoon_migratepage() for?

  e22504296d4f64fb "virtio_balloon: introduce migration primitives to balloon pages"
  f68b992bbb474641 "virtio_balloon: fix race by fill and leak"

And even if we could remove balloon_lock, you still cannot use
__GFP_DIRECT_RECLAIM at xb_set_page(). I think you will need to use
"whether it is safe to wait" flag from
"[PATCH] virtio: avoid possible OOM lockup at virtballoon_oom_notify()" .
