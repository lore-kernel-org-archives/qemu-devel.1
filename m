Received: from eggs.gnu.org ([2001:4830:134:3::10]:35519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fJIGh-0006oR-Dr
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fJIGe-0006Ty-8y
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:44:27 -0400
Received: from 2.mo4.mail-out.ovh.net ([46.105.72.36]:57428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fJIGd-0006Mv-Uh
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:44:24 -0400
Received: from player694.ha.ovh.net (unknown [10.109.108.61])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 171C6173033
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 14:44:15 +0200 (CEST)
Date: Thu, 17 May 2018 14:43:52 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180517144352.75b748f1@bahia.lan>
In-Reply-To: <20180517081527.14410-7-david@redhat.com>
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v4 06/14] spapr: prepare for
 multi stage hotplug handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Thu, 17 May 2018 10:15:19 +0200
David Hildenbrand <david@redhat.com> wrote:

> For multi stage hotplug handlers, we'll have to do some error handling
> in some hotplug functions, so let's use a local error variable (except
> for unplug requests).
> 
> Also, add code to pass control to the final stage hotplug handler at the
> parent bus.
> 
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

Heh ! This is even a fix since errp could theoretically be NULL.

Reviewed-by: Greg Kurz <groug@kaod.org>

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
