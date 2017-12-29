Received: from eggs.gnu.org ([2001:4830:134:3::10]:50812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDL-00036h-Gg
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDI-0004kn-B1
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:19 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:46063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoDI-0004jq-33
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:16 -0500
Received: by mail-pl0-x242.google.com with SMTP id o2so22510896plk.12
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:32:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:27 -0800
Message-Id: <20171229063145.29167-21-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 20/38] target/hppa: Implement the interval timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        |  2 ++
 target/hppa/helper.h     |  3 +++
 target/hppa/cpu.c        |  8 ++++++++
 target/hppa/int_helper.c |  6 ++++++
 target/hppa/op_helper.c  | 36 ++++++++++++++++++++++++++++++++++++
 target/hppa/translate.c  | 16 ++++++++++++----
 6 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index bd91ec57e6..156dbfd761 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -234,6 +234,7 @@ struct HPPACPU {
     /*< public >*/
 
     CPUHPPAState env;
+    QEMUTimer *alarm_timer;
 };
 
 static inline HPPACPU *hppa_env_get_cpu(CPUHPPAState *env)
@@ -343,6 +344,7 @@ int hppa_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw, int midx);
 int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
                               MMUAccessType type, hwaddr *pphys, int *pprot);
 extern const MemoryRegionOps hppa_io_eir_ops;
+void hppa_cpu_alarm_timer(void *);
 #endif
 
 #endif /* HPPA_CPU_H */
diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 535f086ab4..744b11cb66 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -77,9 +77,12 @@ DEF_HELPER_FLAGS_4(fmpynfadd_s, TCG_CALL_NO_RWG, i32, env, i32, i32, i32)
 DEF_HELPER_FLAGS_4(fmpyfadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(fmpynfadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
 
+DEF_HELPER_FLAGS_0(read_interval_timer, TCG_CALL_NO_RWG, tr)
+
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(rfi, void, env)
 DEF_HELPER_1(rfi_r, void, env)
+DEF_HELPER_FLAGS_2(write_interval_timer, TCG_CALL_NO_RWG, void, env, tr)
 DEF_HELPER_FLAGS_2(write_eirr, TCG_CALL_NO_RWG, void, env, tr)
 DEF_HELPER_FLAGS_2(write_eiem, TCG_CALL_NO_RWG, void, env, tr)
 DEF_HELPER_FLAGS_2(swap_system_mask, TCG_CALL_NO_RWG, tr, env, tr)
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 8e10649aaa..586b42067a 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -91,6 +91,14 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
 
     qemu_init_vcpu(cs);
     acc->parent_realize(dev, errp);
+
+#ifndef CONFIG_USER_ONLY
+    {
+        HPPACPU *cpu = HPPA_CPU(cs);
+        cpu->alarm_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                        hppa_cpu_alarm_timer, cpu);
+    }
+#endif
 }
 
 /* Sort hppabetically by type name. */
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 74ab34f306..ee72769544 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -67,6 +67,12 @@ const MemoryRegionOps hppa_io_eir_ops = {
     .impl.max_access_size = 4,
 };
 
+void hppa_cpu_alarm_timer(void *opaque)
+{
+    /* Raise interrupt 0.  */
+    io_eir_write(opaque, 0, 0, 4);
+}
+
 void HELPER(write_eirr)(CPUHPPAState *env, target_ureg val)
 {
     env->cr[CR_EIRR] &= ~val;
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 1963b2439b..6d19cab6c9 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -22,6 +22,8 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
+#include "qemu/timer.h"
+
 
 void QEMU_NORETURN HELPER(excp)(CPUHPPAState *env, int excp)
 {
@@ -602,7 +604,41 @@ float64 HELPER(fmpynfadd_d)(CPUHPPAState *env, float64 a, float64 b, float64 c)
     return ret;
 }
 
+target_ureg HELPER(read_interval_timer)(void)
+{
+#ifdef CONFIG_USER_ONLY
+    /* In user-mode, QEMU_CLOCK_VIRTUAL doesn't exist.
+       Just pass through the host cpu clock ticks.  */
+    return cpu_get_host_ticks();
+#else
+    /* In system mode we have access to a decent high-resolution clock.
+       In order to make OS-level time accounting work with the cr16,
+       present it with a well-timed clock fixed at 250MHz.  */
+    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) >> 2;
+#endif
+}
+
 #ifndef CONFIG_USER_ONLY
+void HELPER(write_interval_timer)(CPUHPPAState *env, target_ureg val)
+{
+    HPPACPU *cpu = hppa_env_get_cpu(env);
+    uint64_t current = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    uint64_t timeout;
+
+    /* Even in 64-bit mode, the comparator is always 32-bit.  But the
+       value we expose to the guest is 1/4 of the speed of the clock,
+       so moosh in 34 bits.  */
+    timeout = deposit64(current, 0, 34, (uint64_t)val << 2);
+
+    /* If the mooshing puts the clock in the past, advance to next round.  */
+    if (timeout < current + 1000) {
+        timeout += 1ULL << 34;
+    }
+
+    cpu->env.cr[CR_IT] = timeout;
+    timer_mod(cpu->alarm_timer, timeout);
+}
+
 target_ureg HELPER(swap_system_mask)(CPUHPPAState *env, target_ureg nsm)
 {
     target_ulong psw = env->psw;
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index ce2a6c21d6..77d3821924 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2029,6 +2029,7 @@ static DisasJumpType trans_mfctl(DisasContext *ctx, uint32_t insn,
     unsigned rt = extract32(insn, 0, 5);
     unsigned ctl = extract32(insn, 21, 5);
     TCGv_reg tmp;
+    DisasJumpType ret;
 
     switch (ctl) {
     case CR_SAR:
@@ -2047,9 +2048,17 @@ static DisasJumpType trans_mfctl(DisasContext *ctx, uint32_t insn,
         /* FIXME: Respect PSW_S bit.  */
         nullify_over(ctx);
         tmp = dest_gpr(ctx, rt);
-        tcg_gen_movi_reg(tmp, 0); /* FIXME */
+        if (ctx->base.tb->cflags & CF_USE_ICOUNT) {
+            gen_io_start();
+            gen_helper_read_interval_timer(tmp);
+            gen_io_end();
+            ret = DISAS_IAQ_N_STALE;
+        } else {
+            gen_helper_read_interval_timer(tmp);
+            ret = DISAS_NEXT;
+        }
         save_gpr(ctx, rt, tmp);
-        break;
+        return nullify_end(ctx, ret);
     case 26:
     case 27:
         break;
@@ -2123,9 +2132,8 @@ static DisasJumpType trans_mtctl(DisasContext *ctx, uint32_t insn,
     nullify_over(ctx);
     switch (ctl) {
     case CR_IT:
-        /* ??? modify interval timer offset */
+        gen_helper_write_interval_timer(cpu_env, reg);
         break;
-
     case CR_EIRR:
         gen_helper_write_eirr(cpu_env, reg);
         break;
-- 
2.14.3
