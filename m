Received: from eggs.gnu.org ([209.51.188.92]:51947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gtqFo-00025E-Bt
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gtq8F-0000ej-LX
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:43:04 -0500
Date: Wed, 13 Feb 2019 09:42:59 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190213094259.37f78c6f@redhat.com>
In-Reply-To: <20190213012544.GS1884@umbus.fritz.box>
References: <20190212214827.30543-1-lvivier@redhat.com>
	<20190212214827.30543-2-lvivier@redhat.com>
	<20190213012544.GS1884@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 1/4] numa,
 spapr: add thread-id in the possible_cpus list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, 13 Feb 2019 12:25:45 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Feb 12, 2019 at 10:48:24PM +0100, Laurent Vivier wrote:
> > spapr_possible_cpu_arch_ids() counts only cores, and so
> > the number of available CPUs is the number of vCPU divided
> > by smp_threads.
> > 
> > ... -smp 4,maxcpus=8,cores=2,threads=2,sockets=2 -numa node,cpus=0,cpus=1 \
> >                                                  -numa node,cpus=3,cpus=4 \
> >                                                  -numa node -numa node
> > 
> > This generates (info hotpluggable-cpus)
> > 
> >   node-id: 0 core-id: 0 thread-id: 0 [thread-id: 1]
> >   node-id: 0 core-id: 6 thread-id: 0 [thread-id: 1]
> >   node-id: 1 core-id: 2 thread-id: 0 [thread-id: 1]
> >   node-id: 1 core-id: 4 thread-id: 0 [thread-id: 1]
> > 
> > And this command line generates the following error:
> > 
> >   CPU(s) not present in any NUMA nodes: CPU 3 [core-id: 6]
> > 
> > That is wrong because CPU 3 [core-id: 6] is assigned to node-id 0
> > Moreover "cpus=4" is not valid, because it means core-id 8 but
> > maxcpus is 8.
> > 
> > With this patch we have now:
> > 
> >   node-id: 0 core-id: 0 thread-id: 0
> >   node-id: 0 core-id: 0 thread-id: 1
> >   node-id: 0 core-id: 1 thread-id: 0
> >   node-id: 1 core-id: 1 thread-id: 1
> >   node-id: 0 core-id: 2 thread-id: 1
> >   node-id: 1 core-id: 2 thread-id: 0
> >   node-id: 0 core-id: 3 thread-id: 1
> >   node-id: 0 core-id: 3 thread-id: 0  
> 
> I'm afraid this is not the right solution.  The point of the
> hotpluggable cpus table is that it has exactly one entry for each
> hotpluggable unit.  For PAPR that's a core, not a thread.
> 
> So, the problem is with how the NUMA configuration code is
> interpreting possible-cpus, not how the machine is building the table.

I'd suggest to deprecate/remove 'cpus' suboption in -numa.
One should use '-numa cpu' instead, which is written with
possible_cpus in mind.

> 
> > CPUs 0 (core-id: 0 thread-id: 0) and 1 (core-id: 0 thread-id: 1) are
> > correctly assigned to node-id 0, CPUs 3 (core-id: 1 thread-id: 1) and
> >  4 (core-id: 2 thread-id: 0) are correctly assigned to node-id 1.
> > All other CPUs are assigned to node-id 0 by default.
> > 
> > And the error message is also correct:
> > 
> >   CPU(s) not present in any NUMA nodes: CPU 2 [core-id: 1, thread-id: 0], \
> >                                         CPU 5 [core-id: 2, thread-id: 1], \
> >                                         CPU 6 [core-id: 3, thread-id: 0], \
> >                                         CPU 7 [core-id: 3, thread-id: 1]
> > 
> > Fixes: ec78f8114bc4 ("numa: use possible_cpus for not mapped CPUs check")
> > Cc: imammedo@redhat.com
> > 
> > Before commit ec78f8114bc4, output was correct:
> > 
> >   CPU(s) not present in any NUMA nodes: 2 5 6 7
> > 
> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > ---
> >  hw/ppc/spapr.c | 33 +++++++++++++--------------------
> >  1 file changed, 13 insertions(+), 20 deletions(-)
> > 
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 332cba89d425..7196ba09da34 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2404,15 +2404,13 @@ static void spapr_validate_node_memory(MachineState *machine, Error **errp)
> >  /* find cpu slot in machine->possible_cpus by core_id */
> >  static CPUArchId *spapr_find_cpu_slot(MachineState *ms, uint32_t id, int *idx)
> >  {
> > -    int index = id / smp_threads;
> > -
> > -    if (index >= ms->possible_cpus->len) {
> > +    if (id >= ms->possible_cpus->len) {
> >          return NULL;
> >      }
> >      if (idx) {
> > -        *idx = index;
> > +        *idx = id;
> >      }
> > -    return &ms->possible_cpus->cpus[index];
> > +    return &ms->possible_cpus->cpus[id];
> >  }
> >  
> >  static void spapr_set_vsmt_mode(sPAPRMachineState *spapr, Error **errp)
> > @@ -2514,7 +2512,7 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
> >              error_report("This machine version does not support CPU hotplug");
> >              exit(1);
> >          }
> > -        boot_cores_nr = possible_cpus->len;
> > +        boot_cores_nr = possible_cpus->len / smp_threads;
> >      }
> >  
> >      if (smc->pre_2_10_has_unused_icps) {
> > @@ -2528,7 +2526,7 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
> >          }
> >      }
> >  
> > -    for (i = 0; i < possible_cpus->len; i++) {
> > +    for (i = 0; i < possible_cpus->len / smp_threads; i++) {
> >          int core_id = i * smp_threads;
> >  
> >          if (mc->has_hotpluggable_cpus) {
> > @@ -3795,21 +3793,16 @@ spapr_cpu_index_to_props(MachineState *machine, unsigned cpu_index)
> >  
> >  static int64_t spapr_get_default_cpu_node_id(const MachineState *ms, int idx)
> >  {
> > -    return idx / smp_cores % nb_numa_nodes;
> > +    return idx / (smp_cores * smp_threads) % nb_numa_nodes;
> >  }
> >  
> >  static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
> >  {
> >      int i;
> >      const char *core_type;
> > -    int spapr_max_cores = max_cpus / smp_threads;
> > -    MachineClass *mc = MACHINE_GET_CLASS(machine);
> >  
> > -    if (!mc->has_hotpluggable_cpus) {
> > -        spapr_max_cores = QEMU_ALIGN_UP(smp_cpus, smp_threads) / smp_threads;
> > -    }
> >      if (machine->possible_cpus) {
> > -        assert(machine->possible_cpus->len == spapr_max_cores);
> > +        assert(machine->possible_cpus->len == max_cpus);
> >          return machine->possible_cpus;
> >      }
> >  
> > @@ -3820,16 +3813,16 @@ static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
> >      }
> >  
> >      machine->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
> > -                             sizeof(CPUArchId) * spapr_max_cores);
> > -    machine->possible_cpus->len = spapr_max_cores;
> > +                             sizeof(CPUArchId) * max_cpus);
> > +    machine->possible_cpus->len = max_cpus;
> >      for (i = 0; i < machine->possible_cpus->len; i++) {
> > -        int core_id = i * smp_threads;
> > -
> >          machine->possible_cpus->cpus[i].type = core_type;
> >          machine->possible_cpus->cpus[i].vcpus_count = smp_threads;
> > -        machine->possible_cpus->cpus[i].arch_id = core_id;
> > +        machine->possible_cpus->cpus[i].arch_id = i;
> >          machine->possible_cpus->cpus[i].props.has_core_id = true;
> > -        machine->possible_cpus->cpus[i].props.core_id = core_id;
> > +        machine->possible_cpus->cpus[i].props.core_id = i / smp_threads;
> > +        machine->possible_cpus->cpus[i].props.has_thread_id = true;
> > +        machine->possible_cpus->cpus[i].props.thread_id = i % smp_threads;
> >      }
> >      return machine->possible_cpus;
> >  }  
> 
