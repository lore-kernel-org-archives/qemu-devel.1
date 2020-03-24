Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443B4C41621
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 03:11:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06518206F8
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 03:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06518206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGZyn-0003cs-2s
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 23:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jGZy6-0003DK-KV
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 23:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1jGZy3-00034a-UQ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 23:11:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:59540)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1jGZy3-0002tB-LA
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 23:11:03 -0400
IronPort-SDR: /MX8DE6rzZG2FO6+c1xOP09Vb770m9pjU0QHH6gR6mAL3xvC04Ngj9nBHYO9t2Oa6J0EYOnv2d
 rTJbDP66DJzQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2020 20:10:54 -0700
IronPort-SDR: 5texMlCqoV/AEcZIgCr6dY5yoiulJUS2ENnzkhX3Sqpyrj8Py1nIyPyXgRSpjaGeryujFJeBk4
 OBE/e05007Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; d="scan'208";a="419734609"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by orsmga005.jf.intel.com with ESMTP; 23 Mar 2020 20:10:49 -0700
Date: Mon, 23 Mar 2020 23:01:18 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v15 Kernel 4/7] vfio iommu: Implementation of ioctl for
 dirty pages tracking.
Message-ID: <20200324030118.GD5456@joy-OptiPlex-7040>
References: <1584649004-8285-1-git-send-email-kwankhede@nvidia.com>
 <1584649004-8285-5-git-send-email-kwankhede@nvidia.com>
 <20200319165704.1f4eb36a@w520.home>
 <bc48ae5c-67f9-d95e-5d60-6c42359bb790@nvidia.com>
 <20200320120137.6acd89ee@x1.home>
 <cf0ee134-c1c7-f60c-afc2-8948268d8880@nvidia.com>
 <20200320125910.028d7af5@w520.home>
 <7062f72a-bf06-a8cd-89f0-9e729699a454@nvidia.com>
 <20200323124448.2d3bc315@w520.home> <20200323185114.GF3017@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323185114.GF3017@work-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.126
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: "Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, "Wang, Zhi A" <zhi.a.wang@intel.com>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 24, 2020 at 02:51:14AM +0800, Dr. David Alan Gilbert wrote:
> * Alex Williamson (alex.williamson@redhat.com) wrote:
> > On Mon, 23 Mar 2020 23:24:37 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> > 
> > > On 3/21/2020 12:29 AM, Alex Williamson wrote:
> > > > On Sat, 21 Mar 2020 00:12:04 +0530
> > > > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> > > >   
> > > >> On 3/20/2020 11:31 PM, Alex Williamson wrote:  
> > > >>> On Fri, 20 Mar 2020 23:19:14 +0530
> > > >>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> > > >>>      
> > > >>>> On 3/20/2020 4:27 AM, Alex Williamson wrote:  
> > > >>>>> On Fri, 20 Mar 2020 01:46:41 +0530
> > > >>>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> > > >>>>>         
> > > >>
> > > >> <snip>
> > > >>  
> > > >>>>>> +static int vfio_iova_dirty_bitmap(struct vfio_iommu *iommu, dma_addr_t iova,
> > > >>>>>> +				  size_t size, uint64_t pgsize,
> > > >>>>>> +				  u64 __user *bitmap)
> > > >>>>>> +{
> > > >>>>>> +	struct vfio_dma *dma;
> > > >>>>>> +	unsigned long pgshift = __ffs(pgsize);
> > > >>>>>> +	unsigned int npages, bitmap_size;
> > > >>>>>> +
> > > >>>>>> +	dma = vfio_find_dma(iommu, iova, 1);
> > > >>>>>> +
> > > >>>>>> +	if (!dma)
> > > >>>>>> +		return -EINVAL;
> > > >>>>>> +
> > > >>>>>> +	if (dma->iova != iova || dma->size != size)
> > > >>>>>> +		return -EINVAL;
> > > >>>>>> +
> > > >>>>>> +	npages = dma->size >> pgshift;
> > > >>>>>> +	bitmap_size = DIRTY_BITMAP_BYTES(npages);
> > > >>>>>> +
> > > >>>>>> +	/* mark all pages dirty if all pages are pinned and mapped. */
> > > >>>>>> +	if (dma->iommu_mapped)
> > > >>>>>> +		bitmap_set(dma->bitmap, 0, npages);
> > > >>>>>> +
> > > >>>>>> +	if (copy_to_user((void __user *)bitmap, dma->bitmap, bitmap_size))
> > > >>>>>> +		return -EFAULT;  
> > > >>>>>
> > > >>>>> We still need to reset the bitmap here, clearing and re-adding the
> > > >>>>> pages that are still pinned.
> > > >>>>>
> > > >>>>> https://lore.kernel.org/kvm/20200319070635.2ff5db56@x1.home/
> > > >>>>>         
> > > >>>>
> > > >>>> I thought you agreed on my reply to it
> > > >>>> https://lore.kernel.org/kvm/31621b70-02a9-2ea5-045f-f72b671fe703@nvidia.com/
> > > >>>>     
> > > >>>>    > Why re-populate when there will be no change since
> > > >>>>    > vfio_iova_dirty_bitmap() is called holding iommu->lock? If there is any
> > > >>>>    > pin request while vfio_iova_dirty_bitmap() is still working, it will
> > > >>>>    > wait till iommu->lock is released. Bitmap will be populated when page is
> > > >>>>    > pinned.  
> > > >>>
> > > >>> As coded, dirty bits are only ever set in the bitmap, never cleared.
> > > >>> If a page is unpinned between iterations of the user recording the
> > > >>> dirty bitmap, it should be marked dirty in the iteration immediately
> > > >>> after the unpinning and not marked dirty in the following iteration.
> > > >>> That doesn't happen here.  We're reporting cumulative dirty pages since
> > > >>> logging was enabled, we need to be reporting dirty pages since the user
> > > >>> last retrieved the dirty bitmap.  The bitmap should be cleared and
> > > >>> currently pinned pages re-added after copying to the user.  Thanks,
> > > >>>      
> > > >>
> > > >> Does that mean, we have to track every iteration? do we really need that
> > > >> tracking?
> > > >>
> > > >> Generally the flow is:
> > > >> - vendor driver pin x pages
> > > >> - Enter pre-copy-phase where vCPUs are running - user starts dirty pages
> > > >> tracking, then user asks dirty bitmap, x pages reported dirty by
> > > >> VFIO_IOMMU_DIRTY_PAGES ioctl with _GET flag
> > > >> - In pre-copy phase, vendor driver pins y more pages, now bitmap
> > > >> consists of x+y bits set
> > > >> - In pre-copy phase, vendor driver unpins z pages, but bitmap is not
> > > >> updated, so again bitmap consists of x+y bits set.
> > > >> - Enter in stop-and-copy phase, vCPUs are stopped, mdev devices are stopped
> > > >> - user asks dirty bitmap - Since here vCPU and mdev devices are stopped,
> > > >> pages should not get dirty by guest driver or the physical device.
> > > >> Hence, x+y dirty pages would be reported.
> > > >>
> > > >> I don't think we need to track every iteration of bitmap reporting.  
> > > > 
> > > > Yes, once a bitmap is read, it's reset.  In your example, after
> > > > unpinning z pages the user should still see a bitmap with x+y pages,
> > > > but once they've read that bitmap, the next bitmap should be x+y-z.
> > > > Userspace can make decisions about when to switch from pre-copy to
> > > > stop-and-copy based on convergence, ie. the slope of the line recording
> > > > dirty pages per iteration.  The implementation here never allows an
> > > > inflection point, dirty pages reported through vfio would always either
> > > > be flat or climbing.  There might also be a case that an iommu backed
> > > > device could start pinning pages during the course of a migration, how
> > > > would the bitmap ever revert from fully populated to only tracking the
> > > > pinned pages?  Thanks,
> > > >   
> > > 
> > > At KVM forum we discussed this - if guest driver pins say 1024 pages 
> > > before migration starts, during pre-copy phase device can dirty 0 pages 
> > > in best case and 1024 pages in worst case. In that case, user will 
> > > transfer content of 1024 pages during pre-copy phase and in 
> > > stop-and-copy phase also, that will be pages will be copied twice. So we 
> > > decided to only get dirty pages bitmap at stop-and-copy phase. If user 
> > > is going to get dirty pages in stop-and-copy phase only, then that will 
> > > be single iteration.
> > > There aren't any devices yet that can track sys memory dirty pages. So 
> > > we can go ahead with this patch and support for dirty pages tracking 
> > > during pre-copy phase can be added later when there will be consumers of 
> > > that functionality.
> > 
> > So if I understand this right, you're expecting the dirty bitmap to
> > accumulate dirty bits, in perpetuity, so that the user can only
> > retrieve them once at the end of migration?  But if that's the case,
> > the user could simply choose to not retrieve the bitmap until the end
> > of migration, the result would be the same.  What we have here is that
> > dirty bits are never cleared, regardless of whether the user has seen
> > them, which is wrong.  Sorry, we had a lot of discussions at KVM forum,
> > I don't recall this specific one 5 months later and maybe we weren't
> > considering all aspects.  I see the behavior we have here as incorrect,
> > but it also seems relatively trivial to make correct.  I hope the QEMU
> > code isn't making us go through all this trouble to report a dirty
> > bitmap that gets thrown away because it expects the final one to be
> > cumulative since the beginning of dirty logging.  Thanks,
> 
> I remember the discussion that we couldn't track the system memory
> dirtying with current hardware; so the question then is just to track
hi Dave
there are already devices that are able to track the system memory,
through two ways:
(1) software method. like VFs for "Intel(R) Ethernet Controller XL710 Family
support".
(2) hardware method. through hardware internal buffer (as one Intel
internal hardware not yet to public, but very soon) or through VTD-3.0
IOMMU.

we have already had code verified using the two ways to track system memory
in fine-grained level.


> what has been pinned and then ideally put that memory off until the end.
> (Which is interesting because I don't think we currently have  a way
> to delay RAM pages till the end in qemu).

I think the problem here is that we mixed pinned pages with dirty pages.
yes, pinned pages for mdev devices are continuously likely to be dirty
until device stopped.
But for devices that are able to report dirty pages, dirtied pages
will be marked again if hardware writes them later.

So, is it good to introduce a capability to let vfio/qemu know how to
treat the dirty pages?
(1) for devices have no fine-grained dirty page tracking capability
  a. pinned pages are regarded as dirty pages. they are not cleared by
  dirty page query
  b. unpinned pages are regarded as dirty pages. they are cleared by
  dirty page query or UNMAP ioctl.
(2) for devices that have fine-grained dirty page tracking capability
   a. pinned/unpinned pages are not regarded as dirty pages
   b. only pages they reported are regarded as dirty pages and are to be
   cleared by dirty page query and UNMAP ioctl.
(3) for dirty pages marking APIs, like vfio_dma_rw()...
   pages marked by them are regared as dirty and are to be cleared by
   dirty page query and UNMAP ioctl

For (1), qemu VFIO only reports dirty page amount and would not transfer
those pages until last round.
for (2) and (3), qemu VFIO should report and transfer them in each
round.


> [I still worry whether migration will be usable with any
> significant amount of system ram that's pinned in this way; the
> downside will very easily get above the threshold that people like]
> 
yes. that's why we have to do multi-round dirty page query and
transfer and clear the dirty bitmaps in each round for devices that are
able to track in fine grain.
and that's why we have to report the amount of dirty pages before
stop-and-copy phase for mdev devices, so that people are able to know
the real downtime as much as possible.

Thanks
Yan

