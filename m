Received: from eggs.gnu.org ([2001:4830:134:3::10]:51944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emXTk-0006VV-Kb
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 23:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emXTj-0002aW-6R
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 23:18:32 -0500
Date: Fri, 16 Feb 2018 15:18:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180216041819.GG2074@umbus.fritz.box>
References: <20180216023328.8407-1-sjitindarsingh@gmail.com>
	<20180216023328.8407-2-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SdvjNjn6lL3tIsv0"
Content-Disposition: inline
In-Reply-To: <20180216023328.8407-2-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V4 2/2] ppc/spapr-caps: For
 pseries-2.12 change spapr-cap defaults
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2018 at 01:33:28PM +1100, Suraj Jitindar Singh wrote:
> For the pseries-2.12 machine type, make the spapr-caps SPAPR_CAP_CFPC
> and SPAPR_CAP_SBBC default to workaround. Thus if the host is capable
> the guest will be able to take advantage of these workarounds by default.
> Otherwise if the host doesn't have these capabilities qemu will fail to
> start and they will have to be explicitly disabled on the command line
> with:
> -machine pseries,cap-cfpc=3Dbroken,cap-sbbc=3Dbroken
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

I've decided to hold off on this for a little bit longer for two
reasons: 1) I realised how badly it will break things for machines
which don't yet updated firmware (both POWER8 and POWER9) which
includes a very large proportion of test machines.  2) I've looked
more closely at what x86 has done.  For themthe mitigations are
controlled by CPU options, not machine level, but the "plain" types
are still the unmitigated variants, with variants for the versions
with microcode updated with mitigations.  See
https://www.qemu.org/2018/02/14/qemu-2-11-1-and-spectre-update/

>=20
> ---
>=20
> V2 -> V3:
>  - Set caps to workaround in the class default rather than the
>    pseries-2.12 initialiser.
> ---
>  hw/ppc/spapr.c      |  6 ++++--
>  hw/ppc/spapr_caps.c | 10 ++++++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 83c9d66dd5..69f59aabf1 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3915,8 +3915,8 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->default_caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_VSX] =3D SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_DFP] =3D SPAPR_CAP_ON;
> -    smc->default_caps.caps[SPAPR_CAP_CFPC] =3D SPAPR_CAP_BROKEN;
> -    smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_BROKEN;
> +    smc->default_caps.caps[SPAPR_CAP_CFPC] =3D SPAPR_CAP_WORKAROUND;
> +    smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_WORKAROUND;
>      smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
>      spapr_caps_add_properties(smc, &error_abort);
>  }
> @@ -4000,6 +4000,8 @@ static void spapr_machine_2_11_class_options(Machin=
eClass *mc)
> =20
>      spapr_machine_2_12_class_options(mc);
>      smc->default_caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_ON;
> +    smc->default_caps.caps[SPAPR_CAP_CFPC] =3D SPAPR_CAP_BROKEN;
> +    smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_BROKEN;
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_11);
>  }
> =20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 99a4b71d19..7b0ecb3eca 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -283,11 +283,21 @@ static sPAPRCapabilities default_caps_with_cpu(sPAP=
RMachineState *spapr,
> =20
>      caps =3D smc->default_caps;
> =20
> +    if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00,
> +                          0, spapr->max_compat_pvr)) {
> +        caps.caps[SPAPR_CAP_CFPC] =3D SPAPR_CAP_BROKEN;
> +    }
> +
>      if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_07,
>                            0, spapr->max_compat_pvr)) {
>          caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
>      }
> =20
> +    if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_06_PLUS,
> +                          0, spapr->max_compat_pvr)) {
> +        caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_BROKEN;
> +    }
> +
>      if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_06,
>                            0, spapr->max_compat_pvr)) {
>          caps.caps[SPAPR_CAP_VSX] =3D SPAPR_CAP_OFF;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SdvjNjn6lL3tIsv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqGW4sACgkQbDjKyiDZ
s5J2yBAAwtWG/DbM8qWTGpGqiKmgLCkxT65UetjbEL0mgeFPgmTdMLoCVY760WKE
rLRGR7U/jzyIktIpPPI0umBts7ixvF8QkvAsqJ+ENpGLPTt0dU8cwgkAke86+EJX
p7LpdAyHkHDUL5EQQZ5VywS7pQX7yOobbcaGdjOyskFcHY39VHh31WGoU/8tCQ1F
nlkRcboXIOoPhPlJqwuUtK4rZpUSjUmHmYCm4dM7HDTBsdxIEpG49hywix7+sIPP
z72AnzMxtv+iLhw3d3LYPKhtrUOh01dQGHiYKehk7/jPv7NGEkwrbE3/Tkb7I+lH
IM/GNn0YrOu8RExldN6uZTG7lTMck1Zy5MHdZWE/3J76lKj2ueQvQjg5sfbK2Zrh
d/CYc6MccZawzzDUrcM89Wfp2Yenody+GA9D/cPRcgIbpHrc0clDmL6Cxaowpd1P
WWNZzAK63QLoG03QgslIrd1P4lSbm9qX0gy2eOQm20Xvo9Zhp2YYclLcA6SN5JhE
qvXFafUGZsZvTzHYCHeNxHkDWY+YGRajFrBTg8oSSX53PI3z4ATkOaoke34lpzdw
wx5ciA9Qc2eWENIUWBVOPVMsqPgNr/juzE50UFzX3RFg5nZtMNEXAXLM+Q8wHcSC
CjXe/hI+bqy4hqH1YE2AhZUdW4R9sFCu2v4ubEO320kNeNbO2uI=
=kEv5
-----END PGP SIGNATURE-----

--SdvjNjn6lL3tIsv0--
