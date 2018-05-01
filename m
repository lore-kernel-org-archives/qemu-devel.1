Received: from eggs.gnu.org ([2001:4830:134:3::10]:45828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fDTZP-00081E-GU
	for qemu-devel@nongnu.org; Tue, 01 May 2018 07:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fDTZL-0004bq-HM
	for qemu-devel@nongnu.org; Tue, 01 May 2018 07:35:43 -0400
Date: Tue, 1 May 2018 16:39:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180501063939.GB2520@umbus.fritz.box>
References: <20180417071722.9399-1-david@gibson.dropbear.id.au>
	<20180417071722.9399-4-david@gibson.dropbear.id.au>
	<a01bebe8-85b7-f2b4-3675-401367471204@kaod.org>
	<20180426064600.GI8800@umbus.fritz.box>
	<5f09ca4d-3c01-7e89-fa87-6340060cf579@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <5f09ca4d-3c01-7e89-fa87-6340060cf579@kaod.org>
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


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 09:20:11AM +0200, C=E9dric Le Goater wrote:
> On 04/26/2018 08:46 AM, David Gibson wrote:
> > On Wed, Apr 25, 2018 at 11:52:18AM +0200, C=E9dric Le Goater wrote:
> >> On 04/17/2018 09:17 AM, David Gibson wrote:
> >>> In cpu_ppc_set_papr() the UPRT and GTSE bits of the LPCR are initiali=
zed
> >>> based on on ppc64_radix_guest().  Which seems reasonable, except that
> >>> ppc64_radix_guest() is based on spapr->patb_entry which is only set up
> >>> in spapr_machine_reset, called much later than cpu_ppc_set_papr().
> >>>
> >>> So the initialization here is pointless.  The base cpu initialization
> >>> already sets a value that's good enough until the guest uses an hcall=
 to
> >>> configure it's preferred MMU mode.
> >>>
> >>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >>> ---
> >>>  target/ppc/translate_init.c | 16 ----------------
> >>>  1 file changed, 16 deletions(-)
> >>>
> >>> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> >>> index bb79d23b50..14f346f441 100644
> >>> --- a/target/ppc/translate_init.c
> >>> +++ b/target/ppc/translate_init.c
> >>> @@ -8897,22 +8897,6 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirt=
ualHypervisor *vhyp)
> >>>      lpcr->default_value &=3D ~LPCR_RMLS;
> >>>      lpcr->default_value |=3D 1ull << LPCR_RMLS_SHIFT;
> >>> =20
> >>> -    if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
> >>> -        /* By default we choose legacy mode and switch to new hash o=
r radix
> >>> -         * when a register process table hcall is made. So disable p=
rocess
> >>> -         * tables and guest translation shootdown by default
> >>> -         *
> >>> -         * Hot-plugged CPUs inherit from the guest radix setting und=
er
> >>> -         * KVM but not under TCG. Update the default LPCR to keep new
> >>> -         * CPUs in sync when radix is enabled.
> >>> -         */
> >>
> >>
> >> This is breaking CPU hotplug under TCG. Should we reintroduce the same=
=20
> >> settings in spapr_cpu_reset() now ?
> >=20
> > Sod.  Yeah, this code is important for the hotplug case.
> >=20
> > But, no, I don't think it should go into reset, I think it should go
> > into the rtas start-cpu path; it only makes sense for secondary CPUs.
>=20
> yes. I will send a fix.

Not sure if this is still on your radar, but if it is, don't bother.
I've already made a fix (along with various others) and will be
posting soonish.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlroC6gACgkQbDjKyiDZ
s5Li+BAAs4zQ8PEINj/JnS0duH/zz/tW3ftP7mbsZ2gNUeri/pz/p3dla9USB3Oo
81r5hu9p+69+HxatcpkjYXSH/8ftoGB1XnQkltz2IImZM2i+2u/UnjcNkIeqSM5u
bSJ+Pu2Puv6FeOt9BRITqhvpFWo0C/DKdnrAMghoaImVCJwJcAnv0XohciU1dcYO
z9kSbY60aEzI9rrwzGFTOe/gY7WWeie5nNMsaHF6nGAOmAzGUeKAZLIXhU0fJHiH
pVa27a1uymxXNqVu8Xfrg5oiMU1546fHglqYVyTGnUC74itwMASmqK3vRTan4FdM
xmnyrhn5plk11lJ9s2pVRpdG2/SkTRDTB+91hDGPMq3DY6IRPM6EYQoPqg1a/Uge
mA0R6/uiwywH6D3YhMZp5CoWF5vXf2O5yLYFmhPSafnT5JIpvWmqEtS8l73fPNf6
vHInrygLukaKW1SyB8iqrYoIEjde+oP/yLcbEg3zl5hxVjb2dcyPNrWA3K+cL6l6
q1/QolDTiXCsAmlQL4FvIX7//KP34nVJK+NBOJjL3bUNsuiHPsOi5Z10/SY6f0cJ
Jf3dAElWjrJWS0HcQ3SfRrB48BA27N4ik68luMM0aoKWSDJPTEkVkUbyQcW9x0Sx
gpwBsW40jX9hq84+uKceu7btk+67f+jO92q6p6JWt6uMhlYk2lY=
=JtBT
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
