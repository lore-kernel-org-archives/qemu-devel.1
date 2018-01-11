Received: from eggs.gnu.org ([2001:4830:134:3::10]:41800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eZbuY-0006zr-0C
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 07:24:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eZbuT-0006qa-Vg
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 07:24:46 -0500
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:46709)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eZbuT-0006oo-Ll
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 07:24:41 -0500
Received: from player755.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 55E0790B23
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 13:24:38 +0100 (CET)
Date: Thu, 11 Jan 2018 13:24:30 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180111132430.5f0f66c3@bahia.lan>
In-Reply-To: <20180105030729.GE24581@umbus.fritz.box>
References: <20180104042405.29773-1-david@gibson.dropbear.id.au>
	<20180104184718.568473a7@bahia.lan>
	<20180105030729.GE24581@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/wV_cXPId9D6TZTzPanCOsk8";
	protocol="application/pgp-signature"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: mdroth@linux.vnet.ibm.com, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, satheera@in.ibm.com

--Sig_/wV_cXPId9D6TZTzPanCOsk8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Jan 2018 14:07:29 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Jan 04, 2018 at 06:47:18PM +0100, Greg Kurz wrote:
> > On Thu,  4 Jan 2018 15:24:05 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > Currently the pseries machine sets the compatibility mode for the
> > > guest's cpus in two places: 1) at machine reset and 2) after CAS
> > > negotiation.
> > >=20
> > > This means that if we set or negotiate a compatiblity mode, then
> > > hotplug a cpu, the hotplugged cpu doesn't get the right mode set and
> > > will incorrectly have the full native features.
> > >=20
> > > To correct this, we set the compatibility mode on a cpu when it is
> > > brought online with the 'start-cpu' RTAS call.  Given that we no
> > > longer need to set the compatibility mode on all CPUs at machine
> > > reset, so we change that to only set the mode for the boot cpu.
> > >=20
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > ---
> > >  hw/ppc/spapr.c      | 2 +-
> > >  hw/ppc/spapr_rtas.c | 8 ++++++++
> > >  2 files changed, 9 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index e22888ba06..d1acfe8858 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -1510,7 +1510,7 @@ static void spapr_machine_reset(void)
> > >          spapr_ovec_cleanup(spapr->ov5_cas);
> > >          spapr->ov5_cas =3D spapr_ovec_new();
> > > =20
> > > -        ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
> > > +        ppc_set_compat(first_ppc_cpu, spapr->max_compat_pvr, &error_=
fatal);
> > >      }
> > > =20
> > >      fdt =3D spapr_build_fdt(spapr, rtas_addr, spapr->rtas_size);
> > > diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> > > index 4bb939d3d1..2ed00548c1 100644
> > > --- a/hw/ppc/spapr_rtas.c
> > > +++ b/hw/ppc/spapr_rtas.c
> > > @@ -163,6 +163,7 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAP=
RMachineState *spapr,
> > >          CPUState *cs =3D CPU(cpu);
> > >          CPUPPCState *env =3D &cpu->env;
> > >          PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> > > +        Error *local_err =3D NULL;
> > > =20
> > >          if (!cs->halted) {
> > >              rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> > > @@ -174,6 +175,13 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPA=
PRMachineState *spapr,
> > >           * new cpu enters */
> > >          kvm_cpu_synchronize_state(cs);
> > > =20
> > > +        /* Set compatibility mode to match existing cpus */
> > > +        ppc_set_compat(cpu, POWERPC_CPU(first_cpu)->compat_pvr, &loc=
al_err); =20
> >=20
> > Is it okay to report a simple HW error to the guest here instead of abo=
rting
> > like we do with first_cpu at reset time ? =20
>=20
> Should be: this happens before we turn the cpu on, so the effect will
> be that the guest fails to online the cpu.  That seems like a better
> failure mode than killing the already running guest.
>=20

Of course, I generally agree with the "better failure mode". My point was
just that if we managed to set the compat mode with the first cpu but we
fail to propagate the same compat mode to subsequent cpus, then this is
a bug in QEMU or KVM.

> >  =20
> > > +        if (local_err) {
> > > +            rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> > > +            return;
> > > +        }
> > > +
> > >          env->msr =3D (1ULL << MSR_SF) | (1ULL << MSR_ME);
> > > =20
> > >          /* Enable Power-saving mode Exit Cause exceptions for the ne=
w CPU */ =20
> >  =20
>=20


--Sig_/wV_cXPId9D6TZTzPanCOsk8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlpXV34ACgkQcdTV5YIv
c9YKLRAAismfLzaqN4Kds6g3wsNjqtrsC28XjHRaUHrvWh5uwpGHw+f7QgmNOWXl
zjN5bT2Ly1aEZuhsQvgrNsnayHsISoUhmguTdCqJdbegFRizxHhBqn/7M/BH30ze
T6RsAsbznKLiJZeLA94wjRifIPjiKILhpexM0cDPnf/D44ZLN+1pH4FHn5YRJxiN
NcCqeWLjYUCr3+d0vfmfl12AD87cztEHRmaLGpPbdXlCt/9LsAgVGraax5ClE50T
UaL0zhb2HOaPLb5bgjsOmCq5ESNq8ZssrRU/1JGDawksuqYUwpcrO6uBDtVe1eS6
Cb5KNCXO85Xzl0FwRqd15lRNoV58EHTwqj+viuKNwWvbIXYNkPQQcc4Ocul185HD
gtHcpdiKXFbtn1Fui9VlOMmp0utfjtyz022xv5wN3PjWZa8Il+64xDTHNMaX0FsE
en+y5Oi2UH14NUDWerMBzzlbwJcZ/eJPnQBmm5aTbnYIkVG0uOza2xH6PcjkPqM7
o2ZYV7pt/UmbHTFtFgTZ9S2yiB75p209k1YszLRFuTq2aeyUEFAiy9VoEcAvtf2O
bHhW1kiEJu/KDKANV0NerGjEqtOD2BTW6TRwH3zd8DKiG0bZ8OO41HQUbjFaMFOR
A9K/vCR3liVJfdYAx9arnVX0eHybrGStGTJuDXSRfZ8Y4zQPcog=
=zhL/
-----END PGP SIGNATURE-----

--Sig_/wV_cXPId9D6TZTzPanCOsk8--
