Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4DBC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 19:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B20C920803
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 19:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTxMY1lL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20C920803
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icDYA-0008F2-Qy
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 14:09:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1icChh-0001LS-K7
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 13:15:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1icCX9-0006Yy-VM
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 13:04:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37039
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1icCX9-0006Sg-BE
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 13:04:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575396261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OUnwykKhCDmNoJYNHlmoqQVgFsC9ZB1zfEVxlOKjtj8=;
 b=iTxMY1lLoIbskH36E4tJSy3zWAYExeW0YGlwJCrxYeLTGOiWaNmgraf+fEYLGAOZmH949V
 8OglW+nR+HIuFOXrcpLp1lZUeia8xws53vs+d8jv4PcUdp68MUTLbRBKVTAT/VIP3NsSHz
 XJjI6qA0BtCd+DcFe+GAzmrAXX1X3AM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-YswC_AzrOEaICnKLMZ8bzQ-1; Tue, 03 Dec 2019 13:04:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D20810054E3;
 Tue,  3 Dec 2019 18:04:15 +0000 (UTC)
Received: from x1.home (ovpn-116-56.phx2.redhat.com [10.3.116.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4765B5D6A7;
 Tue,  3 Dec 2019 18:04:13 +0000 (UTC)
Date: Tue, 3 Dec 2019 11:04:12 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH v9 Kernel 2/5] vfio iommu: Add ioctl defination to get
 dirty pages bitmap.
Message-ID: <20191203110412.055c38df@x1.home>
In-Reply-To: <20191126005739.GA31144@joy-OptiPlex-7040>
References: <1573578220-7530-1-git-send-email-kwankhede@nvidia.com>
 <1573578220-7530-3-git-send-email-kwankhede@nvidia.com>
 <20191112153020.71406c44@x1.home>
 <324ce4f8-d655-ee37-036c-fc9ef9045bef@nvidia.com>
 <20191113130705.32c6b663@x1.home>
 <7f74a2a1-ba1c-9d4c-dc5e-343ecdd7d6d6@nvidia.com>
 <20191114140625.213e8a99@x1.home>
 <20191126005739.GA31144@joy-OptiPlex-7040>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: YswC_AzrOEaICnKLMZ8bzQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "cjia@nvidia.com" <cjia@nvidia.com>,
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

On Mon, 25 Nov 2019 19:57:39 -0500
Yan Zhao <yan.y.zhao@intel.com> wrote:

> On Fri, Nov 15, 2019 at 05:06:25AM +0800, Alex Williamson wrote:
> > On Fri, 15 Nov 2019 00:26:07 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> > > On 11/14/2019 1:37 AM, Alex Williamson wrote:  
> > > > On Thu, 14 Nov 2019 01:07:21 +0530
> > > > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> > > >     
> > > >> On 11/13/2019 4:00 AM, Alex Williamson wrote:    
> > > >>> On Tue, 12 Nov 2019 22:33:37 +0530
> > > >>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> > > >>>        
> > > >>>> All pages pinned by vendor driver through vfio_pin_pages API should be
> > > >>>> considered as dirty during migration. IOMMU container maintains a list of
> > > >>>> all such pinned pages. Added an ioctl defination to get bitmap of such    
> > > >>>
> > > >>> definition
> > > >>>        
> > > >>>> pinned pages for requested IO virtual address range.    
> > > >>>
> > > >>> Additionally, all mapped pages are considered dirty when physically
> > > >>> mapped through to an IOMMU, modulo we discussed devices opting in to
> > > >>> per page pinning to indicate finer granularity with a TBD mechanism to
> > > >>> figure out if any non-opt-in devices remain.
> > > >>>        
> > > >>
> > > >> You mean, in case of device direct assignment (device pass through)?    
> > > > 
> > > > Yes, or IOMMU backed mdevs.  If vfio_dmas in the container are fully
> > > > pinned and mapped, then the correct dirty page set is all mapped pages.
> > > > We discussed using the vpfn list as a mechanism for vendor drivers to
> > > > reduce their migration footprint, but we also discussed that we would
> > > > need a way to determine that all participants in the container have
> > > > explicitly pinned their working pages or else we must consider the
> > > > entire potential working set as dirty.
> > > >     
> > > 
> > > How can vendor driver tell this capability to iommu module? Any suggestions?  
> > 
> > I think it does so by pinning pages.  Is it acceptable that if the
> > vendor driver pins any pages, then from that point forward we consider
> > the IOMMU group dirty page scope to be limited to pinned pages?  There  
> we should also be aware of that dirty page scope is pinned pages + unpinned pages,
> which means ever since a page is pinned, it should be regarded as dirty
> no matter whether it's unpinned later. only after log_sync is called and
> dirty info retrieved, its dirty state should be cleared.

Yes, good point.  We can't just remove a vpfn when a page is unpinned
or else we'd lose information that the page potentially had been
dirtied while it was pinned.  Maybe that vpfn needs to move to a dirty
list and both the currently pinned vpfns and the dirty vpfns are walked
on a log_sync.  The dirty vpfns list would be cleared after a log_sync.
The container would need to know that dirty tracking is enabled and
only manage the dirty vpfns list when necessary.  Thanks,

Alex
 
> > are complications around non-singleton IOMMU groups, but I think we're
> > already leaning towards that being a non-worthwhile problem to solve.
> > So if we require that only singleton IOMMU groups can pin pages and we
> > pass the IOMMU group as a parameter to
> > vfio_iommu_driver_ops.pin_pages(), then the type1 backend can set a
> > flag on its local vfio_group struct to indicate dirty page scope is
> > limited to pinned pages.  We might want to keep a flag on the
> > vfio_iommu struct to indicate if all of the vfio_groups for each
> > vfio_domain in the vfio_iommu.domain_list dirty page scope limited to
> > pinned pages as an optimization to avoid walking lists too often.  Then
> > we could test if vfio_iommu.domain_list is not empty and this new flag
> > does not limit the dirty page scope, then everything within each
> > vfio_dma is considered dirty.
> >    
> > > >>>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > > >>>> Reviewed-by: Neo Jia <cjia@nvidia.com>
> > > >>>> ---
> > > >>>>    include/uapi/linux/vfio.h | 23 +++++++++++++++++++++++
> > > >>>>    1 file changed, 23 insertions(+)
> > > >>>>
> > > >>>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > > >>>> index 35b09427ad9f..6fd3822aa610 100644
> > > >>>> --- a/include/uapi/linux/vfio.h
> > > >>>> +++ b/include/uapi/linux/vfio.h
> > > >>>> @@ -902,6 +902,29 @@ struct vfio_iommu_type1_dma_unmap {
> > > >>>>    #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
> > > >>>>    #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
> > > >>>>    
> > > >>>> +/**
> > > >>>> + * VFIO_IOMMU_GET_DIRTY_BITMAP - _IOWR(VFIO_TYPE, VFIO_BASE + 17,
> > > >>>> + *                                     struct vfio_iommu_type1_dirty_bitmap)
> > > >>>> + *
> > > >>>> + * IOCTL to get dirty pages bitmap for IOMMU container during migration.
> > > >>>> + * Get dirty pages bitmap of given IO virtual addresses range using
> > > >>>> + * struct vfio_iommu_type1_dirty_bitmap. Caller sets argsz, which is size of
> > > >>>> + * struct vfio_iommu_type1_dirty_bitmap. User should allocate memory to get
> > > >>>> + * bitmap and should set size of allocated memory in bitmap_size field.
> > > >>>> + * One bit is used to represent per page consecutively starting from iova
> > > >>>> + * offset. Bit set indicates page at that offset from iova is dirty.
> > > >>>> + */
> > > >>>> +struct vfio_iommu_type1_dirty_bitmap {
> > > >>>> +	__u32        argsz;
> > > >>>> +	__u32        flags;
> > > >>>> +	__u64        iova;                      /* IO virtual address */
> > > >>>> +	__u64        size;                      /* Size of iova range */
> > > >>>> +	__u64        bitmap_size;               /* in bytes */    
> > > >>>
> > > >>> This seems redundant.  We can calculate the size of the bitmap based on
> > > >>> the iova size.
> > > >>>       
> > > >>
> > > >> But in kernel space, we need to validate the size of memory allocated by
> > > >> user instead of assuming user is always correct, right?    
> > > > 
> > > > What does it buy us for the user to tell us the size?  They could be
> > > > wrong, they could be malicious.  The argsz field on the ioctl is mostly
> > > > for the handshake that the user is competent, we should get faults from
> > > > the copy-user operation if it's incorrect.
> > > >    
> > > 
> > > It is to mainly fail safe.
> > >   
> > > >>>> +	void __user *bitmap;                    /* one bit per page */    
> > > >>>
> > > >>> Should we define that as a __u64* to (a) help with the size
> > > >>> calculation, and (b) assure that we can use 8-byte ops on it?
> > > >>>
> > > >>> However, who defines page size?  Is it necessarily the processor page
> > > >>> size?  A physical IOMMU may support page sizes other than the CPU page
> > > >>> size.  It might be more important to indicate the expected page size
> > > >>> than the bitmap size.  Thanks,
> > > >>>       
> > > >>
> > > >> I see in QEMU and in vfio_iommu_type1 module, page sizes considered for
> > > >> mapping are CPU page size, 4K. Do we still need to have such argument?    
> > > > 
> > > > That assumption exists for backwards compatibility prior to supporting
> > > > the iova_pgsizes field in vfio_iommu_type1_info.  AFAIK the current
> > > > interface has no page size assumptions and we should not add any.    
> > > 
> > > So userspace has iova_pgsizes information, which can be input to this 
> > > ioctl. Bitmap should be considering smallest page size. Does that makes 
> > > sense?  
> > 
> > I'm not sure.  I thought I had an argument that the iova_pgsize could
> > indicate support for sizes smaller than the processor page size, which
> > would make the user responsible for using a different base for their
> > page size, but vfio_pgsize_bitmap() already masks out sub-page sizes.
> > Clearly the vendor driver is pinning based on processor sized pages,
> > but that's independent of an IOMMU and not part of a user ABI.
> > 
> > I'm tempted to say your bitmap_size field has a use here, but it seems
> > to fail in validating the user page size at the low extremes.  For
> > example if we have a single page mapping, the user can specify the iova
> > size as 4K (for example), but the minimum bitmap_size they can indicate
> > is 1 byte, would we therefore assume the user's bitmap page size is 512
> > bytes (ie. they provided us with 8 bits to describe a 4K range)?  We'd
> > need to be careful to specify that the minimum iova_pgsize indicated
> > page size is our lower bound as well.  But then what do we do if the
> > user provides us with a smaller buffer than we expect?  For example, a
> > 128MB iova range and only an 8-byte buffer.  Do we go ahead and assume
> > a 2MB page size and fill the bitmap accordingly or do we generate an
> > error?  If the latter, might we support that at some point in time and
> > is it sufficient to let the user perform trial and error to test if that
> > exists?  Thanks,
> > 
> > Alex
> >   
> 


