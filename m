Received: from eggs.gnu.org ([2001:4830:134:3::10]:57255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5F-0003LG-7R
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5E-0004L7-5H
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:40:57 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:35480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fUz5D-0004J0-VW
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:40:56 -0400
Received: by mail-pg0-x242.google.com with SMTP id 15-v6so7928000pge.2
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 11:40:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Jun 2018 08:40:26 -1000
Message-Id: <20180618184046.6270-3-richard.henderson@linaro.org>
In-Reply-To: <20180618184046.6270-1-richard.henderson@linaro.org>
References: <20180618184046.6270-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 02/22] target/openrisc: Use exit_tb instead
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
index 2d7588a3eb..c7c1f40782 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -41,6 +41,7 @@
                   ## __VA_ARGS__)
 
 /* is_jmp field values */
+#define DISAS_EXIT    DISAS_TARGET_0  /* force exit to main loop */
 #define DISAS_UPDATE  DISAS_TARGET_1 /* cpu state was modified dynamically */
 
 typedef struct DisasContext {
@@ -1233,7 +1234,7 @@ static bool trans_l_rfe(DisasContext *dc, arg_l_rfe *a, uint32_t insn)
         gen_illegal_exception(dc);
     } else {
         gen_helper_rfe(cpu_env);
-        dc->base.is_jmp = DISAS_UPDATE;
+        dc->base.is_jmp = DISAS_EXIT;
     }
 #endif
     return true;
@@ -1467,8 +1468,7 @@ static void openrisc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
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
