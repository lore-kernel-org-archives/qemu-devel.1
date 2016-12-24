Received: from eggs.gnu.org ([2001:4830:134:3::10]:45350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cKkgv-0007Jt-Pb
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:40:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cKkgu-0007yJ-MD
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:40:45 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:54721)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cKkgu-0007xo-Ax
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:40:44 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sat, 24 Dec 2016 12:40:24 +0100
Message-Id: <1482579633-3393-4-git-send-email-laurent@vivier.eu>
In-Reply-To: <1482579633-3393-1-git-send-email-laurent@vivier.eu>
References: <1482579633-3393-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 03/12] target-m68k: add cmpm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Message-Id: <1477604609-2206-2-git-send-email-laurent@vivier.eu>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <1478206203-4606-4-git-send-email-rth@twiddle.net>
---
 target/m68k/translate.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index aaa221e..97edb7b 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -2224,6 +2224,21 @@ DISAS_INSN(cmpa)
     gen_update_cc_cmp(s, reg, src, OS_LONG);
 }
 
+DISAS_INSN(cmpm)
+{
+    int opsize = insn_opsize(insn);
+    TCGv src, dst;
+
+    /* Post-increment load (mode 3) from Ay.  */
+    src = gen_ea_mode(env, s, 3, REG(insn, 0), opsize,
+                      NULL_QREG, NULL, EA_LOADS);
+    /* Post-increment load (mode 3) from Ax.  */
+    dst = gen_ea_mode(env, s, 3, REG(insn, 9), opsize,
+                      NULL_QREG, NULL, EA_LOADS);
+
+    gen_update_cc_cmp(s, dst, src, opsize);
+}
+
 DISAS_INSN(eor)
 {
     TCGv src;
@@ -3465,6 +3480,7 @@ void register_m68k_insns (CPUM68KState *env)
     INSN(cmpa,      b1c0, f1c0, CF_ISA_A);
     INSN(cmp,       b000, f100, M68000);
     INSN(eor,       b100, f100, M68000);
+    INSN(cmpm,      b108, f138, M68000);
     INSN(cmpa,      b0c0, f0c0, M68000);
     INSN(eor,       b180, f1c0, CF_ISA_A);
     BASE(and,       c000, f000);
-- 
2.7.4
