Received: from eggs.gnu.org ([2001:4830:134:3::10]:38960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cjnhm-0004Db-4y
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cjnhk-0000CT-J4
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:57:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cjnhk-0000Av-AD
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:57:08 -0500
Date: Fri, 3 Mar 2017 10:57:04 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170303135704.GX2778@thinpad.lan.raisama.net>
References: <1488517304-23131-1-git-send-email-he.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488517304-23131-1-git-send-email-he.chen@linux.intel.com>
Subject: Re: [Qemu-devel] [RFC] x86: Allow to set NUMA distance for
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
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>

On Fri, Mar 03, 2017 at 01:01:44PM +0800, He Chen wrote:
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
> This RFC patch is going to add SLIT table support in QEMU, and provides
> addtional option `distance` for command `-numa` to allow user set vNUMA
> distance by QEMU command.
> 
> With this patch, when a user wants to create a guest that contains
> several vNUMA nodes and also wants to set distance among those nodes,
> the QEMU command would like:
> 
> ```
> -object memory-backend-ram,size=1G,prealloc=yes,host-nodes=0,policy=bind,id=node0 \
> -numa node,nodeid=0,cpus=0,memdev=node0,distance=10,distance=21,distance=31,distance=41 \
> -object memory-backend-ram,size=1G,prealloc=yes,host-nodes=1,policy=bind,id=node1 \
> -numa node,nodeid=1,cpus=1,memdev=node1,distance=21,distance=10,distance=21,distance=31 \
> -object memory-backend-ram,size=1G,prealloc=yes,host-nodes=2,policy=bind,id=node2 \
> -numa node,nodeid=2,cpus=2,memdev=node2,distance=31,distance=21,distance=10,distance=21 \
> -object memory-backend-ram,size=1G,prealloc=yes,host-nodes=3,policy=bind,id=node3 \
> -numa node,nodeid=3,cpus=3,memdev=node3,distance=41,distance=31,distance=21,distance=10 \
> ```
> 
> BTW. Please forgive me that I don't do a pretty wrapper to `distance`
> option.
> 

It would be nice to have a more intuitive syntax to represent
ordered lists in QemuOpts. But this is what we have today.


> What do you think of this RFC patch? And shall we consider to add vNUMA
> distance support to QEMU?
> 

I think the proposal makes sense. I would like the semantics of the new option
to be documented at qapi-schema.json and qemu-options.hx.

I would call the new NumaNodeOptions field "distances", as it is
a list of distances.

I wonder if we should isolate this into a separate "-numa
distances" option, for greater flexibility.

e.g. the first version could support this:

  -numa node,nodeid=0,cpus=0,memdev=node0 \
  -numa node,nodeid=1,cpus=1,memdev=node1 \
  -numa node,nodeid=2,cpus=2,memdev=node2 \
  -numa node,nodeid=3,cpus=3,memdev=node3 \
  -numa distances,from-node=0,distances=10,distances=21,distances=31,distances=41 \
  -numa distances,from-node=1,distances=21,distances=10,distances=21,distances=31 \
  -numa distances,from-node=2,distances=31,distances=21,distances=10,distances=21 \
  -numa distances,from-node=3,distances=41,distances=31,distances=21,distances=10

but in the future we could support something like:

  -numa node,nodeid=0,cpus=0,memdev=node0 \
  -numa node,nodeid=1,cpus=1,memdev=node1 \
  -numa node,nodeid=2,cpus=2,memdev=node2 \
  -numa node,nodeid=3,cpus=3,memdev=node3 \
  -numa distances,distances[0][0]=10,distances[0][1]=21,distances[0][2]=31,distances[0][3]=41,\
                  distances[1][0]=21,distances[1][1]=10,distances[1][2]=21,distances[1][3]=31,\
                  distances[2][0]=31,distances[2][1]=21,distances[2][2]=10,distances[2][3]=21,\
                  distances[3][0]=41,distances[3][1]=31,distances[3][2]=21,distances[3][3]=10

> Thanks,
> -He
> 
> Signed-off-by: He Chen <he.chen@linux.intel.com>
> ---
>  hw/i386/acpi-build.c        | 28 ++++++++++++++++++++++++++++
>  include/hw/acpi/acpi-defs.h |  9 +++++++++
>  include/sysemu/numa.h       |  2 ++
>  numa.c                      | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  qapi-schema.json            | 12 ++++++++----
>  5 files changed, 91 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 1c928ab..ee8236e 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2395,6 +2395,32 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>  }
>  
>  static void
> +build_slit(GArray *table_data, BIOSLinker *linker, MachineState *machine)
> +{
> +    struct AcpiSystemLocalityDistanceTable *slit;
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
> @@ -2669,6 +2695,8 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
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
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> index 8f09dcf..b936eeb 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -21,6 +21,8 @@ typedef struct node_info {
>      struct HostMemoryBackend *node_memdev;
>      bool present;
>      QLIST_HEAD(, numa_addr_range) addr; /* List to store address ranges */
> +    uint8_t distance[MAX_NODES];
> +    bool has_distance;
>  } NodeInfo;
>  
>  extern NodeInfo numa_info[MAX_NODES];
> diff --git a/numa.c b/numa.c
> index 9f56be9..b4e11f3 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -50,6 +50,8 @@ static int have_memdevs = -1;
>  static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
>                               * For all nodes, nodeid < max_numa_nodeid
>                               */
> +static int min_numa_distance = 10;
> +static int max_numa_distance = 255;
>  int nb_numa_nodes;
>  NodeInfo numa_info[MAX_NODES];
>  
> @@ -144,6 +146,8 @@ static void numa_node_parse(NumaNodeOptions *node, QemuOpts *opts, Error **errp)
>  {
>      uint16_t nodenr;
>      uint16List *cpus = NULL;
> +    uint8List *distance = NULL;
> +    int i;
>  
>      if (node->has_nodeid) {
>          nodenr = node->nodeid;
> @@ -208,6 +212,28 @@ static void numa_node_parse(NumaNodeOptions *node, QemuOpts *opts, Error **errp)
>          numa_info[nodenr].node_mem = object_property_get_int(o, "size", NULL);
>          numa_info[nodenr].node_memdev = MEMORY_BACKEND(o);
>      }
> +
> +    if (node->has_distance) {
> +        for (i = 0, distance = node->distance; distance; i++, distance = distance->next) {
> +            if (distance->value >= max_numa_distance) {
> +                error_setg(errp,
> +                        "NUMA distance (%" PRIu8 ")"
> +                        " should be smaller than maxnumadistance (%d)",
> +                        distance->value, max_numa_distance);
> +                return;
> +            }
> +            if (distance->value < min_numa_distance) {
> +                error_setg(errp,
> +                        "NUMA distance (%" PRIu8 ")"
> +                        " should be larger than minnumadistance (%d)",
> +                        distance->value, min_numa_distance);
> +                return;
> +            }
> +            numa_info[nodenr].distance[i] = distance->value;
> +        }
> +        numa_info[nodenr].has_distance = true;
> +    }
> +
>      numa_info[nodenr].present = true;
>      max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
>  }
> @@ -294,6 +320,23 @@ static void validate_numa_cpus(void)
>      g_free(seen_cpus);
>  }
>  
> +static void validate_numa_distance(void)
> +{
> +    int i, j;
> +
> +    for (i = 0; i < nb_numa_nodes; i++) {
> +        for (j = i; j < nb_numa_nodes; j++) {
> +            if (i == j && numa_info[i].distance[j] != min_numa_distance) {
> +                error_report("Local distance must be %d!", min_numa_distance);
> +                exit(EXIT_FAILURE);
> +            } else if (numa_info[i].distance[j] != numa_info[j].distance[i]) {
> +                error_report("Unequal NUMA distance between nodes %d and %d!", i, j);
> +                exit(EXIT_FAILURE);
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
> +        validate_numa_distance();
>      } else {
>          numa_set_mem_node_id(0, ram_size, 0);
>      }
> diff --git a/qapi-schema.json b/qapi-schema.json
> index baa0d26..f2f2d05 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -5597,14 +5597,18 @@
>  # @memdev: #optional memory backend object.  If specified for one node,
>  #          it must be specified for all nodes.
>  #
> +# @distance: #optional NUMA distance array. The length of this array should
> +#            be equal to number of NUMA nodes.
> +#
>  # Since: 2.1
>  ##
>  { 'struct': 'NumaNodeOptions',
>    'data': {
> -   '*nodeid': 'uint16',
> -   '*cpus':   ['uint16'],
> -   '*mem':    'size',
> -   '*memdev': 'str' }}
> +   '*nodeid':   'uint16',
> +   '*cpus':     ['uint16'],
> +   '*mem':      'size',
> +   '*memdev':   'str' ,
> +   '*distance': ['uint8'] }}
>  
>  ##
>  # @HostMemPolicy:
> -- 
> 2.7.4
> 

-- 
Eduardo
