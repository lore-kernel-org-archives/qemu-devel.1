Received: from eggs.gnu.org ([2001:4830:134:3::10]:58125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eSCip-0003DR-Da
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eSCio-00077a-2C
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:06:03 -0500
Date: Fri, 22 Dec 2017 11:39:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171222003906.GA26042@umbus.fritz.box>
References: <20171221165456.8609-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <20171221165456.8609-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: more use of the PPC_*() macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2017 at 05:54:56PM +0100, C=E9dric Le Goater wrote:
> Also introduce utilities to manipulate bitmasks (originaly from OPAL)
> which be will be used in the model of the XIVE interrupt controller.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-2.12, thanks.  Unfortunately getting my tree pulled
is held up because something is breaking on arm.

> ---
>  hw/ppc/pnv_lpc.c        | 10 +++++-----
>  target/ppc/cpu.h        | 49 +++++++++++++++++++++++++++----------------=
------
>  target/ppc/int_helper.c |  2 +-
>  3 files changed, 33 insertions(+), 28 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index b777b78e1837..c42b4a8f6c0f 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -146,13 +146,13 @@ static bool opb_write(PnvLpcController *lpc, uint32=
_t addr, uint8_t *data,
>      return success;
>  }
> =20
> -#define ECCB_CTL_READ           (1ull << (63 - 15))
> +#define ECCB_CTL_READ           PPC_BIT(15)
>  #define ECCB_CTL_SZ_LSH         (63 - 7)
> -#define ECCB_CTL_SZ_MASK        (0xfull << ECCB_CTL_SZ_LSH)
> -#define ECCB_CTL_ADDR_MASK      0xffffffffu;
> +#define ECCB_CTL_SZ_MASK        PPC_BITMASK(4, 7)
> +#define ECCB_CTL_ADDR_MASK      PPC_BITMASK(32, 63)
> =20
> -#define ECCB_STAT_OP_DONE       (1ull << (63 - 52))
> -#define ECCB_STAT_OP_ERR        (1ull << (63 - 52))
> +#define ECCB_STAT_OP_DONE       PPC_BIT(52)
> +#define ECCB_STAT_OP_ERR        PPC_BIT(52)
>  #define ECCB_STAT_RD_DATA_LSH   (63 - 37)
>  #define ECCB_STAT_RD_DATA_MASK  (0xffffffff << ECCB_STAT_RD_DATA_LSH)
> =20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 370b05e76ede..894fb76fabe1 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -93,6 +93,12 @@
>  #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(b=
s))
>  #define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
>                                   PPC_BIT32(bs))
> +#define PPC_BITMASK8(bs, be)    ((PPC_BIT8(bs) - PPC_BIT8(be)) | PPC_BIT=
8(bs))
> +
> +#define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
> +#define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
> +#define SETFIELD(m, v, val)                             \
> +        (((v) & ~(m)) | ((((typeof(v))(val)) << MASK_TO_LSH(m)) & (m)))
> =20
>  /***********************************************************************=
******/
>  /* Exception vectors definitions                                        =
     */
> @@ -2349,32 +2355,31 @@ enum {
> =20
>  /* Processor Compatibility mask (PCR) */
>  enum {
> -    PCR_COMPAT_2_05     =3D 1ull << (63-62),
> -    PCR_COMPAT_2_06     =3D 1ull << (63-61),
> -    PCR_COMPAT_2_07     =3D 1ull << (63-60),
> -    PCR_COMPAT_3_00     =3D 1ull << (63-59),
> -    PCR_VEC_DIS         =3D 1ull << (63-0), /* Vec. disable (bit NA sinc=
e POWER8) */
> -    PCR_VSX_DIS         =3D 1ull << (63-1), /* VSX disable (bit NA since=
 POWER8) */
> -    PCR_TM_DIS          =3D 1ull << (63-2), /* Trans. memory disable (PO=
WER8) */
> +    PCR_COMPAT_2_05     =3D PPC_BIT(62),
> +    PCR_COMPAT_2_06     =3D PPC_BIT(61),
> +    PCR_COMPAT_2_07     =3D PPC_BIT(60),
> +    PCR_COMPAT_3_00     =3D PPC_BIT(59),
> +    PCR_VEC_DIS         =3D PPC_BIT(0), /* Vec. disable (bit NA since PO=
WER8) */
> +    PCR_VSX_DIS         =3D PPC_BIT(1), /* VSX disable (bit NA since POW=
ER8) */
> +    PCR_TM_DIS          =3D PPC_BIT(2), /* Trans. memory disable (POWER8=
) */
>  };
> =20
>  /* HMER/HMEER */
>  enum {
> -    HMER_MALFUNCTION_ALERT      =3D 1ull << (63 - 0),
> -    HMER_PROC_RECV_DONE         =3D 1ull << (63 - 2),
> -    HMER_PROC_RECV_ERROR_MASKED =3D 1ull << (63 - 3),
> -    HMER_TFAC_ERROR             =3D 1ull << (63 - 4),
> -    HMER_TFMR_PARITY_ERROR      =3D 1ull << (63 - 5),
> -    HMER_XSCOM_FAIL             =3D 1ull << (63 - 8),
> -    HMER_XSCOM_DONE             =3D 1ull << (63 - 9),
> -    HMER_PROC_RECV_AGAIN        =3D 1ull << (63 - 11),
> -    HMER_WARN_RISE              =3D 1ull << (63 - 14),
> -    HMER_WARN_FALL              =3D 1ull << (63 - 15),
> -    HMER_SCOM_FIR_HMI           =3D 1ull << (63 - 16),
> -    HMER_TRIG_FIR_HMI           =3D 1ull << (63 - 17),
> -    HMER_HYP_RESOURCE_ERR       =3D 1ull << (63 - 20),
> -    HMER_XSCOM_STATUS_MASK      =3D 7ull << (63 - 23),
> -    HMER_XSCOM_STATUS_LSH       =3D (63 - 23),
> +    HMER_MALFUNCTION_ALERT      =3D PPC_BIT(0),
> +    HMER_PROC_RECV_DONE         =3D PPC_BIT(2),
> +    HMER_PROC_RECV_ERROR_MASKED =3D PPC_BIT(3),
> +    HMER_TFAC_ERROR             =3D PPC_BIT(4),
> +    HMER_TFMR_PARITY_ERROR      =3D PPC_BIT(5),
> +    HMER_XSCOM_FAIL             =3D PPC_BIT(8),
> +    HMER_XSCOM_DONE             =3D PPC_BIT(9),
> +    HMER_PROC_RECV_AGAIN        =3D PPC_BIT(11),
> +    HMER_WARN_RISE              =3D PPC_BIT(14),
> +    HMER_WARN_FALL              =3D PPC_BIT(15),
> +    HMER_SCOM_FIR_HMI           =3D PPC_BIT(16),
> +    HMER_TRIG_FIR_HMI           =3D PPC_BIT(17),
> +    HMER_HYP_RESOURCE_ERR       =3D PPC_BIT(20),
> +    HMER_XSCOM_STATUS_MASK      =3D PPC_BITMASK(21, 23),
>  };
> =20
>  /* Alternate Interrupt Location (AIL) */
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index 1c013a0ee3f1..3a50f1e1b72c 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -183,7 +183,7 @@ uint64_t helper_bpermd(uint64_t rs, uint64_t rb)
>      for (i =3D 0; i < 8; i++) {
>          int index =3D (rs >> (i*8)) & 0xFF;
>          if (index < 64) {
> -            if (rb & (1ull << (63-index))) {
> +            if (rb & PPC_BIT(index)) {
>                  ra |=3D 1 << i;
>              }
>          }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo8VCcACgkQbDjKyiDZ
s5IbUA//Wg/XyyafASPUeJ+yRt8LgzU6pAHP2lUdtVVBX0bCLgS5da2S/ofZ2ct/
iB0hT8VNgUQj9c00XTLoVWPZk/K41/UcBQhmhrdoIfpMP53PgQyfY9gZPfLQG5zN
Pu7+COWJFj5pJuO65e8cqYzOwPbpihspLj0UGgYcTXWgkQzbFSKuyidSLwO0spWs
x6oiM094eK3OP069k8lIafTL3xB8ojoLaBW7wH2r0IbxOQq3RnI5g6UfgwcWVQ+C
N1YeYc4aByDtgpsDfNbV6vctuOG1i+jJylxKp03eqVc6yqdrLpbBl2wIISRPrqvh
T5F/fF6dWQuZZPezdGNxvsv8QTBPSrqtvM9jZzex1BGLFavGkuGaxiMFH3THvwWp
cSR/kNwTiyJKNm7GVdaG7LBFlxzjG1xMDkzkZ2cGhbjTKZAo3OsWsio9cGzO4HXz
Bv+CVZzI9Ij3JDquelWiNaurB0VvbS+cRLeOT5yFXU8mxCY3c44rxqMiPMaKX5v8
CbVDRA7IZVL8mGI8g7u6pG7dbxsZs45dbnw521ZZQyDhDYSdj/WwWPkDJK4QvT2V
Bq2uEtODbYtCV/QZaNw7bKOBIB7wkLqQESEr2oE1SbyihI4u4FCivjK1wU1OCYU6
pTClQxHIqz6AldhlOs+En5bT8aipvbaUTLAkH7zz2OtIkg1ZU40=
=23u6
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
