Received: from eggs.gnu.org ([209.51.188.92]:48234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gkRGA-0001UR-1A
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:20:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gkRG8-0006CA-RY
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:20:21 -0500
Date: Fri, 18 Jan 2019 11:20:01 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190118112001.4bb2cf6f@redhat.com>
In-Reply-To: <20190116113523.9213-10-david@redhat.com>
References: <20190116113523.9213-1-david@redhat.com>
	<20190116113523.9213-10-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 09/10] pc: Support for PCI based memory
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Collin Walling <walling@linux.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

On Wed, 16 Jan 2019 12:35:22 +0100
David Hildenbrand <david@redhat.com> wrote:

> Override the PCI device hotplug handler to properly handle the
> memory device part from the machine hotplug handler and forward to the
> actual PCI bus hotplug handler.
> 
> As PCI hotplug has not been properly factored out into hotplug handlers,
> most magic is performed in the (un)realize functions. Also some buses don't
                                                             ^^^^^^^^ pls, be more specific

> have a PCI hotplug handler at all yet (not sure if they are actually used
> on x86, but just to be sure).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/i386/pc.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 89 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index fd0cb29ba9..62f83859fa 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -75,6 +75,7 @@
>  #include "hw/usb.h"
>  #include "hw/i386/intel_iommu.h"
>  #include "hw/net/ne2000-isa.h"
> +#include "hw/mem/memory-device.h"
>  
>  /* debug PC/ISA interrupts */
>  //#define DEBUG_IRQ
> @@ -2224,6 +2225,84 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>      numa_cpu_pre_plug(cpu_slot, dev, errp);
>  }
>  
> +static void pc_pci_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                            Error **errp)
> +{
> +    HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
> +    Error *local_err = NULL;
> +
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
> +        if (!hotplug_dev2) {
> +            /*
> +             * Without a bus hotplug handler, we cannot control the plug/unplug
> +             * order. Disallow memory devices on such buses.
> +             */
> +            error_setg(errp, "Memory devices not supported on this bus.");
> +            return;
> +        }
> +        memory_device_pre_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev),
> +                               NULL, errp);
> +    }
> +
> +    if (hotplug_dev2) {
> +        hotplug_handler_pre_plug(hotplug_dev2, dev, errp);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +    }
> +}
> +
> +static void pc_pci_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                        Error **errp)
> +{
> +    HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
> +    Error *local_err = NULL;
> +
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
> +        memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
> +    }
> +
> +    if (hotplug_dev2) {
> +        hotplug_handler_plug(hotplug_dev2, dev, &local_err);
> +    }
> +
> +    if (local_err) {
> +        if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
> +            memory_device_unplug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
> +        }
> +    }
> +    error_propagate(errp, local_err);
> +}
> +
> +static void pc_pci_unplug_request(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                                  Error **errp)
> +{
> +    HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
> +
> +    if (hotplug_dev2) {
> +        hotplug_handler_unplug_request(hotplug_dev2, dev, errp);
> +    }
> +}
> +
> +static void pc_pci_device_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                                 Error **errp)
> +{
> +    HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
> +    Error *local_err = NULL;
> +
> +    if (hotplug_dev2) {
> +        hotplug_handler_unplug(hotplug_dev2, dev, &local_err);
> +    }
> +
> +    if (!local_err) {
> +        if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
> +            memory_device_unplug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
> +        }
> +    }
> +    error_propagate(errp, local_err);
> +}
> +
>  static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>                                            DeviceState *dev, Error **errp)
>  {
> @@ -2231,6 +2310,8 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>          pc_memory_pre_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          pc_cpu_pre_plug(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        pc_pci_pre_plug(hotplug_dev, dev, errp);
>      }
>  }
>  
> @@ -2241,6 +2322,8 @@ static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>          pc_memory_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          pc_cpu_plug(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        pc_pci_plug(hotplug_dev, dev, errp);
>      }
>  }
>  
> @@ -2251,6 +2334,8 @@ static void pc_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>          pc_memory_unplug_request(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          pc_cpu_unplug_request_cb(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        pc_pci_unplug_request(hotplug_dev, dev, errp);
>      } else {
>          error_setg(errp, "acpi: device unplug request for not supported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -2264,6 +2349,8 @@ static void pc_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
>          pc_memory_unplug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          pc_cpu_unplug_cb(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        pc_pci_device_unplug(hotplug_dev, dev, errp);
>      } else {
>          error_setg(errp, "acpi: device unplug for not supported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -2274,7 +2361,8 @@ static HotplugHandler *pc_get_hotpug_handler(MachineState *machine,
>                                               DeviceState *dev)
>  {
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
> -        object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        object_dynamic_cast(OBJECT(dev), TYPE_CPU) ||
> +        object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
why all PCI devices instead of virtio-pmem-pci one?

>          return HOTPLUG_HANDLER(machine);
>      }
>  
