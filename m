Received: from eggs.gnu.org ([2001:4830:134:3::10]:39299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dcASE-0003yy-4a
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dcASA-0002t4-4U
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:09:50 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:35762)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dcAS9-0002qe-Rl
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:09:46 -0400
From: James Hogan <james.hogan@imgtec.com>
Date: Mon, 31 Jul 2017 14:09:13 +0100
Message-ID: <ad80a5d3ff807996b3cdf70504cab7efd66c4295.1501506432.git-series.james.hogan@imgtec.com>
In-Reply-To: <cover.6535001d6b9cd2357109d19b1060e3f6a2b958a7.1501506432.git-series.james.hogan@imgtec.com>
References: <cover.6535001d6b9cd2357109d19b1060e3f6a2b958a7.1501506432.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/2] mips: Add KVM T&E segment support for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: James Hogan <james.hogan@imgtec.com>, Yongbok Kim <yongbok.kim@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org

MIPS KVM trap & emulate guest kernels have a different segment layout
compared with traditional MIPS kernels, to allow both the user and
kernel code to run from the user address segment without repeatedly
trapping to KVM.

QEMU currently supports this layout only for KVM, but its sometimes
useful to be able to run these kernels in QEMU on a PC, so enable it for
TCG too.

This also paves the way for MIPS KVM VZ support (which uses the normal
virtual memory layout) by abstracting whether user mode kernel segments
are in use.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
---
 hw/mips/addr.c            | 12 ++++++++++++
 hw/mips/mips_malta.c      | 17 +++++++----------
 include/hw/mips/cpudevs.h |  5 +++--
 target/mips/helper.c      |  4 ++--
 target/mips/translate.c   |  4 ++--
 5 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/hw/mips/addr.c b/hw/mips/addr.c
index e4e86b4a7548..e552dfca843e 100644
--- a/hw/mips/addr.c
+++ b/hw/mips/addr.c
@@ -24,6 +24,8 @@
 #include "hw/hw.h"
 #include "hw/mips/cpudevs.h"
 
+static int mips_um_ksegs;
+
 uint64_t cpu_mips_kseg0_to_phys(void *opaque, uint64_t addr)
 {
     return addr & 0x1fffffffll;
@@ -38,3 +40,13 @@ uint64_t cpu_mips_kvm_um_phys_to_kseg0(void *opaque, uint64_t addr)
 {
     return addr | 0x40000000ll;
 }
+
+int mips_um_ksegs_enabled(void)
+{
+    return mips_um_ksegs;
+}
+
+void mips_um_ksegs_enable(void)
+{
+    mips_um_ksegs = 1;
+}
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 3487d16f61eb..f3354362890a 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -816,23 +816,20 @@ static int64_t load_kernel (void)
         exit(1);
     }
 
-    /* Sanity check where the kernel has been linked */
-    if (kvm_enabled()) {
-        if (kernel_entry & 0x80000000ll) {
+    /* Check where the kernel has been linked */
+    if (kernel_entry & 0x80000000ll) {
+        if (kvm_enabled()) {
             error_report("KVM guest kernels must be linked in useg. "
                          "Did you forget to enable CONFIG_KVM_GUEST?");
             exit(1);
         }
 
-        xlate_to_kseg0 = cpu_mips_kvm_um_phys_to_kseg0;
+        xlate_to_kseg0 = cpu_mips_phys_to_kseg0;
     } else {
-        if (!(kernel_entry & 0x80000000ll)) {
-            error_report("KVM guest kernels aren't supported with TCG. "
-                         "Did you unintentionally enable CONFIG_KVM_GUEST?");
-            exit(1);
-        }
+        /* if kernel entry is in useg it is probably a KVM T&E kernel */
+        mips_um_ksegs_enable();
 
-        xlate_to_kseg0 = cpu_mips_phys_to_kseg0;
+        xlate_to_kseg0 = cpu_mips_kvm_um_phys_to_kseg0;
     }
 
     /* load initrd */
diff --git a/include/hw/mips/cpudevs.h b/include/hw/mips/cpudevs.h
index 698339b83ec7..0c114f486edb 100644
--- a/include/hw/mips/cpudevs.h
+++ b/include/hw/mips/cpudevs.h
@@ -5,11 +5,12 @@
 
 /* Definitions for MIPS CPU internal devices.  */
 
-/* mips_addr.c */
+/* addr.c */
 uint64_t cpu_mips_kseg0_to_phys(void *opaque, uint64_t addr);
 uint64_t cpu_mips_phys_to_kseg0(void *opaque, uint64_t addr);
 uint64_t cpu_mips_kvm_um_phys_to_kseg0(void *opaque, uint64_t addr);
-
+int mips_um_ksegs_enabled(void);
+void mips_um_ksegs_enable(void);
 
 /* mips_int.c */
 void cpu_mips_irq_init_cpu(MIPSCPU *cpu);
diff --git a/target/mips/helper.c b/target/mips/helper.c
index 05883b9f4251..ca39aca08a64 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -19,10 +19,10 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "sysemu/kvm.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "exec/log.h"
+#include "hw/mips/cpudevs.h"
 
 enum {
     TLBRET_XI = -6,
@@ -225,7 +225,7 @@ static int get_physical_address (CPUMIPSState *env, hwaddr *physical,
 #define KVM_KSEG0_BASE  ((target_ulong)(int32_t)0x40000000UL)
 #define KVM_KSEG2_BASE  ((target_ulong)(int32_t)0x60000000UL)
 
-    if (kvm_enabled()) {
+    if (mips_um_ksegs_enabled()) {
         /* KVM T&E adds guest kernel segments in useg */
         if (real_address >= KVM_KSEG0_BASE) {
             if (real_address < KVM_KSEG2_BASE) {
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 51626aead32c..4635012d6436 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -27,10 +27,10 @@
 #include "exec/exec-all.h"
 #include "tcg-op.h"
 #include "exec/cpu_ldst.h"
+#include "hw/mips/cpudevs.h"
 
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
-#include "sysemu/kvm.h"
 #include "exec/semihost.h"
 
 #include "target/mips/trace.h"
@@ -20639,7 +20639,7 @@ void cpu_state_reset(CPUMIPSState *env)
     env->CP0_Wired = 0;
     env->CP0_GlobalNumber = (cs->cpu_index & 0xFF) << CP0GN_VPId;
     env->CP0_EBase = (cs->cpu_index & 0x3FF);
-    if (kvm_enabled()) {
+    if (mips_um_ksegs_enabled()) {
         env->CP0_EBase |= 0x40000000;
     } else {
         env->CP0_EBase |= (int32_t)0x80000000;
-- 
git-series 0.8.10
