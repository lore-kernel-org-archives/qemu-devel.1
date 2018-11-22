Received: from eggs.gnu.org ([2001:4830:134:3::10]:55860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gPpKf-0004N3-GP
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:47:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gPpKc-00088M-BO
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:47:49 -0500
References: <1542892767-37213-1-git-send-email-spopovyc@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <75213f48-7260-97f4-5b1e-7e13cb2dc2bb@redhat.com>
Date: Thu, 22 Nov 2018 14:47:40 +0100
MIME-Version: 1.0
In-Reply-To: <1542892767-37213-1-git-send-email-spopovyc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 3.1 v3] spapr: Fix ibm,
 max-associativity-domains property number of nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Serhii Popovych <spopovyc@redhat.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On 22/11/2018 14:19, Serhii Popovych wrote:
> Laurent Vivier reported off by one with maximum number of NUMA nodes
> provided by qemu-kvm being less by one than required according to
> description of "ibm,max-associativity-domains" property in LoPAPR.
> 
> It appears that I incorrectly treated LoPAPR description of this
> property assuming it provides last valid domain (NUMA node here)
> instead of maximum number of domains.
> 
>   ### Before hot-add
> 
>   (qemu) info numa
>   3 nodes
>   node 0 cpus: 0
>   node 0 size: 0 MB
>   node 0 plugged: 0 MB
>   node 1 cpus:
>   node 1 size: 1024 MB
>   node 1 plugged: 0 MB
>   node 2 cpus:
>   node 2 size: 0 MB
>   node 2 plugged: 0 MB
> 
>   $ numactl -H
>   available: 2 nodes (0-1)
>   node 0 cpus: 0
>   node 0 size: 0 MB
>   node 0 free: 0 MB
>   node 1 cpus:
>   node 1 size: 999 MB
>   node 1 free: 658 MB
>   node distances:
>   node   0   1
>     0:  10  40
>     1:  40  10
> 
>   ### Hot-add
> 
>   (qemu) object_add memory-backend-ram,id=mem0,size=1G
>   (qemu) device_add pc-dimm,id=dimm1,memdev=mem0,node=2
>   (qemu) [   87.704898] pseries-hotplug-mem: Attempting to hot-add 4 ...
>   <there is no "Initmem setup node 2 [mem 0xHEX-0xHEX]">
>   [   87.705128] lpar: Attempting to resize HPT to shift 21
>   ... <HPT resize messages>
> 
>   ### After hot-add
> 
>   (qemu) info numa
>   3 nodes
>   node 0 cpus: 0
>   node 0 size: 0 MB
>   node 0 plugged: 0 MB
>   node 1 cpus:
>   node 1 size: 1024 MB
>   node 1 plugged: 0 MB
>   node 2 cpus:
>   node 2 size: 1024 MB
>   node 2 plugged: 1024 MB
> 
>   $ numactl -H
>   available: 2 nodes (0-1)
>   ^^^^^^^^^^^^^^^^^^^^^^^^
>              Still only two nodes (and memory hot-added to node 0 below)
>   node 0 cpus: 0
>   node 0 size: 1024 MB
>   node 0 free: 1021 MB
>   node 1 cpus:
>   node 1 size: 999 MB
>   node 1 free: 658 MB
>   node distances:
>   node   0   1
>     0:  10  40
>     1:  40  10
> 
> After fix applied numactl(8) reports 3 nodes available and memory
> plugged into node 2 as expected.
> 
> From David Gibson:
> ------------------
>   Qemu makes a distinction between "non NUMA" (nb_numa_nodes == 0) and
>   "NUMA with one node" (nb_numa_nodes == 1).  But from a PAPR guests's
>   point of view these are equivalent.  I don't want to present two
>   different cases to the guest when we don't need to, so even though the
>   guest can handle it, I'd prefer we put a '1' here for both the
>   nb_numa_nodes == 0 and nb_numa_nodes == 1 case.
> 
> This consolidates everything discussed previously on mailing list.
> 
> Fixes: da9f80fbad21 ("spapr: Add ibm,max-associativity-domains property")
> Reported-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
> ---
>  hw/ppc/spapr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 7afd1a1..2ee7201 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1033,7 +1033,7 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
>          cpu_to_be32(0),
>          cpu_to_be32(0),
>          cpu_to_be32(0),
> -        cpu_to_be32(nb_numa_nodes ? nb_numa_nodes - 1 : 0),
> +        cpu_to_be32(nb_numa_nodes ? nb_numa_nodes : 1),
>      };
>  
>      _FDT(rtas = fdt_add_subnode(fdt, 0, "rtas"));
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
