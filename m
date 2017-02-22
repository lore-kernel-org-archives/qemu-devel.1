Received: from eggs.gnu.org ([2001:4830:134:3::10]:42798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgUL0-0004EQ-Te
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:39:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgUKy-0002ls-5O
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:39:58 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487755788-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487755788-16415-9-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c023ac73-b983-885e-961c-f744b3c91cc6@twiddle.net>
Date: Wed, 22 Feb 2017 21:39:48 +1100
MIME-Version: 1.0
In-Reply-To: <1487755788-16415-9-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/11] target/ppc: update ov/ov32 for
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

On 02/22/2017 08:29 PM, Nikunj A Dadhania wrote:
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
>  target/ppc/translate.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index eecdfe9..2a9f508 100644
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
> @@ -1491,7 +1483,23 @@ static void gen_neg(DisasContext *ctx)
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

I think we just now covered this is wrong in the v1 thread.


> +    tcg_gen_neg_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
> +    if (unlikely(Rc(ctx->opcode))) {
> +        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
> +    }
> +    tcg_temp_free(t0);
> +    tcg_temp_free(zero);
>  }
>
>  /***                            Integer logical                            ***/
>
