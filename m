Received: from eggs.gnu.org ([2001:4830:134:3::10]:46563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cRlpA-0003tw-MV
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:18:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cRlp7-0004r5-Fk
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:18:16 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:60213)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cRlp7-0004qS-5U
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:18:13 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 12 Jan 2017 21:18:00 +0100
Message-Id: <1484252284-29291-2-git-send-email-laurent@vivier.eu>
In-Reply-To: <1484252284-29291-1-git-send-email-laurent@vivier.eu>
References: <1484252284-29291-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 1/5] target-m68k: fix bit operation with
 immediate value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, Laurent Vivier <laurent@vivier.eu>

M680x0 bit operations with an immediate value use 9 bits of the 16bit
value, while coldfire ones use only 8 bits.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 5f7357e..410f56a 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1801,9 +1801,16 @@ DISAS_INSN(bitop_im)
     op = (insn >> 6) & 3;
 
     bitnum = read_im16(env, s);
-    if (bitnum & 0xff00) {
-        disas_undef(env, s, insn);
-        return;
+    if (m68k_feature(s->env, M68K_FEATURE_M68000)) {
+        if (bitnum & 0xfe00) {
+            disas_undef(env, s, insn);
+            return;
+        }
+    } else {
+        if (bitnum & 0xff00) {
+            disas_undef(env, s, insn);
+            return;
+        }
     }
 
     SRC_EA(env, src1, opsize, 0, op ? &addr: NULL);
-- 
2.7.4
