Received: from eggs.gnu.org ([2001:4830:134:3::10]:40233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d7jwQ-0008E2-Cg
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:47:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d7jwP-0007v3-9N
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:47:14 -0400
Date: Mon, 8 May 2017 11:47:02 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170508144702.GT3482@thinpad.lan.raisama.net>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
	<1493816238-33120-24-git-send-email-imammedo@redhat.com>
	<20170508054004.GE25748@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170508054004.GE25748@umbus.fritz.box>
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

On Mon, May 08, 2017 at 03:40:04PM +1000, David Gibson wrote:
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

I think I understand your point, but I don't see where any
opportunities to reuse a more generic hook in the current series.

I see only two new hooks added by this series:
1) MachineClass::cpu_index_to_instance_props()
2) machine_set_cpu_numa_node()

The former takes only one cpu_index argument as input. As it
needs to be a machine-specific hook, I think it's good to keep
its input as simple and specific as possible.

The latter could use a generic lookup function to map
CpuInstanceProperties to a set of CPU slots. But I don't see any
case where that logic would be reused by now, so I don't think
it's worth the extra complexity.

-- 
Eduardo
