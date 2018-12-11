Received: from eggs.gnu.org ([2001:4830:134:3::10]:38331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWk9A-0004BY-CI
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:40:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWk98-00032v-Gr
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:40:31 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gWk98-00031k-9f
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:40:30 -0500
Received: by mail-oi1-x242.google.com with SMTP id v6so12355826oif.2
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 07:40:30 -0800 (PST)
MIME-Version: 1.0
References: <20181207103631.28193-1-richard.henderson@linaro.org>
	<20181207103631.28193-12-richard.henderson@linaro.org>
In-Reply-To: <20181207103631.28193-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Dec 2018 15:40:18 +0000
Message-ID: <CAFEAcA_rRBJNoSkVQXj=+-69aBOk7OAZyzUUKyvf4NQjg=g3iA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 11/26] target/arm: Rearrange decode in
 disas_uncond_b_reg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>

On Fri, 7 Dec 2018 at 10:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This will enable PAuth decode in a subsequent patch.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index c84c2dbb66..5fa2647771 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -1989,32 +1989,41 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
>      rn = extract32(insn, 5, 5);
>      op4 = extract32(insn, 0, 5);
>
> -    if (op4 != 0x0 || op3 != 0x0 || op2 != 0x1f) {
> -        unallocated_encoding(s);
> -        return;
> +    if (op2 != 0x1f) {
> +        goto do_unallocated;
>      }
>
>      switch (opc) {
>      case 0: /* BR */
>      case 1: /* BLR */
>      case 2: /* RET */
> -        gen_a64_set_pc(s, cpu_reg(s, rn));
> +        if (op3 == 0 && op4 == 0) {
> +            dst = cpu_reg(s, rn);
> +        } else {
> +            goto do_unallocated;
> +        }
> +        gen_a64_set_pc(s, dst);
>          /* BLR also needs to load return address */
>          if (opc == 1) {
>              tcg_gen_movi_i64(cpu_reg(s, 30), s->pc);
>          }
>          break;
> +
>      case 4: /* ERET */
>          if (s->current_el == 0) {
> -            unallocated_encoding(s);
> -            return;
> -        }
> -        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
> -            gen_io_start();
> +            goto do_unallocated;
>          }
>          dst = tcg_temp_new_i64();
>          tcg_gen_ld_i64(dst, cpu_env,
>                         offsetof(CPUARMState, elr_el[s->current_el]));
> +        if (op3 == 0 && op4 == 0) {
> +            ;
> +        } else {
> +            goto do_unallocated;


This decode check should go before any code has been
emittede (ie before the tcg_gen_ld_i64 above it).

> +        }
> +        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
> +            gen_io_start();
> +        }
>          gen_helper_exception_return(cpu_env, dst);
>          tcg_temp_free_i64(dst);
>          if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
> @@ -2023,14 +2032,17 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
>          /* Must exit loop to check un-masked IRQs */
>          s->base.is_jmp = DISAS_EXIT;
>          return;
> +
>      case 5: /* DRPS */
> -        if (rn != 0x1f) {
> -            unallocated_encoding(s);
> +        if (op3 != 0 || op4 != 0 || rn != 0x1f) {
> +            goto do_unallocated;
>          } else {
>              unsupported_encoding(s, insn);
>          }
>          return;
> +
>      default:
> +    do_unallocated:
>          unallocated_encoding(s);
>          return;
>      }

thanks
-- PMM
