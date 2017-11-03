Received: from eggs.gnu.org ([2001:4830:134:3::10]:48438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eAXX6-00029u-Ox
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 04:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eAXX4-0002Ri-9C
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 04:40:56 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:49386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eAXX4-0002Qh-3O
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 04:40:54 -0400
Received: by mail-wm0-x242.google.com with SMTP id b189so3382390wmd.4
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 01:40:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  3 Nov 2017 09:40:45 +0100
Message-Id: <20171103084046.12821-3-richard.henderson@linaro.org>
In-Reply-To: <20171103084046.12821-1-richard.henderson@linaro.org>
References: <20171103084046.12821-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 2/3] tcg/s390x: Use constant pool for prologue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-s390x@nongnu.org

Rather than have separate code only used for guest_base,
rely on a recent change to handle constant pool entries.

Cc: qemu-s390x@nongnu.org
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
