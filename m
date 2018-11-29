Received: from eggs.gnu.org ([2001:4830:134:3::10]:46960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shannon.zhaosl@gmail.com>) id 1gSC0p-0007gq-LC
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 21:25:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shannon.zhaosl@gmail.com>) id 1gSC0k-0006pF-2A
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 21:25:07 -0500
References: <20181126154616.18173-1-eric.auger@redhat.com>
	<b3c22264-2a95-b851-025c-b8ff0f38f269@redhat.com>
	<65b68704-2c0b-e9b9-2cde-fea5c32161b3@gmail.com>
	<a6e27638-1695-9608-366a-83bbbe873e55@redhat.com>
From: Shannon Zhao <shannon.zhaosl@gmail.com>
Message-ID: <2c6469e1-4da1-7f9d-4525-892287c4c5c1@gmail.com>
Date: Thu, 29 Nov 2018 10:24:50 +0800
MIME-Version: 1.0
In-Reply-To: <a6e27638-1695-9608-366a-83bbbe873e55@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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



On 2018/11/29 1:26, Auger Eric wrote:
>>>>    struct AcpiIortSmmu3 {
>>>>        ACPI_IORT_NODE_HEADER_DEF
>>>>        uint64_t base_address;
>>>> @@ -639,6 +645,8 @@ struct AcpiIortSmmu3 {
>>>>        uint32_t pri_gsiv;
>>>>        uint32_t gerr_gsiv;
>>>>        uint32_t sync_gsiv;
>>>> +    uint32_t pxm;
>> So if we use this field ,we need to set the flags with
>> ACPI_IORT_SMMU_V3_PXM_VALID
>>>> +    uint32_t id_mapping_index;
>> And if we use this field, it needs to set the revision to at least 1.
> But is it harmful to add those fields in the struct as this patch does?
> 
> - in our case ACPI_IORT_SMMU_V3_PXM_VALID flag is not set so the field
> value is ignored according to the spec and arm_smmu_v3_set_proximity()
> will not do anything.
> 
> - SMMU control interrupts are all GSIV based so spec says that deviceID
> index is ignored.
> 
> So eventually the fact the struct size is changing over the revisions
> does not look a problem because the node length is part of the struct
> and the offset to the ID array also is part of the structure.
> 
> So I could have left the structure as before (because we don't use the
> functionalities associated to those fields). But on the other hand it's
> good to upgrade the struct according to Rev D now.
> 
> So I think the patch is correct, isn't?
Yes, I think it's not harmful but it would be better to add some 
comments to explain why we don't increase the revision number ATM.

Thanks,
Shannon
