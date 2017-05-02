Received: from eggs.gnu.org ([2001:4830:134:3::10]:45192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d5e6h-0000FY-FG
	for qemu-devel@nongnu.org; Tue, 02 May 2017 16:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d5e6e-0000Tq-BA
	for qemu-devel@nongnu.org; Tue, 02 May 2017 16:09:11 -0400
Date: Tue, 2 May 2017 17:09:03 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170502200903.GE3482@thinpad.lan.raisama.net>
References: <20170502162955.1610-1-lvivier@redhat.com>
	<20170502162955.1610-2-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170502162955.1610-2-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/1] numa: equally distribute memory on
 nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Tue, May 02, 2017 at 06:29:55PM +0200, Laurent Vivier wrote:
[...]
> diff --git a/numa.c b/numa.c
> index 6fc2393..750fd95 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -294,6 +294,42 @@ static void validate_numa_cpus(void)
>      g_free(seen_cpus);
>  }
>  
> +void numa_legacy_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
> +                                 int nb_nodes, ram_addr_t size)
> +{
> +    int i;
> +    uint64_t usedmem = 0;
> +
> +    /* Align each node according to the alignment
> +     * requirements of the machine class
> +     */
> +
> +    for (i = 0; i < nb_nodes - 1; i++) {
> +        nodes[i].node_mem = (size / nb_nodes) &
> +                            ~((1 << mc->numa_mem_align_shift) - 1);
> +        usedmem += nodes[i].node_mem;
> +    }
> +    nodes[i].node_mem = size - usedmem;
> +}
> +
> +void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
> +                                  int nb_nodes, ram_addr_t size)
> +{
> +    int i;
> +    uint64_t usedmem = 0, node_mem;
> +    uint64_t granularity = size / nb_nodes;
> +    uint64_t propagate = 0;
> +
> +    for (i = 0; i < nb_nodes - 1; i++) {
> +        node_mem = (granularity + propagate) &
> +                   ~((1 << mc->numa_mem_align_shift) - 1);
> +        propagate = granularity + propagate - node_mem;
> +        nodes[i].node_mem = node_mem;
> +        usedmem += node_mem;
> +    }
> +    nodes[i].node_mem = ram_size - usedmem;

I believe you meant 'size - usedmem' here.

I can fix this while applying the patch, if that's OK. The rest
of the patch looks good to me.

> +}
> +
>  void parse_numa_opts(MachineClass *mc)
>  {
>      int i;
> @@ -336,17 +372,8 @@ void parse_numa_opts(MachineClass *mc)
>              }
>          }
>          if (i == nb_numa_nodes) {
> -            uint64_t usedmem = 0;
> -
> -            /* Align each node according to the alignment
> -             * requirements of the machine class
> -             */
> -            for (i = 0; i < nb_numa_nodes - 1; i++) {
> -                numa_info[i].node_mem = (ram_size / nb_numa_nodes) &
> -                                        ~((1 << mc->numa_mem_align_shift) - 1);
> -                usedmem += numa_info[i].node_mem;
> -            }
> -            numa_info[i].node_mem = ram_size - usedmem;
> +            assert(mc->numa_auto_assign_ram);
> +            mc->numa_auto_assign_ram(mc, numa_info, nb_numa_nodes, ram_size);
>          }
>  
>          numa_total = 0;
> -- 
> 2.9.3
> 

-- 
Eduardo
