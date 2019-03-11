Received: from eggs.gnu.org ([209.51.188.92]:34252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h3Qaw-00042z-9e
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:28:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h3QPT-0007gO-KQ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:16:28 -0400
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:40483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1h3QPT-0007XF-Br
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:16:27 -0400
From: Sven Schnelle <svens@stackframe.org>
Date: Mon, 11 Mar 2019 20:16:02 +0100
Message-Id: <20190311191602.25796-12-svens@stackframe.org>
In-Reply-To: <20190311191602.25796-1-svens@stackframe.org>
References: <20190311191602.25796-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 11/11] target/hppa: call eval_interrupt() after
 ssm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>

HP-UX (all versions) is losing timer interrupts, which leads to
hangs. Pressing a key on the console fixes this, so it looks like
QEMU is just looping trough TBs without checking for interrupts.
Further investion showed that this happens when interrupts are
triggered, without PSW_I enabled. Calling eval_interrupt() after
PSW_I is set seems to fix this.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/cpu.h        | 1 +
 target/hppa/int_helper.c | 2 +-
 target/hppa/op_helper.c  | 6 ++++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index d808796ee3..3440ccad28 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -366,5 +366,6 @@ void hppa_cpu_alarm_timer(void *);
 int hppa_artype_for_page(CPUHPPAState *env, target_ulong vaddr);
 #endif
 void QEMU_NORETURN hppa_dynamic_excp(CPUHPPAState *env, int excp, uintptr_t ra);
+void eval_interrupt(HPPACPU *cpu);
 
 #endif /* HPPA_CPU_H */
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 8d5edd3a20..e3acaa39eb 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -25,7 +25,7 @@
 #include "qom/cpu.h"
 
 #ifndef CONFIG_USER_ONLY
-static void eval_interrupt(HPPACPU *cpu)
+void eval_interrupt(HPPACPU *cpu)
 {
     CPUState *cs = CPU(cpu);
     if (cpu->env.cr[CR_EIRR] & cpu->env.cr[CR_EIEM]) {
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index a55a5dfc02..f93211c84f 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -662,6 +662,7 @@ void HELPER(reset)(CPUHPPAState *env)
 
 target_ureg HELPER(swap_system_mask)(CPUHPPAState *env, target_ureg nsm)
 {
+    HPPACPU *cpu = hppa_env_get_cpu(env);
     target_ulong psw = env->psw;
     /*
      * Setting the PSW Q bit to 1, if it was not already 1, is an
@@ -673,6 +674,11 @@ target_ureg HELPER(swap_system_mask)(CPUHPPAState *env, target_ureg nsm)
      * so let this go without comment.
      */
     env->psw = (psw & ~PSW_SM) | (nsm & PSW_SM);
+    if (!(psw & PSW_I) && (nsm & PSW_I)) {
+        qemu_mutex_lock_iothread();
+        eval_interrupt(cpu);
+        qemu_mutex_unlock_iothread();
+    }
     return psw & PSW_SM;
 }
 
-- 
2.20.1
