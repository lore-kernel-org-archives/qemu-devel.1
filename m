Received: from eggs.gnu.org ([2001:4830:134:3::10]:37362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e64PZ-0002Hr-Qx
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 20:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e64PY-0008O3-3f
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 20:46:41 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:44600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e64PX-0008NA-Tm
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 20:46:40 -0400
Received: by mail-pf0-x243.google.com with SMTP id x7so14605632pfa.1
	for <qemu-devel@nongnu.org>; Sat, 21 Oct 2017 17:46:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 21 Oct 2017 17:46:19 -0700
Message-Id: <20171022004621.28372-10-richard.henderson@linaro.org>
In-Reply-To: <20171022004621.28372-1-richard.henderson@linaro.org>
References: <20171022004621.28372-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 09/11] ppc: Support Capstone in
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
Cc: qemu-ppc@nongnu.org

Cc: qemu-ppc@nongnu.org
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas.c                     | 4 ++++
 target/ppc/translate_init.c | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/disas.c b/disas.c
index 8d9bd4901c..e52e776a60 100644
--- a/disas.c
+++ b/disas.c
@@ -448,6 +448,10 @@ void disas(FILE *out, void *code, unsigned long size)
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
index 9b4353437a..41f46193a1 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -35,6 +35,7 @@
 #include "mmu-book3s-v3.h"
 #include "sysemu/qtest.h"
 #include "qemu/cutils.h"
+#include "disas/capstone.h"
 
 //#define PPC_DUMP_CPU
 //#define PPC_DEBUG_SPR
@@ -10537,6 +10538,11 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
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
2.13.6
