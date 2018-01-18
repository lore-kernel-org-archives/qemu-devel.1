Received: from eggs.gnu.org ([2001:4830:134:3::10]:36056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ec404-0004ts-0s
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 01:48:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ec3zz-0008IG-Qj
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 01:48:36 -0500
Date: Thu, 18 Jan 2018 16:53:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180118055348.GU30352@umbus.fritz.box>
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
	<20180115063235.7518-7-sjitindarsingh@gmail.com>
	<20180118052029.GR30352@umbus.fritz.box>
	<0cdab21f-0f70-f705-9ae3-e95eea69f65e@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Zltv+KEU+AMUCOPj"
Content-Disposition: inline
In-Reply-To: <0cdab21f-0f70-f705-9ae3-e95eea69f65e@ozlabs.ru>
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [PATCH V3 6/6]
 target/ppc/spapr: Add H-Call H_GET_CPU_CHARACTERISTICS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, paulus@ozlabs.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--Zltv+KEU+AMUCOPj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 04:44:28PM +1100, Alexey Kardashevskiy wrote:
> On 18/01/18 16:20, David Gibson wrote:
> > On Mon, Jan 15, 2018 at 05:32:35PM +1100, Suraj Jitindar Singh wrote:
> >> The new H-Call H_GET_CPU_CHARACTERISTICS is used by the guest to query
> >> behaviours and available characteristics of the cpu.
> >>
> >> Implement the handler for this new H-Call which formulates its response
> >> based on the setting of the spapr_caps cap-cfpc, cap-sbbc and cap-ibs.
> >>
> >> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> >> ---
> >>  hw/ppc/spapr_hcall.c   | 66 +++++++++++++++++++++++++++++++++++++++++=
+++++++++
> >>  include/hw/ppc/spapr.h |  1 +
> >>  2 files changed, 67 insertions(+)
> >>
> >> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> >> index 51eba52e86..a693d3b852 100644
> >> --- a/hw/ppc/spapr_hcall.c
> >> +++ b/hw/ppc/spapr_hcall.c
> >> @@ -1654,6 +1654,69 @@ static target_ulong h_client_architecture_suppo=
rt(PowerPCCPU *cpu,
> >>      return H_SUCCESS;
> >>  }
> >> =20
> >> +static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
> >> +                                              sPAPRMachineState *spap=
r,
> >> +                                              target_ulong opcode,
> >> +                                              target_ulong *args)
> >> +{
> >> +    uint64_t characteristics =3D H_CPU_CHAR_HON_BRANCH_HINTS &
> >> +			       ~H_CPU_CHAR_THR_RECONF_TRIG;
> >> +    uint64_t behaviour =3D H_CPU_BEHAV_FAVOUR_SECURITY;
> >> +    uint8_t safe_cache =3D spapr_get_cap(spapr, SPAPR_CAP_CFPC);
> >> +    uint8_t safe_bounds_check =3D spapr_get_cap(spapr, SPAPR_CAP_SBBC=
);
> >> +    uint8_t safe_indirect_branch =3D spapr_get_cap(spapr, SPAPR_CAP_I=
BS);
> >> +
> >> +    switch (safe_cache) {
> >> +    case SPAPR_CAP_WORKAROUND:
> >> +        characteristics |=3D H_CPU_CHAR_L1D_FLUSH_ORI30;
> >> +        characteristics |=3D H_CPU_CHAR_L1D_FLUSH_TRIG2;
> >> +        characteristics |=3D H_CPU_CHAR_L1D_THREAD_PRIV;
> >> +        behaviour |=3D H_CPU_BEHAV_L1D_FLUSH_PR;
> >> +        break;
> >> +    case SPAPR_CAP_FIXED:
> >> +        break;
> >> +    default: /* broken */
> >> +        if (safe_cache !=3D SPAPR_CAP_BROKEN) {
> >=20
> > I think you just assert() for this.  The only way these could get a
> > different value is if there's a bug elsewhere.
>=20
>=20
> Why not return H_HARDWARE or other error?

Because what's the guest supposed to do with it.  This is an internal
qemu problem, so it should be dealt with via an internal qemu
mechanism.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Zltv+KEU+AMUCOPj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpgNmwACgkQbDjKyiDZ
s5JO5hAA2E3Djr8Tkg9woYLMqR+HAq7xzZGsCwbBCkzcOVHOfSEPQl3apBj0rkwt
KpDx0OAnqpibKcT9DjuuDShTeuo7ebIsbDRR3MhGBREz/EiCoPmAzbSh5jq9X7u+
waU1R+hGfRSCxBqmjxLjTFVmw924+4XFhaoZlKby+VESzwoVqumxouTC0h1J2DEQ
ckwrImM2bZWFsiRYsf84cdv3xVte8Bz+vMhvnC8wlfALMd4sdeB2ZoEKByn8zKM6
3GeHav4QwTWebA02tDzbgQ4sD6/ykVnt6EmM91ibZ7sKM6r39QLoQs7Htzyk/3rw
JD3itMjewAG1AH6393XuWjOs1sXfhiwaTxizU4RCBFchimgyqpisKNubgUpAKZUT
nh1BLJpT+4gR4mwv4QvSe1w/Pm6OL2uzMq17SX9fvJ2R4C2OVksgDBgwLsPGJ+M9
hO10etZOfuCmmXM6KJxwUw3ERplTnziGUx66vyzyM5G9COAe3RfTI3dJQFg27ecx
F0B1g2iIc8L28/X1GPG2DuLHVknmfdF7xaXdAvcOUJE0Q9lMBiTYBm7vibrxlWYh
mz1jNOc6Ps82O2ODUm9m0FQ6kOUYXvxnlvoI1RaxmKaQMoz3kaPyZ15ys2IVMdeM
j5qyDWrD7yNcpqwlbO+Z+SiqQPXJEB3cqNVMWjomLiOXPoIaSQo=
=FH5P
-----END PGP SIGNATURE-----

--Zltv+KEU+AMUCOPj--
