Received: from eggs.gnu.org ([2001:4830:134:3::10]:41663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbh-0001wK-QH
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbd-0005n1-P8
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:29 -0500
Date: Wed, 19 Dec 2018 17:20:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181219062018.GJ30570@umbus.fritz.box>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<20181218063911.2112-15-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x0KprKst+ZOYEj2z"
Content-Disposition: inline
In-Reply-To: <20181218063911.2112-15-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 14/34] target/ppc: switch FPR,
 VMX and VSX helpers to access data directly from cpu_env
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


--x0KprKst+ZOYEj2z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 10:38:51PM -0800, Richard Henderson wrote:
> From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>=20
> Instead of accessing the FPR, VMX and VSX registers through static arrays=
 of
> TCGv_i64 globals, remove them and change the helpers to load/store data d=
irectly
> within cpu_env.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> Message-Id: <20181217122405.18732-6-mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/translate.c              | 59 ++++++++---------------------
>  target/ppc/translate/vsx-impl.inc.c |  4 +-
>  2 files changed, 18 insertions(+), 45 deletions(-)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index fa3e8dc114..5923c688cd 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -55,15 +55,9 @@
>  /* global register indexes */
>  static char cpu_reg_names[10*3 + 22*4 /* GPR */
>      + 10*4 + 22*5 /* SPE GPRh */
> -    + 10*4 + 22*5 /* FPR */
> -    + 2*(10*6 + 22*7) /* AVRh, AVRl */
> -    + 10*5 + 22*6 /* VSR */
>      + 8*5 /* CRF */];
>  static TCGv cpu_gpr[32];
>  static TCGv cpu_gprh[32];
> -static TCGv_i64 cpu_fpr[32];
> -static TCGv_i64 cpu_avrh[32], cpu_avrl[32];
> -static TCGv_i64 cpu_vsr[32];
>  static TCGv_i32 cpu_crf[8];
>  static TCGv cpu_nip;
>  static TCGv cpu_msr;
> @@ -108,39 +102,6 @@ void ppc_translate_init(void)
>                                           offsetof(CPUPPCState, gprh[i]),=
 p);
>          p +=3D (i < 10) ? 4 : 5;
>          cpu_reg_names_size -=3D (i < 10) ? 4 : 5;
> -
> -        snprintf(p, cpu_reg_names_size, "fp%d", i);
> -        cpu_fpr[i] =3D tcg_global_mem_new_i64(cpu_env,
> -                                            offsetof(CPUPPCState, fpr[i]=
), p);
> -        p +=3D (i < 10) ? 4 : 5;
> -        cpu_reg_names_size -=3D (i < 10) ? 4 : 5;
> -
> -        snprintf(p, cpu_reg_names_size, "avr%dH", i);
> -#ifdef HOST_WORDS_BIGENDIAN
> -        cpu_avrh[i] =3D tcg_global_mem_new_i64(cpu_env,
> -                                             offsetof(CPUPPCState, avr[i=
].u64[0]), p);
> -#else
> -        cpu_avrh[i] =3D tcg_global_mem_new_i64(cpu_env,
> -                                             offsetof(CPUPPCState, avr[i=
].u64[1]), p);
> -#endif
> -        p +=3D (i < 10) ? 6 : 7;
> -        cpu_reg_names_size -=3D (i < 10) ? 6 : 7;
> -
> -        snprintf(p, cpu_reg_names_size, "avr%dL", i);
> -#ifdef HOST_WORDS_BIGENDIAN
> -        cpu_avrl[i] =3D tcg_global_mem_new_i64(cpu_env,
> -                                             offsetof(CPUPPCState, avr[i=
].u64[1]), p);
> -#else
> -        cpu_avrl[i] =3D tcg_global_mem_new_i64(cpu_env,
> -                                             offsetof(CPUPPCState, avr[i=
].u64[0]), p);
> -#endif
> -        p +=3D (i < 10) ? 6 : 7;
> -        cpu_reg_names_size -=3D (i < 10) ? 6 : 7;
> -        snprintf(p, cpu_reg_names_size, "vsr%d", i);
> -        cpu_vsr[i] =3D tcg_global_mem_new_i64(cpu_env,
> -                                            offsetof(CPUPPCState, vsr[i]=
), p);
> -        p +=3D (i < 10) ? 5 : 6;
> -        cpu_reg_names_size -=3D (i < 10) ? 5 : 6;
>      }
> =20
>      cpu_nip =3D tcg_global_mem_new(cpu_env,
> @@ -6696,22 +6657,34 @@ GEN_TM_PRIV_NOOP(trechkpt);
> =20
>  static inline void get_fpr(TCGv_i64 dst, int regno)
>  {
> -    tcg_gen_mov_i64(dst, cpu_fpr[regno]);
> +    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState, fpr[regno]));
>  }
> =20
>  static inline void set_fpr(int regno, TCGv_i64 src)
>  {
> -    tcg_gen_mov_i64(cpu_fpr[regno], src);
> +    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState, fpr[regno]));
>  }
> =20
>  static inline void get_avr64(TCGv_i64 dst, int regno, bool high)
>  {
> -    tcg_gen_mov_i64(dst, (high ? cpu_avrh : cpu_avrl)[regno]);
> +#ifdef HOST_WORDS_BIGENDIAN
> +    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState,
> +                                          avr[regno].u64[(high ? 0 : 1)]=
));
> +#else
> +    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState,
> +                                          avr[regno].u64[(high ? 1 : 0)]=
));
> +#endif
>  }
> =20
>  static inline void set_avr64(int regno, TCGv_i64 src, bool high)
>  {
> -    tcg_gen_mov_i64((high ? cpu_avrh : cpu_avrl)[regno], src);
> +#ifdef HOST_WORDS_BIGENDIAN
> +    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState,
> +                                          avr[regno].u64[(high ? 0 : 1)]=
));
> +#else
> +    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState,
> +                                          avr[regno].u64[(high ? 1 : 0)]=
));
> +#endif
>  }
> =20
>  #include "translate/fp-impl.inc.c"
> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
> index e9a05d66f7..20e1fd9324 100644
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -2,12 +2,12 @@
> =20
>  static inline void get_vsr(TCGv_i64 dst, int n)
>  {
> -    tcg_gen_mov_i64(dst, cpu_vsr[n]);
> +    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState, vsr[n]));
>  }
> =20
>  static inline void set_vsr(int n, TCGv_i64 src)
>  {
> -    tcg_gen_mov_i64(cpu_vsr[n], src);
> +    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState, vsr[n]));
>  }
> =20
>  static inline void get_cpu_vsrh(TCGv_i64 dst, int n)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--x0KprKst+ZOYEj2z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwZ4yIACgkQbDjKyiDZ
s5Lo3g/+MUw9Sfp2qFZrdPyZvWF11VaA8h8daX54GH/r4uFUd05cdrCxhJfmnCfc
cRwJXiMbbLKXWFXDuncLU9MG8l/HwbJydjVSqylDOZCCafAl3TIz/acMllNIxnXQ
C21/xrTxDbVIOZUDnle+YZyEaIMwTkbtFuhgt++QQJYedGfTVVSxPbfFGi4S2UVa
i7Q4cEpt/kilZZroEa9O2etUhv9YOD+zbgFqG/F0mduUjq/Gpl0nHZhkLIZFW2YA
O7XaWwVew71Vy409Jtxh8xmaVweeDWZf5z8/yjIJPS/dMEnkHLRDEUk55MuIdkSV
i7E2woFUnfNiYewYhyHEMrM2MsrPkXBUFQ+7bLzdc4KJU+rz1Z7T2Lhz7vmt1CNw
hnIznqHMBIqzDm3E5vR6Hyn/IT1XJk5CVjKXGo7jWg2Pt2qMxIDjgSoqTEeNiU5c
mZDFx+t9UUntCZwS+m01lCIQQY9vfE+ZRBkPGB3ftP59ZSIyo0folHn+cvhUo9jr
OJOCgXWA6qdXd2W/dipNc9ZgeisZf5Je1vpHX0o6KHSlLxqxQ8LJCBzin4bdvX5p
wbRYjccTTYkmg7Qf+j3sVn+CLp500BtfJIM5vMTlpGSdNqxGg+kFgBBRMU6TZ8mw
QbZ/dTjBGQwbrn+8ewFgdvcBxIi6JgVOZQxPGIE6a6hleJtSyZE=
=zWSQ
-----END PGP SIGNATURE-----

--x0KprKst+ZOYEj2z--
