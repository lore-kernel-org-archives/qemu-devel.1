Received: from eggs.gnu.org ([2001:4830:134:3::10]:55838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dFzKw-0007LE-Df
	for qemu-devel@nongnu.org; Wed, 31 May 2017 04:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dFzKv-0003fO-Em
	for qemu-devel@nongnu.org; Wed, 31 May 2017 04:50:38 -0400
Date: Wed, 31 May 2017 10:50:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170531105027.4dc177f6@nial.brq.redhat.com>
In-Reply-To: <20170530200332.GR32274@thinpad.lan.raisama.net>
References: <1496161442-96665-1-git-send-email-imammedo@redhat.com>
	<1496161442-96665-8-git-send-email-imammedo@redhat.com>
	<20170530200332.GR32274@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 7/7] numa: cpu: calculate/set default
 node-ids after all -numa CLI options are parsed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Tue, 30 May 2017 17:03:32 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Tue, May 30, 2017 at 06:24:02PM +0200, Igor Mammedov wrote:
[...]
> > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > index 76ce021..063f329 100644
> > --- a/include/hw/boards.h
> > +++ b/include/hw/boards.h
> > @@ -94,6 +94,8 @@ typedef struct {
> >   *    Returns an array of @CPUArchId architecture-dependent CPU IDs
> >   *    which includes CPU IDs for present and possible to hotplug CPUs.
> >   *    Caller is responsible for freeing returned list.
> > + * @get_default_cpu_node_id:
> > + *    returns default board specific node_id value for CPU
> >   * @has_hotpluggable_cpus:
> >   *    If true, board supports CPUs creation with -device/device_add.
> >   * @minimum_page_bits:
> > @@ -151,6 +153,7 @@ struct MachineClass {
> >      CpuInstanceProperties (*cpu_index_to_instance_props)(MachineState *machine,
> >                                                           unsigned cpu_index);
> >      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
> > +    int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);  
> 
> Aren't we trying to move away from cpu_index-based CPU
> identification?  Shouldn't we make this get a CPUArchId argument?
it's not cpu-index but index in possible_cpus[],
it's possible to pass in CPUArchId argument and then in callbacks
compute it's index in possible_cpus[] but that seems
a bit unnecessary and would complicate callback impl.

Probably I should add doc comment explaining 'idx' meaning.

> >  };
> >  
> >  /**
> > diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> > index 610eece..ea123ef 100644
> > --- a/include/sysemu/numa.h
> > +++ b/include/sysemu/numa.h
> > @@ -36,4 +36,13 @@ void numa_legacy_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
> >  void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
> >                                    int nb_nodes, ram_addr_t size);
> >  void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **errp);
> > +
> > +static inline void assert_nb_numa_nodes_change(void)  
> 
> Can you document the purpose of this function?
> 
> > +{
> > +    static int saved_nb_numa_nodes;
> > +    assert(nb_numa_nodes);
> > +    assert(saved_nb_numa_nodes == 0 || saved_nb_numa_nodes == nb_numa_nodes);
> > +    saved_nb_numa_nodes = nb_numa_nodes;
> > +}
> > +
> >  #endif
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index ce676df..74f1453 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -1553,6 +1553,13 @@ virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
> >      return possible_cpus->cpus[cpu_index].props;
> >  }
> >  
> > +static int64_t virt_get_default_cpu_node_id(const MachineState *ms, int idx)
> > +{
> > +    assert(nb_numa_nodes);
> > +    assert_nb_numa_nodes_change();  
> 
> I would move this assert to common code instead of copying it to
> all implementations.
> 
> A machine_get_default_cpu_node_id() wrapper that calls
> assert_nb_numa_nodes_change() and mc->get_default_cpu_node_id()
> would be enough, and it wouldn't even need to be declared in a
> header as the only caller would be at hw/core/machine.c.
> 
> (Or, if you prefer to simply drop the assert(), I think that
> would be OK too.)
Callbacks are 'public' API and potentially could be called from anywhere.
Putting asserts inside of callbacks instead of the current single call site
should help to catch errors/wrong usage in future if callback were called
from elsewhere.

So I'd prefer to keep it where it's now or drop it altogether
as it's not much of use at the current call site.
 
> > +    return idx % nb_numa_nodes;
> > +}
> > +
> >  static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
> >  {
> >      int n;
[...]
