Received: from eggs.gnu.org ([2001:4830:134:3::10]:33360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN1GG-0008OZ-1z
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN1GF-0002GW-62
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:52 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dN1GE-0002FC-W8
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:51 -0400
Received: by mail-pg0-x241.google.com with SMTP id j186so17439647pge.1
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 11:18:50 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 19 Jun 2017 11:18:34 -0700
Message-Id: <20170619181839.25249-8-rth@twiddle.net>
In-Reply-To: <20170619181839.25249-1-rth@twiddle.net>
References: <20170619181839.25249-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 07/12] tcg/arm: Try pc-relative addresses for
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
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/arm/tcg-target.inc.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index fce382f..42370e5 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -418,23 +418,37 @@ static inline void tcg_out_dat_imm(TCGContext *s,
 
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
         }
-        rot = encode_imm(~arg);
+    } else {
+        rot = encode_imm(-diff);
         if (rot >= 0) {
-            tcg_out_dat_imm(s, cond, ARITH_MVN, rd, 0,
-                            rotl(~arg, rot) | (rot << 7));
+            tcg_out_dat_imm(s, cond, ARITH_SUB, rd, TCG_REG_PC,
+                            rotl(-diff, rot) | (rot << 7));
             return;
         }
     }
-- 
2.9.4
