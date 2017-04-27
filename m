Received: from eggs.gnu.org ([2001:4830:134:3::10]:37200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d481s-0005R3-UK
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d481p-00068a-RL
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:41:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9121)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d481p-00067O-Gy
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:41:53 -0400
Date: Thu, 27 Apr 2017 17:31:48 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170427203148.GN3482@thinpad.lan.raisama.net>
References: <20170427101259.13798-1-lvivier@redhat.com>
	<20170427101259.13798-3-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170427101259.13798-3-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] numa,
 spapr: equally distribute memory on nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On Thu, Apr 27, 2017 at 12:12:59PM +0200, Laurent Vivier wrote:
> When there are more nodes than memory available to put the minimum
> allowed memory by node, all the memory is put on the last node.
> 
> This is because we put (ram_size / nb_numa_nodes) &
> ~((1 << mc->numa_mem_align_shift) - 1); on each node, and in this
> case the value is 0. This is particularly true with pseries,
> as the memory must be aligned to 256MB.
> 
> To avoid this problem, this patch uses an error diffusion algorithm [1]
> to distribute equally the memory on nodes.
> 
> Example:
> 
> qemu-system-ppc64 -S -nographic  -nodefaults -monitor stdio -m 1G -smp 8 \
>                   -numa node -numa node -numa node \
>                   -numa node -numa node -numa node
> 
> Before:
> 
> (qemu) info numa
> 6 nodes
> node 0 cpus: 0 6
> node 0 size: 0 MB
> node 1 cpus: 1 7
> node 1 size: 0 MB
> node 2 cpus: 2
> node 2 size: 0 MB
> node 3 cpus: 3
> node 3 size: 0 MB
> node 4 cpus: 4
> node 4 size: 0 MB
> node 5 cpus: 5
> node 5 size: 1024 MB
> 
> After:
> (qemu) info numa
> 6 nodes
> node 0 cpus: 0 6
> node 0 size: 0 MB
> node 1 cpus: 1 7
> node 1 size: 256 MB
> node 2 cpus: 2
> node 2 size: 0 MB
> node 3 cpus: 3
> node 3 size: 256 MB
> node 4 cpus: 4
> node 4 size: 256 MB
> node 5 cpus: 5
> node 5 size: 256 MB
> 
> [1] https://en.wikipedia.org/wiki/Error_diffusion
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  hw/ppc/spapr.c         | 21 ++++++++++++++++++++-
>  include/hw/ppc/spapr.h |  3 ++-
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 80d12d0..be498e2 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3106,6 +3106,23 @@ static void spapr_pic_print_info(InterruptStatsProvider *obj,
>      ics_pic_print_info(spapr->ics, mon);
>  }
>  
> +static void spapr_numa_auto_assign_ram(uint64_t *nodes, int nb_nodes,
> +                                       ram_addr_t size)
> +{
> +    int i;
> +    uint64_t usedmem = 0, node_mem;
> +    uint64_t granularity = size / nb_nodes;
> +    uint64_t propagate = 0;
> +
> +    for (i = 0; i < nb_nodes - 1; i++) {
> +        node_mem = (granularity + propagate) & ~(SPAPR_MEMORY_BLOCK_SIZE - 1);
> +        propagate = granularity + propagate - node_mem;
> +        nodes[i] = node_mem;
> +        usedmem += node_mem;
> +    }
> +    nodes[i] = ram_size - usedmem;
> +}

This new algorithm is a much better default, I would like to
enable it for all machines by default. We could move it to
core/machine.c:machine_class_init(), and set numa_auto_assign_ram
to NULL on pc-*-2.9 and spapr-2.9.

> +
>  static void spapr_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
> @@ -3162,7 +3179,8 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>       * SPAPR_MEMORY_BLOCK_SIZE (256M) since that's the granularity
>       * in which LMBs are represented and hot-added
>       */
> -    mc->numa_mem_align_shift = 28;
> +    mc->numa_mem_align_shift = SPAPR_MEMORY_BLOCK_SIZE_SHIFT;
> +    mc->numa_auto_assign_ram = spapr_numa_auto_assign_ram;
>  }
>  
>  static const TypeInfo spapr_machine_info = {
> @@ -3242,6 +3260,7 @@ static void spapr_machine_2_9_class_options(MachineClass *mc)
>  {
>      spapr_machine_2_10_class_options(mc);
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_9);
> +    mc->numa_auto_assign_ram = NULL;
>  }
>  
>  DEFINE_SPAPR_MACHINE(2_9, "2.9", false);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 5802f88..8f4a588 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -653,7 +653,8 @@ int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t legacy_offset);
>  
>  int spapr_rng_populate_dt(void *fdt);
>  
> -#define SPAPR_MEMORY_BLOCK_SIZE (1 << 28) /* 256MB */
> +#define SPAPR_MEMORY_BLOCK_SIZE_SHIFT 28 /* 256MB */
> +#define SPAPR_MEMORY_BLOCK_SIZE (1 << SPAPR_MEMORY_BLOCK_SIZE_SHIFT)
>  
>  /*
>   * This defines the maximum number of DIMM slots we can have for sPAPR
> -- 
> 2.9.3
> 

-- 
Eduardo
