Received: from eggs.gnu.org ([2001:4830:134:3::10]:32825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAe5-0007c4-W7
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAe4-0002mX-PY
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:42 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cbAe4-0002gg-IS
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:40 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAdt-0005U0-Jr
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:37:29 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  7 Feb 2017 18:37:19 +0000
Message-Id: <1486492645-27803-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486492645-27803-1-git-send-email-peter.maydell@linaro.org>
References: <1486492645-27803-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 07/13] Fix Thumb-1 BE32 execution and
 disassembly.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Julian Brown <julian@codesourcery.com>

Thumb-1 code has some issues in BE32 mode (as currently implemented). In
short, since bytes are swapped within words at load time for BE32
executables, this also swaps pairs of adjacent Thumb-1 instructions.

This patch un-swaps those pairs of instructions again, both for execution,
and for disassembly. (The previous version of the patch always read four
bytes in arm_read_memory_func and then extracted the proper two bytes,
in a probably misguided attempt to match the behaviour of actual hardware
as described by e.g. the ARM9TDMI TRM, section 3.3 "Endian effects for
instruction fetches". It's less complicated to just read the correct
two bytes though.)

Signed-off-by: Julian Brown <julian@codesourcery.com>
Message-id: ca20462a044848000370318a8bd41dd0a4ed273f.1484929304.git.julian@codesourcery.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/disas/bfd.h   |  7 +++++++
 target/arm/arm_ldst.h | 10 +++++++++-
 disas.c               |  1 +
 target/arm/cpu.c      | 23 +++++++++++++++++++++++
 4 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/include/disas/bfd.h b/include/disas/bfd.h
index 0435b8c..b01e002 100644
--- a/include/disas/bfd.h
+++ b/include/disas/bfd.h
@@ -295,6 +295,7 @@ typedef struct disassemble_info {
      The bottom 16 bits are for the internal use of the disassembler.  */
   unsigned long flags;
 #define INSN_HAS_RELOC	0x80000000
+#define INSN_ARM_BE32	0x00010000
   PTR private_data;
 
   /* Function used to get bytes to disassemble.  MEMADDR is the
@@ -306,6 +307,12 @@ typedef struct disassemble_info {
     (bfd_vma memaddr, bfd_byte *myaddr, int length,
 	     struct disassemble_info *info);
 
+  /* A place to stash the real read_memory_func if read_memory_func wants to
+     do some funky address arithmetic or similar (e.g. for ARM BE32 mode).  */
+  int (*read_memory_inner_func)
+    (bfd_vma memaddr, bfd_byte *myaddr, int length,
+             struct disassemble_info *info);
+
   /* Function which should be called if we get an error that we can't
      recover from.  STATUS is the errno value from read_memory_func and
      MEMADDR is the address that we were trying to read.  INFO is a
diff --git a/target/arm/arm_ldst.h b/target/arm/arm_ldst.h
index a76d89f..01587b3 100644
--- a/target/arm/arm_ldst.h
+++ b/target/arm/arm_ldst.h
@@ -39,7 +39,15 @@ static inline uint32_t arm_ldl_code(CPUARMState *env, target_ulong addr,
 static inline uint16_t arm_lduw_code(CPUARMState *env, target_ulong addr,
                                      bool sctlr_b)
 {
-    uint16_t insn = cpu_lduw_code(env, addr);
+    uint16_t insn;
+#ifndef CONFIG_USER_ONLY
+    /* In big-endian (BE32) mode, adjacent Thumb instructions have been swapped
+       within each word.  Undo that now.  */
+    if (sctlr_b) {
+        addr ^= 2;
+    }
+#endif
+    insn = cpu_lduw_code(env, addr);
     if (bswap_code(sctlr_b)) {
         return bswap16(insn);
     }
diff --git a/disas.c b/disas.c
index 05a7a12..d335c55 100644
--- a/disas.c
+++ b/disas.c
@@ -190,6 +190,7 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
 
     s.cpu = cpu;
     s.info.read_memory_func = target_read_memory;
+    s.info.read_memory_inner_func = NULL;
     s.info.buffer_vma = code;
     s.info.buffer_length = size;
     s.info.print_address_func = generic_print_address;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a8cfd9d..81448ca 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -446,6 +446,21 @@ print_insn_thumb1(bfd_vma pc, disassemble_info *info)
   return print_insn_arm(pc | 1, info);
 }
 
+static int arm_read_memory_func(bfd_vma memaddr, bfd_byte *b,
+                                int length, struct disassemble_info *info)
+{
+    assert(info->read_memory_inner_func);
+    assert((info->flags & INSN_ARM_BE32) == 0 || length == 2 || length == 4);
+
+    if ((info->flags & INSN_ARM_BE32) != 0 && length == 2) {
+        assert(info->endian == BFD_ENDIAN_LITTLE);
+        return info->read_memory_inner_func(memaddr ^ 2, (bfd_byte *)b, 2,
+                                            info);
+    } else {
+        return info->read_memory_inner_func(memaddr, b, length, info);
+    }
+}
+
 static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     ARMCPU *ac = ARM_CPU(cpu);
@@ -471,6 +486,14 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
         info->endian = BFD_ENDIAN_BIG;
 #endif
     }
+    if (info->read_memory_inner_func == NULL) {
+        info->read_memory_inner_func = info->read_memory_func;
+        info->read_memory_func = arm_read_memory_func;
+    }
+    info->flags &= ~INSN_ARM_BE32;
+    if (arm_sctlr_b(env)) {
+        info->flags |= INSN_ARM_BE32;
+    }
 }
 
 static void arm_cpu_initfn(Object *obj)
-- 
2.7.4
