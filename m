Received: from eggs.gnu.org ([2001:4830:134:3::10]:36254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecP1E-0003Mp-Gb
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 00:15:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecP1D-0003CI-24
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 00:15:12 -0500
Date: Fri, 19 Jan 2018 16:09:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180119050900.GH30352@umbus.fritz.box>
References: <20180119050005.29392-1-sjitindarsingh@gmail.com>
	<20180119050005.29392-3-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W0QGcccuECrPGiFB"
Content-Disposition: inline
In-Reply-To: <20180119050005.29392-3-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V5 2/7] target/ppc/spapr_caps:
 Add macro to generate spapr_caps migration vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, paulus@ozlabs.org


--W0QGcccuECrPGiFB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2018 at 04:00:00PM +1100, Suraj Jitindar Singh wrote:
> The vmstate description and the contained needed function for migration
> of spapr_caps is the same for each cap, with the name of the cap
> substituted. As such introduce a macro to allow for easier generation of
> these.
>=20
> Convert the three existing spapr_caps (htm, vsx, and dfp) to use this
> macro.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Applied to ppc-for-2.12, thanks.

>=20
> ---
>=20
> V5:
>  - Patch added to series
> ---
>  hw/ppc/spapr_caps.c | 78 +++++++++++++++++------------------------------=
------
>  1 file changed, 24 insertions(+), 54 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index d5c9ce774a..5d52969bd5 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -228,62 +228,32 @@ int spapr_caps_post_migration(sPAPRMachineState *sp=
apr)
>      return ok ? 0 : -EINVAL;
>  }
> =20
> -static bool spapr_cap_htm_needed(void *opaque)
> -{
> -    sPAPRMachineState *spapr =3D opaque;
> -
> -    return spapr->cmd_line_caps[SPAPR_CAP_HTM] &&
> -           (spapr->eff.caps[SPAPR_CAP_HTM] !=3D spapr->def.caps[SPAPR_CA=
P_HTM]);
> -}
> -
> -const VMStateDescription vmstate_spapr_cap_htm =3D {
> -    .name =3D "spapr/cap/htm",
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> -    .needed =3D spapr_cap_htm_needed,
> -    .fields =3D (VMStateField[]) {
> -        VMSTATE_UINT8(mig.caps[SPAPR_CAP_HTM], sPAPRMachineState),
> -        VMSTATE_END_OF_LIST()
> -    },
> -};
> -
> -static bool spapr_cap_vsx_needed(void *opaque)
> -{
> -    sPAPRMachineState *spapr =3D opaque;
> -
> -    return spapr->cmd_line_caps[SPAPR_CAP_VSX] &&
> -           (spapr->eff.caps[SPAPR_CAP_VSX] !=3D spapr->def.caps[SPAPR_CA=
P_VSX]);
> +/* Used to generate the migration field and needed function for a spapr =
cap */
> +#define SPAPR_CAP_MIG_STATE(cap, ccap)                  \
> +static bool spapr_cap_##cap##_needed(void *opaque)      \
> +{                                                       \
> +    sPAPRMachineState *spapr =3D opaque;                  \
> +                                                        \
> +    return spapr->cmd_line_caps[SPAPR_CAP_##ccap] &&    \
> +           (spapr->eff.caps[SPAPR_CAP_##ccap] !=3D        \
> +            spapr->def.caps[SPAPR_CAP_##ccap]);         \
> +}                                                       \
> +                                                        \
> +const VMStateDescription vmstate_spapr_cap_##cap =3D {    \
> +    .name =3D "spapr/cap/" #cap,                          \
> +    .version_id =3D 1,                                    \
> +    .minimum_version_id =3D 1,                            \
> +    .needed =3D spapr_cap_##cap##_needed,                 \
> +    .fields =3D (VMStateField[]) {                        \
> +        VMSTATE_UINT8(mig.caps[SPAPR_CAP_##ccap],       \
> +                      sPAPRMachineState),               \
> +        VMSTATE_END_OF_LIST()                           \
> +    },                                                  \
>  }
> =20
> -const VMStateDescription vmstate_spapr_cap_vsx =3D {
> -    .name =3D "spapr/cap/vsx",
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> -    .needed =3D spapr_cap_vsx_needed,
> -    .fields =3D (VMStateField[]) {
> -        VMSTATE_UINT8(mig.caps[SPAPR_CAP_VSX], sPAPRMachineState),
> -        VMSTATE_END_OF_LIST()
> -    },
> -};
> -
> -static bool spapr_cap_dfp_needed(void *opaque)
> -{
> -    sPAPRMachineState *spapr =3D opaque;
> -
> -    return spapr->cmd_line_caps[SPAPR_CAP_DFP] &&
> -           (spapr->eff.caps[SPAPR_CAP_DFP] !=3D spapr->def.caps[SPAPR_CA=
P_DFP]);
> -}
> -
> -const VMStateDescription vmstate_spapr_cap_dfp =3D {
> -    .name =3D "spapr/cap/dfp",
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> -    .needed =3D spapr_cap_dfp_needed,
> -    .fields =3D (VMStateField[]) {
> -        VMSTATE_UINT8(mig.caps[SPAPR_CAP_DFP], sPAPRMachineState),
> -        VMSTATE_END_OF_LIST()
> -    },
> -};
> +SPAPR_CAP_MIG_STATE(htm, HTM);
> +SPAPR_CAP_MIG_STATE(vsx, VSX);
> +SPAPR_CAP_MIG_STATE(dfp, DFP);
> =20
>  void spapr_caps_reset(sPAPRMachineState *spapr)
>  {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--W0QGcccuECrPGiFB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlphfWkACgkQbDjKyiDZ
s5JZIRAAvm/rCYm+M6r2/zT6fAmRk8B3gvte5ekvFSUZm3zHWt3Ot663AlBRJxPZ
Rd5gSJIeXwuk9xut3FqyCwDK0c13MDgTLFWRPsvKnsbxe2+2IVVWTmZtOF1AMmdQ
mufXWIlYO/37NzumUiJCAm0rQSap9IUo+U+xRiU72S0qx2IcZxkxaCwvKXv4sh9h
V/7pacFVlGfHlu9Mrx5XmKdsA/9kAPyZ42voACGj4NpQ4D2mWU8LckVV4hx6wM1A
azTBa7TrI/MzBr+eR/J0giXpFZD2nh1QXfa0mXuqH/UejLwwKJdwWaR/oaASitvF
Hxn49aDwnPr9KXxOrK/XmeYSuCcR3d7nsgeDDWw0r/heA+HUWVMRxov7gB3D9u7C
rDZXZIutm/UcB8aXtQZpDn3YnzxheZaN7sFVqXS3fbkbdo8GD7mh9/arSuxIYE1d
MoMKWev3+pQ4IVKkUBXwOQuluxK/lGLLDxwb+t4TJ+vbYFpvYWjg/GIpZMYnub3H
qyv5k7wD7XTPKOOw8WLNWvzGCiqkpKkjGdZ6p7dncPInfuJAfyLoPBu6iHzItH87
gGx7v6M/WhEXCtN+oKsc+uxU/frJj04zjZyFMzTng1DhiQ+8Kk6HaEW9nAT+XFIi
dB4rKZyfNchBfnHtzqntnIehE9i6dN34ZV/G28znOfRwUXQhaaw=
=Pxez
-----END PGP SIGNATURE-----

--W0QGcccuECrPGiFB--
