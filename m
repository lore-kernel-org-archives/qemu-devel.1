Received: from eggs.gnu.org ([2001:4830:134:3::10]:36503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fVIs6-00019N-DR
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fVIs3-000877-Al
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:48:42 -0400
Date: Tue, 19 Jun 2018 17:48:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180619174830.33d2c3d2@redhat.com>
In-Reply-To: <20180618144800.555-2-david@redhat.com>
References: <20180618144800.555-1-david@redhat.com>
	<20180618144800.555-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/4] pc-dimm: assign and verify the
 "slot" property during pre_plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

On Mon, 18 Jun 2018 16:47:57 +0200
David Hildenbrand <david@redhat.com> wrote:

> We can assign and verify the slot before realizing and trying to plug.
> reading/writing the slot property should never fail, so let's reduce
> error handling a bit by using &error_abort.
> 
> To do this during pre_plug, add and use (x86, ppc) pc_dimm_pre_plug().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/pc.c             |  2 ++
>  hw/mem/pc-dimm.c         | 35 ++++++++++++++++++-----------------
>  hw/ppc/spapr.c           |  1 +
>  include/hw/mem/pc-dimm.h |  1 +
>  4 files changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f310040351..bf986baf91 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1695,6 +1695,8 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>          error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
>          return;
>      }
> +
> +    pc_dimm_pre_plug(dev, MACHINE(hotplug_dev), errp);
>  }
>  
>  static void pc_memory_plug(HotplugHandler *hotplug_dev,
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 65843bc52a..e56c4daef2 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -29,10 +29,27 @@
>  
>  static int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
>  
> +void pc_dimm_pre_plug(DeviceState *dev, MachineState *machine, Error **errp)
> +{
> +    Error *local_err = NULL;
> +    int slot;
> +
> +    slot = object_property_get_int(OBJECT(dev), PC_DIMM_SLOT_PROP,
> +                                   &error_abort);
> +    slot = pc_dimm_get_free_slot(slot == PC_DIMM_UNASSIGNED_SLOT ? NULL : &slot,
> +                                 machine->ram_slots, &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> +    object_property_set_int(OBJECT(dev), slot, PC_DIMM_SLOT_PROP, &error_abort);
> +    trace_mhp_pc_dimm_assigned_slot(slot);
> +out:
> +    error_propagate(errp, local_err);
> +}
> +
>  void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t align,
>                    Error **errp)
>  {
> -    int slot;
>      PCDIMMDevice *dimm = PC_DIMM(dev);
>      PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
>      MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm,
> @@ -59,22 +76,6 @@ void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t align,
>      }
>      trace_mhp_pc_dimm_assigned_address(addr);
>  
> -    slot = object_property_get_int(OBJECT(dev), PC_DIMM_SLOT_PROP, &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
> -
> -    slot = pc_dimm_get_free_slot(slot == PC_DIMM_UNASSIGNED_SLOT ? NULL : &slot,
> -                                 machine->ram_slots, &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
> -    object_property_set_int(OBJECT(dev), slot, PC_DIMM_SLOT_PROP, &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
> -    trace_mhp_pc_dimm_assigned_slot(slot);
> -
>      memory_device_plug_region(machine, mr, addr);
>      vmstate_register_ram(vmstate_mr, dev);
>  
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 6934abc21e..9da233588b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3211,6 +3211,7 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>          goto out;
>      }
>  
> +    pc_dimm_pre_plug(dev, MACHINE(hotplug_dev), errp);
>  out:
>      g_free(mem_dev);
>  }
> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> index 26ebb7d5e9..7b120416d1 100644
> --- a/include/hw/mem/pc-dimm.h
> +++ b/include/hw/mem/pc-dimm.h
> @@ -79,6 +79,7 @@ typedef struct PCDIMMDeviceClass {
>                                                 Error **errp);
>  } PCDIMMDeviceClass;
>  
> +void pc_dimm_pre_plug(DeviceState *dev, MachineState *machine, Error **errp);
>  void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t align,
>                    Error **errp);
>  void pc_dimm_unplug(DeviceState *dev, MachineState *machine);
