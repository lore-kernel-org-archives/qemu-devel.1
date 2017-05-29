Received: from eggs.gnu.org ([2001:4830:134:3::10]:44139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dFJXe-0001Ti-8B
	for qemu-devel@nongnu.org; Mon, 29 May 2017 08:13:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dFJXc-0001py-R2
	for qemu-devel@nongnu.org; Mon, 29 May 2017 08:12:58 -0400
Date: Mon, 29 May 2017 14:12:47 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170529141247.303efd89@nial.brq.redhat.com>
In-Reply-To: <20170526182522.GV32274@thinpad.lan.raisama.net>
References: <1495550330-34087-1-git-send-email-imammedo@redhat.com>
	<1495550330-34087-6-git-send-email-imammedo@redhat.com>
	<20170526182522.GV32274@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/5] numa: move numa_node from CPUState
 into target specific classes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>

On Fri, 26 May 2017 15:25:22 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Tue, May 23, 2017 at 04:38:50PM +0200, Igor Mammedov wrote:
> > Move vcpu's assocciated numa_node field out of generic CPUState
> > into inherited classes that actually care about cpu<->numa mapping,
> > i.e: ARMCPU, PowerPCCPU, X86CPU.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  include/qom/cpu.h       |  2 --
> >  target/arm/cpu.h        |  2 ++
> >  target/i386/cpu.h       |  1 +
> >  target/ppc/cpu.h        |  1 +
> >  hw/ppc/spapr.c          | 24 +++++++++++-------------
> >  hw/ppc/spapr_cpu_core.c |  4 +++-
> >  monitor.c               | 11 +++++++----
> >  target/arm/cpu.c        |  2 +-
> >  target/i386/cpu.c       |  2 +-
> >  9 files changed, 27 insertions(+), 22 deletions(-)
> > 
> > diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> > index 55214ce..89ddb68 100644
> > --- a/include/qom/cpu.h
> > +++ b/include/qom/cpu.h
> > @@ -265,7 +265,6 @@ struct qemu_work_item;
> >   * @cpu_index: CPU index (informative).
> >   * @nr_cores: Number of cores within this CPU package.
> >   * @nr_threads: Number of threads within this CPU.
> > - * @numa_node: NUMA node this CPU is belonging to.
> >   * @host_tid: Host thread ID.
> >   * @running: #true if CPU is currently running (lockless).
> >   * @has_waiter: #true if a CPU is currently waiting for the cpu_exec_end;
> > @@ -314,7 +313,6 @@ struct CPUState {
> >  
> >      int nr_cores;
> >      int nr_threads;
> > -    int numa_node;
> >  
> >      struct QemuThread *thread;
> >  #ifdef _WIN32
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index 048faed..5ffc9d8 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -703,6 +703,8 @@ struct ARMCPU {
> >  
> >      ARMELChangeHook *el_change_hook;
> >      void *el_change_hook_opaque;
> > +
> > +    int32_t node_id; /* NUMA node this CPU is belonging to */
> >  };
> >  
> >  static inline ARMCPU *arm_env_get_cpu(CPUARMState *env)
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index c4602ca..00f35a0 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -1278,6 +1278,7 @@ struct X86CPU {
> >      int32_t socket_id;
> >      int32_t core_id;
> >      int32_t thread_id;
> > +    int32_t node_id; /* NUMA node this CPU is belonging to */  
> 
> I suggest placing this before socket_id, so it follows the
> logical topology order: node, socket, core, thread.
ok

> 
> >  };
> >  
> >  static inline X86CPU *x86_env_get_cpu(CPUX86State *env)
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index 401e10e..31c052d 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -1205,6 +1205,7 @@ struct PowerPCCPU {
> >      uint32_t compat_pvr;
> >      PPCVirtualHypervisor *vhyp;
> >      Object *intc;
> > +    int32_t node_id; /* NUMA node this CPU is belonging to */
> >  
> >      /* Fields related to migration compatibility hacks */
> >      bool pre_2_8_migration;
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index c7fee8b..96a2a74 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -178,25 +178,19 @@ static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
> >      return ret;
> >  }
> >  
> > -static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, CPUState *cs)
> > +static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, PowerPCCPU *cpu)
> >  {
> > -    int ret = 0;
> > -    PowerPCCPU *cpu = POWERPC_CPU(cs);
> >      int index = ppc_get_vcpu_dt_id(cpu);
> >      uint32_t associativity[] = {cpu_to_be32(0x5),
> >                                  cpu_to_be32(0x0),
> >                                  cpu_to_be32(0x0),
> >                                  cpu_to_be32(0x0),
> > -                                cpu_to_be32(cs->numa_node),
> > +                                cpu_to_be32(cpu->node_id),
> >                                  cpu_to_be32(index)};
> >  
> >      /* Advertise NUMA via ibm,associativity */
> > -    if (nb_numa_nodes > 1) {
> > -        ret = fdt_setprop(fdt, offset, "ibm,associativity", associativity,  
> 
> Commit message says we're just moving fields to other structs.
> If you want to change the existing logic, please do it in a
> separate patch.
ok, I'll split the patch.

> 
> > +    return fdt_setprop(fdt, offset, "ibm,associativity", associativity,
> >                            sizeof(associativity));
> > -    }
> > -
> > -    return ret;
> >  }
> >  
> >  /* Populate the "ibm,pa-features" property */
> > @@ -321,9 +315,11 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
> >              return ret;
> >          }
> >  
> > -        ret = spapr_fixup_cpu_numa_dt(fdt, offset, cs);
> > -        if (ret < 0) {
> > -            return ret;
> > +        if (nb_numa_nodes > 1) {
> > +            ret = spapr_fixup_cpu_numa_dt(fdt, offset, cpu);  
> 
> Ditto.
> 
> > +            if (ret < 0) {
> > +                return ret;
> > +            }
> >          }
> >  
> >          ret = spapr_fixup_cpu_smt_dt(fdt, offset, cpu, compat_smt);
> > @@ -538,7 +534,9 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
> >      _FDT((fdt_setprop(fdt, offset, "ibm,pft-size",
> >                        pft_size_prop, sizeof(pft_size_prop))));
> >  
> > -    _FDT(spapr_fixup_cpu_numa_dt(fdt, offset, cs));
> > +    if (nb_numa_nodes > 1) {  
> 
> Ditto.
> 
> > +        _FDT(spapr_fixup_cpu_numa_dt(fdt, offset, cpu));
> > +    }
> >  
> >      _FDT(spapr_fixup_cpu_smt_dt(fdt, offset, cpu, compat_smt));
> >  
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index a17ea07..60baf02 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -183,15 +183,17 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
> >      for (i = 0; i < cc->nr_threads; i++) {
> >          char id[32];
> >          CPUState *cs;
> > +        PowerPCCPU *cpu;
> >  
> >          obj = sc->threads + i * size;
> >  
> >          object_initialize(obj, size, typename);
> >          cs = CPU(obj);
> > +        cpu = POWERPC_CPU(cs);
> >          cs->cpu_index = cc->core_id + i;
> >  
> >          /* Set NUMA node for the threads belonged to core  */
> > -        cs->numa_node = sc->node_id;
> > +        cpu->node_id = sc->node_id;
> >  
> >          snprintf(id, sizeof(id), "thread[%d]", i);
> >          object_property_add_child(OBJECT(sc), id, obj, &local_err);
> > diff --git a/monitor.c b/monitor.c
> > index afbacfe..b053c40 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -1697,23 +1697,26 @@ static void hmp_info_mtree(Monitor *mon, const QDict *qdict)
> >  static void hmp_info_numa(Monitor *mon, const QDict *qdict)
> >  {
> >      int i;
> > -    CPUState *cpu;
> >      uint64_t *node_mem;
> > +    CpuInfoList *cpu_list, *cpu;
> >  
> > +    cpu_list = qmp_query_cpus(&error_abort);
> >      node_mem = g_new0(uint64_t, nb_numa_nodes);
> >      query_numa_node_mem(node_mem);
> >      monitor_printf(mon, "%d nodes\n", nb_numa_nodes);
> >      for (i = 0; i < nb_numa_nodes; i++) {
> >          monitor_printf(mon, "node %d cpus:", i);
> > -        CPU_FOREACH(cpu) {
> > -            if (cpu->numa_node == i) {
> > -                monitor_printf(mon, " %d", cpu->cpu_index);
> > +        for (cpu = cpu_list; cpu; cpu = cpu->next) {
> > +            if (cpu->value->has_props && cpu->value->props->has_node_id &&
> > +                cpu->value->props->node_id == i) {
> > +                monitor_printf(mon, " %" PRIi64, cpu->value->CPU);  
> 
> I suggest moving this to a separate patch, too.
ok

> 
> >              }
> >          }
> >          monitor_printf(mon, "\n");
> >          monitor_printf(mon, "node %d size: %" PRId64 " MB\n", i,
> >                         node_mem[i] >> 20);
> >      }
> > +    qapi_free_CpuInfoList(cpu_list);
> >      g_free(node_mem);
> >  }
> >  
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index c185eb1..09ef3a6 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -1573,7 +1573,7 @@ static Property arm_cpu_properties[] = {
> >      DEFINE_PROP_UINT32("midr", ARMCPU, midr, 0),
> >      DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
> >                          mp_affinity, ARM64_AFFINITY_INVALID),
> > -    DEFINE_PROP_INT32("node-id", CPUState, numa_node, CPU_UNSET_NUMA_NODE_ID),
> > +    DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
> >      DEFINE_PROP_END_OF_LIST()
> >  };
> >  
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index a41d595..ffb5267 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -3986,7 +3986,7 @@ static Property x86_cpu_properties[] = {
> >      DEFINE_PROP_INT32("core-id", X86CPU, core_id, -1),
> >      DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, -1),
> >  #endif
> > -    DEFINE_PROP_INT32("node-id", CPUState, numa_node, CPU_UNSET_NUMA_NODE_ID),
> > +    DEFINE_PROP_INT32("node-id", X86CPU, node_id, CPU_UNSET_NUMA_NODE_ID),
> >      DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
> >      { .name  = "hv-spinlocks", .info  = &qdev_prop_spinlocks },
> >      DEFINE_PROP_BOOL("hv-relaxed", X86CPU, hyperv_relaxed_timing, false),
> > -- 
> > 2.7.4
> >   
> 
