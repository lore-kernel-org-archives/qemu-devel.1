Received: from eggs.gnu.org ([2001:4830:134:3::10]:33969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fptXk-0007nm-27
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 07:00:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fptXe-00044I-Gm
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 07:00:47 -0400
Date: Wed, 15 Aug 2018 13:00:02 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20180815110002.y5jmolo4bwp5fhm6@toto>
References: <20180814124254.5229-1-peter.maydell@linaro.org>
	<20180814124254.5229-10-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180814124254.5229-10-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 09/10] target/arm: Implement AArch32 ERET
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Luc Michel <luc.michel@greensocs.com>, edgari@xilinx.com

On Tue, Aug 14, 2018 at 01:42:53PM +0100, Peter Maydell wrote:
> ARMv7VE introduced the ERET instruction, which is necessary to
> return from an exception taken to Hyp mode. Implement this.
> In A32 encoding it is a completely new encoding; in T32 it
> is an adjustment of the behaviour of the existing
> "SUBS PC, LR, #<imm8>" instruction.


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 3f5751d4826..5ecc24f12fb 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -8887,6 +8887,25 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>              tcg_temp_free_i32(tmp2);
>              store_reg(s, rd, tmp);
>              break;
> +        case 0x6: /* ERET */
> +            if (op1 != 3) {
> +                goto illegal_op;
> +            }
> +            if (!arm_dc_feature(s, ARM_FEATURE_V7VE)) {
> +                goto illegal_op;
> +            }
> +            if ((insn & 0x000fff0f) != 0x0000000e) {
> +                /* UNPREDICTABLE; we choose to UNDEF */
> +                goto illegal_op;
> +            }
> +
> +            if (s->current_el == 2) {
> +                tmp = load_cpu_field(elr_el[2]);
> +            } else {
> +                tmp = load_reg(s, 14);
> +            }
> +            gen_exception_return(s, tmp);
> +            break;
>          case 7:
>          {
>              int imm16 = extract32(insn, 0, 4) | (extract32(insn, 8, 12) << 4);
> @@ -11144,8 +11163,16 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
>                          if (rn != 14 || rd != 15) {
>                              goto illegal_op;
>                          }
> -                        tmp = load_reg(s, rn);
> -                        tcg_gen_subi_i32(tmp, tmp, insn & 0xff);
> +                        if (s->current_el == 2) {
> +                            /* ERET from Hyp uses ELR_Hyp, not LR */
> +                            if (insn & 0xff) {
> +                                goto illegal_op;
> +                            }
> +                            tmp = load_cpu_field(elr_el[2]);
> +                        } else {
> +                            tmp = load_reg(s, rn);
> +                            tcg_gen_subi_i32(tmp, tmp, insn & 0xff);
> +                        }
>                          gen_exception_return(s, tmp);
>                          break;
>                      case 6: /* MRS */
> -- 
> 2.18.0
> 
