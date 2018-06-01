Received: from eggs.gnu.org ([2001:4830:134:3::10]:45148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fOhgq-0003bf-Hz
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 06:53:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fOhgn-0001Ig-F7
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 06:53:48 -0400
Date: Fri, 1 Jun 2018 12:53:32 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180601125332.0bcd6b8b@redhat.com>
In-Reply-To: <20180517081527.14410-9-david@redhat.com>
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-9-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 08/14] spapr: handle pc-dimm unplug via
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
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>

On Thu, 17 May 2018 10:15:21 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's handle it via hotplug_handler_unplug(). E.g. necessary to hotplug/
> unplug memory devices (which a pc-dimm is) later.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/ppc/spapr.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 2f315f963b..286c38c842 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3291,7 +3291,8 @@ static sPAPRDIMMState *spapr_recover_pending_dimm_state(sPAPRMachineState *ms,
>  /* Callback to be called during DRC release. */
>  void spapr_lmb_release(DeviceState *dev)
>  {
> -    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_hotplug_handler(dev));
> +    HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(dev);
> +    sPAPRMachineState *spapr = SPAPR_MACHINE(hotplug_ctrl);
>      sPAPRDIMMState *ds = spapr_pending_dimm_unplugs_find(spapr, PC_DIMM(dev));
>  
>      /* This information will get lost if a migration occurs
> @@ -3309,9 +3310,21 @@ void spapr_lmb_release(DeviceState *dev)
>  
>      /*
>       * Now that all the LMBs have been removed by the guest, call the
> -     * pc-dimm unplug handler to cleanup up the pc-dimm device.
> +     * unplug handler chain. This can never fail.
>       */
> -    pc_dimm_memory_unplug(dev, MACHINE(spapr));
> +    hotplug_ctrl = qdev_get_hotplug_handler(dev);
> +    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
> +}
> +
> +static void spapr_memory_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                                Error **errp)
> +{
> +    sPAPRMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
> +    sPAPRDIMMState *ds = spapr_pending_dimm_unplugs_find(spapr, PC_DIMM(dev));

> +    g_assert(ds);
> +    g_assert(!ds->nr_lmbs);
Theses 2 lines seems to unrelated to patch topic,
could you drop it?

if these values should be checked, it would be better to audit 'ds' use
across spapr.c and file separate patch  separately from this series.

> +    pc_dimm_memory_unplug(dev, MACHINE(hotplug_dev));
>      object_unparent(OBJECT(dev));
>      spapr_pending_dimm_unplugs_remove(spapr, ds);
>  }
> @@ -3608,7 +3621,9 @@ static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
>      Error *local_err = NULL;
>  
>      /* final stage hotplug handler */
> -    if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> +        spapr_memory_unplug(hotplug_dev, dev, &local_err);
> +    } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
>          hotplug_handler_unplug(dev->parent_bus->hotplug_handler, dev,
>                                 &local_err);
>      }
otherwise, ignoring dev->parent_bus parts, patch looks reasonable
