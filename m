Received: from eggs.gnu.org ([2001:4830:134:3::10]:42008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbw-000281-FH
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbn-0005zi-To
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:40 -0500
Date: Wed, 19 Dec 2018 17:40:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181219064012.GZ30570@umbus.fritz.box>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<20181218063911.2112-31-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qrotSzihSRAsrOtf"
Content-Disposition: inline
In-Reply-To: <20181218063911.2112-31-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 30/34] target/ppc: Use mtvscr/mfvscr for
 vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org


--qrotSzihSRAsrOtf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 10:39:07PM -0800, Richard Henderson wrote:
> This is required before changing the representation of the register.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/machine.c | 44 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 41 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 451cf376b4..3c27a89166 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -10,6 +10,7 @@
>  #include "migration/cpu.h"
>  #include "qapi/error.h"
>  #include "kvm_ppc.h"
> +#include "exec/helper-proto.h"
> =20
>  static int cpu_load_old(QEMUFile *f, void *opaque, int version_id)
>  {
> @@ -17,7 +18,7 @@ static int cpu_load_old(QEMUFile *f, void *opaque, int =
version_id)
>      CPUPPCState *env =3D &cpu->env;
>      unsigned int i, j;
>      target_ulong sdr1;
> -    uint32_t fpscr;
> +    uint32_t fpscr, vscr;
>  #if defined(TARGET_PPC64)
>      int32_t slb_nr;
>  #endif
> @@ -84,7 +85,8 @@ static int cpu_load_old(QEMUFile *f, void *opaque, int =
version_id)
>      if (!cpu->vhyp) {
>          ppc_store_sdr1(env, sdr1);
>      }
> -    qemu_get_be32s(f, &env->vscr);
> +    qemu_get_be32s(f, &vscr);
> +    helper_mtvscr(env, vscr);
>      qemu_get_be64s(f, &env->spe_acc);
>      qemu_get_be32s(f, &env->spe_fscr);
>      qemu_get_betls(f, &env->msr_mask);
> @@ -429,6 +431,28 @@ static bool altivec_needed(void *opaque)
>      return (cpu->env.insns_flags & PPC_ALTIVEC);
>  }
> =20
> +static int get_vscr(QEMUFile *f, void *opaque, size_t size,
> +                    const VMStateField *field)
> +{
> +    PowerPCCPU *cpu =3D opaque;
> +    helper_mtvscr(&cpu->env, qemu_get_be32(f));
> +    return 0;
> +}
> +
> +static int put_vscr(QEMUFile *f, void *opaque, size_t size,
> +                    const VMStateField *field, QJSON *vmdesc)
> +{
> +    PowerPCCPU *cpu =3D opaque;
> +    qemu_put_be32(f, helper_mfvscr(&cpu->env));
> +    return 0;
> +}
> +
> +static const VMStateInfo vmstate_vscr =3D {
> +    .name =3D "cpu/altivec/vscr",
> +    .get =3D get_vscr,
> +    .put =3D put_vscr,
> +};
> +
>  static const VMStateDescription vmstate_altivec =3D {
>      .name =3D "cpu/altivec",
>      .version_id =3D 1,
> @@ -436,7 +460,21 @@ static const VMStateDescription vmstate_altivec =3D {
>      .needed =3D altivec_needed,
>      .fields =3D (VMStateField[]) {
>          VMSTATE_AVR_ARRAY(env.vsr, PowerPCCPU, 32),
> -        VMSTATE_UINT32(env.vscr, PowerPCCPU),
> +        /*
> +         * Save the architecture value of the vscr, not the internally
> +         * expanded version.  Since this architecture value does not
> +         * exist in memory to be stored, this requires a but of hoop
> +         * jumping.  We want OFFSET=3D0 so that we effectively pass CPU
> +         * to the helper functions.
> +         */
> +        {
> +            .name =3D "vscr",
> +            .version_id =3D 0,
> +            .size =3D sizeof(uint32_t),
> +            .info =3D &vmstate_vscr,
> +            .flags =3D VMS_SINGLE,
> +            .offset =3D 0
> +        },
>          VMSTATE_END_OF_LIST()
>      },
>  };

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qrotSzihSRAsrOtf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwZ58wACgkQbDjKyiDZ
s5IHfxAAp8MsvmgtJgp0DKG2EyJr21KqLKyWldd7ZYeYFQd5wZ6DfJTRSsW6pk/l
8RTVyXVtK5idSZhtRyQzdQEgLir7oN5hYyNyPimD20kQ/S945F34FFS0SSq1McI9
dRukqCvnnlhabehhGdd4An2b1NBiLAwf5B3G6NPIbv+cf12Cma/e4DEjFar68u5L
ss5/421Ov6xNzAZ2RD03RIsM18i+tzNg9ukAXtcN/R3+PnCpuFBgEpIxiO7Vkixw
QbWSHI20lITe/a7Adj9HAOcx698TlJ0JCIUQ8gQDHXYBaeMG+Dj9rsOy9UQqYmcn
tUBytUinOe7Z/zFgON2bnBpjcsJxzVJycflSOF5csSziQ+d6qza1snopSMytawUV
iPx3x/xAkFtzI436fmDy7TFNvJWs8VEKdPpA9kgfiAzooRP5U+hyXFXb0z+wRBJS
WdUQPmxgbQRi6F/9c9b+J2HEEhX32jvPtZ+0WIm/P+7yIXIOxuRwoLKakMEcMnJV
9eyKCrxbI2AhcCtl6ZOBE3Aysjm0vIfCI5FJTXPEsOcBSOllyAFE6rnfMWl1aXX0
V18ZiWsdJ5s8eiYBI3kW8+n3K9r+59/4kBpzZaG/Y++3zeD7/1ZIZEZD19vr86L/
GU1leCDbUFlXSKV3ubxWRSLqgM4vAA4jvx2iD6Fc4VjJuzypNtY=
=auHh
-----END PGP SIGNATURE-----

--qrotSzihSRAsrOtf--
