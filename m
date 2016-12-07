Received: from eggs.gnu.org ([2001:4830:134:3::10]:43579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cEXuG-00041v-57
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:48:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cEXuC-0005Ws-0o
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:48:52 -0500
Date: Wed, 7 Dec 2016 16:48:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161207054803.GF12489@umbus.fritz.box>
References: <1481053210-26821-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1481053210-26821-8-git-send-email-joserz@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3oCie2+XPXTnK5a5"
Content-Disposition: inline
In-Reply-To: <1481053210-26821-8-git-send-email-joserz@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 7/7] target-ppc: Implement bcdtrunc.
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, nikunj@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com


--3oCie2+XPXTnK5a5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2016 at 05:40:10PM -0200, Jose Ricardo Ziviani wrote:
> bcdutrunc. Decimal unsigned truncate. Works like bcdtrunc. with
> unsigned BCD numbers.
>=20
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

Short description (subject line) says 'bcdtrunc.' instead of
'bcdutrunc'.

Also same comment as previous patch.

> ---
>  target-ppc/helper.h                 |  1 +
>  target-ppc/int_helper.c             | 39 +++++++++++++++++++++++++++++++=
++++++
>  target-ppc/translate/vmx-impl.inc.c |  4 ++++
>  target-ppc/translate/vmx-ops.inc.c  |  2 +-
>  4 files changed, 45 insertions(+), 1 deletion(-)
>=20
> diff --git a/target-ppc/helper.h b/target-ppc/helper.h
> index 49965b0..52a2707 100644
> --- a/target-ppc/helper.h
> +++ b/target-ppc/helper.h
> @@ -396,6 +396,7 @@ DEF_HELPER_4(bcds, i32, avr, avr, avr, i32)
>  DEF_HELPER_4(bcdus, i32, avr, avr, avr, i32)
>  DEF_HELPER_4(bcdsr, i32, avr, avr, avr, i32)
>  DEF_HELPER_4(bcdtrunc, i32, avr, avr, avr, i32)
> +DEF_HELPER_4(bcdutrunc, i32, avr, avr, avr, i32)
> =20
>  DEF_HELPER_2(xsadddp, void, env, i32)
>  DEF_HELPER_2(xssubdp, void, env, i32)
> diff --git a/target-ppc/int_helper.c b/target-ppc/int_helper.c
> index faf34c1..6167f52 100644
> --- a/target-ppc/int_helper.c
> +++ b/target-ppc/int_helper.c
> @@ -3212,6 +3212,45 @@ uint32_t helper_bcdtrunc(ppc_avr_t *r, ppc_avr_t *=
a, ppc_avr_t *b, uint32_t ps)
>      return cr;
>  }
> =20
> +uint32_t helper_bcdutrunc(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint=
32_t ps)
> +{
> +    int i;
> +    uint8_t digit;
> +    uint8_t trunc;
> +    int ox_flag =3D 0;
> +    int invalid =3D 0;
> +    ppc_avr_t ret =3D *b;
> +
> +#if defined(HOST_WORDS_BIGENDIAN)
> +    int upper =3D ARRAY_SIZE(a->u16) - 1;
> +#else
> +    int upper =3D 0;
> +#endif
> +
> +    trunc =3D 32 - (a->u16[upper] % 33);
> +    for (i =3D 0; i < 32; i++) {
> +        digit =3D bcd_get_digit(b, i, &invalid);
> +
> +        if (unlikely(invalid)) {
> +            return CRF_SO;
> +        }
> +
> +        if (i >=3D trunc) {
> +            if (unlikely(!ox_flag && digit > 0x0)) {
> +                ox_flag =3D 1;
> +            }
> +            bcd_put_digit(&ret, 0, i);
> +        }
> +    }
> +
> +    *r =3D ret;
> +    if (r->u64[HI_IDX] =3D=3D 0 && r->u64[LO_IDX] =3D=3D 0) {
> +        return (ox_flag) ? CRF_SO | CRF_EQ : CRF_EQ;
> +    } else {
> +        return (ox_flag) ? CRF_SO | CRF_GT : CRF_GT;
> +    }
> +}
> +
>  void helper_vsbox(ppc_avr_t *r, ppc_avr_t *a)
>  {
>      int i;
> diff --git a/target-ppc/translate/vmx-impl.inc.c b/target-ppc/translate/v=
mx-impl.inc.c
> index 1683f42..3cb6fc2 100644
> --- a/target-ppc/translate/vmx-impl.inc.c
> +++ b/target-ppc/translate/vmx-impl.inc.c
> @@ -1020,6 +1020,7 @@ GEN_BCD(bcds);
>  GEN_BCD(bcdus);
>  GEN_BCD(bcdsr);
>  GEN_BCD(bcdtrunc);
> +GEN_BCD(bcdutrunc);
> =20
>  static void gen_xpnd04_1(DisasContext *ctx)
>  {
> @@ -1102,6 +1103,9 @@ GEN_VXFORM_DUAL(vsubsbs, PPC_ALTIVEC, PPC_NONE, \
>                  bcdtrunc, PPC_NONE, PPC2_ISA300)
>  GEN_VXFORM_DUAL(vsubuqm, PPC2_ALTIVEC_207, PPC_NONE, \
>                  bcdtrunc, PPC_NONE, PPC2_ISA300)
> +GEN_VXFORM_DUAL(vsubcuq, PPC2_ALTIVEC_207, PPC_NONE, \
> +                bcdutrunc, PPC_NONE, PPC2_ISA300)
> +
> =20
>  static void gen_vsbox(DisasContext *ctx)
>  {
> diff --git a/target-ppc/translate/vmx-ops.inc.c b/target-ppc/translate/vm=
x-ops.inc.c
> index e6167a4..139f80c 100644
> --- a/target-ppc/translate/vmx-ops.inc.c
> +++ b/target-ppc/translate/vmx-ops.inc.c
> @@ -149,8 +149,8 @@ GEN_VXFORM_DUAL(vsubsws, xpnd04_2, 0, 30, PPC_ALTIVEC=
, PPC_NONE),
>  GEN_VXFORM_207(vadduqm, 0, 4),
>  GEN_VXFORM_207(vaddcuq, 0, 5),
>  GEN_VXFORM_DUAL(vaddeuqm, vaddecuq, 30, 0xFF, PPC_NONE, PPC2_ALTIVEC_207=
),
> -GEN_VXFORM_207(vsubcuq, 0, 21),
>  GEN_VXFORM_DUAL(vsubuqm, bcdtrunc, 0, 20, PPC2_ALTIVEC_207, PPC2_ISA300),
> +GEN_VXFORM_DUAL(vsubcuq, bcdutrunc, 0, 21, PPC2_ALTIVEC_207, PPC2_ISA300=
),
>  GEN_VXFORM_DUAL(vsubeuqm, vsubecuq, 31, 0xFF, PPC_NONE, PPC2_ALTIVEC_207=
),
>  GEN_VXFORM(vrlb, 2, 0),
>  GEN_VXFORM(vrlh, 2, 1),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3oCie2+XPXTnK5a5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYR6KSAAoJEGw4ysog2bOS3qMQALS85DcQFC8gCMeNOUBlFW1g
BXmfzwt6o/DeqsI7XhVqMvk5y6g3Cx4ihPMtrQZ2ewo4NLmn5K54ddB3xRJTuvPU
eXj8+2nqe19danbd0B3ZCPmSQ1nXL9cATD5PNRO29uf2y39FlMD06HcyKUtC+zRs
z1eAvbir+agV3JabpXltbsKwtRF1lLAB3qGWOUGu/LGsz84gjfdm2f1jyxSL60Fd
Dct5ZUrVcwLEetwuGS/BALjmpg3vjGTskfTUZpcz2U5ZBGHLDvei/opGKxxYZEov
vgTs2Yzd58RgIf0GOawyFM57uzyK4mmyGReG5WRZyh8btS6IwPasP0NDiPrF6xTT
W9Nntlv/bcYBA2jZ6TY4f0h0LEOedxNp9cIPVkv/6U2L9PpGPau7MU6sga8Ht1w2
wQHLGd1Cte+ZDsF1hdMjvwBKM71krrKmOm0o5EeJcq3oXc1RGt4pLr1QCwipoE0X
+Atkuqw4M6xD7MJYGgQQNXT5sqGVJJoRt3VOhPi6dHa+Ev4iNy130F+u0/rd0tZ3
lFhoSo0upufDRpxNsm/4vskHVPkG0DB0D4Wtl2iZ36TVCpkLXniirsEmGj58PUUR
j7tnzX3B3ZpH0cU8h5F9EiM6fTDy0rOoxdSYl06lZI+GV5UJEppQJhIPkbQqoxSe
VXOgs2ll5ZCS7i+r92Eg
=6Jg9
-----END PGP SIGNATURE-----

--3oCie2+XPXTnK5a5--
