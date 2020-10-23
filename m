Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51044C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 07:56:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8257208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 07:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="i9MBR37z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8257208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVrw3-0004fk-Nk
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 03:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kVrvA-0003aX-HT
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 03:55:32 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15049)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kVrv8-0002Vm-AW
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 03:55:32 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f928c400000>; Fri, 23 Oct 2020 00:54:40 -0700
Received: from [10.40.101.194] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 23 Oct
 2020 07:55:14 +0000
Subject: Re: [PATCH v27 14/17] vfio: Dirty page tracking when vIOMMU is enabled
To: Alex Williamson <alex.williamson@redhat.com>
References: <1603365127-14202-1-git-send-email-kwankhede@nvidia.com>
 <1603365127-14202-15-git-send-email-kwankhede@nvidia.com>
 <20201022143710.6a11facc@w520.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <e7cedc2e-232c-76c3-f192-57ebdb27abec@nvidia.com>
Date: Fri, 23 Oct 2020 13:25:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201022143710.6a11facc@w520.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603439680; bh=xMVpPmQx94moPN5hIL6hZZMGEaFbjJtP/qZmYk4rn0U=;
 h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
 b=i9MBR37zhe88VMbqCIl3bs9nvYKW6BbMUHBjNOo2jQvYpkEmLKjiXMlEYHLYtxSKA
 7lstDr/zxNNGVOMhIheO+gWH5GmqVpWKhf8sbfS5knH0LEg6k1Ncf3/+v9b0AkBUth
 tLotBP/gVY3hyhjfMiWtuQm046h0x5zPSLRdgL7u0mJYdweUj30TF24mYWWsvtG4yb
 68mgNjw5BuFTp+Dy5jrACk5bJvhdxo3rBaRj6SYM6GlYXPiFAWvLy48oXzXYdbBZhr
 dhaayDbsOl4zJWi7hSwHgz0+caB/oItPZReV3e9tVDAGcJDeCRv1xYShWSjAsaUl00
 c21QMw8xCB3vA==
Received-SPF: pass client-ip=216.228.121.64; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate25.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 03:55:28
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
Cc: cjia@nvidia.com, zhi.wang.linux@gmail.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, mcrossley@nvidia.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, eskultet@redhat.com,
 dgilbert@redhat.com, changpeng.liu@intel.com, cohuck@redhat.com,
 Ken.Xue@amd.com, jonathan.davies@nutanix.com, pbonzini@redhat.com,
 dnigam@nvidia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/23/2020 2:07 AM, Alex Williamson wrote:
> On Thu, 22 Oct 2020 16:42:04 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> When vIOMMU is enabled, register MAP notifier from log_sync when all
>> devices in container are in stop and copy phase of migration. Call replay
>> and get dirty pages from notifier callback.
>>
>> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> ---
>>   hw/vfio/common.c              | 95 ++++++++++++++++++++++++++++++++++++++++---
>>   hw/vfio/trace-events          |  1 +
>>   include/hw/vfio/vfio-common.h |  1 +
>>   3 files changed, 91 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 2634387df948..98c2b1f9b190 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -442,8 +442,8 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
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
>> @@ -474,8 +474,17 @@ static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
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
>> @@ -485,7 +494,6 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
>>       VFIOContainer *container = giommu->container;
>>       hwaddr iova = iotlb->iova + giommu->iommu_offset;
>> -    bool read_only;
>>       void *vaddr;
>>       int ret;
>>   
>> @@ -501,7 +509,9 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       rcu_read_lock();
>>   
>>       if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>> -        if (!vfio_get_vaddr(iotlb, &vaddr, &read_only)) {
>> +        bool read_only;
>> +
>> +        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only)) {
>>               goto out;
>>           }
>>           /*
>> @@ -899,11 +909,84 @@ err_out:
>>       return ret;
>>   }
>>   
>> +static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>> +{
>> +    VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, dirty_notify);
>> +    VFIOContainer *container = giommu->container;
>> +    hwaddr iova = iotlb->iova + giommu->iommu_offset;
>> +    ram_addr_t translated_addr;
>> +
>> +    trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
>> +
>> +    if (iotlb->target_as != &address_space_memory) {
>> +        error_report("Wrong target AS \"%s\", only system memory is allowed",
>> +                     iotlb->target_as->name ? iotlb->target_as->name : "none");
>> +        return;
>> +    }
>> +
>> +    rcu_read_lock();
>> +
>> +    if (vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
>> +        int ret;
>> +
>> +        ret = vfio_get_dirty_bitmap(container, iova, iotlb->addr_mask + 1,
>> +                                    translated_addr);
>> +        if (ret) {
>> +            error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
>> +                         "0x%"HWADDR_PRIx") = %d (%m)",
>> +                         container, iova,
>> +                         iotlb->addr_mask + 1, ret);
>> +        }
>> +    }
>> +
>> +    rcu_read_unlock();
>> +}
>> +
>>   static int vfio_sync_dirty_bitmap(VFIOContainer *container,
>>                                     MemoryRegionSection *section)
>>   {
>>       ram_addr_t ram_addr;
>>   
>> +    if (memory_region_is_iommu(section->mr)) {
>> +        VFIOGuestIOMMU *giommu;
>> +        int ret = 0;
>> +
>> +        QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
>> +            if (MEMORY_REGION(giommu->iommu) == section->mr &&
>> +                giommu->n.start == section->offset_within_region) {
>> +                Int128 llend;
>> +                Error *err = NULL;
>> +                int idx = memory_region_iommu_attrs_to_index(giommu->iommu,
>> +                                                       MEMTXATTRS_UNSPECIFIED);
>> +
>> +                llend = int128_add(int128_make64(section->offset_within_region),
>> +                                   section->size);
>> +                llend = int128_sub(llend, int128_one());
>> +
>> +                iommu_notifier_init(&giommu->dirty_notify,
>> +                                    vfio_iommu_map_dirty_notify,
>> +                                    IOMMU_NOTIFIER_MAP,
>> +                                    section->offset_within_region,
>> +                                    int128_get64(llend),
>> +                                    idx);
>> +                ret = memory_region_register_iommu_notifier(section->mr,
>> +                                                  &giommu->dirty_notify, &err);
>> +                if (ret) {
>> +                    error_report_err(err);
>> +                    break;
>> +                }
>> +
>> +                memory_region_iommu_replay(giommu->iommu,
>> +                                           &giommu->dirty_notify);
>> +
>> +                memory_region_unregister_iommu_notifier(section->mr,
>> +                                                        &giommu->dirty_notify);
> 
> 
> Is it necessary to do the register/unregister?  It seemed to me that
> perhaps we could do a replay independent of those.
> 

Earlier I thought to do a replay, we need to regsiter. But you are 
right, I verified replay works without registering.

> I'd also be tempted to move dirty_notify to a temporary object rather
> than store it on the giommu for such a brief usage, ie. define:
> 
> struct giommu_dirty_notfier {
>      IOMMUNotifier n;
>      VFIOGuestIOMMU *giommu;
> }
> 
> struct giommu_dirty_notfier n = { .giommu = giommu };
> 
> iommu_notifier_init(&n,...);
> 
> memory_region_iommu_replay(giommu->iommu, &n);
> ...
> 
> struct giommu_dirty_notfier *ndnotifier = container_of(n, struct giommu_dirty_notfier, n);
> VFIOGuestIOMMU *giommu = n->giommu;
> 
> It's nice that we remove the extra bloat of the list/tree entirely with
> this approach.  Thanks,
> 

Thanks for your suggestion. Changing as you suggested above.

Thanks,
Kirti

