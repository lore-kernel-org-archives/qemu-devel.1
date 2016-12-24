Received: from eggs.gnu.org ([2001:4830:134:3::10]:55640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWK-0006wD-9K
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWJ-0005tT-Ac
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:20 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:35244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdWJ-0005sT-5k
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:19 -0500
Received: by mail-pf0-x241.google.com with SMTP id i88so14544089pfk.2
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:01:18 -0800 (PST)
Received: from bigtime.domain ([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	n25sm65339316pfi.33.2016.12.23.20.01.17 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Dec 2016 20:01:17 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 20:00:18 -0800
Message-Id: <20161224040042.12654-42-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 41/65] tcg/aarch64: Handle ctz and clz opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/aarch64/tcg-target.h     |  8 ++++----
 tcg/aarch64/tcg-target.inc.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 976f493..9d6b00f 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -62,8 +62,8 @@ typedef enum {
 #define TCG_TARGET_HAS_eqv_i32          1
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
-#define TCG_TARGET_HAS_clz_i32          0
-#define TCG_TARGET_HAS_ctz_i32          0
+#define TCG_TARGET_HAS_clz_i32          1
+#define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     1
@@ -96,8 +96,8 @@ typedef enum {
 #define TCG_TARGET_HAS_eqv_i64          1
 #define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          0
-#define TCG_TARGET_HAS_clz_i64          0
-#define TCG_TARGET_HAS_ctz_i64          0
+#define TCG_TARGET_HAS_clz_i64          1
+#define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     1
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 17c0b20..585b0d6 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -339,8 +339,12 @@ typedef enum {
     /* Conditional select instructions.  */
     I3506_CSEL      = 0x1a800000,
     I3506_CSINC     = 0x1a800400,
+    I3506_CSINV     = 0x5a800000,
+    I3506_CSNEG     = 0x5a800400,
 
     /* Data-processing (1 source) instructions.  */
+    I3507_CLZ       = 0x5ac01000,
+    I3507_RBIT      = 0x5ac00000,
     I3507_REV16     = 0x5ac00400,
     I3507_REV32     = 0x5ac00800,
     I3507_REV64     = 0x5ac00c00,
@@ -993,6 +997,37 @@ static inline void tcg_out_mb(TCGContext *s, TCGArg a0)
     tcg_out32(s, sync[a0 & TCG_MO_ALL]);
 }
 
+static void tcg_out_cltz(TCGContext *s, TCGType ext, TCGReg d,
+                         TCGReg a0, TCGArg b, bool const_b, bool is_ctz)
+{
+    TCGReg a1 = a0;
+    if (is_ctz) {
+        a1 = TCG_REG_TMP;
+        tcg_out_insn(s, 3507, RBIT, ext, a1, a0);
+    }
+    if (const_b && b == (ext ? 64 : 32)) {
+        tcg_out_insn(s, 3507, CLZ, ext, d, a1);
+    } else {
+        AArch64Insn sel = I3506_CSEL;
+
+        tcg_out_cmp(s, ext, a0, 0, 1);
+        tcg_out_insn(s, 3507, CLZ, ext, TCG_REG_TMP, a1);
+
+        if (const_b) {
+            if (b == -1) {
+                b = TCG_REG_XZR;
+                sel = I3506_CSINV;
+            } else if (b == 0) {
+                b = TCG_REG_XZR;
+            } else {
+                tcg_out_movi(s, ext, d, b);
+                b = d;
+            }
+        }
+        tcg_out_insn_3506(s, sel, ext, d, TCG_REG_TMP, b, TCG_COND_NE);
+    }
+}
+
 #ifdef CONFIG_SOFTMMU
 /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
  *                                     TCGMemOpIdx oi, uintptr_t ra)
@@ -1559,6 +1594,15 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    case INDEX_op_clz_i64:
+    case INDEX_op_clz_i32:
+        tcg_out_cltz(s, ext, a0, a1, a2, c2, false);
+        break;
+    case INDEX_op_ctz_i64:
+    case INDEX_op_ctz_i32:
+        tcg_out_cltz(s, ext, a0, a1, a2, c2, true);
+        break;
+
     case INDEX_op_brcond_i32:
         a1 = (int32_t)a1;
         /* FALLTHRU */
@@ -1750,11 +1794,15 @@ static const TCGTargetOpDef aarch64_op_defs[] = {
     { INDEX_op_sar_i32, { "r", "r", "ri" } },
     { INDEX_op_rotl_i32, { "r", "r", "ri" } },
     { INDEX_op_rotr_i32, { "r", "r", "ri" } },
+    { INDEX_op_clz_i32, { "r", "r", "rAL" } },
+    { INDEX_op_ctz_i32, { "r", "r", "rAL" } },
     { INDEX_op_shl_i64, { "r", "r", "ri" } },
     { INDEX_op_shr_i64, { "r", "r", "ri" } },
     { INDEX_op_sar_i64, { "r", "r", "ri" } },
     { INDEX_op_rotl_i64, { "r", "r", "ri" } },
     { INDEX_op_rotr_i64, { "r", "r", "ri" } },
+    { INDEX_op_clz_i64, { "r", "r", "rAL" } },
+    { INDEX_op_ctz_i64, { "r", "r", "rAL" } },
 
     { INDEX_op_brcond_i32, { "r", "rA" } },
     { INDEX_op_brcond_i64, { "r", "rA" } },
-- 
2.9.3
