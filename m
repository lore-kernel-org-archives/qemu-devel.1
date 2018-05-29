Received: from eggs.gnu.org ([2001:4830:134:3::10]:60472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaosl1988@163.com>) id 1fNfJk-0005F1-Jo
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaosl1988@163.com>) id 1fNfJj-0000nc-E7
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:09:40 -0400
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
From: Shannon Zhao <zhaosl1988@163.com>
In-Reply-To: <CAFEAcA-LoTOnTnSYBpzuyUDFZBsVBaB2qjvzAP_94rou8ob6Tg@mail.gmail.com>
Date: Tue, 29 May 2018 22:09:22 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <65E224A1-C972-4C38-BD6E-41C59191D999@163.com>
References: <1527563283-13148-1-git-send-email-zhaoshenglong@huawei.com>
	<CAFEAcA-LoTOnTnSYBpzuyUDFZBsVBaB2qjvzAP_94rou8ob6Tg@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhaosl@gmail.com>



> =E5=9C=A8 2018=E5=B9=B45=E6=9C=8829=E6=97=A5=EF=BC=8C21:53=EF=BC=8CPeter M=
aydell <peter.maydell@linaro.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>> On 29 May 2018 at 04:08, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
>> acpi_data_push uses g_array_set_size to resize the memory size. If there
>> is no enough contiguous memory, the address will be changed. So previous
>> pointer could not be used any more. It must update the pointer and use
>> the new one.
>>=20
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
>> ---
>> V2: add comments for iort_node_offset and reviewed tags
>> ---
>> hw/arm/virt-acpi-build.c | 19 +++++++++++++++----
>> 1 file changed, 15 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 92ceee9..6209138 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -400,7 +400,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
>>     AcpiIortItsGroup *its;
>>     AcpiIortTable *iort;
>>     AcpiIortSmmu3 *smmu;
>> -    size_t node_size, iort_length, smmu_offset =3D 0;
>> +    size_t node_size, iort_node_offset, iort_length, smmu_offset =3D 0;
>>     AcpiIortRC *rc;
>>=20
>>     iort =3D acpi_data_push(table_data, sizeof(*iort));
>> @@ -415,6 +415,12 @@ build_iort(GArray *table_data, BIOSLinker *linker, V=
irtMachineState *vms)
>>     iort->node_count =3D cpu_to_le32(nb_nodes);
>>     iort->node_offset =3D cpu_to_le32(sizeof(*iort));
>>=20
>> +    /*
>> +     * Use a copy in case table_data->data moves duringa acpi_data_push
>> +     * operations.
>> +     */
>> +    iort_node_offset =3D sizeof(*iort);
>> +
>>     /* ITS group node */
>>     node_size =3D  sizeof(*its) + sizeof(uint32_t);
>>     iort_length +=3D node_size;
>> @@ -429,7 +435,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
>>         int irq =3D  vms->irqmap[VIRT_SMMU];
>>=20
>>         /* SMMUv3 node */
>> -        smmu_offset =3D iort->node_offset + node_size;
>> +        smmu_offset =3D iort_node_offset + node_size;
>=20
> In the old code, we used iort->node_offset directly as a CPU
> endianness order bitmap, which is initialized above using
>    iort->node_offset =3D cpu_to_le32(sizeof(*iort));
> In this version, we use iort_node_offset, which is
> initialized using
>    iort_node_offset =3D sizeof(*iort);
>=20
> So we've lost an endianness conversion on big-endian systems.
> Which is correct, the old code or the new?
I think it=E2=80=99s the new one. I found this bug later and wanted to send a=
nother patch to fix it. But to address Philippe=E2=80=99s comment I folder t=
hem together.

>=20
>>         node_size =3D sizeof(*smmu) + sizeof(*idmap);
>>         iort_length +=3D node_size;
>>         smmu =3D acpi_data_push(table_data, node_size);
>> @@ -450,7 +456,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
>>         idmap->id_count =3D cpu_to_le32(0xFFFF);
>>         idmap->output_base =3D 0;
>>         /* output IORT node is the ITS group node (the first node) */
>> -        idmap->output_reference =3D cpu_to_le32(iort->node_offset);
>> +        idmap->output_reference =3D cpu_to_le32(iort_node_offset);
>=20
> Here we're doing an endianness conversion on iort_node_offset.
>=20
> Overall something is weird here, even in the previous version:
> if we wrote iort->node_offset with cpu_to_le32(), that implies
> that it's little-endian; so why are we reading it with cpu_to_le32()
> here rather than le32_to_cpu() ?
> Both cpu_to_le32() and le32_to_cpu() are the same operation,
> mathematically, but we should use the version which indicates
> our intent, ie which of source and destination is the always-LE
> data, and which is the host-order data.
>=20
>>     }
>>=20
>>     /* Root Complex Node */
>> @@ -479,9 +485,14 @@ build_iort(GArray *table_data, BIOSLinker *linker, V=
irtMachineState *vms)
>>         idmap->output_reference =3D cpu_to_le32(smmu_offset);
>>     } else {
>>         /* output IORT node is the ITS group node (the first node) */
>> -        idmap->output_reference =3D cpu_to_le32(iort->node_offset);
>> +        idmap->output_reference =3D cpu_to_le32(iort_node_offset);
>>     }
>>=20
>> +    /*
>> +     * Update the pointer address in case table_data->data moves during a=
bove
>> +     * acpi_data_push operations.
>> +     */
>> +    iort =3D (AcpiIortTable *)(table_data->data + iort_start);
>>     iort->length =3D cpu_to_le32(iort_length);
>>=20
>>     build_header(linker, table_data, (void *)(table_data->data + iort_sta=
rt),
>=20
> This could just use 'iort' now, right?
Right, but for consistent as other places I think it=E2=80=99s fine to remai=
n unchanged.=20
>=20
>> --
>=20
> thanks
> -- PMM
