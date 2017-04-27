Received: from eggs.gnu.org ([2001:4830:134:3::10]:59362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d3k79-0007rC-MN
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d3k78-0006Tj-PN
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:09:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d3k78-0006TT-Ih
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:09:46 -0400
Date: Thu, 27 Apr 2017 11:09:41 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170427140941.GC3482@thinpad.lan.raisama.net>
References: <20170427101259.13798-1-lvivier@redhat.com>
	<20170427101259.13798-2-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170427101259.13798-2-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] numa: introduce
 numa_auto_assign_ram() function in MachineClass
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

On Thu, Apr 27, 2017 at 12:12:58PM +0200, Laurent Vivier wrote:
> We need to change the way we distribute the memory across
> the nodes. To keep compatibility between machine type version
> introduce a  machine type dependent function.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
[...]
> +static void numa_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
> +                                 int nb_nodes, ram_addr_t size)
> +{
> +    int i;
> +    uint64_t usedmem = 0;
> +
> +    if (mc->numa_auto_assign_ram) {
> +        uint64_t *mem = g_new(uint64_t, nb_nodes);
> +
> +        mc->numa_auto_assign_ram(mem, nb_nodes, size);
> +
> +        for (i = 0; i < nb_nodes; i++) {
> +            nodes[i].node_mem = mem[i];
> +        }
> +
> +        g_free(mem);
> +
> +        return;
> +    }
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

I would prefer to make your new algorithm the default, and move
this code to a legacy_auto_assign_ram() function set by the 2.9
machine-types.

> +
>  void parse_numa_opts(MachineClass *mc)
>  {
>      int i;
> @@ -336,17 +368,7 @@ void parse_numa_opts(MachineClass *mc)
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
> +            numa_auto_assign_ram(mc, numa_info, nb_numa_nodes, ram_size);
>          }
>  
>          numa_total = 0;
> -- 
> 2.9.3
> 

-- 
Eduardo
