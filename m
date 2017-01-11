Received: from eggs.gnu.org ([2001:4830:134:3::10]:35553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8VB-0006Yu-7I
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8VA-0003RV-5Q
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:01 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8VA-0003Qw-0E
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:00 -0500
Received: by mail-pf0-x241.google.com with SMTP id y143so10362251pfb.1
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:18:59 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:17:59 -0800
Message-Id: <20170111021820.24416-45-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 44/65] tcg/s390: Handle clz opcode
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
 tcg/s390/tcg-target.h     |  2 +-
 tcg/s390/tcg-target.inc.c | 36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index 3ac2dc9..22500ba 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -110,7 +110,7 @@ extern uint64_t s390_facilities;
 #define TCG_TARGET_HAS_eqv_i64        0
 #define TCG_TARGET_HAS_nand_i64       0
 #define TCG_TARGET_HAS_nor_i64        0
-#define TCG_TARGET_HAS_clz_i64        0
+#define TCG_TARGET_HAS_clz_i64        (s390_facilities & FACILITY_EXT_IMM)
 #define TCG_TARGET_HAS_ctz_i64        0
 #define TCG_TARGET_HAS_deposit_i64    (s390_facilities & FACILITY_GEN_INST_EXT)
 #define TCG_TARGET_HAS_extract_i64    (s390_facilities & FACILITY_GEN_INST_EXT)
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index c36a9ff..0682d01 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -50,7 +50,7 @@
 #define TCG_REG_NONE    0
 
 /* A scratch register that may be be used throughout the backend.  */
-#define TCG_TMP0        TCG_REG_R14
+#define TCG_TMP0        TCG_REG_R1
 
 #ifndef CONFIG_SOFTMMU
 #define TCG_GUEST_BASE_REG TCG_REG_R13
@@ -133,6 +133,7 @@ typedef enum S390Opcode {
     RRE_DLR     = 0xb997,
     RRE_DSGFR   = 0xb91d,
     RRE_DSGR    = 0xb90d,
+    RRE_FLOGR   = 0xb983,
     RRE_LGBR    = 0xb906,
     RRE_LCGR    = 0xb903,
     RRE_LGFR    = 0xb914,
@@ -1246,6 +1247,33 @@ static void tgen_movcond(TCGContext *s, TCGType type, TCGCond c, TCGReg dest,
     }
 }
 
+static void tgen_clz(TCGContext *s, TCGReg dest, TCGReg a1,
+                     TCGArg a2, int a2const)
+{
+    /* Since this sets both R and R+1, we have no choice but to store the
+       result into R0, allowing R1 == TCG_TMP0 to be clobbered as well.  */
+    QEMU_BUILD_BUG_ON(TCG_TMP0 != TCG_REG_R1);
+    tcg_out_insn(s, RRE, FLOGR, TCG_REG_R0, a1);
+
+    if (a2const && a2 == 64) {
+        tcg_out_mov(s, TCG_TYPE_I64, dest, TCG_REG_R0);
+    } else {
+        if (a2const) {
+            tcg_out_movi(s, TCG_TYPE_I64, dest, a2);
+        } else {
+            tcg_out_mov(s, TCG_TYPE_I64, dest, a2);
+        }
+        if (s390_facilities & FACILITY_LOAD_ON_COND) {
+            /* Emit: if (one bit found) dest = r0.  */
+            tcg_out_insn(s, RRF, LOCGR, dest, TCG_REG_R0, 2);
+        } else {
+            /* Emit: if (no one bit found) goto over; dest = r0; over:  */
+            tcg_out_insn(s, RI, BRC, 8, (4 + 4) >> 1);
+            tcg_out_insn(s, RRE, LGR, dest, TCG_REG_R0);
+        }
+    }
+}
+
 static void tgen_deposit(TCGContext *s, TCGReg dest, TCGReg src,
                          int ofs, int len, int z)
 {
@@ -2186,6 +2214,10 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tgen_extract(s, args[0], args[1], args[2], args[3]);
         break;
 
+    case INDEX_op_clz_i64:
+        tgen_clz(s, args[0], args[1], args[2], const_args[2]);
+        break;
+
     case INDEX_op_mb:
         /* The host memory model is quite strong, we simply need to
            serialize the instruction stream.  */
@@ -2309,6 +2341,8 @@ static const TCGTargetOpDef s390_op_defs[] = {
     { INDEX_op_bswap32_i64, { "r", "r" } },
     { INDEX_op_bswap64_i64, { "r", "r" } },
 
+    { INDEX_op_clz_i64, { "r", "r", "ri" } },
+
     { INDEX_op_add2_i64, { "r", "r", "0", "1", "rA", "r" } },
     { INDEX_op_sub2_i64, { "r", "r", "0", "1", "rA", "r" } },
 
-- 
2.9.3
