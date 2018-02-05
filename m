Received: from eggs.gnu.org ([2001:4830:134:3::10]:37993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eig81-0007k7-FB
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 07:44:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eig7y-0006wh-CH
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 07:44:09 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180205105720.14620-1-peter.maydell@linaro.org>
	<20180205105720.14620-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4bee993f-c7fb-5b2e-a966-7322ff269870@amsat.org>
Date: Mon, 5 Feb 2018 09:43:58 -0300
MIME-Version: 1.0
In-Reply-To: <20180205105720.14620-2-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="bTqPZxR14QwoL5lYXxKelidQsWWZCwPux"
Subject: Re: [Qemu-devel] [PATCH 1/8] hw/intc/armv7m_nvic: Don't hardcode M
 profile ID registers in NVIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bTqPZxR14QwoL5lYXxKelidQsWWZCwPux
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org
Message-ID: <4bee993f-c7fb-5b2e-a966-7322ff269870@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 1/8] hw/intc/armv7m_nvic: Don't hardcode M
 profile ID registers in NVIC
References: <20180205105720.14620-1-peter.maydell@linaro.org>
 <20180205105720.14620-2-peter.maydell@linaro.org>
In-Reply-To: <20180205105720.14620-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/05/2018 07:57 AM, Peter Maydell wrote:
> Instead of hardcoding the values of M profile ID registers in the
> NVIC, use the fields in the CPU struct. This will allow us to
> give different M profile CPU types different ID register values.
> This commit includes the addition of the missing ID_ISAR5,
> which exists as RES0 in both v7M and v8M.
>=20
> (The values of the ID registers might be wrong for the M4 --
> this commit leaves the behaviour there unchanged.)
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  hw/intc/armv7m_nvic.c | 30 ++++++++++++++++--------------
>  target/arm/cpu.c      | 28 ++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 360889d30b..63da0fee34 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -990,31 +990,33 @@ static uint32_t nvic_readl(NVICState *s, uint32_t=
 offset, MemTxAttrs attrs)
>                        "Aux Fault status registers unimplemented\n");
>          return 0;
>      case 0xd40: /* PFR0.  */
> -        return 0x00000030;
> -    case 0xd44: /* PRF1.  */
> -        return 0x00000200;
> +        return cpu->id_pfr0;
> +    case 0xd44: /* PFR1.  */
> +        return cpu->id_pfr1;
>      case 0xd48: /* DFR0.  */
> -        return 0x00100000;
> +        return cpu->id_dfr0;
>      case 0xd4c: /* AFR0.  */
> -        return 0x00000000;
> +        return cpu->id_afr0;
>      case 0xd50: /* MMFR0.  */
> -        return 0x00000030;
> +        return cpu->id_mmfr0;
>      case 0xd54: /* MMFR1.  */
> -        return 0x00000000;
> +        return cpu->id_mmfr1;
>      case 0xd58: /* MMFR2.  */
> -        return 0x00000000;
> +        return cpu->id_mmfr2;
>      case 0xd5c: /* MMFR3.  */
> -        return 0x00000000;
> +        return cpu->id_mmfr3;
>      case 0xd60: /* ISAR0.  */
> -        return 0x01141110;
> +        return cpu->id_isar0;
>      case 0xd64: /* ISAR1.  */
> -        return 0x02111000;
> +        return cpu->id_isar1;
>      case 0xd68: /* ISAR2.  */
> -        return 0x21112231;
> +        return cpu->id_isar2;
>      case 0xd6c: /* ISAR3.  */
> -        return 0x01111110;
> +        return cpu->id_isar3;
>      case 0xd70: /* ISAR4.  */
> -        return 0x01310102;
> +        return cpu->id_isar4;
> +    case 0xd74: /* ISAR5.  */
> +        return cpu->id_isar5;
>      /* TODO: Implement debug registers.  */
>      case 0xd90: /* MPU_TYPE */
>          /* Unified MPU; if the MPU is not present this value is zero *=
/
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 9da6ea505c..223361fb50 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1146,6 +1146,20 @@ static void cortex_m3_initfn(Object *obj)
>      set_feature(&cpu->env, ARM_FEATURE_M);
>      cpu->midr =3D 0x410fc231;
>      cpu->pmsav7_dregion =3D 8;
> +    cpu->id_pfr0 =3D 0x00000030;
> +    cpu->id_pfr1 =3D 0x00000200;
> +    cpu->id_dfr0 =3D 0x00100000;
> +    cpu->id_afr0 =3D 0x00000000;
> +    cpu->id_mmfr0 =3D 0x00000030;
> +    cpu->id_mmfr1 =3D 0x00000000;
> +    cpu->id_mmfr2 =3D 0x00000000;
> +    cpu->id_mmfr3 =3D 0x00000000;
> +    cpu->id_isar0 =3D 0x01141110;
> +    cpu->id_isar1 =3D 0x02111000;
> +    cpu->id_isar2 =3D 0x21112231;
> +    cpu->id_isar3 =3D 0x01111110;
> +    cpu->id_isar4 =3D 0x01310102;
> +    cpu->id_isar5 =3D 0x00000000;
>  }
> =20
>  static void cortex_m4_initfn(Object *obj)
> @@ -1157,6 +1171,20 @@ static void cortex_m4_initfn(Object *obj)
>      set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
>      cpu->midr =3D 0x410fc240; /* r0p0 */
>      cpu->pmsav7_dregion =3D 8;
> +    cpu->id_pfr0 =3D 0x00000030;
> +    cpu->id_pfr1 =3D 0x00000200;
> +    cpu->id_dfr0 =3D 0x00100000;
> +    cpu->id_afr0 =3D 0x00000000;
> +    cpu->id_mmfr0 =3D 0x00000030;
> +    cpu->id_mmfr1 =3D 0x00000000;
> +    cpu->id_mmfr2 =3D 0x00000000;
> +    cpu->id_mmfr3 =3D 0x00000000;
> +    cpu->id_isar0 =3D 0x01141110;
> +    cpu->id_isar1 =3D 0x02111000;
> +    cpu->id_isar2 =3D 0x21112231;
> +    cpu->id_isar3 =3D 0x01111110;
> +    cpu->id_isar4 =3D 0x01310102;
> +    cpu->id_isar5 =3D 0x00000000;
>  }
> =20
>  static void arm_v7m_class_init(ObjectClass *oc, void *data)
>=20


--bTqPZxR14QwoL5lYXxKelidQsWWZCwPux
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlp4UY4ACgkQ4+MsLN6t
wN7k1Q/6AmXe4zDG8Bo8mAcBlY54AGS6B2ZhAeTFFa98JhEFVqbaayt812PcdgJf
G/PlFToeVF6M5XoEdz2ZS9DO75g7cWYQ9DFaZgUY5wy3jZ+pCffCaHgcYOslVA7V
twFXZ4LHZBF4ZLNPc3VBepeAMlOtgD82zYzKIFwdsPr2QVqDBZ0uXSGk+qLjA6mc
1ZSYGFaZR6jB43teXNARzXiZhlayH0IxzZFk5JRg5qd9gaXxkfg9xaKlp/8EWyMd
1t6dtav5N2Sr9wQep/gaOKZlXxHGwA9/qR9iScjdCurCQI/yivmfU1mqFPQxIGVm
LkmYRUOkn4mKnb+LsC4+IjLtv5pLMDmZwLES6OFoa17BwMpRMe7GeLw4bAXAUEyt
4brSGFSIykBCztK7XyVM2wn/sGop/+PZ13jXqYSfu54Q4Me9po4Oj4Xb/i4bNIvO
JXiESTQLx6AYCbslTkiBQbCrpyzsDFgyUvSrnJ7CNm5S0cfnV/HprZPPXbCKhwu/
dVOScxHxmWV0c38R+Z1fZ5RWDOFfg+5f5ot7Sbo1m7X4g5Zt5eSqTKyv/3jSJWV2
t6Hzgo+bObGVWkjMHnQ7LQXtho9GSw5WR1FhC9AF86jgA7CVTRTXJS6OAjhBI1BQ
hQVIh8CcuCSEHW2PDFSB51f3KCEPXF5aIlmscGEXEHPMBw4HevQ=
=Veyz
-----END PGP SIGNATURE-----

--bTqPZxR14QwoL5lYXxKelidQsWWZCwPux--
