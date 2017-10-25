Received: from eggs.gnu.org ([2001:4830:134:3::10]:42871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7Kq0-0007Vo-CJ
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7Kpv-0007zY-K4
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:31:12 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:52865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7Kpv-0007zG-AO
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:31:07 -0400
Received: by mail-wm0-x244.google.com with SMTP id t139so1626414wmt.1
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 05:31:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 14:30:47 +0200
Message-Id: <20171025123056.3165-3-richard.henderson@linaro.org>
In-Reply-To: <20171025123056.3165-1-richard.henderson@linaro.org>
References: <20171025123056.3165-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/11] target/ppc: Convert to disas_set_info hook
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

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas.c                     | 33 ---------------------------------
 monitor.c                   |  5 -----
 target/ppc/translate.c      |  5 +----
 target/ppc/translate_init.c | 21 +++++++++++++++++++++
 4 files changed, 22 insertions(+), 42 deletions(-)

diff --git a/disas.c b/disas.c
index 7e22a80da6..88d16fbd57 100644
--- a/disas.c
+++ b/disas.c
@@ -204,23 +204,6 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
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
@@ -380,22 +363,6 @@ void monitor_disas(Monitor *mon, CPUState *cpu,
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
index a736ae9a81..2164dfcc3b 100644
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
index a81ff69d75..cddbf92564 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7407,12 +7407,9 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
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
index 7b9bf6a773..9b4353437a 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10519,6 +10519,26 @@ static gchar *ppc_gdb_arch_name(CPUState *cs)
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
@@ -10582,6 +10602,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
 #ifndef CONFIG_USER_ONLY
     cc->virtio_is_big_endian = ppc_cpu_is_big_endian;
 #endif
+    cc->disas_set_info = ppc_disas_set_info;
 
     dc->fw_name = "PowerPC,UNKNOWN";
 }
-- 
2.13.6
