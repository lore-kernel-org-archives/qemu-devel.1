Received: from eggs.gnu.org ([209.51.188.92]:41820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbs-0007nO-DJ
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbr-0004JF-Ef
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:20 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnbr-0004IS-8d
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:19 -0400
Received: by mail-pg1-x542.google.com with SMTP id z3so59981pgp.8
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  3 May 2019 22:52:42 -0700
Message-Id: <20190504055300.18426-14-richard.henderson@linaro.org>
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 13/31] tcg/aarch64: Implement
 tcg_out_dupm_vec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, david@redhat.com

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 4a3cfa778a..e8cf4e4044 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -381,6 +381,9 @@ typedef enum {
     I3207_BLR       = 0xd63f0000,
     I3207_RET       = 0xd65f0000,
 
+    /* AdvSIMD load/store single structure.  */
+    I3303_LD1R      = 0x0d40c000,
+
     /* Load literal for loading the address at pc-relative offset */
     I3305_LDR       = 0x58000000,
     I3305_LDR_v64   = 0x5c000000,
@@ -566,7 +569,14 @@ static inline uint32_t tcg_in32(TCGContext *s)
 #define tcg_out_insn(S, FMT, OP, ...) \
     glue(tcg_out_insn_,FMT)(S, glue(glue(glue(I,FMT),_),OP), ## __VA_ARGS__)
 
-static void tcg_out_insn_3305(TCGContext *s, AArch64Insn insn, int imm19, TCGReg rt)
+static void tcg_out_insn_3303(TCGContext *s, AArch64Insn insn, bool q,
+                              TCGReg rt, TCGReg rn, unsigned size)
+{
+    tcg_out32(s, insn | (rt & 0x1f) | (rn << 5) | (size << 10) | (q << 30));
+}
+
+static void tcg_out_insn_3305(TCGContext *s, AArch64Insn insn,
+                              int imm19, TCGReg rt)
 {
     tcg_out32(s, insn | (imm19 & 0x7ffff) << 5 | rt);
 }
@@ -825,7 +835,29 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
 static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
                              TCGReg r, TCGReg base, intptr_t offset)
 {
-    return false;
+    if (offset != 0) {
+        AArch64Insn add_insn = I3401_ADDI;
+        TCGReg temp = TCG_REG_TMP;
+
+        if (offset < 0) {
+            add_insn = I3401_SUBI;
+            offset = -offset;
+        }
+        if (offset <= 0xfff) {
+            tcg_out_insn_3401(s, add_insn, 1, temp, base, offset);
+        } else if (offset <= 0xffffff) {
+            tcg_out_insn_3401(s, add_insn, 1, temp, base, offset & 0xfff000);
+            if (offset & 0xfff) {
+                tcg_out_insn_3401(s, add_insn, 1, temp, base, offset & 0xfff);
+            }
+        } else {
+            tcg_out_movi(s, TCG_TYPE_PTR, temp, offset);
+            tcg_out_insn(s, 3502, ADD, 1, temp, temp, base);
+        }
+        base = temp;
+    }
+    tcg_out_insn(s, 3303, LD1R, type == TCG_TYPE_V128, r, base, vece);
+    return true;
 }
 
 static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
-- 
2.17.1
