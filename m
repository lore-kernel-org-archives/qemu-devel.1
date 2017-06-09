Received: from eggs.gnu.org ([2001:4830:134:3::10]:49475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJCc0-0006D7-7M
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJCbz-0001eC-Hd
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:37:32 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dJCbz-0001e6-DH
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:37:31 -0400
Received: by mail-qt0-x242.google.com with SMTP id x58so13035554qtc.2
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 22:37:31 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  8 Jun 2017 22:37:18 -0700
Message-Id: <20170609053719.26251-7-rth@twiddle.net>
In-Reply-To: <20170609053719.26251-1-rth@twiddle.net>
References: <20170609053719.26251-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v5 6/7] tcg/arm: Try pc-relative addresses for
 movi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/arm/tcg-target.inc.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index fce382f..18708b1 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -418,25 +418,39 @@ static inline void tcg_out_dat_imm(TCGContext *s,
 
 static void tcg_out_movi32(TCGContext *s, int cond, int rd, uint32_t arg)
 {
-    int rot, opc, rn;
-
-    /* For armv7, make sure not to use movw+movt when mov/mvn would do.
-       Speed things up by only checking when movt would be required.
-       Prior to armv7, have one go at fully rotated immediates before
-       doing the decomposition thing below.  */
-    if (!use_armv7_instructions || (arg & 0xffff0000)) {
-        rot = encode_imm(arg);
+    int rot, opc, rn, diff;
+
+    /* Check a single MOV/MVN before anything else.  */
+    rot = encode_imm(arg);
+    if (rot >= 0) {
+        tcg_out_dat_imm(s, cond, ARITH_MOV, rd, 0,
+                        rotl(arg, rot) | (rot << 7));
+        return;
+    }
+    rot = encode_imm(~arg);
+    if (rot >= 0) {
+        tcg_out_dat_imm(s, cond, ARITH_MVN, rd, 0,
+                        rotl(~arg, rot) | (rot << 7));
+        return;
+    }
+
+    /* Check for a pc-relative address.  This will usually be the TB,
+       or within the TB, which is immediately before the code block.  */
+    diff = arg - ((intptr_t)s->code_ptr + 8);
+    if (diff >= 0) {
+        rot = encode_imm(diff);
         if (rot >= 0) {
-            tcg_out_dat_imm(s, cond, ARITH_MOV, rd, 0,
-                            rotl(arg, rot) | (rot << 7));
+            tcg_out_dat_imm(s, cond, ARITH_ADD, rd, TCG_REG_PC,
+                            rotl(diff, rot) | (rot << 7));
             return;
-        }
-        rot = encode_imm(~arg);
+	}
+    } else {
+        rot = encode_imm(-diff);
         if (rot >= 0) {
-            tcg_out_dat_imm(s, cond, ARITH_MVN, rd, 0,
-                            rotl(~arg, rot) | (rot << 7));
+            tcg_out_dat_imm(s, cond, ARITH_SUB, rd, TCG_REG_PC,
+                            rotl(-diff, rot) | (rot << 7));
             return;
-        }
+	}
     }
 
     /* Use movw + movt.  */
-- 
2.9.4
