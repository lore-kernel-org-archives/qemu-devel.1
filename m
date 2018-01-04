Received: from eggs.gnu.org ([2001:4830:134:3::10]:50345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eXCnI-00045J-Cg
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 16:11:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eXCnE-0003Aq-4E
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 16:11:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59374
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eXCnD-00039g-VF
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 16:11:16 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w04L9Is2077193
	for <qemu-devel@nongnu.org>; Thu, 4 Jan 2018 16:11:14 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2f9pe0eveg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 16:11:13 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 4 Jan 2018 16:11:12 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180104184718.568473a7@bahia.lan>
References: <20180104042405.29773-1-david@gibson.dropbear.id.au>
	<20180104184718.568473a7@bahia.lan>
Date: Thu, 04 Jan 2018 15:11:03 -0600
Message-Id: <151510026307.2579.5877378669181689283@sif>
Subject: Re: [Qemu-devel] [PATCH] spapr: Correct compatibility mode setting
 for hotplugged CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Cc: surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, satheera@in.ibm.com

Quoting Greg Kurz (2018-01-04 11:47:18)
> On Thu,  4 Jan 2018 15:24:05 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
> =

> > Currently the pseries machine sets the compatibility mode for the
> > guest's cpus in two places: 1) at machine reset and 2) after CAS
> > negotiation.
> > =

> > This means that if we set or negotiate a compatiblity mode, then
> > hotplug a cpu, the hotplugged cpu doesn't get the right mode set and
> > will incorrectly have the full native features.
> > =

> > To correct this, we set the compatibility mode on a cpu when it is
> > brought online with the 'start-cpu' RTAS call.  Given that we no
> > longer need to set the compatibility mode on all CPUs at machine
> > reset, so we change that to only set the mode for the boot cpu.
> > =

> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr.c      | 2 +-
> >  hw/ppc/spapr_rtas.c | 8 ++++++++
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> > =

> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index e22888ba06..d1acfe8858 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1510,7 +1510,7 @@ static void spapr_machine_reset(void)
> >          spapr_ovec_cleanup(spapr->ov5_cas);
> >          spapr->ov5_cas =3D spapr_ovec_new();
> >  =

> > -        ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
> > +        ppc_set_compat(first_ppc_cpu, spapr->max_compat_pvr, &error_fa=
tal);
> >      }
> >  =

> >      fdt =3D spapr_build_fdt(spapr, rtas_addr, spapr->rtas_size);
> > diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> > index 4bb939d3d1..2ed00548c1 100644
> > --- a/hw/ppc/spapr_rtas.c
> > +++ b/hw/ppc/spapr_rtas.c
> > @@ -163,6 +163,7 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRM=
achineState *spapr,
> >          CPUState *cs =3D CPU(cpu);
> >          CPUPPCState *env =3D &cpu->env;
> >          PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> > +        Error *local_err =3D NULL;
> >  =

> >          if (!cs->halted) {
> >              rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> > @@ -174,6 +175,13 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPR=
MachineState *spapr,
> >           * new cpu enters */
> >          kvm_cpu_synchronize_state(cs);
> >  =

> > +        /* Set compatibility mode to match existing cpus */
> > +        ppc_set_compat(cpu, POWERPC_CPU(first_cpu)->compat_pvr, &local=
_err);
> =

> Is it okay to report a simple HW error to the guest here instead of abort=
ing
> like we do with first_cpu at reset time ?

And if we don't opt for &error_fatal, we need an error_free() below.

> =

> > +        if (local_err) {
> > +            rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> > +            return;
> > +        }
> > +
> >          env->msr =3D (1ULL << MSR_SF) | (1ULL << MSR_ME);
> >  =

> >          /* Enable Power-saving mode Exit Cause exceptions for the new =
CPU */
>=20
