Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9439DC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 20:08:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8E15223BE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 20:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iual+sSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E15223BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUbSA-0008AJ-N0
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 16:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kUbRO-0007Fi-Kf
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 16:07:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34456)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kUbRK-00012q-8V
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 16:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603138048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VgTQj5k55v4emH60ZREPvOaS3fBrn2fx4lMQO20ls7I=;
 b=iual+sSRt0kNJPnc73UZN/hKO+tLz1+M9lnqFEL5Eiyzhvw+QPU0vpGeNgfGFcU+9r+oyf
 +Etv2fluDmOe4P21cFXAufZEvpZVLEhgMVFM1TUtjP/kBzhDy84xoznwGxqeRcPIx/uGKj
 eCns/TIJAeVL9uxJjCeI4ZWbqUz7QKU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-0K4zWgeUOpmz_DPGCC81Xg-1; Mon, 19 Oct 2020 16:07:25 -0400
X-MC-Unique: 0K4zWgeUOpmz_DPGCC81Xg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C3AD18B6135;
 Mon, 19 Oct 2020 20:07:23 +0000 (UTC)
Received: from w520.home (ovpn-112-77.phx2.redhat.com [10.3.112.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2ACED19D7C;
 Mon, 19 Oct 2020 20:07:18 +0000 (UTC)
Date: Mon, 19 Oct 2020 14:07:17 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v26 13/17] vfio: create mapped iova list when vIOMMU is
 enabled
Message-ID: <20201019140717.705368dd@w520.home>
In-Reply-To: <52361a71-f812-5f69-be57-93b732e96ed1@nvidia.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-14-git-send-email-kwankhede@nvidia.com>
 <20200925162316.53dbd2b0@x1.home>
 <d7337283-72b6-3047-3c91-580697a63715@nvidia.com>
 <20201019112408.470ae1e8@w520.home>
 <52361a71-f812-5f69-be57-93b732e96ed1@nvidia.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: cohuck@redhat.com, cjia@nvidia.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, dgilbert@redhat.com, changpeng.liu@intel.com,
 eskultet@redhat.com, Ken.Xue@amd.com, jonathan.davies@nutanix.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 20 Oct 2020 00:45:28 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 10/19/2020 10:54 PM, Alex Williamson wrote:
> > On Mon, 19 Oct 2020 11:31:03 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> >> On 9/26/2020 3:53 AM, Alex Williamson wrote:  
> >>> On Wed, 23 Sep 2020 04:54:15 +0530
> >>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >>>      
> >>>> Create mapped iova list when vIOMMU is enabled. For each mapped iova
> >>>> save translated address. Add node to list on MAP and remove node from
> >>>> list on UNMAP.
> >>>> This list is used to track dirty pages during migration.
> >>>>
> >>>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> >>>> ---
> >>>>    hw/vfio/common.c              | 58 ++++++++++++++++++++++++++++++++++++++-----
> >>>>    include/hw/vfio/vfio-common.h |  8 ++++++
> >>>>    2 files changed, 60 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> >>>> index d4959c036dd1..dc56cded2d95 100644
> >>>> --- a/hw/vfio/common.c
> >>>> +++ b/hw/vfio/common.c
> >>>> @@ -407,8 +407,8 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
> >>>>    }
> >>>>    
> >>>>    /* Called with rcu_read_lock held.  */
> >>>> -static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
> >>>> -                           bool *read_only)
> >>>> +static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
> >>>> +                               ram_addr_t *ram_addr, bool *read_only)
> >>>>    {
> >>>>        MemoryRegion *mr;
> >>>>        hwaddr xlat;
> >>>> @@ -439,8 +439,17 @@ static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
> >>>>            return false;
> >>>>        }
> >>>>    
> >>>> -    *vaddr = memory_region_get_ram_ptr(mr) + xlat;
> >>>> -    *read_only = !writable || mr->readonly;
> >>>> +    if (vaddr) {
> >>>> +        *vaddr = memory_region_get_ram_ptr(mr) + xlat;
> >>>> +    }
> >>>> +
> >>>> +    if (ram_addr) {
> >>>> +        *ram_addr = memory_region_get_ram_addr(mr) + xlat;
> >>>> +    }
> >>>> +
> >>>> +    if (read_only) {
> >>>> +        *read_only = !writable || mr->readonly;
> >>>> +    }
> >>>>    
> >>>>        return true;
> >>>>    }
> >>>> @@ -450,7 +459,6 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
> >>>>        VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
> >>>>        VFIOContainer *container = giommu->container;
> >>>>        hwaddr iova = iotlb->iova + giommu->iommu_offset;
> >>>> -    bool read_only;
> >>>>        void *vaddr;
> >>>>        int ret;
> >>>>    
> >>>> @@ -466,7 +474,10 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
> >>>>        rcu_read_lock();
> >>>>    
> >>>>        if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
> >>>> -        if (!vfio_get_vaddr(iotlb, &vaddr, &read_only)) {
> >>>> +        ram_addr_t ram_addr;
> >>>> +        bool read_only;
> >>>> +
> >>>> +        if (!vfio_get_xlat_addr(iotlb, &vaddr, &ram_addr, &read_only)) {
> >>>>                goto out;
> >>>>            }
> >>>>            /*
> >>>> @@ -484,8 +495,28 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
> >>>>                             "0x%"HWADDR_PRIx", %p) = %d (%m)",
> >>>>                             container, iova,
> >>>>                             iotlb->addr_mask + 1, vaddr, ret);
> >>>> +        } else {
> >>>> +            VFIOIovaRange *iova_range;
> >>>> +
> >>>> +            iova_range = g_malloc0(sizeof(*iova_range));
> >>>> +            iova_range->iova = iova;
> >>>> +            iova_range->size = iotlb->addr_mask + 1;
> >>>> +            iova_range->ram_addr = ram_addr;
> >>>> +
> >>>> +            QLIST_INSERT_HEAD(&giommu->iova_list, iova_range, next);
> >>>>            }
> >>>>        } else {
> >>>> +        VFIOIovaRange *iova_range, *tmp;
> >>>> +
> >>>> +        QLIST_FOREACH_SAFE(iova_range, &giommu->iova_list, next, tmp) {
> >>>> +            if (iova_range->iova >= iova &&
> >>>> +                iova_range->iova + iova_range->size <= iova +
> >>>> +                                                       iotlb->addr_mask + 1) {
> >>>> +                QLIST_REMOVE(iova_range, next);
> >>>> +                g_free(iova_range);
> >>>> +            }
> >>>> +        }
> >>>> +  
> >>>
> >>>
> >>> This is some pretty serious overhead... can't we trigger a replay when
> >>> migration is enabled to build this information then?  
> >>
> >> Are you suggesting to call memory_region_iommu_replay() before
> >> vfio_sync_dirty_bitmap(), which would call vfio_iommu_map_notify() where
> >> iova list of mapping is maintained? Then in the notifer check if
> >> migration_is_running() and container->dirty_pages_supported == true,
> >> then only create iova mapping tree? In this case how would we know that
> >> this is triggered by
> >> vfio_sync_dirty_bitmap()  
> >>    -> memory_region_iommu_replay()  
> >> and we don't have to call vfio_dma_map()?  
> > 
> > memory_region_iommu_replay() calls a notifier of our choice, so we
> > could create a notifier specifically for creating this tree when dirty
> > logging is enabled.  Thanks,
> >   
> 
> This would also mean changes in intel_iommu.c such that it would walk 
> through the iova_tree and call notifier for each entry in iova_tree.

I think we already have that in vtd_iommu_replay(), an
IOMMUMemoryRegionClass.replay callback is rather a requirement of any
vIOMMU intending to support vfio AIUI.
 
> What about other platforms? We will have to handle such cases for
> AMD, ARM, PPC etc...?

There's already a requirement for a working replay callback to work in
any reasonable way with vfio, this is just an additional use case of a
callback we already need and use.

> I don't see replay callback for AMD, that would result in minimum
> IOMMU supported page size granularity walk - which is similar to that
> I tried to implement 2-3 versions back.

Patch 1/3:
https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg00545.html
Patch 5/10:
https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg02196.html

> Does that mean doing such change would improve performance for Intel 
> IOMMU but worsen for AMD/PPC?

We're not adding a new requirement, we already call replay, PPC doesn't
use type1.  What exactly regresses if we introduce another replay user?

> I'm changing list to tree as first level of improvement in this patch.
> 
> Can we do the change you suggested above later as next level of
> improvement?

AIUI above, we're allocating an object and adding it to a list (soon to
be tree) for every vIOMMU mapping, on the off chance that migration
might be used, regardless of devices even supporting migration.  I can
only see that as a runtime performance and size regression.  Thanks,

Alex


