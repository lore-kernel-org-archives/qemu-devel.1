Received: from eggs.gnu.org ([2001:4830:134:3::10]:47248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fZzLX-0002EZ-LU
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fZzLW-0007z4-KW
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:58:27 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:38072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fZzLW-0007xj-EF
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:58:26 -0400
Received: by mail-pl0-x242.google.com with SMTP id d10-v6so8003557plo.5
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 06:58:26 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Mon,  2 Jul 2018 22:57:46 +0900
Message-Id: <20180702135806.7087-6-shorne@gmail.com>
In-Reply-To: <20180702135806.7087-1-shorne@gmail.com>
References: <20180702135806.7087-1-shorne@gmail.com>
Subject: [Qemu-devel] [PULL 05/25] target/openrisc: Use exit_tb instead of
 CPU_INTERRUPT_EXITTB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Development <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Stafford Horne <shorne@gmail.com>

From: Richard Henderson <richard.henderson@linaro.org>

No need to use the interrupt mechanisms when we can
simply exit the tb directly.

Reviewed-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/interrupt_helper.c | 3 +--
 target/openrisc/translate.c        | 6 +++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/openrisc/interrupt_helper.c b/target/openrisc/interrupt_helper.c
index 56620e0571..b865738f8b 100644
--- a/target/openrisc/interrupt_helper.c
+++ b/target/openrisc/interrupt_helper.c
@@ -26,7 +26,6 @@
 void HELPER(rfe)(CPUOpenRISCState *env)
 {
     OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
 #ifndef CONFIG_USER_ONLY
     int need_flush_tlb = (cpu->env.sr & (SR_SM | SR_IME | SR_DME)) ^
                          (cpu->env.esr & (SR_SM | SR_IME | SR_DME));
@@ -53,8 +52,8 @@ void HELPER(rfe)(CPUOpenRISCState *env)
     }
 
     if (need_flush_tlb) {
+        CPUState *cs = CPU(cpu);
         tlb_flush(cs);
     }
 #endif
-    cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
 }
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index f5af515979..43bdf378eb 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -37,6 +37,7 @@
 #include "exec/log.h"
 
 /* is_jmp field values */
+#define DISAS_EXIT    DISAS_TARGET_0  /* force exit to main loop */
 #define DISAS_UPDATE  DISAS_TARGET_1 /* cpu state was modified dynamically */
 
 typedef struct DisasContext {
@@ -1133,7 +1134,7 @@ static bool trans_l_rfe(DisasContext *dc, arg_l_rfe *a, uint32_t insn)
         gen_illegal_exception(dc);
     } else {
         gen_helper_rfe(cpu_env);
-        dc->base.is_jmp = DISAS_UPDATE;
+        dc->base.is_jmp = DISAS_EXIT;
     }
 #endif
     return true;
@@ -1353,8 +1354,7 @@ static void openrisc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         case DISAS_NORETURN:
             break;
         case DISAS_UPDATE:
-            /* indicate that the hash table must be used
-               to find the next TB */
+        case DISAS_EXIT:
             tcg_gen_exit_tb(NULL, 0);
             break;
         default:
-- 
2.17.0
