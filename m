Received: from eggs.gnu.org ([2001:4830:134:3::10]:57535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNf4g-0000yU-Is
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNf4f-000832-Fy
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:54:06 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:37745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fNf4f-00081y-1t
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:54:05 -0400
Received: by mail-ot0-x242.google.com with SMTP id 77-v6so17014592otd.4
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 06:54:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1527563283-13148-1-git-send-email-zhaoshenglong@huawei.com>
References: <1527563283-13148-1-git-send-email-zhaoshenglong@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 May 2018 14:53:43 +0100
Message-ID: <CAFEAcA-LoTOnTnSYBpzuyUDFZBsVBaB2qjvzAP_94rou8ob6Tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhaosl@gmail.com>

On 29 May 2018 at 04:08, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> acpi_data_push uses g_array_set_size to resize the memory size. If there
> is no enough contiguous memory, the address will be changed. So previous
> pointer could not be used any more. It must update the pointer and use
> the new one.
>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
> ---
> V2: add comments for iort_node_offset and reviewed tags
> ---
>  hw/arm/virt-acpi-build.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 92ceee9..6209138 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -400,7 +400,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
>      AcpiIortItsGroup *its;
>      AcpiIortTable *iort;
>      AcpiIortSmmu3 *smmu;
> -    size_t node_size, iort_length, smmu_offset =3D 0;
> +    size_t node_size, iort_node_offset, iort_length, smmu_offset =3D 0;
>      AcpiIortRC *rc;
>
>      iort =3D acpi_data_push(table_data, sizeof(*iort));
> @@ -415,6 +415,12 @@ build_iort(GArray *table_data, BIOSLinker *linker, V=
irtMachineState *vms)
>      iort->node_count =3D cpu_to_le32(nb_nodes);
>      iort->node_offset =3D cpu_to_le32(sizeof(*iort));
>
> +    /*
> +     * Use a copy in case table_data->data moves duringa acpi_data_push
> +     * operations.
> +     */
> +    iort_node_offset =3D sizeof(*iort);
> +
>      /* ITS group node */
>      node_size =3D  sizeof(*its) + sizeof(uint32_t);
>      iort_length +=3D node_size;
> @@ -429,7 +435,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
>          int irq =3D  vms->irqmap[VIRT_SMMU];
>
>          /* SMMUv3 node */
> -        smmu_offset =3D iort->node_offset + node_size;
> +        smmu_offset =3D iort_node_offset + node_size;

In the old code, we used iort->node_offset directly as a CPU
endianness order bitmap, which is initialized above using
    iort->node_offset =3D cpu_to_le32(sizeof(*iort));
In this version, we use iort_node_offset, which is
initialized using
    iort_node_offset =3D sizeof(*iort);

So we've lost an endianness conversion on big-endian systems.
Which is correct, the old code or the new?

>          node_size =3D sizeof(*smmu) + sizeof(*idmap);
>          iort_length +=3D node_size;
>          smmu =3D acpi_data_push(table_data, node_size);
> @@ -450,7 +456,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
>          idmap->id_count =3D cpu_to_le32(0xFFFF);
>          idmap->output_base =3D 0;
>          /* output IORT node is the ITS group node (the first node) */
> -        idmap->output_reference =3D cpu_to_le32(iort->node_offset);
> +        idmap->output_reference =3D cpu_to_le32(iort_node_offset);

Here we're doing an endianness conversion on iort_node_offset.

Overall something is weird here, even in the previous version:
if we wrote iort->node_offset with cpu_to_le32(), that implies
that it's little-endian; so why are we reading it with cpu_to_le32()
here rather than le32_to_cpu() ?
Both cpu_to_le32() and le32_to_cpu() are the same operation,
mathematically, but we should use the version which indicates
our intent, ie which of source and destination is the always-LE
data, and which is the host-order data.

>      }
>
>      /* Root Complex Node */
> @@ -479,9 +485,14 @@ build_iort(GArray *table_data, BIOSLinker *linker, V=
irtMachineState *vms)
>          idmap->output_reference =3D cpu_to_le32(smmu_offset);
>      } else {
>          /* output IORT node is the ITS group node (the first node) */
> -        idmap->output_reference =3D cpu_to_le32(iort->node_offset);
> +        idmap->output_reference =3D cpu_to_le32(iort_node_offset);
>      }
>
> +    /*
> +     * Update the pointer address in case table_data->data moves during =
above
> +     * acpi_data_push operations.
> +     */
> +    iort =3D (AcpiIortTable *)(table_data->data + iort_start);
>      iort->length =3D cpu_to_le32(iort_length);
>
>      build_header(linker, table_data, (void *)(table_data->data + iort_st=
art),

This could just use 'iort' now, right?

> --

thanks
-- PMM
