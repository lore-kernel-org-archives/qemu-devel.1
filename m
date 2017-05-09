Received: from eggs.gnu.org ([2001:4830:134:3::10]:42880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d87X8-00043H-FB
	for qemu-devel@nongnu.org; Tue, 09 May 2017 11:58:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d87X7-0008Ce-Be
	for qemu-devel@nongnu.org; Tue, 09 May 2017 11:58:42 -0400
Date: Tue, 9 May 2017 17:58:29 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170509175829.23fcc112@nial.brq.redhat.com>
In-Reply-To: <20170508054004.GE25748@umbus.fritz.box>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
	<1493816238-33120-24-git-send-email-imammedo@redhat.com>
	<20170508054004.GE25748@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 23/24] numa: add '-numa cpu,
 ...' option for property based node mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 8 May 2017 15:40:04 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, May 03, 2017 at 02:57:17PM +0200, Igor Mammedov wrote:
> > legacy cpu to node mapping is using cpu index values to map
> > VCPU to node with help of '-numa node,nodeid=node,cpus=x[-y]'
> > option. However cpu index is internal concept and QEMU users
> > have to guess /reimplement qemu's logic/ to map it to
> > a concrete cpu socket/core/thread to make sane CPUs
> > placement across numa nodes.
> > 
> > This patch allows to map cpu objects to numa nodes using
> > the same properties as used for cpus with -device/device_add
> > (socket-id/core-id/thread-id/node-id).
> > 
> > At present valid properties/values to address CPUs could be
> > fetched using hotpluggable-cpus monitor/qmp command, it will
> > require user to start qemu twice when creating domain to fetch
> > possible CPUs for a machine type/-smp layout first and
> > then the second time with numa explicit mapping for actual
> > usage. The first step results could be saved and reused to
> > set/change mapping later as far as machine type/-smp stays
> > the same.
> > 
> > Proposed impl. supports exact and wildcard matching to
> > simplify CLI and allow to set mapping for a specific cpu
> > or group of cpu objects specified by matched properties.
> > 
> > For example:
> > 
> >    # exact mapping x86
> >    -numa cpu,node-id=x,socket-id=y,core-id=z,thread-id=n
> > 
> >    # exact mapping SPAPR
> >    -numa cpu,node-id=x,core-id=y
> > 
> >    # wildcard mapping, all cpu objects that match socket-id=y
> >    # are mapped to node-id=x
> >    -numa cpu,node-id=x,socket-id=y
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > v2:
> >   - use new NumaCpuOptions instead of CpuInstanceProperties in
> >     NumaOptions, so that in future we could decouple both
> >     if needed. (Eduardo Habkost <ehabkost@redhat.com>)
> >   - clarify effect of NumaCpuOptions.node-id in qapi-schema.json
> > ---
> >  numa.c           | 25 +++++++++++++++++++++++++
> >  qapi-schema.json | 21 +++++++++++++++++++--
> >  qemu-options.hx  | 23 ++++++++++++++++++++++-
> >  3 files changed, 66 insertions(+), 3 deletions(-)
> > 
> > diff --git a/numa.c b/numa.c
> > index 40e9f44..61521f5 100644
> > --- a/numa.c
> > +++ b/numa.c
> > @@ -227,6 +227,7 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
> >      NumaOptions *object = NULL;
> >      MachineState *ms = opaque;
> >      Error *err = NULL;
> > +    CpuInstanceProperties cpu;
> >  
> >      {
> >          Visitor *v = opts_visitor_new(opts);
> > @@ -246,6 +247,30 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
> >          }
> >          nb_numa_nodes++;
> >          break;
> > +    case NUMA_OPTIONS_TYPE_CPU:
> > +        if (!object->u.cpu.has_node_id) {
> > +            error_setg(&err, "Missing mandatory node-id property");
> > +            goto end;
> > +        }
> > +        if (!numa_info[object->u.cpu.node_id].present) {
> > +            error_setg(&err, "Invalid node-id=%" PRId64 ", NUMA node must be "
> > +                "defined with -numa node,nodeid=ID before it's used with "
> > +                "-numa cpu,node-id=ID", object->u.cpu.node_id);
> > +            goto end;
> > +        }
> > +
> > +        memset(&cpu, 0, sizeof(cpu));
> > +        cpu.has_node_id = object->u.cpu.has_node_id;
> > +        cpu.node_id = object->u.cpu.node_id;
> > +        cpu.has_socket_id = object->u.cpu.has_socket_id;
> > +        cpu.socket_id = object->u.cpu.socket_id;
> > +        cpu.has_core_id = object->u.cpu.has_core_id;
> > +        cpu.core_id = object->u.cpu.core_id;
> > +        cpu.has_thread_id = object->u.cpu.has_thread_id;
> > +        cpu.thread_id = object->u.cpu.thread_id;
> > +
> > +        machine_set_cpu_numa_node(ms, &cpu, &err);  
> 
> It's possible I've confused myself by not looking at this whole series
> at once.
> 
> But, would it be possible to make a single machine hook which maps a
> constructed cpu property set to a "canonical" cpu property set from
> the table of CPU slots (or errors, of course).  That would let you do
> what you need here, and I suspect in other places, without multiple
> hooks.
Not sure that get question.

if it's about machine_set_cpu_numa_node() than it's a single generic
setter of MachineState::possible_cpus(node-id) from non machine code
and the only place it's supposed to be used is from numa configuration
code. I don't see any need to reuse it for something/somewhere else
so far.

More over it's not 1:1 mapping wrt input:affected slots,
it's 1:[1-n] where input could affect multiple slots.

I think I've tried to get machine return a list of cpu slots
and then deal with them in numa.c but result looked messy and
not to my liking.
Eventually I stopped on machine_set_cpu_numa_node() variant
as the cleanest for now.
