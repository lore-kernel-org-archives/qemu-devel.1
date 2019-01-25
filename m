Received: from eggs.gnu.org ([209.51.188.92]:37822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnAe7-0005QF-Rg
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:12:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnAPc-0005NL-Iu
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:57:25 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnAPc-0005MS-6r
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:57:24 -0500
Received: by mail-pl1-x644.google.com with SMTP id p8so5208196plo.2
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 14:57:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 25 Jan 2019 14:57:12 -0800
Message-Id: <20190125225714.10234-6-richard.henderson@linaro.org>
In-Reply-To: <20190125225714.10234-1-richard.henderson@linaro.org>
References: <20190125225714.10234-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 4/6] linux-user: Initialize aarch64 pac keys
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

Initialize the keys to a non-zero value on process start.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_syscall.h |  2 ++
 linux-user/aarch64/cpu_loop.c       | 31 +++++++++++++++++++++++++++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/linux-user/aarch64/target_syscall.h b/linux-user/aarch64/target_syscall.h
index 205265e619..937fd7989e 100644
--- a/linux-user/aarch64/target_syscall.h
+++ b/linux-user/aarch64/target_syscall.h
@@ -22,4 +22,6 @@ struct target_pt_regs {
 #define TARGET_PR_SVE_SET_VL  50
 #define TARGET_PR_SVE_GET_VL  51
 
+void arm_init_pauth_key(ARMPACKey *key);
+
 #endif /* AARCH64_TARGET_SYSCALL_H */
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 65d815f030..d75fd9d3e2 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -147,10 +147,29 @@ void cpu_loop(CPUARMState *env)
     }
 }
 
+static uint64_t arm_rand64(void)
+{
+    int shift = 64 - clz64(RAND_MAX);
+    int i, n = 64 / shift + (64 % shift != 0);
+    uint64_t ret = 0;
+
+    for (i = 0; i < n; i++) {
+        ret = (ret << shift) | rand();
+    }
+    return ret;
+}
+
+void arm_init_pauth_key(ARMPACKey *key)
+{
+    key->lo = arm_rand64();
+    key->hi = arm_rand64();
+}
+
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
-    CPUState *cpu = ENV_GET_CPU(env);
-    TaskState *ts = cpu->opaque;
+    ARMCPU *cpu = arm_env_get_cpu(env);
+    CPUState *cs = CPU(cpu);
+    TaskState *ts = cs->opaque;
     struct image_info *info = ts->info;
     int i;
 
@@ -172,6 +191,14 @@ void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
     }
 #endif
 
+    if (cpu_isar_feature(aa64_pauth, cpu)) {
+        arm_init_pauth_key(&env->apia_key);
+        arm_init_pauth_key(&env->apib_key);
+        arm_init_pauth_key(&env->apda_key);
+        arm_init_pauth_key(&env->apdb_key);
+        arm_init_pauth_key(&env->apga_key);
+    }
+
     ts->stack_base = info->start_stack;
     ts->heap_base = info->brk;
     /* This will be filled in on the first SYS_HEAPINFO call.  */
-- 
2.17.2
