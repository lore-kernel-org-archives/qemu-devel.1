Received: from eggs.gnu.org ([2001:4830:134:3::10]:40110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekDVO-00073d-DB
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:34:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekDVJ-0002em-23
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:34:38 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:36132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekDVI-0002bt-TP
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:34:32 -0500
Received: by mail-pl0-x243.google.com with SMTP id v3so1838415plg.3
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 10:34:32 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-32-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <669dcbee-8a38-f123-fc2d-d54926ecb270@linaro.org>
Date: Fri, 9 Feb 2018 10:34:28 -0800
MIME-Version: 1.0
In-Reply-To: <20180208173157.24705-32-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 31/32] arm/translate-a64: implement
 simd_scalar_three_reg_same_fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 02/08/2018 09:31 AM, Alex Bennée wrote:
> This covers the encoding group:
> 
>   Advanced SIMD scalar three same FP16
> 
> As all the helpers are already there it is simply a case of calling the
> existing helpers in the scalar context.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - checkpatch fixes
> ---
>  target/arm/translate-a64.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index b094399fb4..92adf43a89 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -7764,6 +7764,99 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
>      tcg_temp_free_i64(tcg_rd);
>  }
>  
> +/* AdvSIMD scalar three same FP16
> + *  31 30  29 28       24 23  22 21 20  16 15 14 13    11 10  9  5 4  0
> + * +-----+---+-----------+---+-----+------+-----+--------+---+----+----+
> + * | 0 1 | U | 1 1 1 1 0 | a | 1 0 |  Rm  | 0 0 | opcode | 1 | Rn | Rd |
> + * +-----+---+-----------+---+-----+------+-----+--------+---+----+----+
> + * v: 0101 1110 0100 0000 0000 0100 0000 0000 => 5e400400
> + * m: 1101 1111 0110 0000 1100 0100 0000 0000 => df60c400
> + */
> +static void disas_simd_scalar_three_reg_same_fp16(DisasContext *s, uint32_t insn)
> +{
> +    int rd = extract32(insn, 0, 5);
> +    int rn = extract32(insn, 5, 5);
> +    int opcode = extract32(insn, 11, 3);
> +    int rm = extract32(insn, 16, 5);
> +    bool u = extract32(insn, 29, 1);
> +    bool a = extract32(insn, 23, 1);
> +    int fpopcode = opcode | (a << 3) |  (u << 4);
> +    TCGv_ptr fpst;
> +    TCGv_i32 tcg_op1;
> +    TCGv_i32 tcg_op2;
> +    TCGv_i32 tcg_res;
> +
> +    switch (fpopcode) {
> +    case 0x03: /* FMULX */
> +    case 0x04: /* FCMEQ (reg) */
> +    case 0x07: /* FRECPS */
> +    case 0x0f: /* FRSQRTS */
> +    case 0x14: /* FCMGE (reg) */
> +    case 0x15: /* FACGE */
> +    case 0x1a: /* FABD */
> +    case 0x1c: /* FCMGT (reg) */
> +    case 0x1d: /* FACGT */
> +        break;
> +    default:
> +        unallocated_encoding(s);
> +        return;
> +    }
> +
> +    if (!fp_access_check(s)) {
> +        return;
> +    }

Missing test for fp16 enabled.

> @@ -9991,6 +10084,8 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
>                  gen_helper_advsimd_minh(tcg_res[pass], tcg_op1, tcg_op2, fpst);
>                  break;
>              default:
> +                fprintf(stderr, "%s: insn %#04x, fpop %#2x @ %#" PRIx64 "\n",
> +                        __func__, insn, fpopcode, s->pc);

Leftover debug.


r~
