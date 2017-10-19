Received: from eggs.gnu.org ([2001:4830:134:3::10]:47745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5D71-0007Bp-Pv
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:52:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5D70-0000G8-VM
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:51:59 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:54331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e5D70-0000FZ-PR
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:51:58 -0400
Received: by mail-pf0-x241.google.com with SMTP id n89so6854418pfk.11
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 08:51:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 19 Oct 2017 08:51:43 -0700
Message-Id: <20171019155146.30434-7-richard.henderson@linaro.org>
In-Reply-To: <20171019155146.30434-1-richard.henderson@linaro.org>
References: <20171019155146.30434-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 6/9] arm: Support Capstone in disas_set_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas.c          |  3 +++
 target/arm/cpu.c | 21 ++++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/disas.c b/disas.c
index 63dc573e9f..8d9bd4901c 100644
--- a/disas.c
+++ b/disas.c
@@ -450,6 +450,7 @@ void disas(FILE *out, void *code, unsigned long size)
     print_insn = print_insn_ppc;
 #elif defined(__aarch64__) && defined(CONFIG_ARM_A64_DIS)
     print_insn = print_insn_arm_a64;
+    s.info.cap_arch = CS_ARCH_ARM64;
 #elif defined(__alpha__)
     print_insn = print_insn_alpha;
 #elif defined(__sparc__)
@@ -457,6 +458,8 @@ void disas(FILE *out, void *code, unsigned long size)
     s.info.mach = bfd_mach_sparc_v9b;
 #elif defined(__arm__)
     print_insn = print_insn_arm;
+    s.info.cap_arch = CS_ARCH_ARM;
+    /* TCG only generates code for arm mode.  */
 #elif defined(__MIPSEB__)
     print_insn = print_insn_big_mips;
 #elif defined(__MIPSEL__)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 88578f360e..1576a6d372 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -33,6 +33,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/hw_accel.h"
 #include "kvm_arm.h"
+#include "disas/capstone.h"
 
 static void arm_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -501,10 +502,24 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 #if defined(CONFIG_ARM_A64_DIS)
         info->print_insn = print_insn_arm_a64;
 #endif
-    } else if (env->thumb) {
-        info->print_insn = print_insn_thumb1;
+        info->cap_arch = CS_ARCH_ARM64;
     } else {
-        info->print_insn = print_insn_arm;
+        int cap_mode;
+        if (env->thumb) {
+            info->print_insn = print_insn_thumb1;
+            cap_mode = CS_MODE_THUMB;
+        } else {
+            info->print_insn = print_insn_arm;
+            cap_mode = CS_MODE_ARM;
+        }
+        if (arm_feature(env, ARM_FEATURE_V8)) {
+            cap_mode |= CS_MODE_V8;
+        }
+        if (arm_feature(env, ARM_FEATURE_M)) {
+            cap_mode |= CS_MODE_MCLASS;
+        }
+        info->cap_arch = CS_ARCH_ARM;
+        info->cap_mode = cap_mode;
     }
     if (bswap_code(arm_sctlr_b(env))) {
 #ifdef TARGET_WORDS_BIGENDIAN
-- 
2.13.6
