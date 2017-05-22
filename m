Received: from eggs.gnu.org ([2001:4830:134:3::10]:53670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dCheL-0002xE-1r
	for qemu-devel@nongnu.org; Mon, 22 May 2017 03:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dCheG-0006ry-2i
	for qemu-devel@nongnu.org; Mon, 22 May 2017 03:21:05 -0400
Received: from 5.mo178.mail-out.ovh.net ([46.105.51.53]:54577)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dCheF-0006q0-G3
	for qemu-devel@nongnu.org; Mon, 22 May 2017 03:20:59 -0400
Received: from player715.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 2C2AD38352
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 09:20:51 +0200 (CEST)
References: <149518991537.24289.6673616934370284758.stgit@bahia.lan>
	<149518994738.24289.215239362416048889.stgit@bahia.lan>
	<20170522023039.GH30246@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <dad9039d-1b4c-be7f-bc49-c485b25632fa@kaod.org>
Date: Mon, 22 May 2017 09:20:42 +0200
MIME-Version: 1.0
In-Reply-To: <20170522023039.GH30246@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] spapr: fix migration of ICP objects
 from/to older QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>

On 05/22/2017 04:30 AM, David Gibson wrote:
> On Fri, May 19, 2017 at 12:32:27PM +0200, Greg Kurz wrote:
>> Commit 5bc8d26de20c ("spapr: allocate the ICPState object from under
>> sPAPRCPUCore") moved ICP objects from the machine to CPU cores. This
>> is an improvement since we no longer allocate ICP objects that will
>> never be used. But it has the side-effect of breaking migration of
>> older machine types from older QEMU versions.
>>
>> This patch introduces a compat flag in the sPAPR machine class so
>> that all pseries machine up to 2.9 go on with the previous behavior
>> of pre-allocating ICP objects.
>>
>> Signed-off-by: Greg Kurz <groug@kaod.org>
>> ---
>> v2: - s/void* /void * in xics_system_init()
>>     - don't use "[*]" in the ICP object name
>>     - use pre_2_10_ prefix in field names
>>     - added xics_nr_servers() helper
>> ---
>>  hw/ppc/spapr.c          |   40 +++++++++++++++++++++++++++++++++++++++-
>>  hw/ppc/spapr_cpu_core.c |   29 ++++++++++++++++++++---------
>>  include/hw/ppc/spapr.h  |    2 ++
>>  3 files changed, 61 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 1bb05a9a6b07..182262257c60 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -123,9 +123,15 @@ error:
>>      return NULL;
>>  }
>>  
>> +static inline int xics_nr_servers(void)
>> +{
>> +    return ppc_cpu_dt_id_from_index(max_cpus);
>> +}
>> +
>>  static void xics_system_init(MachineState *machine, int nr_irqs, Error **errp)
>>  {
>>      sPAPRMachineState *spapr = SPAPR_MACHINE(machine);
>> +    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
>>  
>>      if (kvm_enabled()) {
>>          if (machine_kernel_irqchip_allowed(machine) &&
>> @@ -147,6 +153,35 @@ static void xics_system_init(MachineState *machine, int nr_irqs, Error **errp)
>>              return;
>>          }
>>      }
>> +
>> +    if (smc->pre_2_10_icp_allocation) {
>> +        int nr_servers = xics_nr_servers();
>> +        Error *local_err = NULL;
>> +        int i;
>> +
>> +        spapr->pre_2_10_icps = g_malloc0(nr_servers * sizeof(ICPState));
>> +
>> +        for (i = 0; i < nr_servers; i++) {
>> +            void *obj = &spapr->pre_2_10_icps[i];
>> +            char *name = g_strdup_printf("icp[%d]", i);
>> +
>> +            object_initialize(obj, sizeof(ICPState), spapr->icp_type);
>> +            object_property_add_child(OBJECT(spapr), name, obj, &error_abort);
>> +            g_free(name);
>> +            object_unref(obj);
>> +            object_property_add_const_link(obj, "xics", OBJECT(spapr),
>> +                                           &error_abort);
>> +            object_property_set_bool(obj, true, "realized", &local_err);
>> +            if (local_err) {
>> +                while (i--) {
>> +                    object_unparent(obj);
>> +                }
>> +                g_free(spapr->pre_2_10_icps);
>> +                error_propagate(errp, local_err);
>> +                break;
>> +            }
>> +        }
>> +    }
>>  }
>>  
>>  static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
>> @@ -1020,7 +1055,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr,
>>      _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
>>  
>>      /* /interrupt controller */
>> -    spapr_dt_xics(ppc_cpu_dt_id_from_index(max_cpus), fdt, PHANDLE_XICP);
>> +    spapr_dt_xics(xics_nr_servers(), fdt, PHANDLE_XICP);
>>  
>>      ret = spapr_populate_memory(spapr, fdt);
>>      if (ret < 0) {
>> @@ -3286,9 +3321,12 @@ static void spapr_machine_2_9_instance_options(MachineState *machine)
>>  
>>  static void spapr_machine_2_9_class_options(MachineClass *mc)
>>  {
>> +    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
>> +
>>      spapr_machine_2_10_class_options(mc);
>>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_9);
>>      mc->numa_auto_assign_ram = numa_legacy_auto_assign_ram;
>> +    smc->pre_2_10_icp_allocation = true;
>>  }
>>  
>>  DEFINE_SPAPR_MACHINE(2_9, "2.9", false);
>> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
>> index ff7058ecc00e..13c4916aa5e6 100644
>> --- a/hw/ppc/spapr_cpu_core.c
>> +++ b/hw/ppc/spapr_cpu_core.c
>> @@ -119,6 +119,7 @@ static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
>>      size_t size = object_type_get_instance_size(typename);
>>      CPUCore *cc = CPU_CORE(dev);
>>      int i;
>> +    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>>  
>>      for (i = 0; i < cc->nr_threads; i++) {
>>          void *obj = sc->threads + i * size;
>> @@ -127,7 +128,9 @@ static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
>>          PowerPCCPU *cpu = POWERPC_CPU(cs);
>>  
>>          spapr_cpu_destroy(cpu);
>> -        object_unparent(cpu->intc);
>> +        if (!spapr->pre_2_10_icps) {
> 
> Hrm.  I dislike code for the core object directly reaching into the
> machine to check the compat flag here (and a bunch of other places
> below).  I can think of a few possible ways of avoiding this:
> 
> 1) The most direct is to make another compat flag in the cpu core
> object, set by the machine.  Straightforward, but ugly.
> 
> 2) Use a property to optionally pass a reference to the ICP array into
> the core object.  If set it will give the cpu objects ICPs from that
> array (compat mode), if not it will allocate them (new style mode).

for 2) we can just use a object_property_add_const_link() like
we do to pass the 'xics' object which is needed by the ICSes.

> 3) (Preferred, if it works)  Always have the core allocate ICPs for
> each CPU.  For compat mode instead of directly allocating ICPs, the
> machine sets up an array of pointers to the existing ICPs for each
> CPU.  The "extra" slots that don't have ICPs in new-style allocation
> get references to dummy ICP objects (maybe even all the same one).
> Only the dummy ICP(s) are allocated by the machine, the rest remain
> owned by the cpu.

I like this solution too as it should isolate the compat handling under
the machine, maybe even in a single routine.

Thanks,

C. 

> 
> 
>> +            object_unparent(cpu->intc);
>> +        }
>>          cpu_remove_sync(cs);
>>          object_unparent(obj);
>>      }
>> @@ -142,13 +145,19 @@ static void spapr_cpu_core_realize_child(Object *child, Error **errp)
>>      PowerPCCPU *cpu = POWERPC_CPU(cs);
>>      Object *obj;
>>  
>> -    obj = object_new(spapr->icp_type);
>> -    object_property_add_child(OBJECT(cpu), "icp", obj, &error_abort);
>> -    object_unref(obj);
>> -    object_property_add_const_link(obj, "xics", OBJECT(spapr), &error_abort);
>> -    object_property_set_bool(obj, true, "realized", &local_err);
>> -    if (local_err) {
>> -        goto error;
>> +    if (spapr->pre_2_10_icps) {
>> +        int index = cpu->parent_obj.cpu_index;
>> +
>> +        obj = OBJECT(&spapr->pre_2_10_icps[index]);
>> +    } else {
>> +        obj = object_new(spapr->icp_type);
>> +        object_property_add_child(OBJECT(cpu), "icp", obj, &error_abort);
>> +        object_property_add_const_link(obj, "xics", OBJECT(spapr),
>> +                                       &error_abort);
>> +        object_property_set_bool(obj, true, "realized", &local_err);
>> +        if (local_err) {
>> +            goto error;
>> +        }
>>      }
>>  
>>      object_property_set_bool(child, true, "realized", &local_err);
>> @@ -165,7 +174,9 @@ static void spapr_cpu_core_realize_child(Object *child, Error **errp)
>>      return;
>>  
>>  error:
>> -    object_unparent(obj);
>> +    if (!spapr->pre_2_10_icps) {
>> +        object_unparent(obj);
>> +    }
>>      error_propagate(errp, local_err);
>>  }
>>  
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index f875dc41d811..d1dcf0c8bddf 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -54,6 +54,7 @@ struct sPAPRMachineClass {
>>      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
>>      bool pre_2_9_cas_pvr;      /* Use old logic for PVR compat negotiation */
>>      const char *tcg_default_cpu; /* which (TCG) CPU to simulate by default */
>> +    bool pre_2_10_icp_allocation;
>>      void (*phb_placement)(sPAPRMachineState *spapr, uint32_t index,
>>                            uint64_t *buid, hwaddr *pio, 
>>                            hwaddr *mmio32, hwaddr *mmio64,
>> @@ -110,6 +111,7 @@ struct sPAPRMachineState {
>>      MemoryHotplugState hotplug_memory;
>>  
>>      const char *icp_type;
>> +    ICPState *pre_2_10_icps;
>>  };
>>  
>>  #define H_SUCCESS         0
>>
> 
