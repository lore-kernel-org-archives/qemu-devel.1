Received: from eggs.gnu.org ([2001:4830:134:3::10]:54047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLEHJ-00016i-GL
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLEHI-0008WD-Da
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:48:33 -0400
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 14 Jun 2017 12:48:21 -0700
Message-Id: <20170614194821.8754-6-rth@twiddle.net>
In-Reply-To: <20170614194821.8754-1-rth@twiddle.net>
References: <20170614194821.8754-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 5/5] target/arm: Exit after clearing
 interrupt mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, cota@braap.org, pbonzini@redhat.com, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

Exit to cpu loop so we reevaluate cpu_arm_hw_interrupts.

Cc: qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate-a64.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 860e279..e55547d 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1422,7 +1422,9 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
         gen_helper_msr_i_pstate(cpu_env, tcg_op, tcg_imm);
         tcg_temp_free_i32(tcg_imm);
         tcg_temp_free_i32(tcg_op);
-        s->is_jmp = DISAS_UPDATE;
+        /* For DAIFClear, exit the cpu loop to re-evaluate pending IRQs.  */
+        gen_a64_set_pc_im(s->pc);
+        s->is_jmp = (op == 0x1f ? DISAS_EXIT : DISAS_JUMP);
         break;
     }
     default:
@@ -11369,6 +11371,9 @@ void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb)
         case DISAS_JUMP:
             tcg_gen_lookup_and_goto_ptr(cpu_pc);
             break;
+        case DISAS_EXIT:
+            tcg_gen_exit_tb(0);
+            break;
         case DISAS_TB_JUMP:
         case DISAS_EXC:
         case DISAS_SWI:
-- 
2.9.4
