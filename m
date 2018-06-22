Received: from eggs.gnu.org ([2001:4830:134:3::10]:37639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fWGQv-0005jh-4b
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 03:24:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fWGQt-0006af-Qt
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 03:24:37 -0400
References: <1529579774-27795-1-git-send-email-eric.auger@redhat.com>
	<1529579774-27795-5-git-send-email-eric.auger@redhat.com>
	<a5fafaa4-934d-87b6-0903-0846f197ae9f@gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <8b5b21c2-549f-a5af-2e99-5e1f254b7f29@redhat.com>
Date: Fri, 22 Jun 2018 09:24:25 +0200
MIME-Version: 1.0
In-Reply-To: <a5fafaa4-934d-87b6-0903-0846f197ae9f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/4] hw/arm/smmuv3: Add notifications on
 invalidation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jia He <hejianet@gmail.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, jia.he@hxt-semitech.com

Hello Jia,

On 06/22/2018 09:15 AM, Jia He wrote:
> H
> 
> On 6/21/2018 7:16 PM, Eric Auger Wrote:
>> On TLB invalidation commands, let's call registered
>> IOMMU notifiers. Those can only be UNMAP notifiers.
>> SMMUv3 does not support notification on MAP (VFIO).
>>
>> This patch allows vhost use case where IOTLB API is notified
>> on each guest IOTLB invalidation.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> ---
>> v2 -> v3:
>> - added Peter's R-b
>> ---
>>  hw/arm/smmu-common.c         | 34 +++++++++++++++
>>  hw/arm/smmuv3.c              | 99 +++++++++++++++++++++++++++++++++++++++++++-
>>  hw/arm/trace-events          |  5 +++
>>  include/hw/arm/smmu-common.h |  6 +++
>>  4 files changed, 142 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>> index f66e444..3098915 100644
>> --- a/hw/arm/smmu-common.c
>> +++ b/hw/arm/smmu-common.c
>> @@ -385,6 +385,40 @@ static gboolean smmu_iotlb_key_equal(gconstpointer v1, gconstpointer v2)
>>      return (k1->asid == k2->asid) && (k1->iova == k2->iova);
>>  }
>>  
>> +/* Unmap the whole notifier's range */
>> +static void smmu_unmap_notifier_range(IOMMUNotifier *n)
>> +{
>> +    IOMMUTLBEntry entry;
>> +
>> +    entry.target_as = &address_space_memory;
>> +    entry.iova = n->start;
>> +    entry.perm = IOMMU_NONE;
>> +    entry.addr_mask = n->end - n->start;
>> +
>> +    memory_region_notify_one(n, &entry);
>> +}
>> +
>> +/* Unmap all notifiers attached to @mr */
>> +inline void smmu_inv_notifiers_mr(IOMMUMemoryRegion *mr)
>> +{
>> +    IOMMUNotifier *n;
>> +
>> +    trace_smmu_inv_notifiers_mr(mr->parent_obj.name);
>> +    IOMMU_NOTIFIER_FOREACH(n, mr) {
>> +        smmu_unmap_notifier_range(n);
>> +    }
>> +}
>> +
>> +/* Unmap all notifiers of all mr's */
>> +void smmu_inv_notifiers_all(SMMUState *s)
>> +{
>> +    SMMUNotifierNode *node;
>> +
>> +    QLIST_FOREACH(node, &s->notifiers_list, next) {
>> +        smmu_inv_notifiers_mr(&node->sdev->iommu);
>> +    }
>> +}
>> +
>>  static void smmu_base_realize(DeviceState *dev, Error **errp)
>>  {
>>      SMMUState *s = ARM_SMMU(dev);
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 853975a..c58e596 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -780,6 +780,68 @@ epilogue:
>>      return entry;
>>  }
>>  
>> +/**
>> + * smmuv3_notify_iova - call the notifier @n for a given
>> + * @asid and @iova tuple.
>> + *
>> + * @mr: IOMMU mr region handle
>> + * @n: notifier to be called
>> + * @asid: address space ID or negative value if we don't care
>> + * @iova: iova
>> + */
>> +static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>> +                               IOMMUNotifier *n,
>> +                               int asid,
>> +                               dma_addr_t iova)
>> +{
>> +    SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
>> +    SMMUEventInfo event = {};
>> +    SMMUTransTableInfo *tt;
>> +    SMMUTransCfg *cfg;
>> +    IOMMUTLBEntry entry;
>> +
>> +    cfg = smmuv3_get_config(sdev, &event);
>> +    if (!cfg) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s error decoding the configuration for iommu mr=%s\n",
>> +                      __func__, mr->parent_obj.name);
>> +        return;
>> +    }
>> +
>> +    if (asid >= 0 && cfg->asid != asid) {
>> +        return;
>> +    }
>> +
>> +    tt = select_tt(cfg, iova);
>> +    if (!tt) {
>> +        return;
>> +    }
>> +
>> +    entry.target_as = &address_space_memory;
>> +    entry.iova = iova;
>> +    entry.addr_mask = (1 << tt->granule_sz) - 1;
>> +    entry.perm = IOMMU_NONE;
>> +
>> +    memory_region_notify_one(n, &entry);
>> +}
>> +
>> +/* invalidate an asid/iova tuple in all mr's */
>> +static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, dma_addr_t iova)
>> +{
>> +    SMMUNotifierNode *node;
>> +
>> +    QLIST_FOREACH(node, &s->notifiers_list, next) {
>> +        IOMMUMemoryRegion *mr = &node->sdev->iommu;
>> +        IOMMUNotifier *n;
>> +
>> +        trace_smmuv3_inv_notifiers_iova(mr->parent_obj.name, asid, iova);
>> +
>> +        IOMMU_NOTIFIER_FOREACH(n, mr) {
>> +            smmuv3_notify_iova(mr, n, asid, iova);
>> +        }
>> +    }
>> +}
>> +
>>  static int smmuv3_cmdq_consume(SMMUv3State *s)
>>  {
>>      SMMUState *bs = ARM_SMMU(s);
>> @@ -899,12 +961,14 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>>              uint16_t asid = CMD_ASID(&cmd);
>>  
>>              trace_smmuv3_cmdq_tlbi_nh_asid(asid);
>> +            smmu_inv_notifiers_all(&s->smmu_state);
>>              smmu_iotlb_inv_asid(bs, asid);
>>              break;
>>          }
>>          case SMMU_CMD_TLBI_NH_ALL:
>>          case SMMU_CMD_TLBI_NSNH_ALL:
>>              trace_smmuv3_cmdq_tlbi_nh();
>> +            smmu_inv_notifiers_all(&s->smmu_state);
>>              smmu_iotlb_inv_all(bs);
>>              break;
>>          case SMMU_CMD_TLBI_NH_VAA:
>> @@ -913,6 +977,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>>              uint16_t vmid = CMD_VMID(&cmd);
>>  
>>              trace_smmuv3_cmdq_tlbi_nh_vaa(vmid, addr);
>> +            smmuv3_inv_notifiers_iova(bs, -1, addr);
>>              smmu_iotlb_inv_all(bs);
>>              break;
>>          }
>> @@ -924,6 +989,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>>              bool leaf = CMD_LEAF(&cmd);
>>  
>>              trace_smmuv3_cmdq_tlbi_nh_va(vmid, asid, addr, leaf);
>> +            smmuv3_inv_notifiers_iova(bs, asid, addr);
>>              smmu_iotlb_inv_iova(bs, asid, addr);
>>              break;
>>          }
>> @@ -1402,9 +1468,38 @@ static void smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
>>                                         IOMMUNotifierFlag old,
>>                                         IOMMUNotifierFlag new)
>>  {
>> +    SMMUDevice *sdev = container_of(iommu, SMMUDevice, iommu);
>> +    SMMUv3State *s3 = sdev->smmu;
>> +    SMMUState *s = &(s3->smmu_state);
>> +    SMMUNotifierNode *node = NULL;
>> +    SMMUNotifierNode *next_node = NULL;
>> +
>> +    if (new == IOMMU_NOTIFIER_MAP) {
>> +        int bus_num = pci_bus_num(sdev->bus);
>> +        PCIDevice *pcidev = pci_find_device(sdev->bus, bus_num, sdev->devfn);
>> +
>> +        warn_report("SMMUv3 does not support notification on MAP: "
>> +                     "device %s will not function properly", pcidev->name);
>> +    }
>> +
> ah, I know why there is no such warning in my testing server.
> the IOMMUNotifierFlag is initialized with IOMMU_NOTIFIER_ALL=(IOMMU_NOTIFIER_MAP
> | IOMMU_NOTIFIER_UNMAP). Should this condition be considerred?
Hum yes it is a bug. I will fix this asap!

Thanks

Eric
> 
> Cheers,
> Jia
>>      if (old == IOMMU_NOTIFIER_NONE) {
>> -        warn_report("SMMUV3 does not support vhost/vfio integration yet: "
>> -                    "devices of those types will not function properly");
>> +        trace_smmuv3_notify_flag_add(iommu->parent_obj.name);
>> +        node = g_malloc0(sizeof(*node));
>> +        node->sdev = sdev;
>> +        QLIST_INSERT_HEAD(&s->notifiers_list, node, next);
>> +        return;
>> +    }
>> +
>> +    /* update notifier node with new flags */
>> +    QLIST_FOREACH_SAFE(node, &s->notifiers_list, next, next_node) {
>> +        if (node->sdev == sdev) {
>> +            if (new == IOMMU_NOTIFIER_NONE) {
>> +                trace_smmuv3_notify_flag_del(iommu->parent_obj.name);
>> +                QLIST_REMOVE(node, next);
>> +                g_free(node);
>> +            }
>> +            return;
>> +        }
>>      }
>>  }
>>  
>> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
>> index be69c5d..27b11d6 100644
>> --- a/hw/arm/trace-events
>> +++ b/hw/arm/trace-events
>> @@ -17,6 +17,7 @@ smmu_iotlb_cache_miss(uint16_t asid, uint64_t addr, uint32_t hit, uint32_t miss,
>>  smmu_iotlb_inv_all(void) "IOTLB invalidate all"
>>  smmu_iotlb_inv_asid(uint16_t asid) "IOTLB invalidate asid=%d"
>>  smmu_iotlb_inv_iova(uint16_t asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
>> +smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
>>  
>>  #hw/arm/smmuv3.c
>>  smmuv3_read_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
>> @@ -55,3 +56,7 @@ smmuv3_cmdq_tlbi_nh_vaa(int vmid, uint64_t addr) "vmid =%d addr=0x%"PRIx64
>>  smmuv3_cmdq_tlbi_nh(void) ""
>>  smmuv3_cmdq_tlbi_nh_asid(uint16_t asid) "asid=%d"
>>  smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid %d"
>> +smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
>> +smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
>> +smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint64_t iova) "iommu mr=%s asid=%d iova=0x%"PRIx64
>> +
>> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
>> index d173806..50e2912 100644
>> --- a/include/hw/arm/smmu-common.h
>> +++ b/include/hw/arm/smmu-common.h
>> @@ -160,4 +160,10 @@ void smmu_iotlb_inv_all(SMMUState *s);
>>  void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid);
>>  void smmu_iotlb_inv_iova(SMMUState *s, uint16_t asid, dma_addr_t iova);
>>  
>> +/* Unmap the range of all the notifiers registered to any IOMMU mr */
>> +void smmu_inv_notifiers_all(SMMUState *s);
>> +
>> +/* Unmap the range of all the notifiers registered to @mr */
>> +void smmu_inv_notifiers_mr(IOMMUMemoryRegion *mr);
>> +
>>  #endif  /* HW_ARM_SMMU_COMMON */
>>
> 
