Received: from eggs.gnu.org ([2001:4830:134:3::10]:47597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dFhkx-0001aJ-CT
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dFhkp-0000Qn-Mn
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:04:19 -0400
Date: Tue, 30 May 2017 11:04:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170530140401.GJ32274@thinpad.lan.raisama.net>
References: <1494415802-227633-1-git-send-email-imammedo@redhat.com>
	<1494415802-227633-7-git-send-email-imammedo@redhat.com>
	<20170526154625.GI22043@thinpad.lan.raisama.net>
	<20170530141329.60d728c6@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170530141329.60d728c6@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 06/18] numa: mirror cpu to node mapping
 in MachineState::possible_cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Tue, May 30, 2017 at 02:13:29PM +0200, Igor Mammedov wrote:
> On Fri, 26 May 2017 12:46:25 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Wed, May 10, 2017 at 01:29:50PM +0200, Igor Mammedov wrote:
> > [...]
> > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > index 2482c63..420c8c4 100644
> > > --- a/hw/core/machine.c
> > > +++ b/hw/core/machine.c
> > > @@ -389,6 +389,102 @@ HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine)  
> > [...]
> > > +void machine_set_cpu_numa_node(MachineState *machine,
> > > +                               const CpuInstanceProperties *props, Error **errp)
> > > +{  
> > [...]
> > > +    /* force board to initialize possible_cpus if it hasn't been done yet */
> > > +    mc->possible_cpu_arch_ids(machine);  
> > [...]
> > > diff --git a/numa.c b/numa.c
> > > index 7182481..7db5dde 100644
> > > --- a/numa.c
> > > +++ b/numa.c
> > > @@ -170,6 +170,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
> > >          exit(1);
> > >      }
> > >      for (cpus = node->cpus; cpus; cpus = cpus->next) {
> > > +        CpuInstanceProperties props;
> > >          if (cpus->value >= max_cpus) {
> > >              error_setg(errp,
> > >                         "CPU index (%" PRIu16 ")"
> > > @@ -178,6 +179,10 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
> > >              return;
> > >          }
> > >          bitmap_set(numa_info[nodenr].node_cpu, cpus->value, 1);
> > > +        props = mc->cpu_index_to_instance_props(ms, cpus->value);
> > > +        props.node_id = nodenr;
> > > +        props.has_node_id = true;
> > > +        machine_set_cpu_numa_node(ms, &props, &error_fatal);  
> > 
> > This triggers a call to possible_cpu_arch_ids() before
> > nb_numa_nodes is set to the actual number of NUMA nodes in the
> > machine, breaking the "node_id = ... % nb_numa_nodes"
> > initialization logic in pc, virt, and spapr.
> Looking at it more, in current code this problem theoretically
> affects only partial mapping case. And even there it's masked by 
> fixup to 0 node for non explicitly mapped CPUs and the bug which
>  *) "[PATCH v2 3/5] numa: make sure that all cpus in has  has_node_id set if numa is enabled"
> fixes. So invalid default values for non mapped cpus are stored
> in possible_cpus but not used nor visible elsewhere.
> 
> [*] as side effect fixes invalid defaults in possible_cpus as well
> by fixup to 0 node that's moved from pre_plug handler.
> 
> In future we are going to remove partial mapping with fixup to 0
> and fetch default mappings from possible_cpus where these wrong
> defaults won't exists (or matter) as CPUs are going to either
>  1) be all explicitly mapped (so all node_id values are overwritten)
> or
>  2) all default mapped (where defaults will be correct since no
>     -numa cpu=/-numa node,cpus= were called), but that's fragile
>     so I'd add calculate defaults at machine_run_board_init()
>     time anyway.

Your analysis seems correct: it looks like just a case of fragile
code, not a bug that can be triggered with the current code.

-- 
Eduardo
