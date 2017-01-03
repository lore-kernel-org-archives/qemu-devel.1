Received: from eggs.gnu.org ([2001:4830:134:3::10]:39523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cOCjl-0007KF-1t
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 19:13:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cOCjh-0004nt-0w
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 19:13:57 -0500
Date: Tue, 3 Jan 2017 11:08:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170103000851.GK12761@umbus.fritz.box>
References: <1482166064-18121-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1482166064-18121-3-git-send-email-joserz@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zYjDATHXTWnytHRU"
Content-Disposition: inline
In-Reply-To: <1482166064-18121-3-git-send-email-joserz@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/6] target-ppc: Implement bcds.
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


--zYjDATHXTWnytHRU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 19, 2016 at 02:47:40PM -0200, Jose Ricardo Ziviani wrote:
> bcds.: Decimal shift. Given two registers vra and vrb, this instruction
> shift the vrb value by vra bits into the result register.
>=20
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> ---
>  target-ppc/helper.h                 |  1 +
>  target-ppc/int_helper.c             | 40 +++++++++++++++++++++++++++++++=
++++++
>  target-ppc/translate/vmx-impl.inc.c |  3 +++
>  target-ppc/translate/vmx-ops.inc.c  |  3 ++-
>  4 files changed, 46 insertions(+), 1 deletion(-)
>=20
> diff --git a/target-ppc/helper.h b/target-ppc/helper.h
> index 4707db4..1a49b40 100644
> --- a/target-ppc/helper.h
> +++ b/target-ppc/helper.h
> @@ -398,6 +398,7 @@ DEF_HELPER_3(bcdcfsq, i32, avr, avr, i32)
>  DEF_HELPER_3(bcdctsq, i32, avr, avr, i32)
>  DEF_HELPER_4(bcdcpsgn, i32, avr, avr, avr, i32)
>  DEF_HELPER_3(bcdsetsgn, i32, avr, avr, i32)
> +DEF_HELPER_4(bcds, i32, avr, avr, avr, i32)
> =20
>  DEF_HELPER_2(xsadddp, void, env, i32)
>  DEF_HELPER_2(xssubdp, void, env, i32)
> diff --git a/target-ppc/int_helper.c b/target-ppc/int_helper.c
> index 7989b1f..35e14dc 100644
> --- a/target-ppc/int_helper.c
> +++ b/target-ppc/int_helper.c
> @@ -3043,6 +3043,46 @@ uint32_t helper_bcdsetsgn(ppc_avr_t *r, ppc_avr_t =
*b, uint32_t ps)
>      return bcd_cmp_zero(r);
>  }
> =20
> +uint32_t helper_bcds(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t =
ps)
> +{
> +    int cr;
> +#if defined(HOST_WORDS_BIGENDIAN)
> +    int i =3D a->s8[7];
> +#else
> +    int i =3D a->s8[8];
> +#endif
> +    bool ox_flag =3D false;
> +    int sgnb =3D bcd_get_sgn(b);
> +    ppc_avr_t ret =3D *b;
> +    ret.u64[LO_IDX] &=3D ~0xf;
> +
> +    if (bcd_is_valid(b) =3D=3D false) {
> +        return CRF_SO;
> +    }
> +
> +    if (unlikely(i > 31)) {
> +        i =3D 31;
> +    } else if (unlikely(i < -31)) {
> +        i =3D -31;
> +    }
> +
> +    if (i > 0) {
> +        ulshift(&ret.u64[LO_IDX], &ret.u64[HI_IDX], i * 4, &ox_flag);
> +    } else {
> +        urshift(&ret.u64[LO_IDX], &ret.u64[HI_IDX], -i * 4);
> +    }
> +    bcd_put_digit(&ret, bcd_preferred_sgn(sgnb, ps), 0);
> +
> +    *r =3D ret;
> +
> +    cr =3D bcd_cmp_zero(r);
> +    if (unlikely(ox_flag)) {

I can imagine use cases where an overflow is not unlikely.  Best to
remove the unlikely() here and let the CPU's dynamic branch prediction
handle it.

> +        cr |=3D CRF_SO;
> +    }
> +
> +    return cr;
> +}
> +
>  void helper_vsbox(ppc_avr_t *r, ppc_avr_t *a)
>  {
>      int i;
> diff --git a/target-ppc/translate/vmx-impl.inc.c b/target-ppc/translate/v=
mx-impl.inc.c
> index e8e527f..84ebb7e 100644
> --- a/target-ppc/translate/vmx-impl.inc.c
> +++ b/target-ppc/translate/vmx-impl.inc.c
> @@ -1016,6 +1016,7 @@ GEN_BCD2(bcdcfsq)
>  GEN_BCD2(bcdctsq)
>  GEN_BCD2(bcdsetsgn)
>  GEN_BCD(bcdcpsgn);
> +GEN_BCD(bcds);
> =20
>  static void gen_xpnd04_1(DisasContext *ctx)
>  {
> @@ -1090,6 +1091,8 @@ GEN_VXFORM_DUAL(vsubuhs, PPC_ALTIVEC, PPC_NONE, \
>                  bcdsub, PPC_NONE, PPC2_ALTIVEC_207)
>  GEN_VXFORM_DUAL(vaddshs, PPC_ALTIVEC, PPC_NONE, \
>                  bcdcpsgn, PPC_NONE, PPC2_ISA300)
> +GEN_VXFORM_DUAL(vsubudm, PPC2_ALTIVEC_207, PPC_NONE, \
> +                bcds, PPC_NONE, PPC2_ISA300)
> =20
>  static void gen_vsbox(DisasContext *ctx)
>  {
> diff --git a/target-ppc/translate/vmx-ops.inc.c b/target-ppc/translate/vm=
x-ops.inc.c
> index 57dce6e..7b4b009 100644
> --- a/target-ppc/translate/vmx-ops.inc.c
> +++ b/target-ppc/translate/vmx-ops.inc.c
> @@ -62,7 +62,8 @@ GEN_VXFORM_207(vaddudm, 0, 3),
>  GEN_VXFORM_DUAL(vsububm, bcdadd, 0, 16, PPC_ALTIVEC, PPC_NONE),
>  GEN_VXFORM_DUAL(vsubuhm, bcdsub, 0, 17, PPC_ALTIVEC, PPC_NONE),
>  GEN_VXFORM(vsubuwm, 0, 18),
> -GEN_VXFORM_207(vsubudm, 0, 19),
> +GEN_VXFORM_DUAL(vsubudm, bcds, 0, 19, PPC2_ALTIVEC_207, PPC2_ISA300),
> +GEN_VXFORM_300(bcds, 0, 27),
>  GEN_VXFORM(vmaxub, 1, 0),
>  GEN_VXFORM(vmaxuh, 1, 1),
>  GEN_VXFORM(vmaxuw, 1, 2),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zYjDATHXTWnytHRU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYauuQAAoJEGw4ysog2bOSwGMP/2ARY+0aRXYav9eJ8VZZR7no
IiSGx72lZY2sqYLF+n61Ju3dsCtWaZ9xc8Zl1zZj4XcN8hnK5EQr2TRtp8SjE3/0
2RFvLY2GfGsM5UQ73gRmzw9cpucmD2Z4Fi7S2eHBzf78T5J0qJcYt5WSOeAU5ACQ
69pKiTPPKO+Wh7XL5R+c2Odzz0Dw1B6luWfnCLzdYtN5eTqHr3cBAHDdAb0bZxYw
6kFQBbFjdpHTfgzi0UnCGJp78VmoKSG7r/0YHtkBMjd/lB3Gbcg3SKSp/nEzZ4+L
KIoidDYVeR8SPMPhtQ23OohQZvDzXtcPbrVlLOTd0MoxWkdj1k4L2Tz+ISvHtezP
fh2pMYpDWXvD6XRDbs13+eJSAcCSlqrc9/C+yp5g3Fc1QFvhZV6PIBf2zVonF24+
kILSqQdeFhcByBNcxug6ZTQOkZLvJklfOD/sL3eOcoaKl8YPO2rXsiuY6jKaCEVT
8IH4XYMgorbtTd4w0RFo6yIOgEmIEwI3JHM6+Qo6wwUS5H2ABxeYUecuPy4fkYKx
KEFnQgr1Rf81+S5kezvE+oG6AjKMSjGb+zcbpyjz1tLXqr3oMVDTqGSux5lM8IWZ
CvWD7+uSiMYL+S0iwyxKMH7VLj8BWm0IfomgV9u4hSxmKuBYaHwAoalh8X25IlZt
peo+XO5WJAh9s0hJhP4J
=pWEO
-----END PGP SIGNATURE-----

--zYjDATHXTWnytHRU--
