Received: from eggs.gnu.org ([2001:4830:134:3::10]:42883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7Kq1-0007Vu-72
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7Kpw-00080n-QG
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:31:13 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:51742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7Kpw-0007zn-F6
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:31:08 -0400
Received: by mail-wm0-x244.google.com with SMTP id b9so1634896wmh.0
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 05:31:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 14:30:48 +0200
Message-Id: <20171025123056.3165-4-richard.henderson@linaro.org>
In-Reply-To: <20171025123056.3165-1-richard.henderson@linaro.org>
References: <20171025123056.3165-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/11] target/arm: Move BE32 disassembler fixup
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

The Capstone disassembler has its own big-endian fixup.
Doing this twice does not work, of course.  Move our current
fixup from target/arm/cpu.c to disas/arm.c.

This makes read_memory_inner_func unused and can be removed.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/disas/bfd.h |  7 -------
 disas/arm.c         | 21 ++++++++++++++++-----
 target/arm/cpu.c    | 19 -------------------
 3 files changed, 16 insertions(+), 31 deletions(-)

diff --git a/include/disas/bfd.h b/include/disas/bfd.h
index d99da68267..2852f80ed6 100644
--- a/include/disas/bfd.h
+++ b/include/disas/bfd.h
@@ -307,12 +307,6 @@ typedef struct disassemble_info {
     (bfd_vma memaddr, bfd_byte *myaddr, int length,
 	     struct disassemble_info *info);
 
-  /* A place to stash the real read_memory_func if read_memory_func wants to
-     do some funky address arithmetic or similar (e.g. for ARM BE32 mode).  */
-  int (*read_memory_inner_func)
-    (bfd_vma memaddr, bfd_byte *myaddr, int length,
-             struct disassemble_info *info);
-
   /* Function which should be called if we get an error that we can't
      recover from.  STATUS is the errno value from read_memory_func and
      MEMADDR is the address that we were trying to read.  INFO is a
@@ -479,7 +473,6 @@ int generic_symbol_at_address(bfd_vma, struct disassemble_info *);
   (INFO).buffer_vma = 0, \
   (INFO).buffer_length = 0, \
   (INFO).read_memory_func = buffer_read_memory, \
-  (INFO).read_memory_inner_func = NULL, \
   (INFO).memory_error_func = perror_memory, \
   (INFO).print_address_func = generic_print_address, \
   (INFO).print_insn = NULL, \
diff --git a/disas/arm.c b/disas/arm.c
index 27396dd3e1..9967c45990 100644
--- a/disas/arm.c
+++ b/disas/arm.c
@@ -70,6 +70,17 @@ static void floatformat_to_double (unsigned char *data, double *dest)
     *dest = u.f;
 }
 
+static int arm_read_memory(bfd_vma memaddr, bfd_byte *b, int length,
+                           struct disassemble_info *info)
+{
+    assert((info->flags & INSN_ARM_BE32) == 0 || length == 2 || length == 4);
+
+    if ((info->flags & INSN_ARM_BE32) != 0 && length == 2) {
+        memaddr ^= 2;
+    }
+    return info->read_memory_func(memaddr, b, length, info);
+}
+
 /* End of qemu specific additions.  */
 
 struct opcode32
@@ -3810,7 +3821,7 @@ find_ifthen_state (bfd_vma pc, struct disassemble_info *info,
 	  return;
 	}
       addr -= 2;
-      status = info->read_memory_func (addr, (bfd_byte *)b, 2, info);
+      status = arm_read_memory (addr, (bfd_byte *)b, 2, info);
       if (status)
 	return;
 
@@ -3882,7 +3893,7 @@ print_insn_arm (bfd_vma pc, struct disassemble_info *info)
       info->bytes_per_chunk = size;
       printer = print_insn_data;
 
-      status = info->read_memory_func (pc, (bfd_byte *)b, size, info);
+      status = arm_read_memory (pc, (bfd_byte *)b, size, info);
       given = 0;
       if (little)
 	for (i = size - 1; i >= 0; i--)
@@ -3899,7 +3910,7 @@ print_insn_arm (bfd_vma pc, struct disassemble_info *info)
       info->bytes_per_chunk = 4;
       size = 4;
 
-      status = info->read_memory_func (pc, (bfd_byte *)b, 4, info);
+      status = arm_read_memory (pc, (bfd_byte *)b, 4, info);
       if (little)
 	given = (b[0]) | (b[1] << 8) | (b[2] << 16) | ((unsigned)b[3] << 24);
       else
@@ -3915,7 +3926,7 @@ print_insn_arm (bfd_vma pc, struct disassemble_info *info)
       info->bytes_per_chunk = 2;
       size = 2;
 
-      status = info->read_memory_func (pc, (bfd_byte *)b, 2, info);
+      status = arm_read_memory (pc, (bfd_byte *)b, 2, info);
       if (little)
 	given = (b[0]) | (b[1] << 8);
       else
@@ -3929,7 +3940,7 @@ print_insn_arm (bfd_vma pc, struct disassemble_info *info)
 	      || (given & 0xF800) == 0xF000
 	      || (given & 0xF800) == 0xE800)
 	    {
-	      status = info->read_memory_func (pc + 2, (bfd_byte *)b, 2, info);
+	      status = arm_read_memory (pc + 2, (bfd_byte *)b, 2, info);
 	      if (little)
 		given = (b[0]) | (b[1] << 8) | (given << 16);
 	      else
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 88578f360e..82dad0b721 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -473,21 +473,6 @@ print_insn_thumb1(bfd_vma pc, disassemble_info *info)
   return print_insn_arm(pc | 1, info);
 }
 
-static int arm_read_memory_func(bfd_vma memaddr, bfd_byte *b,
-                                int length, struct disassemble_info *info)
-{
-    assert(info->read_memory_inner_func);
-    assert((info->flags & INSN_ARM_BE32) == 0 || length == 2 || length == 4);
-
-    if ((info->flags & INSN_ARM_BE32) != 0 && length == 2) {
-        assert(info->endian == BFD_ENDIAN_LITTLE);
-        return info->read_memory_inner_func(memaddr ^ 2, (bfd_byte *)b, 2,
-                                            info);
-    } else {
-        return info->read_memory_inner_func(memaddr, b, length, info);
-    }
-}
-
 static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     ARMCPU *ac = ARM_CPU(cpu);
@@ -513,10 +498,6 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
         info->endian = BFD_ENDIAN_BIG;
 #endif
     }
-    if (info->read_memory_inner_func == NULL) {
-        info->read_memory_inner_func = info->read_memory_func;
-        info->read_memory_func = arm_read_memory_func;
-    }
     info->flags &= ~INSN_ARM_BE32;
     if (arm_sctlr_b(env)) {
         info->flags |= INSN_ARM_BE32;
-- 
2.13.6
