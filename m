Received: from eggs.gnu.org ([2001:4830:134:3::10]:55337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dxc4y-0004nn-7I
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 12:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dxc4x-0004Mh-Jx
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 12:54:28 -0400
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:49170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dxc4x-0004MD-FS
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 12:54:27 -0400
Received: by mail-pf0-x229.google.com with SMTP id l188so1140943pfc.6
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 09:54:27 -0700 (PDT)
Received: from bigtime.twiddle.net ([70.35.39.2])
	by smtp.gmail.com with ESMTPSA id
	e133sm3062332pfh.177.2017.09.28.09.54.23 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 28 Sep 2017 09:54:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Sep 2017 09:54:10 -0700
Message-Id: <20170928165414.7339-6-richard.henderson@linaro.org>
In-Reply-To: <20170928165414.7339-1-richard.henderson@linaro.org>
References: <20170928165414.7339-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 5/9] i386: Support Capstone in disas_set_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas.c           | 4 ++++
 target/i386/cpu.c | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/disas.c b/disas.c
index 746d76c07d..1c44514254 100644
--- a/disas.c
+++ b/disas.c
@@ -439,9 +439,13 @@ void disas(FILE *out, void *code, unsigned long size)
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
2.13.5
