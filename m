Received: from eggs.gnu.org ([2001:4830:134:3::10]:55441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eX8be-0007cP-Rx
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:43:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eX8bb-0003bT-3l
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:43:02 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:65240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eX8ba-0003ZP-Mn
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:42:58 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  4 Jan 2018 17:42:44 +0100
Message-Id: <20180104164251.26494-11-laurent@vivier.eu>
In-Reply-To: <20180104164251.26494-1-laurent@vivier.eu>
References: <20180104164251.26494-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 10/17] target/m68k: add cpush/cinv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

Add cache lines invalidate and cache lines push
as no-op operations, as we don't have cache.

These instructions are 68040 only.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180104012913.30763-11-laurent@vivier.eu>
---
 target/m68k/translate.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index f77005215f..98efe6b976 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4496,6 +4496,24 @@ DISAS_INSN(cpushl)
     /* Cache push/invalidate.  Implement as no-op.  */
 }
 
+DISAS_INSN(cpush)
+{
+    if (IS_USER(s)) {
+        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        return;
+    }
+    /* Cache push/invalidate.  Implement as no-op.  */
+}
+
+DISAS_INSN(cinv)
+{
+    if (IS_USER(s)) {
+        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        return;
+    }
+    /* Invalidate cache line.  Implement as no-op.  */
+}
+
 DISAS_INSN(wddata)
 {
     gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
@@ -5674,6 +5692,8 @@ void register_m68k_insns (CPUM68KState *env)
     INSN(fsave,     f300, ffc0, FPU);
     INSN(intouch,   f340, ffc0, CF_ISA_A);
     INSN(cpushl,    f428, ff38, CF_ISA_A);
+    INSN(cpush,     f420, ff20, M68040);
+    INSN(cinv,      f400, ff20, M68040);
     INSN(wddata,    fb00, ff00, CF_ISA_A);
     INSN(wdebug,    fbc0, ffc0, CF_ISA_A);
 #endif
-- 
2.14.3
