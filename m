Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCFFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:45:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A293206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WU1G7KtB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A293206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joT7j-0007FI-CB
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 10:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1joT6i-0006Ja-9M
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 10:44:04 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4117)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1joT6f-0004wc-RH
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 10:44:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ef4b7d20000>; Thu, 25 Jun 2020 07:42:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 25 Jun 2020 07:43:59 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 25 Jun 2020 07:43:59 -0700
Received: from [10.40.100.228] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 25 Jun
 2020 14:43:43 +0000
Subject: Re: [PATCH QEMU v25 14/17] vfio: Add vfio_listener_log_sync to mark
 dirty pages
To: Alex Williamson <alex.williamson@redhat.com>
References: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
 <1592684486-18511-15-git-send-email-kwankhede@nvidia.com>
 <20200624125537.649527b3@x1.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <33d35c69-437a-b7b8-821f-6356d559e2ef@nvidia.com>
Date: Thu, 25 Jun 2020 20:13:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200624125537.649527b3@x1.home>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1593096146; bh=UqZWrcdHWebeyon8NdYY2wcPIgDc42DCDxwXmJT1voM=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=WU1G7KtBXi0BFqB3+jG39bes2Okib5OWCG63lhzbrrOg8HrNNaW5bmof21snI8a5p
 nX0CkAj6ZpgndopAaove/4X1LFZWQpEL+luC0gv+0+BuH9lgbKbhcfnhHACHBMDoc1
 BzmgW8iE8MaqsqwD2HOvL7XfgBobG0LRSafsCmtRM/x8rHbsup8niz/HO7XNNnI4XM
 CcODTtfzd0qZBiScsN4aUCT67FkhDVp5XiThp8Zph/LFR4auY34cRhLW8czYP1Q8X0
 onTK3vL4YuCaDs0YC8EYPlroACVO4/NX1q5Ya+3rF4X9cekdbEJwjkTaRo1qR3Vf2V
 afxUlve0wzLxA==
Received-SPF: pass client-ip=216.228.121.143;
 envelope-from=kwankhede@nvidia.com; helo=hqnvemgate24.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 10:44:00
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -80
X-Spam_score: -8.1
X-Spam_bar: --------
X-Spam_report: (-8.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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



On 6/25/2020 12:25 AM, Alex Williamson wrote:
> On Sun, 21 Jun 2020 01:51:23 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> vfio_listener_log_sync gets list of dirty pages from container using
>> VFIO_IOMMU_GET_DIRTY_BITMAP ioctl and mark those pages dirty when all
>> devices are stopped and saving state.
>> Return early for the RAM block section of mapped MMIO region.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> ---
>>   hw/vfio/common.c     | 130 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/trace-events |   1 +
>>   2 files changed, 131 insertions(+)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 6921a78e9ba5..0518cf228ed5 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -29,6 +29,7 @@
>>   #include "hw/vfio/vfio.h"
>>   #include "exec/address-spaces.h"
>>   #include "exec/memory.h"
>> +#include "exec/ram_addr.h"
>>   #include "hw/hw.h"
>>   #include "qemu/error-report.h"
>>   #include "qemu/main-loop.h"
>> @@ -38,6 +39,7 @@
>>   #include "sysemu/reset.h"
>>   #include "trace.h"
>>   #include "qapi/error.h"
>> +#include "migration/migration.h"
>>   
>>   VFIOGroupList vfio_group_list =
>>       QLIST_HEAD_INITIALIZER(vfio_group_list);
>> @@ -288,6 +290,28 @@ const MemoryRegionOps vfio_region_ops = {
>>   };
>>   
>>   /*
>> + * Device state interfaces
>> + */
>> +
>> +static bool vfio_devices_are_stopped_and_saving(void)
>> +{
>> +    VFIOGroup *group;
>> +    VFIODevice *vbasedev;
>> +
>> +    QLIST_FOREACH(group, &vfio_group_list, next) {
> 
> Should this be passed the container in order to iterate
> container->group_list?
> 
>> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>> +            if ((vbasedev->device_state & VFIO_DEVICE_STATE_SAVING) &&
>> +                !(vbasedev->device_state & VFIO_DEVICE_STATE_RUNNING)) {
>> +                continue;
>> +            } else {
>> +                return false;
>> +            }
>> +        }
>> +    }
>> +    return true;
>> +}
>> +
>> +/*
>>    * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
>>    */
>>   static int vfio_dma_unmap(VFIOContainer *container,
>> @@ -852,9 +876,115 @@ static void vfio_listener_region_del(MemoryListener *listener,
>>       }
>>   }
>>   
>> +static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
>> +                                 uint64_t size, ram_addr_t ram_addr)
>> +{
>> +    struct vfio_iommu_type1_dirty_bitmap *dbitmap;
>> +    struct vfio_iommu_type1_dirty_bitmap_get *range;
>> +    uint64_t pages;
>> +    int ret;
>> +
>> +    dbitmap = g_malloc0(sizeof(*dbitmap) + sizeof(*range));
>> +
>> +    dbitmap->argsz = sizeof(*dbitmap) + sizeof(*range);
>> +    dbitmap->flags = VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP;
>> +    range = (struct vfio_iommu_type1_dirty_bitmap_get *)&dbitmap->data;
>> +    range->iova = iova;
>> +    range->size = size;
>> +
>> +    /*
>> +     * cpu_physical_memory_set_dirty_lebitmap() expects pages in bitmap of
>> +     * TARGET_PAGE_SIZE to mark those dirty. Hence set bitmap's pgsize to
>> +     * TARGET_PAGE_SIZE.
>> +     */
>> +    range->bitmap.pgsize = TARGET_PAGE_SIZE;
>> +
>> +    pages = TARGET_PAGE_ALIGN(range->size) >> TARGET_PAGE_BITS;
>> +    range->bitmap.size = ROUND_UP(pages, sizeof(__u64) * BITS_PER_BYTE) /
>> +                                         BITS_PER_BYTE;
>> +    range->bitmap.data = g_try_malloc0(range->bitmap.size);
>> +    if (!range->bitmap.data) {
>> +        ret = -ENOMEM;
>> +        goto err_out;
>> +    }
>> +
>> +    ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, dbitmap);
>> +    if (ret) {
>> +        error_report("Failed to get dirty bitmap for iova: 0x%llx "
>> +                "size: 0x%llx err: %d",
>> +                range->iova, range->size, errno);
>> +        goto err_out;
>> +    }
>> +
>> +    cpu_physical_memory_set_dirty_lebitmap((uint64_t *)range->bitmap.data,
>> +                                            ram_addr, pages);
>> +
>> +    trace_vfio_get_dirty_bitmap(container->fd, range->iova, range->size,
>> +                                range->bitmap.size, ram_addr);
>> +err_out:
>> +    g_free(range->bitmap.data);
>> +    g_free(dbitmap);
>> +
>> +    return ret;
>> +}
>> +
>> +static int vfio_sync_dirty_bitmap(MemoryListener *listener,
>> +                                 MemoryRegionSection *section)
>> +{
>> +    VFIOContainer *container = container_of(listener, VFIOContainer, listener);
>> +    VFIOGuestIOMMU *giommu = NULL;
>> +    ram_addr_t ram_addr;
>> +    uint64_t iova, size;
>> +    int ret = 0;
>> +
>> +    if (memory_region_is_iommu(section->mr)) {
>> +
>> +        QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
>> +            if (MEMORY_REGION(giommu->iommu) == section->mr &&
>> +                giommu->n.start == section->offset_within_region) {
>> +                VFIOIovaRange *iova_range;
>> +
>> +                QLIST_FOREACH(iova_range, &giommu->iova_list, next) {
>> +                    ret = vfio_get_dirty_bitmap(container, iova_range->iova,
>> +                                        iova_range->size, iova_range->ram_addr);
>> +                    if (ret) {
>> +                        break;
>> +                    }
>> +                }
>> +                break;
>> +            }
>> +        }
>> +
>> +    } else {
>> +        iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
>> +        size = int128_get64(section->size);
>> +
>> +        ram_addr = memory_region_get_ram_addr(section->mr) +
>> +                   section->offset_within_region + iova -
>> +                   TARGET_PAGE_ALIGN(section->offset_within_address_space);
>> +
>> +        ret = vfio_get_dirty_bitmap(container, iova, size, ram_addr);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static void vfio_listerner_log_sync(MemoryListener *listener,
>> +        MemoryRegionSection *section)
>> +{
>> +    if (vfio_listener_skipped_section(section)) {
>> +        return;
>> +    }
>> +
>> +    if (vfio_devices_are_stopped_and_saving()) {
>> +        vfio_sync_dirty_bitmap(listener, section);
>> +    }
> 
> 
> How do we decide that this is the best policy for all devices?  For
> example if a device does not support page pinning or some future means
> of marking dirtied pages, this is clearly the right choice, but when
> these are supported, aren't we deferring all dirty logging info until
> the final stage?  Thanks,
> 

Yes, for now we are deferring all dirty logging to stop-and-copy phase. 
In future, whenever hardware support for dirty page tracking get added, 
we will have flag added in migration capability in VFIO_IOMMU_GET_INFO 
capability list. Based on that we can decide to get dirty pages in 
earlier phase of migration.

Thanks,
Kirti

