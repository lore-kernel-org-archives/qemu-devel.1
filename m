Received: from eggs.gnu.org ([2001:4830:134:3::10]:41640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dQiuC-0004dK-UI
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dQiu9-0000ir-Qi
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:31:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2139)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dQiu9-0000i7-He
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:31:21 -0400
Date: Fri, 30 Jun 2017 02:31:17 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170630023053-mutt-send-email-mst@kernel.org>
References: <1498773362-18675-1-git-send-email-zuban32s@gmail.com>
	<1498773362-18675-7-git-send-email-zuban32s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498773362-18675-7-git-send-email-zuban32s@gmail.com>
Subject: Re: [Qemu-devel] [PATCH RFC 6/6] hw/ich9: enable acpi pci hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

On Fri, Jun 30, 2017 at 12:56:02AM +0300, Aleksandr Bezzubikov wrote:
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>

This commit log is where you describe what works and
what doesn't so people can figure it out from git log.

> ---
>  hw/acpi/ich9.c         | 31 +++++++++++++++++++++++++++++++
>  hw/isa/lpc_ich9.c      | 12 ++++++++++++
>  include/hw/acpi/ich9.h |  4 ++++
>  include/hw/i386/pc.h   |  7 ++++++-
>  4 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 5c279bb..25339eb 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -258,6 +258,7 @@ static void pm_reset(void *opaque)
>      }
>      pm->smi_en_wmask = ~0;
>  
> +    acpi_pcihp_reset(&pm->acpi_pci_hotplug);
>      acpi_update_sci(&pm->acpi_regs, pm->irq);
>  }
>  
> @@ -301,6 +302,10 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm,
>      pm->powerdown_notifier.notify = pm_powerdown_req;
>      qemu_register_powerdown_notifier(&pm->powerdown_notifier);
>  
> +    acpi_pcihp_init(OBJECT(lpc_pci), &pm->acpi_pci_hotplug, lpc_pci->bus,
> +                    pci_address_space_io(lpc_pci),
> +                    pm->use_acpi_pci_hotplug);
> +
>      legacy_acpi_cpu_hotplug_init(pci_address_space_io(lpc_pci),
>          OBJECT(lpc_pci), &pm->gpe_cpu, ICH9_CPU_HOTPLUG_IO_BASE);
>  
> @@ -335,6 +340,21 @@ static void ich9_pm_set_memory_hotplug_support(Object *obj, bool value,
>      s->pm.acpi_memory_hotplug.is_enabled = value;
>  }
>  
> +static bool ich9_pm_get_acpi_pci_hotplug_support(Object *obj, Error **errp)
> +{
> +    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
> +
> +    return s->pm.use_acpi_pci_hotplug;
> +}
> +
> +static void ich9_pm_set_acpi_pci_hotplug_support(Object *obj, bool value,
> +                                                 Error **errp)
> +{
> +    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
> +
> +    s->pm.use_acpi_pci_hotplug = value;
> +}
> +
>  static bool ich9_pm_get_cpu_hotplug_legacy(Object *obj, Error **errp)
>  {
>      ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
> @@ -446,6 +466,7 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm, Error **errp)
>  {
>      static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
>      pm->acpi_memory_hotplug.is_enabled = true;
> +    pm->use_acpi_pci_hotplug = true;
>      pm->cpu_hotplug_legacy = true;
>      pm->disable_s3 = 0;
>      pm->disable_s4 = 0;
> @@ -462,6 +483,10 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm, Error **errp)
>                               ich9_pm_get_memory_hotplug_support,
>                               ich9_pm_set_memory_hotplug_support,
>                               NULL);
> +    object_property_add_bool(obj, "acpi-pci-hotplug-with-bridge-support",
> +                             ich9_pm_get_acpi_pci_hotplug_support,
> +                             ich9_pm_set_acpi_pci_hotplug_support,
> +                             NULL);
>      object_property_add_bool(obj, "cpu-hotplug-legacy",
>                               ich9_pm_get_cpu_hotplug_legacy,
>                               ich9_pm_set_cpu_hotplug_legacy,
> @@ -497,6 +522,9 @@ void ich9_pm_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>              acpi_memory_plug_cb(hotplug_dev, &lpc->pm.acpi_memory_hotplug,
>                                  dev, errp);
>          }
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        acpi_pcihp_device_plug_cb(hotplug_dev, &lpc->pm.acpi_pci_hotplug,
> +                                  dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          if (lpc->pm.cpu_hotplug_legacy) {
>              legacy_acpi_cpu_plug_cb(hotplug_dev, &lpc->pm.gpe_cpu, dev, errp);
> @@ -519,6 +547,9 @@ void ich9_pm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>          acpi_memory_unplug_request_cb(hotplug_dev,
>                                        &lpc->pm.acpi_memory_hotplug, dev,
>                                        errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        acpi_pcihp_device_unplug_cb(hotplug_dev, &lpc->pm.acpi_pci_hotplug,
> +                                    dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
>                 !lpc->pm.cpu_hotplug_legacy) {
>          acpi_cpu_unplug_request_cb(hotplug_dev, &lpc->pm.cpuhp_state,
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index e2215dc..13574d0 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -33,6 +33,7 @@
>  #include "hw/hw.h"
>  #include "qapi/visitor.h"
>  #include "qemu/range.h"
> +#include "qapi/error.h"
>  #include "hw/isa/isa.h"
>  #include "hw/sysbus.h"
>  #include "hw/i386/pc.h"
> @@ -574,6 +575,15 @@ static const MemoryRegionOps rcrb_mmio_ops = {
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
>  
> +static void ich9_update_bus_hotplug(PCIBus *pci_bus, void *opaque)
> +{
> +    ICH9LPCState *s = opaque;
> +
> +    if (!pci_bus_is_express(pci_bus)) {
> +        qbus_set_hotplug_handler(BUS(pci_bus), DEVICE(s), &error_abort);
> +    }
> +}
> +
>  static void ich9_lpc_machine_ready(Notifier *n, void *opaque)
>  {
>      ICH9LPCState *s = container_of(n, ICH9LPCState, machine_ready);
> @@ -597,6 +607,8 @@ static void ich9_lpc_machine_ready(Notifier *n, void *opaque)
>          /* floppy */
>          pci_conf[0x82] |= 0x08;
>      }
> +
> +    pci_for_each_bus(s->d.bus, ich9_update_bus_hotplug, s);
>  }
>  
>  /* reset control */
> diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
> index a352c94..e1df363 100644
> --- a/include/hw/acpi/ich9.h
> +++ b/include/hw/acpi/ich9.h
> @@ -22,6 +22,7 @@
>  #define HW_ACPI_ICH9_H
>  
>  #include "hw/acpi/acpi.h"
> +#include "hw/acpi/pcihp.h"
>  #include "hw/acpi/cpu_hotplug.h"
>  #include "hw/acpi/cpu.h"
>  #include "hw/acpi/memory_hotplug.h"
> @@ -55,6 +56,9 @@ typedef struct ICH9LPCPMRegs {
>  
>      MemHotplugState acpi_memory_hotplug;
>  
> +    AcpiPciHpState acpi_pci_hotplug;
> +    bool use_acpi_pci_hotplug;
> +
>      uint8_t disable_s3;
>      uint8_t disable_s4;
>      uint8_t s4_val;
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index e447f5d..0d4e8b2 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -464,7 +464,12 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
>      },
>  
>  #define PC_COMPAT_2_5 \
> -    HW_COMPAT_2_5
> +    HW_COMPAT_2_5 \
> +    {\
> +        .driver   = "ICH9-LPC",\
> +        .property = "acpi-pci-hotplug-with-bridge-support",\
> +        .value    = "off",\
> +    },
>  
>  /* Helper for setting model-id for CPU models that changed model-id
>   * depending on QEMU versions up to QEMU 2.4.
> -- 
> 2.7.4
