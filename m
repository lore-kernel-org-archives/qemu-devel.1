Received: from eggs.gnu.org ([2001:4830:134:3::10]:43173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1diEXw-0002gZ-R3
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1diEXt-0002f9-O5
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:44:48 -0400
Date: Thu, 17 Aug 2017 16:44:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170817064402.GH5509@umbus.fritz.box>
References: <1502947002-19016-1-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rV8arf8D5Dod9UkK"
Content-Disposition: inline
In-Reply-To: <1502947002-19016-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [FIX PATCH v1] spapr: Allow configure-connector to
 be called multiple times
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


--rV8arf8D5Dod9UkK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2017 at 10:46:42AM +0530, Bharata B Rao wrote:
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
> all types of DR connectors.
>=20
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
> v0: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02942.html
> Changes in v1:
>  - Allow configure-connector to be called multiple times for all types
>    of DR connectors and not just LMB DRCs. (David Gibson)
>  - Explicitly allow configure-connector to proceed only if the DRC is
>    either in unisolated or in configured state. (David Gibson)
>=20
>  hw/ppc/spapr_drc.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)

I've applied with a small correction:

>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 5260b5d..40d1e99 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -446,8 +446,12 @@ void spapr_drc_reset(sPAPRDRConnector *drc)
>          drc->state =3D drck->empty_state;
>      }
> =20
> -    drc->ccs_offset =3D -1;
> -    drc->ccs_depth =3D -1;
> +    /*
> +     * Ensure that we are able to send the FDT fragment again
> +     * via configure-connector call if the guest requests.
> +     */
> +    drc->ccs_offset =3D drc->fdt_start_offset;
> +    drc->ccs_depth =3D 0;

This isn't quite right - we should only set these values ready when we
go into ready state (=3D=3DCONFIGURED =3D=3D device present) rather than em=
pty
state (=3D=3DUNALLOCATED =3D=3D no device present).

>  }
> =20
>  static void drc_reset(void *opaque)
> @@ -1071,8 +1075,14 @@ static void rtas_ibm_configure_connector(PowerPCCP=
U *cpu,
>      }
> =20
>      if ((drc->state !=3D SPAPR_DRC_STATE_LOGICAL_UNISOLATE)
> -        && (drc->state !=3D SPAPR_DRC_STATE_PHYSICAL_UNISOLATE)) {
> -        /* Need to unisolate the device before configuring */
> +        && (drc->state !=3D SPAPR_DRC_STATE_PHYSICAL_UNISOLATE)
> +        && (drc->state !=3D SPAPR_DRC_STATE_LOGICAL_CONFIGURED)
> +        && (drc->state !=3D SPAPR_DRC_STATE_PHYSICAL_CONFIGURED)) {
> +        /*
> +         * Need to unisolate the device before configuring
> +         * or it should already be in configured state to
> +         * allow configure-connector be called repeatedly.
> +         */
>          rc =3D SPAPR_DR_CC_RESPONSE_NOT_CONFIGURABLE;
>          goto out;
>      }
> @@ -1108,8 +1118,13 @@ static void rtas_ibm_configure_connector(PowerPCCP=
U *cpu,
>                  /* done sending the device tree, move to configured stat=
e */
>                  trace_spapr_drc_set_configured(drc_index);
>                  drc->state =3D drck->ready_state;
> -                drc->ccs_offset =3D -1;
> -                drc->ccs_depth =3D -1;
> +                /*
> +                 * Ensure that we are able to send the FDT fragment
> +                 * again via configure-connector call if the guest reque=
sts.
> +                 */
> +                drc->ccs_offset =3D drc->fdt_start_offset;
> +                drc->ccs_depth =3D 0;
> +                fdt_offset_next =3D drc->fdt_start_offset;
>                  resp =3D SPAPR_DR_CC_RESPONSE_SUCCESS;
>              } else {
>                  resp =3D SPAPR_DR_CC_RESPONSE_PREV_PARENT;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rV8arf8D5Dod9UkK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmVOy8ACgkQbDjKyiDZ
s5IGnQ/+LvvC5NMmS44uldIjZz2wB0CjH6m2bImB86v/7qPjkAbBCmH0VTKUgTIR
b9nbsikSeLaRhNsJCgzxtVFeVVJoEtibwqHyLeTh1aXg2lVCsd1Nx7Z3k8maMgEc
M+AVjum01zgBnzgKUj6wDDE/IB+M+KFbFFvopJooQYwewEKV+qWoyiTwS6uC/Twh
j5mx7TBpmDYVM9T4PbT3zYKopLBBb/xGUpFDwJJfqopg0KbJhTC5skYKQrB9B9mD
EOTLG4Udyoo352qHSfJyrL8+p4IxqfZYlMd7s+4BRRdN1XpDKJUOTOz0tzx3MrO4
S2jzBPE6yctSH1YY2Yvv1cA7n2XXfQLm4Jh52Ez/dJ+GcuDwV6GdprPR56s+ktsY
EkqXn+FmI+Ak4ebd+uaJYFoKMcxcRxpUTdqzIJH5NaZ6emVHWtragA7qYBwgyqJA
5NJ2yNH+6rNeCZqimtzPgfjrkp8/MmgYKKBvBxWSZgg7KXBdXbBfja5vC8N5i7wG
c7XOSL3zTRl0PkXZiOohl2eL4lRG2CJGOxZK/oi5XunxcEh0k4PGFQ1R3a3oB6gf
aJaoHamms1Xef13QyP5R4MQ1hfHGV+Q5Bk2hILts0iha36JlV6Xvt4Lm1YXh4/om
+fcz1SwpydgbR+U9mvy9V2+z76kxBUk+O4yxBV+uACImpZcDxFg=
=stND
-----END PGP SIGNATURE-----

--rV8arf8D5Dod9UkK--
