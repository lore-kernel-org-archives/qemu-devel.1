Received: from eggs.gnu.org ([2001:4830:134:3::10]:56576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eTmfM-0005Og-VL
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 05:41:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eTmfJ-00063E-Ot
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 05:41:01 -0500
Received: from www262.sakura.ne.jp ([2001:e42:101:1:202:181:97:72]:58383)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eTmfJ-0004df-3q
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 05:40:57 -0500
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <201712241345.DIG21823.SLFOOJtQFOMVFH@I-love.SAKURA.ne.jp>
	<5A3F5A4A.1070009@intel.com> <5A3F6254.7070306@intel.com>
	<201712252351.FBE81721.HFOtFOJQSOFLVM@I-love.SAKURA.ne.jp>
	<5A41BCC1.5010004@intel.com>
In-Reply-To: <5A41BCC1.5010004@intel.com>
Message-Id: <201712261938.IFF64061.LtFMOVJFHOSFQO@I-love.SAKURA.ne.jp>
Date: Tue, 26 Dec 2017 19:38:13 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Qemu-devel] [PATCH v20 4/7] virtio-balloon: VIRTIO_BALLOON_F_SG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wei.w.wang@intel.com, willy@infradead.org
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

Wei Wang wrote:
> On 12/25/2017 10:51 PM, Tetsuo Handa wrote:
> > Wei Wang wrote:
> >>>>>> @@ -173,8 +292,15 @@ static unsigned fill_balloon(struct
> >>>>>> virtio_balloon *vb, size_t num)
> >>>>>>          while ((page = balloon_page_pop(&pages))) {
> >>>>>>            balloon_page_enqueue(&vb->vb_dev_info, page);
> >>>>>> +        if (use_sg) {
> >>>>>> +            if (xb_set_page(vb, page, &pfn_min, &pfn_max) < 0) {
> >>>>>> +                __free_page(page);
> >>>>>> +                continue;
> >>>>>> +            }
> >>>>>> +        } else {
> >>>>>> +            set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
> >>>>>> +        }
> >>>>> Is this the right behaviour?
> >>>> I don't think so. In the worst case, we can set no bit using
> >>>> xb_set_page().
> >>>>>                                 If we can't record the page in the xb,
> >>>>> wouldn't we rather send it across as a single page?
> >>>>>
> >>>> I think that we need to be able to fallback to !use_sg path when OOM.
> >>> I also have different thoughts:
> >>>
> >>> 1) For OOM, we have leak_balloon_sg_oom (oom has nothing to do with
> >>> fill_balloon), which does not use xbitmap to record pages, thus no
> >>> memory allocation.
> >>>
> >>> 2) If the memory is already under pressure, it is pointless to
> >>> continue inflating memory to the host. We need to give thanks to the
> >>> memory allocation failure reported by xbitmap, which gets us a chance
> >>> to release the inflated pages that have been demonstrated to cause the
> >>> memory pressure of the guest.
> >>>
> >> Forgot to add my conclusion: I think the above behavior is correct.
> >>
> > What is the desired behavior when hitting OOM path during inflate/deflate?
> > Once inflation started, the inflation logic is called again and again
> > until the balloon inflates to the requested size.
> 
> The above is true, but I can't agree with the following. Please see below.
> 
> > Such situation will
> > continue wasting CPU resource between inflate-due-to-host's-request versus
> > deflate-due-to-guest's-OOM. It is pointless but cannot stop doing pointless
> > thing.
> 
> What we are doing here is to free the pages that were just allocated in 
> this round of inflating. Next round will be sometime later when the 
> balloon work item gets its turn to run. Yes, it will then continue to 
> inflate.
> Here are the two cases that will happen then:
> 1) the guest is still under memory pressure, the inflate will fail at 
> memory allocation, which results in a msleep(200), and then it exists 
> for another time to run.
> 2) the guest isn't under memory pressure any more (e.g. the task which 
> consumes the huge amount of memory is gone), it will continue to inflate 
> as normal till the requested size.
> 

How likely does 2) occur? It is not so likely. msleep(200) is enough to spam
the guest with puff messages. Next round is starting too quickly.

> I think what we are doing is a quite sensible behavior, except a small 
> change I plan to make:
> 
>          while ((page = balloon_page_pop(&pages))) {
> -               balloon_page_enqueue(&vb->vb_dev_info, page);
>                  if (use_sg) {
>                          if (xb_set_page(vb, page, &pfn_min, &pfn_max) < 
> 0) {
>                                  __free_page(page);
>                                  continue;
>                          }
>                  } else {
>                          set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
>                  }
> +             balloon_page_enqueue(&vb->vb_dev_info, page);
> 
> >
> > Also, as of Linux 4.15, only up to VIRTIO_BALLOON_ARRAY_PFNS_MAX pages (i.e.
> > 1MB) are invisible from deflate request. That amount would be an acceptable
> > error. But your patch makes more pages being invisible, for pages allocated
> > by balloon_page_alloc() without holding balloon_lock are stored into a local
> > variable "LIST_HEAD(pages)" (which means that balloon_page_dequeue() with
> > balloon_lock held won't be able to find pages not yet queued by
> > balloon_page_enqueue()), doesn't it? What if all memory pages were held in
> > "LIST_HEAD(pages)" and balloon_page_dequeue() was called before
> > balloon_page_enqueue() is called?
> >
> 
> If we think of the balloon driver just as a regular driver or 
> application, that will be a pretty nature thing. A regular driver can 
> eat a huge amount of memory for its own usages, would this amount of 
> memory be treated as an error as they are invisible to the 
> balloon_page_enqueue?
> 

No. Memory used by applications which consumed a lot of memory in their
mm_struct is reclaimed by the OOM killer/reaper. Drivers try to avoid
allocating more memory than they need. If drivers allocate more memory
than they need, they have a hook for releasing unused memory (i.e.
register_shrinker() or OOM notifier). What I'm saying here is that
the hook for releasing unused memory does not work unless memory held in
LIST_HEAD(pages) becomes visible to balloon_page_dequeue().

If a system has 128GB of memory, and 127GB of memory was stored into
LIST_HEAD(pages) upon first fill_balloon() request, and somebody held
balloon_lock from OOM notifier path from out_of_memory() before
fill_balloon() holds balloon_lock, leak_balloon_sg_oom() finds that
no memory can be freed because balloon_page_enqueue() was never called,
and allows the caller of out_of_memory() to invoke the OOM killer despite
there is 127GB of memory which can be freed if fill_balloon() was able
to hold balloon_lock before leak_balloon_sg_oom() holds balloon_lock.
I don't think that that amount is an acceptable error.
