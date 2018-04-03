Received: from eggs.gnu.org ([2001:4830:134:3::10]:46351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3ICo-0008QU-LB
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 05:26:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3ICl-00078s-BY
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 05:26:18 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:36730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f3ICk-00078H-Vu
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 05:26:15 -0400
Received: by mail-wr0-x244.google.com with SMTP id y55so17862570wry.3
	for <qemu-devel@nongnu.org>; Tue, 03 Apr 2018 02:26:14 -0700 (PDT)
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-6-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180217182323.25885-6-richard.henderson@linaro.org>
Date: Tue, 03 Apr 2018 10:26:12 +0100
Message-ID: <87y3i4d4jv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/67] target/arm: Implement SVE load
 vector/predicate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-sve.c | 132 +++++++++++++++++++++++++++++++++++++++=
++++++
>  target/arm/sve.decode      |  22 +++++++-
>  2 files changed, 153 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index 50cf2a1fdd..c0cccfda6f 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -46,6 +46,19 @@ typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
>   * Implement all of the translator functions referenced by the decoder.
>   */
>
> +/* Return the offset info CPUARMState of the predicate vector register P=
n.
> + * Note for this purpose, FFR is P16.  */
> +static inline int pred_full_reg_offset(DisasContext *s, int regno)
> +{
> +    return offsetof(CPUARMState, vfp.pregs[regno]);
> +}

You don't use it yet but probably worth a:

static inline int ffr_full_reg_offset(DisasContext *s)
{
    return pred_full_reg_offset(s, 16);
}

here when you get to it to avoid the magic 16 appearing in the main code.

> +
> +/* Return the byte size of the whole predicate register, VL / 64.  */
> +static inline int pred_full_reg_size(DisasContext *s)
> +{
> +    return s->sve_len >> 3;
> +}
> +
>  /* Invoke a vector expander on two Zregs.  */
>  static void do_vector2_z(DisasContext *s, GVecGen2Fn *gvec_fn,
>                           int esz, int rd, int rn)
> @@ -97,3 +110,122 @@ static void trans_BIC_zzz(DisasContext *s, arg_BIC_z=
zz *a, uint32_t insn)
>  {
>      do_vector3_z(s, tcg_gen_gvec_andc, 0, a->rd, a->rn, a->rm);
>  }
> +
> +/*
> + *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
> + */
> +
> +/* Subroutine loading a vector register at VOFS of LEN bytes.
> + * The load should begin at the address Rn + IMM.
> + */
> +
> +#if UINTPTR_MAX =3D=3D UINT32_MAX
> +# define ptr i32
> +#else
> +# define ptr i64
> +#endif

This seems superfluous, don't we already have TCGv_ptr for this reason?

> +
> +static void do_ldr(DisasContext *s, uint32_t vofs, uint32_t len,
> +                   int rn, int imm)
> +{
> +    uint32_t len_align =3D QEMU_ALIGN_DOWN(len, 8);
> +    uint32_t len_remain =3D len % 8;
> +    uint32_t nparts =3D len / 8 + ctpop8(len_remain);
> +    int midx =3D get_mem_index(s);
> +    TCGv_i64 addr, t0, t1;
> +
> +    addr =3D tcg_temp_new_i64();
> +    t0 =3D tcg_temp_new_i64();
> +
> +    /* Note that unpredicated load/store of vector/predicate registers
> +     * are defined as a stream of bytes, which equates to little-endian
> +     * operations on larger quantities.  There is no nice way to force
> +     * a little-endian load for aarch64_be-linux-user out of line.
> +     *
> +     * Attempt to keep code expansion to a minimum by limiting the
> +     * amount of unrolling done.
> +     */
> +    if (nparts <=3D 4) {
> +        int i;
> +
> +        for (i =3D 0; i < len_align; i +=3D 8) {
> +            tcg_gen_addi_i64(addr, cpu_reg_sp(s, rn), imm + i);
> +            tcg_gen_qemu_ld_i64(t0, addr, midx, MO_LEQ);
> +            tcg_gen_st_i64(t0, cpu_env, vofs + i);
> +        }
> +    } else {
> +        TCGLabel *loop =3D gen_new_label();
> +        TCGv_ptr i =3D TCGV_NAT_TO_PTR(glue(tcg_const_local_, ptr)(0));
> +        TCGv_ptr dest;
> +
> +        gen_set_label(loop);
> +
> +        /* Minimize the number of local temps that must be re-read from
> +         * the stack each iteration.  Instead, re-compute values other
> +         * than the loop counter.
> +         */
> +        dest =3D tcg_temp_new_ptr();
> +        tcg_gen_addi_ptr(dest, i, imm);
> +#if UINTPTR_MAX =3D=3D UINT32_MAX
> +        tcg_gen_extu_i32_i64(addr, TCGV_PTR_TO_NAT(dest));
> +        tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, rn));
> +#else
> +        tcg_gen_add_i64(addr, TCGV_PTR_TO_NAT(dest), cpu_reg_sp(s, rn));
> +#endif
> +
> +        tcg_gen_qemu_ld_i64(t0, addr, midx, MO_LEQ);
> +
> +        tcg_gen_add_ptr(dest, cpu_env, i);
> +        tcg_gen_addi_ptr(i, i, 8);
> +        tcg_gen_st_i64(t0, dest, vofs);
> +        tcg_temp_free_ptr(dest);
> +
> +        glue(tcg_gen_brcondi_, ptr)(TCG_COND_LTU, TCGV_PTR_TO_NAT(i),
> +                                    len_align, loop);

If this is the only use for ptr I wonder if it would just make more
sense to #if/else here.

> +        tcg_temp_free_ptr(i);
> +    }
> +
> +    /* Predicate register loads can be any multiple of 2.
> +     * Note that we still store the entire 64-bit unit into cpu_env.
> +     */
> +    if (len_remain) {
> +        tcg_gen_addi_i64(addr, cpu_reg_sp(s, rn), imm + len_align);
> +
> +        switch (len_remain) {
> +        case 2:
> +        case 4:
> +        case 8:
> +            tcg_gen_qemu_ld_i64(t0, addr, midx, MO_LE | ctz32(len_remain=
));
> +            break;
> +
> +        case 6:
> +            t1 =3D tcg_temp_new_i64();
> +            tcg_gen_qemu_ld_i64(t0, addr, midx, MO_LEUL);
> +            tcg_gen_addi_i64(addr, addr, 4);
> +            tcg_gen_qemu_ld_i64(t1, addr, midx, MO_LEUW);
> +            tcg_gen_deposit_i64(t0, t0, t1, 32, 32);
> +            tcg_temp_free_i64(t1);
> +            break;
> +
> +        default:
> +            g_assert_not_reached();
> +        }
> +        tcg_gen_st_i64(t0, cpu_env, vofs + len_align);
> +    }
> +    tcg_temp_free_i64(addr);
> +    tcg_temp_free_i64(t0);
> +}
> +
> +#undef ptr
> +
> +static void trans_LDR_zri(DisasContext *s, arg_rri *a, uint32_t insn)
> +{
> +    int size =3D vec_full_reg_size(s);
> +    do_ldr(s, vec_full_reg_offset(s, a->rd), size, a->rn, a->imm * size);
> +}
> +
> +static void trans_LDR_pri(DisasContext *s, arg_rri *a, uint32_t insn)
> +{
> +    int size =3D pred_full_reg_size(s);
> +    do_ldr(s, pred_full_reg_offset(s, a->rd), size, a->rn, a->imm * size=
);
> +}
> diff --git a/target/arm/sve.decode b/target/arm/sve.decode
> index 2c13a6024a..0c6a7ba34d 100644
> --- a/target/arm/sve.decode
> +++ b/target/arm/sve.decode
> @@ -19,11 +19,17 @@
>  # This file is processed by scripts/decodetree.py
>  #
>
> +########################################################################=
###
> +# Named fields.  These are primarily for disjoint fields.
> +
> +%imm9_16_10	16:s6 10:3
> +
>  ########################################################################=
###
>  # Named attribute sets.  These are used to make nice(er) names
>  # when creating helpers common to those for the individual
>  # instruction patterns.
>
> +&rri		rd rn imm
>  &rrr_esz	rd rn rm esz
>
>  ########################################################################=
###
> @@ -31,7 +37,13 @@
>  # reduce the amount of duplication between instruction patterns.
>
>  # Three operand with unused vector element size
> -@rd_rn_rm_e0	........ ... rm:5  ... ...  rn:5 rd:5		&rrr_esz esz=3D0
> +@rd_rn_rm_e0	........ ... rm:5 ... ... rn:5 rd:5		&rrr_esz esz=3D0
> +
> +# Basic Load/Store with 9-bit immediate offset
> +@pd_rn_i9	........ ........ ...... rn:5 . rd:4	\
> +		&rri imm=3D%imm9_16_10
> +@rd_rn_i9	........ ........ ...... rn:5 rd:5	\
> +		&rri imm=3D%imm9_16_10
>
>  ########################################################################=
###
>  # Instruction patterns.  Grouped according to the SVE encodingindex.xhtm=
l.
> @@ -43,3 +55,11 @@ AND_zzz		00000100 00 1 ..... 001 100 ..... .....		@rd_=
rn_rm_e0
>  ORR_zzz		00000100 01 1 ..... 001 100 ..... .....		@rd_rn_rm_e0
>  EOR_zzz		00000100 10 1 ..... 001 100 ..... .....		@rd_rn_rm_e0
>  BIC_zzz		00000100 11 1 ..... 001 100 ..... .....		@rd_rn_rm_e0
> +
> +### SVE Memory - 32-bit Gather and Unsized Contiguous Group
> +
> +# SVE load predicate register
> +LDR_pri		10000101 10 ...... 000 ... ..... 0 ....		@pd_rn_i9
> +
> +# SVE load vector register
> +LDR_zri		10000101 10 ...... 010 ... ..... .....		@rd_rn_i9


--
Alex Benn=C3=A9e
