Received: from eggs.gnu.org ([2001:4830:134:3::10]:33111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fESzc-0000MP-KD
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fESzb-00053o-C4
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:10:52 -0400
Date: Fri, 4 May 2018 15:00:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180504050020.GU13229@umbus.fritz.box>
References: <20180503062145.17899-1-david@gibson.dropbear.id.au>
	<20180503062145.17899-4-david@gibson.dropbear.id.au>
	<20180503183416.1170da6b@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GXtmylMy6DdaH5oR"
Content-Disposition: inline
In-Reply-To: <20180503183416.1170da6b@bahia.lan>
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
To: Greg Kurz <groug@kaod.org>
Cc: clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com


--GXtmylMy6DdaH5oR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 06:34:16PM +0200, Greg Kurz wrote:
> On Thu,  3 May 2018 16:21:40 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > rtas_start_cpu() calls spapr_cpu_update_tb_offset() and
> > spapr_cpu_set_endianness() to initialize certain things in the new cpu's
> > state.  This is the only caller of those helpers, and they're each only
> > a few lines long, so we might as well just fold them into the caller.
> >=20
> > In addition, those helpers initialize state on the new cpu to match tha=
t of
> > the first cpu.  That will generally work, but might be at least logical=
ly
> > incorrect if the first cpu has been set offline by the guest.  So, inst=
ead
> > base the state on that of the cpu invoking the RTAS call, which is
> > obviously active already.
> >=20
>=20
> Much better indeed !
>=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr_rtas.c | 38 ++++++++++++++------------------------
> >  1 file changed, 14 insertions(+), 24 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> > index b251c130cb..df073447c5 100644
> > --- a/hw/ppc/spapr_rtas.c
> > +++ b/hw/ppc/spapr_rtas.c
> > @@ -120,27 +120,6 @@ static void rtas_query_cpu_stopped_state(PowerPCCP=
U *cpu_,
> >      rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> >  }
> > =20
> > -/*
> > - * Set the timebase offset of the CPU to that of first CPU.
> > - * This helps hotplugged CPU to have the correct timebase offset.
> > - */
> > -static void spapr_cpu_update_tb_offset(PowerPCCPU *cpu)
> > -{
> > -    PowerPCCPU *fcpu =3D POWERPC_CPU(first_cpu);
> > -
> > -    cpu->env.tb_env->tb_offset =3D fcpu->env.tb_env->tb_offset;
> > -}
> > -
> > -static void spapr_cpu_set_endianness(PowerPCCPU *cpu)
> > -{
> > -    PowerPCCPU *fcpu =3D POWERPC_CPU(first_cpu);
> > -    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(fcpu);
> > -
> > -    if (!pcc->interrupts_big_endian(fcpu)) {
> > -        cpu->env.spr[SPR_LPCR] |=3D LPCR_ILE;
> > -    }
> > -}
> > -
> >  static void rtas_start_cpu(PowerPCCPU *callcpu, sPAPRMachineState *spa=
pr,
> >                             uint32_t token, uint32_t nargs,
> >                             target_ulong args,
> > @@ -150,6 +129,7 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, sPA=
PRMachineState *spapr,
> >      PowerPCCPU *newcpu;
> >      CPUPPCState *env;
> >      PowerPCCPUClass *pcc;
> > +    target_ulong lpcr;
> > =20
> >      if (nargs !=3D 3 || nret !=3D 1) {
> >          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> > @@ -178,10 +158,20 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, s=
PAPRMachineState *spapr,
> >      cpu_synchronize_state(CPU(newcpu));
> > =20
> >      env->msr =3D (1ULL << MSR_SF) | (1ULL << MSR_ME);
> > -    spapr_cpu_set_endianness(newcpu);
> > -    spapr_cpu_update_tb_offset(newcpu);
> > +
> >      /* Enable Power-saving mode Exit Cause exceptions for the new CPU =
*/
> > -    ppc_store_lpcr(newcpu, env->spr[SPR_LPCR] | pcc->lpcr_pm);
> > +    lpcr =3D env->spr[SPR_LPCR] | pcc->lpcr_pm;
> > +    if (!pcc->interrupts_big_endian(callcpu)) {
> > +        lpcr |=3D LPCR_ILE;
> > +    }
> > +    ppc_store_lpcr(newcpu, lpcr);
> > +
> > +    /*
> > +     * Set the timebase offset of the new CPU to that of the invoking
> > +     * CPU.  This helps hotplugged CPU to have the correct timebase
>                ^
> Extraneous space here

Oh my, the can of worms you've opened with that apparently innocuous
comment :)
    https://en.wikipedia.org/wiki/Sentence_spacing#Controversy

tl;dr: I have a habit of putting a double space after full stops.  The
merits of that are highly debatable, but there it is.

> > +     * offset.
> > +     */
> > +    newcpu->env.tb_env->tb_offset =3D callcpu->env.tb_env->tb_offset;
> > =20
>=20
> Maybe use env-> instead of newcpu->env. ?

That is better, but I'm already most of the way through my
pre-pull-request testing, so I don't want to risk any code changes
(although I still fold the new R-bs into the commit messages).

>=20
> Anyway,
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> >      env->nip =3D start;
> >      env->gpr[3] =3D r3;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GXtmylMy6DdaH5oR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrr6OQACgkQbDjKyiDZ
s5I3dxAA4CvTblwc9jKQpNp7g7gZekHbXutFkmtSY/3EvNvrUtYtn7NzFJ5HLa0f
B9w8e3bndxvkQJEOUd0FIrE+oGPqtsGo6wvg9I0sXVJ9S3HLY/1sOWYBUATtMnaz
CDKrpcXYK9pE4CDRbr7AzcQvezICIK7VURE7bP3vHSm8J9Uiqqk7YPJaR1cwAXOw
lGIp/5+nM+Vu7B6MpbVLz7tpo7hVbMq5uPvAd/vEZ8Zx+Dohg+F72SPUPG9uRKEd
ycfeZZibKY7V+wWk/plNoQTiciMCOJhSrWfXabG/nsARuM+zS7ceb/ZwAc56kLma
nxi0MW+D/9H8dqVqghJDMcoepFkK/XNnlLvtMPln7wDuYX3W0dLJXy2E/DVRiZdy
agYW0s+hu5Ey/PGzcBK0kf/88+Z48MDZ3fmmKYz+iUFbIefupAjbLqcIlmASnPt8
5M3Yc6/sZQm/XOfeqp+aeMpGpAZNAtgcZn2ljyVMy+L0Z3INXryAKhsQ3BFzxdQQ
i9EUQkWAy8vS93CekqPvretQAFZBmGfcNeqXJW9etrlxfK0C4kIcdsl7PrZ9adH/
D8BGphgLWuUgPUjIzJtmXifEBdLr0IZGG5k48N/NbXnBiB18J5pk194tYI8tRRfv
2bY9qbgPmAqYdK2vYHFlpfonSOBkTC7g3S/59ho7C7SxG6j+n2Q=
=eCCZ
-----END PGP SIGNATURE-----

--GXtmylMy6DdaH5oR--
