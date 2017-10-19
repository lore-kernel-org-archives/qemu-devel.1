Received: from eggs.gnu.org ([2001:4830:134:3::10]:47731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5D70-0007BC-LN
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:52:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5D6z-0000FE-Ia
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:51:58 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:50831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e5D6z-0000ET-Dt
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:51:57 -0400
Received: by mail-pf0-x243.google.com with SMTP id b6so6866228pfh.7
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 08:51:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 19 Oct 2017 08:51:42 -0700
Message-Id: <20171019155146.30434-6-richard.henderson@linaro.org>
In-Reply-To: <20171019155146.30434-1-richard.henderson@linaro.org>
References: <20171019155146.30434-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 5/9] i386: Support Capstone in disas_set_info
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

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas.c           | 4 ++++
 target/i386/cpu.c | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/disas.c b/disas.c
index e392a2926e..63dc573e9f 100644
--- a/disas.c
+++ b/disas.c
@@ -438,9 +438,13 @@ void disas(FILE *out, void *code, unsigned long size)
 #elif defined(__i386__)
     s.info.mach = bfd_mach_i386_i386;
     print_insn = print_insn_i386;
+    s.info.cap_arch = CS_ARCH_X86;
+    s.info.cap_mode = CS_MODE_32;
 #elif defined(__x86_64__)
     s.info.mach = bfd_mach_x86_64;
     print_insn = print_insn_i386;
+    s.info.cap_arch = CS_ARCH_X86;
+    s.info.cap_mode = CS_MODE_64;
 #elif defined(_ARCH_PPC)
     s.info.disassembler_options = (char *)"any";
     print_insn = print_insn_ppc;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 13b2f8fbc5..cf890b763b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -51,6 +51,8 @@
 #include "hw/i386/apic_internal.h"
 #endif
 
+#include "disas/capstone.h"
+
 
 /* Cache topology CPUID constants: */
 
@@ -4106,6 +4108,11 @@ static void x86_disas_set_info(CPUState *cs, disassemble_info *info)
                   : env->hflags & HF_CS32_MASK ? bfd_mach_i386_i386
                   : bfd_mach_i386_i8086);
     info->print_insn = print_insn_i386;
+
+    info->cap_arch = CS_ARCH_X86;
+    info->cap_mode = (env->hflags & HF_CS64_MASK ? CS_MODE_64
+                      : env->hflags & HF_CS32_MASK ? CS_MODE_32
+                      : CS_MODE_16);
 }
 
 static Property x86_cpu_properties[] = {
-- 
2.13.6
