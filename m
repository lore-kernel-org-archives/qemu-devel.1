Received: from eggs.gnu.org ([2001:4830:134:3::10]:48094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cmNV5-0006YW-EX
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 11:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cmNV2-00087T-8G
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 11:34:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cmNV1-00086u-W0
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 11:34:40 -0500
Date: Fri, 10 Mar 2017 18:34:34 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170310182804-mutt-send-email-mst@kernel.org>
References: <1489141097-28587-1-git-send-email-he.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489141097-28587-1-git-send-email-he.chen@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH] x86: Allow to set NUMA distance for
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
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Fri, Mar 10, 2017 at 06:18:17PM +0800, He Chen wrote:
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
> This patch is going to add SLIT table support in QEMU, and provides
> addtional option `dist` for command `-numa` to allow user set vNUMA
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
> -numa dist,a=0,b=1,val=21 \
> -numa dist,a=0,b=2,val=31 \
> -numa dist,a=0,b=3,val=41 \
> -numa dist,a=1,b=0,val=21 \
> ...
> ```
> 
> Thanks,
> -He

You don't want your greeting in the git log, pls
put it after ---.

> 
> Signed-off-by: He Chen <he.chen@linux.intel.com>
> ---
>  hw/i386/acpi-build.c        | 28 ++++++++++++++++++++++++++
>  include/hw/acpi/acpi-defs.h |  9 +++++++++
>  include/sysemu/numa.h       |  1 +
>  numa.c                      | 48 +++++++++++++++++++++++++++++++++++++++++++++
>  qapi-schema.json            | 24 +++++++++++++++++++++--
>  qemu-options.hx             |  5 ++++-
>  6 files changed, 112 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 2073108..7ced37d 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2396,6 +2396,32 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>  }
>  
>  static void
> +build_slit(GArray *table_data, BIOSLinker *linker, MachineState *machine)

Pls add reference to earliest spec version that has
this table.


> +{
> +    struct AcpiSystemLocalityDistanceTable *slit;

Coding style violation.

> +    uint8_t *entry;
> +    int slit_start, slit_data_len, i, j;
> +    slit_start = table_data->len;
> +
> +    slit = acpi_data_push(table_data, sizeof(*slit));
> +    slit->nb_localities = nb_numa_nodes;
> +
> +    slit_data_len = sizeof(uint8_t) * nb_numa_nodes * nb_numa_nodes;
> +    entry = acpi_data_push(table_data, slit_data_len);
> +
> +    for (i = 0; i < nb_numa_nodes; i++) {
> +        for (j = 0; j < nb_numa_nodes; j++) {
> +            entry[i * nb_numa_nodes + j] = numa_info[i].distance[j];
> +        }
> +    }
> +

Pointer math like this does not make me happy at all.
I suggest you rewrite it all using build_append_int_noprefix.


> +    build_header(linker, table_data,
> +                 (void *)(table_data->data + slit_start),
> +                 "SLIT",
> +                 table_data->len - slit_start, 1, NULL, NULL);
> +}
> +
> +static void
>  build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>  {
>      AcpiTableMcfg *mcfg;
> @@ -2678,6 +2704,8 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>      if (pcms->numa_nodes) {
>          acpi_add_table(table_offsets, tables_blob);
>          build_srat(tables_blob, tables->linker, machine);
> +        acpi_add_table(table_offsets, tables_blob);
> +        build_slit(tables_blob, tables->linker, machine);
>      }
>      if (acpi_get_mcfg(&mcfg)) {
>          acpi_add_table(table_offsets, tables_blob);
> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> index 4cc3630..b183a8f 100644
> --- a/include/hw/acpi/acpi-defs.h
> +++ b/include/hw/acpi/acpi-defs.h
> @@ -527,6 +527,15 @@ struct AcpiSratProcessorGiccAffinity
>  
>  typedef struct AcpiSratProcessorGiccAffinity AcpiSratProcessorGiccAffinity;
>  
> +/*
> + * SLIT (NUMA distance description) table
> + */
> +struct AcpiSystemLocalityDistanceTable {
> +    ACPI_TABLE_HEADER_DEF
> +    uint64_t    nb_localities;
> +} QEMU_PACKED;
> +typedef struct AcpiSystemLocalityDistanceTable AcpiSystemLocalityDistanceTable;
> +
>  /* PCI fw r3.0 MCFG table. */
>  /* Subtable */
>  struct AcpiMcfgAllocation {

These structs are not really helpful in documenting the format.

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
> diff --git a/numa.c b/numa.c
> index e01cb54..897657a 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -50,6 +50,9 @@ static int have_memdevs = -1;
>  static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
>                               * For all nodes, nodeid < max_numa_nodeid
>                               */
> +static int min_numa_distance = 10;
> +static int def_numa_distance = 20;
> +static int max_numa_distance = 255;

What are the units here? Pls document. Also
add comments documenting the reason for these numbers.

>  int nb_numa_nodes;
>  NodeInfo numa_info[MAX_NODES];
>  

Why make these static int? something like a #define or enum will
be clearer.


> @@ -208,10 +211,33 @@ static void numa_node_parse(NumaNodeOptions *node, QemuOpts *opts, Error **errp)
>          numa_info[nodenr].node_mem = object_property_get_int(o, "size", NULL);
>          numa_info[nodenr].node_memdev = MEMORY_BACKEND(o);
>      }
> +
>      numa_info[nodenr].present = true;
>      max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
>  }
>  
> +static void numa_distance_parse(NumaDistOptions *dist, QemuOpts *opts, Error **errp)
> +{
> +    uint8_t a = dist->a;
> +    uint8_t b = dist->b;
> +    uint8_t val = dist->val;
> +
> +    if (a >= MAX_NODES || b >= MAX_NODES) {
> +        error_setg(errp, "Max number of NUMA nodes reached: %"
> +                   PRIu16 "", a > b ? a : b);
> +        return;
> +    }
> +
> +    if (val > max_numa_distance || val < min_numa_distance) {
> +        error_setg(errp,
> +                "NUMA distance (%" PRIu8 ") out of range (%d)~(%d)",
> +                dist->val, max_numa_distance, min_numa_distance);
> +        return;
> +    }
> +
> +    numa_info[a].distance[b] = val;
> +}
> +
>  static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
>  {
>      NumaOptions *object = NULL;
> @@ -235,6 +261,12 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
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
> @@ -294,6 +326,21 @@ static void validate_numa_cpus(void)
>      g_free(seen_cpus);
>  }
>  
> +static void default_numa_distance(void)
> +{
> +    int i, j;
> +
> +    for (i = 0; i < nb_numa_nodes; i++) {
> +        for (j = 0; j < nb_numa_nodes; j++) {
> +            if (i == j && numa_info[i].distance[j] != min_numa_distance) {
> +                numa_info[i].distance[j] = min_numa_distance;
> +            } else if (numa_info[i].distance[j] <= min_numa_distance) {
> +                numa_info[i].distance[j] = def_numa_distance;
> +            }
> +        }
> +    }
> +}
> +
>  void parse_numa_opts(MachineClass *mc)
>  {
>      int i;
> @@ -390,6 +437,7 @@ void parse_numa_opts(MachineClass *mc)
>          }
>  
>          validate_numa_cpus();
> +        default_numa_distance();
>      } else {
>          numa_set_mem_node_id(0, ram_size, 0);
>      }
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 32b4a4b..2988304 100644
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
> +# @a: first NUMA node.
> +#
> +# @b: second NUMA node.
> +#
> +# @val: NUMA distance between 2 given NUMA nodes.
> +#
> +# Since: 2.9
> +##
> +{ 'struct': 'NumaDistOptions',
> +  'data': {
> +   'a':   'uint8',
> +   'b':   'uint8',
> +   'val': 'uint8' }}
> +
> +##
>  # @HostMemPolicy:
>  #
>  # Host memory policy types
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 8dd8ee3..0de5cf8 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -139,12 +139,15 @@ ETEXI
>  
>  DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>      "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
> -    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n", QEMU_ARCH_ALL)
> +    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
> +    "-numa dist,a=firstnode,b=secondnode,val=distance\n", QEMU_ARCH_ALL)
>  STEXI
>  @item -numa node[,mem=@var{size}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
>  @itemx -numa node[,memdev=@var{id}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
> +@itemx -numa dist,a=@var{firstnode},b=@var{secondnode},val=@var{distance}
>  @findex -numa
>  Define a NUMA node and assign RAM and VCPUs to it.
> +Set NUMA distance between 2 NUMA nodes.
>  
>  @var{firstcpu} and @var{lastcpu} are CPU indexes. Each
>  @samp{cpus} option represent a contiguous range of CPU indexes

In what units? What's the default if not set?

> -- 
> 2.7.4
