Received: from eggs.gnu.org ([2001:4830:134:3::10]:48328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1csp0B-00045k-2V
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1csp06-00030n-U7
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:09:27 -0400
Date: Tue, 28 Mar 2017 13:09:11 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170328130911.78c2edc6@Igors-MacBook-Pro.local>
In-Reply-To: <20170328051602.GK21068@umbus.fritz.box>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-23-git-send-email-imammedo@redhat.com>
	<20170328051602.GK21068@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 22/23] numa: add '-numa cpu,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

On Tue, 28 Mar 2017 16:16:02 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Mar 22, 2017 at 02:32:47PM +0100, Igor Mammedov wrote:
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
> 
> What's the rationale for adding a new CLI, rather than adding node-id
> properties to the appropriate objects with -device, -global or -set as
> appropriate?
 '-global' applies to all cpus, while '-device,-set' applies to present
 at boot time cpus only. So they do not work for the case of possible but
 not present at boot time objects. For ACPI based targets, we need to have
 numa mapping at boot time to build ACPI SRAT table.
 I don't know if it's important for spapr/fdt, but it uses current predefined
 mapping with -numa node,cpus=x-y and new CLI hides from user internal
 cpu_index and allows to use the same properties as we use for -device cpu,...
 to define mapping to numa nodes for present/possible cpus.

> 
> > ---
> >  numa.c           | 13 +++++++++++++
> >  qapi-schema.json |  7 +++++--
> >  qemu-options.hx  | 23 ++++++++++++++++++++++-
> >  3 files changed, 40 insertions(+), 3 deletions(-)
> > 
> > diff --git a/numa.c b/numa.c
> > index 088fae3..588586b 100644
> > --- a/numa.c
> > +++ b/numa.c
> > @@ -246,6 +246,19 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
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
> > +        machine_set_cpu_numa_node(ms, &object->u.cpu, &err);
> > +        break;
> >      default:
> >          abort();
> >      }
> > diff --git a/qapi-schema.json b/qapi-schema.json
> > index a6b5955..a9a1d5e 100644
> > --- a/qapi-schema.json
> > +++ b/qapi-schema.json
> > @@ -5673,10 +5673,12 @@
> >  ##
> >  # @NumaOptionsType:
> >  #
> > +# @cpu: property based CPU(s) to node mapping (Since: 2.10)
> > +#
> >  # Since: 2.1
> >  ##
> >  { 'enum': 'NumaOptionsType',
> > -  'data': [ 'node' ] }
> > +  'data': [ 'node', 'cpu' ] }
> >  
> >  ##
> >  # @NumaOptions:
> > @@ -5689,7 +5691,8 @@
> >    'base': { 'type': 'NumaOptionsType' },
> >    'discriminator': 'type',
> >    'data': {
> > -    'node': 'NumaNodeOptions' }}
> > +    'node': 'NumaNodeOptions',
> > +    'cpu': 'CpuInstanceProperties' }}
> >  
> >  ##
> >  # @NumaNodeOptions:
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 99af8ed..2185c34 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -139,13 +139,16 @@ ETEXI
> >  
> >  DEF("numa", HAS_ARG, QEMU_OPTION_numa,
> >      "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
> > -    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n", QEMU_ARCH_ALL)
> > +    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
> > +    "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n", QEMU_ARCH_ALL)
> >  STEXI
> >  @item -numa node[,mem=@var{size}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
> >  @itemx -numa node[,memdev=@var{id}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
> > +@itemx -numa cpu,node-id=@var{node}[,socket-id=@var{x}][,core-id=@var{y}][,thread-id=@var{z}]
> >  @findex -numa
> >  Define a NUMA node and assign RAM and VCPUs to it.
> >  
> > +Legacy VCPU assignment uses @samp{cpus} option where
> >  @var{firstcpu} and @var{lastcpu} are CPU indexes. Each
> >  @samp{cpus} option represent a contiguous range of CPU indexes
> >  (or a single VCPU if @var{lastcpu} is omitted). A non-contiguous
> > @@ -159,6 +162,24 @@ a NUMA node:
> >  -numa node,cpus=0-2,cpus=5
> >  @end example
> >  
> > +@samp{cpu} option is new alternative to @samp{cpus} option
> > +uses @samp{socket-id|core-id|thread-id} properties to assign
> > +CPU objects to a @var{node} using topology layout properties of CPU.
> > +Set of properties is machine specific, and depends on used machine
> > +type/@samp{smp} options. It could be queried with @samp{hotpluggable-cpus}
> > +monitor command.
> > +@samp{node-id} property specifies @var{node} to which CPU object
> > +will be assigned, it's required for @var{node} to be declared
> > +with @samp{node} option before it's used with @samp{cpu} option.
> > +
> > +For example:
> > +@example
> > +-M pc \
> > +-smp 1,sockets=2,maxcpus=2 \
> > +-numa node,nodeid=0 -numa node,nodeid=1 \
> > +-numa cpu,node-id=0,socket-id=0 -numa cpu,node-id=1,socket-id=1
> > +@end example
> > +
> >  @samp{mem} assigns a given RAM amount to a node. @samp{memdev}
> >  assigns RAM from a given memory backend device to a node. If
> >  @samp{mem} and @samp{memdev} are omitted in all nodes, RAM is
> 
