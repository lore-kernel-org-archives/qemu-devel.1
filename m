Received: from eggs.gnu.org ([2001:4830:134:3::10]:43663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTfpj-0001W3-U6
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 22:51:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTfpi-00050b-PT
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 22:51:00 -0400
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri,  7 Jul 2017 16:50:29 -1000
Message-Id: <20170708025030.15845-3-rth@twiddle.net>
In-Reply-To: <20170708025030.15845-1-rth@twiddle.net>
References: <20170708025030.15845-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 2/3] linux-user: Tidy and enforce reserved_va
 initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, qemu-arm@nongnu.org, aurelien@aurel32.net

We had a check using TARGET_VIRT_ADDR_SPACE_BITS to make sure
that the allocation coming in from the command-line option was
not too large, but that didn't include target-specific knowledge
about other restrictions on user-space.

Remove several target-specific hacks in linux-user/main.c.

For MIPS and Nios, we can replace them with proper adjustments
to the respective target's TARGET_VIRT_ADDR_SPACE_BITS definition.

For ARM, we had no existing ifdef but I suspect that the current
default value of 0xf7000000 was chosen with this in mind.  Define
a workable value in linux-user/arm/, and also document why the
special case is required.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 linux-user/arm/target_cpu.h |  4 ++++
 target/mips/mips-defs.h     |  6 +++++-
 target/nios2/cpu.h          |  6 +++++-
 linux-user/main.c           | 38 +++++++++++++++++++++++++-------------
 4 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/linux-user/arm/target_cpu.h b/linux-user/arm/target_cpu.h
index d888219..c4f79eb 100644
--- a/linux-user/arm/target_cpu.h
+++ b/linux-user/arm/target_cpu.h
@@ -19,6 +19,10 @@
 #ifndef ARM_TARGET_CPU_H
 #define ARM_TARGET_CPU_H
 
+/* We need to be able to map the commpage.
+   See validate_guest_space in linux-user/elfload.c.  */
+#define MAX_RESERVED_VA  0xfff00000ul
+
 static inline void cpu_clone_regs(CPUARMState *env, target_ulong newsp)
 {
     if (newsp) {
diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
index 047554e..d239069 100644
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -15,7 +15,11 @@
 #else
 #define TARGET_LONG_BITS 32
 #define TARGET_PHYS_ADDR_SPACE_BITS 40
-#define TARGET_VIRT_ADDR_SPACE_BITS 32
+# ifdef CONFIG_USER_ONLY
+#  define TARGET_VIRT_ADDR_SPACE_BITS 31
+# else
+#  define TARGET_VIRT_ADDR_SPACE_BITS 32
+#endif
 #endif
 
 /* Masks used to mark instructions to indicate which ISA level they
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 13931f3..da3f637 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -227,7 +227,11 @@ qemu_irq *nios2_cpu_pic_init(Nios2CPU *cpu);
 void nios2_check_interrupts(CPUNios2State *env);
 
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
-#define TARGET_VIRT_ADDR_SPACE_BITS 32
+#ifdef CONFIG_USER_ONLY
+# define TARGET_VIRT_ADDR_SPACE_BITS 31
+#else
+# define TARGET_VIRT_ADDR_SPACE_BITS 32
+#endif
 
 #define cpu_init(cpu_model) CPU(cpu_nios2_init(cpu_model))
 
diff --git a/linux-user/main.c b/linux-user/main.c
index ad03c9e..e000533 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -60,23 +60,38 @@ do {                                                                    \
     }                                                                   \
 } while (0)
 
-#if (TARGET_LONG_BITS == 32) && (HOST_LONG_BITS == 64)
 /*
  * When running 32-on-64 we should make sure we can fit all of the possible
  * guest address space into a contiguous chunk of virtual host memory.
  *
  * This way we will never overlap with our own libraries or binaries or stack
  * or anything else that QEMU maps.
+ *
+ * Many cpus reserve the high bit (or more than one for some 64-bit cpus)
+ * of the address for the kernel.  Some cpus rely on this and user space
+ * uses the high bit(s) for pointer tagging and the like.  For them, we
+ * must preserve the expected address space.
  */
-# if defined(TARGET_MIPS) || defined(TARGET_NIOS2)
-/*
- * MIPS only supports 31 bits of virtual address space for user space.
- * Nios2 also only supports 31 bits.
- */
-unsigned long reserved_va = 0x77000000;
+#ifndef MAX_RESERVED_VA
+# if HOST_LONG_BITS > TARGET_VIRT_ADDR_SPACE_BITS
+#  if TARGET_VIRT_ADDR_SPACE_BITS == 32 && \
+      (TARGET_LONG_BITS == 32 || defined(TARGET_ABI32))
+/* There are a number of places where we assign reserved_va to a variable
+   of type abi_ulong and expect it to fit.  Avoid the last page.  */
+#   define MAX_RESERVED_VA  (0xfffffffful & TARGET_PAGE_MASK)
+#  else
+#   define MAX_RESERVED_VA  (1ul << TARGET_VIRT_ADDR_SPACE_BITS)
+#  endif
 # else
-unsigned long reserved_va = 0xf7000000;
+#  define MAX_RESERVED_VA  0
 # endif
+#endif
+
+/* That said, reserving *too* much vm space via mmap can run into problems
+   with rlimits, oom due to page table creation, etc.  We will still try it,
+   if directed by the command-line option, but not by default.  */
+#if HOST_LONG_BITS == 64 && TARGET_VIRT_ADDR_SPACE_BITS <= 32
+unsigned long reserved_va = MAX_RESERVED_VA;
 #else
 unsigned long reserved_va;
 #endif
@@ -3975,11 +3990,8 @@ static void handle_arg_reserved_va(const char *arg)
         unsigned long unshifted = reserved_va;
         p++;
         reserved_va <<= shift;
-        if (((reserved_va >> shift) != unshifted)
-#if HOST_LONG_BITS > TARGET_VIRT_ADDR_SPACE_BITS
-            || (reserved_va > (1ul << TARGET_VIRT_ADDR_SPACE_BITS))
-#endif
-            ) {
+        if (reserved_va >> shift != unshifted
+            || (MAX_RESERVED_VA && reserved_va > MAX_RESERVED_VA)) {
             fprintf(stderr, "Reserved virtual address too big\n");
             exit(EXIT_FAILURE);
         }
-- 
2.9.4
