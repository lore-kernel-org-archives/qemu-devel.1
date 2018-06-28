Received: from eggs.gnu.org ([2001:4830:134:3::10]:39872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYNDh-0004uh-UT
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYNDg-0007eQ-Tl
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:41 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:40768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYNDg-0007eC-O1
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:40 -0400
Received: by mail-pl0-x242.google.com with SMTP id t6-v6so2010179plo.7
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 20:03:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 27 Jun 2018 20:03:12 -0700
Message-Id: <20180628030330.15615-6-richard.henderson@linaro.org>
In-Reply-To: <20180628030330.15615-1-richard.henderson@linaro.org>
References: <20180628030330.15615-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 05/23] target/openrisc: Use exit_tb instead
 of CPU_INTERRUPT_EXITTB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: shorne@gmail.com

No need to use the interrupt mechanisms when we can
simply exit the tb directly.

Reviewed-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.17.1
