Received: from eggs.gnu.org ([2001:4830:134:3::10]:47718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fRCxG-0001Rr-4N
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:41:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fRCxC-0002RV-4s
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:41:06 -0400
Received: from 6.mo177.mail-out.ovh.net ([46.105.51.249]:58488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fRCxB-0002Qv-Tu
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:41:02 -0400
Received: from player731.ha.ovh.net (unknown [10.109.108.88])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 48098B5D52
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 10:41:00 +0200 (CEST)
Date: Fri, 8 Jun 2018 10:40:41 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180608104041.17eca7b6@bahia.lan>
In-Reply-To: <20180607165218.9558-5-david@redhat.com>
References: <20180607165218.9558-1-david@redhat.com>
	<20180607165218.9558-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 4/8] spapr: local error handling in
 hotplug handler functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Thu,  7 Jun 2018 18:52:14 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's introduce and use local error variables in the hotplug handler
> functions.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index a12be24ca9..4447cb197f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3576,11 +3576,14 @@ out:
>  static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
>                                        DeviceState *dev, Error **errp)
>  {
> +    Error *local_err = NULL;
> +
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> -        spapr_memory_plug(hotplug_dev, dev, errp);
> +        spapr_memory_plug(hotplug_dev, dev, &local_err);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
> -        spapr_core_plug(hotplug_dev, dev, errp);
> +        spapr_core_plug(hotplug_dev, dev, &local_err);
>      }
> +    error_propagate(errp, local_err);
>  }
>  
>  static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
> @@ -3588,10 +3591,11 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
>  {
>      sPAPRMachineState *sms = SPAPR_MACHINE(OBJECT(hotplug_dev));
>      MachineClass *mc = MACHINE_GET_CLASS(sms);
> +    Error *local_err = NULL;
>  
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          if (spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT)) {
> -            spapr_memory_unplug_request(hotplug_dev, dev, errp);
> +            spapr_memory_unplug_request(hotplug_dev, dev, &local_err);
>          } else {
>              /* NOTE: this means there is a window after guest reset, prior to
>               * CAS negotiation, where unplug requests will fail due to the
> @@ -3599,25 +3603,32 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
>               * the case with PCI unplug, where the events will be queued and
>               * eventually handled by the guest after boot
>               */
> -            error_setg(errp, "Memory hot unplug not supported for this guest");
> +            error_setg(&local_err,
> +                       "Memory hot unplug not supported for this guest");
>          }
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
>          if (!mc->has_hotpluggable_cpus) {
> -            error_setg(errp, "CPU hot unplug not supported on this machine");
> -            return;
> +            error_setg(&local_err,
> +                       "CPU hot unplug not supported on this machine");
> +            goto out;
>          }
> -        spapr_core_unplug_request(hotplug_dev, dev, errp);
> +        spapr_core_unplug_request(hotplug_dev, dev, &local_err);
>      }
> +out:
> +    error_propagate(errp, local_err);
>  }
>  
>  static void spapr_machine_device_pre_plug(HotplugHandler *hotplug_dev,
>                                            DeviceState *dev, Error **errp)
>  {
> +    Error *local_err = NULL;
> +
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> -        spapr_memory_pre_plug(hotplug_dev, dev, errp);
> +        spapr_memory_pre_plug(hotplug_dev, dev, &local_err);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
> -        spapr_core_pre_plug(hotplug_dev, dev, errp);
> +        spapr_core_pre_plug(hotplug_dev, dev, &local_err);
>      }
> +    error_propagate(errp, local_err);
>  }
>  
>  static HotplugHandler *spapr_get_hotplug_handler(MachineState *machine,
