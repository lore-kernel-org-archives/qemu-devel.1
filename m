Received: from eggs.gnu.org ([2001:4830:134:3::10]:58452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRVsf-0004BJ-25
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:16:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRVsd-0005CN-SR
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:16:49 -0500
Date: Thu, 12 Jan 2017 14:10:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170112031034.GG14026@umbus.fritz.box>
References: <1484014214-32533-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1484014214-32533-7-git-send-email-joserz@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JkW1gnuWHDypiMFO"
Content-Disposition: inline
In-Reply-To: <1484014214-32533-7-git-send-email-joserz@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 6/7] ppc: Implement bcdtrunc. instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, nikunj@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, eblake@redhat.com


--JkW1gnuWHDypiMFO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 10, 2017 at 12:10:13AM -0200, Jose Ricardo Ziviani wrote:
> bcdtrunc.: Decimal integer truncate. Given a BCD number in vrb and the
> number of bytes to truncate in vra, the return register will have vrb
> with such bits truncated.
>=20
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> ---
>  target/ppc/helper.h                 |  1 +
>  target/ppc/int_helper.c             | 37 +++++++++++++++++++++++++++++++=
++++++
>  target/ppc/translate/vmx-impl.inc.c |  5 +++++
>  target/ppc/translate/vmx-ops.inc.c  |  4 ++--
>  4 files changed, 45 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index d1db462..db17917 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -401,6 +401,7 @@ DEF_HELPER_3(bcdsetsgn, i32, avr, avr, i32)
>  DEF_HELPER_4(bcds, i32, avr, avr, avr, i32)
>  DEF_HELPER_4(bcdus, i32, avr, avr, avr, i32)
>  DEF_HELPER_4(bcdsr, i32, avr, avr, avr, i32)
> +DEF_HELPER_4(bcdtrunc, i32, avr, avr, avr, i32)
> =20
>  DEF_HELPER_2(xsadddp, void, env, i32)
>  DEF_HELPER_2(xsaddqp, void, env, i32)
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index b184063..06b14d5 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -3223,6 +3223,43 @@ uint32_t helper_bcdsr(ppc_avr_t *r, ppc_avr_t *a, =
ppc_avr_t *b, uint32_t ps)
>      return cr;
>  }
> =20
> +uint32_t helper_bcdtrunc(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint3=
2_t ps)
> +{
> +    uint64_t mask;
> +    uint32_t ox_flag =3D 0;
> +#if defined(HOST_WORDS_BIGENDIAN)
> +    int i =3D a->s16[3] + 1;
> +#else
> +    int i =3D a->s16[4] + 1;
> +#endif
> +    ppc_avr_t ret =3D *b;
> +
> +    if (bcd_is_valid(b) =3D=3D false) {
> +        return CRF_SO;
> +    }
> +
> +    if (i > 16 && i < 32) {
> +        if (ret.u64[HI_IDX] >> (i * 4 - 64)) {
> +            ox_flag =3D CRF_SO;
> +        }

You can simplify this by just checking ret.u64[HI_IDX] & ~mask before
you apply the mast.

> +
> +        mask =3D (uint64_t)-1 >> (128 - i * 4);
> +        ret.u64[HI_IDX] &=3D mask;
> +    } else if (i >=3D 0 && i <=3D 16) {
> +        if (ret.u64[HI_IDX] || (i < 16 && ret.u64[LO_IDX] >> (i * 4))) {
> +            ox_flag =3D CRF_SO;
> +        }
> +
> +        mask =3D (uint64_t)-1 >> (64 - i * 4);

Similarly here.

> +        ret.u64[LO_IDX] &=3D mask;
> +        ret.u64[HI_IDX] =3D 0;
> +    }
> +    bcd_put_digit(&ret, bcd_preferred_sgn(bcd_get_sgn(b), ps), 0);
> +    *r =3D ret;
> +
> +    return bcd_cmp_zero(&ret) | ox_flag;
> +}
> +
>  void helper_vsbox(ppc_avr_t *r, ppc_avr_t *a)
>  {
>      int i;
> diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
> index 451abb5..1683f42 100644
> --- a/target/ppc/translate/vmx-impl.inc.c
> +++ b/target/ppc/translate/vmx-impl.inc.c
> @@ -1019,6 +1019,7 @@ GEN_BCD(bcdcpsgn);
>  GEN_BCD(bcds);
>  GEN_BCD(bcdus);
>  GEN_BCD(bcdsr);
> +GEN_BCD(bcdtrunc);
> =20
>  static void gen_xpnd04_1(DisasContext *ctx)
>  {
> @@ -1097,6 +1098,10 @@ GEN_VXFORM_DUAL(vsubudm, PPC2_ALTIVEC_207, PPC_NON=
E, \
>                  bcds, PPC_NONE, PPC2_ISA300)
>  GEN_VXFORM_DUAL(vsubuwm, PPC_ALTIVEC, PPC_NONE, \
>                  bcdus, PPC_NONE, PPC2_ISA300)
> +GEN_VXFORM_DUAL(vsubsbs, PPC_ALTIVEC, PPC_NONE, \
> +                bcdtrunc, PPC_NONE, PPC2_ISA300)
> +GEN_VXFORM_DUAL(vsubuqm, PPC2_ALTIVEC_207, PPC_NONE, \
> +                bcdtrunc, PPC_NONE, PPC2_ISA300)
> =20
>  static void gen_vsbox(DisasContext *ctx)
>  {
> diff --git a/target/ppc/translate/vmx-ops.inc.c b/target/ppc/translate/vm=
x-ops.inc.c
> index fa9c996..e6167a4 100644
> --- a/target/ppc/translate/vmx-ops.inc.c
> +++ b/target/ppc/translate/vmx-ops.inc.c
> @@ -143,14 +143,14 @@ GEN_VXFORM(vaddsws, 0, 14),
>  GEN_VXFORM_DUAL(vsububs, bcdadd, 0, 24, PPC_ALTIVEC, PPC_NONE),
>  GEN_VXFORM_DUAL(vsubuhs, bcdsub, 0, 25, PPC_ALTIVEC, PPC_NONE),
>  GEN_VXFORM(vsubuws, 0, 26),
> -GEN_VXFORM(vsubsbs, 0, 28),
> +GEN_VXFORM_DUAL(vsubsbs, bcdtrunc, 0, 28, PPC_NONE, PPC2_ISA300),
>  GEN_VXFORM(vsubshs, 0, 29),
>  GEN_VXFORM_DUAL(vsubsws, xpnd04_2, 0, 30, PPC_ALTIVEC, PPC_NONE),
>  GEN_VXFORM_207(vadduqm, 0, 4),
>  GEN_VXFORM_207(vaddcuq, 0, 5),
>  GEN_VXFORM_DUAL(vaddeuqm, vaddecuq, 30, 0xFF, PPC_NONE, PPC2_ALTIVEC_207=
),
> -GEN_VXFORM_207(vsubuqm, 0, 20),
>  GEN_VXFORM_207(vsubcuq, 0, 21),
> +GEN_VXFORM_DUAL(vsubuqm, bcdtrunc, 0, 20, PPC2_ALTIVEC_207, PPC2_ISA300),
>  GEN_VXFORM_DUAL(vsubeuqm, vsubecuq, 31, 0xFF, PPC_NONE, PPC2_ALTIVEC_207=
),
>  GEN_VXFORM(vrlb, 2, 0),
>  GEN_VXFORM(vrlh, 2, 1),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JkW1gnuWHDypiMFO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYdvOnAAoJEGw4ysog2bOSqdUP+wdbeVoQoPtxabEfHwzxDk5J
p2IaPAi/AcEOTziRaJ6m5aUOkfTsYBtjj0qSK8iEzVDmnTvIzVcodS/srot6CNs5
B7XBlrqk705RSs/O6BzPTGdtO2wAt7j8x3on+UsGXslvFU+bnhDyqFF26VnJZlBx
tFZhi+vyqj3M58PNBA5Dqb8/gdPJeHgsrmMATv4lD8KCjp8+I24IJrBc6h2/a/aw
tLz09NmhaQbKTt5HJGX1YdVITZoGhOXMjvxgk0bJ5+iUOdav+zejfbs2J9FRBRCF
Qhacg2hiQ0pcMi8TTz36tkeBUb1LTq4dRLn2UC1WyhZ7xK/yzwcJYHOJERhfRli2
pgsX7nXHhBHi3qehy1sWKpRQOMKHxhef3emcXl+koSYcGrjxCr6Tm5oYnrgeTx8i
vb9cSXLdqrjMP+gngYKxOKZA1+gGvKe6KMiI/+SHtu/eqH4sKGgvgmthQS0f1NZp
VA7IxgNcSLewJLnXmnIAA5P7dwwO0OhQWCWD5pi9vByIE/3I2KTQzsTZXdfTKPMm
Yy+3ZmPgUR8ToFyWge+2KfOlh5zAKkaiYPQy44X9gd1NUMeZeNLxN+M8Uk3JkbSf
KQm/tUrPbeMLHcpg3MRTZkrkV1jl6sMzDVCXHOoE/OuMuxF/2XaRZ0eh84V/cs3W
5zYb/MFlyT8QzISF9V5N
=A6FI
-----END PGP SIGNATURE-----

--JkW1gnuWHDypiMFO--
