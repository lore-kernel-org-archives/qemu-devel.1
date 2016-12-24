Received: from eggs.gnu.org ([2001:4830:134:3::10]:45426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cKkh6-0007SI-Hf
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cKkh3-00083T-DO
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:40:56 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:64919)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cKkh3-000827-2Q
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:40:53 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sat, 24 Dec 2016 12:40:30 +0100
Message-Id: <1482579633-3393-10-git-send-email-laurent@vivier.eu>
In-Reply-To: <1482579633-3393-1-git-send-email-laurent@vivier.eu>
References: <1482579633-3393-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 09/12] target-m68k: Do not cpu_abort on
 undefined insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

From: Richard Henderson <rth@twiddle.net>

Report this properly via exception and, importantly, allow
the disassembler the chance to tell us what insn is not handled.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <1478699171-10637-3-git-send-email-rth@twiddle.net>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index acc8182..0417c32 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1214,10 +1214,12 @@ DISAS_INSN(undef_fpu)
 
 DISAS_INSN(undef)
 {
-    M68kCPU *cpu = m68k_env_get_cpu(env);
-
+    /* ??? This is both instructions that are as yet unimplemented
+       for the 680x0 series, as well as those that are implemented
+       but actually illegal for CPU32 or pre-68020.  */
+    qemu_log_mask(LOG_UNIMP, "Illegal instruction: %04x @ %08x",
+                  insn, s->pc - 2);
     gen_exception(s, s->pc - 2, EXCP_UNSUPPORTED);
-    cpu_abort(CPU(cpu), "Illegal instruction: %04x @ %08x", insn, s->pc - 2);
 }
 
 DISAS_INSN(mulw)
-- 
2.7.4
