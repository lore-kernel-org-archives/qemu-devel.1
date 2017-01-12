Received: from eggs.gnu.org ([2001:4830:134:3::10]:46672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cRlpG-0003xj-Kh
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:18:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cRlpD-0004uy-D3
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:18:22 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:61041)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cRlpD-0004tr-1f
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:18:19 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 12 Jan 2017 21:18:02 +0100
Message-Id: <1484252284-29291-4-git-send-email-laurent@vivier.eu>
In-Reply-To: <1484252284-29291-1-git-send-email-laurent@vivier.eu>
References: <1484252284-29291-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 3/5] target-m68k: manage pre-dec et post-inc in
 CAS
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

In these cases we must update the address register after
the operation.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 0e97900..23e2b06 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1963,6 +1963,15 @@ DISAS_INSN(cas)
     gen_partset_reg(opsize, DREG(ext, 0), load);
 
     tcg_temp_free(load);
+
+    switch (extract32(insn, 3, 3)) {
+    case 3: /* Indirect postincrement.  */
+        tcg_gen_addi_i32(AREG(insn, 0), addr, opsize_bytes(opsize));
+        break;
+    case 4: /* Indirect predecrememnt.  */
+        tcg_gen_mov_i32(AREG(insn, 0), addr);
+        break;
+    }
 }
 
 DISAS_INSN(cas2w)
-- 
2.7.4
