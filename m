Received: from eggs.gnu.org ([2001:4830:134:3::10]:44019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwwFf-0002xH-8V
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 16:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwwFe-0003Fc-7p
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 16:14:43 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:48917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dwwFe-0003F9-2J
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 16:14:42 -0400
Received: by mail-pg0-x22d.google.com with SMTP id v23so6516366pgc.5
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 13:14:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 26 Sep 2017 13:14:25 -0700
Message-Id: <20170926201427.2833-8-richard.henderson@linaro.org>
In-Reply-To: <20170926201427.2833-1-richard.henderson@linaro.org>
References: <20170926201427.2833-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 7/9] ppc: Support Capstone in disas_set_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-ppc@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas.c                     | 4 ++++
 target/ppc/translate_init.c | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/disas.c b/disas.c
index 23c4742f8d..0d212f2ac5 100644
--- a/disas.c
+++ b/disas.c
@@ -449,6 +449,10 @@ void disas(FILE *out, void *code, unsigned long size)
 #elif defined(_ARCH_PPC)
     s.info.disassembler_options = (char *)"any";
     print_insn = print_insn_ppc;
+    s.info.cap_arch = CS_ARCH_PPC;
+# ifdef _ARCH_PPC64
+    s.info.cap_mode = CS_MODE_64;
+# endif
 #elif defined(__aarch64__) && defined(CONFIG_ARM_A64_DIS)
     print_insn = print_insn_arm_a64;
     s.info.cap_arch = CS_ARCH_ARM64;
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 5524b171e0..599068cb22 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -35,6 +35,7 @@
 #include "mmu-book3s-v3.h"
 #include "sysemu/qtest.h"
 #include "qemu/cutils.h"
+#include "disas/capstone.h"
 
 //#define PPC_DUMP_CPU
 //#define PPC_DEBUG_SPR
@@ -10661,6 +10662,11 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
     }
     info->disassembler_options = (char *)"any";
     info->print_insn = print_insn_ppc;
+
+    info->cap_arch = CS_ARCH_PPC;
+#ifdef TARGET_PPC64
+    info->cap_mode = CS_MODE_64;
+#endif
 }
 
 static Property ppc_cpu_properties[] = {
-- 
2.13.5
