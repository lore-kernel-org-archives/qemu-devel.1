Received: from eggs.gnu.org ([2001:4830:134:3::10]:42762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cUc73-0002BR-CY
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:32:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cUc6z-0004wh-Bb
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:32:29 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:41775)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Julian_Brown@mentor.com>)
	id 1cUc6z-0004w2-2M
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:32:25 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=SVR-IES-MBX-04.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1cUc6x-0005Yn-QW from Julian_Brown@mentor.com
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:32:24 -0800
From: Julian Brown <julian@codesourcery.com>
Date: Fri, 20 Jan 2017 08:32:06 -0800
Message-ID: <b583e38472ecbea145659f7e9f8ee689ff5aff37.1484929304.git.julian@codesourcery.com>
In-Reply-To: <cover.1484929304.git.julian@codesourcery.com>
References: <cover.1484929304.git.julian@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 4/7] ARM big-endian semihosting support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This patch introduces an ARM-specific version of the memory read/write,
etc. functions used for semihosting, in order to byte-swap (big-endian)
target memory that is to be interpreted by the (little-endian) host.
The target_memory_rw_debug function is used that knows about the
byte-reversal used for BE32 system mode.

Signed-off-by: Julian Brown <julian@codesourcery.com>
---
 include/exec/softmmu-arm-semi.h | 131 ++++++++++++++++++++++++++++++++++++++++
 target/arm/arm-semi.c           |   4 +-
 target/arm/cpu.c                |  24 ++++++++
 target/arm/cpu.h                |   6 ++
 4 files changed, 163 insertions(+), 2 deletions(-)
 create mode 100644 include/exec/softmmu-arm-semi.h

diff --git a/include/exec/softmmu-arm-semi.h b/include/exec/softmmu-arm-semi.h
new file mode 100644
index 0000000..bba9ca6
--- /dev/null
+++ b/include/exec/softmmu-arm-semi.h
@@ -0,0 +1,131 @@
+/*
+ * Helper routines to provide target memory access for ARM semihosting
+ * syscalls in system emulation mode.
+ *
+ * Copyright (c) 2007 CodeSourcery, (c) 2016 Mentor Graphics
+ *
+ * This code is licensed under the GPL
+ */
+
+#ifndef SOFTMMU_ARM_SEMI_H
+#define SOFTMMU_ARM_SEMI_H 1
+
+/* In big-endian mode (either BE8 or BE32), values larger than a byte will be
+ * transferred to/from memory in big-endian format.  Assuming we're on a
+ * little-endian host machine, such values will need to be byteswapped before
+ * and after the host processes them.
+ *
+ * This means that byteswapping will occur *twice* in BE32 mode for
+ * halfword/word reads/writes.
+ */
+
+static inline bool arm_bswap_needed(CPUARMState *env)
+{
+#ifdef HOST_WORDS_BIGENDIAN
+#error HOST_WORDS_BIGENDIAN is not supported for ARM semihosting at the moment.
+#else
+    return arm_sctlr_b(env) || arm_cpsr_e(env);
+#endif
+}
+
+static inline uint64_t softmmu_tget64(CPUArchState *env, target_ulong addr)
+{
+    uint64_t val;
+
+    target_memory_rw_debug(ENV_GET_CPU(env), addr, (uint8_t *)&val, 8, 0);
+    if (arm_bswap_needed(env)) {
+        return bswap64(val);
+    } else {
+        return val;
+    }
+}
+
+static inline uint32_t softmmu_tget32(CPUArchState *env, target_ulong addr)
+{
+    uint32_t val;
+
+    target_memory_rw_debug(ENV_GET_CPU(env), addr, (uint8_t *)&val, 4, 0);
+    if (arm_bswap_needed(env)) {
+        return bswap32(val);
+    } else {
+        return val;
+    }
+}
+
+static inline uint32_t softmmu_tget8(CPUArchState *env, target_ulong addr)
+{
+    uint8_t val;
+    target_memory_rw_debug(ENV_GET_CPU(env), addr, &val, 1, 0);
+    return val;
+}
+
+#define get_user_u64(arg, p) ({ arg = softmmu_tget64(env, p); 0; })
+#define get_user_u32(arg, p) ({ arg = softmmu_tget32(env, p) ; 0; })
+#define get_user_u8(arg, p) ({ arg = softmmu_tget8(env, p) ; 0; })
+#define get_user_ual(arg, p) get_user_u32(arg, p)
+
+static inline void softmmu_tput64(CPUArchState *env,
+                                  target_ulong addr, uint64_t val)
+{
+    if (arm_bswap_needed(env)) {
+        val = bswap64(val);
+    }
+    cpu_memory_rw_debug(ENV_GET_CPU(env), addr, (uint8_t *)&val, 8, 1);
+}
+
+static inline void softmmu_tput32(CPUArchState *env,
+                                  target_ulong addr, uint32_t val)
+{
+    if (arm_bswap_needed(env)) {
+        val = bswap32(val);
+    }
+    target_memory_rw_debug(ENV_GET_CPU(env), addr, (uint8_t *)&val, 4, 1);
+}
+#define put_user_u64(arg, p) ({ softmmu_tput64(env, p, arg) ; 0; })
+#define put_user_u32(arg, p) ({ softmmu_tput32(env, p, arg) ; 0; })
+#define put_user_ual(arg, p) put_user_u32(arg, p)
+
+static inline void *softmmu_lock_user(CPUArchState *env,
+                                      target_ulong addr, target_ulong len,
+                                      int copy)
+{
+    uint8_t *p;
+    /* TODO: Make this something that isn't fixed size.  */
+    p = malloc(len);
+    if (p && copy) {
+        target_memory_rw_debug(ENV_GET_CPU(env), addr, p, len, 0);
+    }
+    return p;
+}
+#define lock_user(type, p, len, copy) softmmu_lock_user(env, p, len, copy)
+static inline char *softmmu_lock_user_string(CPUArchState *env,
+                                             target_ulong addr)
+{
+    char *p;
+    char *s;
+    uint8_t c;
+    /* TODO: Make this something that isn't fixed size.  */
+    s = p = malloc(1024);
+    if (!s) {
+        return NULL;
+    }
+    do {
+        target_memory_rw_debug(ENV_GET_CPU(env), addr, &c, 1, 0);
+        addr++;
+        *(p++) = c;
+    } while (c);
+    return s;
+}
+#define lock_user_string(p) softmmu_lock_user_string(env, p)
+static inline void softmmu_unlock_user(CPUArchState *env, void *p,
+                                       target_ulong addr, target_ulong len)
+{
+    if (len) {
+        target_memory_rw_debug(ENV_GET_CPU(env), addr, p, len, 1);
+    }
+    free(p);
+}
+
+#define unlock_user(s, args, len) softmmu_unlock_user(env, s, args, len)
+
+#endif
diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 7cac873..6b235ad 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -114,7 +114,7 @@ static inline uint32_t set_swi_errno(CPUARMState *env, uint32_t code)
     return code;
 }
 
-#include "exec/softmmu-semi.h"
+#include "exec/softmmu-arm-semi.h"
 #endif
 
 static target_ulong arm_semi_syscall_len;
@@ -187,7 +187,7 @@ static void arm_semi_flen_cb(CPUState *cs, target_ulong ret, target_ulong err)
     /* The size is always stored in big-endian order, extract
        the value. We assume the size always fit in 32 bits.  */
     uint32_t size;
-    cpu_memory_rw_debug(cs, arm_flen_buf(cpu) + 32, (uint8_t *)&size, 4, 0);
+    target_memory_rw_debug(cs, arm_flen_buf(cpu) + 32, (uint8_t *)&size, 4, 0);
     size = be32_to_cpu(size);
     if (is_a64(env)) {
         env->xregs[0] = size;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index bdf86de..74a2fa1 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1571,6 +1571,27 @@ static gchar *arm_gdb_arch_name(CPUState *cs)
     return g_strdup("arm");
 }
 
+#ifndef CONFIG_USER_ONLY
+static int arm_cpu_memory_rw_debug(CPUState *cpu, vaddr address,
+                                   uint8_t *buf, int len, bool is_write)
+{
+    target_ulong addr = address;
+    ARMCPU *armcpu = ARM_CPU(cpu);
+    CPUARMState *env = &armcpu->env;
+
+    if (arm_sctlr_b(env)) {
+        target_ulong i;
+        for (i = 0; i < len; i++) {
+            cpu_memory_rw_debug(cpu, (addr + i) ^ 3, &buf[i], 1, is_write);
+        }
+    } else {
+        cpu_memory_rw_debug(cpu, addr, buf, len, is_write);
+    }
+
+    return 0;
+}
+#endif
+
 static void arm_cpu_class_init(ObjectClass *oc, void *data)
 {
     ARMCPUClass *acc = ARM_CPU_CLASS(oc);
@@ -1588,6 +1609,9 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     cc->has_work = arm_cpu_has_work;
     cc->cpu_exec_interrupt = arm_cpu_exec_interrupt;
     cc->dump_state = arm_cpu_dump_state;
+#if !defined(CONFIG_USER_ONLY)
+    cc->memory_rw_debug = arm_cpu_memory_rw_debug;
+#endif
     cc->set_pc = arm_cpu_set_pc;
     cc->gdb_read_register = arm_cpu_gdb_read_register;
     cc->gdb_write_register = arm_cpu_gdb_write_register;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ac8d625..efd0de5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2128,6 +2128,12 @@ static inline bool arm_sctlr_b(CPUARMState *env)
         (env->cp15.sctlr_el[1] & SCTLR_B) != 0;
 }
 
+static inline bool arm_cpsr_e(CPUARMState *env)
+{
+    return arm_feature(env, ARM_FEATURE_V7) &&
+           (env->uncached_cpsr & CPSR_E) != 0;
+}
+
 /* Return true if the processor is in big-endian mode. */
 static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
 {
-- 
2.8.1
