Received: from eggs.gnu.org ([2001:4830:134:3::10]:33917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fNuku-0000b6-Te
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:38:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fNukt-0008Rc-FL
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:38:44 -0400
References: <1527563283-13148-1-git-send-email-zhaoshenglong@huawei.com>
	<CAFEAcA-LoTOnTnSYBpzuyUDFZBsVBaB2qjvzAP_94rou8ob6Tg@mail.gmail.com>
	<65E224A1-C972-4C38-BD6E-41C59191D999@163.com>
	<383b0c0b-4406-869c-5493-df2f48896113@redhat.com>
	<5B0DFB0C.3000002@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <81226dc7-4b0a-bd1b-6910-0b9a94b0128f@redhat.com>
Date: Wed, 30 May 2018 08:38:34 +0200
MIME-Version: 1.0
In-Reply-To: <5B0DFB0C.3000002@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] ARM: ACPI: Fix use-after-free due to
 memory realloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi Shannon,

On 05/30/2018 03:14 AM, Shannon Zhao wrote:
>=20
>=20
> On 2018/5/30 3:53, Auger Eric wrote:
>> Hi Shannon,
>>
>> On 05/29/2018 04:09 PM, Shannon Zhao wrote:
>>>
>>>
>>>> =E5=9C=A8 2018=E5=B9=B45=E6=9C=8829=E6=97=A5=EF=BC=8C21:53=EF=BC=8CP=
eter Maydell <peter.maydell@linaro.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>>
>>>>> On 29 May 2018 at 04:08, Shannon Zhao <zhaoshenglong@huawei.com> wr=
ote:
>>>>> acpi_data_push uses g_array_set_size to resize the memory size. If =
there
>>>>> is no enough contiguous memory, the address will be changed. So pre=
vious
>>>>> pointer could not be used any more. It must update the pointer and =
use
>>>>> the new one.
>>>>>
>>>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>>> Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
>>>>> ---
>>>>> V2: add comments for iort_node_offset and reviewed tags
>>>>> ---
>>>>> hw/arm/virt-acpi-build.c | 19 +++++++++++++++----
>>>>> 1 file changed, 15 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>>>>> index 92ceee9..6209138 100644
>>>>> --- a/hw/arm/virt-acpi-build.c
>>>>> +++ b/hw/arm/virt-acpi-build.c
>>>>> @@ -400,7 +400,7 @@ build_iort(GArray *table_data, BIOSLinker *link=
er, VirtMachineState *vms)
>>>>>     AcpiIortItsGroup *its;
>>>>>     AcpiIortTable *iort;
>>>>>     AcpiIortSmmu3 *smmu;
>>>>> -    size_t node_size, iort_length, smmu_offset =3D 0;
>>>>> +    size_t node_size, iort_node_offset, iort_length, smmu_offset =3D=
 0;
>>>>>     AcpiIortRC *rc;
>>>>>
>>>>>     iort =3D acpi_data_push(table_data, sizeof(*iort));
>>>>> @@ -415,6 +415,12 @@ build_iort(GArray *table_data, BIOSLinker *lin=
ker, VirtMachineState *vms)
>>>>>     iort->node_count =3D cpu_to_le32(nb_nodes);
>>>>>     iort->node_offset =3D cpu_to_le32(sizeof(*iort));
>>>>>
>>>>> +    /*
>>>>> +     * Use a copy in case table_data->data moves duringa acpi_data=
_push
nit: duringa typo
>>>>> +     * operations.
>>>>> +     */
>>>>> +    iort_node_offset =3D sizeof(*iort);
>>>>> +
>>>>>     /* ITS group node */
>>>>>     node_size =3D  sizeof(*its) + sizeof(uint32_t);
>>>>>     iort_length +=3D node_size;
>>>>> @@ -429,7 +435,7 @@ build_iort(GArray *table_data, BIOSLinker *link=
er, VirtMachineState *vms)
>>>>>         int irq =3D  vms->irqmap[VIRT_SMMU];
>>>>>
>>>>>         /* SMMUv3 node */
>>>>> -        smmu_offset =3D iort->node_offset + node_size;
>>>>> +        smmu_offset =3D iort_node_offset + node_size;
>>>>
>>>> In the old code, we used iort->node_offset directly as a CPU
>>>> endianness order bitmap, which is initialized above using
>>>>    iort->node_offset =3D cpu_to_le32(sizeof(*iort));
>>>> In this version, we use iort_node_offset, which is
>>>> initialized using
>>>>    iort_node_offset =3D sizeof(*iort);
>>>>
>>>> So we've lost an endianness conversion on big-endian systems.
>>>> Which is correct, the old code or the new?
>>> I think it=E2=80=99s the new one. I found this bug later and wanted t=
o send another patch to fix it. But to address Philippe=E2=80=99s comment=
 I folder them together.
>> Shouldn't we have
>> iort_node_offset =3D iort->node_offset;
>> iort->node_offset =3D cpu_to_le32(iort_node_offset);
>> instead?
>>
> Hi Eric,
> Have you read this patch and code carefully?
I checked against the v1 in my branch thinking you did not change
anything besides the comment (your log history?).

>=20
> I think you mean
> iort_node_offset =3D sizeof(*iort);
Yes sorry wrong copy/paste
> iort->node_offset =3D cpu_to_le32(iort_node_offset);
>=20
> Right? If so it's almost same with what I write. I just use sizeof twic=
e.
>=20
> iort->node_offset =3D cpu_to_le32(sizeof(*iort));
> iort_node_offset =3D sizeof(*iort);
>=20
>> Otherwise subsequent computations are done with the node_offset alread=
y
>> converted to le32 whereas the cpu mode may be "be"?
>>
> What I did here is to avoid the case you mentioned.
> The iort_node_offset is host order, right? And I use iort_node_offset
> instead of iort->node_offset for subsequent computations not the le32
> one. So smmu_offset =3D iort_node_offset + node_size; will get the righ=
t
> value as well as below ones.
OK checking again v2, this looks OK to me.

Thanks

Eric
>=20
> Thanks,
>=20
>> Shouldn't conversions to le32 being done at the last stage when
>> populating the structs?
>>
>> May be worth splitting this into 2 patches then or at least mentioning
>> this other fix in the commit message?
>>
>> Thanks
>>
>> Eric
>>
>>>
>>>>
>>>>>         node_size =3D sizeof(*smmu) + sizeof(*idmap);
>>>>>         iort_length +=3D node_size;
>>>>>         smmu =3D acpi_data_push(table_data, node_size);
>>>>> @@ -450,7 +456,7 @@ build_iort(GArray *table_data, BIOSLinker *link=
er, VirtMachineState *vms)
>>>>>         idmap->id_count =3D cpu_to_le32(0xFFFF);
>>>>>         idmap->output_base =3D 0;
>>>>>         /* output IORT node is the ITS group node (the first node) =
*/
>>>>> -        idmap->output_reference =3D cpu_to_le32(iort->node_offset)=
;
>>>>> +        idmap->output_reference =3D cpu_to_le32(iort_node_offset);
>>>>
>>>> Here we're doing an endianness conversion on iort_node_offset.
>>>>
>>>> Overall something is weird here, even in the previous version:
>>>> if we wrote iort->node_offset with cpu_to_le32(), that implies
>>>> that it's little-endian; so why are we reading it with cpu_to_le32()
>>>> here rather than le32_to_cpu() ?
>>>> Both cpu_to_le32() and le32_to_cpu() are the same operation,
>>>> mathematically, but we should use the version which indicates
>>>> our intent, ie which of source and destination is the always-LE
>>>> data, and which is the host-order data.
>>>>
>>>>>     }
>>>>>
>>>>>     /* Root Complex Node */
>>>>> @@ -479,9 +485,14 @@ build_iort(GArray *table_data, BIOSLinker *lin=
ker, VirtMachineState *vms)
>>>>>         idmap->output_reference =3D cpu_to_le32(smmu_offset);
>>>>>     } else {
>>>>>         /* output IORT node is the ITS group node (the first node) =
*/
>>>>> -        idmap->output_reference =3D cpu_to_le32(iort->node_offset)=
;
>>>>> +        idmap->output_reference =3D cpu_to_le32(iort_node_offset);
>>>>>     }
>>>>>
>>>>> +    /*
>>>>> +     * Update the pointer address in case table_data->data moves d=
uring above
>>>>> +     * acpi_data_push operations.
>>>>> +     */
>>>>> +    iort =3D (AcpiIortTable *)(table_data->data + iort_start);
>>>>>     iort->length =3D cpu_to_le32(iort_length);
>>>>>
>>>>>     build_header(linker, table_data, (void *)(table_data->data + io=
rt_start),
>>>>
>>>> This could just use 'iort' now, right?
>>> Right, but for consistent as other places I think it=E2=80=99s fine t=
o remain unchanged.=20
>>>>
>>>>> --
>>>>
>>>> thanks
>>>> -- PMM
>>>
>>>
>>
>> .
>>
>=20
