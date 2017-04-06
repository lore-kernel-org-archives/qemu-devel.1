Received: from eggs.gnu.org ([2001:4830:134:3::10]:60094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cw8pq-00061W-Ln
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:56:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cw8pn-0008L6-J3
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:56:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1cw8pn-0008Jc-9G
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:56:27 -0400
Date: Thu, 6 Apr 2017 16:56:17 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170406145617.m7nyim27jjmml47f@kamzik.brq.redhat.com>
References: <1491445133-6534-1-git-send-email-he.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491445133-6534-1-git-send-email-he.chen@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v5] Allow setting NUMA distance for
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

On Thu, Apr 06, 2017 at 10:18:53AM +0800, He Chen wrote:
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
> -numa dist,src=0,dst=1,val=21 \
> -numa dist,src=0,dst=2,val=31 \
> -numa dist,src=0,dst=3,val=41 \
> -numa dist,src=1,dst=2,val=21 \
> -numa dist,src=1,dst=3,val=31 \
> -numa dist,src=2,dst=3,val=21 \
> ```
> 
> Signed-off-by: He Chen <he.chen@linux.intel.com>
> ---
>  hw/acpi/aml-build.c         |  25 +++++++++
>  hw/i386/acpi-build.c        |   2 +
>  include/hw/acpi/aml-build.h |   1 +
>  include/sysemu/numa.h       |   1 +
>  include/sysemu/sysemu.h     |   4 ++
>  numa.c                      | 121 ++++++++++++++++++++++++++++++++++++++++++++
>  qapi-schema.json            |  30 ++++++++++-
>  qemu-options.hx             |  17 ++++++-
>  8 files changed, 198 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index c6f2032..2c6ab07 100644
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
> @@ -1609,3 +1610,27 @@ void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
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

We could make the generation of the SLIT dependent on have_numa_distance.

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
> index 6fc2393..838e45a 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -52,6 +52,7 @@ static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
>                               */
>  int nb_numa_nodes;
>  NodeInfo numa_info[MAX_NODES];
> +static bool have_numa_distance;
>  
>  void numa_set_mem_node_id(ram_addr_t addr, uint64_t size, uint32_t node)
>  {
> @@ -212,6 +213,41 @@ static void numa_node_parse(NumaNodeOptions *node, QemuOpts *opts, Error **errp)
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

This should probably output what the max is (MAX_NODES) rather than
the largest of the two inputs.  What if both were too large?  In that
case the smallest of the two would make more sense.

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
> +    have_numa_distance = true;
> +}
> +
>  static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
>  {
>      NumaOptions *object = NULL;
> @@ -235,6 +271,12 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
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
> @@ -294,6 +336,84 @@ static void validate_numa_cpus(void)
>      g_free(seen_cpus);
>  }
>  
> +static void validate_numa_distance(void)
> +{
> +    int src, dst, s, d;
> +    bool is_asymmetrical = false;
> +    bool opposite_miss = false;

opposite_missing

> +
> +    if (!have_numa_distance) {
> +        for (src = 0; src < nb_numa_nodes; src++) {
> +            for (dst = 0; dst < nb_numa_nodes; dst++) {
> +                if (numa_info[src].present && numa_info[dst].present) {
> +                    if (src == dst) {
> +                        numa_info[src].distance[dst] = NUMA_DISTANCE_MIN;
> +                    } else {
> +                        numa_info[src].distance[dst] = NUMA_DISTANCE_DEFAULT;
> +                    }
> +                }
> +            }
> +        }
> +
> +        return;
> +    }

We could drop the above and just not provide an SLIT at all when
have_numa_distance is false, because, per the ACPI spec, the SLIT is
an optional table.

> +
> +    for (src = 0; src < nb_numa_nodes; src++) {
> +        for (dst = src; dst < nb_numa_nodes; dst++) {
> +            s = src;
> +            d = dst;
> +
> +            if (numa_info[s].present && numa_info[d].present) {
> +                if (numa_info[s].distance[d] == 0 &&
> +                    numa_info[d].distance[s] == 0) {
> +                    if (s == d) {
> +                        numa_info[s].distance[d] = NUMA_DISTANCE_MIN;
> +                        continue;
> +                    } else {
> +                        error_report("The distance between node %d and %d is missing, "
> +                                     "please provide all unique node pair's distance.",

s/pair's distance/pair distances/

> +                                     s, d);
> +                        exit(EXIT_FAILURE);
> +                    }
> +                }
> +
> +                if (s == d && numa_info[s].distance[d] != NUMA_DISTANCE_MIN) {
> +                    error_report("The local distance of node %d should be %d.",
> +                                 s, NUMA_DISTANCE_MIN);
> +                    exit(EXIT_FAILURE);
> +                }

Is it possible for the above condition to ever be true?  Isn't already
disallowed by numa_distance_parse(), right?

> +
> +                if (numa_info[s].distance[d] == 0) {
> +                    s = dst;
> +                    d = src;
> +                }
> +
> +                if (numa_info[d].distance[s] == 0) {
> +                    opposite_miss = true;
> +                }
> +
> +                if ((numa_info[d].distance[s] != 0) &&
> +                    (numa_info[s].distance[d] != numa_info[d].distance[s])) {
> +                    is_asymmetrical = true;
> +                }
> +
> +                if (is_asymmetrical) {
> +                    if (opposite_miss) {
> +                        error_report("At least one asymmetrical pair of distance "

distances

> +                                     "is given, please provide all node pairs' "
> +                                     "distance value for both directions.");

...is given, please provide distances for both directions of all node pairs.


> +                        exit(EXIT_FAILURE);
> +                    }
> +                } else {
> +                    numa_info[d].distance[s] = numa_info[s].distance[d];
> +                }
> +            }
> +        }
> +    }
> +
> +    return;

pointless 'return'

> +}
> +
>  void parse_numa_opts(MachineClass *mc)
>  {
>      int i;
> @@ -390,6 +510,7 @@ void parse_numa_opts(MachineClass *mc)
>          }
>  
>          validate_numa_cpus();
> +        validate_numa_distance();
>      } else {
>          numa_set_mem_node_id(0, ram_size, 0);
>      }
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 250e4dc..7552777 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -5673,10 +5673,14 @@
>  ##
>  # @NumaOptionsType:
>  #
> +# @node: NUMA nodes configuration
> +#
> +# @dist: NUMA distance configuration (since 2.10)
> +#
>  # Since: 2.1
>  ##
>  { 'enum': 'NumaOptionsType',
> -  'data': [ 'node' ] }
> +  'data': [ 'node', 'dist' ] }
>  
>  ##
>  # @NumaOptions:
> @@ -5689,7 +5693,8 @@
>    'base': { 'type': 'NumaOptionsType' },
>    'discriminator': 'type',
>    'data': {
> -    'node': 'NumaNodeOptions' }}
> +    'node': 'NumaNodeOptions',
> +    'dist': 'NumaDistOptions' }}
>  
>  ##
>  # @NumaNodeOptions:
> @@ -5718,6 +5723,27 @@
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
> +#       When a node is unreachable from another node, set the distance
> +#       to 255.

When a node is unreachable from another node, set the distance between
them to 255.

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
> index 99af8ed..2318d85 100644
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
> @@ -167,6 +170,18 @@ split equally between them.
>  @samp{mem} and @samp{memdev} are mutually exclusive. Furthermore,
>  if one node uses @samp{memdev}, all of them have to use it.
>  
> +@var{source} and @var{destination} are NUMA node IDs.
> +@var{distance} is the NUMA distance from @var{source} to @var{destination}.
> +The distance from a node to itself is always 10. If no distance values
> +are given for node pairs, then the default distance of 20 is used for each
> +pair. If any pair of nodes is given a distance, then all pairs must be
> +given distances. Although, when distances are only given in one direction
> +for each pair of nodes, then the distances in the opposite directions are
> +assumed to be the same. If, however, an asymmetrical pair of distances is
> +given for even one node pair, then all node pairs must be provided
> +distance values for both directions, even when they are symmetrical. When
> +a node is unreachable from another node, set the pair's distance to 255.

We'll need to tweak/remove the 'default distance of 20' part of this if we
decide to not generate the SLIT at all when no distances are given.

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
