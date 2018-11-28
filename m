Received: from eggs.gnu.org ([2001:4830:134:3::10]:35330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gS3bv-000095-Lr
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:26:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gS3br-00010I-52
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:26:51 -0500
References: <20181126154616.18173-1-eric.auger@redhat.com>
	<b3c22264-2a95-b851-025c-b8ff0f38f269@redhat.com>
	<65b68704-2c0b-e9b9-2cde-fea5c32161b3@gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <a6e27638-1695-9608-366a-83bbbe873e55@redhat.com>
Date: Wed, 28 Nov 2018 18:26:33 +0100
MIME-Version: 1.0
In-Reply-To: <65b68704-2c0b-e9b9-2cde-fea5c32161b3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Shannon Zhao <shannon.zhaosl@gmail.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: shameerali.kolothum.thodi@huawei.com

Hi Shannon,

On 11/28/18 5:39 PM, Shannon Zhao wrote:
>=20
>=20
> On 2018/11/27 13:53, Auger Eric wrote:
>> Hi Shannon,
>>
>> On 11/26/18 4:46 PM, Eric Auger wrote:
>>> The AcpiIortSmmu3 misses 2 32b fields corresponding to the
>>> proximity domain and the device id mapping index.
>> I fail to understand how we currently track the evolutions of the IORT
>> structures:
>>
>> Looking at the smmuv3 node in kernel include/acpi/actbl2.h
>>
>> - the following fields were added in c944230064eb=C2=A0 ACPICA: iasl: =
Update
>> to IORT SMMUv3 disassembling (1 year, 4 months ago)
>> =C2=A0=C2=A0=C2=A0=C2=A0u8 pxm;
>> =C2=A0=C2=A0=C2=A0=C2=A0u8 reserved1;
>> =C2=A0=C2=A0=C2=A0=C2=A0u16 reserved2;
>> - id_mapping_index was added in 4c106aa411ee=C2=A0 ACPICA: iasl: Add S=
MMUv3
>> device ID mapping index support (1 year ago)
>> - current u32 pxm was introduced in d87be0438e3d=C2=A0 ACPICA: IORT: U=
pdate
>> for revision D (6 months ago)
>>
>> I would have expected each of those evolutions to be tagged by a
>> revision increment in the acpi_iort_node.revision field but this is no=
t
>> done. Also I fail to see any enum for encoding the revision.
>>
>> The smmuv3 struct that has been exposed until now corresponds to Rev C
>> https://lists.linuxfoundation.org/pipermail/iommu/2017-May/022000.html
>> (0c2021c047ba=C2=A0 ACPICA: IORT: Update SMMU models for revision C (1=
 year,
>> 4 months ago)
>>
>> Also I noticed that in rev D, new fields were added in struct
>> acpi_iort_root_complex. We miss them at the moment in the IORT
>> description.
>>
>> How does the guest kernel know which revision of the IORT is exposed?
>> What do I miss?
>>
> Look at the kernel code in iort.c it checks if the flags field has set
> ACPI_IORT_SMMU_V3_PXM_VALID bit.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0if (smmu->flags & ACPI_IORT_SMMU_V3_PXM_VALID) =
{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_dev_node(dev, acpi_map_p=
xm_to_node(smmu->pxm));
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_info("SMMU-v3[%llx] Mappe=
d to Proximity domain %d\n",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smmu=
->base_address,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smmu=
->pxm);
> =C2=A0=C2=A0=C2=A0=C2=A0}
>=20
> But it doesn't check the revision I think the reason is that revision 1
> & 2 just use the next reserved fields. No matter u8 or u32, kernel
> driver get the same value.
>=20
> The code handling id_mapping_index does check the revision.
>=20
> static int iort_get_id_mapping_index(struct acpi_iort_node *node)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0struct acpi_iort_smmu_v3 *smmu;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0switch (node->type) {
> =C2=A0=C2=A0=C2=A0=C2=A0case ACPI_IORT_NODE_SMMU_V3:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * SMMUv3 dev ID mappin=
g index was introduced in revision 1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * table, not available=
 in revision 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (node->revision < 1)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn -EINVAL;
>=20
>> Thanks
>>
>> Eric
>>
>>>
>>> Also let's report IO-coherent access is supported for
>>> translation table walks, descriptor fetches and queues by
>>> setting the COHACC override flag. Without that, we observe
>>> wrong command opcodes. The DT description also advertises
>>> the dma coherency.
>>>
>>> Fixes a703b4f6c1ee ("hw/arm/virt-acpi-build: Add smmuv3 node in IORT
>>> table")
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> Reported-by: Shameerali Kolothum Thodi
>>> <shameerali.kolothum.thodi@huawei.com>
>>> ---
>>> =C2=A0 hw/arm/virt-acpi-build.c=C2=A0=C2=A0=C2=A0 | 1 +
>>> =C2=A0 include/hw/acpi/acpi-defs.h | 8 ++++++++
>>> =C2=A0 2 files changed, 9 insertions(+)
>>>
>>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>>> index 5785fb697c..aa177ba64d 100644
>>> --- a/hw/arm/virt-acpi-build.c
>>> +++ b/hw/arm/virt-acpi-build.c
>>> @@ -448,6 +448,7 @@ build_iort(GArray *table_data, BIOSLinker
>>> *linker, VirtMachineState *vms)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smmu->mapping_=
count =3D cpu_to_le32(1);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smmu->mapping_=
offset =3D cpu_to_le32(sizeof(*smmu));
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smmu->base_add=
ress =3D cpu_to_le64(vms->memmap[VIRT_SMMU].base);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smmu->flags =3D ACPI_IORT=
_SMMU_V3_COHACC_OVERRIDE;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smmu->event_gs=
iv =3D cpu_to_le32(irq);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smmu->pri_gsiv=
 =3D cpu_to_le32(irq + 1);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smmu->gerr_gsi=
v =3D cpu_to_le32(irq + 2);
>>> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.=
h
>>> index af8e023968..c3ee1f517b 100644
>>> --- a/include/hw/acpi/acpi-defs.h
>>> +++ b/include/hw/acpi/acpi-defs.h
>>> @@ -628,6 +628,12 @@ struct AcpiIortItsGroup {
>>> =C2=A0 } QEMU_PACKED;
>>> =C2=A0 typedef struct AcpiIortItsGroup AcpiIortItsGroup;
>>> =C2=A0 +enum {
>>> +=C2=A0=C2=A0=C2=A0 ACPI_IORT_SMMU_V3_COHACC_OVERRIDE =3D 1 << 0,
>>> +=C2=A0=C2=A0=C2=A0 ACPI_IORT_SMMU_V3_HTTU_OVERRIDE=C2=A0=C2=A0 =3D 3=
 << 1,
>>> +=C2=A0=C2=A0=C2=A0 ACPI_IORT_SMMU_V3_PXM_VALID=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D 1 << 3
>>> +};
>>> +
>>> =C2=A0 struct AcpiIortSmmu3 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ACPI_IORT_NODE_HEADER_DEF
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t base_address;
>>> @@ -639,6 +645,8 @@ struct AcpiIortSmmu3 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t pri_gsiv;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t gerr_gsiv;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t sync_gsiv;
>>> +=C2=A0=C2=A0=C2=A0 uint32_t pxm;
> So if we use this field ,we need to set the flags with
> ACPI_IORT_SMMU_V3_PXM_VALID
>>> +=C2=A0=C2=A0=C2=A0 uint32_t id_mapping_index;
> And if we use this field, it needs to set the revision to at least 1.
But is it harmful to add those fields in the struct as this patch does?

- in our case ACPI_IORT_SMMU_V3_PXM_VALID flag is not set so the field
value is ignored according to the spec and arm_smmu_v3_set_proximity()
will not do anything.

- SMMU control interrupts are all GSIV based so spec says that deviceID
index is ignored.

So eventually the fact the struct size is changing over the revisions
does not look a problem because the node length is part of the struct
and the offset to the ID array also is part of the structure.

So I could have left the structure as before (because we don't use the
functionalities associated to those fields). But on the other hand it's
good to upgrade the struct according to Rev D now.

So I think the patch is correct, isn't?

Thanks

Eric
>=20
> Thanks,
> Shannon
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AcpiIortIdMapping id_mapping_array[0];
>>> =C2=A0 } QEMU_PACKED;
>>> =C2=A0 typedef struct AcpiIortSmmu3 AcpiIortSmmu3;
>>>
