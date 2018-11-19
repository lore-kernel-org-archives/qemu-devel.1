Received: from eggs.gnu.org ([2001:4830:134:3::10]:35155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gOmtO-0000mu-2c
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 11:59:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gOmtL-00071V-A5
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 11:59:21 -0500
Received: from 3.mo173.mail-out.ovh.net ([46.105.34.1]:36964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gOmtK-0006zf-Iw
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 11:59:18 -0500
Received: from player688.ha.ovh.net (unknown [10.109.159.157])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id CB798E0D12
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 17:59:16 +0100 (CET)
Date: Mon, 19 Nov 2018 17:59:08 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181119175908.5d3e1d4a@bahia.lan>
In-Reply-To: <3411737e-824a-0653-024b-f46fe5695790@redhat.com>
References: <1542632978-65604-1-git-send-email-spopovyc@redhat.com>
	<20181119142719.3d702892@bahia.lan>
	<3411737e-824a-0653-024b-f46fe5695790@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for 3.1] spapr: Fix ibm,
 max-associativity-domains property number of nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Serhii Popovych <spopovyc@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On Mon, 19 Nov 2018 14:48:34 +0100
Laurent Vivier <lvivier@redhat.com> wrote:

> On 19/11/2018 14:27, Greg Kurz wrote:
> > On Mon, 19 Nov 2018 08:09:38 -0500
> > Serhii Popovych <spopovyc@redhat.com> wrote:
> >   
> >> Laurent Vivier reported off by one with maximum number of NUMA nodes
> >> provided by qemu-kvm being less by one than required according to
> >> description of "ibm,max-associativity-domains" property in LoPAPR.
> >>
> >> It appears that I incorrectly treated LoPAPR description of this
> >> property assuming it provides last valid domain (NUMA node here)
> >> instead of maximum number of domains.
> >>
> >>   ### Before hot-add
> >>
> >>   (qemu) info numa
> >>   3 nodes
> >>   node 0 cpus: 0
> >>   node 0 size: 0 MB
> >>   node 0 plugged: 0 MB
> >>   node 1 cpus:
> >>   node 1 size: 1024 MB
> >>   node 1 plugged: 0 MB
> >>   node 2 cpus:
> >>   node 2 size: 0 MB
> >>   node 2 plugged: 0 MB
> >>
> >>   $ numactl -H
> >>   available: 2 nodes (0-1)
> >>   node 0 cpus: 0
> >>   node 0 size: 0 MB
> >>   node 0 free: 0 MB
> >>   node 1 cpus:
> >>   node 1 size: 999 MB
> >>   node 1 free: 658 MB
> >>   node distances:
> >>   node   0   1
> >>     0:  10  40
> >>     1:  40  10
> >>
> >>   ### Hot-add
> >>
> >>   (qemu) object_add memory-backend-ram,id=mem0,size=1G
> >>   (qemu) device_add pc-dimm,id=dimm1,memdev=mem0,node=2
> >>   (qemu) [   87.704898] pseries-hotplug-mem: Attempting to hot-add 4 ...
> >>   <there is no "Initmem setup node 2 [mem 0xHEX-0xHEX]">
> >>   [   87.705128] lpar: Attempting to resize HPT to shift 21
> >>   ... <HPT resize messages>
> >>
> >>   ### After hot-add
> >>
> >>   (qemu) info numa
> >>   3 nodes
> >>   node 0 cpus: 0
> >>   node 0 size: 0 MB
> >>   node 0 plugged: 0 MB
> >>   node 1 cpus:
> >>   node 1 size: 1024 MB
> >>   node 1 plugged: 0 MB
> >>   node 2 cpus:
> >>   node 2 size: 1024 MB
> >>   node 2 plugged: 1024 MB
> >>
> >>   $ numactl -H
> >>   available: 2 nodes (0-1)
> >>   ^^^^^^^^^^^^^^^^^^^^^^^^
> >>              Still only two nodes (and memory hot-added to node 0 below)
> >>   node 0 cpus: 0
> >>   node 0 size: 1024 MB
> >>   node 0 free: 1021 MB
> >>   node 1 cpus:
> >>   node 1 size: 999 MB
> >>   node 1 free: 658 MB
> >>   node distances:
> >>   node   0   1
> >>     0:  10  40
> >>     1:  40  10
> >>
> >> After fix applied numactl(8) reports 3 nodes available and memory
> >> plugged into node 2 as expected.
> >>
> >> Fixes: da9f80fbad21 ("spapr: Add ibm,max-associativity-domains property")
> >> Reported-by: Laurent Vivier <lvivier@redhat.com>
> >> Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
> >> ---
> >>  hw/ppc/spapr.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index 7afd1a1..843ae6c 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -1033,7 +1033,7 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
> >>          cpu_to_be32(0),
> >>          cpu_to_be32(0),
> >>          cpu_to_be32(0),
> >> -        cpu_to_be32(nb_numa_nodes ? nb_numa_nodes - 1 : 0),
> >> +        cpu_to_be32(nb_numa_nodes ? nb_numa_nodes : 0),  
> > 
> > Maybe simply cpu_to_be32(nb_numa_nodes) ?  
> 
> Or "cpu_to_be32(nb_numa_nodes ? nb_numa_nodes : 1)" ?
> 
> In spapr_populate_drconf_memory() we have this logic.
> 

Hmm... maybe you're right, it seems that the code assumes
non-NUMA configs have at one node. Similar assumption is
also present in pc_dimm_realize():

    if (((nb_numa_nodes > 0) && (dimm->node >= nb_numa_nodes)) ||
        (!nb_numa_nodes && dimm->node)) {
        error_setg(errp, "'DIMM property " PC_DIMM_NODE_PROP " has value %"
                   PRIu32 "' which exceeds the number of numa nodes: %d",
                   dimm->node, nb_numa_nodes ? nb_numa_nodes : 1);
        return;
    }

This is a bit confusing...

> Thanks,
> Laurent
