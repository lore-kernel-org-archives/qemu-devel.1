Received: from eggs.gnu.org ([2001:4830:134:3::10]:33649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cEHQY-0008GU-IL
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:13:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cEHQV-0000ed-Vg
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:13:06 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:35052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Julian_Brown@mentor.com>)
	id 1cEHQV-0000ca-Lo
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:13:03 -0500
Date: Tue, 6 Dec 2016 15:11:30 +0000
From: Julian Brown <julian@codesourcery.com>
Message-ID: <20161206151130.204280f0@squid.athome>
In-Reply-To: <CAFEAcA_Z88S+mMRjMzJg+iOx6t4_hwEsEYVuYBWgk6JJL2UEhg@mail.gmail.com>
References: <1478194258-75276-1-git-send-email-julian@codesourcery.com>
	<1478194258-75276-2-git-send-email-julian@codesourcery.com>
	<CAFEAcA_Z88S+mMRjMzJg+iOx6t4_hwEsEYVuYBWgk6JJL2UEhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/++uLVWufgvrvJ26l9sYBCcI"
Subject: Re: [Qemu-devel] [PATCH 1/5] ARM BE8/BE32 semihosting and gdbstub
 support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

--MP_/++uLVWufgvrvJ26l9sYBCcI
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 3 Nov 2016 22:23:09 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> Strong 'no' for the approach of having different CPU
> names, I'm afraid. What you want is to have a CPU
> property which works like the hardware CPU's CFGEND
> signal to set the reset value of the SCTLR.EE bit. Then
> a board can use that where it would wire up CFGEND
> in real hardware, and on the command line you can
> have -cpu whatever,cfgend=yes (which is a bit ugly
> but then it's borderline whether it makes any sense at
> all for the user to be able to set the endianness on
> the commandline).

How about something like this? (Re-testing these patches has taken a
while because I hit apparent reliability problems running GDB tests
against the trunk QEMU: I filed
https://bugs.launchpad.net/qemu/+bug/1647683 for that).

(There's some slight dubiousness about memory ownership with the GLIB
functions -- I don't have a good handle on that, really, but I think
it's OK.)

Thanks,

Julian
--MP_/++uLVWufgvrvJ26l9sYBCcI
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-ARM-BE8-BE32-semihosting-and-gdbstub-support.patch"

>From d76129fb9ab60df696af6bc4911041f95b3a560b Mon Sep 17 00:00:00 2001
From: Julian Brown <julian@codesourcery.com>
Date: Tue, 1 Nov 2016 08:35:48 -0700
Subject: [PATCH 1/4] ARM BE8/BE32 semihosting and gdbstub support.

This patch improves support for semihosting and debugging with the
in-built gdbstub for ARM system-mode emulation in big-endian mode (either
BE8 or BE32), after the fairly recent changes to allow a single QEMU
binary to deal with each of LE, BE8 and BE32 modes in one. It's only
currently good for little-endian host systems. The relevant use case
is using QEMU as a "bare metal" instruction-set simulator, e.g. for
toolchain testing.

For semihosting, the softmmu-semi.h file is overridden with an
ARM-specific version that knows about byte-swapping target memory into
host order -- including that which has been byte-swapped at load time
for BE32 mode.

For the gdbstub, we'd like to be able to invoke QEMU from GDB like:

(gdb) target remote | arm-qemu-system -cpu=foo [options] /dev/null
(gdb) load
(gdb) ...

which unfortunately bypasses the probing of the loaded ELF file (since
it's just /dev/null) to determine whether to use BE8/BE32 mode. A
"cfgend" boolean parameter has been added for this scenario, mirroring
the configuration input on (some?) ARM cores, to choose a core-appropriate
big-endian mode at reset. (Use e.g. -cpu=arm926,cfgend=yes).

Signed-off-by: Julian Brown <julian@codesourcery.com>
---
 hw/arm/boot.c                   |  16 ++++-
 include/exec/softmmu-arm-semi.h | 148 ++++++++++++++++++++++++++++++++++++++++
 target-arm/arm-semi.c           |   2 +-
 target-arm/cpu.c                |  52 +++++++++++++-
 target-arm/cpu.h                |  12 ++++
 target-arm/gdbstub.c            |  42 ++++++++++++
 6 files changed, 267 insertions(+), 5 deletions(-)
 create mode 100644 include/exec/softmmu-arm-semi.h

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 942416d..68a6574 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -894,7 +894,21 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
         entry = info->loader_start + kernel_load_offset;
         kernel_size = load_image_targphys(info->kernel_filename, entry,
                                           info->ram_size - kernel_load_offset);
-        is_linux = 1;
+        if (kernel_size > 0) {
+            is_linux = 1;
+        } else {
+            /* We've been launched with a kernel of /dev/null or similar.
+             * Infer endianness from the reset value of the SCTLR for this
+             * CPU/board.  (This can be altered using the cfgend parameter.)
+             */
+            if (!arm_feature(&cpu->env, ARM_FEATURE_V7) &&
+                (cpu->reset_sctlr & SCTLR_B) != 0)
+                info->endianness = ARM_ENDIANNESS_BE32;
+            else if ((cpu->reset_sctlr & SCTLR_EE) != 0)
+                info->endianness = ARM_ENDIANNESS_BE8;
+            else
+                info->endianness = ARM_ENDIANNESS_LE;
+        }
     }
     if (kernel_size < 0) {
         fprintf(stderr, "qemu: could not load kernel '%s'\n",
diff --git a/include/exec/softmmu-arm-semi.h b/include/exec/softmmu-arm-semi.h
new file mode 100644
index 0000000..d97e017
--- /dev/null
+++ b/include/exec/softmmu-arm-semi.h
@@ -0,0 +1,148 @@
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
+/* In BE32 system mode, the CPU-specific memory_rw_debug method will arrange to
+ * perform byteswapping on the target memory, so that it appears to the host as
+ * it appears to the emulated CPU.  Memory is read verbatim in BE8 mode.  (In
+ * other words, this function arranges so that BUF has the same format in both
+ * BE8 and BE32 system mode.)
+ */
+
+static inline int armsemi_memory_rw_debug(CPUState *cpu, target_ulong addr,
+                                          uint8_t *buf, int len, bool is_write)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+
+    if (cc->memory_rw_debug) {
+        return cc->memory_rw_debug(cpu, addr, buf, len, is_write);
+    }
+    return cpu_memory_rw_debug(cpu, addr, buf, len, is_write);
+}
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
+    return arm_sctlr_b(env) || arm_sctlr_ee(env);
+#endif
+}
+
+static inline uint64_t softmmu_tget64(CPUArchState *env, target_ulong addr)
+{
+    uint64_t val;
+
+    armsemi_memory_rw_debug(ENV_GET_CPU(env), addr, (uint8_t *)&val, 8, 0);
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
+    armsemi_memory_rw_debug(ENV_GET_CPU(env), addr, (uint8_t *)&val, 4, 0);
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
+    armsemi_memory_rw_debug(ENV_GET_CPU(env), addr, &val, 1, 0);
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
+    armsemi_memory_rw_debug(ENV_GET_CPU(env), addr, (uint8_t *)&val, 4, 1);
+}
+#define put_user_u64(arg, p) ({ softmmu_tput64(env, p, arg) ; 0; })
+#define put_user_u32(arg, p) ({ softmmu_tput32(env, p, arg) ; 0; })
+#define put_user_ual(arg, p) put_user_u32(arg, p)
+
+static void *softmmu_lock_user(CPUArchState *env,
+                               target_ulong addr, target_ulong len, int copy)
+{
+    uint8_t *p;
+    /* TODO: Make this something that isn't fixed size.  */
+    p = malloc(len);
+    if (p && copy) {
+        armsemi_memory_rw_debug(ENV_GET_CPU(env), addr, p, len, 0);
+    }
+    return p;
+}
+#define lock_user(type, p, len, copy) softmmu_lock_user(env, p, len, copy)
+static char *softmmu_lock_user_string(CPUArchState *env, target_ulong addr)
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
+        armsemi_memory_rw_debug(ENV_GET_CPU(env), addr, &c, 1, 0);
+        addr++;
+        *(p++) = c;
+    } while (c);
+    return s;
+}
+#define lock_user_string(p) softmmu_lock_user_string(env, p)
+static void softmmu_unlock_user(CPUArchState *env, void *p, target_ulong addr,
+                                target_ulong len)
+{
+    uint8_t *pc = p;
+    if (len) {
+        armsemi_memory_rw_debug(ENV_GET_CPU(env), addr, p, len, 1);
+    }
+    free(p);
+}
+
+#define unlock_user(s, args, len) softmmu_unlock_user(env, s, args, len)
+
+#endif
diff --git a/target-arm/arm-semi.c b/target-arm/arm-semi.c
index 7cac873..a9cf5f2 100644
--- a/target-arm/arm-semi.c
+++ b/target-arm/arm-semi.c
@@ -114,7 +114,7 @@ static inline uint32_t set_swi_errno(CPUARMState *env, uint32_t code)
     return code;
 }
 
-#include "exec/softmmu-semi.h"
+#include "exec/softmmu-arm-semi.h"
 #endif
 
 static target_ulong arm_semi_syscall_len;
diff --git a/target-arm/cpu.c b/target-arm/cpu.c
index 2eb4098..6afb0d9 100644
--- a/target-arm/cpu.c
+++ b/target-arm/cpu.c
@@ -33,6 +33,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
+#include "exec/cpu-common.h"
 
 static void arm_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -497,6 +498,9 @@ static Property arm_cpu_rvbar_property =
 static Property arm_cpu_has_el3_property =
             DEFINE_PROP_BOOL("has_el3", ARMCPU, has_el3, true);
 
+static Property arm_cpu_cfgend_property =
+            DEFINE_PROP_BOOL("cfgend", ARMCPU, cfgend, false);
+
 /* use property name "pmu" to match other archs and virt tools */
 static Property arm_cpu_has_pmu_property =
             DEFINE_PROP_BOOL("pmu", ARMCPU, has_pmu, true);
@@ -559,6 +563,18 @@ static void arm_cpu_post_init(Object *obj)
         }
     }
 
+    qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
+                             &error_abort);
+
+    qdev_prop_set_globals(DEVICE(obj));
+
+    if (object_property_get_bool(obj, "cfgend", NULL)) {
+        if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            cpu->reset_sctlr |= SCTLR_EE;
+        } else {
+            cpu->reset_sctlr |= SCTLR_B;
+        }
+    }
 }
 
 static void arm_cpu_finalizefn(Object *obj)
@@ -758,6 +774,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 static ObjectClass *arm_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
+    CPUClass *cc;
     char *typename;
     char **cpuname;
 
@@ -765,15 +782,20 @@ static ObjectClass *arm_cpu_class_by_name(const char *cpu_model)
         return NULL;
     }
 
-    cpuname = g_strsplit(cpu_model, ",", 1);
+    cpuname = g_strsplit(cpu_model, ",", 2);
     typename = g_strdup_printf("%s-" TYPE_ARM_CPU, cpuname[0]);
     oc = object_class_by_name(typename);
-    g_strfreev(cpuname);
-    g_free(typename);
     if (!oc || !object_class_dynamic_cast(oc, TYPE_ARM_CPU) ||
         object_class_is_abstract(oc)) {
+        g_strfreev(cpuname);
+        g_free(typename);
         return NULL;
     }
+
+    cc = CPU_CLASS(oc);
+    cc->parse_features(typename, cpuname[1], &error_fatal);
+    g_strfreev(cpuname);
+
     return oc;
 }
 
@@ -1534,6 +1556,27 @@ static gchar *arm_gdb_arch_name(CPUState *cs)
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
@@ -1551,6 +1594,9 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     cc->has_work = arm_cpu_has_work;
     cc->cpu_exec_interrupt = arm_cpu_exec_interrupt;
     cc->dump_state = arm_cpu_dump_state;
+#if !defined(CONFIG_USER_ONLY)
+    cc->memory_rw_debug = arm_cpu_memory_rw_debug;
+#endif
     cc->set_pc = arm_cpu_set_pc;
     cc->gdb_read_register = arm_cpu_gdb_read_register;
     cc->gdb_write_register = arm_cpu_gdb_write_register;
diff --git a/target-arm/cpu.h b/target-arm/cpu.h
index ca5c849..03f19ab 100644
--- a/target-arm/cpu.h
+++ b/target-arm/cpu.h
@@ -657,6 +657,12 @@ struct ARMCPU {
     uint32_t dcz_blocksize;
     uint64_t rvbar;
 
+    /* Whether the cfgend input is high (i.e. this CPU should reset into
+       big-endian mode).  This setting isn't used directly: instead it modifies
+       the reset_sctlr value to have SCTLR_B or SCTLR_EE set, depending on the
+       architecture version.  */
+    bool cfgend;
+
     ARMELChangeHook *el_change_hook;
     void *el_change_hook_opaque;
 };
@@ -2108,6 +2114,12 @@ static inline bool arm_sctlr_b(CPUARMState *env)
         (env->cp15.sctlr_el[1] & SCTLR_B) != 0;
 }
 
+static inline bool arm_sctlr_ee(CPUARMState *env)
+{
+    return arm_feature(env, ARM_FEATURE_V7) &&
+           (env->cp15.sctlr_el[1] & SCTLR_EE) != 0;
+}
+
 /* Return true if the processor is in big-endian mode. */
 static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
 {
diff --git a/target-arm/gdbstub.c b/target-arm/gdbstub.c
index 04c1208..1e9fe68 100644
--- a/target-arm/gdbstub.c
+++ b/target-arm/gdbstub.c
@@ -21,6 +21,7 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
+#include "exec/softmmu-arm-semi.h"
 
 /* Old gdb always expect FPA registers.  Newer (xml-aware) gdb only expect
    whatever the target description contains.  Due to a historical mishap
@@ -32,10 +33,22 @@ int arm_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
+#ifndef CONFIG_USER_ONLY
+    bool targ_bigendian = arm_bswap_needed(env);
+#endif
 
     if (n < 16) {
         /* Core integer register.  */
+#ifdef CONFIG_USER_ONLY
         return gdb_get_reg32(mem_buf, env->regs[n]);
+#else
+        if (targ_bigendian) {
+            stl_be_p(mem_buf, env->regs[n]);
+        } else {
+            stl_le_p(mem_buf, env->regs[n]);
+        }
+        return 4;
+#endif
     }
     if (n < 24) {
         /* FPA registers.  */
@@ -51,10 +64,28 @@ int arm_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
         if (gdb_has_xml) {
             return 0;
         }
+#ifdef CONFIG_USER_ONLY
         return gdb_get_reg32(mem_buf, 0);
+#else
+        if (targ_bigendian) {
+            stl_be_p(mem_buf, 0);
+        } else {
+            stl_le_p(mem_buf, 0);
+        }
+        return 4;
+#endif
     case 25:
         /* CPSR */
+#ifdef CONFIG_USER_ONLY
         return gdb_get_reg32(mem_buf, cpsr_read(env));
+#else
+        if (targ_bigendian) {
+            stl_be_p(mem_buf, cpsr_read(env));
+        } else {
+            stl_le_p(mem_buf, cpsr_read(env));
+        }
+        return 4;
+#endif
     }
     /* Unknown register.  */
     return 0;
@@ -65,8 +96,19 @@ int arm_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     uint32_t tmp;
+#ifndef CONFIG_USER_ONLY
+    bool targ_bigendian = arm_bswap_needed(env);
+#endif
 
+#ifdef CONFIG_USER_ONLY
     tmp = ldl_p(mem_buf);
+#else
+    if (targ_bigendian) {
+        tmp = ldl_be_p(mem_buf);
+    } else {
+        tmp = ldl_le_p(mem_buf);
+    }
+#endif
 
     /* Mask out low bit of PC to workaround gdb bugs.  This will probably
        cause problems if we ever implement the Jazelle DBX extensions.  */
-- 
1.9.1


--MP_/++uLVWufgvrvJ26l9sYBCcI--
