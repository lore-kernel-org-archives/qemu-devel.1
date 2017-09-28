Received: from eggs.gnu.org ([2001:4830:134:3::10]:55278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dxc4w-0004mN-0n
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 12:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dxc4s-0004JK-4l
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 12:54:26 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:44059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dxc4r-0004Ix-MC
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 12:54:22 -0400
Received: by mail-pf0-x22e.google.com with SMTP id e1so1146458pfk.1
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 09:54:21 -0700 (PDT)
Received: from bigtime.twiddle.net ([70.35.39.2])
	by smtp.gmail.com with ESMTPSA id
	e133sm3062332pfh.177.2017.09.28.09.54.18 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 28 Sep 2017 09:54:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Sep 2017 09:54:07 -0700
Message-Id: <20170928165414.7339-3-richard.henderson@linaro.org>
In-Reply-To: <20170928165414.7339-1-richard.henderson@linaro.org>
References: <20170928165414.7339-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 2/9] target/ppc: Convert to disas_set_info
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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
index 1184bec678..d55ad61dbb 100644
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
index c6399a3a0d..2863e2c0b0 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10681,6 +10681,26 @@ static gchar *ppc_gdb_arch_name(CPUState *cs)
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
@@ -10742,6 +10762,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
 #ifndef CONFIG_USER_ONLY
     cc->virtio_is_big_endian = ppc_cpu_is_big_endian;
 #endif
+    cc->disas_set_info = ppc_disas_set_info;
 
     dc->fw_name = "PowerPC,UNKNOWN";
 }
-- 
2.13.5
