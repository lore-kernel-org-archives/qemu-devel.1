Received: from eggs.gnu.org ([2001:4830:134:3::10]:34718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dmkEg-0007rT-BN
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 13:23:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dmkEb-0001jK-DV
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 13:23:34 -0400
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:34710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dmkEb-0001jA-8H
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 13:23:29 -0400
Received: by mail-yw0-x242.google.com with SMTP id h127so2482438ywf.1
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 10:23:29 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue, 29 Aug 2017 13:23:26 -0400
Message-Id: <20170829172326.1131-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [PATCH] tcg/softmmu: Increase size of TLB caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net

This patch increases the number of entries cached in the TLB. I went
over a few architectures to see if increasing it is problematic. Only
armv6 seems to have a limitation that only 8 bits can be used for
indexing these entries. For other architectures, the number of TLB
entries is increased to a 4K-sized cache. The patch also doubles the
number of victim TLB entries.

Some statistics collected from a build benchmark for various cache
sizes is listed below:

| TLB bits\vTLB entires |             8 |            16  |            32 |
|                     8 | 952.94(+0.0%) | 929.99(+2.4%)  | 919.02(+3.6%) |
|                    10 | 898.92(+5.6%) | 886.13(+7.0%)  | 887.03(+6.9%) |
|                    12 | 878.56(+7.8%) | 873.53(+8.3%)* | 875.34(+8.1%) |

The best combination for this workload came out to be 12 bits for the
TLB and a 16 entry vTLB cache.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 include/exec/cpu-defs.h  | 6 +++---
 tcg/aarch64/tcg-target.h | 1 +
 tcg/arm/tcg-target.h     | 1 +
 tcg/i386/tcg-target.h    | 2 ++
 tcg/ia64/tcg-target.h    | 1 +
 tcg/mips/tcg-target.h    | 2 ++
 tcg/ppc/tcg-target.h     | 1 +
 tcg/s390/tcg-target.h    | 1 +
 tcg/sparc/tcg-target.h   | 1 +
 tcg/tci/tcg-target.h     | 1 +
 10 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index bc8e7f848d..1957e3f32c 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -57,8 +57,8 @@ typedef uint64_t target_ulong;
 #endif
 
 #if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
-/* use a fully associative victim tlb of 8 entries */
-#define CPU_VTLB_SIZE 8
+/* use a fully associative victim tlb of 16 entries */
+#define CPU_VTLB_SIZE 16
 
 #if HOST_LONG_BITS == 32 && TARGET_LONG_BITS == 32
 #define CPU_TLB_ENTRY_BITS 4
@@ -89,7 +89,7 @@ typedef uint64_t target_ulong;
  * of tlb_table inside env (which is non-trivial but not huge).
  */
 #define CPU_TLB_BITS                                             \
-    MIN(8,                                                       \
+    MIN(MIN(12, TCG_TARGET_TLB_MAX_INDEX_BITS),                  \
         TCG_TARGET_TLB_DISPLACEMENT_BITS - CPU_TLB_ENTRY_BITS -  \
         (NB_MMU_MODES <= 1 ? 0 :                                 \
          NB_MMU_MODES <= 2 ? 1 :                                 \
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index b41a248bee..9f4558cd83 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -15,6 +15,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE  4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 24
+#define TCG_TARGET_TLB_MAX_INDEX_BITS 32
 #undef TCG_TARGET_STACK_GROWSUP
 
 typedef enum {
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index a38be15a39..ebe27991f3 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -60,6 +60,7 @@ extern int arm_arch;
 #undef TCG_TARGET_STACK_GROWSUP
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
+#define TCG_TARGET_TLB_MAX_INDEX_BITS 8
 
 typedef enum {
     TCG_REG_R0 = 0,
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 73a15f7e80..5279af6eb1 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -162,6 +162,8 @@ extern bool have_popcnt;
 # define TCG_AREG0 TCG_REG_EBP
 #endif
 
+#define TCG_TARGET_TLB_MAX_INDEX_BITS (32 - CPU_TLB_ENTRY_BITS)
+
 static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
 {
 }
diff --git a/tcg/ia64/tcg-target.h b/tcg/ia64/tcg-target.h
index 8f475fe742..35878e20c7 100644
--- a/tcg/ia64/tcg-target.h
+++ b/tcg/ia64/tcg-target.h
@@ -28,6 +28,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE 16
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 21
+#define TCG_TARGET_TLB_MAX_INDEX_BITS 32
 
 typedef struct {
     uint64_t lo __attribute__((aligned(16)));
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index e9558d15bc..1b60e53169 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -39,6 +39,8 @@
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
 #define TCG_TARGET_NB_REGS 32
 
+#define TCG_TARGET_TLB_MAX_INDEX_BITS (16 - CPU_TLB_ENTRY_BITS)
+
 typedef enum {
     TCG_REG_ZERO = 0,
     TCG_REG_AT,
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 5a092b038a..82e10c9471 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -34,6 +34,7 @@
 #define TCG_TARGET_NB_REGS 32
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
+#define TCG_TARGET_TLB_MAX_INDEX_BITS 32
 
 typedef enum {
     TCG_REG_R0,  TCG_REG_R1,  TCG_REG_R2,  TCG_REG_R3,
diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index dc0e59193c..57f0e22532 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -27,6 +27,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE 2
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 19
+#define TCG_TARGET_TLB_MAX_INDEX_BITS 32
 
 typedef enum TCGReg {
     TCG_REG_R0 = 0,
diff --git a/tcg/sparc/tcg-target.h b/tcg/sparc/tcg-target.h
index 4515c9ab48..378d218923 100644
--- a/tcg/sparc/tcg-target.h
+++ b/tcg/sparc/tcg-target.h
@@ -29,6 +29,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 32
+#define TCG_TARGET_TLB_MAX_INDEX_BITS 12
 #define TCG_TARGET_NB_REGS 32
 
 typedef enum {
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 06963288dc..bb36e8197d 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -43,6 +43,7 @@
 #define TCG_TARGET_INTERPRETER 1
 #define TCG_TARGET_INSN_UNIT_SIZE 1
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 32
+#define TCG_TARGET_TLB_MAX_INDEX_BITS 32
 
 #if UINTPTR_MAX == UINT32_MAX
 # define TCG_TARGET_REG_BITS 32
-- 
2.13.0
