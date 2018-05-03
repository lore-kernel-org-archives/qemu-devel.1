Received: from eggs.gnu.org ([2001:4830:134:3::10]:47715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEF0P-0007lN-Rj
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEF0O-0005z7-Np
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:14:45 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:39706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEF0O-0005yu-Ij
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:14:44 -0400
Received: by mail-ot0-x241.google.com with SMTP id l12-v6so20797433oth.6
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 07:14:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180427002651.28356-8-richard.henderson@linaro.org>
References: <20180427002651.28356-1-richard.henderson@linaro.org>
	<20180427002651.28356-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 May 2018 15:14:23 +0100
Message-ID: <CAFEAcA9iEoMonBRZ8d1005q71bU6CyKEjorHb2towDNUYvmBaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 7/9] target/arm: Fill in
 disas_ldst_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 27 April 2018 at 01:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
> This implements all of the v8.1-Atomics instructions except
> for compare-and-swap, which is decoded elsewhere.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 38 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 0706c8c394..6ed7627d79 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -84,6 +84,7 @@ typedef void NeonGenOneOpFn(TCGv_i64, TCGv_i64);
>  typedef void CryptoTwoOpFn(TCGv_ptr, TCGv_ptr);
>  typedef void CryptoThreeOpIntFn(TCGv_ptr, TCGv_ptr, TCGv_i32);
>  typedef void CryptoThreeOpFn(TCGv_ptr, TCGv_ptr, TCGv_ptr);
> +typedef void AtomicThreeOpFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGArg, TCGMemOp);
>
>  /* Note that the gvec expanders operate on offsets + sizes.  */
>  typedef void GVecGen2Fn(unsigned, uint32_t, uint32_t, uint32_t, uint32_t);
> @@ -2772,6 +2773,8 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
>      int rn = extract32(insn, 5, 5);
>      int o3_opc = extract32(insn, 12, 4);
>      int feature = ARM_FEATURE_V8_ATOMICS;
> +    TCGv_i64 tcg_rn, tcg_rs;
> +    AtomicThreeOpFn *fn;
>
>      if (is_vector) {
>          unallocated_encoding(s);
> @@ -2779,14 +2782,32 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
>      }
>      switch (o3_opc) {
>      case 000: /* LDADD */
> +        fn = tcg_gen_atomic_fetch_add_i64;
> +        break;
>      case 001: /* LDCLR */
> +        fn = tcg_gen_atomic_fetch_and_i64;
> +        break;
>      case 002: /* LDEOR */
> +        fn = tcg_gen_atomic_fetch_xor_i64;
> +        break;
>      case 003: /* LDSET */
> +        fn = tcg_gen_atomic_fetch_or_i64;
> +        break;
>      case 004: /* LDSMAX */
> +        fn = tcg_gen_atomic_fetch_smax_i64;
> +        break;
>      case 005: /* LDSMIN */
> +        fn = tcg_gen_atomic_fetch_smin_i64;
> +        break;
>      case 006: /* LDUMAX */
> +        fn = tcg_gen_atomic_fetch_umax_i64;
> +        break;
>      case 007: /* LDUMIN */
> +        fn = tcg_gen_atomic_fetch_umin_i64;
> +        break;
>      case 010: /* SWP */
> +        fn = tcg_gen_atomic_xchg_i64;
> +        break;
>      default:
>          unallocated_encoding(s);
>          return;
> @@ -2796,8 +2817,21 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
>          return;
>      }
>
> -    (void)rs;
> -    (void)rn;
> +    if (rn == 31) {
> +        gen_check_sp_alignment(s);
> +    }
> +    tcg_rn = cpu_reg_sp(s, rn);
> +    tcg_rs = read_cpu_reg(s, rs, false);
> +
> +    if (o3_opc == 1) { /* LDCLR */
> +        tcg_gen_not_i64(tcg_rs, tcg_rs);
> +    }
> +
> +    /* The tcg atomic primitives are all full barriers.  Therefore we
> +     * can ignore the Acquire and Release bits of this instruction.
> +     */
> +    fn(cpu_reg(s, rt), tcg_rn, tcg_rs, get_mem_index(s),
> +       s->be_data | size | MO_ALIGN);

Does this definitely do the arithmetic operation at the datatype
size and not the _i64 size ? (It makes a difference for example
with LDEORB if Rs has high bits set: the result should always
have [31:8] zero.)

Still missing LDAPR*, but otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

>  }
>
>  /* Load/store register (all forms) */
> --
> 2.14.3

thanks
-- PMM
