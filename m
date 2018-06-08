Received: from eggs.gnu.org ([2001:4830:134:3::10]:51978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fRDDW-0002I0-Uj
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fRDDS-0003Qm-1E
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:57:55 -0400
Date: Fri, 8 Jun 2018 10:57:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180608105746.2e89caf1@redhat.com>
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
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Greg Kurz <groug@kaod.org>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Thu,  7 Jun 2018 18:52:17 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's handle it via hotplug_handler_unplug() to make plug/unplug code
> look symmetrical.
ditto wrt commit message as 6/8

> 
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
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
