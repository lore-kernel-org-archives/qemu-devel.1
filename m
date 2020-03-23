Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092F3C4332E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 01:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF502070A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 01:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF502070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGBmu-0004IJ-Uv
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 21:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jGBlS-0003fz-P5
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 21:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1jGBlQ-0000NO-Al
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 21:20:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:49147)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1jGBlO-0000He-PU
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 21:20:24 -0400
IronPort-SDR: 5RIOd0ch5JELLaW5u2v6gALxHN0EGGCWILn+EuNb+Deeq/Dp2Y6i0ZBhDh8Gq7IQAClBO5101W
 iIDoMt9tcmUw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2020 18:20:18 -0700
IronPort-SDR: C5W7DBlsZsmDNqxgn5kUVm+1enbfNIRY8NRiPmEjm6642kzxEs7IMjEmjO07Q/Q60ryxsAo7sW
 bQz/T9f6PUNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,294,1580803200"; d="scan'208";a="392752188"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by orsmga004.jf.intel.com with ESMTP; 22 Mar 2020 18:20:11 -0700
Date: Sun, 22 Mar 2020 21:10:41 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v14 Kernel 5/7] vfio iommu: Update UNMAP_DMA ioctl to get
 dirty bitmap before unmap
Message-ID: <20200323011041.GB5456@joy-OptiPlex-7040>
References: <1584560474-19946-1-git-send-email-kwankhede@nvidia.com>
 <1584560474-19946-6-git-send-email-kwankhede@nvidia.com>
 <20200320083529.GA5456@joy-OptiPlex-7040>
 <20200320094039.4d99408d@w520.home>
 <20200320094727.12aba30e@w520.home>
 <aa76ad96-394f-f1fb-2e8d-a453bd69a39b@nvidia.com>
 <20200320132821.2fe80c29@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320132821.2fe80c29@w520.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.43
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
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang,
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 Kirti Wankhede <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Mar 21, 2020 at 03:28:21AM +0800, Alex Williamson wrote:
> On Sat, 21 Mar 2020 00:44:32 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
> > On 3/20/2020 9:17 PM, Alex Williamson wrote:
> > > On Fri, 20 Mar 2020 09:40:39 -0600
> > > Alex Williamson <alex.williamson@redhat.com> wrote:
> > >   
> > >> On Fri, 20 Mar 2020 04:35:29 -0400
> > >> Yan Zhao <yan.y.zhao@intel.com> wrote:
> > >>  
> > >>> On Thu, Mar 19, 2020 at 03:41:12AM +0800, Kirti Wankhede wrote:  
> > >>>> DMA mapped pages, including those pinned by mdev vendor drivers, might
> > >>>> get unpinned and unmapped while migration is active and device is still
> > >>>> running. For example, in pre-copy phase while guest driver could access
> > >>>> those pages, host device or vendor driver can dirty these mapped pages.
> > >>>> Such pages should be marked dirty so as to maintain memory consistency
> > >>>> for a user making use of dirty page tracking.
> > >>>>
> > >>>> To get bitmap during unmap, user should set flag
> > >>>> VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP, bitmap memory should be allocated and
> > >>>> zeroed by user space application. Bitmap size and page size should be set
> > >>>> by user application.
> > >>>>
> > >>>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > >>>> Reviewed-by: Neo Jia <cjia@nvidia.com>
> > >>>> ---
> > >>>>   drivers/vfio/vfio_iommu_type1.c | 55 ++++++++++++++++++++++++++++++++++++++---
> > >>>>   include/uapi/linux/vfio.h       | 11 +++++++++
> > >>>>   2 files changed, 62 insertions(+), 4 deletions(-)
> > >>>>
> > >>>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > >>>> index d6417fb02174..aa1ac30f7854 100644
> > >>>> --- a/drivers/vfio/vfio_iommu_type1.c
> > >>>> +++ b/drivers/vfio/vfio_iommu_type1.c
> > >>>> @@ -939,7 +939,8 @@ static int verify_bitmap_size(uint64_t npages, uint64_t bitmap_size)
> > >>>>   }
> > >>>>   
> > >>>>   static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
> > >>>> -			     struct vfio_iommu_type1_dma_unmap *unmap)
> > >>>> +			     struct vfio_iommu_type1_dma_unmap *unmap,
> > >>>> +			     struct vfio_bitmap *bitmap)
> > >>>>   {
> > >>>>   	uint64_t mask;
> > >>>>   	struct vfio_dma *dma, *dma_last = NULL;
> > >>>> @@ -990,6 +991,10 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
> > >>>>   	 * will be returned if these conditions are not met.  The v2 interface
> > >>>>   	 * will only return success and a size of zero if there were no
> > >>>>   	 * mappings within the range.
> > >>>> +	 *
> > >>>> +	 * When VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP flag is set, unmap request
> > >>>> +	 * must be for single mapping. Multiple mappings with this flag set is
> > >>>> +	 * not supported.
> > >>>>   	 */
> > >>>>   	if (iommu->v2) {
> > >>>>   		dma = vfio_find_dma(iommu, unmap->iova, 1);
> > >>>> @@ -997,6 +1002,13 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
> > >>>>   			ret = -EINVAL;
> > >>>>   			goto unlock;
> > >>>>   		}
> > >>>> +
> > >>>> +		if ((unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
> > >>>> +		    (dma->iova != unmap->iova || dma->size != unmap->size)) {  
> > >>> dma is probably NULL here!  
> > >>
> > >> Yep, I didn't look closely enough there.  This is situated right
> > >> between the check to make sure we're not bisecting a mapping at the
> > >> start of the unmap and the check to make sure we're not bisecting a
> > >> mapping at the end of the unmap.  There's no guarantee that we have a
> > >> valid pointer here.  The test should be in the while() loop below this
> > >> code.  
> > > 
> > > Actually the test could remain here, we can exit here if we can't find
> > > a dma at the start of the unmap range with the GET_DIRTY_BITMAP flag,
> > > but we absolutely cannot deref dma without testing it.
> > >   
> > 
> > In the check above newly added check, if dma is NULL then its an error 
> > condition, because Unmap requests must fully cover previous mappings, right?
> 
> Yes, but we'll do a null pointer deref before we return error.
>  
> > >>> And this restriction on UNMAP would make some UNMAP operations of vIOMMU
> > >>> fail.
> > >>>
> > >>> e.g. below condition indeed happens in reality.
> > >>> an UNMAP ioctl comes for IOVA range from 0xff800000, of size 0x200000
> > >>> However, IOVAs in this range are mapped page by page.i.e., dma->size is 0x1000.
> > >>>
> > >>> Previous, this UNMAP ioctl could unmap successfully as a whole.  
> > >>
> > >> What triggers this in the guest?  Note that it's only when using the
> > >> GET_DIRTY_BITMAP flag that this is restricted.  Does the event you're
> > >> referring to potentially occur under normal circumstances in that mode?
> > >> Thanks,
> > >>  

it happens in vIOMMU Domain level invalidation of IOTLB
(domain-selective invalidation, see vtd_iotlb_domain_invalidate() in qemu).
common in VTD lazy mode, and NOT just happening once at boot time.
rather than invalidate page by page, it batches the page invalidation.
so, when this invalidation takes place, even higher level page tables
have been invalid and therefore it has to invalidate a bigger combined range.
That's why we see IOVAs are mapped in 4k pages, but are unmapped in 2M
pages.

I think those UNMAPs should also have GET_DIRTY_BIMTAP flag on, right?
> > 
> > Such unmap would callback vfio_iommu_map_notify() in QEMU. In 
> > vfio_iommu_map_notify(), unmap is called on same range <iova, 
> > iotlb->addr_mask + 1> which was used for map. Secondly unmap with bitmap 
> > will be called only when device state has _SAVING flag set.
> 
in this case, iotlb->addr_mask in unmap is 0x200000 -1.
different than 0x1000 -1 used for map.
> It might be helpful for Yan, and everyone else, to see the latest QEMU
> patch series.  Thanks,
>
yes, please. also curious of log_sync part for vIOMMU. given most IOVAs in
address space are unmapped and therefore no IOTLBs are able to be found.

Thanks
Yan

