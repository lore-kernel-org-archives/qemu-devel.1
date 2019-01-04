Received: from eggs.gnu.org ([208.118.235.92]:38872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfUaB-0005kE-LY
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 13:52:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfUaA-0003WJ-RH
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 13:52:35 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfUaA-0003VV-MV
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 13:52:34 -0500
Received: by mail-ot1-x344.google.com with SMTP id w25so32833246otm.13
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 10:52:34 -0800 (PST)
MIME-Version: 1.0
References: <20181214052410.11863-1-richard.henderson@linaro.org>
	<20181214052410.11863-14-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jan 2019 18:52:22 +0000
Message-ID: <CAFEAcA_at=1SroQBFa14r4cPtFsxoTJLvpgKfyO7DiFjBkT=oQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 13/27] target/arm: Decode Load/store
 register (pac)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 14 Dec 2018 at 05:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Not that there are any stores involved, but why argue with ARM's
> naming convention.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 62 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index e62d248894..c57c89d98a 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -3146,6 +3146,65 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
>         s->be_data | size | MO_ALIGN);
>  }
>
> +/* PAC memory operations
> + *
> + *  31  30      27  26    24    22  21       12  11  10    5     0
> + * +------+-------+---+-----+-----+---+--------+---+---+----+-----+
> + * | size | 1 1 1 | V | 0 0 | M S | 1 |  imm9  | W | 1 | Rn |  Rt |
> + * +------+-------+---+-----+-----+------------+---+---+----+-----+
> + *
> + * Rt: the result register
> + * Rn: base address or SP
> + * Rs: the source register for the operation
> + * V: vector flag (always 0 as of v8.3)
> + * M: clear for key DA, set for key DB
> + * W: pre-indexing flag
> + * S: sign for imm9.
> + */
> +static void disas_ldst_pac(DisasContext *s, uint32_t insn,
> +                           int size, int rt, bool is_vector)
> +{
> +    int rn = extract32(insn, 5, 5);
> +    bool is_wback = extract32(insn, 11, 1);
> +    bool use_key_a = !extract32(insn, 23, 1);
> +    int offset, memidx;
> +    TCGv_i64 tcg_addr, tcg_rt;
> +
> +    if (size != 3 || is_vector || !dc_isar_feature(aa64_pauth, s)) {
> +        unallocated_encoding(s);
> +        return;
> +    }
> +
> +    if (rn == 31) {
> +        gen_check_sp_alignment(s);
> +    }
> +    tcg_addr = read_cpu_reg_sp(s, rn, 1);
> +
> +    if (s->pauth_active) {
> +        if (use_key_a) {
> +            gen_helper_autda(tcg_addr, cpu_env, tcg_addr, cpu_X[31]);
> +        } else {
> +            gen_helper_autdb(tcg_addr, cpu_env, tcg_addr, cpu_X[31]);
> +        }
> +    }
> +
> +    /* Form the 10-bit signed, scaled offset.  */
> +    offset = (extract32(insn, 22, 1) << 9) | extract32(insn, 12, 9);
> +    offset = sextract32(offset << size, 10 + size, 0);
> +    tcg_gen_addi_i64(tcg_addr, tcg_addr, offset);
> +
> +    tcg_rt = cpu_reg(s, rt);
> +    memidx = get_mem_index(s);
> +    do_gpr_ld_memidx(s, tcg_rt, tcg_addr, size,
> +                     /* is_signed */ false, /* extend */ false, memidx,
> +                     /* iss_valid */ true, /* iss_srt */ rt,
> +                     /* iss_sf */ true, /* iss_ar */ false);

Since you don't have the "memidx might be something other than
the result of get_mem_index()" case to worry about, you could
use do_gpr_ld() here.

ISS information is not valid for accesses which do writeback.
(We seem to get this wrong in the existing disas_ldst_reg_imm9()...)

> +
> +    if (is_wback) {
> +        tcg_gen_mov_i64(cpu_reg_sp(s, rn), tcg_addr);
> +    }
> +}
> +
>  /* Load/store register (all forms) */
>  static void disas_ldst_reg(DisasContext *s, uint32_t insn)
>  {
> @@ -3171,6 +3230,9 @@ static void disas_ldst_reg(DisasContext *s, uint32_t insn)
>          case 2:
>              disas_ldst_reg_roffset(s, insn, opc, size, rt, is_vector);
>              return;
> +        default:
> +            disas_ldst_pac(s, insn, size, rt, is_vector);
> +            return;
>          }
>          break;
>      case 1:
> --
> 2.17.2
>

thanks
-- PMM
