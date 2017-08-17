Received: from eggs.gnu.org ([2001:4830:134:3::10]:58781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1di9ht-0004Qk-NG
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 21:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1di9hs-0001QQ-H5
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 21:34:45 -0400
Date: Thu, 17 Aug 2017 11:29:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170817012919.GA5509@umbus.fritz.box>
References: <1502883336-14608-1-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <1502883336-14608-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [FIX PATCH v0] spapr: Allow configure-connector to
 be called multiple times for LMBs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, nfont@linux.vnet.ibm.com


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2017 at 05:05:36PM +0530, Bharata B Rao wrote:
> In case of in-kernel memory hot unplug, when the guest is not able
> to remove all the LMBs that are requested for removal, it will add back
> any LMBs that have been successfully removed. The DR Connectors of
> these LMBs wouldn't have been unconfigured and hence the addition of
> these LMBs will result in configure-connector call being issued on
> LMB DR connectors that are already in configured state. Such
> configure-connector calls will fail resulting in a DIMM which is
> partially unplugged.
>=20
> This however worked till recently before we overhauled the DRC
> implementation in QEMU. Commit 9d4c0f4f0a71e: "spapr: Consolidate
> DRC state variables" is the first commit where this problem shows up
> as per git bisect.
>=20
> Ideally guest shouldn't be issuing configure-connector call on an
> already configured DR connector. However for now, work around this in
> QEMU by allowing configure-connector to be called multiple times for
> LMBs.
>=20
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr_drc.c | 37 +++++++++++++++++++++++++++++++------
>  1 file changed, 31 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 5260b5d..2dd9635 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -446,8 +446,17 @@ void spapr_drc_reset(sPAPRDRConnector *drc)
>          drc->state =3D drck->empty_state;
>      }
> =20
> -    drc->ccs_offset =3D -1;
> -    drc->ccs_depth =3D -1;
> +    if (spapr_drc_type(drc) =3D=3D SPAPR_DR_CONNECTOR_TYPE_LMB) {

We shouldn't have a type dependency here.  If we want the configure
connector process to be repeatable, it should be repeatable for
everything, even if we only actually need it for LMBs.

> +        /*
> +         * Ensure that we are able to send the FDT fragment of the
> +         * LMB again via configure-connector call if guest requests.
> +         */
> +        drc->ccs_offset =3D drc->fdt_start_offset;
> +        drc->ccs_depth =3D 0;
> +    } else {
> +        drc->ccs_offset =3D -1;
> +        drc->ccs_depth =3D -1;
> +    }
>  }
> =20
>  static void drc_reset(void *opaque)
> @@ -1071,8 +1080,14 @@ static void rtas_ibm_configure_connector(PowerPCCP=
U *cpu,
>      }
> =20
>      if ((drc->state !=3D SPAPR_DRC_STATE_LOGICAL_UNISOLATE)
> -        && (drc->state !=3D SPAPR_DRC_STATE_PHYSICAL_UNISOLATE)) {
> -        /* Need to unisolate the device before configuring */
> +        && (drc->state !=3D SPAPR_DRC_STATE_PHYSICAL_UNISOLATE) &&
> +        (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_LMB)) {
> +        /*
> +         * Need to unisolate the device before configuring, however
> +         * LMB DRCs are exempted from this check as guest can issue
> +         * configure-connector calls for an already configured
> +         * LMB DRC.
> +         */

Same here - but we do need to explicitly check that the state is
either UNISOLATE *or* CONFIGURED, and not allow it from some other
random state.

>          rc =3D SPAPR_DR_CC_RESPONSE_NOT_CONFIGURABLE;
>          goto out;
>      }
> @@ -1108,8 +1123,18 @@ static void rtas_ibm_configure_connector(PowerPCCP=
U *cpu,
>                  /* done sending the device tree, move to configured stat=
e */
>                  trace_spapr_drc_set_configured(drc_index);
>                  drc->state =3D drck->ready_state;
> -                drc->ccs_offset =3D -1;
> -                drc->ccs_depth =3D -1;
> +                if (spapr_drc_type(drc) =3D=3D SPAPR_DR_CONNECTOR_TYPE_L=
MB) {

And again.

> +                    /*
> +                     * Ensure that we are able to send the FDT fragment =
of the
> +                     * LMB again via configure-connector call if guest r=
equests.
> +                     */
> +                    drc->ccs_offset =3D drc->fdt_start_offset;
> +                    drc->ccs_depth =3D 0;
> +                    fdt_offset_next =3D drc->fdt_start_offset;
> +                } else {
> +                    drc->ccs_offset =3D -1;
> +                    drc->ccs_depth =3D -1;
> +                }
>                  resp =3D SPAPR_DR_CC_RESPONSE_SUCCESS;
>              } else {
>                  resp =3D SPAPR_DR_CC_RESPONSE_PREV_PARENT;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmU8W0ACgkQbDjKyiDZ
s5LlFBAAgnE6FmskfMp9dtxsu9yKQITgP84HtUziIQcmIVhioN1UAGysmpdjKCHx
W//EmMh818fkIr4+KEr8TdFmRoMas0MARGLVG3qj2gnuwMaLLabY5owkqCHMZlIB
65QG3QfaM2CRdS9WwODK87DZDVQH4wq5oMrHD01w92/4EwIMFwkPytDodaigvLhA
Z4Aw3vcdoBLEuwmkfC1J22SwfCNYIhJgDcvnYMqIAOpjM0n0580a3l9+izM9kr0c
NVllKQZKYouh8Ru9OUNAiowTnqyB+9tupTjRABJTQePKT2OvjY7Wc6XgKhUiDBP8
UXAw01TzB649J6zbutV/iBXu84zelRcs0p/Bl3LArQuz0rN+lwM5XE2DC8pDQbck
L1bqjExzTV6giAzDAWJa+HHA9vvkG1jwRm7552izcqgMjL1xvz89pT3F+eSt4fvv
a6bglbDJ1KN9T+w6NNAf/12NnQGdUCxzXFzeh7Z1Lbzwi7cHnX4rfnA9rkKACVqd
maldIXxovv3q7mom6Wbzn7nD6CYDVVZ/LETktV6IpgblpuLs/0DjUlVIZpcW063U
LIorIDRe9x4FyxrOjnU0dddc/FUSAR23rqTyDTB30R2Ke+M5p9QjnYsVFQOWvcOr
wZmpaLemESXV3pdXmSTBISf8LZzPb+76LGbQ39W658cxacgLqj0=
=nTCW
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
