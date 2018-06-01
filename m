Received: from eggs.gnu.org ([2001:4830:134:3::10]:36292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fOcHX-0003Bq-K3
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 01:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fOcHU-0003mz-AW
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 01:07:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40838 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fOcHU-0003kE-4H
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 01:07:16 -0400
Date: Fri, 1 Jun 2018 13:07:09 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180601050709.GI14867@xz-mi>
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
	<20180601045824.GH14867@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180601045824.GH14867@xz-mi>
Subject: Re: [Qemu-devel] [PATCH v7 0/5] virtio-balloon: free page hint
 reporting support
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

On Fri, Jun 01, 2018 at 12:58:24PM +0800, Peter Xu wrote:
> On Tue, Apr 24, 2018 at 02:13:43PM +0800, Wei Wang wrote:
> > This is the deivce part implementation to add a new feature,
> > VIRTIO_BALLOON_F_FREE_PAGE_HINT to the virtio-balloon device. The device
> > receives the guest free page hints from the driver and clears the
> > corresponding bits in the dirty bitmap, so that those free pages are
> > not transferred by the migration thread to the destination.
> > 
> > - Test Environment
> >     Host: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
> >     Guest: 8G RAM, 4 vCPU
> >     Migration setup: migrate_set_speed 100G, migrate_set_downtime 2 second
> > 
> > - Test Results
> >     - Idle Guest Live Migration Time (results are averaged over 10 runs):
> >         - Optimization v.s. Legacy = 271ms vs 1769ms --> ~86% reduction
> >     - Guest with Linux Compilation Workload (make bzImage -j4):
> >         - Live Migration Time (average)
> >           Optimization v.s. Legacy = 1265ms v.s. 2634ms --> ~51% reduction
> >         - Linux Compilation Time
> >           Optimization v.s. Legacy = 4min56s v.s. 5min3s
> >           --> no obvious difference
> > 
> > - Source Code
> >     - QEMU:  https://github.com/wei-w-wang/qemu-free-page-lm.git
> >     - Linux: https://github.com/wei-w-wang/linux-free-page-lm.git
> 
> Hi, Wei,
> 
> I have a very high-level question to the series.
> 
> IIUC the core idea for this series is that we can avoid sending some
> of the pages if we know that we don't need to send them.  I think this
> is based on the fact that on the destination side all the pages are by
> default zero after they are malloced.  While before this series, IIUC
> any migration will send every single page to destination, no matter
> whether it's zeroed or not.  So I'm uncertain about whether this will
> affect the received bitmap on the destination side.  Say, before this
> series, the received bitmap will directly cover the whole RAM bitmap
> after migration is finished, now it's won't.  Will there be any side
> effect?  I don't see obvious issue now, but just raise this question
> up.
> 
> Meanwhile, this reminds me about a more funny idea: whether we can
> just avoid sending the zero pages directly from QEMU's perspective.
> In other words, can we just do nothing if save_zero_page() detected
> that the page is zero (I guess the is_zero_range() can be fast too,
> but I don't know exactly how fast it is)?  And how that would be
> differed from this page hinting way in either performance and other
> aspects.

I noticed a problem (after I wrote the above paragraph 5 minutes
ago...): when a page was valid and sent to the destination (with
non-zero data), however after a while that page was zeroed.  Then if
we don't send zero pages at all, we won't send the page after it's
zeroed.  Then on the destination side we'll have a stale non-zero
page.  Is my understanding correct?  Will that be a problem to this
series too where a valid page can be possibly freed and hinted?

> 
> I haven't digged into the kernel patches yet so I have totally no idea
> on the detailed implementation of the page hinting.  Please feel free
> to correct me if there is obvious misunderstandings.
> 
> Regards,
> 
> -- 
> Peter Xu

-- 
Peter Xu
