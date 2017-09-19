Received: from eggs.gnu.org ([2001:4830:134:3::10]:49157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duK3h-00088G-S3
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duK3g-0003lY-Ig
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:03:33 -0400
Received: from mail-io0-x233.google.com ([2607:f8b0:4001:c06::233]:49511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1duK3g-0003lA-CC
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:03:32 -0400
Received: by mail-io0-x233.google.com with SMTP id 21so725884iof.6
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 08:03:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 19 Sep 2017 10:03:12 -0500
Message-Id: <20170919150313.10833-8-richard.henderson@linaro.org>
In-Reply-To: <20170919150313.10833-1-richard.henderson@linaro.org>
References: <20170919150313.10833-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 7/8] ppc: Support Capstone in disas_set_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>

Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas.c                     | 4 ++++
 target/ppc/translate_init.c | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/disas.c b/disas.c
index ea295f9cfc..b4e4fc409e 100644
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
index c7b4a7c02a..b976784d21 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -35,6 +35,7 @@
 #include "mmu-book3s-v3.h"
 #include "sysemu/qtest.h"
 #include "qemu/cutils.h"
+#include "disas/capstone.h"
 
 //#define PPC_DUMP_CPU
 //#define PPC_DEBUG_SPR
@@ -10662,6 +10663,11 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
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
