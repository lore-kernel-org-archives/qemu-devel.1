Received: from eggs.gnu.org ([2001:4830:134:3::10]:49673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsYz3-0000Qd-9I
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsYz2-0000XY-Ec
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:35:29 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:49374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsYz2-0000WA-6l
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:35:28 -0400
Received: by mail-pg0-x232.google.com with SMTP id m30so118660pgn.6
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 11:35:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 14 Sep 2017 11:35:12 -0700
Message-Id: <20170914183516.19537-7-richard.henderson@linaro.org>
In-Reply-To: <20170914183516.19537-1-richard.henderson@linaro.org>
References: <20170914183516.19537-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 06/10] target/arm: Support Capstone in
 disas_set_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

Cc: qemu-arm@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a1acce3c7a..92159ca0b1 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -33,6 +33,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/hw_accel.h"
 #include "kvm_arm.h"
+#include "disas/capstone.h"
 
 static void arm_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -476,10 +477,24 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
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
2.13.5
