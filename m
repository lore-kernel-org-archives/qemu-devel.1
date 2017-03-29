Received: from eggs.gnu.org ([2001:4830:134:3::10]:47410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <he.chen@linux.intel.com>) id 1ct9Ig-0003xw-5u
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <he.chen@linux.intel.com>) id 1ct9Id-00049u-17
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:49:54 -0400
Date: Wed, 29 Mar 2017 16:50:00 +0800
From: He Chen <he.chen@linux.intel.com>
Message-ID: <20170329085000.GA20377@he>
References: <1490175166-19785-1-git-send-email-he.chen@linux.intel.com>
	<20170323102955.5e2d1c65@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323102955.5e2d1c65@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] Allow setting NUMA distance for
 different NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>, Richard Henderson <rth@twiddle.net>

On Thu, Mar 23, 2017 at 10:29:55AM +0100, Igor Mammedov wrote:
> On Wed, 22 Mar 2017 17:32:46 +0800
> He Chen <he.chen@linux.intel.com> wrote:
> 
> > Current, QEMU does not provide a clear command to set vNUMA distance for
> > guest although we already have `-numa` command to set vNUMA nodes.
> > 
> > vNUMA distance makes sense in certain scenario.
> > But now, if we create a guest that has 4 vNUMA nodes, when we check NUMA
> > info via `numactl -H`, we will see:
> > 
> > node distance:
> > node    0    1    2    3
> >   0:   10   20   20   20
> >   1:   20   10   20   20
> >   2:   20   20   10   20
> >   3:   20   20   20   10
> > 
> > Guest kernel regards all local node as distance 10, and all remote node
> > as distance 20 when there is no SLIT table since QEMU doesn't build it.
> > It looks like a little strange when you have seen the distance in an
> > actual physical machine that contains 4 NUMA nodes. My machine shows:
> > 
> > node distance:
> > node    0    1    2    3
> >   0:   10   21   31   41
> >   1:   21   10   21   31
> >   2:   31   21   10   21
> >   3:   41   31   21   10
> > 
> > To set vNUMA distance, guest should see a complete SLIT table.
> > I found QEMU has provide `-acpitable` command that allows users to add
> > a ACPI table into guest, but it requires users building ACPI table by
> > themselves first. Using `-acpitable` to add a SLIT table may be not so
> > straightforward or flexible, imagine that when the vNUMA configuration
> > is changes and we need to generate another SLIT table manually. It may
> > not be friendly to users or upper software like libvirt.
> > 
> > This patch is going to add SLIT table support in QEMU, and provides
> > additional option `dist` for command `-numa` to allow user set vNUMA
> > distance by QEMU command.
> > 
> > With this patch, when a user wants to create a guest that contains
> > several vNUMA nodes and also wants to set distance among those nodes,
> > the QEMU command would like:
> > 
> > ```
> > -object memory-backend-ram,size=1G,prealloc=yes,host-nodes=0,policy=bind,id=node0 \
> > -numa node,nodeid=0,cpus=0,memdev=node0 \
> > -object memory-backend-ram,size=1G,prealloc=yes,host-nodes=1,policy=bind,id=node1 \
> > -numa node,nodeid=1,cpus=1,memdev=node1 \
> > -object memory-backend-ram,size=1G,prealloc=yes,host-nodes=2,policy=bind,id=node2 \
> > -numa node,nodeid=2,cpus=2,memdev=node2 \
> > -object memory-backend-ram,size=1G,prealloc=yes,host-nodes=3,policy=bind,id=node3 \
> > -numa node,nodeid=3,cpus=3,memdev=node3 \
> > -numa dist,src=0,dst=1,val=21 \
> > -numa dist,src=0,dst=2,val=31 \
> > -numa dist,src=0,dst=3,val=41 \
> > -numa dist,src=1,dst=0,val=21 \
> > ...
> > ```
> > 
> > Signed-off-by: He Chen <he.chen@linux.intel.com>
> > 
> > fix
> > ---
> >  hw/acpi/aml-build.c         | 26 +++++++++++++++++++++++++
> >  hw/arm/virt-acpi-build.c    |  2 ++
> >  hw/i386/acpi-build.c        |  2 ++
> >  include/hw/acpi/aml-build.h |  1 +
> >  include/sysemu/numa.h       |  1 +
> >  include/sysemu/sysemu.h     |  4 ++++
> >  numa.c                      | 47 +++++++++++++++++++++++++++++++++++++++++++++
> >  qapi-schema.json            | 30 ++++++++++++++++++++++++++---
> >  qemu-options.hx             | 12 +++++++++++-
> >  9 files changed, 121 insertions(+), 4 deletions(-)
> > 
> > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> > index c6f2032..410b30e 100644
> > --- a/hw/acpi/aml-build.c
> > +++ b/hw/acpi/aml-build.c
> > @@ -24,6 +24,7 @@
> >  #include "hw/acpi/aml-build.h"
> >  #include "qemu/bswap.h"
> >  #include "qemu/bitops.h"
> > +#include "sysemu/numa.h"
> >  
> >  static GArray *build_alloc_array(void)
> >  {
> > @@ -1609,3 +1610,28 @@ void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
> >      numamem->base_addr = cpu_to_le64(base);
> >      numamem->range_length = cpu_to_le64(len);
> >  }
> > +
> > +/*
> > + * ACPI spec 5.2.17 System Locality Distance Information Table
> > + * (Revision 2.0 or later)
> > + */
> > +void build_slit(GArray *table_data, BIOSLinker *linker)
> > +{
> > +    int slit_start, i, j;
> > +    slit_start = table_data->len;
> > +
> > +    acpi_data_push(table_data, sizeof(AcpiTableHeader));
> > +
> > +    build_append_int_noprefix(table_data, nb_numa_nodes, 8);
> > +    for (i = 0; i < nb_numa_nodes; i++) {
> > +        for (j = 0; j < nb_numa_nodes; j++) {
> > +            build_append_int_noprefix(table_data, numa_info[i].distance[j], 1);
> > +        }
> > +    }
> > +
> > +    build_header(linker, table_data,
> > +                 (void *)(table_data->data + slit_start),
> > +                 "SLIT",
> > +                 table_data->len - slit_start, 1, NULL, NULL);
> > +}
> > +
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index 0835e59..d9e6828 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -781,6 +781,8 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
> >      if (nb_numa_nodes > 0) {
> >          acpi_add_table(table_offsets, tables_blob);
> >          build_srat(tables_blob, tables->linker, vms);
> > +        acpi_add_table(table_offsets, tables_blob);
> > +        build_slit(tables_blob, tables->linker);
> >      }
> >  
> >      if (its_class_name() && !vmc->no_its) {
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 2073108..12730ea 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -2678,6 +2678,8 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
> >      if (pcms->numa_nodes) {
> >          acpi_add_table(table_offsets, tables_blob);
> >          build_srat(tables_blob, tables->linker, machine);
> > +        acpi_add_table(table_offsets, tables_blob);
> > +        build_slit(tables_blob, tables->linker);
> >      }
> >      if (acpi_get_mcfg(&mcfg)) {
> >          acpi_add_table(table_offsets, tables_blob);
> > diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> > index 00c21f1..329a0d0 100644
> > --- a/include/hw/acpi/aml-build.h
> > +++ b/include/hw/acpi/aml-build.h
> > @@ -389,4 +389,5 @@ GCC_FMT_ATTR(2, 3);
> >  void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
> >                         uint64_t len, int node, MemoryAffinityFlags flags);
> >  
> > +void build_slit(GArray *table_data, BIOSLinker *linker);
> >  #endif
> > diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> > index 8f09dcf..2f7a941 100644
> > --- a/include/sysemu/numa.h
> > +++ b/include/sysemu/numa.h
> > @@ -21,6 +21,7 @@ typedef struct node_info {
> >      struct HostMemoryBackend *node_memdev;
> >      bool present;
> >      QLIST_HEAD(, numa_addr_range) addr; /* List to store address ranges */
> > +    uint8_t distance[MAX_NODES];
> >  } NodeInfo;
> >  
> >  extern NodeInfo numa_info[MAX_NODES];
> > diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> > index 576c7ce..a4e328d 100644
> > --- a/include/sysemu/sysemu.h
> > +++ b/include/sysemu/sysemu.h
> > @@ -169,6 +169,10 @@ extern int mem_prealloc;
> >  
> >  #define MAX_NODES 128
> >  #define NUMA_NODE_UNASSIGNED MAX_NODES
> > +#define MIN_NUMA_DISTANCE 10
> > +#define DEF_NUMA_DISTANCE 20
> > +#define MAX_NUMA_DISTANCE 254
> > +#define NUMA_DISTANCE_UNREACHABLE 255
> >  
> >  #define MAX_OPTION_ROMS 16
> >  typedef struct QEMUOptionRom {
> > diff --git a/numa.c b/numa.c
> > index e01cb54..425a320 100644
> > --- a/numa.c
> > +++ b/numa.c
> > @@ -212,6 +212,28 @@ static void numa_node_parse(NumaNodeOptions *node, QemuOpts *opts, Error **errp)
> >      max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
> >  }
> >  
> > +static void numa_distance_parse(NumaDistOptions *dist, QemuOpts *opts, Error **errp)
> > +{
> > +    uint64_t src = dist->src;
> > +    uint64_t dst = dist->dst;
> > +    uint8_t val = dist->val;
> > +
> > +    if (src >= MAX_NODES || dst >= MAX_NODES) {
> this allows to specify any src/dst instead of present nodes only,
> you should probably check that src/dst are present here,
> see: numa_info[x].present
> 
> if node is not present complain that it should be declared with
> '-numa node' option first and exit.
> 
Thanks for pointing out this.

> > +        error_setg(errp, "Max number of NUMA nodes reached: %"
> > +                   PRIu64 "", src > dst ? src : dst);
> > +        return;
> > +    }
> > +
> > +    if (val < MIN_NUMA_DISTANCE || val > MAX_NUMA_DISTANCE) {
> > +        error_setg(errp,
> > +                "NUMA distance (%" PRIu8 ") out of range (%d) ~ (%d)",
> > +                dist->val, MIN_NUMA_DISTANCE, MAX_NUMA_DISTANCE);
> > +        return;
> > +    }
> > +
> > +    numa_info[src].distance[dst] = val;
> > +}
> > +
> >  static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
> >  {
> >      NumaOptions *object = NULL;
> > @@ -235,6 +257,12 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
> >          }
> >          nb_numa_nodes++;
> >          break;
> > +    case NUMA_OPTIONS_TYPE_DIST:
> > +        numa_distance_parse(&object->u.dist, opts, &err);
> > +        if (err) {
> > +            goto end;
> > +        }
> > +        break;
> >      default:
> >          abort();
> >      }
> > @@ -294,6 +322,24 @@ static void validate_numa_cpus(void)
> >      g_free(seen_cpus);
> >  }
> >  
> > +static void default_numa_distance(void)
> > +{
> > +    int src, dst;
> > +
> fill in defaults only if there weren't any '-numa dist' on CLI
> and refuse to start if partial filled table were explicitly provided on CLI
> 
I am afraid that I may have a bad function name here, fill_numa_distance
might be a better name?

Also, since the distance can be asymmetric, IMHO, providing a partial
filled table looks fine. If we set many NUMA nodes e.g. 8 nodes for
guest, the whole filled table would require many command lines which
might be inconvenient and less flexible.
Please correct me if I am wrong, thanks.
> > +    for (src = 0; src < nb_numa_nodes; src++) {
> > +        for (dst = 0; dst < nb_numa_nodes; dst++) {
> > +            if (src == dst && numa_info[src].distance[dst] != MIN_NUMA_DISTANCE) {
> > +                numa_info[src].distance[dst] = MIN_NUMA_DISTANCE;
> > +            } else if (numa_info[src].distance[dst] <= MIN_NUMA_DISTANCE) {
> > +                if (numa_info[dst].distance[src] > MIN_NUMA_DISTANCE)
> > +                    numa_info[src].distance[dst] = numa_info[dst].distance[src];
> > +                else
> > +                    numa_info[src].distance[dst] = DEF_NUMA_DISTANCE;
> > +            }
> > +        }
> > +    }
> > +}
> > +
> >  void parse_numa_opts(MachineClass *mc)
> >  {
> >      int i;
> > @@ -390,6 +436,7 @@ void parse_numa_opts(MachineClass *mc)
> >          }
> >  
> >          validate_numa_cpus();
> > +        default_numa_distance();
> >      } else {
> >          numa_set_mem_node_id(0, ram_size, 0);
> >      }
> > diff --git a/qapi-schema.json b/qapi-schema.json
> > index 32b4a4b..21ad94a 100644
> > --- a/qapi-schema.json
> > +++ b/qapi-schema.json
> > @@ -5644,15 +5644,19 @@
> >  ##
> >  # @NumaOptionsType:
> >  #
> > +# @node: NUMA nodes configuration
> > +#
> > +# @dist: NUMA distance configuration
> > +#
> >  # Since: 2.1
> >  ##
> >  { 'enum': 'NumaOptionsType',
> > -  'data': [ 'node' ] }
> > +  'data': [ 'node', 'dist' ] }
> >  
> >  ##
> >  # @NumaOptions:
> >  #
> > -# A discriminated record of NUMA options. (for OptsVisitor)
> > +# A discriminated record of NUMA options.
> unrelated change?
> 
> >  #
> >  # Since: 2.1
> >  ##
> > @@ -5660,7 +5664,8 @@
> >    'base': { 'type': 'NumaOptionsType' },
> >    'discriminator': 'type',
> >    'data': {
> > -    'node': 'NumaNodeOptions' }}
> > +    'node': 'NumaNodeOptions',
> > +    'dist': 'NumaDistOptions' }}
> >  
> >  ##
> >  # @NumaNodeOptions:
> > @@ -5689,6 +5694,25 @@
> >     '*memdev': 'str' }}
> >  
> >  ##
> > +# @NumaDistOptions:
> > +#
> > +# Set distance between 2 NUMA nodes. (for OptsVisitor)
> > +#
> > +# @src: source NUMA node.
> > +#
> > +# @dst: destination NUMA node.
> > +#
> > +# @val: NUMA distance from source node to destination node.
> > +#
> > +# Since: 2.10
> > +##
> > +{ 'struct': 'NumaDistOptions',
> > +  'data': {
> > +   'src': 'uint64',
> > +   'dst': 'uint64',
> nodeid is uint16, so probably these should be also uint16
> 
> 
> > +   'val': 'uint8' }}
> > +
> > +##
> >  # @HostMemPolicy:
> >  #
> >  # Host memory policy types
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 8dd8ee3..43c3950 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -139,12 +139,15 @@ ETEXI
> >  
> >  DEF("numa", HAS_ARG, QEMU_OPTION_numa,
> >      "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
> > -    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n", QEMU_ARCH_ALL)
> > +    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
> > +    "-numa dist,src=source,dst=destination,val=distance\n", QEMU_ARCH_ALL)
> >  STEXI
> >  @item -numa node[,mem=@var{size}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
> >  @itemx -numa node[,memdev=@var{id}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
> > +@itemx -numa dist,src=@var{source},dst=@var{destination},val=@var{distance}
> >  @findex -numa
> >  Define a NUMA node and assign RAM and VCPUs to it.
> > +Set NUMA distance from source node to destination node.
> >  
> >  @var{firstcpu} and @var{lastcpu} are CPU indexes. Each
> >  @samp{cpus} option represent a contiguous range of CPU indexes
> > @@ -167,6 +170,13 @@ split equally between them.
> >  @samp{mem} and @samp{memdev} are mutually exclusive. Furthermore,
> >  if one node uses @samp{memdev}, all of them have to use it.
> >  
> > +@var{source} and @var{destination} are NUMA node IDs.
> > +@var{distance} is the NUMA distance from @var{source} to @var{destination}.
> > +The distance from node A to node B may be different from the distance from
> > +node B to node A since the distance can to be asymmetry.
> > +If the distance is not set, the default distance for a local NUMA node is 10,
> > +and 20 for a remote node.
> > +
> >  Note that the -@option{numa} option doesn't allocate any of the
> >  specified resources, it just assigns existing resources to NUMA
> >  nodes. This means that one still has to use the @option{-m},
> 
