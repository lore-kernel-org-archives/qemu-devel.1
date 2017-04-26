Received: from eggs.gnu.org ([2001:4830:134:3::10]:33718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d3NyO-0005aV-I9
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d3NyK-00048d-BX
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:31:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d3NyK-00048B-2O
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:31:12 -0400
Date: Wed, 26 Apr 2017 11:31:08 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170426143108.GW3482@thinpad.lan.raisama.net>
References: <20170426100701.21893-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170426100701.21893-1-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] numa: equally distribute memory on nodes
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

On Wed, Apr 26, 2017 at 12:07:01PM +0200, Laurent Vivier wrote:
> When there is more nodes than memory available to put the minimum
> allowed memory by node, all the memory is put on the last node.
> 
> This is because we put (ram_size / nb_numa_nodes) &
> ~((1 << mc->numa_mem_align_shift) - 1); on each node, and in this
> case the value is 0. This is particularly true with pseries,
> as the memory must be aligned to 256MB.
> 
> To avoid this problem, this patch uses an error diffusion algorithm [1]
> to distribute equally the memory on nodes.

Nice.

But we need compat code to keep the previous behavior on older
machine-types. We can use either a new boolean MachineClass
field, or a MachineClass method (mc->auto_assign_ram(), maybe?)
that 2.9 machine-types could override.

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
>  numa.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/numa.c b/numa.c
> index 6fc2393..bcf1c54 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -336,15 +336,19 @@ void parse_numa_opts(MachineClass *mc)
>              }
>          }
>          if (i == nb_numa_nodes) {
> -            uint64_t usedmem = 0;
> +            uint64_t usedmem = 0, node_mem;
> +            uint64_t granularity = ram_size / nb_numa_nodes;
> +            uint64_t propagate = 0;
>  
>              /* Align each node according to the alignment
>               * requirements of the machine class
>               */
>              for (i = 0; i < nb_numa_nodes - 1; i++) {
> -                numa_info[i].node_mem = (ram_size / nb_numa_nodes) &
> +                node_mem = (granularity + propagate) &
>                                          ~((1 << mc->numa_mem_align_shift) - 1);
> -                usedmem += numa_info[i].node_mem;
> +                propagate = granularity + propagate - node_mem;
> +                numa_info[i].node_mem = node_mem;
> +                usedmem += node_mem;
>              }
>              numa_info[i].node_mem = ram_size - usedmem;
>          }
> -- 
> 2.9.3
> 

-- 
Eduardo
