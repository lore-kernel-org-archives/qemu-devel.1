Received: from eggs.gnu.org ([2001:4830:134:3::10]:35030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Uj-00063R-GV
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Ui-00037R-HO
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:33 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8Ui-000379-CX
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:32 -0500
Received: by mail-pf0-x244.google.com with SMTP id 127so31457257pfg.0
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:18:32 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:17:26 -0800
Message-Id: <20170111021820.24416-12-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 11/65] tcg/s390: Implement field extraction
 opcodes
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
 tcg/s390/tcg-target.h     |  4 ++--
 tcg/s390/tcg-target.inc.c | 11 +++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index d650a72..e9ac12e 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -78,7 +78,7 @@ extern uint64_t s390_facilities;
 #define TCG_TARGET_HAS_nand_i32       0
 #define TCG_TARGET_HAS_nor_i32        0
 #define TCG_TARGET_HAS_deposit_i32    (s390_facilities & FACILITY_GEN_INST_EXT)
-#define TCG_TARGET_HAS_extract_i32    0
+#define TCG_TARGET_HAS_extract_i32    (s390_facilities & FACILITY_GEN_INST_EXT)
 #define TCG_TARGET_HAS_sextract_i32   0
 #define TCG_TARGET_HAS_movcond_i32    1
 #define TCG_TARGET_HAS_add2_i32       1
@@ -109,7 +109,7 @@ extern uint64_t s390_facilities;
 #define TCG_TARGET_HAS_nand_i64       0
 #define TCG_TARGET_HAS_nor_i64        0
 #define TCG_TARGET_HAS_deposit_i64    (s390_facilities & FACILITY_GEN_INST_EXT)
-#define TCG_TARGET_HAS_extract_i64    0
+#define TCG_TARGET_HAS_extract_i64    (s390_facilities & FACILITY_GEN_INST_EXT)
 #define TCG_TARGET_HAS_sextract_i64   0
 #define TCG_TARGET_HAS_movcond_i64    1
 #define TCG_TARGET_HAS_add2_i64       1
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 3821378..2faa761 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -1252,6 +1252,12 @@ static void tgen_deposit(TCGContext *s, TCGReg dest, TCGReg src,
     tcg_out_risbg(s, dest, src, msb, lsb, ofs, 0);
 }
 
+static void tgen_extract(TCGContext *s, TCGReg dest, TCGReg src,
+                         int ofs, int len)
+{
+    tcg_out_risbg(s, dest, src, 64 - len, 63, 64 - ofs, 1);
+}
+
 static void tgen_gotoi(TCGContext *s, int cc, tcg_insn_unit *dest)
 {
     ptrdiff_t off = dest - s->code_ptr;
@@ -2158,6 +2164,9 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     OP_32_64(deposit):
         tgen_deposit(s, args[0], args[2], args[3], args[4]);
         break;
+    OP_32_64(extract):
+        tgen_extract(s, args[0], args[1], args[2], args[3]);
+        break;
 
     case INDEX_op_mb:
         /* The host memory model is quite strong, we simply need to
@@ -2227,6 +2236,7 @@ static const TCGTargetOpDef s390_op_defs[] = {
     { INDEX_op_setcond_i32, { "r", "r", "rC" } },
     { INDEX_op_movcond_i32, { "r", "r", "rC", "r", "0" } },
     { INDEX_op_deposit_i32, { "r", "0", "r" } },
+    { INDEX_op_extract_i32, { "r", "r" } },
 
     { INDEX_op_qemu_ld_i32, { "r", "L" } },
     { INDEX_op_qemu_ld_i64, { "r", "L" } },
@@ -2288,6 +2298,7 @@ static const TCGTargetOpDef s390_op_defs[] = {
     { INDEX_op_setcond_i64, { "r", "r", "rC" } },
     { INDEX_op_movcond_i64, { "r", "r", "rC", "r", "0" } },
     { INDEX_op_deposit_i64, { "r", "0", "r" } },
+    { INDEX_op_extract_i64, { "r", "r" } },
 
     { INDEX_op_mb, { } },
     { -1 },
-- 
2.9.3
