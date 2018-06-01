Received: from eggs.gnu.org ([2001:4830:134:3::10]:51183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fOiHK-00074t-9L
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fOiHH-00048O-2D
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:31:30 -0400
Date: Fri, 1 Jun 2018 13:31:21 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180601133121.7123087d@redhat.com>
In-Reply-To: <20180517081527.14410-14-david@redhat.com>
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-14-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 13/14] memory-device: factor out unplug
 into hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Thu, 17 May 2018 10:15:26 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's move the unplug logic into the applicable hotplug handler for pc and
> spapr.
> 
> We'll move the plug logic next, then this will look more symmetrical in
> the hotplug handlers.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/i386/pc.c                   | 17 ++++++++++++++++-
>  hw/mem/memory-device.c         | 14 ++++++++++++--
>  hw/mem/pc-dimm.c               |  2 --
>  hw/mem/trace-events            |  2 ++
>  hw/ppc/spapr.c                 | 16 +++++++++++++++-
>  include/hw/mem/memory-device.h |  2 +-
>  6 files changed, 46 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 61f1537e14..426fb534c2 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2044,6 +2044,12 @@ static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>      } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
>          hotplug_handler_plug(dev->parent_bus->hotplug_handler, dev, &local_err);
>      }
> +
> +    if (local_err) {
> +        if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
> +            memory_device_unplug(MACHINE(hotplug_dev), MEMORY_DEVICE(dev));
> +        }
> +    }
>      error_propagate(errp, local_err);
>  }
>  
> @@ -2080,7 +2086,16 @@ static void pc_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
>          error_setg(&local_err, "acpi: device unplug for not supported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
>      }
> -    error_propagate(errp, local_err);
> +
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    /* first stage hotplug handler */
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
> +        memory_device_unplug(MACHINE(hotplug_dev), MEMORY_DEVICE(dev));
> +    }
>  }
>  
>  static HotplugHandler *pc_get_hotpug_handler(MachineState *machine,
> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
> index d22c91993f..8f10d613ea 100644
> --- a/hw/mem/memory-device.c
> +++ b/hw/mem/memory-device.c
> @@ -17,6 +17,7 @@
>  #include "qemu/range.h"
>  #include "hw/virtio/vhost.h"
>  #include "sysemu/kvm.h"
> +#include "trace.h"
>  
>  static gint memory_device_addr_sort(gconstpointer a, gconstpointer b)
>  {
> @@ -246,12 +247,21 @@ void memory_device_plug_region(MachineState *ms, MemoryRegion *mr,
>                                  addr - ms->device_memory->base, mr);
>  }
>  
> -void memory_device_unplug_region(MachineState *ms, MemoryRegion *mr)
> +void memory_device_unplug(MachineState *ms, MemoryDeviceState *md)
>  {
> -    /* we expect a previous call to memory_device_get_free_addr() */
> +    const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
> +    MemoryRegion *mr = mdc->get_memory_region(md);
> +
> +    /* we expect a previous call to memory_device_pre_plug */
>      g_assert(ms->device_memory);
>  
> +    if (!memory_region_is_mapped(mr)) {
> +        return;
> +    }
> +
>      memory_region_del_subregion(&ms->device_memory->mr, mr);
> +    trace_memory_device_unassign_address(mdc->get_addr(md));
> +    mdc->set_addr(md, 0);
>  }
>  
>  static const TypeInfo memory_device_info = {
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 5e2e3263ab..d487bb513b 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -94,9 +94,7 @@ void pc_dimm_memory_unplug(DeviceState *dev, MachineState *machine)
>      PCDIMMDevice *dimm = PC_DIMM(dev);
>      PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
>      MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm);
> -    MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
>  
> -    memory_device_unplug_region(machine, mr);
>      vmstate_unregister_ram(vmstate_mr, dev);
>  }
>  
> diff --git a/hw/mem/trace-events b/hw/mem/trace-events
> index e150dcc497..a661ee49a3 100644
> --- a/hw/mem/trace-events
> +++ b/hw/mem/trace-events
> @@ -3,3 +3,5 @@
>  # hw/mem/pc-dimm.c
>  mhp_pc_dimm_assigned_slot(int slot) "%d"
>  mhp_pc_dimm_assigned_address(uint64_t addr) "0x%"PRIx64
> +# hw/mem/memory-device.c
> +memory_device_unassign_address(uint64_t addr) "0x%"PRIx64
maybe split out tracing into a separate patch?

> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 562712def2..abdd38a6b5 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3621,6 +3621,11 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
>          hotplug_handler_plug(dev->parent_bus->hotplug_handler, dev, &local_err);
>      }
>  out:
> +    if (local_err) {
> +        if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
> +            memory_device_unplug(MACHINE(hotplug_dev), MEMORY_DEVICE(dev));
> +        }
> +    }
we shouldn't call unplug here.
I'd suggest spapr_memory_plug() and/or memory_device_plug() to do
error handling and rollback on it's own, it shouldn't complicate generic
machines' hotplug handlers.

>      error_propagate(errp, local_err);
>  }
>  
> @@ -3638,7 +3643,16 @@ static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
>          hotplug_handler_unplug(dev->parent_bus->hotplug_handler, dev,
>                                 &local_err);
>      }
> -    error_propagate(errp, local_err);
> +
> +    if (local_err) {
this check probably not needed, error_propagate()
bails out of local_err is NULL

> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    /* first stage hotplug handler */
I'd drop this comment, it looks not necessary and even a bit confusing to me.

> +    if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
> +        memory_device_unplug(MACHINE(hotplug_dev), MEMORY_DEVICE(dev));
> +    }
>  }
>  
>  static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
> diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
> index 3a4e9edc92..b8365959e7 100644
> --- a/include/hw/mem/memory-device.h
> +++ b/include/hw/mem/memory-device.h
> @@ -58,6 +58,6 @@ uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
>                                       Error **errp);
>  void memory_device_plug_region(MachineState *ms, MemoryRegion *mr,
>                                 uint64_t addr);
> -void memory_device_unplug_region(MachineState *ms, MemoryRegion *mr);
> +void memory_device_unplug(MachineState *ms, MemoryDeviceState *md);
>  
>  #endif
