Received: from eggs.gnu.org ([2001:4830:134:3::10]:38172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1coVWy-0002IV-Kx
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 09:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1coVWv-0006m1-Cf
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 09:33:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1coVWv-0006lk-40
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 09:33:25 -0400
Date: Thu, 16 Mar 2017 14:33:18 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170316133318.cfiekwfcdxuxbzx4@kamzik.brq.redhat.com>
References: <1489653504-25229-1-git-send-email-he.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489653504-25229-1-git-send-email-he.chen@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v2] x86: Allow to set NUMA distance for
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

On Thu, Mar 16, 2017 at 04:38:24PM +0800, He Chen wrote:
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
> -object memory-backend-ram,size=1G,prealloc=yes,host-nodes=0,policy=bind,id=node0 \
> -numa node,nodeid=0,cpus=0,memdev=node0 \
> -object memory-backend-ram,size=1G,prealloc=yes,host-nodes=1,policy=bind,id=node1 \
> -numa node,nodeid=1,cpus=1,memdev=node1 \
> -object memory-backend-ram,size=1G,prealloc=yes,host-nodes=2,policy=bind,id=node2 \
> -numa node,nodeid=2,cpus=2,memdev=node2 \
> -object memory-backend-ram,size=1G,prealloc=yes,host-nodes=3,policy=bind,id=node3 \
> -numa node,nodeid=3,cpus=3,memdev=node3 \
> -numa dist,src=0,dst=1,val=21 \
> -numa dist,src=0,dst=2,val=31 \
> -numa dist,src=0,dst=3,val=41 \
> -numa dist,src=1,dst=0,val=21 \
> ...
> ```
> 
> Signed-off-by: He Chen <he.chen@linux.intel.com>
> ---
>  hw/i386/acpi-build.c    | 27 +++++++++++++++++++++++++++
>  include/sysemu/numa.h   |  1 +
>  include/sysemu/sysemu.h |  3 +++
>  numa.c                  | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  qapi-schema.json        | 24 ++++++++++++++++++++++--
>  qemu-options.hx         | 12 +++++++++++-
>  6 files changed, 108 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 2073108..50906b9 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2395,6 +2395,31 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>                   table_data->len - srat_start, 1, NULL, NULL);
>  }
>  
> +/*
> + * ACPI spec 5.2.17 System Locality Distance Information Table
> + * (Revision 2.0 or later)
> + */
> +static void
> +build_slit(GArray *table_data, BIOSLinker *linker, MachineState *machine)
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
>  static void
>  build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>  {
> @@ -2678,6 +2703,8 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>      if (pcms->numa_nodes) {
>          acpi_add_table(table_offsets, tables_blob);
>          build_srat(tables_blob, tables->linker, machine);
> +        acpi_add_table(table_offsets, tables_blob);
> +        build_slit(tables_blob, tables->linker, machine);
>      }
>      if (acpi_get_mcfg(&mcfg)) {
>          acpi_add_table(table_offsets, tables_blob);
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
> index 576c7ce..d674287 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -169,6 +169,9 @@ extern int mem_prealloc;
>  
>  #define MAX_NODES 128
>  #define NUMA_NODE_UNASSIGNED MAX_NODES
> +#define MIN_NUMA_DISTANCE 10
> +#define DEF_NUMA_DISTANCE 20
> +#define MAX_NUMA_DISTANCE 255

I'd prefer the names start with 'NUMA_DISTANCE', e.g. NUMA_DISTANCE_MIN.
Also, spelling out 'DEFAULT' would be nicer, and 255 isn't the max
distance, it means an infinite distance, i.e. the spec says that a
distance of 255 means the locality j is not reachable from i. How about
these names instead?

 #define NUMA_DISTANCE_MIN         10
 #define NUMA_DISTANCE_DEFAULT     20
 #define NUMA_DISTANCE_MAX         254
 #define NUMA_DISTANCE_UNREACHABLE 255

>  
>  #define MAX_OPTION_ROMS 16
>  typedef struct QEMUOptionRom {
> diff --git a/numa.c b/numa.c
> index e01cb54..9b28e47 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -212,6 +212,28 @@ static void numa_node_parse(NumaNodeOptions *node, QemuOpts *opts, Error **errp)
>      max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
>  }
>  
> +static void numa_distance_parse(NumaDistOptions *dist, QemuOpts *opts, Error **errp)
> +{
> +    uint64_t src = dist->src;
> +    uint64_t dst = dist->dst;
> +    uint8_t val = dist->val;
> +
> +    if (src >= MAX_NODES || dst >= MAX_NODES) {
> +        error_setg(errp, "Max number of NUMA nodes reached: %"
> +                   PRIu64 "", src > dst ? src : dst);
> +        return;
> +    }
> +
> +    if (val < MIN_NUMA_DISTANCE) {
> +        error_setg(errp,
> +                "NUMA distance (%" PRIu8 ") out of range (%d) ~ (%d)",
> +                dist->val, MAX_NUMA_DISTANCE, MIN_NUMA_DISTANCE);

Ranges are usually written as "[min, max]". This is "(max) ~ (min)".

> +        return;
> +    }
> +
> +    numa_info[src].distance[dst] = val;
> +}
> +
>  static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
>  {
>      NumaOptions *object = NULL;
> @@ -235,6 +257,12 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
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
> @@ -294,6 +322,21 @@ static void validate_numa_cpus(void)
>      g_free(seen_cpus);
>  }
>  
> +static void default_numa_distance(void)
> +{
> +    int i, j;
> +
> +    for (i = 0; i < nb_numa_nodes; i++) {
> +        for (j = 0; j < nb_numa_nodes; j++) {
> +            if (i == j && numa_info[i].distance[j] != MIN_NUMA_DISTANCE) {
> +                numa_info[i].distance[j] = MIN_NUMA_DISTANCE;
> +            } else if (numa_info[i].distance[j] <= MIN_NUMA_DISTANCE) {
> +                numa_info[i].distance[j] = DEF_NUMA_DISTANCE;
> +            }
> +        }
> +    }
> +}
> +
>  void parse_numa_opts(MachineClass *mc)
>  {
>      int i;
> @@ -390,6 +433,7 @@ void parse_numa_opts(MachineClass *mc)
>          }
>  
>          validate_numa_cpus();
> +        default_numa_distance();
>      } else {
>          numa_set_mem_node_id(0, ram_size, 0);
>      }
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 32b4a4b..cbb7176 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -5647,7 +5647,7 @@
>  # Since: 2.1
>  ##
>  { 'enum': 'NumaOptionsType',
> -  'data': [ 'node' ] }
> +  'data': [ 'node', 'dist' ] }
>  
>  ##
>  # @NumaOptions:
> @@ -5660,7 +5660,8 @@
>    'base': { 'type': 'NumaOptionsType' },
>    'discriminator': 'type',
>    'data': {
> -    'node': 'NumaNodeOptions' }}
> +    'node': 'NumaNodeOptions',
> +    'dist': 'NumaDistOptions' }}
>  
>  ##
>  # @NumaNodeOptions:
> @@ -5689,6 +5690,25 @@
>     '*memdev': 'str' }}
>  
>  ##
> +# @NumaDistOptions:
> +#
> +# Set distance between 2 NUMA nodes. (for OptsVisitor)
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
> +   'src': 'uint64',
> +   'dst': 'uint64',
> +   'val': 'uint8' }}
> +
> +##
>  # @HostMemPolicy:
>  #
>  # Host memory policy types
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 8dd8ee3..b7b4ec5 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -139,12 +139,15 @@ ETEXI
>  
>  DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>      "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
> -    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n", QEMU_ARCH_ALL)
> +    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
> +    "-numa dist,src=source,dst=destination,val=distance\n", QEMU_ARCH_I386)

Why did this change from QEMU_ARCH_ALL to QEMU_ARCH_I386? We also have
numa support for ARM.

>  STEXI
>  @item -numa node[,mem=@var{size}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
>  @itemx -numa node[,memdev=@var{id}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
> +@itemx -numa dist,src=@var{source},dst=@var{destination},val=@var{distance}
>  @findex -numa
>  Define a NUMA node and assign RAM and VCPUs to it.
> +Set NUMA distance from source node to destination node.
>  
>  @var{firstcpu} and @var{lastcpu} are CPU indexes. Each
>  @samp{cpus} option represent a contiguous range of CPU indexes
> @@ -167,6 +170,13 @@ split equally between them.
>  @samp{mem} and @samp{memdev} are mutually exclusive. Furthermore,
>  if one node uses @samp{memdev}, all of them have to use it.
>  
> +@var{source} and @var{destination} are NUMA node ID.
> +@var{distance} is NUMA distance from @var{source} to @var{destination}.
> +The distance from node A to node B may be different from the distance from
> +node B to node A since the distance allows to be asymmetry.
> +If the distance is not set, the default distance for local NUMA node is 10,
> +and 20 for remote node.

I think a default of i -> j == j -> i, when only one is specified is
reasonable. numa_distance_parse can simply also set
numa_info[dst].distance[src] = val, if it's not already set.

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
