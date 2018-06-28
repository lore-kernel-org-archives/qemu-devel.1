Received: from eggs.gnu.org ([2001:4830:134:3::10]:52922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYWpC-0000Mt-QN
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYWp9-00026q-5Y
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:19:02 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:33583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fYWp8-00023g-H6
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:18:59 -0400
Received: by mail-wm0-x236.google.com with SMTP id z6-v6so20825813wma.0
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 06:18:58 -0700 (PDT)
References: <20180627043328.11531-1-richard.henderson@linaro.org>
	<20180627043328.11531-14-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180627043328.11531-14-richard.henderson@linaro.org>
Date: Thu, 28 Jun 2018 14:18:55 +0100
Message-ID: <87woujuk00.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v6 13/35] target/arm: Implement
 SVE gather loads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
> ---
> v6:
>   * Finish esz =3D=3D msz && u=3D=3D1 decode in sve.decode.
>   * Remove duplicate decode in trans_ST1_zprz.
>   * Add xs=3D2 comment.
>   * Reformat tables to leave room for ff helpers.
> ---
>  target/arm/helper-sve.h    |  67 +++++++++++++++++++++++++
>  target/arm/sve_helper.c    |  77 ++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 100 +++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  57 +++++++++++++++++++++
>  4 files changed, 301 insertions(+)
>
> diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
> index 8880128f9c..aeb62afc34 100644
> --- a/target/arm/helper-sve.h
> +++ b/target/arm/helper-sve.h
> @@ -959,6 +959,73 @@ DEF_HELPER_FLAGS_4(sve_st1hd_r, TCG_CALL_NO_WG, void=
, env, ptr, tl, i32)
>
>  DEF_HELPER_FLAGS_4(sve_st1sd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
>
> +DEF_HELPER_FLAGS_6(sve_ldbsu_zsu, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +DEF_HELPER_FLAGS_6(sve_ldhsu_zsu, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +DEF_HELPER_FLAGS_6(sve_ldssu_zsu, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +DEF_HELPER_FLAGS_6(sve_ldbss_zsu, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +DEF_HELPER_FLAGS_6(sve_ldhss_zsu, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_6(sve_ldbsu_zss, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +DEF_HELPER_FLAGS_6(sve_ldhsu_zss, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +DEF_HELPER_FLAGS_6(sve_ldssu_zss, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +DEF_HELPER_FLAGS_6(sve_ldbss_zss, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +DEF_HELPER_FLAGS_6(sve_ldhss_zss, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_6(sve_ldbdu_zsu, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +DEF_HELPER_FLAGS_6(sve_ldhdu_zsu, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +DEF_HELPER_FLAGS_6(sve_ldsdu_zsu, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +DEF_HELPER_FLAGS_6(sve_ldddu_zsu, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +DEF_HELPER_FLAGS_6(sve_ldbds_zsu, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +DEF_HELPER_FLAGS_6(sve_ldhds_zsu, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +DEF_HELPER_FLAGS_6(sve_ldsds_zsu, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_6(sve_ldbdu_zss, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +DEF_HELPER_FLAGS_6(sve_ldhdu_zss, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +DEF_HELPER_FLAGS_6(sve_ldsdu_zss, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +DEF_HELPER_FLAGS_6(sve_ldddu_zss, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +DEF_HELPER_FLAGS_6(sve_ldbds_zss, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +DEF_HELPER_FLAGS_6(sve_ldhds_zss, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +DEF_HELPER_FLAGS_6(sve_ldsds_zss, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_6(sve_ldbdu_zd, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +DEF_HELPER_FLAGS_6(sve_ldhdu_zd, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +DEF_HELPER_FLAGS_6(sve_ldsdu_zd, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +DEF_HELPER_FLAGS_6(sve_ldddu_zd, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +DEF_HELPER_FLAGS_6(sve_ldbds_zd, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +DEF_HELPER_FLAGS_6(sve_ldhds_zd, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +DEF_HELPER_FLAGS_6(sve_ldsds_zd, TCG_CALL_NO_WG,
> +                   void, env, ptr, ptr, ptr, tl, i32)
> +
>  DEF_HELPER_FLAGS_6(sve_stbs_zsu, TCG_CALL_NO_WG,
>                     void, env, ptr, ptr, ptr, tl, i32)
>  DEF_HELPER_FLAGS_6(sve_sths_zsu, TCG_CALL_NO_WG,
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index 7622bb2af0..24f75a32d3 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -3714,6 +3714,83 @@ void HELPER(sve_st4dd_r)(CPUARMState *env, void *v=
g,
>      }
>  }
>
> +/* Loads with a vector index.  */
> +
> +#define DO_LD1_ZPZ_S(NAME, TYPEI, TYPEM, FN)                            \
> +void HELPER(NAME)(CPUARMState *env, void *vd, void *vg, void *vm,       \
> +                  target_ulong base, uint32_t desc)                     \
> +{                                                                       \
> +    intptr_t i, oprsz =3D simd_oprsz(desc);                             =
  \
> +    unsigned scale =3D simd_data(desc);                                 =
  \
> +    uintptr_t ra =3D GETPC();                                           =
  \
> +    for (i =3D 0; i < oprsz; i++) {                                     =
  \
> +        uint16_t pg =3D *(uint16_t *)(vg + H1_2(i >> 3));               =
  \
> +        do {                                                            \
> +            TYPEM m =3D 0;                                              =
  \
> +            if (pg & 1) {                                               \
> +                target_ulong off =3D *(TYPEI *)(vm + H1_4(i));          =
  \
> +                m =3D FN(env, base + (off << scale), ra);               =
  \
> +            }                                                           \
> +            *(uint32_t *)(vd + H1_4(i)) =3D m;                          =
  \
> +            i +=3D 4, pg >>=3D 4;                                       =
    \
> +        } while (i & 15);                                               \
> +    }                                                                   \
> +}
> +
> +#define DO_LD1_ZPZ_D(NAME, TYPEI, TYPEM, FN)                            \
> +void HELPER(NAME)(CPUARMState *env, void *vd, void *vg, void *vm,       \
> +                  target_ulong base, uint32_t desc)                     \
> +{                                                                       \
> +    intptr_t i, oprsz =3D simd_oprsz(desc) / 8;                         =
  \
> +    unsigned scale =3D simd_data(desc);                                 =
  \
> +    uintptr_t ra =3D GETPC();                                           =
  \
> +    uint64_t *d =3D vd, *m =3D vm; uint8_t *pg =3D vg;                  =
      \
> +    for (i =3D 0; i < oprsz; i++) {                                     =
  \
> +        TYPEM mm =3D 0;                                                 =
  \
> +        if (pg[H1(i)] & 1) {                                            \
> +            target_ulong off =3D (TYPEI)m[i];                           =
  \
> +            mm =3D FN(env, base + (off << scale), ra);                  =
  \
> +        }                                                               \
> +        d[i] =3D mm;                                                    =
  \
> +    }                                                                   \
> +}
> +
> +DO_LD1_ZPZ_S(sve_ldbsu_zsu, uint32_t, uint8_t,  cpu_ldub_data_ra)
> +DO_LD1_ZPZ_S(sve_ldhsu_zsu, uint32_t, uint16_t, cpu_lduw_data_ra)
> +DO_LD1_ZPZ_S(sve_ldssu_zsu, uint32_t, uint32_t, cpu_ldl_data_ra)
> +DO_LD1_ZPZ_S(sve_ldbss_zsu, uint32_t, int8_t,   cpu_ldub_data_ra)
> +DO_LD1_ZPZ_S(sve_ldhss_zsu, uint32_t, int16_t,  cpu_lduw_data_ra)
> +
> +DO_LD1_ZPZ_S(sve_ldbsu_zss, int32_t, uint8_t,  cpu_ldub_data_ra)
> +DO_LD1_ZPZ_S(sve_ldhsu_zss, int32_t, uint16_t, cpu_lduw_data_ra)
> +DO_LD1_ZPZ_S(sve_ldssu_zss, int32_t, uint32_t, cpu_ldl_data_ra)
> +DO_LD1_ZPZ_S(sve_ldbss_zss, int32_t, int8_t,   cpu_ldub_data_ra)
> +DO_LD1_ZPZ_S(sve_ldhss_zss, int32_t, int16_t,  cpu_lduw_data_ra)
> +
> +DO_LD1_ZPZ_D(sve_ldbdu_zsu, uint32_t, uint8_t,  cpu_ldub_data_ra)
> +DO_LD1_ZPZ_D(sve_ldhdu_zsu, uint32_t, uint16_t, cpu_lduw_data_ra)
> +DO_LD1_ZPZ_D(sve_ldsdu_zsu, uint32_t, uint32_t, cpu_ldl_data_ra)
> +DO_LD1_ZPZ_D(sve_ldddu_zsu, uint32_t, uint64_t, cpu_ldq_data_ra)
> +DO_LD1_ZPZ_D(sve_ldbds_zsu, uint32_t, int8_t,   cpu_ldub_data_ra)
> +DO_LD1_ZPZ_D(sve_ldhds_zsu, uint32_t, int16_t,  cpu_lduw_data_ra)
> +DO_LD1_ZPZ_D(sve_ldsds_zsu, uint32_t, int32_t,  cpu_ldl_data_ra)
> +
> +DO_LD1_ZPZ_D(sve_ldbdu_zss, int32_t, uint8_t,  cpu_ldub_data_ra)
> +DO_LD1_ZPZ_D(sve_ldhdu_zss, int32_t, uint16_t, cpu_lduw_data_ra)
> +DO_LD1_ZPZ_D(sve_ldsdu_zss, int32_t, uint32_t, cpu_ldl_data_ra)
> +DO_LD1_ZPZ_D(sve_ldddu_zss, int32_t, uint64_t, cpu_ldq_data_ra)
> +DO_LD1_ZPZ_D(sve_ldbds_zss, int32_t, int8_t,   cpu_ldub_data_ra)
> +DO_LD1_ZPZ_D(sve_ldhds_zss, int32_t, int16_t,  cpu_lduw_data_ra)
> +DO_LD1_ZPZ_D(sve_ldsds_zss, int32_t, int32_t,  cpu_ldl_data_ra)
> +
> +DO_LD1_ZPZ_D(sve_ldbdu_zd, uint64_t, uint8_t,  cpu_ldub_data_ra)
> +DO_LD1_ZPZ_D(sve_ldhdu_zd, uint64_t, uint16_t, cpu_lduw_data_ra)
> +DO_LD1_ZPZ_D(sve_ldsdu_zd, uint64_t, uint32_t, cpu_ldl_data_ra)
> +DO_LD1_ZPZ_D(sve_ldddu_zd, uint64_t, uint64_t, cpu_ldq_data_ra)
> +DO_LD1_ZPZ_D(sve_ldbds_zd, uint64_t, int8_t,   cpu_ldub_data_ra)
> +DO_LD1_ZPZ_D(sve_ldhds_zd, uint64_t, int16_t,  cpu_lduw_data_ra)
> +DO_LD1_ZPZ_D(sve_ldsds_zd, uint64_t, int32_t,  cpu_ldl_data_ra)
> +
>  /* Stores with a vector index.  */
>
>  #define DO_ST1_ZPZ_S(NAME, TYPEI, FN)                                   \
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index 27854e0042..33ffb217d0 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -4255,6 +4255,106 @@ static void do_mem_zpz(DisasContext *s, int zt, i=
nt pg, int zm, int scale,
>      tcg_temp_free_i32(desc);
>  }
>
> +/* Indexed by [ff][xs][u][msz].  */
> +static gen_helper_gvec_mem_scatter * const gather_load_fn32[2][2][2][3] =
=3D {
> +    { { { gen_helper_sve_ldbss_zsu,
> +          gen_helper_sve_ldhss_zsu,
> +          NULL, },
> +        { gen_helper_sve_ldbsu_zsu,
> +          gen_helper_sve_ldhsu_zsu,
> +          gen_helper_sve_ldssu_zsu, } },
> +      { { gen_helper_sve_ldbss_zss,
> +          gen_helper_sve_ldhss_zss,
> +          NULL, },
> +        { gen_helper_sve_ldbsu_zss,
> +          gen_helper_sve_ldhsu_zss,
> +          gen_helper_sve_ldssu_zss, } } },
> +    /* TODO fill in first-fault handlers */
> +};
> +
> +/* Note that we overload xs=3D2 to indicate 64-bit offset.  */
> +static gen_helper_gvec_mem_scatter * const gather_load_fn64[2][3][2][4] =
=3D {
> +    { { { gen_helper_sve_ldbds_zsu,
> +          gen_helper_sve_ldhds_zsu,
> +          gen_helper_sve_ldsds_zsu,
> +          NULL, },
> +        { gen_helper_sve_ldbdu_zsu,
> +          gen_helper_sve_ldhdu_zsu,
> +          gen_helper_sve_ldsdu_zsu,
> +          gen_helper_sve_ldddu_zsu, } },
> +      { { gen_helper_sve_ldbds_zss,
> +          gen_helper_sve_ldhds_zss,
> +          gen_helper_sve_ldsds_zss,
> +          NULL, },
> +        { gen_helper_sve_ldbdu_zss,
> +          gen_helper_sve_ldhdu_zss,
> +          gen_helper_sve_ldsdu_zss,
> +          gen_helper_sve_ldddu_zss, } },
> +      { { gen_helper_sve_ldbds_zd,
> +          gen_helper_sve_ldhds_zd,
> +          gen_helper_sve_ldsds_zd,
> +          NULL, },
> +        { gen_helper_sve_ldbdu_zd,
> +          gen_helper_sve_ldhdu_zd,
> +          gen_helper_sve_ldsdu_zd,
> +          gen_helper_sve_ldddu_zd, } } },
> +    /* TODO fill in first-fault handlers */
> +};
> +
> +static bool trans_LD1_zprz(DisasContext *s, arg_LD1_zprz *a, uint32_t in=
sn)
> +{
> +    gen_helper_gvec_mem_scatter *fn =3D NULL;
> +
> +    if (!sve_access_check(s)) {
> +        return true;
> +    }
> +
> +    switch (a->esz) {
> +    case MO_32:
> +        fn =3D gather_load_fn32[a->ff][a->xs][a->u][a->msz];
> +        break;
> +    case MO_64:
> +        fn =3D gather_load_fn64[a->ff][a->xs][a->u][a->msz];
> +        break;
> +    }
> +    assert(fn !=3D NULL);
> +
> +    do_mem_zpz(s, a->rd, a->pg, a->rm, a->scale * a->msz,
> +               cpu_reg_sp(s, a->rn), fn);
> +    return true;
> +}
> +
> +static bool trans_LD1_zpiz(DisasContext *s, arg_LD1_zpiz *a, uint32_t in=
sn)
> +{
> +    gen_helper_gvec_mem_scatter *fn =3D NULL;
> +    TCGv_i64 imm;
> +
> +    if (a->esz < a->msz || (a->esz =3D=3D a->msz && !a->u)) {
> +        return false;
> +    }
> +    if (!sve_access_check(s)) {
> +        return true;
> +    }
> +
> +    switch (a->esz) {
> +    case MO_32:
> +        fn =3D gather_load_fn32[a->ff][0][a->u][a->msz];
> +        break;
> +    case MO_64:
> +        fn =3D gather_load_fn64[a->ff][2][a->u][a->msz];
> +        break;
> +    }
> +    assert(fn !=3D NULL);
> +
> +    /* Treat LD1_zpiz (zn[x] + imm) the same way as LD1_zprz (rn + zm[x])
> +     * by loading the immediate into the scalar parameter.
> +     */
> +    imm =3D tcg_const_i64(a->imm << a->msz);
> +    do_mem_zpz(s, a->rd, a->pg, a->rn, 0, imm, fn);
> +    tcg_temp_free_i64(imm);
> +    return true;
> +}
> +
>  static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a, uint32_t in=
sn)
>  {
>      /* Indexed by [xs][msz].  */
> diff --git a/target/arm/sve.decode b/target/arm/sve.decode
> index 80b955ff84..45016c6042 100644
> --- a/target/arm/sve.decode
> +++ b/target/arm/sve.decode
> @@ -80,6 +80,8 @@
>  &rpri_load      rd pg rn imm dtype nreg
>  &rprr_store     rd pg rn rm msz esz nreg
>  &rpri_store     rd pg rn imm msz esz nreg
> +&rprr_gather_load       rd pg rn rm esz msz u ff xs scale
> +&rpri_gather_load       rd pg rn imm esz msz u ff
>  &rprr_scatter_store     rd pg rn rm esz msz xs scale
>
>  ########################################################################=
###
> @@ -194,6 +196,22 @@
>  @rpri_load_msz  ....... .... . imm:s4 ... pg:3 rn:5 rd:5 \
>                  &rpri_load dtype=3D%msz_dtype
>
> +# Gather Loads.
> +@rprr_g_load_u        ....... .. .    . rm:5 . u:1 ff:1 pg:3 rn:5 rd:5 \
> +                      &rprr_gather_load xs=3D2
> +@rprr_g_load_xs_u     ....... .. xs:1 . rm:5 . u:1 ff:1 pg:3 rn:5 rd:5 \
> +                      &rprr_gather_load
> +@rprr_g_load_xs_u_sc  ....... .. xs:1 scale:1 rm:5 . u:1 ff:1 pg:3 rn:5 =
rd:5 \
> +                      &rprr_gather_load
> +@rprr_g_load_xs_sc    ....... .. xs:1 scale:1 rm:5 . . ff:1 pg:3 rn:5 rd=
:5 \
> +                      &rprr_gather_load
> +@rprr_g_load_u_sc     ....... .. .    scale:1 rm:5 . u:1 ff:1 pg:3 rn:5 =
rd:5 \
> +                      &rprr_gather_load xs=3D2
> +@rprr_g_load_sc       ....... .. .    scale:1 rm:5 . . ff:1 pg:3 rn:5 rd=
:5 \
> +                      &rprr_gather_load xs=3D2
> +@rpri_g_load          ....... msz:2 .. imm:5 . u:1 ff:1 pg:3 rn:5 rd:5 \
> +                      &rpri_gather_load
> +
>  # Stores; user must fill in ESZ, MSZ, NREG as needed.
>  @rprr_store         ....... ..    ..     rm:5 ... pg:3 rn:5 rd:5    &rpr=
r_store
>  @rpri_store_msz     ....... msz:2 .. . imm:s4 ... pg:3 rn:5 rd:5    &rpr=
i_store
> @@ -759,6 +777,19 @@ LDR_zri         10000101 10 ...... 010 ... ..... ...=
..          @rd_rn_i9
>  LD1R_zpri       1000010 .. 1 imm:6 1.. pg:3 rn:5 rd:5 \
>                  &rpri_load dtype=3D%dtype_23_13 nreg=3D0
>
> +# SVE 32-bit gather load (scalar plus 32-bit unscaled offsets)
> +# SVE 32-bit gather load (scalar plus 32-bit scaled offsets)
> +LD1_zprz        1000010 00 .0 ..... 0.. ... ..... ..... \
> +                @rprr_g_load_xs_u esz=3D2 msz=3D0 scale=3D0
> +LD1_zprz        1000010 01 .. ..... 0.. ... ..... ..... \
> +                @rprr_g_load_xs_u_sc esz=3D2 msz=3D1
> +LD1_zprz        1000010 10 .. ..... 01. ... ..... ..... \
> +                @rprr_g_load_xs_sc esz=3D2 msz=3D2 u=3D1
> +
> +# SVE 32-bit gather load (vector plus immediate)
> +LD1_zpiz        1000010 .. 01 ..... 1.. ... ..... ..... \
> +                @rpri_g_load esz=3D2
> +
>  ### SVE Memory Contiguous Load Group
>
>  # SVE contiguous load (scalar plus scalar)
> @@ -808,6 +839,32 @@ PRF_rr          1000010 -- 00 rm:5 110 --- ----- 0 -=
---
>
>  ### SVE Memory 64-bit Gather Group
>
> +# SVE 64-bit gather load (scalar plus 32-bit unpacked unscaled offsets)
> +# SVE 64-bit gather load (scalar plus 32-bit unpacked scaled offsets)
> +LD1_zprz        1100010 00 .0 ..... 0.. ... ..... ..... \
> +                @rprr_g_load_xs_u esz=3D3 msz=3D0 scale=3D0
> +LD1_zprz        1100010 01 .. ..... 0.. ... ..... ..... \
> +                @rprr_g_load_xs_u_sc esz=3D3 msz=3D1
> +LD1_zprz        1100010 10 .. ..... 0.. ... ..... ..... \
> +                @rprr_g_load_xs_u_sc esz=3D3 msz=3D2
> +LD1_zprz        1100010 11 .. ..... 01. ... ..... ..... \
> +                @rprr_g_load_xs_sc esz=3D3 msz=3D3 u=3D1
> +
> +# SVE 64-bit gather load (scalar plus 64-bit unscaled offsets)
> +# SVE 64-bit gather load (scalar plus 64-bit scaled offsets)
> +LD1_zprz        1100010 00 10 ..... 1.. ... ..... ..... \
> +                @rprr_g_load_u esz=3D3 msz=3D0 scale=3D0
> +LD1_zprz        1100010 01 1. ..... 1.. ... ..... ..... \
> +                @rprr_g_load_u_sc esz=3D3 msz=3D1
> +LD1_zprz        1100010 10 1. ..... 1.. ... ..... ..... \
> +                @rprr_g_load_u_sc esz=3D3 msz=3D2
> +LD1_zprz        1100010 11 1. ..... 11. ... ..... ..... \
> +                @rprr_g_load_sc esz=3D3 msz=3D3 u=3D1
> +
> +# SVE 64-bit gather load (vector plus immediate)
> +LD1_zpiz        1100010 .. 01 ..... 1.. ... ..... ..... \
> +                @rpri_g_load esz=3D3
> +
>  # SVE 64-bit gather prefetch (scalar plus 64-bit scaled offsets)
>  PRF             1100010 00 11 ----- 1-- --- ----- 0 ----


--
Alex Benn=C3=A9e
