Received: from eggs.gnu.org ([2001:4830:134:3::10]:41584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fOhNX-0006us-2u
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 06:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fOhNU-0008Ty-FR
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 06:33:51 -0400
Date: Fri, 1 Jun 2018 12:33:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180601123343.33546511@redhat.com>
In-Reply-To: <20180517081527.14410-7-david@redhat.com>
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 06/14] spapr: prepare for multi stage
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

On Thu, 17 May 2018 10:15:19 +0200
David Hildenbrand <david@redhat.com> wrote:

maybe subj: make hotplug handlers use local_error
> For multi stage hotplug handlers, we'll have to do some error handling
> in some hotplug functions, so let's use a local error variable (except
> for unplug requests).


> 
> Also, add code to pass control to the final stage hotplug handler at the
> parent bus.
doing several not related things in one patch doesn't help reviewing it.
Also as explained 04/14 it's not needed at all.
Could you try to keep patches minimal,
we can add more complexity in later revisions if it really necessary.

 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/ppc/spapr.c | 54 +++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 43 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ebf30dd60b..b7c5c95f7a 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3571,27 +3571,48 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
>  {
>      MachineState *ms = MACHINE(hotplug_dev);
>      sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(ms);
> +    Error *local_err = NULL;
>  
> +    /* final stage hotplug handler */
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          int node;
>  
>          if (!smc->dr_lmb_enabled) {
> -            error_setg(errp, "Memory hotplug not supported for this machine");
> -            return;
> +            error_setg(&local_err,
> +                       "Memory hotplug not supported for this machine");
> +            goto out;
>          }
> -        node = object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP, errp);
> -        if (*errp) {
> -            return;
> +        node = object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP,
> +                                        &local_err);
> +        if (local_err) {
> +            goto out;
>          }
>          if (node < 0 || node >= MAX_NODES) {
> -            error_setg(errp, "Invaild node %d", node);
> -            return;
> +            error_setg(&local_err, "Invaild node %d", node);
> +            goto out;
>          }
>  
> -        spapr_memory_plug(hotplug_dev, dev, node, errp);
> +        spapr_memory_plug(hotplug_dev, dev, node, &local_err);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
> -        spapr_core_plug(hotplug_dev, dev, errp);
> +        spapr_core_plug(hotplug_dev, dev, &local_err);
> +    } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
> +        hotplug_handler_plug(dev->parent_bus->hotplug_handler, dev, &local_err);
> +    }
> +out:
> +    error_propagate(errp, local_err);
> +}
> +
> +static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
> +                                        DeviceState *dev, Error **errp)
> +{
> +    Error *local_err = NULL;
> +
> +    /* final stage hotplug handler */
> +    if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
> +        hotplug_handler_unplug(dev->parent_bus->hotplug_handler, dev,
> +                               &local_err);
>      }
> +    error_propagate(errp, local_err);
>  }
>  
>  static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
> @@ -3618,17 +3639,27 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
>              return;
>          }
>          spapr_core_unplug_request(hotplug_dev, dev, errp);
> +    } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
> +        hotplug_handler_unplug_request(dev->parent_bus->hotplug_handler, dev,
> +                                       errp);
>      }
>  }
>  
>  static void spapr_machine_device_pre_plug(HotplugHandler *hotplug_dev,
>                                            DeviceState *dev, Error **errp)
>  {
> +    Error *local_err = NULL;
> +
> +    /* final stage hotplug handler */
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> -        spapr_memory_pre_plug(hotplug_dev, dev, errp);
> +        spapr_memory_pre_plug(hotplug_dev, dev, &local_err);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
> -        spapr_core_pre_plug(hotplug_dev, dev, errp);
> +        spapr_core_pre_plug(hotplug_dev, dev, &local_err);
> +    } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
> +        hotplug_handler_pre_plug(dev->parent_bus->hotplug_handler, dev,
> +                                 &local_err);
>      }
> +    error_propagate(errp, local_err);
>  }
>  
>  static HotplugHandler *spapr_get_hotplug_handler(MachineState *machine,
> @@ -3988,6 +4019,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>      mc->get_default_cpu_node_id = spapr_get_default_cpu_node_id;
>      mc->possible_cpu_arch_ids = spapr_possible_cpu_arch_ids;
>      hc->unplug_request = spapr_machine_device_unplug_request;
> +    hc->unplug = spapr_machine_device_unplug;
>  
>      smc->dr_lmb_enabled = true;
>      mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power8_v2.0");
