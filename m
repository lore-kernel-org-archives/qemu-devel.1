Received: from eggs.gnu.org ([2001:4830:134:3::10]:44083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fKjNG-000718-Pu
	for qemu-devel@nongnu.org; Mon, 21 May 2018 07:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fKjNB-0005QJ-Uk
	for qemu-devel@nongnu.org; Mon, 21 May 2018 07:53:10 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:36008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fKjNB-0005Q3-Kn
	for qemu-devel@nongnu.org; Mon, 21 May 2018 07:53:05 -0400
Received: by mail-wr0-x243.google.com with SMTP id k5-v6so3628653wrn.3
	for <qemu-devel@nongnu.org>; Mon, 21 May 2018 04:53:05 -0700 (PDT)
References: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
	<1526801333-30613-4-git-send-email-whois.zihan.yang@gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <ef3fc85d-7726-c888-e8ca-9dfae1b908d3@gmail.com>
Date: Mon, 21 May 2018 14:53:01 +0300
MIME-Version: 1.0
In-Reply-To: <1526801333-30613-4-git-send-email-whois.zihan.yang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC 3/3] acpi-build: allocate mcfg for multiple
 host bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zihan Yang <whois.zihan.yang@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>



On 05/20/2018 10:28 AM, Zihan Yang wrote:
> Currently only q35 host bridge us allocated space in MCFG table. To put pxb host
> into sepratate pci domain, each of them should have its own configuration space
> int MCFG table
>
> Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
> ---
>   hw/i386/acpi-build.c | 83 +++++++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 62 insertions(+), 21 deletions(-)
>
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 9bc6d97..808d815 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -89,6 +89,7 @@
>   typedef struct AcpiMcfgInfo {
>       uint64_t mcfg_base;
>       uint32_t mcfg_size;
> +    struct AcpiMcfgInfo *next;
>   } AcpiMcfgInfo;
>   
>   typedef struct AcpiPmInfo {
> @@ -2427,14 +2428,15 @@ build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>   {
>       AcpiTableMcfg *mcfg;
>       const char *sig;
> -    int len = sizeof(*mcfg) + 1 * sizeof(mcfg->allocation[0]);
> +    int len, count = 0;
> +    AcpiMcfgInfo *cfg = info;
>   
> +    while (cfg) {
> +        ++count;
> +        cfg = cfg->next;
> +    }
> +    len = sizeof(*mcfg) + count * sizeof(mcfg->allocation[0]);
>       mcfg = acpi_data_push(table_data, len);
> -    mcfg->allocation[0].address = cpu_to_le64(info->mcfg_base);
> -    /* Only a single allocation so no need to play with segments */
> -    mcfg->allocation[0].pci_segment = cpu_to_le16(0);
> -    mcfg->allocation[0].start_bus_number = 0;
> -    mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->mcfg_size - 1);
>   
>       /* MCFG is used for ECAM which can be enabled or disabled by guest.
>        * To avoid table size changes (which create migration issues),
> @@ -2448,6 +2450,17 @@ build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>       } else {
>           sig = "MCFG";
>       }
> +
> +    count = 0;
> +    while (info) {
> +        mcfg[count].allocation[0].address = cpu_to_le64(info->mcfg_base);
> +        /* Only a single allocation so no need to play with segments */
> +        mcfg[count].allocation[0].pci_segment = cpu_to_le16(count);
> +        mcfg[count].allocation[0].start_bus_number = 0;
> +        mcfg[count++].allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->mcfg_size - 1);

An interesting point is if we want to limit the MMFCG size for PXBs, as 
we may not be
interested to use all the buses in a specific domain. For each bus we 
require some
address space that remains unused.

> +        info = info->next;
> +    }
> +
>       build_header(linker, table_data, (void *)mcfg, sig, len, 1, NULL, NULL);
>   }
>   
> @@ -2602,26 +2615,52 @@ struct AcpiBuildState {
>       MemoryRegion *linker_mr;
>   } AcpiBuildState;
>   
> -static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
> +static inline void cleanup_mcfg(AcpiMcfgInfo *mcfg)
> +{
> +    AcpiMcfgInfo *tmp;
> +    while (mcfg) {
> +        tmp = mcfg->next;
> +        g_free(mcfg);
> +        mcfg = tmp;
> +    }
> +}
> +
> +static AcpiMcfgInfo *acpi_get_mcfg(void)
>   {
>       Object *pci_host;
>       QObject *o;
> +    AcpiMcfgInfo *head = NULL, *tail, *mcfg;
>   
>       pci_host = acpi_get_i386_pci_host();
>       g_assert(pci_host);
>   
> -    o = object_property_get_qobject(pci_host, PCIE_HOST_MCFG_BASE, NULL);
> -    if (!o) {
> -        return false;
> +    while (pci_host) {
> +        mcfg = g_new0(AcpiMcfgInfo, 1);
> +        mcfg->next = NULL;
> +        if (!head) {
> +            tail = head = mcfg;
> +        } else {
> +            tail->next = mcfg;
> +            tail = mcfg;
> +        }
> +
> +        o = object_property_get_qobject(pci_host, PCIE_HOST_MCFG_BASE, NULL);
> +        if (!o) {
> +            cleanup_mcfg(head);
> +            g_free(mcfg);
> +            return NULL;
> +        }
> +        mcfg->mcfg_base = qnum_get_uint(qobject_to(QNum, o));
> +        qobject_unref(o);
> +
> +        o = object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NULL);

I'll let Igor to comment on the APCI bits, but the idea of querying each 
PCI host
for the MMFCG details and put it into a different table sounds good to me.

[Adding Laszlo for his insights]
Looking forward to see the SeaBIOS patches :)

Thanks!
Marcel

> +        assert(o);
> +        mcfg->mcfg_size = qnum_get_uint(qobject_to(QNum, o));
> +        qobject_unref(o);
> +
> +        pci_host = OBJECT(QTAILQ_NEXT(PCI_HOST_BRIDGE(pci_host), next));
>       }
> -    mcfg->mcfg_base = qnum_get_uint(qobject_to(QNum, o));
> -    qobject_unref(o);
> -
> -    o = object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NULL);
> -    assert(o);
> -    mcfg->mcfg_size = qnum_get_uint(qobject_to(QNum, o));
> -    qobject_unref(o);
> -    return true;
> +    return head;
>   }
>   
>   static
> @@ -2633,7 +2672,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>       unsigned facs, dsdt, rsdt, fadt;
>       AcpiPmInfo pm;
>       AcpiMiscInfo misc;
> -    AcpiMcfgInfo mcfg;
> +    AcpiMcfgInfo *mcfg;
>       Range pci_hole, pci_hole64;
>       uint8_t *u;
>       size_t aml_len = 0;
> @@ -2714,10 +2753,12 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>               build_slit(tables_blob, tables->linker);
>           }
>       }
> -    if (acpi_get_mcfg(&mcfg)) {
> +    if ((mcfg = acpi_get_mcfg()) != NULL) {
>           acpi_add_table(table_offsets, tables_blob);
> -        build_mcfg_q35(tables_blob, tables->linker, &mcfg);
> +        build_mcfg_q35(tables_blob, tables->linker, mcfg);
>       }
> +    cleanup_mcfg(mcfg);
> +
>       if (x86_iommu_get_default()) {
>           IommuType IOMMUType = x86_iommu_get_type();
>           if (IOMMUType == TYPE_AMD) {
