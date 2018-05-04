Received: from eggs.gnu.org ([2001:4830:134:3::10]:53305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fEURq-00029q-Rt
	for qemu-devel@nongnu.org; Fri, 04 May 2018 02:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fEURn-0003bN-NX
	for qemu-devel@nongnu.org; Fri, 04 May 2018 02:44:06 -0400
Received: from 3.mo69.mail-out.ovh.net ([188.165.52.203]:44154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fEURn-0003aZ-DA
	for qemu-devel@nongnu.org; Fri, 04 May 2018 02:44:03 -0400
Received: from player691.ha.ovh.net (unknown [10.109.120.17])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id B362915062
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 08:44:01 +0200 (CEST)
Date: Fri, 4 May 2018 08:43:53 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180504084353.1b64d73b@bahia.lan>
In-Reply-To: <20180504050020.GU13229@umbus.fritz.box>
References: <20180503062145.17899-1-david@gibson.dropbear.id.au>
	<20180503062145.17899-4-david@gibson.dropbear.id.au>
	<20180503183416.1170da6b@bahia.lan>
	<20180504050020.GU13229@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/Y4CG4F2xpUXwpEwYyE4JSZx";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 3/8] spapr: Remove unhelpful helpers from
 rtas_start_cpu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com

--Sig_/Y4CG4F2xpUXwpEwYyE4JSZx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 4 May 2018 15:00:20 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, May 03, 2018 at 06:34:16PM +0200, Greg Kurz wrote:
> > On Thu,  3 May 2018 16:21:40 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > rtas_start_cpu() calls spapr_cpu_update_tb_offset() and
> > > spapr_cpu_set_endianness() to initialize certain things in the new cp=
u's
> > > state.  This is the only caller of those helpers, and they're each on=
ly
> > > a few lines long, so we might as well just fold them into the caller.
> > >=20
> > > In addition, those helpers initialize state on the new cpu to match t=
hat of
> > > the first cpu.  That will generally work, but might be at least logic=
ally
> > > incorrect if the first cpu has been set offline by the guest.  So, in=
stead
> > > base the state on that of the cpu invoking the RTAS call, which is
> > > obviously active already.
> > >  =20
> >=20
> > Much better indeed !
> >  =20
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > ---
> > >  hw/ppc/spapr_rtas.c | 38 ++++++++++++++------------------------
> > >  1 file changed, 14 insertions(+), 24 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> > > index b251c130cb..df073447c5 100644
> > > --- a/hw/ppc/spapr_rtas.c
> > > +++ b/hw/ppc/spapr_rtas.c
> > > @@ -120,27 +120,6 @@ static void rtas_query_cpu_stopped_state(PowerPC=
CPU *cpu_,
> > >      rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> > >  }
> > > =20
> > > -/*
> > > - * Set the timebase offset of the CPU to that of first CPU.
> > > - * This helps hotplugged CPU to have the correct timebase offset.
> > > - */
> > > -static void spapr_cpu_update_tb_offset(PowerPCCPU *cpu)
> > > -{
> > > -    PowerPCCPU *fcpu =3D POWERPC_CPU(first_cpu);
> > > -
> > > -    cpu->env.tb_env->tb_offset =3D fcpu->env.tb_env->tb_offset;
> > > -}
> > > -
> > > -static void spapr_cpu_set_endianness(PowerPCCPU *cpu)
> > > -{
> > > -    PowerPCCPU *fcpu =3D POWERPC_CPU(first_cpu);
> > > -    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(fcpu);
> > > -
> > > -    if (!pcc->interrupts_big_endian(fcpu)) {
> > > -        cpu->env.spr[SPR_LPCR] |=3D LPCR_ILE;
> > > -    }
> > > -}
> > > -
> > >  static void rtas_start_cpu(PowerPCCPU *callcpu, sPAPRMachineState *s=
papr,
> > >                             uint32_t token, uint32_t nargs,
> > >                             target_ulong args,
> > > @@ -150,6 +129,7 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, s=
PAPRMachineState *spapr,
> > >      PowerPCCPU *newcpu;
> > >      CPUPPCState *env;
> > >      PowerPCCPUClass *pcc;
> > > +    target_ulong lpcr;
> > > =20
> > >      if (nargs !=3D 3 || nret !=3D 1) {
> > >          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> > > @@ -178,10 +158,20 @@ static void rtas_start_cpu(PowerPCCPU *callcpu,=
 sPAPRMachineState *spapr,
> > >      cpu_synchronize_state(CPU(newcpu));
> > > =20
> > >      env->msr =3D (1ULL << MSR_SF) | (1ULL << MSR_ME);
> > > -    spapr_cpu_set_endianness(newcpu);
> > > -    spapr_cpu_update_tb_offset(newcpu);
> > > +
> > >      /* Enable Power-saving mode Exit Cause exceptions for the new CP=
U */
> > > -    ppc_store_lpcr(newcpu, env->spr[SPR_LPCR] | pcc->lpcr_pm);
> > > +    lpcr =3D env->spr[SPR_LPCR] | pcc->lpcr_pm;
> > > +    if (!pcc->interrupts_big_endian(callcpu)) {
> > > +        lpcr |=3D LPCR_ILE;
> > > +    }
> > > +    ppc_store_lpcr(newcpu, lpcr);
> > > +
> > > +    /*
> > > +     * Set the timebase offset of the new CPU to that of the invoking
> > > +     * CPU.  This helps hotplugged CPU to have the correct timebase =
=20
> >                ^
> > Extraneous space here =20
>=20
> Oh my, the can of worms you've opened with that apparently innocuous
> comment :)
>     https://en.wikipedia.org/wiki/Sentence_spacing#Controversy
>=20

Ha ha ! I now have an impression of deja-vu, probably on this very same
list :D

> tl;dr: I have a habit of putting a double space after full stops.  The
> merits of that are highly debatable, but there it is.
>=20

Sure, I'll try to remember that the so-called French spacing doesn't
rule the world... yet ;)


> > > +     * offset.
> > > +     */
> > > +    newcpu->env.tb_env->tb_offset =3D callcpu->env.tb_env->tb_offset;
> > >   =20
> >=20
> > Maybe use env-> instead of newcpu->env. ? =20
>=20
> That is better, but I'm already most of the way through my
> pre-pull-request testing, so I don't want to risk any code changes
> (although I still fold the new R-bs into the commit messages).
>=20

Understandable.

> >=20
> > Anyway,
> >=20
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> >  =20
> > >      env->nip =3D start;
> > >      env->gpr[3] =3D r3; =20
> >  =20
>=20


--Sig_/Y4CG4F2xpUXwpEwYyE4JSZx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlrsASkACgkQcdTV5YIv
c9al7w//a0A0qKy2xgXjIjQ87jBLYjeiMaMTcNkMr8L7ZcMMe+TySGWQwlvUIp1+
biusVR1wdiXlVo6V27rzdkOzwW/mpfb6LXQJFkjUaFKL5MTGOkNuwin5FxHbeXoe
datEsHvQLxYppGxigPXWrJjTUfTkOui/fNuni+RuRpoonWXXUgfYVxbz/QEEf+Am
E+w9B3lIY0fn1uNJJpaNBU0f5B/KF5sDXTFkyMOSW8Ig0fyT9bFrFaeoKn8d15wt
bSDMY6Ph73PWypPN/wszweOIVELPAXuvBz20YfKynGKRHsCaA7/8z76AFFx+JD3T
V2evzzFyEu8Q+m4FWdigLmqp5QV0pekB+WxfD7R3H4kVE8uIwUGjo3e3K9k9kK5L
Vv0/i74ilj8WB8USfK4mX7G7M9zGX15uu/SccXL8RA25kalx8vY88GR6potjKFie
RVh75vB1XJUSp/NppkiN+rR2LSFKALnTmp6mIRPit7lhXvJZ/c/4G/tqwgAP734S
VnsiRYiJLFuA59KF31HCaU/jroC6IBR7e7s5yA4j5kTx/uQxjVQhFiwnmYbf/zxR
YHpQTOcjpeDsQBYIj8U2uA+BB9nIBDiaDcbjmAAE0fKjVtZM/Ampjv9S4I6cIPhB
I0h1/rPwivToD+4nkLbU6oP1BV7Vq5SGx97s43uf9mvPy68fIGY=
=jfSF
-----END PGP SIGNATURE-----

--Sig_/Y4CG4F2xpUXwpEwYyE4JSZx--
