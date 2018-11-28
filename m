Received: from eggs.gnu.org ([2001:4830:134:3::10]:37472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shannon.zhaosl@gmail.com>) id 1gS2uL-00060y-3d
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:41:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shannon.zhaosl@gmail.com>) id 1gS2u6-0001vM-Ca
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:41:35 -0500
References: <20181126154616.18173-1-eric.auger@redhat.com>
	<b3c22264-2a95-b851-025c-b8ff0f38f269@redhat.com>
From: Shannon Zhao <shannon.zhaosl@gmail.com>
Message-ID: <65b68704-2c0b-e9b9-2cde-fea5c32161b3@gmail.com>
Date: Thu, 29 Nov 2018 00:39:58 +0800
MIME-Version: 1.0
In-Reply-To: <b3c22264-2a95-b851-025c-b8ff0f38f269@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1] hw/arm/virt-acpi-build: Fix SMMUv3
 ACPI integration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: shameerali.kolothum.thodi@huawei.com



On 2018/11/27 13:53, Auger Eric wrote:
> Hi Shannon,
> 
> On 11/26/18 4:46 PM, Eric Auger wrote:
>> The AcpiIortSmmu3 misses 2 32b fields corresponding to the
>> proximity domain and the device id mapping index.
> I fail to understand how we currently track the evolutions of the IORT
> structures:
> 
> Looking at the smmuv3 node in kernel include/acpi/actbl2.h
> 
> - the following fields were added in c944230064eb  ACPICA: iasl: Update
> to IORT SMMUv3 disassembling (1 year, 4 months ago)
> 	u8 pxm;
> 	u8 reserved1;
> 	u16 reserved2;
> - id_mapping_index was added in 4c106aa411ee  ACPICA: iasl: Add SMMUv3
> device ID mapping index support (1 year ago)
> - current u32 pxm was introduced in d87be0438e3d  ACPICA: IORT: Update
> for revision D (6 months ago)
> 
> I would have expected each of those evolutions to be tagged by a
> revision increment in the acpi_iort_node.revision field but this is not
> done. Also I fail to see any enum for encoding the revision.
> 
> The smmuv3 struct that has been exposed until now corresponds to Rev C
> https://lists.linuxfoundation.org/pipermail/iommu/2017-May/022000.html
> (0c2021c047ba  ACPICA: IORT: Update SMMU models for revision C (1 year,
> 4 months ago)
> 
> Also I noticed that in rev D, new fields were added in struct
> acpi_iort_root_complex. We miss them at the moment in the IORT description.
> 
> How does the guest kernel know which revision of the IORT is exposed?
> What do I miss?
> 
Look at the kernel code in iort.c it checks if the flags field has set 
ACPI_IORT_SMMU_V3_PXM_VALID bit.

	if (smmu->flags & ACPI_IORT_SMMU_V3_PXM_VALID) {
		set_dev_node(dev, acpi_map_pxm_to_node(smmu->pxm));
		pr_info("SMMU-v3[%llx] Mapped to Proximity domain %d\n",
			smmu->base_address,
			smmu->pxm);
	}

But it doesn't check the revision I think the reason is that revision 1 
& 2 just use the next reserved fields. No matter u8 or u32, kernel 
driver get the same value.

The code handling id_mapping_index does check the revision.

static int iort_get_id_mapping_index(struct acpi_iort_node *node)
{
	struct acpi_iort_smmu_v3 *smmu;

	switch (node->type) {
	case ACPI_IORT_NODE_SMMU_V3:
		/*
		 * SMMUv3 dev ID mapping index was introduced in revision 1
		 * table, not available in revision 0
		 */
		if (node->revision < 1)
			return -EINVAL;

> Thanks
> 
> Eric
> 
>>
>> Also let's report IO-coherent access is supported for
>> translation table walks, descriptor fetches and queues by
>> setting the COHACC override flag. Without that, we observe
>> wrong command opcodes. The DT description also advertises
>> the dma coherency.
>>
>> Fixes a703b4f6c1ee ("hw/arm/virt-acpi-build: Add smmuv3 node in IORT table")
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reported-by: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>> ---
>>   hw/arm/virt-acpi-build.c    | 1 +
>>   include/hw/acpi/acpi-defs.h | 8 ++++++++
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 5785fb697c..aa177ba64d 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -448,6 +448,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>           smmu->mapping_count = cpu_to_le32(1);
>>           smmu->mapping_offset = cpu_to_le32(sizeof(*smmu));
>>           smmu->base_address = cpu_to_le64(vms->memmap[VIRT_SMMU].base);
>> +        smmu->flags = ACPI_IORT_SMMU_V3_COHACC_OVERRIDE;
>>           smmu->event_gsiv = cpu_to_le32(irq);
>>           smmu->pri_gsiv = cpu_to_le32(irq + 1);
>>           smmu->gerr_gsiv = cpu_to_le32(irq + 2);
>> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
>> index af8e023968..c3ee1f517b 100644
>> --- a/include/hw/acpi/acpi-defs.h
>> +++ b/include/hw/acpi/acpi-defs.h
>> @@ -628,6 +628,12 @@ struct AcpiIortItsGroup {
>>   } QEMU_PACKED;
>>   typedef struct AcpiIortItsGroup AcpiIortItsGroup;
>>   
>> +enum {
>> +    ACPI_IORT_SMMU_V3_COHACC_OVERRIDE = 1 << 0,
>> +    ACPI_IORT_SMMU_V3_HTTU_OVERRIDE   = 3 << 1,
>> +    ACPI_IORT_SMMU_V3_PXM_VALID       = 1 << 3
>> +};
>> +
>>   struct AcpiIortSmmu3 {
>>       ACPI_IORT_NODE_HEADER_DEF
>>       uint64_t base_address;
>> @@ -639,6 +645,8 @@ struct AcpiIortSmmu3 {
>>       uint32_t pri_gsiv;
>>       uint32_t gerr_gsiv;
>>       uint32_t sync_gsiv;
>> +    uint32_t pxm;
So if we use this field ,we need to set the flags with 
ACPI_IORT_SMMU_V3_PXM_VALID.
>> +    uint32_t id_mapping_index;
And if we use this field, it needs to set the revision to at least 1.

Thanks,
Shannon
>>       AcpiIortIdMapping id_mapping_array[0];
>>   } QEMU_PACKED;
>>   typedef struct AcpiIortSmmu3 AcpiIortSmmu3;
>>
