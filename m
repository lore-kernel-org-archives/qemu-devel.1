Received: from eggs.gnu.org ([2001:4830:134:3::10]:41994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbv-00026M-7b
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbn-0005zT-S0
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:40 -0500
Date: Wed, 19 Dec 2018 17:39:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181219063940.GY30570@umbus.fritz.box>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<20181218063911.2112-30-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="npbjE3dh3wBH6WIP"
Content-Disposition: inline
In-Reply-To: <20181218063911.2112-30-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 29/34] target/ppc: Add helper_mfvscr
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


--npbjE3dh3wBH6WIP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 10:39:06PM -0800, Richard Henderson wrote:
> This is required before changing the representation of the register.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/helper.h                 | 1 +
>  target/ppc/arch_dump.c              | 3 ++-
>  target/ppc/int_helper.c             | 5 +++++
>  target/ppc/translate/vmx-impl.inc.c | 2 +-
>  target/ppc/translate_init.inc.c     | 2 +-
>  5 files changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index b3ffe28103..7dbb08b9dd 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -295,6 +295,7 @@ DEF_HELPER_5(vmsumshm, void, env, avr, avr, avr, avr)
>  DEF_HELPER_5(vmsumshs, void, env, avr, avr, avr, avr)
>  DEF_HELPER_4(vmladduhm, void, avr, avr, avr, avr)
>  DEF_HELPER_FLAGS_2(mtvscr, TCG_CALL_NO_RWG, void, env, i32)
> +DEF_HELPER_FLAGS_1(mfvscr, TCG_CALL_NO_RWG, i32, env)
>  DEF_HELPER_3(lvebx, void, env, avr, tl)
>  DEF_HELPER_3(lvehx, void, env, avr, tl)
>  DEF_HELPER_3(lvewx, void, env, avr, tl)
> diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
> index c272d0d3d4..f753798789 100644
> --- a/target/ppc/arch_dump.c
> +++ b/target/ppc/arch_dump.c
> @@ -17,6 +17,7 @@
>  #include "elf.h"
>  #include "sysemu/dump.h"
>  #include "sysemu/kvm.h"
> +#include "exec/helper-proto.h"
> =20
>  #ifdef TARGET_PPC64
>  #define ELFCLASS ELFCLASS64
> @@ -173,7 +174,7 @@ static void ppc_write_elf_vmxregset(NoteFuncArg *arg,=
 PowerPCCPU *cpu)
>              vmxregset->avr[i].u64[1] =3D cpu->env.vsr[32 + i].u64[1];
>          }
>      }
> -    vmxregset->vscr.u32[3] =3D cpu_to_dump32(s, cpu->env.vscr);
> +    vmxregset->vscr.u32[3] =3D cpu_to_dump32(s, helper_mfvscr(&cpu->env)=
);
>  }
> =20
>  static void ppc_write_elf_vsxregset(NoteFuncArg *arg, PowerPCCPU *cpu)
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index 0443f33cd2..75201bbba6 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -475,6 +475,11 @@ void helper_mtvscr(CPUPPCState *env, uint32_t vscr)
>      set_flush_to_zero((vscr >> VSCR_NJ) & 1, &env->vec_status);
>  }
> =20
> +uint32_t helper_mfvscr(CPUPPCState *env)
> +{
> +    return env->vscr;
> +}
> +
>  void helper_vaddcuw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
>  {
>      int i;
> diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
> index ab6da3aa55..1c0c461241 100644
> --- a/target/ppc/translate/vmx-impl.inc.c
> +++ b/target/ppc/translate/vmx-impl.inc.c
> @@ -187,7 +187,7 @@ static void gen_mfvscr(DisasContext *ctx)
>      tcg_gen_movi_i64(avr, 0);
>      set_avr64(rD(ctx->opcode), avr, true);
>      t =3D tcg_temp_new_i32();
> -    tcg_gen_ld_i32(t, cpu_env, offsetof(CPUPPCState, vscr));
> +    gen_helper_mfvscr(t, cpu_env);
>      tcg_gen_extu_i32_i64(avr, t);
>      set_avr64(rD(ctx->opcode), avr, false);
>      tcg_temp_free_i32(t);
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 292b1df700..353285c6bd 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -9527,7 +9527,7 @@ static int gdb_get_avr_reg(CPUPPCState *env, uint8_=
t *mem_buf, int n)
>          return 16;
>      }
>      if (n =3D=3D 32) {
> -        stl_p(mem_buf, env->vscr);
> +        stl_p(mem_buf, helper_mfvscr(env));
>          ppc_maybe_bswap_register(env, mem_buf, 4);
>          return 4;
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--npbjE3dh3wBH6WIP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwZ56sACgkQbDjKyiDZ
s5LpyBAAhkWTJVbRjllywZRa8WxKWRAtaBhSiOw4RqNQ48ycFXLggQgbogist6k4
sFfI6YNe4z347WJLApAdYGliwB530QkgVsNZ3qFnp7QwQ+L6qbpGhoDIs/D/xbfV
yxmY0lwQ1NwjQdiNTpxLTAPQV0F/Te8rX500+cTuU5qwOXrbcL1vCirKZ7StDBMs
OHP/Ckfym28VDIqKDWnk7u+/QA8addQOsE5ETcJJYTojzRnyWhAfmS/o2ccLSA+E
538sGJb1Ms+rLixq4sdN92LmJ8EHBHfnPNBgmhLTiNUBELNP5zR1eZhfALEc0Yu4
491YyVRsPHoCEUtgpaw8N1ocOL+rEFQZPfrj7cDoB99Vm8flZPjrkqmL3rVt2lh8
KvLJWus2AfBmviA0FZlkQjVqXXpAJLOcMumvxKZ3JIXj5eAs7LZxPz2LMeIeq/4r
F7auMBNG0ER/z4Db0sNMFJL65a2xyZvh67LfVlXn0I2YZsxlbrWzV3UZQAL2rQGz
fALW8vaOHJVll92OG1bgRoVf7EsUkA5sMGb7nYSmrmP6QZXslzGapCDQUhxLAGrh
dW45Fq484rrMKVb38onbrGOD5jspPKLysS5nSSrxpzLv9bOp+3Ml0l2H00qx1VMf
ocK8apqnbFz4lMhY7vwjHMMRe8ZVv5Ge/vKxl9hRbIJibvnXtpw=
=N6om
-----END PGP SIGNATURE-----

--npbjE3dh3wBH6WIP--
