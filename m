Received: from eggs.gnu.org ([2001:4830:134:3::10]:60689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cF7Xn-0005H9-JM
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 17:52:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cF7Xk-0002TS-I9
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 17:52:03 -0500
Date: Fri, 9 Dec 2016 08:06:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161208210614.GB13139@umbus.fritz.box>
References: <1481162828-2295-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1481162828-2295-6-git-send-email-joserz@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Content-Disposition: inline
In-Reply-To: <1481162828-2295-6-git-send-email-joserz@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/6] target-ppc: Implement bcdtrunc.
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


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 08, 2016 at 12:07:07AM -0200, Jose Ricardo Ziviani wrote:
> bcdtrunc.: Decimal integer truncate. Given a BCD number in vrb and the
> number of bytes to truncate in vra, the return register will have vrb
> with such bits truncated.
>=20
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

Um.. this is wrong on multiple accounts.  Have you actually tested
this with any input at all?

> ---
>  target-ppc/helper.h                 |  1 +
>  target-ppc/int_helper.c             | 40 +++++++++++++++++++++++++++++++=
++++++
>  target-ppc/translate/vmx-impl.inc.c |  5 +++++
>  target-ppc/translate/vmx-ops.inc.c  |  4 ++--
>  4 files changed, 48 insertions(+), 2 deletions(-)
>=20
> diff --git a/target-ppc/helper.h b/target-ppc/helper.h
> index d9528eb..49965b0 100644
> --- a/target-ppc/helper.h
> +++ b/target-ppc/helper.h
> @@ -395,6 +395,7 @@ DEF_HELPER_3(bcdsetsgn, i32, avr, avr, i32)
>  DEF_HELPER_4(bcds, i32, avr, avr, avr, i32)
>  DEF_HELPER_4(bcdus, i32, avr, avr, avr, i32)
>  DEF_HELPER_4(bcdsr, i32, avr, avr, avr, i32)
> +DEF_HELPER_4(bcdtrunc, i32, avr, avr, avr, i32)
> =20
>  DEF_HELPER_2(xsadddp, void, env, i32)
>  DEF_HELPER_2(xssubdp, void, env, i32)
> diff --git a/target-ppc/int_helper.c b/target-ppc/int_helper.c
> index cfef25f..dea08e6 100644
> --- a/target-ppc/int_helper.c
> +++ b/target-ppc/int_helper.c
> @@ -3169,6 +3169,46 @@ uint32_t helper_bcdsr(ppc_avr_t *r, ppc_avr_t *a, =
ppc_avr_t *b, uint32_t ps)
>      return cr;
>  }
> =20
> +uint32_t helper_bcdtrunc(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint3=
2_t ps)
> +{
> +    uint64_t mask;
> +    uint32_t bits;
> +    uint32_t ox_flag =3D 0;
> +    ppc_avr_t ret =3D *b;
> +
> +#if defined(HOST_WORDS_BIGENDIAN)
> +    int upper =3D ARRAY_SIZE(a->u16) - 1;
> +#else
> +    int upper =3D 0;
> +#endif
> +
> +    if (bcd_is_valid(b) =3D=3D false) {
> +        return CRF_SO;
> +    }
> +
> +    bits =3D (a->u16[upper] & 31) << 2;

According to the ISA, the value here gives the number of digits to
*retain*, you're treating it as the number of digits to clear.  You're
also not accounting for the sign marker, which should be retained in
any case.

Finally, the ISA says the value in bits 48:63 are treated as length
with no mention of being truncated to 5 bits.  Which means it's not
clear what should happen if length > 31.  You'll need to check with
the hardware people about this.

> +    if (bits >=3D 64) {
> +        if (ret.u64[HI_IDX] || (ret.u64[LO_IDX] >> (128 - bits))) {
> +            ox_flag =3D CRF_SO;
> +        }
> +
> +        mask =3D (uint64_t)-1 >> (bits - 64);
> +        ret.u64[HI_IDX] =3D 0;
> +        ret.u64[LO_IDX] &=3D mask;
> +    } else {
> +        if (ret.u64[HI_IDX] >> (64 - bits)) {
> +            ox_flag =3D CRF_SO;
> +        }
> +
> +        mask =3D (uint64_t)-1 >> bits;
> +        ret.u64[HI_IDX] &=3D mask;
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
> diff --git a/target-ppc/translate/vmx-impl.inc.c b/target-ppc/translate/v=
mx-impl.inc.c
> index 451abb5..1683f42 100644
> --- a/target-ppc/translate/vmx-impl.inc.c
> +++ b/target-ppc/translate/vmx-impl.inc.c
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
> diff --git a/target-ppc/translate/vmx-ops.inc.c b/target-ppc/translate/vm=
x-ops.inc.c
> index fa9c996..e6167a4 100644
> --- a/target-ppc/translate/vmx-ops.inc.c
> +++ b/target-ppc/translate/vmx-ops.inc.c
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

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYSctEAAoJEGw4ysog2bOSbE4P/jKKapw88M1U1BL69PAe8o/U
Ppufdw+z21GeFGOGqt3+78kLx1swtf/StMm/AMeTIngh6n54Y1ANaxg/zYajJqIo
lZFYG4JOa6yQBkwj3aX+0nKfxLzZSuhmITBYd7VyFYPmsfRakobt3RwyXUkZAAHq
M7+66uYtfUx2Oz5x3EPK4Q78jvjAKnV0kwMBn5s0UjegDzY4BKaLje8sH+W4efZq
Q2vZTNVm0PIVClRp1APR9rK29AwLe6CHZbDzPHeth1sdCFqQ+X4m41xfrckYILv5
lEaXqGlva1eI92hzMXnboJO1ec4R8EbEJU/rOutUXllkMlfDHqFh17d6jrGEMp8x
bVt4PtuONJt00XoWuecRIrWIGjqmum5qP8clu6KjVz13bz8w1wKLcGSrqxkIbc9/
YhWDD0oSMKYdEeS5f4959e3Zvo0tRD+DdYr2JXCyguf3yaHwNX+Vch/o710sgESk
1kN6UQfPTtpR7lBRxMNY3NYzyPN051XWWgCE1cq9wCb3UKAgzupZ9Vm4Ll6x0Ebp
4KaS5TxdHiyfqyXLzQE2gk4Lkb4RjqrrbWqLbQQ0iq9Ys3v3jjMZ5k1cchS8QmAe
fUAVlSprnWxj6rykB6Agqx2V0oq+KNVZzpzh+LOUlemHozjKPeeDzXfyeIvohlIq
34q0qz9RqVP/LLy5uySg
=QuvF
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
