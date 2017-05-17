Received: from eggs.gnu.org ([2001:4830:134:3::10]:35684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAsxD-0002jN-7V
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAsxB-00048r-Ty
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:01:03 -0400
Date: Wed, 17 May 2017 16:55:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170517065543.GL15596@umbus.fritz.box>
References: <1494992962-6929-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1494992962-6929-5-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y+Z5jE7Arku/2GrR"
Content-Disposition: inline
In-Reply-To: <1494992962-6929-5-git-send-email-bharata@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v1 4/6] spapr: Consolidate HPT freeing
 code into a routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com


--Y+Z5jE7Arku/2GrR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2017 at 09:19:20AM +0530, Bharata B Rao wrote:
> Consolidate the code that frees HPT into a separate routine
> spapr_free_hpt() as the same chunk of code is called from two places.
>=20
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>

Applied to ppc-for-2.10.  This is a good clean up in its own right.
Plus it will be useful to me to get my HPT resizing patches integrated
with radix support.

> ---
>  hw/ppc/spapr.c         | 13 +++++++++----
>  hw/ppc/spapr_hcall.c   |  5 +----
>  include/hw/ppc/spapr.h |  1 +
>  3 files changed, 11 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 1b7cada..521eef1 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1222,16 +1222,21 @@ static int spapr_hpt_shift_for_ramsize(uint64_t r=
amsize)
>      return shift;
>  }
> =20
> +void spapr_free_hpt(sPAPRMachineState *spapr)
> +{
> +    g_free(spapr->htab);
> +    spapr->htab =3D NULL;
> +    spapr->htab_shift =3D 0;
> +    close_htab_fd(spapr);
> +}
> +
>  static void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
>                                   Error **errp)
>  {
>      long rc;
> =20
>      /* Clean up any HPT info from a previous boot */
> -    g_free(spapr->htab);
> -    spapr->htab =3D NULL;
> -    spapr->htab_shift =3D 0;
> -    close_htab_fd(spapr);
> +    spapr_free_hpt(spapr);
> =20
>      rc =3D kvmppc_reset_htab(shift);
>      if (rc < 0) {
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 3600b0e..be79e3d 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -913,10 +913,7 @@ static void spapr_check_setup_free_hpt(sPAPRMachineS=
tate *spapr,
>          /* We assume RADIX, so this catches all the "Do Nothing" cases */
>      } else if (!(patbe_old & PATBE1_GR)) {
>          /* HASH->RADIX : Free HPT */
> -        g_free(spapr->htab);
> -        spapr->htab =3D NULL;
> -        spapr->htab_shift =3D 0;
> -        close_htab_fd(spapr);
> +        spapr_free_hpt(spapr);
>      } else if (!(patbe_new & PATBE1_GR)) {
>          /* RADIX->HASH || NOTHING->HASH : Allocate HPT */
>          spapr_setup_hpt_and_vrma(spapr);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index a692e63..6f9cb85 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -610,6 +610,7 @@ int spapr_h_cas_compose_response(sPAPRMachineState *s=
m,
>                                   sPAPROptionVector *ov5_updates);
>  void close_htab_fd(sPAPRMachineState *spapr);
>  void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr);
> +void spapr_free_hpt(sPAPRMachineState *spapr);
>  sPAPRTCETable *spapr_tce_new_table(DeviceState *owner, uint32_t liobn);
>  void spapr_tce_table_enable(sPAPRTCETable *tcet,
>                              uint32_t page_shift, uint64_t bus_offset,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Y+Z5jE7Arku/2GrR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZG/PvAAoJEGw4ysog2bOSQlcQAJ0uQbto6oqtUWe76mmJyi/O
47vagN0+7NYJV2WsRX69SK3Fqt+k+ROx8E1ic1ku/TbDdbZpiy2kORPSwQKCJpCl
XT5WHr6o4le/zTHNfw2hFj3begZQQfpodP9olWQPXso0i1i8C3EXPfQwsOr4vX2g
Np2X1SYb8E9UGkD8CCzYPoGtEF7tcAlC+nob5Q+0zpOF4MQrDK9RXKeudKB2XZr/
wiatA1WHcJLHlpd/AS5VbpGCMrb6PWW4yrwfM5E41PLgbcAb3iwL6DyF48ouRU2/
hgbRs9zAwkEOPOIaPG21sI3WbABHSAeIRvxz+CTB9ZIxgMIK0CdJfcn/NC8UVYoE
I3CzUeiL0o7Ky0qmFIjGAXB0THLA2Eob6QD1X4CcDSbHAm8H3xRAbjqCFL1TzIGT
GhA6ArgypoVTwsaG3b6d8u7njbUyuzvm2yNtd7I0T4MIbkBd0fh6z7hhjKpjTLXt
zcK0gFtCM/X/j2SDytIypp61JwcZ1QXoJqCZu9VxXSVlv5ppKBdy2vwPhN3C/7iZ
Z75drI3zNZ5c0jM+USOh30iIJIJs8KK4td5MoFzLDfGOTyk2Th7CPLoi/TBdae4K
ZLSdNrFRmHd8eir3CVjuj5oL9s6Ozn966H/SqpdbmSS7ZjDpQtkskuKnThMg+fey
3vF5YQtv0x3zOsO+Ykv0
=HyNf
-----END PGP SIGNATURE-----

--Y+Z5jE7Arku/2GrR--
