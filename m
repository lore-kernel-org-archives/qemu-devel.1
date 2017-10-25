Received: from eggs.gnu.org ([2001:4830:134:3::10]:42916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7Kq3-0007WX-AT
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7Kq2-00083R-7x
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:31:15 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:54239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7Kq2-00082r-15
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:31:14 -0400
Received: by mail-wm0-x244.google.com with SMTP id r196so1625100wmf.2
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 05:31:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 14:30:52 +0200
Message-Id: <20171025123056.3165-8-richard.henderson@linaro.org>
In-Reply-To: <20171025123056.3165-1-richard.henderson@linaro.org>
References: <20171025123056.3165-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/11] i386: Support Capstone in disas_set_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

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
