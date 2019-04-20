Received: from eggs.gnu.org ([209.51.188.92]:40182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWe-0008Uq-6I
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWd-0007yl-50
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:04 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkWc-0007yB-VH
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:03 -0400
Received: by mail-pl1-x644.google.com with SMTP id f36so3538773plb.5
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 19 Apr 2019 21:34:14 -1000
Message-Id: <20190420073442.7488-11-richard.henderson@linaro.org>
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 10/38] tcg/aarch64: Implement tcg_out_dupm_vec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 38 ++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 3f95930e88..1db4e22365 100644
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
@@ -414,6 +417,8 @@ typedef enum {
     I3312_LDRVQ     = 0x3c000000 | 3 << 22 | 0 << 30,
     I3312_STRVQ     = 0x3c000000 | 2 << 22 | 0 << 30,
 
+
+
     I3312_TO_I3310  = 0x00200800,
     I3312_TO_I3313  = 0x01000000,
 
@@ -566,7 +571,14 @@ static inline uint32_t tcg_in32(TCGContext *s)
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
@@ -825,7 +837,29 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
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
