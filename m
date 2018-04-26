Received: from eggs.gnu.org ([2001:4830:134:3::10]:42220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBb48-0007k6-Ro
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 03:11:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBb44-0001NM-Hg
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 03:11:40 -0400
Date: Thu, 26 Apr 2018 16:46:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180426064600.GI8800@umbus.fritz.box>
References: <20180417071722.9399-1-david@gibson.dropbear.id.au>
	<20180417071722.9399-4-david@gibson.dropbear.id.au>
	<a01bebe8-85b7-f2b4-3675-401367471204@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xGGVyNQdqA79rdfn"
Content-Disposition: inline
In-Reply-To: <a01bebe8-85b7-f2b4-3675-401367471204@kaod.org>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for-2.13 03/10] target/ppc:
 Remove unnecessary initialization of LPCR_UPRT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--xGGVyNQdqA79rdfn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 11:52:18AM +0200, C=E9dric Le Goater wrote:
> On 04/17/2018 09:17 AM, David Gibson wrote:
> > In cpu_ppc_set_papr() the UPRT and GTSE bits of the LPCR are initialized
> > based on on ppc64_radix_guest().  Which seems reasonable, except that
> > ppc64_radix_guest() is based on spapr->patb_entry which is only set up
> > in spapr_machine_reset, called much later than cpu_ppc_set_papr().
> >=20
> > So the initialization here is pointless.  The base cpu initialization
> > already sets a value that's good enough until the guest uses an hcall to
> > configure it's preferred MMU mode.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  target/ppc/translate_init.c | 16 ----------------
> >  1 file changed, 16 deletions(-)
> >=20
> > diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> > index bb79d23b50..14f346f441 100644
> > --- a/target/ppc/translate_init.c
> > +++ b/target/ppc/translate_init.c
> > @@ -8897,22 +8897,6 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtua=
lHypervisor *vhyp)
> >      lpcr->default_value &=3D ~LPCR_RMLS;
> >      lpcr->default_value |=3D 1ull << LPCR_RMLS_SHIFT;
> > =20
> > -    if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
> > -        /* By default we choose legacy mode and switch to new hash or =
radix
> > -         * when a register process table hcall is made. So disable pro=
cess
> > -         * tables and guest translation shootdown by default
> > -         *
> > -         * Hot-plugged CPUs inherit from the guest radix setting under
> > -         * KVM but not under TCG. Update the default LPCR to keep new
> > -         * CPUs in sync when radix is enabled.
> > -         */
>=20
>=20
> This is breaking CPU hotplug under TCG. Should we reintroduce the same=20
> settings in spapr_cpu_reset() now ?

Sod.  Yeah, this code is important for the hotplug case.

But, no, I don't think it should go into reset, I think it should go
into the rtas start-cpu path; it only makes sense for secondary CPUs.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xGGVyNQdqA79rdfn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrhdaUACgkQbDjKyiDZ
s5J76A//arpCxyK/tLEGMkD2J/5cAMTkEfJcSkWFNtbkh/tTkOWf1FGksPuRvjyc
WuCVgeuZOGeJmVN2G9PS9rOv1xltQZmE1hRDobIrvE+3lUJyebdZjxJOBhegAnK2
N9ZC+xhya4p9XqraleiGPcHRefOVxRFObZqJua66d2sWzYZizLPcD1SRfy8ZNYhy
do3Am5VPKITGYsAofjdhArTg2bPDunVmrrGt5WrL8bTB4+DsiO11PjsyS2Y7ypyL
hrLyQYb29jKp0Qvw3SqVRk6zASEPoVR2zS0zIq5HHysfsdwNq5oFy2UEZVmLnTpF
wGOHO3/tddqRj4k0ouB3IJPVLhNXEmgcVu3K4ILGt0Iu17Szr2hUoBL1iFoPIU9I
xOd6ozK4yF/H7GBCKekOwRHLACNoPadxMpLBiym3GrppQF1ml+2aqmOo9eTEiQdD
xqEgVaQhF3Q/cAWnc6a3UOIVBrs2TQKknQS6EREeYmBYe6gdx86rVJ/aaKiNYOV+
1orVgsXE8OO9hRB+ybzcYp0ZE0h3czA0Nff/MY6rKpZ6VAvm3ppkrQod2XdDlQ+g
ghOqhs/N5KcSZYmNWsmOXTl3ugB26Mx6aiWrKrSbWHF6UkuMrvHNDjYNHXw0Pt/4
V2M4Tn5XsK/LyFLrnQLmTMS9MbiuzfWcQoWJ/S8NaMdOnjrlLPo=
=KBmP
-----END PGP SIGNATURE-----

--xGGVyNQdqA79rdfn--
