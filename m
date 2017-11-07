Received: from eggs.gnu.org ([2001:4830:134:3::10]:41873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eC2uQ-0007N6-8H
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 07:23:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eC2uG-0004md-7l
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 07:23:14 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:50166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eC2uF-0004ld-VZ
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 07:23:04 -0500
Received: by mail-wr0-x243.google.com with SMTP id o88so838068wrb.6
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 04:23:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue,  7 Nov 2017 13:22:34 +0100
Message-Id: <20171107122234.8439-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] disas: Dump insn bytes along with capstone
 disassembly
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

This feature is present for some targets in the bfd disassembler(s).
Implement it generically for all capstone users.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/disas/bfd.h |  2 ++
 disas.c             | 96 ++++++++++++++++++++++++++++++++++++++++++++++-------
 target/arm/cpu.c    |  6 ++++
 target/i386/cpu.c   |  2 ++
 4 files changed, 94 insertions(+), 12 deletions(-)

diff --git a/include/disas/bfd.h b/include/disas/bfd.h
index 1f88c9e9d5..46c7ec3376 100644
--- a/include/disas/bfd.h
+++ b/include/disas/bfd.h
@@ -374,6 +374,8 @@ typedef struct disassemble_info {
   /* Options for Capstone disassembly.  */
   int cap_arch;
   int cap_mode;
+  int cap_insn_unit;
+  int cap_insn_split;
 
 } disassemble_info;
 
diff --git a/disas.c b/disas.c
index 92b389d25f..d4ad1089ef 100644
--- a/disas.c
+++ b/disas.c
@@ -220,6 +220,77 @@ static cs_err cap_disas_start(disassemble_info *info, csh *handle)
     return CS_ERR_OK;
 }
 
+static void cap_dump_insn_units(disassemble_info *info, cs_insn *insn,
+                                int i, int n)
+{
+    fprintf_function print = info->fprintf_func;
+    FILE *stream = info->stream;
+
+    switch (info->cap_insn_unit) {
+    case 4:
+        if (info->endian == BFD_ENDIAN_BIG) {
+            for (; i < n; i += 4) {
+                print(stream, " %08x", ldl_be_p(insn->bytes + i));
+
+            }
+        } else {
+            for (; i < n; i += 4) {
+                print(stream, " %08x", ldl_le_p(insn->bytes + i));
+            }
+        }
+        break;
+
+    case 2:
+        if (info->endian == BFD_ENDIAN_BIG) {
+            for (; i < n; i += 2) {
+                print(stream, " %04x", lduw_be_p(insn->bytes + i));
+            }
+        } else {
+            for (; i < n; i += 2) {
+                print(stream, " %04x", lduw_le_p(insn->bytes + i));
+            }
+        }
+        break;
+
+    default:
+        for (; i < n; i++) {
+            print(stream, " %02x", insn->bytes[i]);
+        }
+        break;
+    }
+}
+
+static void cap_dump_insn(disassemble_info *info, cs_insn *insn)
+{
+    fprintf_function print = info->fprintf_func;
+    int i, n, split;
+
+    print(info->stream, "0x%08" PRIx64 ": ", insn->address);
+
+    n = insn->size;
+    split = info->cap_insn_split;
+
+    /* Dump the first SPLIT bytes of the instruction.  */
+    cap_dump_insn_units(info, insn, 0, MIN(n, split));
+
+    /* Add padding up to SPLIT so that mnemonics line up.  */
+    if (n < split) {
+        int width = (split - n) / info->cap_insn_unit;
+        width *= (2 * info->cap_insn_unit + 1);
+        print(info->stream, "%*s", width, "");
+    }
+
+    /* Print the actual instruction.  */
+    print(info->stream, "  %-8s %s\n", insn->mnemonic, insn->op_str);
+
+    /* Dump any remaining part of the insn on subsequent lines.  */
+    for (i = split; i < n; i += split) {
+        print(info->stream, "0x%08" PRIx64 ": ", insn->address + i);
+        cap_dump_insn_units(info, insn, i, MIN(n, i + split));
+        print(info->stream, "\n");
+    }
+}
+
 /* Disassemble SIZE bytes at PC for the target.  */
 static bool cap_disas_target(disassemble_info *info, uint64_t pc, size_t size)
 {
@@ -242,10 +313,7 @@ static bool cap_disas_target(disassemble_info *info, uint64_t pc, size_t size)
         size -= tsize;
 
         while (cs_disasm_iter(handle, &cbuf, &csize, &pc, insn)) {
-            (*info->fprintf_func)(info->stream,
-                                  "0x%08" PRIx64 ":  %-12s %s\n",
-                                  insn->address, insn->mnemonic,
-                                  insn->op_str);
+           cap_dump_insn(info, insn);
         }
 
         /* If the target memory is not consumed, go back for more... */
@@ -290,10 +358,7 @@ static bool cap_disas_host(disassemble_info *info, void *code, size_t size)
     pc = (uintptr_t)code;
 
     while (cs_disasm_iter(handle, &cbuf, &size, &pc, insn)) {
-        (*info->fprintf_func)(info->stream,
-                              "0x%08" PRIx64 ":  %-12s %s\n",
-                              insn->address, insn->mnemonic,
-                              insn->op_str);
+       cap_dump_insn(info, insn);
     }
     if (size != 0) {
         (*info->fprintf_func)(info->stream,
@@ -337,10 +402,7 @@ static bool cap_disas_monitor(disassemble_info *info, uint64_t pc, int count)
         csize += tsize;
 
         if (cs_disasm_iter(handle, &cbuf, &csize, &pc, insn)) {
-            (*info->fprintf_func)(info->stream,
-                                  "0x%08" PRIx64 ":  %-12s %s\n",
-                                  insn->address, insn->mnemonic,
-                                  insn->op_str);
+            cap_dump_insn(info, insn);
             if (--count <= 0) {
                 break;
             }
@@ -376,6 +438,8 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
     s.info.print_address_func = generic_print_address;
     s.info.cap_arch = -1;
     s.info.cap_mode = 0;
+    s.info.cap_insn_unit = 4;
+    s.info.cap_insn_split = 4;
 
 #ifdef TARGET_WORDS_BIGENDIAN
     s.info.endian = BFD_ENDIAN_BIG;
@@ -427,6 +491,8 @@ void disas(FILE *out, void *code, unsigned long size)
     s.info.buffer_length = size;
     s.info.cap_arch = -1;
     s.info.cap_mode = 0;
+    s.info.cap_insn_unit = 4;
+    s.info.cap_insn_split = 4;
 
 #ifdef HOST_WORDS_BIGENDIAN
     s.info.endian = BFD_ENDIAN_BIG;
@@ -440,11 +506,15 @@ void disas(FILE *out, void *code, unsigned long size)
     print_insn = print_insn_i386;
     s.info.cap_arch = CS_ARCH_X86;
     s.info.cap_mode = CS_MODE_32;
+    s.info.cap_insn_unit = 1;
+    s.info.cap_insn_split = 8;
 #elif defined(__x86_64__)
     s.info.mach = bfd_mach_x86_64;
     print_insn = print_insn_i386;
     s.info.cap_arch = CS_ARCH_X86;
     s.info.cap_mode = CS_MODE_64;
+    s.info.cap_insn_unit = 1;
+    s.info.cap_insn_split = 8;
 #elif defined(_ARCH_PPC)
     s.info.disassembler_options = (char *)"any";
     print_insn = print_insn_ppc;
@@ -537,6 +607,8 @@ void monitor_disas(Monitor *mon, CPUState *cpu,
     s.info.buffer_vma = pc;
     s.info.cap_arch = -1;
     s.info.cap_mode = 0;
+    s.info.cap_insn_unit = 4;
+    s.info.cap_insn_split = 4;
 
 #ifdef TARGET_WORDS_BIGENDIAN
     s.info.endian = BFD_ENDIAN_BIG;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 47c8b2a85c..7f7a3d1e32 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -489,13 +489,19 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
         info->print_insn = print_insn_arm_a64;
 #endif
         info->cap_arch = CS_ARCH_ARM64;
+        info->cap_insn_unit = 4;
+        info->cap_insn_split = 4;
     } else {
         int cap_mode;
         if (env->thumb) {
             info->print_insn = print_insn_thumb1;
+            info->cap_insn_unit = 2;
+            info->cap_insn_split = 4;
             cap_mode = CS_MODE_THUMB;
         } else {
             info->print_insn = print_insn_arm;
+            info->cap_insn_unit = 4;
+            info->cap_insn_split = 4;
             cap_mode = CS_MODE_ARM;
         }
         if (arm_feature(env, ARM_FEATURE_V8)) {
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6f21a5e518..1edcf29e27 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4109,6 +4109,8 @@ static void x86_disas_set_info(CPUState *cs, disassemble_info *info)
     info->cap_mode = (env->hflags & HF_CS64_MASK ? CS_MODE_64
                       : env->hflags & HF_CS32_MASK ? CS_MODE_32
                       : CS_MODE_16);
+    info->cap_insn_unit = 1;
+    info->cap_insn_split = 8;
 }
 
 static Property x86_cpu_properties[] = {
-- 
2.13.6
