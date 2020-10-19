Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369A6C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 06:03:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7562F22257
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 06:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="F8RlR3iK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7562F22257
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUOGk-0005Qp-2O
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 02:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kUOEd-0004t6-HI
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 02:01:31 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4017)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kUOEX-0002jr-P2
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 02:01:31 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f8d2b850000>; Sun, 18 Oct 2020 23:00:37 -0700
Received: from [10.40.101.194] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Oct
 2020 06:01:07 +0000
Subject: Re: [PATCH v26 13/17] vfio: create mapped iova list when vIOMMU is
 enabled
To: Alex Williamson <alex.williamson@redhat.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-14-git-send-email-kwankhede@nvidia.com>
 <20200925162316.53dbd2b0@x1.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <d7337283-72b6-3047-3c91-580697a63715@nvidia.com>
Date: Mon, 19 Oct 2020 11:31:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200925162316.53dbd2b0@x1.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603087237; bh=u4MoZwQUtzLHwUhh4GfJrF73bWMs7vnQRdAWipE6ynM=;
 h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
 b=F8RlR3iKDoQ1+x7+HUlV8jgvmOpKeXUS7/p4ILJ5legT41TNvDQWqYd14NR94nVsa
 pbCFiydkq8vQYBqvJI7XvHv8NVHxrM8G3OphqU3RfPRo3ARfavyv7spbgrVL7qN2ML
 Kgz3LCH+AlO35M/Ou/ZKrpCgar3TXBNnaSyYAHTg1OFuNPhgeoWsDI7Gb6Hn0Gh3jW
 KI4Uu5kpLn8oS29IBmFObQSeu+eLH2JJet/kBtVWng0PGKkK3llhAxNUYpAy4X8aeu
 YayXUom4vdR7doElBQPCRzWi2TA48pWgmgQ/RlxhvqSr/lXi07EnVjrtyrBi+kx6Xi
 Tf+JHis4SbSPA==
Received-SPF: pass client-ip=216.228.121.64; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate25.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:01:24
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 9/26/2020 3:53 AM, Alex Williamson wrote:
> On Wed, 23 Sep 2020 04:54:15 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> Create mapped iova list when vIOMMU is enabled. For each mapped iova
>> save translated address. Add node to list on MAP and remove node from
>> list on UNMAP.
>> This list is used to track dirty pages during migration.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> ---
>>   hw/vfio/common.c              | 58 ++++++++++++++++++++++++++++++++++++++-----
>>   include/hw/vfio/vfio-common.h |  8 ++++++
>>   2 files changed, 60 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index d4959c036dd1..dc56cded2d95 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -407,8 +407,8 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>>   }
>>   
>>   /* Called with rcu_read_lock held.  */
>> -static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
>> -                           bool *read_only)
>> +static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>> +                               ram_addr_t *ram_addr, bool *read_only)
>>   {
>>       MemoryRegion *mr;
>>       hwaddr xlat;
>> @@ -439,8 +439,17 @@ static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
>>           return false;
>>       }
>>   
>> -    *vaddr = memory_region_get_ram_ptr(mr) + xlat;
>> -    *read_only = !writable || mr->readonly;
>> +    if (vaddr) {
>> +        *vaddr = memory_region_get_ram_ptr(mr) + xlat;
>> +    }
>> +
>> +    if (ram_addr) {
>> +        *ram_addr = memory_region_get_ram_addr(mr) + xlat;
>> +    }
>> +
>> +    if (read_only) {
>> +        *read_only = !writable || mr->readonly;
>> +    }
>>   
>>       return true;
>>   }
>> @@ -450,7 +459,6 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
>>       VFIOContainer *container = giommu->container;
>>       hwaddr iova = iotlb->iova + giommu->iommu_offset;
>> -    bool read_only;
>>       void *vaddr;
>>       int ret;
>>   
>> @@ -466,7 +474,10 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       rcu_read_lock();
>>   
>>       if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>> -        if (!vfio_get_vaddr(iotlb, &vaddr, &read_only)) {
>> +        ram_addr_t ram_addr;
>> +        bool read_only;
>> +
>> +        if (!vfio_get_xlat_addr(iotlb, &vaddr, &ram_addr, &read_only)) {
>>               goto out;
>>           }
>>           /*
>> @@ -484,8 +495,28 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>                            "0x%"HWADDR_PRIx", %p) = %d (%m)",
>>                            container, iova,
>>                            iotlb->addr_mask + 1, vaddr, ret);
>> +        } else {
>> +            VFIOIovaRange *iova_range;
>> +
>> +            iova_range = g_malloc0(sizeof(*iova_range));
>> +            iova_range->iova = iova;
>> +            iova_range->size = iotlb->addr_mask + 1;
>> +            iova_range->ram_addr = ram_addr;
>> +
>> +            QLIST_INSERT_HEAD(&giommu->iova_list, iova_range, next);
>>           }
>>       } else {
>> +        VFIOIovaRange *iova_range, *tmp;
>> +
>> +        QLIST_FOREACH_SAFE(iova_range, &giommu->iova_list, next, tmp) {
>> +            if (iova_range->iova >= iova &&
>> +                iova_range->iova + iova_range->size <= iova +
>> +                                                       iotlb->addr_mask + 1) {
>> +                QLIST_REMOVE(iova_range, next);
>> +                g_free(iova_range);
>> +            }
>> +        }
>> +
> 
> 
> This is some pretty serious overhead... can't we trigger a replay when
> migration is enabled to build this information then? 

Are you suggesting to call memory_region_iommu_replay() before 
vfio_sync_dirty_bitmap(), which would call vfio_iommu_map_notify() where 
iova list of mapping is maintained? Then in the notifer check if 
migration_is_running() and container->dirty_pages_supported == true, 
then only create iova mapping tree? In this case how would we know that 
this is triggered by
vfio_sync_dirty_bitmap()
  -> memory_region_iommu_replay()
and we don't have to call vfio_dma_map()?

> We're looking at
> potentially thousands of entries, so a list is probably also not a good
> choice. 

Changing it to tree.

Thanks,
Kirti

  I don't think it's acceptable to incur this even when not
> migrating (ie. the vast majority of the time).  Thanks,
> 
> Alex
> 
>>           ret = vfio_dma_unmap(container, iova, iotlb->addr_mask + 1);
>>           if (ret) {
>>               error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>> @@ -642,6 +673,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>>               g_free(giommu);
>>               goto fail;
>>           }
>> +        QLIST_INIT(&giommu->iova_list);
>>           QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
>>           memory_region_iommu_replay(giommu->iommu, &giommu->n);
>>   
>> @@ -740,6 +772,13 @@ static void vfio_listener_region_del(MemoryListener *listener,
>>           QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
>>               if (MEMORY_REGION(giommu->iommu) == section->mr &&
>>                   giommu->n.start == section->offset_within_region) {
>> +                VFIOIovaRange *iova_range, *tmp;
>> +
>> +                QLIST_FOREACH_SAFE(iova_range, &giommu->iova_list, next, tmp) {
>> +                    QLIST_REMOVE(iova_range, next);
>> +                    g_free(iova_range);
>> +                }
>> +
>>                   memory_region_unregister_iommu_notifier(section->mr,
>>                                                           &giommu->n);
>>                   QLIST_REMOVE(giommu, giommu_next);
>> @@ -1541,6 +1580,13 @@ static void vfio_disconnect_container(VFIOGroup *group)
>>           QLIST_REMOVE(container, next);
>>   
>>           QLIST_FOREACH_SAFE(giommu, &container->giommu_list, giommu_next, tmp) {
>> +            VFIOIovaRange *iova_range, *itmp;
>> +
>> +            QLIST_FOREACH_SAFE(iova_range, &giommu->iova_list, next, itmp) {
>> +                QLIST_REMOVE(iova_range, next);
>> +                g_free(iova_range);
>> +            }
>> +
>>               memory_region_unregister_iommu_notifier(
>>                       MEMORY_REGION(giommu->iommu), &giommu->n);
>>               QLIST_REMOVE(giommu, giommu_next);
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 0a1651eda2d0..aa7524fe2cc5 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -89,11 +89,19 @@ typedef struct VFIOContainer {
>>       QLIST_ENTRY(VFIOContainer) next;
>>   } VFIOContainer;
>>   
>> +typedef struct VFIOIovaRange {
>> +    hwaddr iova;
>> +    size_t size;
>> +    ram_addr_t ram_addr;
>> +    QLIST_ENTRY(VFIOIovaRange) next;
>> +} VFIOIovaRange;
>> +
>>   typedef struct VFIOGuestIOMMU {
>>       VFIOContainer *container;
>>       IOMMUMemoryRegion *iommu;
>>       hwaddr iommu_offset;
>>       IOMMUNotifier n;
>> +    QLIST_HEAD(, VFIOIovaRange) iova_list;
>>       QLIST_ENTRY(VFIOGuestIOMMU) giommu_next;
>>   } VFIOGuestIOMMU;
>>   
> 

