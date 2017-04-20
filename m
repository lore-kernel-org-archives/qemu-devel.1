Received: from eggs.gnu.org ([2001:4830:134:3::10]:51727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <he.chen@linux.intel.com>) id 1d18L7-0005mM-5P
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 05:25:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <he.chen@linux.intel.com>) id 1d18L3-000469-4w
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 05:25:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:16926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <he.chen@linux.intel.com>)
	id 1d18L2-0003nI-Nv
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 05:25:21 -0400
Date: Thu, 20 Apr 2017 17:25:45 +0800
From: He Chen <he.chen@linux.intel.com>
Message-ID: <20170420092545.GA13391@he>
References: <1491900566-32222-1-git-send-email-he.chen@linux.intel.com>
	<20170419161440.02c33ec5@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170419161440.02c33ec5@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6] Allow setting NUMA distance for
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
Cc: Andrew Jones <drjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Apr 19, 2017 at 04:14:40PM +0200, Igor Mammedov wrote:
> On Tue, 11 Apr 2017 16:49:26 +0800
> He Chen <he.chen@linux.intel.com> wrote:
> 
> > This patch is going to add SLIT table support in QEMU, and provides
> > additional option `dist` for command `-numa` to allow user set vNUMA
> > distance by QEMU command.
> > 
> > With this patch, when a user wants to create a guest that contains
> > several vNUMA nodes and also wants to set distance among those nodes,
> > the QEMU command would like:
> > 
> > ```
> > -numa node,nodeid=0,cpus=0 \
> > -numa node,nodeid=1,cpus=1 \
> > -numa node,nodeid=2,cpus=2 \
> > -numa node,nodeid=3,cpus=3 \
> > -numa dist,src=0,dst=1,val=21 \
> > -numa dist,src=0,dst=2,val=31 \
> > -numa dist,src=0,dst=3,val=41 \
> > -numa dist,src=1,dst=2,val=21 \
> > -numa dist,src=1,dst=3,val=31 \
> > -numa dist,src=2,dst=3,val=21 \
> > ```
> > 
> > Signed-off-by: He Chen <he.chen@linux.intel.com>
> > ---
> >  hw/acpi/aml-build.c         |  25 +++++++++++
> >  hw/i386/acpi-build.c        |   4 ++
> >  include/hw/acpi/aml-build.h |   1 +
> >  include/sysemu/numa.h       |   2 +
> >  include/sysemu/sysemu.h     |   4 ++
> >  numa.c                      | 100 ++++++++++++++++++++++++++++++++++++++++++++
> >  qapi-schema.json            |  30 ++++++++++++-
> >  qemu-options.hx             |  16 ++++++-
> >  8 files changed, 179 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> > index c6f2032..2c6ab07 100644
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
> > @@ -1609,3 +1610,27 @@ void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
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
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 2073108..2458ebc 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -2678,6 +2678,10 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
> >      if (pcms->numa_nodes) {
> >          acpi_add_table(table_offsets, tables_blob);
> >          build_srat(tables_blob, tables->linker, machine);
> > +        if (have_numa_distance) {
> > +            acpi_add_table(table_offsets, tables_blob);
> > +            build_slit(tables_blob, tables->linker);
> > +        }
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
> > index 8f09dcf..0ea1bc0 100644
> > --- a/include/sysemu/numa.h
> > +++ b/include/sysemu/numa.h
> > @@ -8,6 +8,7 @@
> >  #include "hw/boards.h"
> >  
> >  extern int nb_numa_nodes;   /* Number of NUMA nodes */
> > +extern bool have_numa_distance;
> >  
> >  struct numa_addr_range {
> >      ram_addr_t mem_start;
> > @@ -21,6 +22,7 @@ typedef struct node_info {
> >      struct HostMemoryBackend *node_memdev;
> >      bool present;
> >      QLIST_HEAD(, numa_addr_range) addr; /* List to store address ranges */
> > +    uint8_t distance[MAX_NODES];
> >  } NodeInfo;
> >  
> >  extern NodeInfo numa_info[MAX_NODES];
> > diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> > index 576c7ce..6999545 100644
> > --- a/include/sysemu/sysemu.h
> > +++ b/include/sysemu/sysemu.h
> > @@ -169,6 +169,10 @@ extern int mem_prealloc;
> >  
> >  #define MAX_NODES 128
> >  #define NUMA_NODE_UNASSIGNED MAX_NODES
> > +#define NUMA_DISTANCE_MIN         10
> > +#define NUMA_DISTANCE_DEFAULT     20
> > +#define NUMA_DISTANCE_MAX         254
> > +#define NUMA_DISTANCE_UNREACHABLE 255
> >  
> >  #define MAX_OPTION_ROMS 16
> >  typedef struct QEMUOptionRom {
> > diff --git a/numa.c b/numa.c
> > index 6fc2393..1d3453a 100644
> > --- a/numa.c
> > +++ b/numa.c
> > @@ -51,6 +51,7 @@ static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
> >                               * For all nodes, nodeid < max_numa_nodeid
> >                               */
> >  int nb_numa_nodes;
> > +bool have_numa_distance;
> >  NodeInfo numa_info[MAX_NODES];
> >  
> >  void numa_set_mem_node_id(ram_addr_t addr, uint64_t size, uint32_t node)
> > @@ -212,6 +213,41 @@ static void numa_node_parse(NumaNodeOptions *node, QemuOpts *opts, Error **errp)
> >      max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
> >  }
> >  
> > +static void numa_distance_parse(NumaDistOptions *dist, QemuOpts *opts, Error **errp)
> > +{
> > +    uint16_t src = dist->src;
> > +    uint16_t dst = dist->dst;
> > +    uint8_t val = dist->val;
> > +
> > +    if (!numa_info[src].present || !numa_info[dst].present) {
> possible out of bounds read since src/dst here could be > MAX_NODES here,
> move this block after "if (src >= MAX_NODES || dst >= MAX_NODES) {"
> 
Yes, thanks for pointing it out.
> > +        error_setg(errp, "Source/Destination NUMA node is missing. "
> > +                   "Please use '-numa node' option to declare it first.");
> > +        return;
> > +    }
> > +
> > +    if (src >= MAX_NODES || dst >= MAX_NODES) {
> > +        error_setg(errp, "Max number of NUMA nodes reached: %"
> > +                   PRIu16 "", MAX_NODES);
> message implies that max number of nodes has been allocated,
> which is not what check verifies.
> how about:
>  "Invalid node %" PRIu16 ", max possible could be %d" 
> 
As we should tell user which nodeid (src or dst) is invalid, what do you
think of divide this if into 2 ifs like:

```
    if (src >= MAX_NODES) {
        error_setg(errp,
                   "Invalid node %" PRIu16
                   ", max possible could be %" PRIu16,
                   src, MAX_NODES);
        return;
    }

    if (dst >= MAX_NODES) {
        error_setg(errp,
                   "Invalid node %" PRIu16
                   ", max possible could be %" PRIu16,
                   dst, MAX_NODES);
        return;
    }
```
> > +        return;
> > +    }
> > +
> > +    if (val < NUMA_DISTANCE_MIN) {
> > +        error_setg(errp, "NUMA distance (%" PRIu8 ") is invalid, "
> > +                   "it should be larger than %d.",
> > +                   val, NUMA_DISTANCE_MIN);
> > +        return;
> > +    }
> > +
> > +    if (src == dst && val != NUMA_DISTANCE_MIN) {
> > +        error_setg(errp, "Local distance of node %d should be %d.",
> > +                   src, NUMA_DISTANCE_MIN);
> > +        return;
> > +    }
> > +
> > +    numa_info[src].distance[dst] = val;
> > +    have_numa_distance = true;
> > +}
> > +
> >  static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
> >  {
> >      NumaOptions *object = NULL;
> > @@ -235,6 +271,12 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
> >          }
> >          nb_numa_nodes++;
> >          break;
> > +    case NUMA_OPTIONS_TYPE_DIST:
> > +        numa_distance_parse(&object->u.dist, opts, &err);
> looks like 'opts' argument isn't used inside numa_distance_parse(),
> why it's here?
> 
> > +        if (err) {
> > +            goto end;
> > +        }
> > +        break;
> >      default:
> >          abort();
> >      }
> > @@ -294,6 +336,63 @@ static void validate_numa_cpus(void)
> >      g_free(seen_cpus);
> >  }
> >  
> > +static void validate_numa_distance(void)
> name of function doesn't match what it's doing,
> it not only validates but also sets/fixups distance values,
> 
> it would be cleaner to split verification and
> setting default/implied/mirrored values in to separate functions.
> 
I agree that split these operations to sepaprate functions (e.g.
`validate_numa_distance` and `fixup_numa_distance`) would be a good
idea.

But if so, two functions would repeat some operations e.g. check whether
the numa distance table is asymmetrical.

I prefer to keep validation and fixup in one function, of course, if we
come up with a good function name and we can make the function code
clear enough. Please correct me if I am wrong.

> > +{
> > +    int src, dst, s, d;
> > +    bool is_asymmetrical = false;
> > +    bool opposite_missing = false;
> > +
> > +    if (!have_numa_distance) {
> > +        return;
> > +    }
> > +
> > +    for (src = 0; src < nb_numa_nodes; src++) {
> > +        for (dst = src; dst < nb_numa_nodes; dst++) {
> > +            s = src;
> > +            d = dst;
> > +
> > +            if (numa_info[s].present && numa_info[d].present) {
> > +                if (numa_info[s].distance[d] == 0 &&
> > +                    numa_info[d].distance[s] == 0) {
> > +                    if (s == d) {
> > +                        numa_info[s].distance[d] = NUMA_DISTANCE_MIN;
> > +                    } else {
> > +                        error_report("The distance between node %d and %d is missing, "
> > +                                     "please provide all unique node pair distances.",
> > +                                     s, d);
> > +                        exit(EXIT_FAILURE);
> > +                    }
> > +                }
> > +
> > +                if (numa_info[s].distance[d] == 0) {
> > +                    s = dst;
> > +                    d = src;
> this swapping makes the following up code rather confusing,
> I'd prefer dst/src to be used as is in the capacity names imply and s, d dropped
> 
> PS:
> adding small comments around blocks in this function
> would help reviewers and whoever comes here later to
> understand what's going on.
> 
Oh, there should be comments here.

May I explain why I choose to use var s/d here and do this swapping.

Let's see some input cases first:
  +-----------+       +-----------+       +-----------+
  |XX 21 31 41|       |XX 21 31 XX|       |XX 21 31 41|
  |XX XX 21 31|       |XX XX 21 31|       |XX XX 21 31|
  |XX XX XX 21|       |XX XX XX 21|       |XX XX 10 21|
  |XX XX XX XX|       |41 XX XX XX|       |51 XX XX 10|
  +-----------+       +-----------+       +-----------+
       (1)                 (2)                 (3)
  (XX means the value is not provided by users.)

According to previous discussion, we agreed that user at least should
provide Table (1) as legal input because we can complete the whole with
default mirror distance policy.
Regarding Table (2), I think we also agreed that it is legal because if
we move left bottom 41 to the opposite position we still get a upper
triangular matrix and it is the same as Table (1).

I have to admit that s/d is confusing, what I mean is that `s`
represents the entry in upper triangular matrix and `d` represents the
entry in the lower triangular matrix that is symmetric with respect to
the main diagonal.

`if (numa_info[s].distance[d] == 0)` means that we miss the distance
value in the upper triangular matrix, we would encounter this in table
(2). In this case, we want to deal with Table (2) in the same way as
Table (1). So we do the swapping.

Table (1) and Table (2) would be regarded as symmetric matrices, they
are the same essentially.
Table (3) is illegal input since we find that one asymmetrical pair of
distances is given, in this case, the whole table should be given.

> > +                }
> > +
> > +                if (numa_info[d].distance[s] == 0) {
> if above swapping happened than this condition would be checking
> the same array entry as previous condition did, is that correct?
> 
I think yes although it does the same thing as previous condition from
the code view. Here, we want to check if the opposite entry is not set.
Let's see Table (2), when we process entry(1,4) i.e.
`numa_info[0].distance[3]`, we find it is 0, then we swap `s` and `d`,
now `numa_info[s].distance[d]` is `41`, and we will see this condition
makes sense in this case.
> > +                    opposite_missing = true;
> > +                }
> > +
> > +                if ((numa_info[d].distance[s] != 0) &&
> > +                    (numa_info[s].distance[d] != numa_info[d].distance[s])) {
> > +                    is_asymmetrical = true;
> > +                }
> > +
> > +                if (is_asymmetrical) {
> > +                    if (opposite_missing) {
> > +                        error_report("At least one asymmetrical pair of distances "
> > +                                     "is given, please provide distances for both "
> > +                                     "directions of all node pairs.");
> > +                        exit(EXIT_FAILURE);
> > +                    }
> > +                } else {
> what if numa_info[d].distance[s] is 0 and numa_info[s].distance[d] is 0 as well?
> wouldn't we end up with invalid distance entry in SLIT
> 
At the start of this function, we ensure that the symmetric value would
not be both 0.

I know, the code in this function may be not clear enough. But when I
treat the whole numa distance table as a matrix, it looks fine.
Anyway, this is my point of view, if you have any sugguestion, I am very
willing to know and cook a better patch in next version.

Thanks,
-He
