Received: from eggs.gnu.org ([2001:4830:134:3::10]:43326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEEmO-0002LD-6J
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:00:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEEmJ-0007UK-Ul
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:00:16 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:33190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEEmJ-0007T3-Nk
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:00:11 -0400
Received: by mail-ot0-x242.google.com with SMTP id l22-v6so20741538otj.0
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 07:00:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180427002651.28356-7-richard.henderson@linaro.org>
References: <20180427002651.28356-1-richard.henderson@linaro.org>
	<20180427002651.28356-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 May 2018 14:59:49 +0100
Message-ID: <CAFEAcA_trFkyHOofragLEKpsNP67t4-3ZbSyCAgU2nYG75Zg5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 6/9] target/arm: Introduce
 ARM_FEATURE_V8_ATOMICS and initial decode
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
> The insns in the ARMv8.1-Atomics are added to the existing
> load/store exclusive and load/store reg opcode spaces.
> Rearrange the top-level decoders for these to accomodate.
> The Atomics insns themselves still generate Unallocated.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> +    case 0x4: /* LDXR */
> +    case 0x5: /* LDAXR */
> +        if (rn == 31) {
> +            gen_check_sp_alignment(s);
>          }
> -    } else {
> -        TCGv_i64 tcg_rt = cpu_reg(s, rt);
> -        bool iss_sf = disas_ldst_compute_iss_sf(size, false, 0);
> +        tcg_addr = read_cpu_reg_sp(s, rn, 1);
> +        s->is_ldex = true;
> +        gen_load_exclusive(s, rt, rt2, tcg_addr, size, false);
> +        if (is_lasr) {
> +            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
> +        }
> +        return;
>
> +    case 0x9: /* STLR */
>          /* Generate ISS for non-exclusive accesses including LASR.  */
> -        if (is_store) {
> +        if (rn == 31) {
> +            gen_check_sp_alignment(s);
> +        }
> +        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
> +        tcg_addr = read_cpu_reg_sp(s, rn, 1);
> +        do_gpr_st(s, cpu_reg(s, rt), tcg_addr, size, true, rt,
> +                  disas_ldst_compute_iss_sf(size, false, 0), is_lasr);
> +        return;
> +
> +    case 0xd: /* LDARB */

should be /* LDAR */ to match lack of size suffixes on other
comments in the switch ?

> +        /* Generate ISS for non-exclusive accesses including LASR.  */
> +        if (rn == 31) {
> +            gen_check_sp_alignment(s);
> +        }
> +        tcg_addr = read_cpu_reg_sp(s, rn, 1);
> +        do_gpr_ld(s, cpu_reg(s, rt), tcg_addr, size, false, false, true, rt,
> +                  disas_ldst_compute_iss_sf(size, false, 0), is_lasr);
> +        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
> +        return;
> +
> +    case 0x2: case 0x3: /* CASP / STXP */
> +        if (size & 2) { /* STXP / STLXP */
> +            if (rn == 31) {
> +                gen_check_sp_alignment(s);
> +            }
>              if (is_lasr) {
>                  tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
>              }
> -            do_gpr_st(s, tcg_rt, tcg_addr, size,
> -                      true, rt, iss_sf, is_lasr);
> -        } else {
> -            do_gpr_ld(s, tcg_rt, tcg_addr, size, false, false,
> -                      true, rt, iss_sf, is_lasr);
> +            tcg_addr = read_cpu_reg_sp(s, rn, 1);
> +            gen_store_exclusive(s, rs, rt, rt2, tcg_addr, size, true);
> +            return;
> +        }
> +        /* CASP / CASPL */
> +        break;
> +
> +    case 0x6: case 0x7: /* CASP / LDXP */
> +        if (size & 2) { /* LDXP / LDAXP */
> +            if (rn == 31) {
> +                gen_check_sp_alignment(s);
> +            }
> +            tcg_addr = read_cpu_reg_sp(s, rn, 1);
> +            s->is_ldex = true;
> +            gen_load_exclusive(s, rt, rt2, tcg_addr, size, true);
>              if (is_lasr) {
>                  tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
>              }
> +            return;
>          }
> +        /* CASPA / CASPAL */
> +        break;
> +
> +    case 0xa: /* CAS */
> +    case 0xb: /* CASL */
> +    case 0xe: /* CASA */
> +    case 0xf: /* CASAL */
> +        break;
>      }
> +    unallocated_encoding(s);
>  }
>
>  /*
> @@ -2715,6 +2751,55 @@ static void disas_ldst_reg_unsigned_imm(DisasContext *s, uint32_t insn,
>      }
>  }
>
> +/* Atomic memory operations
> + *
> + *  31  30      27  26    24    22  21   16   15    12    10    5     0
> + * +------+-------+---+-----+-----+---+----+----+-----+-----+----+-----+
> + * | size | 1 1 1 | V | 0 0 | A R | 1 | Rs | o3 | opc | 0 0 | Rn |  Rt |
> + * +------+-------+---+-----+-----+--------+----+-----+-----+----+-----+
> + *
> + * Rt: the result register
> + * Rn: base address or SP
> + * Rs: the source register for the operation
> + * V: vector flag (always 0 as of v8.3)
> + * A: acquire flag
> + * R: release flag
> + */
> +static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
> +                              int size, int rt, bool is_vector)
> +{
> +    int rs = extract32(insn, 16, 5);
> +    int rn = extract32(insn, 5, 5);
> +    int o3_opc = extract32(insn, 12, 4);
> +    int feature = ARM_FEATURE_V8_ATOMICS;
> +
> +    if (is_vector) {
> +        unallocated_encoding(s);
> +        return;
> +    }
> +    switch (o3_opc) {
> +    case 000: /* LDADD */
> +    case 001: /* LDCLR */
> +    case 002: /* LDEOR */
> +    case 003: /* LDSET */
> +    case 004: /* LDSMAX */
> +    case 005: /* LDSMIN */
> +    case 006: /* LDUMAX */
> +    case 007: /* LDUMIN */
> +    case 010: /* SWP */

I can see why you've used octal constants here, but I think they're
probably going to be more confusing than helpful since they're
so rare in our codebase.

What about LDAPRB, LDAPRH, LDAPR (which are o3_opc == 0b1100) ?

> +    default:
> +        unallocated_encoding(s);
> +        return;
> +    }
> +    if (!arm_dc_feature(s, feature)) {
> +        unallocated_encoding(s);
> +        return;
> +    }
> +
> +    (void)rs;
> +    (void)rn;
> +}

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
