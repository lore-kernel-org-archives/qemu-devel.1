Received: from eggs.gnu.org ([2001:4830:134:3::10]:51641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cuxWC-0007Vc-0E
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 04:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cuxW8-0005o2-RG
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 04:39:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1cuxW8-0005my-Ic
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 04:39:16 -0400
Date: Mon, 3 Apr 2017 10:38:51 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170403083851.u6f7ktakdqtmzwhj@kamzik.brq.redhat.com>
References: <1491042326-24335-1-git-send-email-he.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491042326-24335-1-git-send-email-he.chen@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v4] Allow setting NUMA distance for
 different NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: He Chen <he.chen@linux.intel.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Sat, Apr 01, 2017 at 06:25:26PM +0800, He Chen wrote:
> Current, QEMU does not provide a clear command to set vNUMA distance for
> guest although we already have `-numa` command to set vNUMA nodes.
> 
> vNUMA distance makes sense in certain scenario.
> But now, if we create a guest that has 4 vNUMA nodes, when we check NUMA
> info via `numactl -H`, we will see:
> 
> node distance:
> node    0    1    2    3
>   0:   10   20   20   20
>   1:   20   10   20   20
>   2:   20   20   10   20
>   3:   20   20   20   10
> 
> Guest kernel regards all local node as distance 10, and all remote node
> as distance 20 when there is no SLIT table since QEMU doesn't build it.
> It looks like a little strange when you have seen the distance in an
> actual physical machine that contains 4 NUMA nodes. My machine shows:
> 
> node distance:
> node    0    1    2    3
>   0:   10   21   31   41
>   1:   21   10   21   31
>   2:   31   21   10   21
>   3:   41   31   21   10
> 
> To set vNUMA distance, guest should see a complete SLIT table.
> I found QEMU has provide `-acpitable` command that allows users to add
> a ACPI table into guest, but it requires users building ACPI table by
> themselves first. Using `-acpitable` to add a SLIT table may be not so
> straightforward or flexible, imagine that when the vNUMA configuration
> is changes and we need to generate another SLIT table manually. It may
> not be friendly to users or upper software like libvirt.
> 
> This patch is going to add SLIT table support in QEMU, and provides
> additional option `dist` for command `-numa` to allow user set vNUMA
> distance by QEMU command.
> 
> With this patch, when a user wants to create a guest that contains
> several vNUMA nodes and also wants to set distance among those nodes,
> the QEMU command would like:
> 
> ```
> -numa node,nodeid=0,cpus=0 \
> -numa node,nodeid=1,cpus=1 \
> -numa node,nodeid=2,cpus=2 \
> -numa node,nodeid=3,cpus=3 \
> -numa dist,src=0,dst=0,val=10 \
> -numa dist,src=0,dst=1,val=21 \
> -numa dist,src=0,dst=2,val=31 \
> -numa dist,src=0,dst=3,val=41 \
> -numa dist,src=1,dst=0,val=21 \
> -numa dist,src=1,dst=1,val=10 \
> -numa dist,src=1,dst=2,val=21 \
> -numa dist,src=1,dst=3,val=31 \
> -numa dist,src=2,dst=0,val=31 \
> -numa dist,src=2,dst=1,val=21 \
> -numa dist,src=2,dst=2,val=10 \
> -numa dist,src=2,dst=3,val=21 \
> -numa dist,src=3,dst=0,val=41 \
> -numa dist,src=3,dst=1,val=31 \
> -numa dist,src=3,dst=2,val=21 \
> -numa dist,src=3,dst=3,val=10 \
> ```
> 
> Signed-off-by: He Chen <he.chen@linux.intel.com>
> ---
>  hw/acpi/aml-build.c         | 26 +++++++++++++++++
>  hw/i386/acpi-build.c        |  2 ++
>  include/hw/acpi/aml-build.h |  1 +
>  include/sysemu/numa.h       |  1 +
>  include/sysemu/sysemu.h     |  4 +++
>  numa.c                      | 70 +++++++++++++++++++++++++++++++++++++++++++++
>  qapi-schema.json            | 28 ++++++++++++++++--
>  qemu-options.hx             | 11 ++++++-
>  8 files changed, 140 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index c6f2032..410b30e 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -24,6 +24,7 @@
>  #include "hw/acpi/aml-build.h"
>  #include "qemu/bswap.h"
>  #include "qemu/bitops.h"
> +#include "sysemu/numa.h"
>  
>  static GArray *build_alloc_array(void)
>  {
> @@ -1609,3 +1610,28 @@ void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
>      numamem->base_addr = cpu_to_le64(base);
>      numamem->range_length = cpu_to_le64(len);
>  }
> +
> +/*
> + * ACPI spec 5.2.17 System Locality Distance Information Table
> + * (Revision 2.0 or later)
> + */
> +void build_slit(GArray *table_data, BIOSLinker *linker)
> +{
> +    int slit_start, i, j;
> +    slit_start = table_data->len;
> +
> +    acpi_data_push(table_data, sizeof(AcpiTableHeader));
> +
> +    build_append_int_noprefix(table_data, nb_numa_nodes, 8);
> +    for (i = 0; i < nb_numa_nodes; i++) {
> +        for (j = 0; j < nb_numa_nodes; j++) {
> +            build_append_int_noprefix(table_data, numa_info[i].distance[j], 1);
> +        }
> +    }
> +
> +    build_header(linker, table_data,
> +                 (void *)(table_data->data + slit_start),
> +                 "SLIT",
> +                 table_data->len - slit_start, 1, NULL, NULL);
> +}
> +
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 2073108..12730ea 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2678,6 +2678,8 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>      if (pcms->numa_nodes) {
>          acpi_add_table(table_offsets, tables_blob);
>          build_srat(tables_blob, tables->linker, machine);
> +        acpi_add_table(table_offsets, tables_blob);
> +        build_slit(tables_blob, tables->linker);
>      }
>      if (acpi_get_mcfg(&mcfg)) {
>          acpi_add_table(table_offsets, tables_blob);
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index 00c21f1..329a0d0 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -389,4 +389,5 @@ GCC_FMT_ATTR(2, 3);
>  void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
>                         uint64_t len, int node, MemoryAffinityFlags flags);
>  
> +void build_slit(GArray *table_data, BIOSLinker *linker);
>  #endif
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> index 8f09dcf..2f7a941 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -21,6 +21,7 @@ typedef struct node_info {
>      struct HostMemoryBackend *node_memdev;
>      bool present;
>      QLIST_HEAD(, numa_addr_range) addr; /* List to store address ranges */
> +    uint8_t distance[MAX_NODES];
>  } NodeInfo;
>  
>  extern NodeInfo numa_info[MAX_NODES];
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 576c7ce..6999545 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -169,6 +169,10 @@ extern int mem_prealloc;
>  
>  #define MAX_NODES 128
>  #define NUMA_NODE_UNASSIGNED MAX_NODES
> +#define NUMA_DISTANCE_MIN         10
> +#define NUMA_DISTANCE_DEFAULT     20
> +#define NUMA_DISTANCE_MAX         254
> +#define NUMA_DISTANCE_UNREACHABLE 255
>  
>  #define MAX_OPTION_ROMS 16
>  typedef struct QEMUOptionRom {
> diff --git a/numa.c b/numa.c
> index e01cb54..421c383 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -212,6 +212,40 @@ static void numa_node_parse(NumaNodeOptions *node, QemuOpts *opts, Error **errp)
>      max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
>  }
>  
> +static void numa_distance_parse(NumaDistOptions *dist, QemuOpts *opts, Error **errp)
> +{
> +    uint16_t src = dist->src;
> +    uint16_t dst = dist->dst;
> +    uint8_t val = dist->val;
> +
> +    if (!numa_info[src].present || !numa_info[dst].present) {
> +        error_setg(errp, "Source/Destination NUMA node is missing. "
> +                   "Please use '-numa node' option to declare it first.");
> +        return;
> +    }
> +
> +    if (src >= MAX_NODES || dst >= MAX_NODES) {
> +        error_setg(errp, "Max number of NUMA nodes reached: %"
> +                   PRIu16 "", src > dst ? src : dst);
> +        return;
> +    }
> +
> +    if (val < NUMA_DISTANCE_MIN) {
> +        error_setg(errp, "NUMA distance (%" PRIu8 ") is invalid, "
> +                   "it should be larger than %d.",
> +                   val, NUMA_DISTANCE_MIN);
> +        return;
> +    }
> +
> +    if (src == dst && val != NUMA_DISTANCE_MIN) {
> +        error_setg(errp, "Local distance of node %d should be %d.",
> +                   src, NUMA_DISTANCE_MIN);
> +        return;
> +    }
> +
> +    numa_info[src].distance[dst] = val;
> +}
> +
>  static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
>  {
>      NumaOptions *object = NULL;
> @@ -235,6 +269,12 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
>          }
>          nb_numa_nodes++;
>          break;
> +    case NUMA_OPTIONS_TYPE_DIST:
> +        numa_distance_parse(&object->u.dist, opts, &err);
> +        if (err) {
> +            goto end;
> +        }
> +        break;
>      default:
>          abort();
>      }
> @@ -294,6 +334,35 @@ static void validate_numa_cpus(void)
>      g_free(seen_cpus);
>  }
>  
> +static void validate_numa_distance(void)
> +{
> +    int src, dst;
> +    bool have_distance = false;
> +
> +    for (src = 0; src < nb_numa_nodes; src++) {
> +        for (dst = 0; dst < nb_numa_nodes; dst++) {
> +            if (numa_info[src].present &&
> +                numa_info[src].distance[dst] != 0)
> +                have_distance = true;
> +        }
> +    }
> +
> +    if (!have_distance)
> +        return;
> +
> +    for (src = 0; src < nb_numa_nodes; src++) {
> +        for (dst = 0; dst < nb_numa_nodes; dst++) {
> +            if (numa_info[src].present &&
> +                numa_info[src].distance[dst] == 0) {
> +                error_report("The distance between node %d and %d is missing, "
> +                             "please provide the complete NUMA distance information.",
> +                             src, dst);
> +                exit(EXIT_FAILURE);
> +            }
> +        }
> +    }
> +}

This validation is stricter than what Eduardo and I agreed was sufficient.
This says if any distance is given, they must all be given. We agreed that
the symmetrical shortcut was probably OK, but if any asymmetrical distance
is given, then they must all be given. Here a couple examples

Given:
 A -> B : 25
 A -> C : 35
 A -> D : 45
 B -> C : 25
 B -> D : 35
 C -> D : 25

The above is OK. All reverse directions are assumed symmetrical.

Given:
 A -> B : 25
 A -> C : 35
 A -> D : 45
 B -> C : 25
 B -> D : 35
 C -> D : 25
 D -> C : 35

The above is not OK, as C -> D and D -> C are given asymmetrical
distances, but no others are. We can no longer trust that the user meant
the rest are symmetrical, so all must be given now.

We should also ensure that when even one node pair's distance is given,
then all unique node pair's must have a distance given.

I've also attempted to describe this below as a suggestion for the
documentation.

> +
>  void parse_numa_opts(MachineClass *mc)
>  {
>      int i;
> @@ -390,6 +459,7 @@ void parse_numa_opts(MachineClass *mc)
>          }
>  
>          validate_numa_cpus();
> +        validate_numa_distance();
>      } else {
>          numa_set_mem_node_id(0, ram_size, 0);
>      }
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 32b4a4b..b432e13 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -5644,10 +5644,14 @@
>  ##
>  # @NumaOptionsType:
>  #
> +# @node: NUMA nodes configuration
> +#
> +# @dist: NUMA distance configuration
> +#
>  # Since: 2.1
>  ##
>  { 'enum': 'NumaOptionsType',
> -  'data': [ 'node' ] }
> +  'data': [ 'node', 'dist' ] }
>  
>  ##
>  # @NumaOptions:
> @@ -5660,7 +5664,8 @@
>    'base': { 'type': 'NumaOptionsType' },
>    'discriminator': 'type',
>    'data': {
> -    'node': 'NumaNodeOptions' }}
> +    'node': 'NumaNodeOptions',
> +    'dist': 'NumaDistOptions' }}
>  
>  ##
>  # @NumaNodeOptions:
> @@ -5689,6 +5694,25 @@
>     '*memdev': 'str' }}
>  
>  ##
> +# @NumaDistOptions:
> +#
> +# Set the distance between 2 NUMA nodes.
> +#
> +# @src: source NUMA node.
> +#
> +# @dst: destination NUMA node.
> +#
> +# @val: NUMA distance from source node to destination node.
> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'NumaDistOptions',
> +  'data': {
> +   'src': 'uint16',
> +   'dst': 'uint16',
> +   'val': 'uint8' }}
> +
> +##
>  # @HostMemPolicy:
>  #
>  # Host memory policy types
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 8dd8ee3..ce1a8ad 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -139,12 +139,15 @@ ETEXI
>  
>  DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>      "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
> -    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n", QEMU_ARCH_ALL)
> +    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
> +    "-numa dist,src=source,dst=destination,val=distance\n", QEMU_ARCH_ALL)
>  STEXI
>  @item -numa node[,mem=@var{size}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
>  @itemx -numa node[,memdev=@var{id}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
> +@itemx -numa dist,src=@var{source},dst=@var{destination},val=@var{distance}
>  @findex -numa
>  Define a NUMA node and assign RAM and VCPUs to it.
> +Set the NUMA distance from a source node to a destination node.
>  
>  @var{firstcpu} and @var{lastcpu} are CPU indexes. Each
>  @samp{cpus} option represent a contiguous range of CPU indexes
> @@ -167,6 +170,12 @@ split equally between them.
>  @samp{mem} and @samp{memdev} are mutually exclusive. Furthermore,
>  if one node uses @samp{memdev}, all of them have to use it.
>  
> +@var{source} and @var{destination} are NUMA node IDs.
> +@var{distance} is the NUMA distance from @var{source} to @var{destination}.
> +The distance from node A to node B may be different from the distance from
> +node B to node A as the distance can to be asymmetrical. If a node is
> +unreachable, set 255 as distance.

The distance from a node to itself is always 10.  If no distance values
are given for node pairs, then the default distance of 20 is used for each
pair.  If any pair of nodes is given a distance, then all pairs must be
given distances.  Although, when distances are only given in one direction
for each pair of nodes, then the distances in the opposite directions are
assumed to be the same.  If, however, an asymmetrical pair of distances is
given for even one node pair, then all node pairs must be provided
distance values for both directions, even when they are symmetrical.  When
a node is unreachable from another node, set the pair's distance to 255.

> +
>  Note that the -@option{numa} option doesn't allocate any of the
>  specified resources, it just assigns existing resources to NUMA
>  nodes. This means that one still has to use the @option{-m},
> -- 
> 2.7.4
> 
>

Thanks,
drew
