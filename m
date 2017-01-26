Received: from eggs.gnu.org ([2001:4830:134:3::10]:32838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cWiIg-00079Y-3T
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 06:33:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cWiIc-0004om-WC
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 06:33:10 -0500
Date: Thu, 26 Jan 2017 12:32:58 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170126123258.2d34fe95@Igors-MacBook-Pro.local>
In-Reply-To: <1466145399-32209-16-git-send-email-david@gibson.dropbear.id.au>
References: <1466145399-32209-1-git-send-email-david@gibson.dropbear.id.au>
	<1466145399-32209-16-git-send-email-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 15/18] spapr: CPU hot unplug support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: peter.maydell@linaro.org, agraf@suse.de, aik@ozlabs.ru, bharata@linux.vnet.ibm.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Fri, 17 Jun 2016 16:36:36 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> From: Bharata B Rao <bharata@linux.vnet.ibm.com>
> 
> Remove the CPU core device by removing the underlying CPU thread devices.
> Hot removal of CPU for sPAPR guests is achieved by sending the hot unplug
> notification to the guest. Release the vCPU object after CPU hot unplug so
> that vCPU fd can be parked and reused.
> 
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
[...]


Bharata,

Here is some notes I've made while auditing spapr cpu hotplug code.
  
spapr_core_release() should be spapr_core_unrealize()
except of machine related
 spapr->cores[cc->core_id / smt] = NULL;
which should go to spapr_core_unplug()

> +static void spapr_core_release(DeviceState *dev, void *opaque)
> +{
> +    sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
> +    const char *typename = object_class_get_name(sc->cpu_class);
> +    size_t size = object_type_get_instance_size(typename);
> +    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
> +    sPAPRCPUCore *core = SPAPR_CPU_CORE(OBJECT(dev));
> +    CPUCore *cc = CPU_CORE(dev);
> +    int smt = kvmppc_smt_threads();
> +    int i;
> +
> +    for (i = 0; i < cc->nr_threads; i++) {
> +        void *obj = sc->threads + i * size;
> +        DeviceState *dev = DEVICE(obj);
> +        CPUState *cs = CPU(dev);
> +        PowerPCCPU *cpu = POWERPC_CPU(cs);
> +
> +        spapr_cpu_destroy(cpu);
> +        cpu_remove_sync(cs);
> +        object_unparent(obj);
> +    }
> +
> +    spapr->cores[cc->core_id / smt] = NULL;
> +
> +    g_free(core->threads);
> +    object_unparent(OBJECT(dev));
> +}
> +

spapr_core_[un]plug() functions belong to machine code and should
be in hw/ppc/spapr.c

> +void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                       Error **errp)
> +{
> +    sPAPRCPUCore *core = SPAPR_CPU_CORE(OBJECT(dev));
> +    PowerPCCPU *cpu = POWERPC_CPU(core->threads);
> +    int id = ppc_get_vcpu_dt_id(cpu);
> +    sPAPRDRConnector *drc =
> +        spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_CPU, id);
> +    sPAPRDRConnectorClass *drck;
> +    Error *local_err = NULL;
> +
> +    g_assert(drc);
> +
> +    drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> +    drck->detach(drc, dev, spapr_core_release, NULL, &local_err);

Could you explain call flow during cpu unplug?

My expectations were that unplug_request() handler asks for CPU removal
and unplug() handler removes CPU.
It's obviously messed up somehow.

> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    spapr_hotplug_req_remove_by_index(drc);
> +}
> +
>  void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>                       Error **errp)
>  {
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
> index 7cb0515..1c9b319 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -31,4 +31,6 @@ void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>  char *spapr_get_cpu_core_type(const char *model);
>  void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>                       Error **errp);
> +void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                       Error **errp);
>  #endif
