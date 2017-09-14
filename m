Received: from eggs.gnu.org ([2001:4830:134:3::10]:49581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsYz0-0000Oy-JQ
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:35:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsYyw-0000Oa-Py
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:35:26 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:54885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsYyw-0000NR-Ku
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:35:22 -0400
Received: by mail-pg0-x235.google.com with SMTP id c137so111717pga.11
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 11:35:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 14 Sep 2017 11:35:08 -0700
Message-Id: <20170914183516.19537-3-richard.henderson@linaro.org>
In-Reply-To: <20170914183516.19537-1-richard.henderson@linaro.org>
References: <20170914183516.19537-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 02/10] target/ppc: Convert to disas_set_info
 hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org

Cc: qemu-ppc@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas.c                     | 33 ---------------------------------
 monitor.c                   |  5 -----
 target/ppc/translate.c      |  5 +----
 target/ppc/translate_init.c | 21 +++++++++++++++++++++
 4 files changed, 22 insertions(+), 42 deletions(-)

diff --git a/disas.c b/disas.c
index 2be716fdb2..3a375a3b6c 100644
--- a/disas.c
+++ b/disas.c
@@ -205,23 +205,6 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
         cc->disas_set_info(cpu, &s.info);
     }
 
-#if defined(TARGET_PPC)
-    if ((flags >> 16) & 1) {
-        s.info.endian = BFD_ENDIAN_LITTLE;
-    }
-    if (flags & 0xFFFF) {
-        /* If we have a precise definition of the instruction set, use it. */
-        s.info.mach = flags & 0xFFFF;
-    } else {
-#ifdef TARGET_PPC64
-        s.info.mach = bfd_mach_ppc64;
-#else
-        s.info.mach = bfd_mach_ppc;
-#endif
-    }
-    s.info.disassembler_options = (char *)"any";
-    s.info.print_insn = print_insn_ppc;
-#endif
     if (s.info.print_insn == NULL) {
         s.info.print_insn = print_insn_od_target;
     }
@@ -381,22 +364,6 @@ void monitor_disas(Monitor *mon, CPUState *cpu,
         cc->disas_set_info(cpu, &s.info);
     }
 
-#if defined(TARGET_PPC)
-    if (flags & 0xFFFF) {
-        /* If we have a precise definition of the instruction set, use it. */
-        s.info.mach = flags & 0xFFFF;
-    } else {
-#ifdef TARGET_PPC64
-        s.info.mach = bfd_mach_ppc64;
-#else
-        s.info.mach = bfd_mach_ppc;
-#endif
-    }
-    if ((flags >> 16) & 1) {
-        s.info.endian = BFD_ENDIAN_LITTLE;
-    }
-    s.info.print_insn = print_insn_ppc;
-#endif
     if (!s.info.print_insn) {
         monitor_printf(mon, "0x" TARGET_FMT_lx
                        ": Asm output not supported on this arch\n", pc);
diff --git a/monitor.c b/monitor.c
index 3f3ebc31ef..a0f43f27e7 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1310,11 +1310,6 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
 
     if (format == 'i') {
         int flags = 0;
-#ifdef TARGET_PPC
-        CPUArchState *env = mon_get_cpu_env();
-        flags = msr_le << 16;
-        flags |= env->bfd_mach;
-#endif
         monitor_disas(mon, cs, addr, count, is_physical, flags);
         return;
     }
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 606b605ba0..bc155f1036 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7395,12 +7395,9 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 #if defined(DEBUG_DISAS)
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
         && qemu_log_in_addr_range(pc_start)) {
-        int flags;
-        flags = env->bfd_mach;
-        flags |= ctx.le_mode << 16;
         qemu_log_lock();
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, ctx.nip - pc_start, flags);
+        log_target_disas(cs, pc_start, ctx.nip - pc_start, 0);
         qemu_log("\n");
         qemu_log_unlock();
     }
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index c827d1e388..c7b4a7c02a 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10644,6 +10644,26 @@ static gchar *ppc_gdb_arch_name(CPUState *cs)
 #endif
 }
 
+static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+
+    if ((env->hflags >> MSR_LE) & 1) {
+        info->endian = BFD_ENDIAN_LITTLE;
+    }
+    info->mach = env->bfd_mach;
+    if (!env->bfd_mach) {
+#ifdef TARGET_PPC64
+        info->mach = bfd_mach_ppc64;
+#else
+        info->mach = bfd_mach_ppc;
+#endif
+    }
+    info->disassembler_options = (char *)"any";
+    info->print_insn = print_insn_ppc;
+}
+
 static Property ppc_cpu_properties[] = {
     DEFINE_PROP_BOOL("pre-2.8-migration", PowerPCCPU, pre_2_8_migration, false),
     DEFINE_PROP_BOOL("pre-2.10-migration", PowerPCCPU, pre_2_10_migration,
@@ -10705,6 +10725,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
 #ifndef CONFIG_USER_ONLY
     cc->virtio_is_big_endian = ppc_cpu_is_big_endian;
 #endif
+    cc->disas_set_info = ppc_disas_set_info;
 
     dc->fw_name = "PowerPC,UNKNOWN";
 }
-- 
2.13.5
