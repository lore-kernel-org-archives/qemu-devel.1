Received: from eggs.gnu.org ([2001:4830:134:3::10]:39789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7k3w-0006iK-QH
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 11:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7k3t-0005h6-EP
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 11:27:15 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:54239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7k3t-0005g6-8Q
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 11:27:13 -0400
Received: by mail-wm0-x242.google.com with SMTP id r196so9130634wmf.2
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 08:27:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 26 Oct 2017 17:27:04 +0200
Message-Id: <20171026152704.24525-3-richard.henderson@linaro.org>
In-Reply-To: <20171026152704.24525-1-richard.henderson@linaro.org>
References: <20171026152704.24525-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] tcg/s390x: Use constant pool for prologue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, laurent.desnogues@gmail.com

Rather than have separate code only used for guest_base,
rely on a recent change to handle constant pool entries.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390/tcg-target.inc.c | 44 ++++++++++++--------------------------------
 1 file changed, 12 insertions(+), 32 deletions(-)

diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 38a7cdab75..9af6dcef05 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -555,9 +555,6 @@ static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg dst, TCGReg src)
 static const S390Opcode lli_insns[4] = {
     RI_LLILL, RI_LLILH, RI_LLIHL, RI_LLIHH
 };
-static const S390Opcode ii_insns[4] = {
-    RI_IILL, RI_IILH, RI_IIHL, RI_IIHH
-};
 
 static bool maybe_out_small_movi(TCGContext *s, TCGType type,
                                  TCGReg ret, tcg_target_long sval)
@@ -647,36 +644,19 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
         return;
     }
 
-    /* When allowed, stuff it in the constant pool.  */
-    if (!in_prologue) {
-        if (USE_REG_TB) {
-            tcg_out_insn(s, RXY, LG, ret, TCG_REG_TB, TCG_REG_NONE, 0);
-            new_pool_label(s, sval, R_390_20, s->code_ptr - 2,
-                           -(intptr_t)s->code_gen_ptr);
-        } else {
-            tcg_out_insn(s, RIL, LGRL, ret, 0);
-            new_pool_label(s, sval, R_390_PC32DBL, s->code_ptr - 2, 2);
-        }
-        return;
-    }
-
-    /* What's left is for the prologue, loading GUEST_BASE, and because
-       it failed to match above, is known to be a full 64-bit quantity.
-       We could try more than this, but it probably wouldn't pay off.  */
-    if (s390_facilities & FACILITY_EXT_IMM) {
-        tcg_out_insn(s, RIL, LLILF, ret, uval);
-        tcg_out_insn(s, RIL, IIHF, ret, uval >> 32);
+    /* Otherwise, stuff it in the constant pool.  */
+    if (s390_facilities & FACILITY_GEN_INST_EXT) {
+        tcg_out_insn(s, RIL, LGRL, ret, 0);
+        new_pool_label(s, sval, R_390_PC32DBL, s->code_ptr - 2, 2);
+    } else if (USE_REG_TB && !in_prologue) {
+        tcg_out_insn(s, RXY, LG, ret, TCG_REG_TB, TCG_REG_NONE, 0);
+        new_pool_label(s, sval, R_390_20, s->code_ptr - 2,
+                       -(intptr_t)s->code_gen_ptr);
     } else {
-        const S390Opcode *insns = lli_insns;
-        int i;
-
-        for (i = 0; i < 4; i++) {
-            uint16_t part = uval >> (16 * i);
-            if (part) {
-                tcg_out_insn_RI(s, insns[i], ret, part);
-                insns = ii_insns;
-            }
-        }
+        TCGReg base = ret ? ret : TCG_TMP0;
+        tcg_out_insn(s, RIL, LARL, base, 0);
+        new_pool_label(s, sval, R_390_PC32DBL, s->code_ptr - 2, 2);
+        tcg_out_insn(s, RXY, LG, ret, base, TCG_REG_NONE, 0);
     }
 }
 
-- 
2.13.6
