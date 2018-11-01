Received: from eggs.gnu.org ([2001:4830:134:3::10]:36701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gIDgJ-0007I2-Mo
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 10:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gIDgG-0005Fe-Fk
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 10:10:43 -0400
Date: Thu, 1 Nov 2018 15:10:34 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181101151034.4eb1618c@redhat.com>
In-Reply-To: <20181024101930.20674-3-david@redhat.com>
References: <20181024101930.20674-1-david@redhat.com>
	<20181024101930.20674-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/7] pcihp: overwrite hotplug handler
 recursively from the start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-ppc@nongnu.org, Libvirt <libvir-list@redhat.com>

On Wed, 24 Oct 2018 12:19:25 +0200
David Hildenbrand <david@redhat.com> wrote:

> For now, the hotplug handler is not called for devices that are
> being cold plugged. The hotplug handler is setup when the machine
> initialization is fully done. Only bridges that were cold plugged are
> considered.
> 
> Set the hotplug handler for the root piix bus directly when realizing.
> Overwrite the hotplug handler of bridges when hotplugging/coldplugging
> them.
> 
> This will now make sure that the ACPI PCI hotplug handler is also called
> for cold-plugged devices (also on bridges) and for bridges that were
> hotplugged.
> 
> When trying to hotplug a device to a hotplugged bridge, we now correctly
> get the error message
>  "Unsupported bus. Bus doesn't have property 'acpi-pcihp-bsel' set"
> Insted of going via the standard PCI hotplug handler.
Erroring out is probably not ok, since it can break existing setups
where SHPC hotplugging to hotplugged bridge was working just fine before.

Marcel/Michael what's your take on this change in behaviour?
CCing libvirt in case they are doing this stuff


> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/acpi/pcihp.c | 10 ++++++++++
>  hw/acpi/piix4.c | 16 +---------------
>  2 files changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 5e7cef173c..647b5e8d82 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -30,6 +30,7 @@
>  #include "hw/hw.h"
>  #include "hw/i386/pc.h"
>  #include "hw/pci/pci.h"
> +#include "hw/pci/pci_bridge.h"
>  #include "hw/acpi/acpi.h"
>  #include "sysemu/sysemu.h"
>  #include "exec/address-spaces.h"
> @@ -236,6 +237,15 @@ void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
>      int slot = PCI_SLOT(pdev->devfn);
>      int bsel;
>  
> +    if (!s->legacy_piix && object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
> +        PCIBus *sec = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
> +
> +        /* Overwrite the default hotplug handler with the ACPI PCI one. */
> +        qbus_set_hotplug_handler(BUS(sec), DEVICE(hotplug_dev), &error_abort);
> +        /* No need to do it recursively */
> +        assert(QLIST_EMPTY(&sec->child));
> +    }
> +
>      /* Don't send event when device is enabled during qemu machine creation:
>       * it is present on boot, no hotplug event is necessary. We do send an
>       * event when the device is disabled later. */
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index 167afe2cea..e611778daf 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -446,15 +446,6 @@ static void piix4_device_unplug_cb(HotplugHandler *hotplug_dev,
>      }
>  }
>  
> -static void piix4_update_bus_hotplug(PCIBus *pci_bus, void *opaque)
> -{
> -    PIIX4PMState *s = opaque;
> -
> -    /* pci_bus cannot outlive PIIX4PMState, because /machine keeps it alive
> -     * and it's not hot-unpluggable */
> -    qbus_set_hotplug_handler(BUS(pci_bus), DEVICE(s), &error_abort);
> -}
> -
>  static void piix4_pm_machine_ready(Notifier *n, void *opaque)
>  {
>      PIIX4PMState *s = container_of(n, PIIX4PMState, machine_ready);
> @@ -468,12 +459,6 @@ static void piix4_pm_machine_ready(Notifier *n, void *opaque)
>      pci_conf[0x63] = 0x60;
>      pci_conf[0x67] = (memory_region_present(io_as, 0x3f8) ? 0x08 : 0) |
>          (memory_region_present(io_as, 0x2f8) ? 0x90 : 0);
> -
> -    if (s->use_acpi_pci_hotplug) {
> -        pci_for_each_bus(pci_get_bus(d), piix4_update_bus_hotplug, s);
> -    } else {
> -        piix4_update_bus_hotplug(pci_get_bus(d), s);
> -    }
>  }
>  
>  static void piix4_pm_add_propeties(PIIX4PMState *s)
> @@ -547,6 +532,7 @@ static void piix4_pm_realize(PCIDevice *dev, Error **errp)
>  
>      piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
>                                     pci_get_bus(dev), s);
> +    qbus_set_hotplug_handler(BUS(pci_get_bus(dev)), DEVICE(s), &error_abort);
>  
>      piix4_pm_add_propeties(s);
>  }
