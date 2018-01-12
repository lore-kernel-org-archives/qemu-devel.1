Received: from eggs.gnu.org ([2001:4830:134:3::10]:52426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1eZvZV-0008Og-I0
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:24:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1eZvZS-0000FM-Cd
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:24:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39272
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1eZvZS-0000EZ-70
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:24:18 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0C9NhRl084566
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 04:24:17 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2feqs6ecmw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 04:24:16 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Fri, 12 Jan 2018 04:24:15 -0500
Date: Fri, 12 Jan 2018 07:24:09 -0200
From: joserz@linux.vnet.ibm.com
References: <20180106004722.1152-1-joserz@linux.vnet.ibm.com>
	<20180106004722.1152-2-joserz@linux.vnet.ibm.com>
	<20180111141622.GI24770@umbus.fritz.box>
	<20180112034619.GK24770@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180112034619.GK24770@umbus.fritz.box>
Message-Id: <20180112092409.ajlelwt5grwyqe6s@pacoca>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/1] spapr: Check SMT based on
 KVM_CAP_PPC_SMT_POSSIBLE
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

On Fri, Jan 12, 2018 at 02:46:19PM +1100, David Gibson wrote:
> On Fri, Jan 12, 2018 at 01:16:22AM +1100, David Gibson wrote:
> > On Fri, Jan 05, 2018 at 10:47:22PM -0200, Jose Ricardo Ziviani wrote:
> > > Power9 supports 4 HW threads/core but it's possible to emulate
> > > doorbells to implement virtual SMT. KVM has the KVM_CAP_PPC_SMT_POSSIBLE
> > > which returns a bitmap with all SMT modes supported by the host.
> > > 
> > > Today, QEMU forces the SMT mode based on PVR compat table, this is
> > > silently done in spapr_fixup_cpu_dt. Then, if user passes thread=8 the
> > > guest will end up with 4 threads/core without any feedback to the user.
> > > It is confusing and will crash QEMU if a cpu is hotplugged in that
> > > guest.
> > > 
> > > This patch makes use of KVM_CAP_PPC_SMT_POSSIBLE to check if the host
> > > supports the SMT mode so it allows Power9 guests to have 8 threads/core
> > > if desired.
> > > 
> > > Reported-by: Satheesh Rajendran <satheera@in.ibm.com>
> > > Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> > > ---
> > >  hw/ppc/spapr.c       | 14 +++++++++++++-
> > >  hw/ppc/trace-events  |  1 +
> > >  target/ppc/kvm.c     |  5 +++++
> > >  target/ppc/kvm_ppc.h |  6 ++++++
> > >  4 files changed, 25 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index d1acfe8858..ea2503cd2f 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -345,7 +345,19 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
> > >          PowerPCCPU *cpu = POWERPC_CPU(cs);
> > >          DeviceClass *dc = DEVICE_GET_CLASS(cs);
> > >          int index = spapr_vcpu_id(cpu);
> > > -        int compat_smt = MIN(smp_threads, ppc_compat_max_threads(cpu));
> > > +
> > > +        /* set smt to maximum for this current pvr if the number
> > > +         * passed is higher than defined by PVR compat mode AND
> > > +         * if KVM cannot emulate it.*/
> > > +        int compat_smt = smp_threads;
> > > +        if ((kvmppc_cap_smt_possible() & smp_threads) != smp_threads &&
> > > +                smp_threads > ppc_compat_max_threads(cpu)) {
> > > +            compat_smt = ppc_compat_max_threads(cpu);
> > 
> > I don't think this is the right approach.  We've been trying to remove
> > places where host properties (such as those read from KVM
> > capabilities) affect guest visible properties of the VM - like vsmt.
> > Places like that break migration and often libvirt expectations as
> > well.
> > 
> > This is putting one back in, and so a step in the wrong direction.
> 
> Following on from this with some more investigation.
> 
> I think the discussion is going off the rails because the reason for
> this compat threads limit has been forgotten.
> 
> *It has nothing to do with the host*.  It's been recoded a bunch, but
> the logic was originally introduced by 2a48d993 "spapr: Limit threads
> per core according to current compatibility mode".  It states that it
> was to avoid confusing the *guest* by presenting more threads than it
> expects on an compatible-with-old CPU.
> 
> This also explains why it's done in this otherwise weird way - just
> truncating the presented threads in the device tree, while the other
> threads still "exist" in the qemu and KVM model:
> 
> It's because this happens at CAS time, for the benefit of guests which
> don't understand newer CPUs, at which point it's really too late to
> report an error to the user or renumber the CPUs.
> 
> So I think what we actually want to do here is just *remove* the
> compat limit for POWER9 cpus.  Strictly it's to do with the host
> kernel rather than the cpu, but in practice we can count on POWER9
> guests not being confused by >4 threads (since they POWER8 compat
> guests running on POWER9 have to anyway).
> 
> 
> As a separate matter, we need to validate guest threads-per-core
> against what the host's capable of, but that doesn't belong here.

Awesome explanation

I'm going to make these changes, perform a lot of more tests and send
the patches.

Thank you

> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
