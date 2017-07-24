Received: from eggs.gnu.org ([2001:4830:134:3::10]:58399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dZkVV-0005Sb-Vi
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dZkVS-0002UD-Ri
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:03:13 -0400
Received: from mail-yw0-x244.google.com ([2607:f8b0:4002:c05::244]:37047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dZkVS-0002Tt-NQ
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:03:10 -0400
Received: by mail-yw0-x244.google.com with SMTP id h189so5752235ywf.4
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 14:03:09 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 24 Jul 2017 17:03:06 -0400
Message-Id: <20170724210306.18428-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [RFC PATCH] tcg/softmmu: Increase size of TLB cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, pbonzini@redhat.com

This patch increases the number of entries we allow in the TLB. I went
over a few architectures to see if increasing it is problematic. Only
armv6 seems to have a limitation that only 8 bits can be used for
indexing these entries. For other architectures, I increased the
number of TLB entries to a 4K-sized cache.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 include/exec/cpu-defs.h  | 5 ++++-
 tcg/aarch64/tcg-target.h | 1 +
 tcg/i386/tcg-target.h    | 2 ++
 tcg/mips/tcg-target.h    | 1 +
 tcg/s390/tcg-target.h    | 1 +
 tcg/sparc/tcg-target.h   | 1 +
 6 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 29b3c2ada8..cb81232b83 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -64,6 +64,9 @@ typedef uint64_t target_ulong;
 #define CPU_TLB_ENTRY_BITS 5
 #endif
 
+#ifndef CPU_TLB_BITS_MAX
+# define CPU_TLB_BITS_MAX 8
+#endif
 /* TCG_TARGET_TLB_DISPLACEMENT_BITS is used in CPU_TLB_BITS to ensure that
  * the TLB is not unnecessarily small, but still small enough for the
  * TLB lookup instruction sequence used by the TCG target.
@@ -87,7 +90,7 @@ typedef uint64_t target_ulong;
  * of tlb_table inside env (which is non-trivial but not huge).
  */
 #define CPU_TLB_BITS                                             \
-    MIN(8,                                                       \
+    MIN(CPU_TLB_BITS_MAX,                                        \
         TCG_TARGET_TLB_DISPLACEMENT_BITS - CPU_TLB_ENTRY_BITS -  \
         (NB_MMU_MODES <= 1 ? 0 :                                 \
          NB_MMU_MODES <= 2 ? 1 :                                 \
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 55a46ac825..f428e09c98 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -15,6 +15,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE  4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 24
+#define CPU_TLB_BITS_MAX 12
 #undef TCG_TARGET_STACK_GROWSUP
 
 typedef enum {
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 73a15f7e80..35c27a977b 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -162,6 +162,8 @@ extern bool have_popcnt;
 # define TCG_AREG0 TCG_REG_EBP
 #endif
 
+#define CPU_TLB_BITS_MAX 12
+
 static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
 {
 }
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index d75cb63ed3..fd9046b7ad 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -37,6 +37,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
+#define CPU_TLB_BITS_MAX 12
 #define TCG_TARGET_NB_REGS 32
 
 typedef enum {
diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index 957f0c0afe..218be322ad 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -27,6 +27,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE 2
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 19
+#define CPU_TLB_BITS_MAX 12
 
 typedef enum TCGReg {
     TCG_REG_R0 = 0,
diff --git a/tcg/sparc/tcg-target.h b/tcg/sparc/tcg-target.h
index 854a0afd70..9fd59a64f2 100644
--- a/tcg/sparc/tcg-target.h
+++ b/tcg/sparc/tcg-target.h
@@ -29,6 +29,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 32
+#define CPU_TLB_BITS_MAX 12
 #define TCG_TARGET_NB_REGS 32
 
 typedef enum {
-- 
2.13.0
