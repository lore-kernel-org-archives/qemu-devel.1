Received: from eggs.gnu.org ([2001:4830:134:3::10]:33424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN1GL-0008Sr-ML
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN1GK-0002JA-O2
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:57 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:32778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dN1GK-0002Ij-I8
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:56 -0400
Received: by mail-pf0-x241.google.com with SMTP id w12so18592149pfk.0
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 11:18:56 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 19 Jun 2017 11:18:39 -0700
Message-Id: <20170619181839.25249-13-rth@twiddle.net>
In-Reply-To: <20170619181839.25249-1-rth@twiddle.net>
References: <20170619181839.25249-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/12] target/arm: Exit after clearing aarch64
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
Cc: peter.maydell@linaro.org

Exit to cpu loop so we reevaluate cpu_arm_hw_interrupts.

Tested-by: Emilio G. Cota <cota@braap.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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
