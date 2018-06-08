Received: from eggs.gnu.org ([2001:4830:134:3::10]:53073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fRDGh-0004mf-6x
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:01:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fRDGc-000561-7O
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:01:11 -0400
Received: from 17.mo1.mail-out.ovh.net ([87.98.179.142]:60730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fRDGb-00055N-Vv
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:01:06 -0400
Received: from player773.ha.ovh.net (unknown [10.109.122.50])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 4992A1061F9
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 11:01:04 +0200 (CEST)
Date: Fri, 8 Jun 2018 11:00:48 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180608110048.0c084a09@bahia.lan>
In-Reply-To: <20180607165218.9558-8-david@redhat.com>
References: <20180607165218.9558-1-david@redhat.com>
	<20180607165218.9558-8-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 7/8] spapr: handle cpu core unplug via
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

On Thu,  7 Jun 2018 18:52:17 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's handle it via hotplug_handler_unplug() to make plug/unplug code
> look symmetrical.
> 
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0a8a3455d6..994deea8cf 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3415,7 +3415,15 @@ static void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
>  /* Callback to be called during DRC release. */
>  void spapr_core_release(DeviceState *dev)
>  {
> -    MachineState *ms = MACHINE(qdev_get_hotplug_handler(dev));
> +    HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(dev);
> +
> +    /* Call the unplug handler chain. This can never fail. */
> +    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
> +}
> +
> +static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev)
> +{
> +    MachineState *ms = MACHINE(hotplug_dev);
>      sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(ms);
>      CPUCore *cc = CPU_CORE(dev);
>      CPUArchId *core_slot = spapr_find_cpu_slot(ms, cc->core_id, NULL);
> @@ -3600,6 +3608,8 @@ static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
>  {
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          spapr_memory_unplug(hotplug_dev, dev);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
> +        spapr_core_unplug(hotplug_dev, dev);
>      }
>  }
>  
