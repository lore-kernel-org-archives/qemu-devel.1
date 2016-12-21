Received: from eggs.gnu.org ([2001:4830:134:3::10]:42597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cJfjH-0008RZ-8b
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 07:10:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cJfjC-0003bU-1B
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 07:10:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cJfjB-0003a6-Fi
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 07:10:37 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 731D02173C
	for <qemu-devel@nongnu.org>; Wed, 21 Dec 2016 12:10:36 +0000 (UTC)
References: <1480980749-182204-1-git-send-email-imammedo@redhat.com>
	<1480980749-182204-7-git-send-email-imammedo@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <cf7a92bf-bbcc-6de2-d0ab-bef39064e3a6@redhat.com>
Date: Wed, 21 Dec 2016 14:10:33 +0200
MIME-Version: 1.0
In-Reply-To: <1480980749-182204-7-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 06/10] memhp: merge
 build_memory_devices() into build_memory_hotplug_aml()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 12/06/2016 01:32 AM, Igor Mammedov wrote:
> It consolidates memory hotplug AML in one place within DSDT
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/acpi/memory_hotplug.h |  2 --
>  hw/acpi/memory_hotplug.c         | 14 ++++-----
>  hw/i386/acpi-build.c             | 61 ++++++++++++++++++----------------------
>  3 files changed, 33 insertions(+), 44 deletions(-)
>
> diff --git a/include/hw/acpi/memory_hotplug.h b/include/hw/acpi/memory_hotplug.h
> index c70481e..6dc48d2 100644
> --- a/include/hw/acpi/memory_hotplug.h
> +++ b/include/hw/acpi/memory_hotplug.h
> @@ -54,6 +54,4 @@ void acpi_memory_ospm_status(MemHotplugState *mem_st, ACPIOSTInfoList ***list);
>
>  void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
>                                uint16_t io_base, uint16_t io_len);
> -void build_memory_devices(Aml *sb_scope, int nr_mem,
> -                          uint16_t io_base, uint16_t io_len);
>  #endif
> diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
> index fb40a5e..18b95f2 100644
> --- a/hw/acpi/memory_hotplug.c
> +++ b/hw/acpi/memory_hotplug.c
> @@ -310,9 +310,11 @@ const VMStateDescription vmstate_memory_hotplug = {
>  void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
>                                uint16_t io_base, uint16_t io_len)
>  {
> +    int i;
>      Aml *ifctx;
>      Aml *method;
>      Aml *pci_scope;
> +    Aml *sb_scope;
>      Aml *mem_ctrl_dev;
>
>      /* scope for memory hotplug controller device node */
> @@ -610,19 +612,12 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
>      }
>      aml_append(pci_scope, mem_ctrl_dev);
>      aml_append(table, pci_scope);
> -}
> -
> -void build_memory_devices(Aml *sb_scope, int nr_mem,
> -                          uint16_t io_base, uint16_t io_len)
> -{
> -    int i;
> -    Aml *dev;
> -    Aml *method;
> -    Aml *ifctx;
>
> +    sb_scope = aml_scope("_SB");


One question here, before this patch the mem devices were
added to \\_SB scope, now they are added to _SB.

I suppose is OK? Is there any change in the DSDT? Can we see a diff?

Thanks,
Marcel

>      /* build memory devices */
>      for (i = 0; i < nr_mem; i++) {
>          #define BASEPATH "\\_SB.PCI0." MEMORY_HOTPLUG_DEVICE "."
> +        Aml *dev;
>          const char *s;
>
>          dev = aml_device("MP%02X", i);
> @@ -673,4 +668,5 @@ void build_memory_devices(Aml *sb_scope, int nr_mem,
>          aml_append(method, ifctx);
>      }
>      aml_append(sb_scope, method);
> +    aml_append(table, sb_scope);
>  }
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 38dcac7..690e9a0 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2197,45 +2197,40 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>
>      sb_scope = aml_scope("\\_SB");
>      {
> -        build_memory_devices(sb_scope, nr_mem, pm->mem_hp_io_base,
> -                             pm->mem_hp_io_len);
> +        Object *pci_host;
> +        PCIBus *bus = NULL;
>
> -        {
> -            Object *pci_host;
> -            PCIBus *bus = NULL;
> +        pci_host = acpi_get_i386_pci_host();
> +        if (pci_host) {
> +            bus = PCI_HOST_BRIDGE(pci_host)->bus;
> +        }
>
> -            pci_host = acpi_get_i386_pci_host();
> -            if (pci_host) {
> -                bus = PCI_HOST_BRIDGE(pci_host)->bus;
> +        if (bus) {
> +            Aml *scope = aml_scope("PCI0");
> +            /* Scan all PCI buses. Generate tables to support hotplug. */
> +            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
> +
> +            if (misc->tpm_version != TPM_VERSION_UNSPEC) {
> +                dev = aml_device("ISA.TPM");
> +                aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C31")));
> +                aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
> +                crs = aml_resource_template();
> +                aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
> +                           TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
> +                /*
> +                    FIXME: TPM_TIS_IRQ=5 conflicts with PNP0C0F irqs,
> +                    Rewrite to take IRQ from TPM device model and
> +                    fix default IRQ value there to use some unused IRQ
> +                 */
> +                /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
> +                aml_append(dev, aml_name_decl("_CRS", crs));
> +                aml_append(scope, dev);
>              }
>
> -            if (bus) {
> -                Aml *scope = aml_scope("PCI0");
> -                /* Scan all PCI buses. Generate tables to support hotplug. */
> -                build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
> -
> -                if (misc->tpm_version != TPM_VERSION_UNSPEC) {
> -                    dev = aml_device("ISA.TPM");
> -                    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C31")));
> -                    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
> -                    crs = aml_resource_template();
> -                    aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
> -                               TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
> -                    /*
> -                        FIXME: TPM_TIS_IRQ=5 conflicts with PNP0C0F irqs,
> -                        Rewrite to take IRQ from TPM device model and
> -                        fix default IRQ value there to use some unused IRQ
> -                     */
> -                    /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
> -                    aml_append(dev, aml_name_decl("_CRS", crs));
> -                    aml_append(scope, dev);
> -                }
> -
> -                aml_append(sb_scope, scope);
> -            }
> +            aml_append(sb_scope, scope);
>          }
> -        aml_append(dsdt, sb_scope);
>      }
> +    aml_append(dsdt, sb_scope);
>
>      /* copy AML table into ACPI tables blob and patch header there */
>      g_array_append_vals(table_data, dsdt->buf->data, dsdt->buf->len);
>
