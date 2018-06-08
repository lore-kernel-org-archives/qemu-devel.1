Received: from eggs.gnu.org ([2001:4830:134:3::10]:59990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fRHK7-0007Jf-Hx
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fRHK2-0004go-Gj
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:20:59 -0400
Received: from 13.mo7.mail-out.ovh.net ([87.98.150.175]:47330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fRHK2-0004gA-9J
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:20:54 -0400
Received: from player734.ha.ovh.net (unknown [10.109.122.116])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 9D2B2B1CF8
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 15:20:50 +0200 (CEST)
Date: Fri, 8 Jun 2018 15:20:39 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180608152039.7283bea9@bahia.lan>
In-Reply-To: <20180608124816.22140-3-david@redhat.com>
References: <20180608124816.22140-1-david@redhat.com>
	<20180608124816.22140-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/6] spapr: move lookup of the node into
 spapr_memory_plug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Fri,  8 Jun 2018 14:48:12 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's clean the hotplug handler up by moving lookup of the node into
> the function where it is actually being used.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f16a0b2870..1f577b274b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3136,7 +3136,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
>  }
>  
>  static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> -                              uint32_t node, Error **errp)
> +                              Error **errp)
>  {
>      Error *local_err = NULL;
>      sPAPRMachineState *ms = SPAPR_MACHINE(hotplug_dev);
> @@ -3144,6 +3144,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>      PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
>      MemoryRegion *mr;
>      uint64_t align, size, addr;
> +    uint32_t node;
>  
>      mr = ddc->get_memory_region(dimm, &local_err);
>      if (local_err) {
> @@ -3163,6 +3164,8 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>          goto out_unplug;
>      }
>  
> +    node = object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP,
> +                                    &error_abort);
>      spapr_add_lmbs(dev, addr, size, node,
>                     spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
>                     &local_err);
> @@ -3572,16 +3575,11 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
>      sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(ms);
>  
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> -        int node;
> -
>          if (!smc->dr_lmb_enabled) {
>              error_setg(errp, "Memory hotplug not supported for this machine");
>              return;
>          }
> -        node = object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP,
> -                                        &error_abort);
> -
> -        spapr_memory_plug(hotplug_dev, dev, node, errp);
> +        spapr_memory_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
>          spapr_core_plug(hotplug_dev, dev, errp);
>      }
