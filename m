Received: from eggs.gnu.org ([2001:4830:134:3::10]:44946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fO0py-0003FY-S4
	for qemu-devel@nongnu.org; Wed, 30 May 2018 09:08:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fO0pv-0000D9-7x
	for qemu-devel@nongnu.org; Wed, 30 May 2018 09:08:22 -0400
Date: Wed, 30 May 2018 15:08:06 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180530150806.061c26b9@redhat.com>
In-Reply-To: <20180517081527.14410-5-david@redhat.com>
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 04/14] pc: prepare for multi stage
 hotplug handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>

On Thu, 17 May 2018 10:15:17 +0200
David Hildenbrand <david@redhat.com> wrote:

> For multi stage hotplug handlers, we'll have to do some error handling
> in some hotplug functions, so let's use a local error variable (except
> for unplug requests).
I'd split out introducing local error into separate patch
so patch would do a single thing.

> Also, add code to pass control to the final stage hotplug handler at the
> parent bus.
But I don't agree with generic
 "} else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {"
forwarding, it's done by 3/14 for generic case and in case of
special device that needs bus handler called from machine one,
I'd suggest to do forwarding explicitly for that device only
like we do with acpi_dev.


> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/i386/pc.c | 39 +++++++++++++++++++++++++++++++--------
>  1 file changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index d768930d02..510076e156 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2007,19 +2007,32 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>  static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>                                            DeviceState *dev, Error **errp)
>  {
> +    Error *local_err = NULL;
> +
> +    /* final stage hotplug handler */
>      if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> -        pc_cpu_pre_plug(hotplug_dev, dev, errp);
> +        pc_cpu_pre_plug(hotplug_dev, dev, &local_err);
> +    } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
> +        hotplug_handler_pre_plug(dev->parent_bus->hotplug_handler, dev,
> +                                 &local_err);
>      }
> +    error_propagate(errp, local_err);
>  }
>  
>  static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>                                        DeviceState *dev, Error **errp)
>  {
> +    Error *local_err = NULL;
> +
> +    /* final stage hotplug handler */
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> -        pc_dimm_plug(hotplug_dev, dev, errp);
> +        pc_dimm_plug(hotplug_dev, dev, &local_err);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> -        pc_cpu_plug(hotplug_dev, dev, errp);
> +        pc_cpu_plug(hotplug_dev, dev, &local_err);
> +    } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
> +        hotplug_handler_plug(dev->parent_bus->hotplug_handler, dev, &local_err);
>      }
> +    error_propagate(errp, local_err);
>  }
>  
>  static void pc_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
> @@ -2029,7 +2042,10 @@ static void pc_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>          pc_dimm_unplug_request(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          pc_cpu_unplug_request_cb(hotplug_dev, dev, errp);
> -    } else {
> +    } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
> +        hotplug_handler_unplug_request(dev->parent_bus->hotplug_handler, dev,
> +                                       errp);
> +    } else if (!dev->parent_bus) {
>          error_setg(errp, "acpi: device unplug request for not supported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
>      }
> @@ -2038,14 +2054,21 @@ static void pc_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>  static void pc_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
>                                          DeviceState *dev, Error **errp)
>  {
> +    Error *local_err = NULL;
> +
> +    /* final stage hotplug handler */
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> -        pc_dimm_unplug(hotplug_dev, dev, errp);
> +        pc_dimm_unplug(hotplug_dev, dev, &local_err);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> -        pc_cpu_unplug_cb(hotplug_dev, dev, errp);
> -    } else {
> -        error_setg(errp, "acpi: device unplug for not supported device"
> +        pc_cpu_unplug_cb(hotplug_dev, dev, &local_err);
> +    } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
> +        hotplug_handler_unplug(dev->parent_bus->hotplug_handler, dev,
> +                               &local_err);
> +    } else if (!dev->parent_bus) {
> +        error_setg(&local_err, "acpi: device unplug for not supported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
>      }
> +    error_propagate(errp, local_err);
>  }
>  
>  static HotplugHandler *pc_get_hotpug_handler(MachineState *machine,
