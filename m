Received: from eggs.gnu.org ([2001:4830:134:3::10]:53049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cq2iD-00040w-5I
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 15:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cq2i8-0005XX-7R
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 15:11:25 -0400
Date: Mon, 20 Mar 2017 16:11:14 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170320191114.GE2811@thinpad.lan.raisama.net>
References: <20170320141244.20737-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170320141244.20737-1-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] numa,
 spapr: align default numa node memory size to 256MB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>

On Mon, Mar 20, 2017 at 03:12:44PM +0100, Laurent Vivier wrote:
> Since commit 224245b ("spapr: Add LMB DR connectors"), NUMA node
> memory size must be aligned to 256MB (SPAPR_MEMORY_BLOCK_SIZE).
> 
> But when "-numa" option is provided without "mem" parameter,
> the memory is equally divided between nodes, but 8MB aligned.
> This can be not valid for pseries.
> 
> In that case we can have:
> $ ./ppc64-softmmu/qemu-system-ppc64 -m 4G -numa node -numa node -numa node
> qemu-system-ppc64: Node 0 memory size 0x55000000 is not aligned to 256 MiB
> 
> With this patch, we have:
> (qemu) info numa
> 3 nodes
> node 0 cpus: 0
> node 0 size: 1280 MB
> node 1 cpus:
> node 1 size: 1280 MB
> node 2 cpus:
> node 2 size: 1536 MB
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

The code looks good, but a few comments explaining the reason for
the numa_mem_align_shift values would be interesting. Additional
comments below:

> ---
> v2:
> - remove dtc
> - Add a field in MachineClass to only modify the
>   numa node memory alignment value for pseries-2.9
>   and upper.
> 
>  hw/core/machine.c   | 3 +++
>  hw/ppc/spapr.c      | 2 ++
>  include/hw/boards.h | 1 +
>  numa.c              | 4 ++--
>  4 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 0d92672..2ad5ab5 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -396,6 +396,9 @@ static void machine_class_init(ObjectClass *oc, void *data)
>      mc->default_ram_size = 128 * M_BYTE;
>      mc->rom_file_has_mr = true;
>  
> +    /* numa node memory size aligned on 8MB by default */
> +    mc->numa_mem_align_shift = 23;
> +

This could include the original "On Linux, each node's border has
to be 8MB aligned" comment from parse_numa_opts(), to explain the
reason for the 8MB default.

>      object_class_property_add_str(oc, "accel",
>          machine_get_accel, machine_set_accel, &error_abort);
>      object_class_property_set_description(oc, "accel",
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 6ee566d..1e72fe8 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3096,6 +3096,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>      xic->ics_resend = spapr_ics_resend;
>      xic->icp_get = spapr_icp_get;
>      ispc->print_info = spapr_pic_print_info;
> +    mc->numa_mem_align_shift = 28;

A comment explaining why spapr requires 256MB alignment would be
nice.

>  }
>  
>  static const TypeInfo spapr_machine_info = {
> @@ -3180,6 +3181,7 @@ static void spapr_machine_2_8_class_options(MachineClass *mc)
>  {
>      spapr_machine_2_9_class_options(mc);
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_8);
> +    mc->numa_mem_align_shift = 23;
>  }
>  
>  DEFINE_SPAPR_MACHINE(2_8, "2.8", false);
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 269d0ba..31d9c72 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -135,6 +135,7 @@ struct MachineClass {
>      bool rom_file_has_mr;
>      int minimum_page_bits;
>      bool has_hotpluggable_cpus;
> +    int numa_mem_align_shift;
>  
>      HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
>                                             DeviceState *dev);
> diff --git a/numa.c b/numa.c
> index e01cb54..98e4d02 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -338,12 +338,12 @@ void parse_numa_opts(MachineClass *mc)
>          if (i == nb_numa_nodes) {
>              uint64_t usedmem = 0;
>  
> -            /* On Linux, each node's border has to be 8MB aligned,
> +            /* On Linux, each node's border has to be aligned,
>               * the final node gets the rest.
>               */

I assume that the 256MB alignment in spapr is not just because of
Linux (is it?). This makes the comment misleading.

I would rewrite it to something like: "Align each node according
to the alignment requirements of the machine class".


>              for (i = 0; i < nb_numa_nodes - 1; i++) {
>                  numa_info[i].node_mem = (ram_size / nb_numa_nodes) &
> -                                        ~((1 << 23UL) - 1);
> +                                        ~((1 << mc->numa_mem_align_shift) - 1);
>                  usedmem += numa_info[i].node_mem;
>              }
>              numa_info[i].node_mem = ram_size - usedmem;
> -- 
> 2.9.3
> 

-- 
Eduardo
