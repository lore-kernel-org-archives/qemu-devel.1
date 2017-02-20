Received: from eggs.gnu.org ([2001:4830:134:3::10]:55095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cfu3x-0005GQ-IW
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:55:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cfu3u-0002WH-WA
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:55:57 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487585521-19445-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487585521-19445-8-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <165844eb-e94c-1955-2fe3-59f0a3931094@twiddle.net>
Date: Tue, 21 Feb 2017 06:55:46 +1100
MIME-Version: 1.0
In-Reply-To: <1487585521-19445-8-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 07/10] target/ppc: update ov/ov32 for
 nego
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

On 02/20/2017 09:11 PM, Nikunj A Dadhania wrote:
> For 64-bit mode if the register RA contains 0x8000_0000_0000_0000, OV
> and OV32 are set to 1.
>
> For 32-bit mode if the register RA contains 0x8000_0000, OV and OV32 are
> set to 1.
>
> Use the tcg-ops for negation (neg_tl) and drop gen_op_arith_neg() as
> nego was the last user.
>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  target/ppc/translate.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 9fa3b5a..0168e1c 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -1473,14 +1473,6 @@ static void gen_subfic(DisasContext *ctx)
>  }
>
>  /* neg neg. nego nego. */
> -static inline void gen_op_arith_neg(DisasContext *ctx, bool compute_ov)
> -{
> -    TCGv zero = tcg_const_tl(0);
> -    gen_op_arith_subf(ctx, cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
> -                      zero, 0, 0, compute_ov, Rc(ctx->opcode));
> -    tcg_temp_free(zero);
> -}
> -
>  static void gen_neg(DisasContext *ctx)
>  {
>      tcg_gen_neg_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
> @@ -1488,7 +1480,20 @@ static void gen_neg(DisasContext *ctx)
>
>  static void gen_nego(DisasContext *ctx)
>  {
> -    gen_op_arith_neg(ctx, 1);
> +    TCGv t0 = tcg_temp_new();
> +    TCGv zero = tcg_const_tl(0);
> +
> +    if (NARROW_MODE(ctx)) {
> +        tcg_gen_xori_tl(t0, cpu_gpr[rA(ctx->opcode)], INT32_MIN);
> +    } else {
> +        tcg_gen_xori_tl(t0, cpu_gpr[rA(ctx->opcode)], (target_ulong)INT64_MIN);
> +    }
> +
> +    tcg_gen_setcond_tl(TCG_COND_EQ, cpu_ov, t0, zero);
> +    tcg_gen_mov_tl(cpu_ov32, cpu_ov);
> +    tcg_gen_neg_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
> +    tcg_temp_free(t0);
> +    tcg_temp_free(zero);
>  }

Again, you're forgetting "nego.".  Don't try to simplify from gen_op_arith_subf 
by hand.


r~
