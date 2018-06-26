Received: from eggs.gnu.org ([2001:4830:134:3::10]:45168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fXkhN-0000Cu-Qm
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:55:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fXkhJ-0007ro-M8
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:55:45 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:36555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fXkhJ-0007qr-0i
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:55:41 -0400
Received: by mail-wr0-x244.google.com with SMTP id f16-v6so16587102wrm.3
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 02:55:40 -0700 (PDT)
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-2-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180621015359.12018-2-richard.henderson@linaro.org>
Date: Tue, 26 Jun 2018 10:55:38 +0100
Message-ID: <87o9fxx46d.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 01/35] target/arm: Implement SVE Memory
 Contiguous Load Group
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

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |  35 +++++++++
>  target/arm/sve_helper.c    | 153 +++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 121 +++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  34 +++++++++
>  4 files changed, 343 insertions(+)
>
> diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
> index 2e76084992..fcc9ba5f50 100644
> --- a/target/arm/helper-sve.h
> +++ b/target/arm/helper-sve.h
> @@ -719,3 +719,38 @@ DEF_HELPER_FLAGS_5(gvec_rsqrts_s, TCG_CALL_NO_RWG,
>                     void, ptr, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_5(gvec_rsqrts_d, TCG_CALL_NO_RWG,
>                     void, ptr, ptr, ptr, ptr, i32)
> +
> +DEF_HELPER_FLAGS_4(sve_ld1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ld2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ld3bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ld4bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_4(sve_ld1hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ld2hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ld3hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ld4hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_4(sve_ld1ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ld2ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ld3ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ld4ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_4(sve_ld1dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ld2dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ld3dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ld4dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_4(sve_ld1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ld1bsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ld1bdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ld1bhs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ld1bss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ld1bds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_4(sve_ld1hsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ld1hdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ld1hss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ld1hds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_4(sve_ld1sdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_ld1sds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index 128bbf9b04..4e6ad282f9 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -2810,3 +2810,156 @@ uint32_t HELPER(sve_while)(void *vd, uint32_t cou=
nt, uint32_t pred_desc)
>
>      return predtest_ones(d, oprsz, esz_mask);
>  }
> +
> +/*
> + * Load contiguous data, protected by a governing predicate.
> + */
> +#define DO_LD1(NAME, FN, TYPEE, TYPEM, H)                  \
> +static void do_##NAME(CPUARMState *env, void *vd, void *vg, \
> +                      target_ulong addr, intptr_t oprsz,   \
> +                      uintptr_t ra)                        \
> +{                                                          \
> +    intptr_t i =3D 0;                                        \
> +    do {                                                   \
> +        uint16_t pg =3D *(uint16_t *)(vg + H1_2(i >> 3));    \
> +        do {                                               \
> +            TYPEM m =3D 0;                                   \
> +            if (pg & 1) {                                  \
> +                m =3D FN(env, addr, ra);                     \
> +            }                                              \
> +            *(TYPEE *)(vd + H(i)) =3D m;                     \
> +            i +=3D sizeof(TYPEE), pg >>=3D sizeof(TYPEE);      \
> +            addr +=3D sizeof(TYPEM);                         \
> +        } while (i & 15);                                  \
> +    } while (i < oprsz);                                   \
> +}                                                          \
> +void HELPER(NAME)(CPUARMState *env, void *vg,              \
> +                  target_ulong addr, uint32_t desc)        \
> +{                                                          \
> +    do_##NAME(env, &env->vfp.zregs[simd_data(desc)], vg,   \
> +              addr, simd_oprsz(desc), GETPC());            \
> +}
> +
> +#define DO_LD2(NAME, FN, TYPEE, TYPEM, H)                  \
> +void HELPER(NAME)(CPUARMState *env, void *vg,              \
> +                  target_ulong addr, uint32_t desc)        \
> +{                                                          \
> +    intptr_t i, oprsz =3D simd_oprsz(desc);                  \
> +    intptr_t ra =3D GETPC();                                 \
> +    unsigned rd =3D simd_data(desc);                         \
> +    void *d1 =3D &env->vfp.zregs[rd];                        \
> +    void *d2 =3D &env->vfp.zregs[(rd + 1) & 31];             \
> +    for (i =3D 0; i < oprsz; ) {                             \
> +        uint16_t pg =3D *(uint16_t *)(vg + H1_2(i >> 3));    \
> +        do {                                               \
> +            TYPEM m1 =3D 0, m2 =3D 0;                          \
> +            if (pg & 1) {                                  \
> +                m1 =3D FN(env, addr, ra);                    \
> +                m2 =3D FN(env, addr + sizeof(TYPEM), ra);    \
> +            }                                              \
> +            *(TYPEE *)(d1 + H(i)) =3D m1;                    \
> +            *(TYPEE *)(d2 + H(i)) =3D m2;                    \
> +            i +=3D sizeof(TYPEE), pg >>=3D sizeof(TYPEE);      \
> +            addr +=3D 2 * sizeof(TYPEM);                     \
> +        } while (i & 15);                                  \
> +    }                                                      \
> +}
> +
> +#define DO_LD3(NAME, FN, TYPEE, TYPEM, H)                  \
> +void HELPER(NAME)(CPUARMState *env, void *vg,              \
> +                  target_ulong addr, uint32_t desc)        \
> +{                                                          \
> +    intptr_t i, oprsz =3D simd_oprsz(desc);                  \
> +    intptr_t ra =3D GETPC();                                 \
> +    unsigned rd =3D simd_data(desc);                         \
> +    void *d1 =3D &env->vfp.zregs[rd];                        \
> +    void *d2 =3D &env->vfp.zregs[(rd + 1) & 31];             \
> +    void *d3 =3D &env->vfp.zregs[(rd + 2) & 31];             \
> +    for (i =3D 0; i < oprsz; ) {                             \
> +        uint16_t pg =3D *(uint16_t *)(vg + H1_2(i >> 3));    \
> +        do {                                               \
> +            TYPEM m1 =3D 0, m2 =3D 0, m3 =3D 0;                  \
> +            if (pg & 1) {                                  \
> +                m1 =3D FN(env, addr, ra);                    \
> +                m2 =3D FN(env, addr + sizeof(TYPEM), ra);    \
> +                m3 =3D FN(env, addr + 2 * sizeof(TYPEM), ra); \
> +            }                                              \
> +            *(TYPEE *)(d1 + H(i)) =3D m1;                    \
> +            *(TYPEE *)(d2 + H(i)) =3D m2;                    \
> +            *(TYPEE *)(d3 + H(i)) =3D m3;                    \
> +            i +=3D sizeof(TYPEE), pg >>=3D sizeof(TYPEE);      \
> +            addr +=3D 3 * sizeof(TYPEM);                     \
> +        } while (i & 15);                                  \
> +    }                                                      \
> +}
> +
> +#define DO_LD4(NAME, FN, TYPEE, TYPEM, H)                  \
> +void HELPER(NAME)(CPUARMState *env, void *vg,              \
> +                  target_ulong addr, uint32_t desc)        \
> +{                                                          \
> +    intptr_t i, oprsz =3D simd_oprsz(desc);                  \
> +    intptr_t ra =3D GETPC();                                 \
> +    unsigned rd =3D simd_data(desc);                         \
> +    void *d1 =3D &env->vfp.zregs[rd];                        \
> +    void *d2 =3D &env->vfp.zregs[(rd + 1) & 31];             \
> +    void *d3 =3D &env->vfp.zregs[(rd + 2) & 31];             \
> +    void *d4 =3D &env->vfp.zregs[(rd + 3) & 31];             \
> +    for (i =3D 0; i < oprsz; ) {                             \
> +        uint16_t pg =3D *(uint16_t *)(vg + H1_2(i >> 3));    \
> +        do {                                               \
> +            TYPEM m1 =3D 0, m2 =3D 0, m3 =3D 0, m4 =3D 0;          \
> +            if (pg & 1) {                                  \
> +                m1 =3D FN(env, addr, ra);                    \
> +                m2 =3D FN(env, addr + sizeof(TYPEM), ra);    \
> +                m3 =3D FN(env, addr + 2 * sizeof(TYPEM), ra); \
> +                m4 =3D FN(env, addr + 3 * sizeof(TYPEM), ra); \
> +            }                                              \
> +            *(TYPEE *)(d1 + H(i)) =3D m1;                    \
> +            *(TYPEE *)(d2 + H(i)) =3D m2;                    \
> +            *(TYPEE *)(d3 + H(i)) =3D m3;                    \
> +            *(TYPEE *)(d4 + H(i)) =3D m4;                    \
> +            i +=3D sizeof(TYPEE), pg >>=3D sizeof(TYPEE);      \
> +            addr +=3D 4 * sizeof(TYPEM);                     \
> +        } while (i & 15);                                  \
> +    }                                                      \
> +}
> +
> +DO_LD1(sve_ld1bhu_r, cpu_ldub_data_ra, uint16_t, uint8_t, H1_2)
> +DO_LD1(sve_ld1bhs_r, cpu_ldsb_data_ra, uint16_t, int8_t, H1_2)
> +DO_LD1(sve_ld1bsu_r, cpu_ldub_data_ra, uint32_t, uint8_t, H1_4)
> +DO_LD1(sve_ld1bss_r, cpu_ldsb_data_ra, uint32_t, int8_t, H1_4)
> +DO_LD1(sve_ld1bdu_r, cpu_ldub_data_ra, uint64_t, uint8_t, )
> +DO_LD1(sve_ld1bds_r, cpu_ldsb_data_ra, uint64_t, int8_t, )
> +
> +DO_LD1(sve_ld1hsu_r, cpu_lduw_data_ra, uint32_t, uint16_t, H1_4)
> +DO_LD1(sve_ld1hss_r, cpu_ldsw_data_ra, uint32_t, int8_t, H1_4)
> +DO_LD1(sve_ld1hdu_r, cpu_lduw_data_ra, uint64_t, uint16_t, )
> +DO_LD1(sve_ld1hds_r, cpu_ldsw_data_ra, uint64_t, int16_t, )
> +
> +DO_LD1(sve_ld1sdu_r, cpu_ldl_data_ra, uint64_t, uint32_t, )
> +DO_LD1(sve_ld1sds_r, cpu_ldl_data_ra, uint64_t, int32_t, )
> +
> +DO_LD1(sve_ld1bb_r, cpu_ldub_data_ra, uint8_t, uint8_t, H1)
> +DO_LD2(sve_ld2bb_r, cpu_ldub_data_ra, uint8_t, uint8_t, H1)
> +DO_LD3(sve_ld3bb_r, cpu_ldub_data_ra, uint8_t, uint8_t, H1)
> +DO_LD4(sve_ld4bb_r, cpu_ldub_data_ra, uint8_t, uint8_t, H1)
> +
> +DO_LD1(sve_ld1hh_r, cpu_lduw_data_ra, uint16_t, uint16_t, H1_2)
> +DO_LD2(sve_ld2hh_r, cpu_lduw_data_ra, uint16_t, uint16_t, H1_2)
> +DO_LD3(sve_ld3hh_r, cpu_lduw_data_ra, uint16_t, uint16_t, H1_2)
> +DO_LD4(sve_ld4hh_r, cpu_lduw_data_ra, uint16_t, uint16_t, H1_2)
> +
> +DO_LD1(sve_ld1ss_r, cpu_ldl_data_ra, uint32_t, uint32_t, H1_4)
> +DO_LD2(sve_ld2ss_r, cpu_ldl_data_ra, uint32_t, uint32_t, H1_4)
> +DO_LD3(sve_ld3ss_r, cpu_ldl_data_ra, uint32_t, uint32_t, H1_4)
> +DO_LD4(sve_ld4ss_r, cpu_ldl_data_ra, uint32_t, uint32_t, H1_4)
> +
> +DO_LD1(sve_ld1dd_r, cpu_ldq_data_ra, uint64_t, uint64_t, )
> +DO_LD2(sve_ld2dd_r, cpu_ldq_data_ra, uint64_t, uint64_t, )
> +DO_LD3(sve_ld3dd_r, cpu_ldq_data_ra, uint64_t, uint64_t, )
> +DO_LD4(sve_ld4dd_r, cpu_ldq_data_ra, uint64_t, uint64_t, )
> +
> +#undef DO_LD1
> +#undef DO_LD2
> +#undef DO_LD3
> +#undef DO_LD4
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index 226c97579c..3543daff48 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -42,6 +42,8 @@ typedef void gen_helper_gvec_flags_3(TCGv_i32, TCGv_ptr=
, TCGv_ptr,
>  typedef void gen_helper_gvec_flags_4(TCGv_i32, TCGv_ptr, TCGv_ptr,
>                                       TCGv_ptr, TCGv_ptr, TCGv_i32);
>
> +typedef void gen_helper_gvec_mem(TCGv_env, TCGv_ptr, TCGv_i64, TCGv_i32);
> +
>  /*
>   * Helpers for extracting complex instruction fields.
>   */
> @@ -82,6 +84,15 @@ static inline int expand_imm_sh8u(int x)
>      return (uint8_t)x << (x & 0x100 ? 8 : 0);
>  }
>
> +/* Convert a 2-bit memory size (msz) to a 4-bit data type (dtype)
> + * with unsigned data.  C.f. SVE Memory Contiguous Load Group.
> + */
> +static inline int msz_dtype(int msz)
> +{
> +    static const uint8_t dtype[4] =3D { 0, 5, 10, 15 };
> +    return dtype[msz];
> +}

I'm a little confused by the magic numbers in dtype[4], do they map
directly to dtype_mop[]?

> +
>  /*
>   * Include the generated decoder.
>   */
> @@ -3526,3 +3537,113 @@ static bool trans_LDR_pri(DisasContext *s, arg_rr=
i *a, uint32_t insn)
>      }
>      return true;
>  }
> +
> +/*
> + *** SVE Memory - Contiguous Load Group
> + */
> +
> +/* The memory mode of the dtype.  */
> +static const TCGMemOp dtype_mop[16] =3D {
> +    MO_UB, MO_UB, MO_UB, MO_UB,
> +    MO_SL, MO_UW, MO_UW, MO_UW,
> +    MO_SW, MO_SW, MO_UL, MO_UL,
> +    MO_SB, MO_SB, MO_SB, MO_Q
> +};
> +
> +#define dtype_msz(x)  (dtype_mop[x] & MO_SIZE)
> +
> +/* The vector element size of dtype.  */
> +static const uint8_t dtype_esz[16] =3D {
> +    0, 1, 2, 3,
> +    3, 1, 2, 3,
> +    3, 2, 2, 3,
> +    3, 2, 1, 3
> +};
> +
> +static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
> +                       gen_helper_gvec_mem *fn)
> +{
> +    unsigned vsz =3D vec_full_reg_size(s);
> +    TCGv_ptr t_pg;
> +    TCGv_i32 desc;
> +
> +    /* For e.g. LD4, there are not enough arguments to pass all 4
> +     * registers as pointers, so encode the regno into the data field.
> +     * For consistency, do this even for LD1.
> +     */
> +    desc =3D tcg_const_i32(simd_desc(vsz, vsz, zt));
> +    t_pg =3D tcg_temp_new_ptr();
> +
> +    tcg_gen_addi_ptr(t_pg, cpu_env, pred_full_reg_offset(s, pg));
> +    fn(cpu_env, t_pg, addr, desc);
> +
> +    tcg_temp_free_ptr(t_pg);
> +    tcg_temp_free_i32(desc);
> +}
> +
> +static void do_ld_zpa(DisasContext *s, int zt, int pg,
> +                      TCGv_i64 addr, int dtype, int nreg)
> +{
> +    static gen_helper_gvec_mem * const fns[16][4] =3D {
> +        { gen_helper_sve_ld1bb_r, gen_helper_sve_ld2bb_r,
> +          gen_helper_sve_ld3bb_r, gen_helper_sve_ld4bb_r },
> +        { gen_helper_sve_ld1bhu_r, NULL, NULL, NULL },
> +        { gen_helper_sve_ld1bsu_r, NULL, NULL, NULL },
> +        { gen_helper_sve_ld1bdu_r, NULL, NULL, NULL },
> +
> +        { gen_helper_sve_ld1sds_r, NULL, NULL, NULL },
> +        { gen_helper_sve_ld1hh_r, gen_helper_sve_ld2hh_r,
> +          gen_helper_sve_ld3hh_r, gen_helper_sve_ld4hh_r },
> +        { gen_helper_sve_ld1hsu_r, NULL, NULL, NULL },
> +        { gen_helper_sve_ld1hdu_r, NULL, NULL, NULL },
> +
> +        { gen_helper_sve_ld1hds_r, NULL, NULL, NULL },
> +        { gen_helper_sve_ld1hss_r, NULL, NULL, NULL },
> +        { gen_helper_sve_ld1ss_r, gen_helper_sve_ld2ss_r,
> +          gen_helper_sve_ld3ss_r, gen_helper_sve_ld4ss_r },
> +        { gen_helper_sve_ld1sdu_r, NULL, NULL, NULL },
> +
> +        { gen_helper_sve_ld1bds_r, NULL, NULL, NULL },
> +        { gen_helper_sve_ld1bss_r, NULL, NULL, NULL },
> +        { gen_helper_sve_ld1bhs_r, NULL, NULL, NULL },
> +        { gen_helper_sve_ld1dd_r, gen_helper_sve_ld2dd_r,
> +          gen_helper_sve_ld3dd_r, gen_helper_sve_ld4dd_r },
> +    };
> +    gen_helper_gvec_mem *fn =3D fns[dtype][nreg];
> +
> +    /* While there are holes in the table, they are not
> +     * accessible via the instruction encoding.
> +     */
> +    assert(fn !=3D NULL);
> +    do_mem_zpa(s, zt, pg, addr, fn);
> +}
> +
> +static bool trans_LD_zprr(DisasContext *s, arg_rprr_load *a, uint32_t in=
sn)
> +{
> +    if (a->rm =3D=3D 31) {
> +        return false;
> +    }
> +    if (sve_access_check(s)) {
> +        TCGv_i64 addr =3D new_tmp_a64(s);
> +        tcg_gen_muli_i64(addr, cpu_reg(s, a->rm),
> +                         (a->nreg + 1) << dtype_msz(a->dtype));
> +        tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
> +        do_ld_zpa(s, a->rd, a->pg, addr, a->dtype, a->nreg);
> +    }
> +    return true;
> +}
> +
> +static bool trans_LD_zpri(DisasContext *s, arg_rpri_load *a, uint32_t in=
sn)
> +{
> +    if (sve_access_check(s)) {
> +        int vsz =3D vec_full_reg_size(s);
> +        int elements =3D vsz >> dtype_esz[a->dtype];
> +        TCGv_i64 addr =3D new_tmp_a64(s);
> +
> +        tcg_gen_addi_i64(addr, cpu_reg_sp(s, a->rn),
> +                         (a->imm * elements * (a->nreg + 1))
> +                         << dtype_msz(a->dtype));
> +        do_ld_zpa(s, a->rd, a->pg, addr, a->dtype, a->nreg);
> +    }
> +    return true;
> +}
> diff --git a/target/arm/sve.decode b/target/arm/sve.decode
> index 6f436f9096..cfb12da639 100644
> --- a/target/arm/sve.decode
> +++ b/target/arm/sve.decode
> @@ -45,6 +45,9 @@
>  # Unsigned 8-bit immediate, optionally shifted left by 8.
>  %sh8_i8u        5:9 !function=3Dexpand_imm_sh8u
>
> +# Unsigned load of msz into esz=3D2, represented as a dtype.
> +%msz_dtype      23:2 !function=3Dmsz_dtype
> +
>  # Either a copy of rd (at bit 0), or a different source
>  # as propagated via the MOVPRFX instruction.
>  %reg_movprfx    0:5
> @@ -71,6 +74,8 @@
>  &incdec2_cnt    rd rn pat esz imm d u
>  &incdec_pred    rd pg esz d u
>  &incdec2_pred   rd rn pg esz d u
> +&rprr_load      rd pg rn rm dtype nreg
> +&rpri_load      rd pg rn imm dtype nreg
>
>  ########################################################################=
###
>  # Named instruction formats.  These are generally used to
> @@ -170,6 +175,15 @@
>  @incdec2_pred   ........ esz:2 .... .. ..... .. pg:4 rd:5 \
>                  &incdec2_pred rn=3D%reg_movprfx
>
> +# Loads; user must fill in NREG.
> +@rprr_load_dt   ....... dtype:4 rm:5 ... pg:3 rn:5 rd:5         &rprr_lo=
ad
> +@rpri_load_dt   ....... dtype:4 . imm:s4 ... pg:3 rn:5 rd:5     &rpri_lo=
ad
> +
> +@rprr_load_msz  ....... .... rm:5 ... pg:3 rn:5 rd:5 \
> +                &rprr_load dtype=3D%msz_dtype
> +@rpri_load_msz  ....... .... . imm:s4 ... pg:3 rn:5 rd:5 \
> +                &rpri_load dtype=3D%msz_dtype
> +
>  ########################################################################=
###
>  # Instruction patterns.  Grouped according to the SVE encodingindex.xhtm=
l.
>
> @@ -665,3 +679,23 @@ LDR_pri         10000101 10 ...... 000 ... ..... 0 .=
...         @pd_rn_i9
>
>  # SVE load vector register
>  LDR_zri         10000101 10 ...... 010 ... ..... .....          @rd_rn_i9
> +
> +### SVE Memory Contiguous Load Group
> +

> +# SVE contiguous load (scalar plus scalar)
> +LD_zprr         1010010 .... ..... 010 ... ..... .....    @rprr_load_dt =
nreg=3D0
> +
> +# SVE contiguous load (scalar plus immediate)
> +LD_zpri         1010010 .... 0.... 101 ... ..... .....    @rpri_load_dt =
nreg=3D0
> +
> +# SVE contiguous non-temporal load (scalar plus scalar)
> +# LDNT1B, LDNT1H, LDNT1W, LDNT1D
> +# SVE load multiple structures (scalar plus scalar)
> +# LD2B, LD2H, LD2W, LD2D; etc.
> +LD_zprr         1010010 .. nreg:2 ..... 110 ... ..... .....     @rprr_lo=
ad_msz
> +
> +# SVE contiguous non-temporal load (scalar plus immediate)
> +# LDNT1B, LDNT1H, LDNT1W, LDNT1D
> +# SVE load multiple structures (scalar plus immediate)
> +# LD2B, LD2H, LD2W, LD2D; etc.
> +LD_zpri         1010010 .. nreg:2 0.... 111 ... ..... .....     @rpri_lo=
ad_msz

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
