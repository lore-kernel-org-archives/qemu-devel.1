Received: from eggs.gnu.org ([2001:4830:134:3::10]:35340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLEz8-0004G1-0c
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLEz6-0006yR-Vg
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:33:50 -0400
Date: Wed, 14 Jun 2017 16:33:43 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170614203343.GB8420@flamenco>
References: <20170614194821.8754-1-rth@twiddle.net>
	<20170614194821.8754-6-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170614194821.8754-6-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH] target/aarch64: exit to main loop after 'msr
 daifclr'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, pbonzini@redhat.com, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Wed, Jun 14, 2017 at 12:48:21 -0700, Richard Henderson wrote:
> Exit to cpu loop so we reevaluate cpu_arm_hw_interrupts.
> 
> Cc: qemu-arm@nongnu.org
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
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

For op != 0x1f we end up setting the pc twice (first here, then in
the switch statement). It's still correct though.

> +        s->is_jmp = (op == 0x1f ? DISAS_EXIT : DISAS_JUMP);

Could do without the parens.

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

We could also mention the regression in the commit log. In fact
I just did that :-) feel free to reuse parts of the below.

Thanks,

		E.

--- 8< ---

Commit e75449a3 ("target/aarch64: optimize indirect branches") causes
a regression by which -smp > 1 freezes under TCG, even with
`-accel accel=tcg,thread=single' (i.e. MTTCG disabled).

The cause of the regression is well described here by Alex:
On Wed, Jun 14, 2017 at 15:02:06 +0100, Alex Bennée wrote:
> Fundamentally the problem was that an interrupt was pending
> (interrupt_request was set) but the "msr daifclr" operations when the
> kernel did local_irq/fiq_enable() never got handled because the
> cpu_idle loop was being very efficiently chained. As a result we never
> got around to exiting the TCG code and calling arm_cpu_do_interrupt
> which would then raise the IRQ to move things on
> [ Message-Id: <20170614140209.29847-1-alex.bennee@linaro.org> ]

Fix it by enforcing an exit to the main loop right after 'msr daifclr'
is executed.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/arm/translate-a64.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 860e279..323e419 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1422,7 +1422,8 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
         gen_helper_msr_i_pstate(cpu_env, tcg_op, tcg_imm);
         tcg_temp_free_i32(tcg_imm);
         tcg_temp_free_i32(tcg_op);
-        s->is_jmp = DISAS_UPDATE;
+        /* force exit to the main loop for DAIFClear */
+        s->is_jmp = op == 0x1f ? DISAS_EXIT : DISAS_UPDATE;
         break;
     }
     default:
@@ -11362,6 +11363,10 @@ void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb)
         case DISAS_NEXT:
             gen_goto_tb(dc, 1, dc->pc);
             break;
+        case DISAS_EXIT:
+            gen_a64_set_pc_im(dc->pc);
+            tcg_gen_exit_tb(0);
+            break;
         default:
         case DISAS_UPDATE:
             gen_a64_set_pc_im(dc->pc);
-- 
2.7.4
