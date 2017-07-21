Received: from eggs.gnu.org ([2001:4830:134:3::10]:40222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dYZC1-0005me-KE
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dYZC0-0002J2-3f
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:46:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dYZBz-0002IR-QB
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:46:12 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 21 Jul 2017 16:45:56 +0200
Message-Id: <1500648359-25931-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1500648359-25931-1-git-send-email-thuth@redhat.com>
References: <1500648359-25931-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/5] target/s390x: Move diag helpers to a
 separate file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Cc: Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

misc_helper.c won't be compiled with --disable-tcg anymore, but we
still need the diag helpers in KVM builds, too, so move the helper
functions to a separate file.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/Makefile.objs |   2 +-
 target/s390x/diag.c        | 179 +++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/misc_helper.c | 167 ------------------------------------------
 3 files changed, 180 insertions(+), 168 deletions(-)
 create mode 100644 target/s390x/diag.c

diff --git a/target/s390x/Makefile.objs b/target/s390x/Makefile.objs
index 46f6a8c..8002852 100644
--- a/target/s390x/Makefile.objs
+++ b/target/s390x/Makefile.objs
@@ -1,7 +1,7 @@
 obj-y += translate.o helper.o cpu.o interrupt.o
 obj-y += int_helper.o fpu_helper.o cc_helper.o mem_helper.o misc_helper.o
 obj-y += gdbstub.o cpu_models.o cpu_features.o
-obj-$(CONFIG_SOFTMMU) += machine.o ioinst.o arch_dump.o mmu_helper.o
+obj-$(CONFIG_SOFTMMU) += machine.o ioinst.o arch_dump.o mmu_helper.o diag.o
 obj-$(CONFIG_KVM) += kvm.o
 
 # build and run feature list generator
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
new file mode 100644
index 0000000..10ac845
--- /dev/null
+++ b/target/s390x/diag.c
@@ -0,0 +1,179 @@
+/*
+ * S390x DIAG instruction helper functions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/address-spaces.h"
+#include "exec/exec-all.h"
+#include "hw/watchdog/wdt_diag288.h"
+#include "sysemu/cpus.h"
+#include "hw/s390x/ipl.h"
+
+static int modified_clear_reset(S390CPU *cpu)
+{
+    S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
+    CPUState *t;
+
+    pause_all_vcpus();
+    cpu_synchronize_all_states();
+    CPU_FOREACH(t) {
+        run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
+    }
+    s390_cmma_reset();
+    subsystem_reset();
+    s390_crypto_reset();
+    scc->load_normal(CPU(cpu));
+    cpu_synchronize_all_post_reset();
+    resume_all_vcpus();
+    return 0;
+}
+
+static int load_normal_reset(S390CPU *cpu)
+{
+    S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
+    CPUState *t;
+
+    pause_all_vcpus();
+    cpu_synchronize_all_states();
+    CPU_FOREACH(t) {
+        run_on_cpu(t, s390_do_cpu_reset, RUN_ON_CPU_NULL);
+    }
+    s390_cmma_reset();
+    subsystem_reset();
+    scc->initial_cpu_reset(CPU(cpu));
+    scc->load_normal(CPU(cpu));
+    cpu_synchronize_all_post_reset();
+    resume_all_vcpus();
+    return 0;
+}
+
+int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
+{
+    uint64_t func = env->regs[r1];
+    uint64_t timeout = env->regs[r1 + 1];
+    uint64_t action = env->regs[r3];
+    Object *obj;
+    DIAG288State *diag288;
+    DIAG288Class *diag288_class;
+
+    if (r1 % 2 || action != 0) {
+        return -1;
+    }
+
+    /* Timeout must be more than 15 seconds except for timer deletion */
+    if (func != WDT_DIAG288_CANCEL && timeout < 15) {
+        return -1;
+    }
+
+    obj = object_resolve_path_type("", TYPE_WDT_DIAG288, NULL);
+    if (!obj) {
+        return -1;
+    }
+
+    diag288 = DIAG288(obj);
+    diag288_class = DIAG288_GET_CLASS(diag288);
+    return diag288_class->handle_timer(diag288, func, timeout);
+}
+
+#define DIAG_308_RC_OK              0x0001
+#define DIAG_308_RC_NO_CONF         0x0102
+#define DIAG_308_RC_INVALID         0x0402
+
+void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3)
+{
+    uint64_t addr =  env->regs[r1];
+    uint64_t subcode = env->regs[r3];
+    IplParameterBlock *iplb;
+
+    if (env->psw.mask & PSW_MASK_PSTATE) {
+        program_interrupt(env, PGM_PRIVILEGED, ILEN_AUTO);
+        return;
+    }
+
+    if ((subcode & ~0x0ffffULL) || (subcode > 6)) {
+        program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO);
+        return;
+    }
+
+    switch (subcode) {
+    case 0:
+        modified_clear_reset(s390_env_get_cpu(env));
+        if (tcg_enabled()) {
+            cpu_loop_exit(CPU(s390_env_get_cpu(env)));
+        }
+        break;
+    case 1:
+        load_normal_reset(s390_env_get_cpu(env));
+        if (tcg_enabled()) {
+            cpu_loop_exit(CPU(s390_env_get_cpu(env)));
+        }
+        break;
+    case 3:
+        s390_reipl_request();
+        if (tcg_enabled()) {
+            cpu_loop_exit(CPU(s390_env_get_cpu(env)));
+        }
+        break;
+    case 5:
+        if ((r1 & 1) || (addr & 0x0fffULL)) {
+            program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO);
+            return;
+        }
+        if (!address_space_access_valid(&address_space_memory, addr,
+                                        sizeof(IplParameterBlock), false)) {
+            program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO);
+            return;
+        }
+        iplb = g_malloc0(sizeof(IplParameterBlock));
+        cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
+        if (!iplb_valid_len(iplb)) {
+            env->regs[r1 + 1] = DIAG_308_RC_INVALID;
+            goto out;
+        }
+
+        cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
+
+        if (!iplb_valid_ccw(iplb) && !iplb_valid_fcp(iplb)) {
+            env->regs[r1 + 1] = DIAG_308_RC_INVALID;
+            goto out;
+        }
+
+        s390_ipl_update_diag308(iplb);
+        env->regs[r1 + 1] = DIAG_308_RC_OK;
+out:
+        g_free(iplb);
+        return;
+    case 6:
+        if ((r1 & 1) || (addr & 0x0fffULL)) {
+            program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO);
+            return;
+        }
+        if (!address_space_access_valid(&address_space_memory, addr,
+                                        sizeof(IplParameterBlock), true)) {
+            program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO);
+            return;
+        }
+        iplb = s390_ipl_get_iplb();
+        if (iplb) {
+            cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->len));
+            env->regs[r1 + 1] = DIAG_308_RC_OK;
+        } else {
+            env->regs[r1 + 1] = DIAG_308_RC_NO_CONF;
+        }
+        return;
+    default:
+        hw_error("Unhandled diag308 subcode %" PRIx64, subcode);
+        break;
+    }
+}
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index b508101..6a90ad5 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -24,22 +24,15 @@
 #include "exec/memory.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
-#include "sysemu/kvm.h"
 #include "qemu/timer.h"
-#include "qemu/main-loop.h"
 #include "exec/address-spaces.h"
-#ifdef CONFIG_KVM
-#include <linux/kvm.h>
-#endif
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 
 #if !defined(CONFIG_USER_ONLY)
-#include "hw/watchdog/wdt_diag288.h"
 #include "sysemu/cpus.h"
 #include "sysemu/sysemu.h"
 #include "hw/s390x/ebcdic.h"
-#include "hw/s390x/ipl.h"
 #endif
 
 /* #define DEBUG_HELPER */
@@ -116,166 +109,6 @@ uint32_t HELPER(servc)(CPUS390XState *env, uint64_t r1, uint64_t r2)
     return r;
 }
 
-#ifndef CONFIG_USER_ONLY
-static int modified_clear_reset(S390CPU *cpu)
-{
-    S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
-    CPUState *t;
-
-    pause_all_vcpus();
-    cpu_synchronize_all_states();
-    CPU_FOREACH(t) {
-        run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
-    }
-    s390_cmma_reset();
-    subsystem_reset();
-    s390_crypto_reset();
-    scc->load_normal(CPU(cpu));
-    cpu_synchronize_all_post_reset();
-    resume_all_vcpus();
-    return 0;
-}
-
-static int load_normal_reset(S390CPU *cpu)
-{
-    S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
-    CPUState *t;
-
-    pause_all_vcpus();
-    cpu_synchronize_all_states();
-    CPU_FOREACH(t) {
-        run_on_cpu(t, s390_do_cpu_reset, RUN_ON_CPU_NULL);
-    }
-    s390_cmma_reset();
-    subsystem_reset();
-    scc->initial_cpu_reset(CPU(cpu));
-    scc->load_normal(CPU(cpu));
-    cpu_synchronize_all_post_reset();
-    resume_all_vcpus();
-    return 0;
-}
-
-int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
-{
-    uint64_t func = env->regs[r1];
-    uint64_t timeout = env->regs[r1 + 1];
-    uint64_t action = env->regs[r3];
-    Object *obj;
-    DIAG288State *diag288;
-    DIAG288Class *diag288_class;
-
-    if (r1 % 2 || action != 0) {
-        return -1;
-    }
-
-    /* Timeout must be more than 15 seconds except for timer deletion */
-    if (func != WDT_DIAG288_CANCEL && timeout < 15) {
-        return -1;
-    }
-
-    obj = object_resolve_path_type("", TYPE_WDT_DIAG288, NULL);
-    if (!obj) {
-        return -1;
-    }
-
-    diag288 = DIAG288(obj);
-    diag288_class = DIAG288_GET_CLASS(diag288);
-    return diag288_class->handle_timer(diag288, func, timeout);
-}
-
-#define DIAG_308_RC_OK              0x0001
-#define DIAG_308_RC_NO_CONF         0x0102
-#define DIAG_308_RC_INVALID         0x0402
-
-void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3)
-{
-    uint64_t addr =  env->regs[r1];
-    uint64_t subcode = env->regs[r3];
-    IplParameterBlock *iplb;
-
-    if (env->psw.mask & PSW_MASK_PSTATE) {
-        program_interrupt(env, PGM_PRIVILEGED, ILEN_AUTO);
-        return;
-    }
-
-    if ((subcode & ~0x0ffffULL) || (subcode > 6)) {
-        program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO);
-        return;
-    }
-
-    switch (subcode) {
-    case 0:
-        modified_clear_reset(s390_env_get_cpu(env));
-        if (tcg_enabled()) {
-            cpu_loop_exit(CPU(s390_env_get_cpu(env)));
-        }
-        break;
-    case 1:
-        load_normal_reset(s390_env_get_cpu(env));
-        if (tcg_enabled()) {
-            cpu_loop_exit(CPU(s390_env_get_cpu(env)));
-        }
-        break;
-    case 3:
-        s390_reipl_request();
-        if (tcg_enabled()) {
-            cpu_loop_exit(CPU(s390_env_get_cpu(env)));
-        }
-        break;
-    case 5:
-        if ((r1 & 1) || (addr & 0x0fffULL)) {
-            program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO);
-            return;
-        }
-        if (!address_space_access_valid(&address_space_memory, addr,
-                                        sizeof(IplParameterBlock), false)) {
-            program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO);
-            return;
-        }
-        iplb = g_malloc0(sizeof(IplParameterBlock));
-        cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
-        if (!iplb_valid_len(iplb)) {
-            env->regs[r1 + 1] = DIAG_308_RC_INVALID;
-            goto out;
-        }
-
-        cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
-
-        if (!iplb_valid_ccw(iplb) && !iplb_valid_fcp(iplb)) {
-            env->regs[r1 + 1] = DIAG_308_RC_INVALID;
-            goto out;
-        }
-
-        s390_ipl_update_diag308(iplb);
-        env->regs[r1 + 1] = DIAG_308_RC_OK;
-out:
-        g_free(iplb);
-        return;
-    case 6:
-        if ((r1 & 1) || (addr & 0x0fffULL)) {
-            program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO);
-            return;
-        }
-        if (!address_space_access_valid(&address_space_memory, addr,
-                                        sizeof(IplParameterBlock), true)) {
-            program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO);
-            return;
-        }
-        iplb = s390_ipl_get_iplb();
-        if (iplb) {
-            cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->len));
-            env->regs[r1 + 1] = DIAG_308_RC_OK;
-        } else {
-            env->regs[r1 + 1] = DIAG_308_RC_NO_CONF;
-        }
-        return;
-    default:
-        hw_error("Unhandled diag308 subcode %" PRIx64, subcode);
-        break;
-    }
-}
-#endif
-
 void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
 {
     uint64_t r;
-- 
1.8.3.1
