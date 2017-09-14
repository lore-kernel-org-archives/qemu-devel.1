Received: from eggs.gnu.org ([2001:4830:134:3::10]:49810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsYzB-0000X5-7b
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:35:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsYz7-0000et-Qc
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:35:37 -0400
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:43507)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsYz7-0000dS-Jb
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:35:33 -0400
Received: by mail-pg0-x22b.google.com with SMTP id u18so127516pgo.0
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 11:35:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 14 Sep 2017 11:35:16 -0700
Message-Id: <20170914183516.19537-11-richard.henderson@linaro.org>
In-Reply-To: <20170914183516.19537-1-richard.henderson@linaro.org>
References: <20170914183516.19537-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 10/10] target/mips: Support Capstone in
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
Cc: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>

Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/cpu.h            |  2 ++
 target/mips/cpu.c            |  8 --------
 target/mips/translate_init.c | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 74f6a5b098..dca713825d 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1118,4 +1118,6 @@ static inline void QEMU_NORETURN do_raise_exception(CPUMIPSState *env,
     do_raise_exception_err(env, exception, 0, pc);
 }
 
+void mips_cpu_disas_set_info(CPUState *s, disassemble_info *info);
+
 #endif /* MIPS_CPU_H */
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 1bb66b7a5a..898f1b3759 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -111,14 +111,6 @@ static void mips_cpu_reset(CPUState *s)
 #endif
 }
 
-static void mips_cpu_disas_set_info(CPUState *s, disassemble_info *info) {
-#ifdef TARGET_WORDS_BIGENDIAN
-    info->print_insn = print_insn_big_mips;
-#else
-    info->print_insn = print_insn_little_mips;
-#endif
-}
-
 static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
diff --git a/target/mips/translate_init.c b/target/mips/translate_init.c
index 255d25bacd..1d43b3c36d 100644
--- a/target/mips/translate_init.c
+++ b/target/mips/translate_init.c
@@ -947,3 +947,39 @@ static void msa_reset(CPUMIPSState *env)
     /* set proper signanling bit meaning ("1" means "quiet") */
     set_snan_bit_is_one(0, &env->active_tc.msa_fp_status);
 }
+
+#include "disas/capstone.h"
+
+void mips_cpu_disas_set_info(CPUState *s, disassemble_info *info)
+{
+    MIPSCPU *cpu = MIPS_CPU(s);
+    CPUMIPSState *env = &cpu->env;
+    int insn_flags = env->cpu_model->insn_flags;
+    int cap_mode;
+
+#ifdef TARGET_WORDS_BIGENDIAN
+    info->print_insn = print_insn_big_mips;
+#else
+    info->print_insn = print_insn_little_mips;
+#endif
+
+    cap_mode = 0;
+    if (insn_flags & ISA_MIPS3) {
+        cap_mode |= CS_MODE_MIPS3;
+    }
+    if (insn_flags & ISA_MIPS32) {
+        cap_mode |= CS_MODE_MIPS32;
+    }
+    if (insn_flags & ISA_MIPS64) {
+        cap_mode |= CS_MODE_MIPS64;
+    }
+    if (insn_flags & ISA_MIPS32R6) {
+        cap_mode |= CS_MODE_MIPS32R6;
+    }
+#ifdef TARGET_MIPS64
+    cap_mode |= CS_MODE_MIPSGP64;
+#endif
+
+    info->cap_arch = CS_ARCH_MIPS;
+    info->cap_mode = cap_mode;
+}
-- 
2.13.5
