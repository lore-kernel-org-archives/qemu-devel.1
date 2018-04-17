Received: from eggs.gnu.org ([2001:4830:134:3::10]:41279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1f8Hll-0006N7-Kd
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 23:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1f8Hlc-0005rK-Nn
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 23:59:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40826
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1f8Hlc-0005nM-HB
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 23:58:52 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3H3s2S3006485
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 23:58:51 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hd9dwg42w-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 23:58:51 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Tue, 17 Apr 2018 04:58:49 +0100
Date: Tue, 17 Apr 2018 09:28:42 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1523472120-56496-1-git-send-email-spopovyc@redhat.com>
	<1523472120-56496-2-git-send-email-spopovyc@redhat.com>
	<20180413075739.GC14855@in.ibm.com>
	<e651fb40-2e44-73ed-6082-d9e497073e69@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e651fb40-2e44-73ed-6082-d9e497073e69@redhat.com>
Message-Id: <20180417035842.GA3942@in.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for 2.13 v3 1/2] spapr: Add ibm,
 max-associativity-domains property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Serhii Popovych <spopovyc@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On Mon, Apr 16, 2018 at 07:47:29PM +0300, Serhii Popovych wrote:
> Bharata B Rao wrote:
> > On Wed, Apr 11, 2018 at 02:41:59PM -0400, Serhii Popovych wrote:
> >> Now recent kernels (i.e. since linux-stable commit a346137e9142
> >> ("powerpc/numa: Use ibm,max-associativity-domains to discover possible nodes")
> >> support this property to mark initially memory-less NUMA nodes as "possible"
> >> to allow further memory hot-add to them.
> >>
> >> Advertise this property for pSeries machines to let guest kernels detect
> >> maximum supported node configuration and benefit from kernel side change
> >> when hot-add memory to specific, possibly empty before, NUMA node.
> >>
> >> Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
> >> ---
> >>  hw/ppc/spapr.c | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index a81570e..c05bbad 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -910,6 +910,13 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
> >>          0, cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE),
> >>          cpu_to_be32(max_cpus / smp_threads),
> >>      };
> >> +    uint32_t maxdomains[] = {
> >> +        cpu_to_be32(4),
> >> +        cpu_to_be32(0),
> >> +        cpu_to_be32(0),
> >> +        cpu_to_be32(0),
> >> +        cpu_to_be32(nb_numa_nodes - 1),
> >> +    };
> >>
> >>      _FDT(rtas = fdt_add_subnode(fdt, 0, "rtas"));
> >>
> >> @@ -946,6 +953,9 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
> >>      _FDT(fdt_setprop(fdt, rtas, "ibm,associativity-reference-points",
> >>                       refpoints, sizeof(refpoints)));
> >>
> >> +    _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
> >> +                     maxdomains, sizeof(maxdomains)));
> >> +
> >>      _FDT(fdt_setprop_cell(fdt, rtas, "rtas-error-log-max",
> >>                            RTAS_ERROR_LOG_MAX));
> >>      _FDT(fdt_setprop_cell(fdt, rtas, "rtas-event-scan-rate",
> >> -- 
> >> 1.8.3.1
> > 
> > This commit causes hash guest with latest guest kernel to hang at early boot.
> 
> I use v4.16 tag from stable and can't reproduce on P8 machine reported
> issue.
> 
> Could you please share more details about your setup, kernel commit id
> you spot problem?

I am on 4.16.0-rc7 (commit id: 0b412605ef5f)

BTW this happens only for non-NUMA guest.

Regards,
Bharata.
