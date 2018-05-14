Received: from eggs.gnu.org ([2001:4830:134:3::10]:41586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fIAsT-00027L-Iv
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fIAsQ-0007xL-Cc
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:38:49 -0400
References: <20180514100023.12542-1-david@redhat.com>
	<20180514100023.12542-19-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9424ab12-d262-f71a-9a3b-67af2a21cf42@redhat.com>
Date: Mon, 14 May 2018 12:38:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180514100023.12542-19-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 18/18] s390x: support memory devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>

On 14.05.2018 12:00, David Hildenbrand wrote:
> Let's route all memory devices we can hotplug through the machine hotplug
> handler, just like on pc and spapr.
> 
> As CONFIG_DIMM is not enabled, we won't ever try to plug DIMMs.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  default-configs/s390x-softmmu.mak |  1 +
>  hw/s390x/s390-virtio-ccw.c        | 31 ++++++++++++++++++++++++++++++-
>  2 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
> index 2f4bfe73b4..c0628c0123 100644
> --- a/default-configs/s390x-softmmu.mak
> +++ b/default-configs/s390x-softmmu.mak
> @@ -9,3 +9,4 @@ CONFIG_S390_FLIC=y
>  CONFIG_S390_FLIC_KVM=$(CONFIG_KVM)
>  CONFIG_VFIO_CCW=$(CONFIG_LINUX)
>  CONFIG_WDT_DIAG288=y
> +CONFIG_MEM_DEVICE=y
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 7700658400..54c620baf2 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -35,6 +35,7 @@
>  #include "migration/register.h"
>  #include "cpu_models.h"
>  #include "hw/nmi.h"
> +#include "hw/mem/memory-device.h"
>  
>  S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>  {
> @@ -436,12 +437,29 @@ static void s390_machine_device_plug(HotplugHandler *hotplug_dev,
>  {
>      Error *local_err = NULL;
>  
> +    /* first stage hotplug handler */
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
> +        memory_device_plug(MACHINE(hotplug_dev), MEMORY_DEVICE(dev), NULL,
> +                           &local_err);
> +    }
> +
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
>      /* final stage hotplug handler */
>      if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          s390_cpu_plug(hotplug_dev, dev, &local_err);
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
> @@ -468,6 +486,16 @@ static void s390_machine_device_unplug(HotplugHandler *hotplug_dev,
>                                 &local_err);
>      }
>      error_propagate(errp, local_err);
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
>  static CpuInstanceProperties s390_cpu_index_to_props(MachineState *ms,
> @@ -506,7 +534,8 @@ static const CPUArchIdList *s390_possible_cpu_arch_ids(MachineState *ms)
>  static HotplugHandler *s390_get_hotplug_handler(MachineState *machine,
>                                                  DeviceState *dev)
>  {
> -    if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) ||
> +        object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
>          return HOTPLUG_HANDLER(machine);
>      }
>      return NULL;
> 

Just noticed that this patch misses the pre plug handler here. I will
wait for some feedback before I resend (and the !s390x patches can be
picked up independently).

-- 

Thanks,

David / dhildenb
