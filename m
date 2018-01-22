Received: from eggs.gnu.org ([2001:4830:134:3::10]:47853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1edZ2M-0001gJ-FX
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 05:09:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1edZ2H-0004dU-Dt
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 05:09:10 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:42985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1edZ2H-0004ce-1N
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 05:09:05 -0500
Received: by mail-wr0-x243.google.com with SMTP id e41so7953593wre.9
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 02:09:04 -0800 (PST)
References: <20180119045438.28582-1-richard.henderson@linaro.org>
	<20180119045438.28582-3-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180119045438.28582-3-richard.henderson@linaro.org>
Date: Mon, 22 Jan 2018 10:09:01 +0000
Message-ID: <877esakxxe.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/16] target/arm: Use pointers in
 crypto helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Rather than passing regnos to the helpers, pass pointers to the
> vector registers directly.  This eliminates the need to pass in
> the environment pointer and reduces the number of places that
> directly access env->vfp.regs[].
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.h        |  18 ++---
>  target/arm/crypto_helper.c | 184 +++++++++++++++++----------------------=
------
>  target/arm/translate-a64.c |  75 ++++++++++--------
>  target/arm/translate.c     |  68 +++++++++--------
>  4 files changed, 161 insertions(+), 184 deletions(-)
>
> diff --git a/target/arm/helper.h b/target/arm/helper.h
> index 066729e8ad..688380af6b 100644
> --- a/target/arm/helper.h
> +++ b/target/arm/helper.h
> @@ -522,17 +522,17 @@ DEF_HELPER_3(neon_qzip8, void, env, i32, i32)
>  DEF_HELPER_3(neon_qzip16, void, env, i32, i32)
>  DEF_HELPER_3(neon_qzip32, void, env, i32, i32)
>
> -DEF_HELPER_4(crypto_aese, void, env, i32, i32, i32)
> -DEF_HELPER_4(crypto_aesmc, void, env, i32, i32, i32)
> +DEF_HELPER_FLAGS_3(crypto_aese, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_3(crypto_aesmc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
>
> -DEF_HELPER_5(crypto_sha1_3reg, void, env, i32, i32, i32, i32)
> -DEF_HELPER_3(crypto_sha1h, void, env, i32, i32)
> -DEF_HELPER_3(crypto_sha1su1, void, env, i32, i32)
> +DEF_HELPER_FLAGS_4(crypto_sha1_3reg, TCG_CALL_NO_RWG, void, ptr, ptr, pt=
r, i32)
> +DEF_HELPER_FLAGS_2(crypto_sha1h, TCG_CALL_NO_RWG, void, ptr, ptr)
> +DEF_HELPER_FLAGS_2(crypto_sha1su1, TCG_CALL_NO_RWG, void, ptr, ptr)
>
> -DEF_HELPER_4(crypto_sha256h, void, env, i32, i32, i32)
> -DEF_HELPER_4(crypto_sha256h2, void, env, i32, i32, i32)
> -DEF_HELPER_3(crypto_sha256su0, void, env, i32, i32)
> -DEF_HELPER_4(crypto_sha256su1, void, env, i32, i32, i32)
> +DEF_HELPER_FLAGS_3(crypto_sha256h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
> +DEF_HELPER_FLAGS_3(crypto_sha256h2, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
> +DEF_HELPER_FLAGS_2(crypto_sha256su0, TCG_CALL_NO_RWG, void, ptr, ptr)
> +DEF_HELPER_FLAGS_3(crypto_sha256su1, TCG_CALL_NO_RWG, void, ptr, ptr, pt=
r)
>
>  DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
>  DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
> diff --git a/target/arm/crypto_helper.c b/target/arm/crypto_helper.c
> index 3b6df3f41a..9ca0bdead7 100644
> --- a/target/arm/crypto_helper.c
> +++ b/target/arm/crypto_helper.c
> @@ -30,20 +30,14 @@ union CRYPTO_STATE {
>  #define CR_ST_WORD(state, i)   (state.words[i])
>  #endif
>
> -void HELPER(crypto_aese)(CPUARMState *env, uint32_t rd, uint32_t rm,
> -                         uint32_t decrypt)
> +void HELPER(crypto_aese)(void *vd, void *vm, uint32_t decrypt)
>  {
>      static uint8_t const * const sbox[2] =3D { AES_sbox, AES_isbox };
>      static uint8_t const * const shift[2] =3D { AES_shifts, AES_ishifts =
};
> -
> -    union CRYPTO_STATE rk =3D { .l =3D {
> -        float64_val(env->vfp.regs[rm]),
> -        float64_val(env->vfp.regs[rm + 1])
> -    } };
> -    union CRYPTO_STATE st =3D { .l =3D {
> -        float64_val(env->vfp.regs[rd]),
> -        float64_val(env->vfp.regs[rd + 1])
> -    } };
> +    uint64_t *rd =3D vd;
> +    uint64_t *rm =3D vm;
> +    union CRYPTO_STATE rk =3D { .l =3D { rm[0], rm[1] } };
> +    union CRYPTO_STATE st =3D { .l =3D { rd[0], rd[1] } };
>      int i;
>
>      assert(decrypt < 2);
> @@ -57,12 +51,11 @@ void HELPER(crypto_aese)(CPUARMState *env, uint32_t r=
d, uint32_t rm,
>          CR_ST_BYTE(st, i) =3D sbox[decrypt][CR_ST_BYTE(rk, shift[decrypt=
][i])];
>      }
>
> -    env->vfp.regs[rd] =3D make_float64(st.l[0]);
> -    env->vfp.regs[rd + 1] =3D make_float64(st.l[1]);
> +    rd[0] =3D st.l[0];
> +    rd[1] =3D st.l[1];
>  }
>
> -void HELPER(crypto_aesmc)(CPUARMState *env, uint32_t rd, uint32_t rm,
> -                          uint32_t decrypt)
> +void HELPER(crypto_aesmc)(void *vd, void *vm, uint32_t decrypt)
>  {
>      static uint32_t const mc[][256] =3D { {
>          /* MixColumns lookup table */
> @@ -197,10 +190,10 @@ void HELPER(crypto_aesmc)(CPUARMState *env, uint32_=
t rd, uint32_t rm,
>          0x92b479a7, 0x99b970a9, 0x84ae6bbb, 0x8fa362b5,
>          0xbe805d9f, 0xb58d5491, 0xa89a4f83, 0xa397468d,
>      } };
> -    union CRYPTO_STATE st =3D { .l =3D {
> -        float64_val(env->vfp.regs[rm]),
> -        float64_val(env->vfp.regs[rm + 1])
> -    } };
> +
> +    uint64_t *rd =3D vd;
> +    uint64_t *rm =3D vm;
> +    union CRYPTO_STATE st =3D { .l =3D { rm[0], rm[1] } };
>      int i;
>
>      assert(decrypt < 2);
> @@ -213,8 +206,8 @@ void HELPER(crypto_aesmc)(CPUARMState *env, uint32_t =
rd, uint32_t rm,
>              rol32(mc[decrypt][CR_ST_BYTE(st, i + 3)], 24);
>      }
>
> -    env->vfp.regs[rd] =3D make_float64(st.l[0]);
> -    env->vfp.regs[rd + 1] =3D make_float64(st.l[1]);
> +    rd[0] =3D st.l[0];
> +    rd[1] =3D st.l[1];
>  }
>
>  /*
> @@ -236,21 +229,14 @@ static uint32_t maj(uint32_t x, uint32_t y, uint32_=
t z)
>      return (x & y) | ((x | y) & z);
>  }
>
> -void HELPER(crypto_sha1_3reg)(CPUARMState *env, uint32_t rd, uint32_t rn,
> -                              uint32_t rm, uint32_t op)
> +void HELPER(crypto_sha1_3reg)(void *vd, void *vn, void *vm, uint32_t op)
>  {
> -    union CRYPTO_STATE d =3D { .l =3D {
> -        float64_val(env->vfp.regs[rd]),
> -        float64_val(env->vfp.regs[rd + 1])
> -    } };
> -    union CRYPTO_STATE n =3D { .l =3D {
> -        float64_val(env->vfp.regs[rn]),
> -        float64_val(env->vfp.regs[rn + 1])
> -    } };
> -    union CRYPTO_STATE m =3D { .l =3D {
> -        float64_val(env->vfp.regs[rm]),
> -        float64_val(env->vfp.regs[rm + 1])
> -    } };
> +    uint64_t *rd =3D vd;
> +    uint64_t *rn =3D vn;
> +    uint64_t *rm =3D vm;
> +    union CRYPTO_STATE d =3D { .l =3D { rd[0], rd[1] } };
> +    union CRYPTO_STATE n =3D { .l =3D { rn[0], rn[1] } };
> +    union CRYPTO_STATE m =3D { .l =3D { rm[0], rm[1] } };
>
>      if (op =3D=3D 3) { /* sha1su0 */
>          d.l[0] ^=3D d.l[1] ^ m.l[0];
> @@ -284,42 +270,37 @@ void HELPER(crypto_sha1_3reg)(CPUARMState *env, uin=
t32_t rd, uint32_t rn,
>              CR_ST_WORD(d, 0) =3D t;
>          }
>      }
> -    env->vfp.regs[rd] =3D make_float64(d.l[0]);
> -    env->vfp.regs[rd + 1] =3D make_float64(d.l[1]);
> +    rd[0] =3D d.l[0];
> +    rd[1] =3D d.l[1];
>  }
>
> -void HELPER(crypto_sha1h)(CPUARMState *env, uint32_t rd, uint32_t rm)
> +void HELPER(crypto_sha1h)(void *vd, void *vm)
>  {
> -    union CRYPTO_STATE m =3D { .l =3D {
> -        float64_val(env->vfp.regs[rm]),
> -        float64_val(env->vfp.regs[rm + 1])
> -    } };
> +    uint64_t *rd =3D vd;
> +    uint64_t *rm =3D vm;
> +    union CRYPTO_STATE m =3D { .l =3D { rm[0], rm[1] } };
>
>      CR_ST_WORD(m, 0) =3D ror32(CR_ST_WORD(m, 0), 2);
>      CR_ST_WORD(m, 1) =3D CR_ST_WORD(m, 2) =3D CR_ST_WORD(m, 3) =3D 0;
>
> -    env->vfp.regs[rd] =3D make_float64(m.l[0]);
> -    env->vfp.regs[rd + 1] =3D make_float64(m.l[1]);
> +    rd[0] =3D m.l[0];
> +    rd[1] =3D m.l[1];
>  }
>
> -void HELPER(crypto_sha1su1)(CPUARMState *env, uint32_t rd, uint32_t rm)
> +void HELPER(crypto_sha1su1)(void *vd, void *vm)
>  {
> -    union CRYPTO_STATE d =3D { .l =3D {
> -        float64_val(env->vfp.regs[rd]),
> -        float64_val(env->vfp.regs[rd + 1])
> -    } };
> -    union CRYPTO_STATE m =3D { .l =3D {
> -        float64_val(env->vfp.regs[rm]),
> -        float64_val(env->vfp.regs[rm + 1])
> -    } };
> +    uint64_t *rd =3D vd;
> +    uint64_t *rm =3D vm;
> +    union CRYPTO_STATE d =3D { .l =3D { rd[0], rd[1] } };
> +    union CRYPTO_STATE m =3D { .l =3D { rm[0], rm[1] } };
>
>      CR_ST_WORD(d, 0) =3D rol32(CR_ST_WORD(d, 0) ^ CR_ST_WORD(m, 1), 1);
>      CR_ST_WORD(d, 1) =3D rol32(CR_ST_WORD(d, 1) ^ CR_ST_WORD(m, 2), 1);
>      CR_ST_WORD(d, 2) =3D rol32(CR_ST_WORD(d, 2) ^ CR_ST_WORD(m, 3), 1);
>      CR_ST_WORD(d, 3) =3D rol32(CR_ST_WORD(d, 3) ^ CR_ST_WORD(d, 0), 1);
>
> -    env->vfp.regs[rd] =3D make_float64(d.l[0]);
> -    env->vfp.regs[rd + 1] =3D make_float64(d.l[1]);
> +    rd[0] =3D d.l[0];
> +    rd[1] =3D d.l[1];
>  }
>
>  /*
> @@ -347,21 +328,14 @@ static uint32_t s1(uint32_t x)
>      return ror32(x, 17) ^ ror32(x, 19) ^ (x >> 10);
>  }
>
> -void HELPER(crypto_sha256h)(CPUARMState *env, uint32_t rd, uint32_t rn,
> -                            uint32_t rm)
> +void HELPER(crypto_sha256h)(void *vd, void *vn, void *vm)
>  {
> -    union CRYPTO_STATE d =3D { .l =3D {
> -        float64_val(env->vfp.regs[rd]),
> -        float64_val(env->vfp.regs[rd + 1])
> -    } };
> -    union CRYPTO_STATE n =3D { .l =3D {
> -        float64_val(env->vfp.regs[rn]),
> -        float64_val(env->vfp.regs[rn + 1])
> -    } };
> -    union CRYPTO_STATE m =3D { .l =3D {
> -        float64_val(env->vfp.regs[rm]),
> -        float64_val(env->vfp.regs[rm + 1])
> -    } };
> +    uint64_t *rd =3D vd;
> +    uint64_t *rn =3D vn;
> +    uint64_t *rm =3D vm;
> +    union CRYPTO_STATE d =3D { .l =3D { rd[0], rd[1] } };
> +    union CRYPTO_STATE n =3D { .l =3D { rn[0], rn[1] } };
> +    union CRYPTO_STATE m =3D { .l =3D { rm[0], rm[1] } };
>      int i;
>
>      for (i =3D 0; i < 4; i++) {
> @@ -383,25 +357,18 @@ void HELPER(crypto_sha256h)(CPUARMState *env, uint3=
2_t rd, uint32_t rn,
>          CR_ST_WORD(d, 0) =3D t;
>      }
>
> -    env->vfp.regs[rd] =3D make_float64(d.l[0]);
> -    env->vfp.regs[rd + 1] =3D make_float64(d.l[1]);
> +    rd[0] =3D d.l[0];
> +    rd[1] =3D d.l[1];
>  }
>
> -void HELPER(crypto_sha256h2)(CPUARMState *env, uint32_t rd, uint32_t rn,
> -                             uint32_t rm)
> +void HELPER(crypto_sha256h2)(void *vd, void *vn, void *vm)
>  {
> -    union CRYPTO_STATE d =3D { .l =3D {
> -        float64_val(env->vfp.regs[rd]),
> -        float64_val(env->vfp.regs[rd + 1])
> -    } };
> -    union CRYPTO_STATE n =3D { .l =3D {
> -        float64_val(env->vfp.regs[rn]),
> -        float64_val(env->vfp.regs[rn + 1])
> -    } };
> -    union CRYPTO_STATE m =3D { .l =3D {
> -        float64_val(env->vfp.regs[rm]),
> -        float64_val(env->vfp.regs[rm + 1])
> -    } };
> +    uint64_t *rd =3D vd;
> +    uint64_t *rn =3D vn;
> +    uint64_t *rm =3D vm;
> +    union CRYPTO_STATE d =3D { .l =3D { rd[0], rd[1] } };
> +    union CRYPTO_STATE n =3D { .l =3D { rn[0], rn[1] } };
> +    union CRYPTO_STATE m =3D { .l =3D { rm[0], rm[1] } };
>      int i;
>
>      for (i =3D 0; i < 4; i++) {
> @@ -415,51 +382,40 @@ void HELPER(crypto_sha256h2)(CPUARMState *env, uint=
32_t rd, uint32_t rn,
>          CR_ST_WORD(d, 0) =3D CR_ST_WORD(n, 3 - i) + t;
>      }
>
> -    env->vfp.regs[rd] =3D make_float64(d.l[0]);
> -    env->vfp.regs[rd + 1] =3D make_float64(d.l[1]);
> +    rd[0] =3D d.l[0];
> +    rd[1] =3D d.l[1];
>  }
>
> -void HELPER(crypto_sha256su0)(CPUARMState *env, uint32_t rd, uint32_t rm)
> +void HELPER(crypto_sha256su0)(void *vd, void *vm)
>  {
> -    union CRYPTO_STATE d =3D { .l =3D {
> -        float64_val(env->vfp.regs[rd]),
> -        float64_val(env->vfp.regs[rd + 1])
> -    } };
> -    union CRYPTO_STATE m =3D { .l =3D {
> -        float64_val(env->vfp.regs[rm]),
> -        float64_val(env->vfp.regs[rm + 1])
> -    } };
> +    uint64_t *rd =3D vd;
> +    uint64_t *rm =3D vm;
> +    union CRYPTO_STATE d =3D { .l =3D { rd[0], rd[1] } };
> +    union CRYPTO_STATE m =3D { .l =3D { rm[0], rm[1] } };
>
>      CR_ST_WORD(d, 0) +=3D s0(CR_ST_WORD(d, 1));
>      CR_ST_WORD(d, 1) +=3D s0(CR_ST_WORD(d, 2));
>      CR_ST_WORD(d, 2) +=3D s0(CR_ST_WORD(d, 3));
>      CR_ST_WORD(d, 3) +=3D s0(CR_ST_WORD(m, 0));
>
> -    env->vfp.regs[rd] =3D make_float64(d.l[0]);
> -    env->vfp.regs[rd + 1] =3D make_float64(d.l[1]);
> +    rd[0] =3D d.l[0];
> +    rd[1] =3D d.l[1];
>  }
>
> -void HELPER(crypto_sha256su1)(CPUARMState *env, uint32_t rd, uint32_t rn,
> -                              uint32_t rm)
> +void HELPER(crypto_sha256su1)(void *vd, void *vn, void *vm)
>  {
> -    union CRYPTO_STATE d =3D { .l =3D {
> -        float64_val(env->vfp.regs[rd]),
> -        float64_val(env->vfp.regs[rd + 1])
> -    } };
> -    union CRYPTO_STATE n =3D { .l =3D {
> -        float64_val(env->vfp.regs[rn]),
> -        float64_val(env->vfp.regs[rn + 1])
> -    } };
> -    union CRYPTO_STATE m =3D { .l =3D {
> -        float64_val(env->vfp.regs[rm]),
> -        float64_val(env->vfp.regs[rm + 1])
> -    } };
> +    uint64_t *rd =3D vd;
> +    uint64_t *rn =3D vn;
> +    uint64_t *rm =3D vm;
> +    union CRYPTO_STATE d =3D { .l =3D { rd[0], rd[1] } };
> +    union CRYPTO_STATE n =3D { .l =3D { rn[0], rn[1] } };
> +    union CRYPTO_STATE m =3D { .l =3D { rm[0], rm[1] } };
>
>      CR_ST_WORD(d, 0) +=3D s1(CR_ST_WORD(m, 2)) + CR_ST_WORD(n, 1);
>      CR_ST_WORD(d, 1) +=3D s1(CR_ST_WORD(m, 3)) + CR_ST_WORD(n, 2);
>      CR_ST_WORD(d, 2) +=3D s1(CR_ST_WORD(d, 0)) + CR_ST_WORD(n, 3);
>      CR_ST_WORD(d, 3) +=3D s1(CR_ST_WORD(d, 1)) + CR_ST_WORD(m, 0);
>
> -    env->vfp.regs[rd] =3D make_float64(d.l[0]);
> -    env->vfp.regs[rd + 1] =3D make_float64(d.l[1]);
> +    rd[0] =3D d.l[0];
> +    rd[1] =3D d.l[1];
>  }
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 70c1e08a36..6d9b3af64c 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -80,8 +80,9 @@ typedef void NeonGenWidenFn(TCGv_i64, TCGv_i32);
>  typedef void NeonGenTwoSingleOPFn(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_ptr=
);
>  typedef void NeonGenTwoDoubleOPFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_ptr=
);
>  typedef void NeonGenOneOpFn(TCGv_i64, TCGv_i64);
> -typedef void CryptoTwoOpEnvFn(TCGv_ptr, TCGv_i32, TCGv_i32);
> -typedef void CryptoThreeOpEnvFn(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32);
> +typedef void CryptoTwoOpFn(TCGv_ptr, TCGv_ptr);
> +typedef void CryptoThreeOpIntFn(TCGv_ptr, TCGv_ptr, TCGv_i32);
> +typedef void CryptoThreeOpFn(TCGv_ptr, TCGv_ptr, TCGv_ptr);
>
>  /* initialize TCG globals.  */
>  void a64_translate_init(void)
> @@ -535,6 +536,21 @@ static inline int vec_reg_offset(DisasContext *s, in=
t regno,
>      return offs;
>  }
>
> +/* Return the offset info CPUARMState of the "whole" vector register Qn.=
  */
> +static inline int vec_full_reg_offset(DisasContext *s, int regno)
> +{
> +    assert_fp_access_checked(s);
> +    return offsetof(CPUARMState, vfp.regs[regno * 2]);
> +}
> +
> +/* Return a newly allocated pointer to the vector register.  */
> +static TCGv_ptr vec_full_reg_ptr(DisasContext *s, int regno)
> +{
> +    TCGv_ptr ret =3D tcg_temp_new_ptr();
> +    tcg_gen_addi_ptr(ret, cpu_env, vec_full_reg_offset(s, regno));
> +    return ret;
> +}
> +
>  /* Return the offset into CPUARMState of a slice (from
>   * the least significant end) of FP register Qn (ie
>   * Dn, Sn, Hn or Bn).
> @@ -10949,8 +10965,9 @@ static void disas_crypto_aes(DisasContext *s, uin=
t32_t insn)
>      int rn =3D extract32(insn, 5, 5);
>      int rd =3D extract32(insn, 0, 5);
>      int decrypt;
> -    TCGv_i32 tcg_rd_regno, tcg_rn_regno, tcg_decrypt;
> -    CryptoThreeOpEnvFn *genfn;
> +    TCGv_ptr tcg_rd_ptr, tcg_rn_ptr;
> +    TCGv_i32 tcg_decrypt;
> +    CryptoThreeOpIntFn *genfn;
>
>      if (!arm_dc_feature(s, ARM_FEATURE_V8_AES)
>          || size !=3D 0) {
> @@ -10984,18 +11001,14 @@ static void disas_crypto_aes(DisasContext *s, u=
int32_t insn)
>          return;
>      }
>
> -    /* Note that we convert the Vx register indexes into the
> -     * index within the vfp.regs[] array, so we can share the
> -     * helper with the AArch32 instructions.
> -     */
> -    tcg_rd_regno =3D tcg_const_i32(rd << 1);
> -    tcg_rn_regno =3D tcg_const_i32(rn << 1);
> +    tcg_rd_ptr =3D vec_full_reg_ptr(s, rd);
> +    tcg_rn_ptr =3D vec_full_reg_ptr(s, rn);
>      tcg_decrypt =3D tcg_const_i32(decrypt);
>
> -    genfn(cpu_env, tcg_rd_regno, tcg_rn_regno, tcg_decrypt);
> +    genfn(tcg_rd_ptr, tcg_rn_ptr, tcg_decrypt);
>
> -    tcg_temp_free_i32(tcg_rd_regno);
> -    tcg_temp_free_i32(tcg_rn_regno);
> +    tcg_temp_free_ptr(tcg_rd_ptr);
> +    tcg_temp_free_ptr(tcg_rn_ptr);
>      tcg_temp_free_i32(tcg_decrypt);
>  }
>
> @@ -11012,8 +11025,8 @@ static void disas_crypto_three_reg_sha(DisasConte=
xt *s, uint32_t insn)
>      int rm =3D extract32(insn, 16, 5);
>      int rn =3D extract32(insn, 5, 5);
>      int rd =3D extract32(insn, 0, 5);
> -    CryptoThreeOpEnvFn *genfn;
> -    TCGv_i32 tcg_rd_regno, tcg_rn_regno, tcg_rm_regno;
> +    CryptoThreeOpFn *genfn;
> +    TCGv_ptr tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr;
>      int feature =3D ARM_FEATURE_V8_SHA256;
>
>      if (size !=3D 0) {
> @@ -11052,23 +11065,23 @@ static void disas_crypto_three_reg_sha(DisasCon=
text *s, uint32_t insn)
>          return;
>      }
>
> -    tcg_rd_regno =3D tcg_const_i32(rd << 1);
> -    tcg_rn_regno =3D tcg_const_i32(rn << 1);
> -    tcg_rm_regno =3D tcg_const_i32(rm << 1);
> +    tcg_rd_ptr =3D vec_full_reg_ptr(s, rd);
> +    tcg_rn_ptr =3D vec_full_reg_ptr(s, rn);
> +    tcg_rm_ptr =3D vec_full_reg_ptr(s, rm);
>
>      if (genfn) {
> -        genfn(cpu_env, tcg_rd_regno, tcg_rn_regno, tcg_rm_regno);
> +        genfn(tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr);
>      } else {
>          TCGv_i32 tcg_opcode =3D tcg_const_i32(opcode);
>
> -        gen_helper_crypto_sha1_3reg(cpu_env, tcg_rd_regno,
> -                                    tcg_rn_regno, tcg_rm_regno, tcg_opco=
de);
> +        gen_helper_crypto_sha1_3reg(tcg_rd_ptr, tcg_rn_ptr,
> +                                    tcg_rm_ptr, tcg_opcode);
>          tcg_temp_free_i32(tcg_opcode);
>      }
>
> -    tcg_temp_free_i32(tcg_rd_regno);
> -    tcg_temp_free_i32(tcg_rn_regno);
> -    tcg_temp_free_i32(tcg_rm_regno);
> +    tcg_temp_free_ptr(tcg_rd_ptr);
> +    tcg_temp_free_ptr(tcg_rn_ptr);
> +    tcg_temp_free_ptr(tcg_rm_ptr);
>  }
>
>  /* Crypto two-reg SHA
> @@ -11083,9 +11096,9 @@ static void disas_crypto_two_reg_sha(DisasContext=
 *s, uint32_t insn)
>      int opcode =3D extract32(insn, 12, 5);
>      int rn =3D extract32(insn, 5, 5);
>      int rd =3D extract32(insn, 0, 5);
> -    CryptoTwoOpEnvFn *genfn;
> +    CryptoTwoOpFn *genfn;
>      int feature;
> -    TCGv_i32 tcg_rd_regno, tcg_rn_regno;
> +    TCGv_ptr tcg_rd_ptr, tcg_rn_ptr;
>
>      if (size !=3D 0) {
>          unallocated_encoding(s);
> @@ -11119,13 +11132,13 @@ static void disas_crypto_two_reg_sha(DisasConte=
xt *s, uint32_t insn)
>          return;
>      }
>
> -    tcg_rd_regno =3D tcg_const_i32(rd << 1);
> -    tcg_rn_regno =3D tcg_const_i32(rn << 1);
> +    tcg_rd_ptr =3D vec_full_reg_ptr(s, rd);
> +    tcg_rn_ptr =3D vec_full_reg_ptr(s, rn);
>
> -    genfn(cpu_env, tcg_rd_regno, tcg_rn_regno);
> +    genfn(tcg_rd_ptr, tcg_rn_ptr);
>
> -    tcg_temp_free_i32(tcg_rd_regno);
> -    tcg_temp_free_i32(tcg_rn_regno);
> +    tcg_temp_free_ptr(tcg_rd_ptr);
> +    tcg_temp_free_ptr(tcg_rn_ptr);
>  }
>
>  /* C3.6 Data processing - SIMD, inc Crypto
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 781be1e219..7b5db15861 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -1559,6 +1559,13 @@ static inline void neon_store_reg64(TCGv_i64 var, =
int reg)
>      tcg_gen_st_i64(var, cpu_env, vfp_reg_offset(1, reg));
>  }
>
> +static TCGv_ptr vfp_reg_ptr(bool dp, int reg)
> +{
> +    TCGv_ptr ret =3D tcg_temp_new_ptr();
> +    tcg_gen_addi_ptr(ret, cpu_env, vfp_reg_offset(dp, reg));
> +    return ret;
> +}
> +
>  #define tcg_gen_ld_f32 tcg_gen_ld_i32
>  #define tcg_gen_ld_f64 tcg_gen_ld_i64
>  #define tcg_gen_st_f32 tcg_gen_st_i32
> @@ -5597,6 +5604,7 @@ static int disas_neon_data_insn(DisasContext *s, ui=
nt32_t insn)
>      int u;
>      uint32_t imm, mask;
>      TCGv_i32 tmp, tmp2, tmp3, tmp4, tmp5;
> +    TCGv_ptr ptr1, ptr2, ptr3;
>      TCGv_i64 tmp64;
>
>      /* FIXME: this access check should not take precedence over UNDEF
> @@ -5643,34 +5651,34 @@ static int disas_neon_data_insn(DisasContext *s, =
uint32_t insn)
>                  if (!arm_dc_feature(s, ARM_FEATURE_V8_SHA1)) {
>                      return 1;
>                  }
> -                tmp =3D tcg_const_i32(rd);
> -                tmp2 =3D tcg_const_i32(rn);
> -                tmp3 =3D tcg_const_i32(rm);
> +                ptr1 =3D vfp_reg_ptr(true, rd);
> +                ptr2 =3D vfp_reg_ptr(true, rn);
> +                ptr3 =3D vfp_reg_ptr(true, rm);
>                  tmp4 =3D tcg_const_i32(size);
> -                gen_helper_crypto_sha1_3reg(cpu_env, tmp, tmp2, tmp3, tm=
p4);
> +                gen_helper_crypto_sha1_3reg(ptr1, ptr2, ptr3, tmp4);
>                  tcg_temp_free_i32(tmp4);
>              } else { /* SHA-256 */
>                  if (!arm_dc_feature(s, ARM_FEATURE_V8_SHA256) || size =
=3D=3D 3) {
>                      return 1;
>                  }
> -                tmp =3D tcg_const_i32(rd);
> -                tmp2 =3D tcg_const_i32(rn);
> -                tmp3 =3D tcg_const_i32(rm);
> +                ptr1 =3D vfp_reg_ptr(true, rd);
> +                ptr2 =3D vfp_reg_ptr(true, rn);
> +                ptr3 =3D vfp_reg_ptr(true, rm);
>                  switch (size) {
>                  case 0:
> -                    gen_helper_crypto_sha256h(cpu_env, tmp, tmp2, tmp3);
> +                    gen_helper_crypto_sha256h(ptr1, ptr2, ptr3);
>                      break;
>                  case 1:
> -                    gen_helper_crypto_sha256h2(cpu_env, tmp, tmp2, tmp3);
> +                    gen_helper_crypto_sha256h2(ptr1, ptr2, ptr3);
>                      break;
>                  case 2:
> -                    gen_helper_crypto_sha256su1(cpu_env, tmp, tmp2, tmp3=
);
> +                    gen_helper_crypto_sha256su1(ptr1, ptr2, ptr3);
>                      break;
>                  }
>              }
> -            tcg_temp_free_i32(tmp);
> -            tcg_temp_free_i32(tmp2);
> -            tcg_temp_free_i32(tmp3);
> +            tcg_temp_free_ptr(ptr1);
> +            tcg_temp_free_ptr(ptr2);
> +            tcg_temp_free_ptr(ptr3);
>              return 0;
>          }
>          if (size =3D=3D 3 && op !=3D NEON_3R_LOGIC) {
> @@ -7159,8 +7167,8 @@ static int disas_neon_data_insn(DisasContext *s, ui=
nt32_t insn)
>                          || ((rm | rd) & 1)) {
>                          return 1;
>                      }
> -                    tmp =3D tcg_const_i32(rd);
> -                    tmp2 =3D tcg_const_i32(rm);
> +                    ptr1 =3D vfp_reg_ptr(true, rd);
> +                    ptr2 =3D vfp_reg_ptr(true, rm);
>
>                       /* Bit 6 is the lowest opcode bit; it distinguishes=
 between
>                        * encryption (AESE/AESMC) and decryption (AESD/AES=
IMC)
> @@ -7168,12 +7176,12 @@ static int disas_neon_data_insn(DisasContext *s, =
uint32_t insn)
>                      tmp3 =3D tcg_const_i32(extract32(insn, 6, 1));
>
>                      if (op =3D=3D NEON_2RM_AESE) {
> -                        gen_helper_crypto_aese(cpu_env, tmp, tmp2, tmp3);
> +                        gen_helper_crypto_aese(ptr1, ptr2, tmp3);
>                      } else {
> -                        gen_helper_crypto_aesmc(cpu_env, tmp, tmp2, tmp3=
);
> +                        gen_helper_crypto_aesmc(ptr1, ptr2, tmp3);
>                      }
> -                    tcg_temp_free_i32(tmp);
> -                    tcg_temp_free_i32(tmp2);
> +                    tcg_temp_free_ptr(ptr1);
> +                    tcg_temp_free_ptr(ptr2);
>                      tcg_temp_free_i32(tmp3);
>                      break;
>                  case NEON_2RM_SHA1H:
> @@ -7181,13 +7189,13 @@ static int disas_neon_data_insn(DisasContext *s, =
uint32_t insn)
>                          || ((rm | rd) & 1)) {
>                          return 1;
>                      }
> -                    tmp =3D tcg_const_i32(rd);
> -                    tmp2 =3D tcg_const_i32(rm);
> +                    ptr1 =3D vfp_reg_ptr(true, rd);
> +                    ptr2 =3D vfp_reg_ptr(true, rm);
>
> -                    gen_helper_crypto_sha1h(cpu_env, tmp, tmp2);
> +                    gen_helper_crypto_sha1h(ptr1, ptr2);
>
> -                    tcg_temp_free_i32(tmp);
> -                    tcg_temp_free_i32(tmp2);
> +                    tcg_temp_free_ptr(ptr1);
> +                    tcg_temp_free_ptr(ptr2);
>                      break;
>                  case NEON_2RM_SHA1SU1:
>                      if ((rm | rd) & 1) {
> @@ -7201,15 +7209,15 @@ static int disas_neon_data_insn(DisasContext *s, =
uint32_t insn)
>                      } else if (!arm_dc_feature(s, ARM_FEATURE_V8_SHA1)) {
>                          return 1;
>                      }
> -                    tmp =3D tcg_const_i32(rd);
> -                    tmp2 =3D tcg_const_i32(rm);
> +                    ptr1 =3D vfp_reg_ptr(true, rd);
> +                    ptr2 =3D vfp_reg_ptr(true, rm);
>                      if (q) {
> -                        gen_helper_crypto_sha256su0(cpu_env, tmp, tmp2);
> +                        gen_helper_crypto_sha256su0(ptr1, ptr2);
>                      } else {
> -                        gen_helper_crypto_sha1su1(cpu_env, tmp, tmp2);
> +                        gen_helper_crypto_sha1su1(ptr1, ptr2);
>                      }
> -                    tcg_temp_free_i32(tmp);
> -                    tcg_temp_free_i32(tmp2);
> +                    tcg_temp_free_ptr(ptr1);
> +                    tcg_temp_free_ptr(ptr2);
>                      break;
>                  default:
>                  elementwise:


--
Alex Benn=C3=A9e
