Received: from eggs.gnu.org ([2001:4830:134:3::10]:52879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1debCP-0003AZ-A6
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 02:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1debCM-0000jK-4e
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 02:07:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1debCL-0000iw-RD
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 02:07:30 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7763tkY051357
	for <qemu-devel@nongnu.org>; Mon, 7 Aug 2017 02:07:27 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2c5xu9h63v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 07 Aug 2017 02:07:27 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Mon, 7 Aug 2017 16:07:24 +1000
Date: Mon, 7 Aug 2017 16:07:20 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
References: <cover.1501740002.git.sam.bobroff@au1.ibm.com>
	<696b158f34bcf950f95709927f7496b5a4426229.1501740002.git.sam.bobroff@au1.ibm.com>
	<20170804031019.GG6553@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170804031019.GG6553@umbus.fritz.box>
Message-Id: <20170807060720.vy5xggkhisaj3w2k@tungsten.ozlabs.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] ppc: spapr: Make VCPU ID handling
 private to SPAPR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, agraf@suse.de

On Fri, Aug 04, 2017 at 01:10:19PM +1000, David Gibson wrote:
> On Thu, Aug 03, 2017 at 04:28:52PM +1000, Sam Bobroff wrote:
> > The concept of a VCPU ID that differs from the CPU's index
> > (cpu->cpu_index) exists only within SPAPR machines so, move the
> > functions ppc_get_vcpu_id() and ppc_get_cpu_by_vcpu_id() into spapr.c
> > and rename them appropriately.
> > 
> > Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> 
> Mostly good, but...
> 
> [snip]
> > +int spapr_vcpu_id(PowerPCCPU *cpu)
> > +{
> > +    return cpu->vcpu_id;
> > +}
> > +
> > +PowerPCCPU *spapr_find_cpu(int vcpu_id)
> > +{
> > +    CPUState *cs;
> > +
> > +    CPU_FOREACH(cs) {
> > +        PowerPCCPU *cpu = POWERPC_CPU(cs);
> > +
> > +        if (cpu->vcpu_id == vcpu_id) {
> > +            return cpu;
> > +        }
> > +    }
> > +
> > +    return NULL;
> > +}
> 
> [...]
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 7ccb350c5f..2bf2727860 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -512,7 +512,7 @@ bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
> >  
> >  unsigned long kvm_arch_vcpu_id(CPUState *cpu)
> >  {
> > -    return ppc_get_vcpu_id(POWERPC_CPU(cpu));
> > +    return spapr_vcpu_id(POWERPC_CPU(cpu));
> >  }
> 
> Here you've replaced an implicit dependency on spapr details in the
> generic code with an explicit dependency on spapr details.  That's the
> wrong direction.

Ah right, I'll flip it around.

> Instead _this_ one should directly reference vcpu_id, the spapr one
> should be something like:
> 
> 	if (kvm)
> 		return kvm_arch_vcpu_id(...)
> 	else
> 		return cpu_index;

OK.

> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
