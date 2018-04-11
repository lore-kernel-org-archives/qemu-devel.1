Received: from eggs.gnu.org ([2001:4830:134:3::10]:33872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f6BeV-0002Sf-Qi
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 05:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f6BeR-0000nl-Cq
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 05:02:51 -0400
Received: from 8.mo177.mail-out.ovh.net ([46.105.61.98]:42698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f6BeR-0000jx-6J
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 05:02:47 -0400
Received: from player735.ha.ovh.net (unknown [10.109.108.91])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id CCAC7AAD02
	for <qemu-devel@nongnu.org>; Wed, 11 Apr 2018 11:02:35 +0200 (CEST)
Date: Wed, 11 Apr 2018 11:02:27 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180411110203.50073321@bahia.lan>
In-Reply-To: <20180411000348.GL3361@umbus.fritz.box>
References: <1523383946-37373-1-git-send-email-spopovyc@redhat.com>
	<1523383946-37373-2-git-send-email-spopovyc@redhat.com>
	<20180411000348.GL3361@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for 2.13 v2 1/2] spapr: Add ibm,
 max-associativity-domains property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Serhii Popovych <spopovyc@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

On Wed, 11 Apr 2018 10:03:48 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Apr 10, 2018 at 02:12:25PM -0400, Serhii Popovych wrote:
> > Now recent kernels (i.e. since linux-stable commit a346137e9142
> > ("powerpc/numa: Use ibm,max-associativity-domains to discover possible nodes")
> > support this property to mark initially memory-less NUMA nodes as "possible"
> > to allow further memory hot-add to them.
> > 
> > Advertise this property for pSeries machines to let guest kernels detect
> > maximum supported node configuration and benefit from kernel side change
> > when hot-add memory to specific, possibly empty before, NUMA node.
> > 
> > Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
> > ---
> >  hw/ppc/spapr.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 2c0be8c..3f61785 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -909,6 +909,14 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
> >          0, cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE),
> >          cpu_to_be32(max_cpus / smp_threads),
> >      };
> > +    uint32_t maxdomains[] = {
> > +        cpu_to_be32(5),
> > +        cpu_to_be32(0),
> > +        cpu_to_be32(0),
> > +        cpu_to_be32(0),
> > +        cpu_to_be32(nb_numa_nodes - 1),
> > +        cpu_to_be32(0),
> > +    };  
> 
> Ah.. close, but not quite right.  This is saying that there's exactly
> one node at the bottom (cpu) level, which isn't what we want.  Instead
> of setting it to 0, we want to completely drop that layer, keeping it
> unspecified.
> 
> To do that you need to change the first cell from 5 to 4 (since only 4
> levels will be listed) and drop the last cell entirely.
> 

Alternatively, if we don't want to do any assumptions on the guest
expectations, it is possible to pass the right value in the 6th cell:

	cpu_to_be32(spapr_vcpu_id(spapr, max_cpus - 1))

> >      _FDT(rtas = fdt_add_subnode(fdt, 0, "rtas"));
> >  
> > @@ -945,6 +953,9 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
> >      _FDT(fdt_setprop(fdt, rtas, "ibm,associativity-reference-points",
> >                       refpoints, sizeof(refpoints)));
> >  
> > +    _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
> > +                     maxdomains, sizeof(maxdomains)));
> > +
> >      _FDT(fdt_setprop_cell(fdt, rtas, "rtas-error-log-max",
> >                            RTAS_ERROR_LOG_MAX));
> >      _FDT(fdt_setprop_cell(fdt, rtas, "rtas-event-scan-rate",  
> 
