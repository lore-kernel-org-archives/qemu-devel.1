Received: from eggs.gnu.org ([2001:4830:134:3::10]:48126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dkuXS-0003cN-2k
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dkuXO-00060M-W6
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:59:22 -0400
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Thu, 24 Aug 2017 11:58:49 -0400
Message-Id: <20170824155849.30799-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [RFC v2 PATCH] tcg/softmmu: Increase size of TLB caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Claudio Fontana <claudio.fontana@huawei.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, "open list:Overall" <qemu-devel@nongnu.org>, "open list:AArch64 target" <qemu-arm@nongnu.org>

This patch increases the number of entries cached in the TLB. I went
over a few architectures to see if increasing it is problematic. Only
armv6 seems to have a limitation that only 8 bits can be used for
indexing these entries. For other architectures, the number of TLB
entries is increased to a 4K-sized cache. The patch also doubles the
number of victim TLB entries.

A few statistics collected from a build benchmark for various cache
sizes is below:

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
 tcg/mips/tcg-target.h    | 1 +
 tcg/ppc/tcg-target.h     | 1 +
 tcg/s390/tcg-target.h    | 1 +
 tcg/sparc/tcg-target.h   | 1 +
 tcg/tci/tcg-target.h     | 1 +
 10 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index bc8e7f848d..a5e1ad6cea 100644
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
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 5ef1086710..69414be393 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -60,6 +60,7 @@ extern int arm_arch;
 #undef TCG_TARGET_STACK_GROWSUP
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
+#define CPU_TLB_BITS_MAX 8
 
 typedef enum {
     TCG_REG_R0 = 0,
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
diff --git a/tcg/ia64/tcg-target.h b/tcg/ia64/tcg-target.h
index 901bb7575d..fd713f7adf 100644
--- a/tcg/ia64/tcg-target.h
+++ b/tcg/ia64/tcg-target.h
@@ -28,6 +28,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE 16
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 21
+#define CPU_TLB_BITS_MAX 8
 
 typedef struct {
     uint64_t lo __attribute__((aligned(16)));
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
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 5f4a40a5b4..f5071f706d 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -34,6 +34,7 @@
 #define TCG_TARGET_NB_REGS 32
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
+#define CPU_TLB_BITS_MAX 8
 
 typedef enum {
     TCG_REG_R0,  TCG_REG_R1,  TCG_REG_R2,  TCG_REG_R3,
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
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 06963288dc..3d39d479ea 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -43,6 +43,7 @@
 #define TCG_TARGET_INTERPRETER 1
 #define TCG_TARGET_INSN_UNIT_SIZE 1
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 32
+#define CPU_TLB_BITS_MAX 8
 
 #if UINTPTR_MAX == UINT32_MAX
 # define TCG_TARGET_REG_BITS 32
-- 
2.13.0
