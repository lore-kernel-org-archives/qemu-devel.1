Received: from eggs.gnu.org ([2001:4830:134:3::10]:45771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fOhkE-0004qI-B1
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 06:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fOhkB-000312-AG
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 06:57:18 -0400
Date: Fri, 1 Jun 2018 12:57:11 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180601125711.21e458a4@redhat.com>
In-Reply-To: <20180517081527.14410-10-david@redhat.com>
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-10-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 09/14] spapr: handle cpu core unplug via
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
Cc: qemu-devel@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Thu, 17 May 2018 10:15:22 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's handle it via hotplug_handler_unplug().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/ppc/spapr.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 286c38c842..13d153b5a6 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3412,7 +3412,16 @@ static void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
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
> +static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                              Error **errp)
> +{
> +    MachineState *ms = MACHINE(hotplug_dev);
>      sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(ms);
>      CPUCore *cc = CPU_CORE(dev);
>      CPUArchId *core_slot = spapr_find_cpu_slot(ms, cc->core_id, NULL);
> @@ -3623,6 +3632,8 @@ static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
>      /* final stage hotplug handler */
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          spapr_memory_unplug(hotplug_dev, dev, &local_err);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
> +        spapr_core_unplug(hotplug_dev, dev, &local_err);
>      } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
>          hotplug_handler_unplug(dev->parent_bus->hotplug_handler, dev,
>                                 &local_err);
