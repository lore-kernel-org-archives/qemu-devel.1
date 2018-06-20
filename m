Received: from eggs.gnu.org ([2001:4830:134:3::10]:54078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fVXpF-0004ij-Ju
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fVXpC-00089A-Ct
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:46:45 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:45127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fVXpC-00087c-0X
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:46:42 -0400
Received: by mail-wr0-x22c.google.com with SMTP id o12-v6so2156494wrm.12
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 00:46:41 -0700 (PDT)
References: <1528794804-6289-1-git-send-email-whois.zihan.yang@gmail.com>
	<1528794804-6289-3-git-send-email-whois.zihan.yang@gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <60e47271-dca6-2c7e-0a22-60b222051dad@gmail.com>
Date: Wed, 20 Jun 2018 10:46:37 +0300
MIME-Version: 1.0
In-Reply-To: <1528794804-6289-3-git-send-email-whois.zihan.yang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC v2 3/3] acpi-build: describe new pci domain
 in AML
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zihan Yang <whois.zihan.yang@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>



On 06/12/2018 12:13 PM, Zihan Yang wrote:
> Describe new pci segments of host bridges in AML. The host bridge list is
> replaced by QTAILQ to let q35 host be processed first in every traverse
>
> Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
> ---
>   hw/i386/acpi-build.c      | 69 ++++++++++++++++++++++++++++++-----------------
>   hw/pci/pci.c              |  9 ++++---
>   include/hw/pci/pci_host.h |  2 +-
>   3 files changed, 50 insertions(+), 30 deletions(-)
>
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 104e52d..a9f1503 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2123,36 +2123,55 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>       sb_scope = aml_scope("\\_SB");
>       {
>           Object *pci_host;
> +        QObject *o;
>           PCIBus *bus = NULL;
> +        uint32_t domain_nr;
> +        bool q35host = true;
>   
>           pci_host = acpi_get_i386_pci_host();
> -        if (pci_host) {
> +        while (pci_host) {
> +            o = object_property_get_qobject(pci_host, "domain_nr", NULL);
> +            assert(o);
> +            domain_nr = qnum_get_uint(qobject_to(QNum, o));
> +            qobject_unref(o);
> +
> +            /* skip expander bridges that still reside in domain 0 */
> +            if (!q35host && domain_nr == 0) {
> +                pci_host = OBJECT(QTAILQ_NEXT(PCI_HOST_BRIDGE(pci_host), next));

Why do you skip pci_hosts without domain? We still want to add them to 
the DSDT, right ?

> +                continue;
> +            }
>               bus = PCI_HOST_BRIDGE(pci_host)->bus;
> -        }
>   
> -        if (bus) {
> -            Aml *scope = aml_scope("PCI0");
> -            /* Scan all PCI buses. Generate tables to support hotplug. */
> -            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
> +            if (bus) {
> +                Aml *scope = aml_scope("PCI0");
> +                aml_append(scope, aml_name_decl("_SEG", aml_int(domain_nr)));
> +                /* For simplicity, base bus number starts from 0 */
> +                aml_append(scope, aml_name_decl("_BBN", aml_int(0)));

Nice. _SEG and _BBN should be enough to let the guest know we have multiple
PCI domains.

> +                /* Scan all PCI buses. Generate tables to support hotplug. */
> +                build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
>   
> -            if (TPM_IS_TIS(tpm_find())) {
> -                dev = aml_device("ISA.TPM");
> -                aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C31")));
> -                aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
> -                crs = aml_resource_template();
> -                aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
> -                           TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
> -                /*
> -                    FIXME: TPM_TIS_IRQ=5 conflicts with PNP0C0F irqs,
> -                    Rewrite to take IRQ from TPM device model and
> -                    fix default IRQ value there to use some unused IRQ
> -                 */
> -                /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
> -                aml_append(dev, aml_name_decl("_CRS", crs));
> -                aml_append(scope, dev);
> +                if (TPM_IS_TIS(tpm_find())) {
> +                    dev = aml_device("ISA.TPM");
> +                    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C31")));
> +                    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
> +                    crs = aml_resource_template();
> +                    aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
> +                               TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
> +                    /*
> +                        FIXME: TPM_TIS_IRQ=5 conflicts with PNP0C0F irqs,
> +                        Rewrite to take IRQ from TPM device model and
> +                        fix default IRQ value there to use some unused IRQ
> +                     */
> +                    /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
> +                    aml_append(dev, aml_name_decl("_CRS", crs));
> +                    aml_append(scope, dev);
> +                }
> +
> +                aml_append(sb_scope, scope);
>               }
> -
> -            aml_append(sb_scope, scope);
> +            /* q35 host is the first one in the tail queue */
> +            q35host = false;

I don't think you should use this hack. Add a domain_nr property to the 
q35 host
and set it always to 0. Then you don't need special cases.

> +            pci_host = OBJECT(QTAILQ_NEXT(PCI_HOST_BRIDGE(pci_host), next));
>           }
>       }
>   
> @@ -2645,7 +2664,7 @@ static AcpiMcfgInfo *acpi_get_mcfg(void)
>           qobject_unref(o);
>           /* skip q35 host and bridges that reside in the same domain with it */
>           if (domain_nr == 0) {
> -            pci_host = OBJECT(QLIST_NEXT(PCI_HOST_BRIDGE(pci_host), next));
> +            pci_host = OBJECT(QTAILQ_NEXT(PCI_HOST_BRIDGE(pci_host), next));
>               continue;
>           }
>   
> @@ -2674,7 +2693,7 @@ static AcpiMcfgInfo *acpi_get_mcfg(void)
>           assert(o);
>           mcfg->domain_nr = qnum_get_uint(qobject_to(QNum, o));
>   
> -        pci_host = OBJECT(QLIST_NEXT(PCI_HOST_BRIDGE(pci_host), next));
> +        pci_host = OBJECT(QTAILQ_NEXT(PCI_HOST_BRIDGE(pci_host), next));
>       }
>   
>       return head;
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 80bc459..f63385f 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -196,7 +196,8 @@ static void pci_del_option_rom(PCIDevice *pdev);
>   static uint16_t pci_default_sub_vendor_id = PCI_SUBVENDOR_ID_REDHAT_QUMRANET;
>   static uint16_t pci_default_sub_device_id = PCI_SUBDEVICE_ID_QEMU;
>   
> -static QLIST_HEAD(, PCIHostState) pci_host_bridges;
> +static QTAILQ_HEAD(, PCIHostState) pci_host_bridges =
> +    QTAILQ_HEAD_INITIALIZER(pci_host_bridges);
>   
>   int pci_bar(PCIDevice *d, int reg)
>   {
> @@ -330,7 +331,7 @@ static void pci_host_bus_register(DeviceState *host)
>   {
>       PCIHostState *host_bridge = PCI_HOST_BRIDGE(host);
>   
> -    QLIST_INSERT_HEAD(&pci_host_bridges, host_bridge, next);
> +    QTAILQ_INSERT_HEAD(&pci_host_bridges, host_bridge, next);
>   }
>   
>   PCIBus *pci_device_root_bus(const PCIDevice *d)
> @@ -1798,7 +1799,7 @@ PciInfoList *qmp_query_pci(Error **errp)
>       PciInfoList *info, *head = NULL, *cur_item = NULL;
>       PCIHostState *host_bridge;
>   
> -    QLIST_FOREACH(host_bridge, &pci_host_bridges, next) {
> +    QTAILQ_FOREACH(host_bridge, &pci_host_bridges, next) {
>           info = g_malloc0(sizeof(*info));
>           info->value = qmp_query_pci_bus(host_bridge->bus,
>                                           pci_bus_num(host_bridge->bus));
> @@ -2493,7 +2494,7 @@ int pci_qdev_find_device(const char *id, PCIDevice **pdev)
>       PCIHostState *host_bridge;
>       int rc = -ENODEV;
>   
> -    QLIST_FOREACH(host_bridge, &pci_host_bridges, next) {
> +    QTAILQ_FOREACH(host_bridge, &pci_host_bridges, next) {
>           int tmp = pci_qdev_find_recursive(host_bridge->bus, id, pdev);
>           if (!tmp) {
>               rc = 0;
> diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
> index ba31595..a5617cf 100644
> --- a/include/hw/pci/pci_host.h
> +++ b/include/hw/pci/pci_host.h
> @@ -47,7 +47,7 @@ struct PCIHostState {
>       uint32_t config_reg;
>       PCIBus *bus;
>   
> -    QLIST_ENTRY(PCIHostState) next;
> +    QTAILQ_ENTRY(PCIHostState) next;
>   };
>   
>   typedef struct PCIHostBridgeClass {

Looking good, do you have something working?

Thanks,
Marcel
