Received: from eggs.gnu.org ([209.51.188.92]:58309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hGkiB-0000sk-SH
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 09:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hGkiA-000649-Dk
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 09:34:51 -0400
Date: Wed, 17 Apr 2019 22:46:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190417124605.GS32705@umbus.fritz.box>
References: <20190416045552.24573-1-npiggin@gmail.com>
	<20190417015934.GH32705@umbus.fritz.box>
	<1555498879.055yucy998.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XCAZszJJXrQJLz3d"
Content-Disposition: inline
In-Reply-To: <1555498879.055yucy998.astroid@bobo.none>
Subject: Re: [Qemu-devel] [PATCH v3] spapr: add splpar hcalls H_PROD,
 H_CONFER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--XCAZszJJXrQJLz3d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2019 at 09:20:00PM +1000, Nicholas Piggin wrote:
> David Gibson's on April 17, 2019 11:59 am:
> > On Tue, Apr 16, 2019 at 02:55:52PM +1000, Nicholas Piggin wrote:
> >> These implementations have a few deficiencies that are noted, but are
> >> good enough for Linux to use.
> >>=20
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >> ---
> >>=20
> >> v3: Removed wrong comment about GPR3, drop H_JOIN for now (at least un=
til
> >> it is tested some more in Linux/KVM), and expand the comment about not
> >> prod bit.
> >>=20
> >>  hw/ppc/spapr_hcall.c | 71 ++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 71 insertions(+)
> >>=20
> >> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> >> index 8a736797b9..8892ad008b 100644
> >> --- a/hw/ppc/spapr_hcall.c
> >> +++ b/hw/ppc/spapr_hcall.c
> >> @@ -1065,6 +1065,74 @@ static target_ulong h_cede(PowerPCCPU *cpu, Spa=
prMachineState *spapr,
> >>      return H_SUCCESS;
> >>  }
> >> =20
> >> +static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spap=
r,
> >> +                           target_ulong opcode, target_ulong *args)
> >> +{
> >> +    target_long target =3D args[0];
> >> +    CPUState *cs =3D CPU(cpu);
> >> +
> >> +    /*
> >> +     * This does not do a targeted yield or confer, but check the par=
ameter
> >> +     * anyway. -1 means confer to all/any other CPUs.
> >> +     */
> >> +    if (target !=3D -1 && !CPU(spapr_find_cpu(target))) {
> >> +        return H_PARAMETER;
> >> +    }
> >> +
> >> +    /*
> >> +     * PAPR calls for waiting until proded in this case (or presumably
> >> +     * an external interrupt if MSR[EE]=3D1, without dispatch sequenc=
e count
> >> +     * check.
> >=20
> > Is this comment complete?  It's missing a closing parenthesis at the
> > very least.
>=20
> Needs closing parenthesis after EE=3D1 AFAIKS. Good catch.
> =20
> >> +static target_ulong h_prod(PowerPCCPU *cpu, SpaprMachineState *spapr,
> >> +                           target_ulong opcode, target_ulong *args)
> >> +{
> >> +    target_long target =3D args[0];
> >> +    CPUState *cs;
> >> +
> >> +    /*
> >> +     * PAPR specifies there should be a prod flag should be associate=
d with
> >> +     * a vCPU, which gets set here, tested by H_CEDE, and cleared any=
 time
> >> +     * the vCPU is dispatched, including via preemption.
> >> +     *
> >> +     * We don't implement this because it is not used by Linux. The b=
it would
> >> +     * be difficult or impossible to use properly because preemption =
can not
> >> +     * be prevented so dispatch sequence count would have to somehow =
be used
> >> +     * to detect it.
> >=20
> > Hm.  AFAIK the dispatch sequence count only exists with KVM, so I
> > don't see how testing it would fit with a userspace implementation of P=
ROD.
>=20
> Right, I think even if you did have it, the prod bit really doesn't
> offer much value. You could perhaps enter CEDE without hard disabling
> interrupts race-free, something like --
>=20
>   do {
>     seq =3D dispatch_seq;
>     if (work_pending)
>       return;
>   } while (seq !=3D dispatch_seq);
>   hcall(H_CEDE);
>=20
>   vs
>=20
>   work_pending =3D 1;
>   hcall(H_PROD);
>=20
> But Linux certainly doesn't do anything like this, and after the
> barriers needed and added complexity to work out the idle state on
> the producer side, it's unlikely to be worthwhile (and either way
> dwarfed by the hcall cost).
>=20
> Buut... in theory it does not conform to PAPR exactly. We would need
> to clear it on all guest dispatch, and also implement the dispatch
> counter if we are worried about this.
>=20
> >=20
> >> +     */
> >> +
> >> +    cs =3D CPU(spapr_find_cpu(target));
> >> +    if (!cs) {
> >> +        return H_PARAMETER;
> >> +    }
> >> +
> >> +    cs->halted =3D 0;
> >> +    qemu_cpu_kick(cs);
> >> +
> >> +    return H_SUCCESS;
> >> +}
> >> +
> >>  static target_ulong h_rtas(PowerPCCPU *cpu, SpaprMachineState *spapr,
> >>                             target_ulong opcode, target_ulong *args)
> >>  {
> >> @@ -1860,6 +1928,9 @@ static void hypercall_register_types(void)
> >>      /* hcall-splpar */
> >>      spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
> >>      spapr_register_hypercall(H_CEDE, h_cede);
> >> +    spapr_register_hypercall(H_CONFER, h_confer);
> >> +    spapr_register_hypercall(H_PROD, h_prod);
> >> +
> >>      spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
> >=20
> > You're no longer enabling the KVM CONFER and PROD hypercalls.  Are
> > they enabled by default, or is that an intentional change?
>=20
> Oh, it was not intentional, I must not understand how this works. Why
> is this no longer enabling the those hcalls?

spapr_register_hypercall() puts a handler in the table that qemu uses
to dispatch hypercalls that cause a KVM exit.  So, it makes qemu able
to handle it.

But for things which we want to handle within KVM, without causing an
exit there's kvmppc_enable_hcall().  That tells KVM to handle the
hcall itself without exiting.  We don't do that by default (except for
some grandfathered cases) so that changing host kernel won't cause the
guest to see different behaviour, which qemu wants to control for
compatibilty and migration.

Ah.. which makes we realize, we probably need to only enable these
hcalls for newer machine types, too.  Although we'd probably get away
with it in this case.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XCAZszJJXrQJLz3d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAly3IAsACgkQbDjKyiDZ
s5JYoBAAljJx70FTdCLKKWudexh3hsuslK80UmuPJTp4XHSe9O0tmjzxpu+wwkL9
/mmDpY4JRddGEO31ltU7Jbgcqwt8IkveiUr2KWAVK2x4iADo6BQYAkc7wolb+Nu2
DA8/gqPfUsLJHVfomnTwSnWDizUxwvTBExF/00+4LmgaFud8H6SNCyERiBQIn/kb
IUmm831A1ewIVLuSczTVTTY8m7PXeh8mVE9XZDzRWg6bxx+p5Hj05JGlL+Aiu8Eh
PJKMpZRtrk9Jh4gbvgHwra9ShaEhuemM9WnGhY52DIMWJh2hgJoqrFEuPSikYj+g
RiRDTB4vqWotNERTQqVlokAzkEnf8bj1OUa9baGy5oQUYnPqx1ace/BiiE8N0QJC
Fpx+qfT4la2OWIt/hO80wiodvCR9En5j59WmR0tCP2a+iduxIDocpOFqY4wDst1R
DGzWBmp+m9JJjM7oFeDvbfR2qm8vF6aoibiMaPqjkHouXluVxTQ7MdfiOaBNkFby
8/ihSp0705PJxOeo2/4zLOQLsDiVUMSi+cRVSZFpttbCPgPoa3sccXEgVh5Lilus
vOLOyxmIgAGPYx8Bb9oux/gnV4nbBMVnt8E2ug5NO+ZZUydPRdARIH1nELVgAPhZ
mJRgr35ltFkW/4w/onrfO+uOupoPskOhwS5+iep5c0jmzEVG504=
=nBST
-----END PGP SIGNATURE-----

--XCAZszJJXrQJLz3d--
