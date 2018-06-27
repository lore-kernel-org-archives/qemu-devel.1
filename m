Received: from eggs.gnu.org ([2001:4830:134:3::10]:34518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYCnz-0007Wl-L4
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 11:56:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYCnv-00028l-9S
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 11:56:27 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:53543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fYCnu-00026O-PI
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 11:56:23 -0400
Received: by mail-wm0-x244.google.com with SMTP id b188-v6so286780wme.3
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 08:56:22 -0700 (PDT)
References: <20180627043328.11531-1-richard.henderson@linaro.org>
	<20180627043328.11531-3-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180627043328.11531-3-richard.henderson@linaro.org>
Date: Wed, 27 Jun 2018 16:56:20 +0100
Message-ID: <876024w7dn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v6 02/35] target/arm: Implement
 SVE Contiguous Load, first-fault and no-fault
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
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
(with cortex-strings test cases)

>
> ---
> v6:
>   * Remove cold attribute from record_fault, add unlikely marker
>     to the if that protects its call, which seems to be enough to
>     prevent the function being inlined.
>   * Fix the set of bits masked by record_fault.
> ---
>  target/arm/helper-sve.h    |  40 ++++++++++
>  target/arm/sve_helper.c    | 157 +++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c |  69 ++++++++++++++++
>  target/arm/sve.decode      |   6 ++
>  4 files changed, 272 insertions(+)
>
> diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
> index fcc9ba5f50..7338abbbcf 100644
> --- a/target/arm/helper-sve.h
> +++ b/target/arm/helper-sve.h
> @@ -754,3 +754,43 @@ DEF_HELPER_FLAGS_4(sve_ld1hds_r, TCG_CALL_NO_WG, voi=
d, env, ptr, tl, i32)
>
>  DEF_HELPER_FLAGS_4(sve_ld1sdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
>  DEF_HELPER_FLAGS_4(sve_ld1sds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_4(sve_ldff1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i3=
2)
> +DEF_HELPER_FLAGS_4(sve_ldff1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i=
32)
> +DEF_HELPER_FLAGS_4(sve_ldff1bsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i=
32)
> +DEF_HELPER_FLAGS_4(sve_ldff1bdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i=
32)
> +DEF_HELPER_FLAGS_4(sve_ldff1bhs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i=
32)
> +DEF_HELPER_FLAGS_4(sve_ldff1bss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i=
32)
> +DEF_HELPER_FLAGS_4(sve_ldff1bds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i=
32)
> +
> +DEF_HELPER_FLAGS_4(sve_ldff1hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i3=
2)
> +DEF_HELPER_FLAGS_4(sve_ldff1hsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i=
32)
> +DEF_HELPER_FLAGS_4(sve_ldff1hdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i=
32)
> +DEF_HELPER_FLAGS_4(sve_ldff1hss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i=
32)
> +DEF_HELPER_FLAGS_4(sve_ldff1hds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i=
32)
> +
> +DEF_HELPER_FLAGS_4(sve_ldff1ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i3=
2)
> +DEF_HELPER_FLAGS_4(sve_ldff1sdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i=
32)
> +DEF_HELPER_FLAGS_4(sve_ldff1sds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i=
32)
> +
> +DEF_HELPER_FLAGS_4(sve_ldff1dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i3=
2)
> +
> +DEF_HELPER_FLAGS_4(sve_ldnf1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i3=
2)
> +DEF_HELPER_FLAGS_4(sve_ldnf1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i=
32)
> +DEF_HELPER_FLAGS_4(sve_ldnf1bsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i=
32)
> +DEF_HELPER_FLAGS_4(sve_ldnf1bdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i=
32)
> +DEF_HELPER_FLAGS_4(sve_ldnf1bhs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i=
32)
> +DEF_HELPER_FLAGS_4(sve_ldnf1bss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i=
32)
> +DEF_HELPER_FLAGS_4(sve_ldnf1bds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i=
32)
> +
> +DEF_HELPER_FLAGS_4(sve_ldnf1hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i3=
2)
> +DEF_HELPER_FLAGS_4(sve_ldnf1hsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i=
32)
> +DEF_HELPER_FLAGS_4(sve_ldnf1hdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i=
32)
> +DEF_HELPER_FLAGS_4(sve_ldnf1hss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i=
32)
> +DEF_HELPER_FLAGS_4(sve_ldnf1hds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i=
32)
> +
> +DEF_HELPER_FLAGS_4(sve_ldnf1ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i3=
2)
> +DEF_HELPER_FLAGS_4(sve_ldnf1sdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i=
32)
> +DEF_HELPER_FLAGS_4(sve_ldnf1sds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i=
32)
> +
> +DEF_HELPER_FLAGS_4(sve_ldnf1dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i3=
2)
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index 4e6ad282f9..0d22a57a22 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -2963,3 +2963,160 @@ DO_LD4(sve_ld4dd_r, cpu_ldq_data_ra, uint64_t, ui=
nt64_t, )
>  #undef DO_LD2
>  #undef DO_LD3
>  #undef DO_LD4
> +
> +/*
> + * Load contiguous data, first-fault and no-fault.
> + */
> +
> +#ifdef CONFIG_USER_ONLY
> +
> +/* Fault on byte I.  All bits in FFR from I are cleared.  The vector
> + * result from I is CONSTRAINED UNPREDICTABLE; we choose the MERGE
> + * option, which leaves subsequent data unchanged.
> + */
> +static void record_fault(CPUARMState *env, uintptr_t i, uintptr_t oprsz)
> +{
> +    uint64_t *ffr =3D env->vfp.pregs[FFR_PRED_NUM].p;
> +
> +    if (i & 63) {
> +        ffr[i / 64] &=3D MAKE_64BIT_MASK(0, i & 63);
> +        i =3D ROUND_UP(i, 64);
> +    }
> +    for (; i < oprsz; i +=3D 64) {
> +        ffr[i / 64] =3D 0;
> +    }
> +}
> +
> +/* Hold the mmap lock during the operation so that there is no race
> + * between page_check_range and the load operation.  We expect the
> + * usual case to have no faults at all, so we check the whole range
> + * first and if successful defer to the normal load operation.
> + *
> + * TODO: Change mmap_lock to a rwlock so that multiple readers
> + * can run simultaneously.  This will probably help other uses
> + * within QEMU as well.
> + */
> +#define DO_LDFF1(PART, FN, TYPEE, TYPEM, H)                             \
> +static void do_sve_ldff1##PART(CPUARMState *env, void *vd, void *vg,    \
> +                               target_ulong addr, intptr_t oprsz,       \
> +                               bool first, uintptr_t ra)                \
> +{                                                                       \
> +    intptr_t i =3D 0;                                                   =
  \
> +    do {                                                                \
> +        uint16_t pg =3D *(uint16_t *)(vg + H1_2(i >> 3));               =
  \
> +        do {                                                            \
> +            TYPEM m =3D 0;                                              =
  \
> +            if (pg & 1) {                                               \
> +                if (!first &&                                           \
> +                    unlikely(page_check_range(addr, sizeof(TYPEM),      \
> +                                              PAGE_READ))) {            \
> +                    record_fault(env, i, oprsz);                        \
> +                    return;                                             \
> +                }                                                       \
> +                m =3D FN(env, addr, ra);                                =
  \
> +                first =3D false;                                        =
  \
> +            }                                                           \
> +            *(TYPEE *)(vd + H(i)) =3D m;                                =
  \
> +            i +=3D sizeof(TYPEE), pg >>=3D sizeof(TYPEE);               =
    \
> +            addr +=3D sizeof(TYPEM);                                    =
  \
> +        } while (i & 15);                                               \
> +    } while (i < oprsz);                                                \
> +}                                                                       \
> +void HELPER(sve_ldff1##PART)(CPUARMState *env, void *vg,                \
> +                             target_ulong addr, uint32_t desc)          \
> +{                                                                       \
> +    intptr_t oprsz =3D simd_oprsz(desc);                                =
  \
> +    unsigned rd =3D simd_data(desc);                                    =
  \
> +    void *vd =3D &env->vfp.zregs[rd];                                   =
  \
> +    mmap_lock();                                                        \
> +    if (likely(page_check_range(addr, oprsz, PAGE_READ) =3D=3D 0)) {    =
    \
> +        do_sve_ld1##PART(env, vd, vg, addr, oprsz, GETPC());            \
> +    } else {                                                            \
> +        do_sve_ldff1##PART(env, vd, vg, addr, oprsz, true, GETPC());    \
> +    }                                                                   \
> +    mmap_unlock();                                                      \
> +}
> +
> +/* No-fault loads are like first-fault loads without the
> + * first faulting special case.
> + */
> +#define DO_LDNF1(PART)                                                  \
> +void HELPER(sve_ldnf1##PART)(CPUARMState *env, void *vg,                \
> +                             target_ulong addr, uint32_t desc)          \
> +{                                                                       \
> +    intptr_t oprsz =3D simd_oprsz(desc);                                =
  \
> +    unsigned rd =3D simd_data(desc);                                    =
  \
> +    void *vd =3D &env->vfp.zregs[rd];                                   =
  \
> +    mmap_lock();                                                        \
> +    if (likely(page_check_range(addr, oprsz, PAGE_READ) =3D=3D 0)) {    =
    \
> +        do_sve_ld1##PART(env, vd, vg, addr, oprsz, GETPC());            \
> +    } else {                                                            \
> +        do_sve_ldff1##PART(env, vd, vg, addr, oprsz, false, GETPC());   \
> +    }                                                                   \
> +    mmap_unlock();                                                      \
> +}
> +
> +#else
> +
> +/* TODO: System mode is not yet supported.
> + * This would probably use tlb_vaddr_to_host.
> + */
> +#define DO_LDFF1(PART, FN, TYPEE, TYPEM, H)                     \
> +void HELPER(sve_ldff1##PART)(CPUARMState *env, void *vg,        \
> +                  target_ulong addr, uint32_t desc)             \
> +{                                                               \
> +    g_assert_not_reached();                                     \
> +}
> +
> +#define DO_LDNF1(PART)                                          \
> +void HELPER(sve_ldnf1##PART)(CPUARMState *env, void *vg,        \
> +                  target_ulong addr, uint32_t desc)             \
> +{                                                               \
> +    g_assert_not_reached();                                     \
> +}
> +
> +#endif
> +
> +DO_LDFF1(bb_r,  cpu_ldub_data_ra, uint8_t, uint8_t, H1)
> +DO_LDFF1(bhu_r, cpu_ldub_data_ra, uint16_t, uint8_t, H1_2)
> +DO_LDFF1(bhs_r, cpu_ldsb_data_ra, uint16_t, int8_t, H1_2)
> +DO_LDFF1(bsu_r, cpu_ldub_data_ra, uint32_t, uint8_t, H1_4)
> +DO_LDFF1(bss_r, cpu_ldsb_data_ra, uint32_t, int8_t, H1_4)
> +DO_LDFF1(bdu_r, cpu_ldub_data_ra, uint64_t, uint8_t, )
> +DO_LDFF1(bds_r, cpu_ldsb_data_ra, uint64_t, int8_t, )
> +
> +DO_LDFF1(hh_r,  cpu_lduw_data_ra, uint16_t, uint16_t, H1_2)
> +DO_LDFF1(hsu_r, cpu_lduw_data_ra, uint32_t, uint16_t, H1_4)
> +DO_LDFF1(hss_r, cpu_ldsw_data_ra, uint32_t, int8_t, H1_4)
> +DO_LDFF1(hdu_r, cpu_lduw_data_ra, uint64_t, uint16_t, )
> +DO_LDFF1(hds_r, cpu_ldsw_data_ra, uint64_t, int16_t, )
> +
> +DO_LDFF1(ss_r,  cpu_ldl_data_ra, uint32_t, uint32_t, H1_4)
> +DO_LDFF1(sdu_r, cpu_ldl_data_ra, uint64_t, uint32_t, )
> +DO_LDFF1(sds_r, cpu_ldl_data_ra, uint64_t, int32_t, )
> +
> +DO_LDFF1(dd_r,  cpu_ldq_data_ra, uint64_t, uint64_t, )
> +
> +#undef DO_LDFF1
> +
> +DO_LDNF1(bb_r)
> +DO_LDNF1(bhu_r)
> +DO_LDNF1(bhs_r)
> +DO_LDNF1(bsu_r)
> +DO_LDNF1(bss_r)
> +DO_LDNF1(bdu_r)
> +DO_LDNF1(bds_r)
> +
> +DO_LDNF1(hh_r)
> +DO_LDNF1(hsu_r)
> +DO_LDNF1(hss_r)
> +DO_LDNF1(hdu_r)
> +DO_LDNF1(hds_r)
> +
> +DO_LDNF1(ss_r)
> +DO_LDNF1(sdu_r)
> +DO_LDNF1(sds_r)
> +
> +DO_LDNF1(dd_r)
> +
> +#undef DO_LDNF1
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index 3543daff48..09f77b5405 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -3647,3 +3647,72 @@ static bool trans_LD_zpri(DisasContext *s, arg_rpr=
i_load *a, uint32_t insn)
>      }
>      return true;
>  }
> +
> +static bool trans_LDFF1_zprr(DisasContext *s, arg_rprr_load *a, uint32_t=
 insn)
> +{
> +    static gen_helper_gvec_mem * const fns[16] =3D {
> +        gen_helper_sve_ldff1bb_r,
> +        gen_helper_sve_ldff1bhu_r,
> +        gen_helper_sve_ldff1bsu_r,
> +        gen_helper_sve_ldff1bdu_r,
> +
> +        gen_helper_sve_ldff1sds_r,
> +        gen_helper_sve_ldff1hh_r,
> +        gen_helper_sve_ldff1hsu_r,
> +        gen_helper_sve_ldff1hdu_r,
> +
> +        gen_helper_sve_ldff1hds_r,
> +        gen_helper_sve_ldff1hss_r,
> +        gen_helper_sve_ldff1ss_r,
> +        gen_helper_sve_ldff1sdu_r,
> +
> +        gen_helper_sve_ldff1bds_r,
> +        gen_helper_sve_ldff1bss_r,
> +        gen_helper_sve_ldff1bhs_r,
> +        gen_helper_sve_ldff1dd_r,
> +    };
> +
> +    if (sve_access_check(s)) {
> +        TCGv_i64 addr =3D new_tmp_a64(s);
> +        tcg_gen_shli_i64(addr, cpu_reg(s, a->rm), dtype_msz(a->dtype));
> +        tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
> +        do_mem_zpa(s, a->rd, a->pg, addr, fns[a->dtype]);
> +    }
> +    return true;
> +}
> +
> +static bool trans_LDNF1_zpri(DisasContext *s, arg_rpri_load *a, uint32_t=
 insn)
> +{
> +    static gen_helper_gvec_mem * const fns[16] =3D {
> +        gen_helper_sve_ldnf1bb_r,
> +        gen_helper_sve_ldnf1bhu_r,
> +        gen_helper_sve_ldnf1bsu_r,
> +        gen_helper_sve_ldnf1bdu_r,
> +
> +        gen_helper_sve_ldnf1sds_r,
> +        gen_helper_sve_ldnf1hh_r,
> +        gen_helper_sve_ldnf1hsu_r,
> +        gen_helper_sve_ldnf1hdu_r,
> +
> +        gen_helper_sve_ldnf1hds_r,
> +        gen_helper_sve_ldnf1hss_r,
> +        gen_helper_sve_ldnf1ss_r,
> +        gen_helper_sve_ldnf1sdu_r,
> +
> +        gen_helper_sve_ldnf1bds_r,
> +        gen_helper_sve_ldnf1bss_r,
> +        gen_helper_sve_ldnf1bhs_r,
> +        gen_helper_sve_ldnf1dd_r,
> +    };
> +
> +    if (sve_access_check(s)) {
> +        int vsz =3D vec_full_reg_size(s);
> +        int elements =3D vsz >> dtype_esz[a->dtype];
> +        int off =3D (a->imm * elements) << dtype_msz(a->dtype);
> +        TCGv_i64 addr =3D new_tmp_a64(s);
> +
> +        tcg_gen_addi_i64(addr, cpu_reg_sp(s, a->rn), off);
> +        do_mem_zpa(s, a->rd, a->pg, addr, fns[a->dtype]);
> +    }
> +    return true;
> +}
> diff --git a/target/arm/sve.decode b/target/arm/sve.decode
> index cfb12da639..afbed57de1 100644
> --- a/target/arm/sve.decode
> +++ b/target/arm/sve.decode
> @@ -685,9 +685,15 @@ LDR_zri         10000101 10 ...... 010 ... ..... ...=
..          @rd_rn_i9
>  # SVE contiguous load (scalar plus scalar)
>  LD_zprr         1010010 .... ..... 010 ... ..... .....    @rprr_load_dt =
nreg=3D0
>
> +# SVE contiguous first-fault load (scalar plus scalar)
> +LDFF1_zprr      1010010 .... ..... 011 ... ..... .....    @rprr_load_dt =
nreg=3D0
> +
>  # SVE contiguous load (scalar plus immediate)
>  LD_zpri         1010010 .... 0.... 101 ... ..... .....    @rpri_load_dt =
nreg=3D0
>
> +# SVE contiguous non-fault load (scalar plus immediate)
> +LDNF1_zpri      1010010 .... 1.... 101 ... ..... .....    @rpri_load_dt =
nreg=3D0
> +
>  # SVE contiguous non-temporal load (scalar plus scalar)
>  # LDNT1B, LDNT1H, LDNT1W, LDNT1D
>  # SVE load multiple structures (scalar plus scalar)


--
Alex Benn=C3=A9e
