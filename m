Received: from eggs.gnu.org ([2001:4830:134:3::10]:52448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fRDEz-0003WI-1O
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fRDEu-0004Hd-CZ
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:59:25 -0400
Received: from 18.mo4.mail-out.ovh.net ([188.165.54.143]:53359)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fRDEu-0004HM-67
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:59:20 -0400
Received: from player789.ha.ovh.net (unknown [10.109.108.106])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 91C1E181FF9
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 10:59:16 +0200 (CEST)
Date: Fri, 8 Jun 2018 10:59:00 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180608105900.67fe07ba@bahia.lan>
In-Reply-To: <20180607165218.9558-7-david@redhat.com>
References: <20180607165218.9558-1-david@redhat.com>
	<20180607165218.9558-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 6/8] spapr: handle pc-dimm unplug via
 hotplug handler chain
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

On Thu,  7 Jun 2018 18:52:16 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's handle it via hotplug_handler_unplug(). E.g. necessary to hotplug/
> unplug memory devices (which a pc-dimm is) later.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index bcb72d9fa7..0a8a3455d6 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3298,7 +3298,8 @@ static sPAPRDIMMState *spapr_recover_pending_dimm_state(sPAPRMachineState *ms,
>  /* Callback to be called during DRC release. */
>  void spapr_lmb_release(DeviceState *dev)
>  {
> -    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_hotplug_handler(dev));
> +    HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(dev);
> +    sPAPRMachineState *spapr = SPAPR_MACHINE(hotplug_ctrl);
>      sPAPRDIMMState *ds = spapr_pending_dimm_unplugs_find(spapr, PC_DIMM(dev));
>  
>      /* This information will get lost if a migration occurs
> @@ -3316,9 +3317,17 @@ void spapr_lmb_release(DeviceState *dev)
>  
>      /*
>       * Now that all the LMBs have been removed by the guest, call the
> -     * pc-dimm unplug handler to cleanup up the pc-dimm device.
> +     * unplug handler chain. This can never fail.
>       */
> -    pc_dimm_memory_unplug(dev, MACHINE(spapr));
> +    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
> +}
> +
> +static void spapr_memory_unplug(HotplugHandler *hotplug_dev, DeviceState *dev)
> +{
> +    sPAPRMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
> +    sPAPRDIMMState *ds = spapr_pending_dimm_unplugs_find(spapr, PC_DIMM(dev));
> +
> +    pc_dimm_memory_unplug(dev, MACHINE(hotplug_dev));
>      object_unparent(OBJECT(dev));
>      spapr_pending_dimm_unplugs_remove(spapr, ds);
>  }
> @@ -3589,6 +3598,9 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
>  static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
>                                          DeviceState *dev, Error **errp)
>  {
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> +        spapr_memory_unplug(hotplug_dev, dev);
> +    }
>  }
>  
>  static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
