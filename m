Received: from eggs.gnu.org ([2001:4830:134:3::10]:41495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evMsm-0004X1-92
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evMsk-00060W-Qc
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:48:52 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:43459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evMsk-0005zT-JY
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:48:50 -0400
Received: by mail-ot0-x241.google.com with SMTP id m22so15097614otf.10
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 05:48:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1518893216-9983-14-git-send-email-eric.auger@redhat.com>
References: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
	<1518893216-9983-14-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Mar 2018 12:48:29 +0000
Message-ID: <CAFEAcA810AsyBgCJ2vSKcxqRYKGZgJ3RLEqmJt_c5aa9j9t_Kw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v9 13/14] hw/arm/virt-acpi-build: Add
 smmuv3 node in IORT table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

On 17 February 2018 at 18:46, Eric Auger <eric.auger@redhat.com> wrote:
> From: Prem Mallappa <prem.mallappa@broadcom.com>
>
> This patch builds the smmuv3 node in the ACPI IORT table.
>
> The RID space of the root complex, which spans 0x0-0x10000
> maps to streamid space 0x0-0x10000 in smmuv3, which in turn
> maps to deviceid space 0x0-0x10000 in the ITS group.
>
> The guest must feature the IOMMU probe deferral series
> (https://lkml.org/lkml/2017/4/10/214) which fixes streamid
> multiple lookup. This bug is not related to the SMMU emulation.
>
> Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
>
> v2 -> v3:
> - integrate into the existing IORT table made up of ITS, RC nodes
> - take into account vms->smmu
> - match linux actbl2.h acpi_iort_smmu_v3 field names
> ---
>  hw/arm/virt-acpi-build.c    | 56 +++++++++++++++++++++++++++++++++++++++------
>  include/hw/acpi/acpi-defs.h | 15 ++++++++++++
>  2 files changed, 64 insertions(+), 7 deletions(-)

Since ACPI is definitely not my area of expertise, I've cc'd
Shannon on this patch. Shannon, could you take a look at it, please?

> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index f7fa795..4b5ad91 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -393,19 +393,26 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
>  }
>
>  static void
> -build_iort(GArray *table_data, BIOSLinker *linker)
> +build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  {
> -    int iort_start = table_data->len;
> +    int nb_nodes, iort_start = table_data->len;
>      AcpiIortIdMapping *idmap;
>      AcpiIortItsGroup *its;
>      AcpiIortTable *iort;
> -    size_t node_size, iort_length;
> +    AcpiIortSmmu3 *smmu;
> +    size_t node_size, iort_length, smmu_offset = 0;
>      AcpiIortRC *rc;
>
>      iort = acpi_data_push(table_data, sizeof(*iort));
>
> +    if (vms->iommu) {
> +        nb_nodes = 3; /* RC, ITS, SMMUv3 */
> +    } else {
> +        nb_nodes = 2; /* RC, ITS */
> +    }
> +
>      iort_length = sizeof(*iort);
> -    iort->node_count = cpu_to_le32(2); /* RC and ITS nodes */
> +    iort->node_count = cpu_to_le32(nb_nodes);
>      iort->node_offset = cpu_to_le32(sizeof(*iort));
>
>      /* ITS group node */
> @@ -418,6 +425,35 @@ build_iort(GArray *table_data, BIOSLinker *linker)
>      its->its_count = cpu_to_le32(1);
>      its->identifiers[0] = 0; /* MADT translation_id */
>
> +    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
> +        int irq =  vms->irqmap[VIRT_SMMU];
> +
> +        /* SMMUv3 node */
> +        smmu_offset = cpu_to_le32(iort->node_offset + node_size);
> +        node_size = sizeof(*smmu) + sizeof(*idmap);
> +        iort_length += node_size;
> +        smmu = acpi_data_push(table_data, node_size);
> +
> +
> +        smmu->type = ACPI_IORT_NODE_SMMU_V3;
> +        smmu->length = cpu_to_le16(node_size);
> +        smmu->mapping_count = cpu_to_le32(1);
> +        smmu->mapping_offset = cpu_to_le32(sizeof(*smmu));
> +        smmu->base_address = cpu_to_le64(vms->memmap[VIRT_SMMU].base);
> +        smmu->event_gsiv = cpu_to_le32(irq);
> +        smmu->pri_gsiv = cpu_to_le32(irq + 1);
> +        smmu->gerr_gsiv = cpu_to_le32(irq + 2);
> +        smmu->sync_gsiv = cpu_to_le32(irq + 3);
> +
> +        /* Identity RID mapping covering the whole input RID range */
> +        idmap = &smmu->id_mapping_array[0];
> +        idmap->input_base = 0;
> +        idmap->id_count = cpu_to_le32(0xFFFF);
> +        idmap->output_base = 0;
> +        /* output IORT node is the ITS group node (the first node) */
> +        idmap->output_reference = cpu_to_le32(iort->node_offset);
> +    }
> +
>      /* Root Complex Node */
>      node_size = sizeof(*rc) + sizeof(*idmap);
>      iort_length += node_size;
> @@ -438,8 +474,14 @@ build_iort(GArray *table_data, BIOSLinker *linker)
>      idmap->input_base = 0;
>      idmap->id_count = cpu_to_le32(0xFFFF);
>      idmap->output_base = 0;
> -    /* output IORT node is the ITS group node (the first node) */
> -    idmap->output_reference = cpu_to_le32(iort->node_offset);
> +
> +    if (vms->iommu) {
> +        /* output IORT node is the smmuv3 node */
> +        idmap->output_reference = cpu_to_le32(smmu_offset);
> +    } else {
> +        /* output IORT node is the ITS group node (the first node) */
> +        idmap->output_reference = cpu_to_le32(iort->node_offset);
> +    }
>
>      iort->length = cpu_to_le32(iort_length);
>
> @@ -786,7 +828,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>
>      if (its_class_name() && !vmc->no_its) {
>          acpi_add_table(table_offsets, tables_blob);
> -        build_iort(tables_blob, tables->linker);
> +        build_iort(tables_blob, tables->linker, vms);
>      }
>
>      /* XSDT is pointed to by RSDP */
> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> index 80c8099..068ce28 100644
> --- a/include/hw/acpi/acpi-defs.h
> +++ b/include/hw/acpi/acpi-defs.h
> @@ -700,6 +700,21 @@ struct AcpiIortItsGroup {
>  } QEMU_PACKED;
>  typedef struct AcpiIortItsGroup AcpiIortItsGroup;
>
> +struct AcpiIortSmmu3 {
> +    ACPI_IORT_NODE_HEADER_DEF
> +    uint64_t base_address;
> +    uint32_t flags;
> +    uint32_t reserved2;
> +    uint64_t vatos_address;
> +    uint32_t model;
> +    uint32_t event_gsiv;
> +    uint32_t pri_gsiv;
> +    uint32_t gerr_gsiv;
> +    uint32_t sync_gsiv;
> +    AcpiIortIdMapping id_mapping_array[0];
> +} QEMU_PACKED;
> +typedef struct AcpiIortSmmu3 AcpiIortSmmu3;
> +
>  struct AcpiIortRC {
>      ACPI_IORT_NODE_HEADER_DEF
>      AcpiIortMemoryAccess memory_properties;
> --
> 2.5.5
>

thanks
-- PMM
