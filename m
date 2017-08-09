Received: from eggs.gnu.org ([2001:4830:134:3::10]:39492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1dfESf-0002XD-Oi
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 20:02:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1dfESc-0000W3-FF
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 20:02:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52825
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1dfESc-0000V4-Ak
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 20:02:54 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v78Nx3Vb125973
	for <qemu-devel@nongnu.org>; Tue, 8 Aug 2017 20:02:52 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2c7ng7vq3h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 20:02:52 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Wed, 9 Aug 2017 10:02:49 +1000
Date: Wed, 9 Aug 2017 10:02:44 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
References: <cover.1502087564.git.sam.bobroff@au1.ibm.com>
	<2b5e13652c749b9ad2a519190396fe4160ac0dea.1502087564.git.sam.bobroff@au1.ibm.com>
	<20170808062420.82867C6037@b03ledav006.gho.boulder.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170808062420.82867C6037@b03ledav006.gho.boulder.ibm.com>
Message-Id: <20170809000244.3eptjvatsxsdbx2d@tungsten.ozlabs.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] ppc: spapr: Make VCPU ID handling
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, Aug 08, 2017 at 04:24:01PM +1000, David Gibson wrote:
> On Mon, Aug 07, 2017 at 04:33:29PM +1000, Sam Bobroff wrote:
> > The concept of a VCPU ID that differs from the CPU's index
> > (cpu->cpu_index) exists only within SPAPR machines so, move the
> > functions ppc_get_vcpu_id() and ppc_get_cpu_by_vcpu_id() into spapr.c
> > and rename them appropriately.
> > 
> > Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> > ---
> > Changes in v2:
> > 
> > * Re-arranged so that spapr_vcpu_id() calls kvm_arch_vcpu_id() rather than the
> > other way around.
> 
> Ah.. so close..
> 
> [snip]
> > +int spapr_vcpu_id(PowerPCCPU *cpu)
> > +{
> > +    CPUState *cs = CPU(cpu);
> > +
> > +    if (kvm_enabled()) {
> > +        return kvm_arch_vcpu_id(cs);
> > +    } else {
> > +        return cs->cpu_index;
> > +    }
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
> 
> This is still reaching into vcpu_id which should really be cpu
> private, not in spapr.  You can use spapr_vcpu_id() which you already
> defined to avoid this.

OK I'll post another version.

> With that done, I believe it should be possible to put cpu->vcpu_id in
> an ifdef CONFIG_KVM and have things work.

That is indeed possible! ifdefs are needed around the initialization
block in ppc_cpu_realizefn(), although here in spapr_vcpu_id() it doesn't seem
necessary. (Presumably because kvm_enabled() becomes a constant 0 without
CONFIG_KVM so the compiler can treat it like an ifdef.)

We don't want to actually patch it to use CONFIG_KVM though, do we? I
was intending (as part of the VSMT work) to make the vcpu_id a SPAPR
concept, rather than a KVM one, so that machines could (in theory
anyway) be migrated between KVM and non-KVM systems.

> > +            return cpu;
> > +        }
> > +    }
> > +
> > +    return NULL;
> > +}
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
