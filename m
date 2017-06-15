Received: from eggs.gnu.org ([2001:4830:134:3::10]:37561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dLQAP-000762-LD
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:30:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dLQAM-0005wf-HH
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:30:13 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:36065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dLQAM-0005w0-A6
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:30:10 -0400
Received: by mail-wr0-x232.google.com with SMTP id 36so11127877wry.3
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 01:30:10 -0700 (PDT)
References: <20170614194821.8754-1-rth@twiddle.net>
	<20170614194821.8754-6-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170614194821.8754-6-rth@twiddle.net>
Date: Thu, 15 Jun 2017 09:30:44 +0100
Message-ID: <87y3stmz4b.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 5/5] target/arm: Exit after clearing
 interrupt mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, cota@braap.org, pbonzini@redhat.com, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>


Richard Henderson <rth@twiddle.net> writes:

> Exit to cpu loop so we reevaluate cpu_arm_hw_interrupts.
>
> Cc: qemu-arm@nongnu.org
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  target/arm/translate-a64.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 860e279..e55547d 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -1422,7 +1422,9 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
>          gen_helper_msr_i_pstate(cpu_env, tcg_op, tcg_imm);
>          tcg_temp_free_i32(tcg_imm);
>          tcg_temp_free_i32(tcg_op);
> -        s->is_jmp = DISAS_UPDATE;
> +        /* For DAIFClear, exit the cpu loop to re-evaluate pending IRQs.  */
> +        gen_a64_set_pc_im(s->pc);
> +        s->is_jmp = (op == 0x1f ? DISAS_EXIT : DISAS_JUMP);
>          break;
>      }
>      default:
> @@ -11369,6 +11371,9 @@ void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb)
>          case DISAS_JUMP:
>              tcg_gen_lookup_and_goto_ptr(cpu_pc);
>              break;
> +        case DISAS_EXIT:
> +            tcg_gen_exit_tb(0);
> +            break;
>          case DISAS_TB_JUMP:
>          case DISAS_EXC:
>          case DISAS_SWI:


--
Alex Bennée
