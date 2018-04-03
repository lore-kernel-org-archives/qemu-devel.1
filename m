Received: from eggs.gnu.org ([2001:4830:134:3::10]:41151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3HpE-00082H-LR
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 05:01:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3Hp8-0008Kg-0Q
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 05:01:56 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:50408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f3Hp7-0008IO-MH
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 05:01:49 -0400
Received: by mail-wm0-x242.google.com with SMTP id t67so11984152wmt.0
	for <qemu-devel@nongnu.org>; Tue, 03 Apr 2018 02:01:49 -0700 (PDT)
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-3-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180217182323.25885-3-richard.henderson@linaro.org>
Date: Tue, 03 Apr 2018 10:01:46 +0100
Message-ID: <871sfwek91.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 02/67] target/arm: Introduce
 translate-a64.h
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

> Move some stuff that will be common to both translate-a64.c
> and translate-sve.c.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/translate-a64.h | 110 +++++++++++++++++++++++++++++++++++++++=
++++++
>  target/arm/translate-a64.c | 101 ++++++---------------------------------=
--
>  2 files changed, 123 insertions(+), 88 deletions(-)
>  create mode 100644 target/arm/translate-a64.h
>
> diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
> new file mode 100644
> index 0000000000..e519aee314
> --- /dev/null
> +++ b/target/arm/translate-a64.h
> @@ -0,0 +1,110 @@
> +/*
> + *  AArch64 translation, common definitions.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> + */
> +
> +#ifndef TARGET_ARM_TRANSLATE_A64_H
> +#define TARGET_ARM_TRANSLATE_A64_H
> +
> +void unallocated_encoding(DisasContext *s);
> +
> +#define unsupported_encoding(s, insn)                                   =
 \
> +    do {                                                                =
 \
> +        qemu_log_mask(LOG_UNIMP,                                        =
 \
> +                      "%s:%d: unsupported instruction encoding 0x%08x " =
 \
> +                      "at pc=3D%016" PRIx64 "\n",                       =
   \
> +                      __FILE__, __LINE__, insn, s->pc - 4);             =
 \
> +        unallocated_encoding(s);                                        =
 \
> +    } while (0)
> +
> +TCGv_i64 new_tmp_a64(DisasContext *s);
> +TCGv_i64 new_tmp_a64_zero(DisasContext *s);
> +TCGv_i64 cpu_reg(DisasContext *s, int reg);
> +TCGv_i64 cpu_reg_sp(DisasContext *s, int reg);
> +TCGv_i64 read_cpu_reg(DisasContext *s, int reg, int sf);
> +TCGv_i64 read_cpu_reg_sp(DisasContext *s, int reg, int sf);
> +void write_fp_dreg(DisasContext *s, int reg, TCGv_i64 v);
> +TCGv_ptr get_fpstatus_ptr(bool);
> +bool logic_imm_decode_wmask(uint64_t *result, unsigned int immn,
> +                            unsigned int imms, unsigned int immr);
> +uint64_t vfp_expand_imm(int size, uint8_t imm8);
> +
> +/* We should have at some point before trying to access an FP register
> + * done the necessary access check, so assert that
> + * (a) we did the check and
> + * (b) we didn't then just plough ahead anyway if it failed.
> + * Print the instruction pattern in the abort message so we can figure
> + * out what we need to fix if a user encounters this problem in the wild.
> + */
> +static inline void assert_fp_access_checked(DisasContext *s)
> +{
> +#ifdef CONFIG_DEBUG_TCG
> +    if (unlikely(!s->fp_access_checked || s->fp_excp_el)) {
> +        fprintf(stderr, "target-arm: FP access check missing for "
> +                "instruction 0x%08x\n", s->insn);
> +        abort();
> +    }
> +#endif
> +}
> +
> +/* Return the offset into CPUARMState of an element of specified
> + * size, 'element' places in from the least significant end of
> + * the FP/vector register Qn.
> + */
> +static inline int vec_reg_offset(DisasContext *s, int regno,
> +                                 int element, TCGMemOp size)
> +{
> +    int offs =3D 0;
> +#ifdef HOST_WORDS_BIGENDIAN
> +    /* This is complicated slightly because vfp.zregs[n].d[0] is
> +     * still the low half and vfp.zregs[n].d[1] the high half
> +     * of the 128 bit vector, even on big endian systems.
> +     * Calculate the offset assuming a fully bigendian 128 bits,
> +     * then XOR to account for the order of the two 64 bit halves.
> +     */
> +    offs +=3D (16 - ((element + 1) * (1 << size)));
> +    offs ^=3D 8;
> +#else
> +    offs +=3D element * (1 << size);
> +#endif
> +    offs +=3D offsetof(CPUARMState, vfp.zregs[regno]);
> +    assert_fp_access_checked(s);
> +    return offs;
> +}
> +
> +/* Return the offset info CPUARMState of the "whole" vector register Qn.=
  */
> +static inline int vec_full_reg_offset(DisasContext *s, int regno)
> +{
> +    assert_fp_access_checked(s);
> +    return offsetof(CPUARMState, vfp.zregs[regno]);
> +}
> +
> +/* Return a newly allocated pointer to the vector register.  */
> +static inline TCGv_ptr vec_full_reg_ptr(DisasContext *s, int regno)
> +{
> +    TCGv_ptr ret =3D tcg_temp_new_ptr();
> +    tcg_gen_addi_ptr(ret, cpu_env, vec_full_reg_offset(s, regno));
> +    return ret;
> +}
> +
> +/* Return the byte size of the "whole" vector register, VL / 8.  */
> +static inline int vec_full_reg_size(DisasContext *s)
> +{
> +    return s->sve_len;
> +}
> +
> +bool disas_sve(DisasContext *, uint32_t);
> +
> +#endif /* TARGET_ARM_TRANSLATE_A64_H */
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 032cbfa17d..e0e7ebf68c 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -36,13 +36,13 @@
>  #include "exec/log.h"
>
>  #include "trace-tcg.h"
> +#include "translate-a64.h"
>
>  static TCGv_i64 cpu_X[32];
>  static TCGv_i64 cpu_pc;
>
>  /* Load/store exclusive handling */
>  static TCGv_i64 cpu_exclusive_high;
> -static TCGv_i64 cpu_reg(DisasContext *s, int reg);
>
>  static const char *regnames[] =3D {
>      "x0", "x1", "x2", "x3", "x4", "x5", "x6", "x7",
> @@ -392,22 +392,13 @@ static inline void gen_goto_tb(DisasContext *s, int=
 n, uint64_t dest)
>      }
>  }
>
> -static void unallocated_encoding(DisasContext *s)
> +void unallocated_encoding(DisasContext *s)
>  {
>      /* Unallocated and reserved encodings are uncategorized */
>      gen_exception_insn(s, 4, EXCP_UDEF, syn_uncategorized(),
>                         default_exception_el(s));
>  }
>
> -#define unsupported_encoding(s, insn)                                   =
 \
> -    do {                                                                =
 \
> -        qemu_log_mask(LOG_UNIMP,                                        =
 \
> -                      "%s:%d: unsupported instruction encoding 0x%08x " =
 \
> -                      "at pc=3D%016" PRIx64 "\n",                       =
   \
> -                      __FILE__, __LINE__, insn, s->pc - 4);             =
 \
> -        unallocated_encoding(s);                                        =
 \
> -    } while (0)
> -
>  static void init_tmp_a64_array(DisasContext *s)
>  {
>  #ifdef CONFIG_DEBUG_TCG
> @@ -425,13 +416,13 @@ static void free_tmp_a64(DisasContext *s)
>      init_tmp_a64_array(s);
>  }
>
> -static TCGv_i64 new_tmp_a64(DisasContext *s)
> +TCGv_i64 new_tmp_a64(DisasContext *s)
>  {
>      assert(s->tmp_a64_count < TMP_A64_MAX);
>      return s->tmp_a64[s->tmp_a64_count++] =3D tcg_temp_new_i64();
>  }
>
> -static TCGv_i64 new_tmp_a64_zero(DisasContext *s)
> +TCGv_i64 new_tmp_a64_zero(DisasContext *s)
>  {
>      TCGv_i64 t =3D new_tmp_a64(s);
>      tcg_gen_movi_i64(t, 0);
> @@ -453,7 +444,7 @@ static TCGv_i64 new_tmp_a64_zero(DisasContext *s)
>   * to cpu_X[31] and ZR accesses to a temporary which can be discarded.
>   * This is the point of the _sp forms.
>   */
> -static TCGv_i64 cpu_reg(DisasContext *s, int reg)
> +TCGv_i64 cpu_reg(DisasContext *s, int reg)
>  {
>      if (reg =3D=3D 31) {
>          return new_tmp_a64_zero(s);
> @@ -463,7 +454,7 @@ static TCGv_i64 cpu_reg(DisasContext *s, int reg)
>  }
>
>  /* register access for when 31 =3D=3D SP */
> -static TCGv_i64 cpu_reg_sp(DisasContext *s, int reg)
> +TCGv_i64 cpu_reg_sp(DisasContext *s, int reg)
>  {
>      return cpu_X[reg];
>  }
> @@ -472,7 +463,7 @@ static TCGv_i64 cpu_reg_sp(DisasContext *s, int reg)
>   * representing the register contents. This TCGv is an auto-freed
>   * temporary so it need not be explicitly freed, and may be modified.
>   */
> -static TCGv_i64 read_cpu_reg(DisasContext *s, int reg, int sf)
> +TCGv_i64 read_cpu_reg(DisasContext *s, int reg, int sf)
>  {
>      TCGv_i64 v =3D new_tmp_a64(s);
>      if (reg !=3D 31) {
> @@ -487,7 +478,7 @@ static TCGv_i64 read_cpu_reg(DisasContext *s, int reg=
, int sf)
>      return v;
>  }
>
> -static TCGv_i64 read_cpu_reg_sp(DisasContext *s, int reg, int sf)
> +TCGv_i64 read_cpu_reg_sp(DisasContext *s, int reg, int sf)
>  {
>      TCGv_i64 v =3D new_tmp_a64(s);
>      if (sf) {
> @@ -498,72 +489,6 @@ static TCGv_i64 read_cpu_reg_sp(DisasContext *s, int=
 reg, int sf)
>      return v;
>  }
>
> -/* We should have at some point before trying to access an FP register
> - * done the necessary access check, so assert that
> - * (a) we did the check and
> - * (b) we didn't then just plough ahead anyway if it failed.
> - * Print the instruction pattern in the abort message so we can figure
> - * out what we need to fix if a user encounters this problem in the wild.
> - */
> -static inline void assert_fp_access_checked(DisasContext *s)
> -{
> -#ifdef CONFIG_DEBUG_TCG
> -    if (unlikely(!s->fp_access_checked || s->fp_excp_el)) {
> -        fprintf(stderr, "target-arm: FP access check missing for "
> -                "instruction 0x%08x\n", s->insn);
> -        abort();
> -    }
> -#endif
> -}
> -
> -/* Return the offset into CPUARMState of an element of specified
> - * size, 'element' places in from the least significant end of
> - * the FP/vector register Qn.
> - */
> -static inline int vec_reg_offset(DisasContext *s, int regno,
> -                                 int element, TCGMemOp size)
> -{
> -    int offs =3D 0;
> -#ifdef HOST_WORDS_BIGENDIAN
> -    /* This is complicated slightly because vfp.zregs[n].d[0] is
> -     * still the low half and vfp.zregs[n].d[1] the high half
> -     * of the 128 bit vector, even on big endian systems.
> -     * Calculate the offset assuming a fully bigendian 128 bits,
> -     * then XOR to account for the order of the two 64 bit halves.
> -     */
> -    offs +=3D (16 - ((element + 1) * (1 << size)));
> -    offs ^=3D 8;
> -#else
> -    offs +=3D element * (1 << size);
> -#endif
> -    offs +=3D offsetof(CPUARMState, vfp.zregs[regno]);
> -    assert_fp_access_checked(s);
> -    return offs;
> -}
> -
> -/* Return the offset info CPUARMState of the "whole" vector register Qn.=
  */
> -static inline int vec_full_reg_offset(DisasContext *s, int regno)
> -{
> -    assert_fp_access_checked(s);
> -    return offsetof(CPUARMState, vfp.zregs[regno]);
> -}
> -
> -/* Return a newly allocated pointer to the vector register.  */
> -static TCGv_ptr vec_full_reg_ptr(DisasContext *s, int regno)
> -{
> -    TCGv_ptr ret =3D tcg_temp_new_ptr();
> -    tcg_gen_addi_ptr(ret, cpu_env, vec_full_reg_offset(s, regno));
> -    return ret;
> -}
> -
> -/* Return the byte size of the "whole" vector register, VL / 8.  */
> -static inline int vec_full_reg_size(DisasContext *s)
> -{
> -    /* FIXME SVE: We should put the composite ZCR_EL* value into tb->fla=
gs.
> -       In the meantime this is just the AdvSIMD length of 128.  */
> -    return 128 / 8;
> -}
> -
>  /* Return the offset into CPUARMState of a slice (from
>   * the least significant end) of FP register Qn (ie
>   * Dn, Sn, Hn or Bn).
> @@ -620,7 +545,7 @@ static void clear_vec_high(DisasContext *s, bool is_q=
, int rd)
>      }
>  }
>
> -static void write_fp_dreg(DisasContext *s, int reg, TCGv_i64 v)
> +void write_fp_dreg(DisasContext *s, int reg, TCGv_i64 v)
>  {
>      unsigned ofs =3D fp_reg_offset(s, reg, MO_64);
>
> @@ -637,7 +562,7 @@ static void write_fp_sreg(DisasContext *s, int reg, T=
CGv_i32 v)
>      tcg_temp_free_i64(tmp);
>  }
>
> -static TCGv_ptr get_fpstatus_ptr(bool is_f16)
> +TCGv_ptr get_fpstatus_ptr(bool is_f16)
>  {
>      TCGv_ptr statusptr =3D tcg_temp_new_ptr();
>      int offset;
> @@ -3130,8 +3055,8 @@ static inline uint64_t bitmask64(unsigned int lengt=
h)
>   * value (ie should cause a guest UNDEF exception), and true if they are
>   * valid, in which case the decoded bit pattern is written to result.
>   */
> -static bool logic_imm_decode_wmask(uint64_t *result, unsigned int immn,
> -                                   unsigned int imms, unsigned int immr)
> +bool logic_imm_decode_wmask(uint64_t *result, unsigned int immn,
> +                            unsigned int imms, unsigned int immr)
>  {
>      uint64_t mask;
>      unsigned e, levels, s, r;
> @@ -5164,7 +5089,7 @@ static void disas_fp_3src(DisasContext *s, uint32_t=
 insn)
>   * the range 01....1xx to 10....0xx, and the most significant 4 bits of
>   * the mantissa; see VFPExpandImm() in the v8 ARM ARM.
>   */
> -static uint64_t vfp_expand_imm(int size, uint8_t imm8)
> +uint64_t vfp_expand_imm(int size, uint8_t imm8)
>  {
>      uint64_t imm;


--
Alex Benn=C3=A9e
