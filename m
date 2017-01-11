Received: from eggs.gnu.org ([2001:4830:134:3::10]:35744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8VK-0006iB-6g
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8VI-0003Yn-7j
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:10 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:34650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8VH-0003YO-VS
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:08 -0500
Received: by mail-pf0-x244.google.com with SMTP id y143so10362765pfb.1
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:19:07 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:18:09 -0800
Message-Id: <20170111021820.24416-55-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 54/65] tcg: Add opcode for ctpop
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

The number of actual invocations of ctpop itself does not warrent
an opcode, but it is very helpful for POWER7 to use in generating
an expansion for ctz.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg-runtime.c            | 10 ++++++++++
 tcg/aarch64/tcg-target.h |  2 ++
 tcg/arm/tcg-target.h     |  1 +
 tcg/i386/tcg-target.h    |  2 ++
 tcg/ia64/tcg-target.h    |  2 ++
 tcg/mips/tcg-target.h    |  2 ++
 tcg/optimize.c           | 14 ++++++++++++++
 tcg/ppc/tcg-target.h     |  2 ++
 tcg/s390/tcg-target.h    |  2 ++
 tcg/sparc/tcg-target.h   |  2 ++
 tcg/tcg-op.c             | 29 +++++++++++++++++++++++++++++
 tcg/tcg-op.h             |  4 ++++
 tcg/tcg-opc.h            |  2 ++
 tcg/tcg-runtime.h        |  2 ++
 tcg/tcg.h                |  1 +
 tcg/tci/tcg-target.h     |  2 ++
 16 files changed, 79 insertions(+)

diff --git a/tcg-runtime.c b/tcg-runtime.c
index c8b98df..4c60c96 100644
--- a/tcg-runtime.c
+++ b/tcg-runtime.c
@@ -131,6 +131,16 @@ uint64_t HELPER(clrsb_i64)(uint64_t arg)
     return clrsb64(arg);
 }
 
+uint32_t HELPER(ctpop_i32)(uint32_t arg)
+{
+    return ctpop32(arg);
+}
+
+uint64_t HELPER(ctpop_i64)(uint64_t arg)
+{
+    return ctpop64(arg);
+}
+
 void HELPER(exit_atomic)(CPUArchState *env)
 {
     cpu_loop_exit_atomic(ENV_GET_CPU(env), GETPC());
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 9d6b00f..1a5ea23 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -64,6 +64,7 @@ typedef enum {
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
+#define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     1
@@ -98,6 +99,7 @@ typedef enum {
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
+#define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     1
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 4cb94dc..09a19c6 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -112,6 +112,7 @@ extern bool use_idiv_instructions;
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          use_armv5t_instructions
 #define TCG_TARGET_HAS_ctz_i32          use_armv7_instructions
+#define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_deposit_i32      use_armv7_instructions
 #define TCG_TARGET_HAS_extract_i32      use_armv7_instructions
 #define TCG_TARGET_HAS_sextract_i32     use_armv7_instructions
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 8fff287..b8f73f5 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -95,6 +95,7 @@ extern bool have_bmi1;
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
+#define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     1
@@ -129,6 +130,7 @@ extern bool have_bmi1;
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
+#define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     0
diff --git a/tcg/ia64/tcg-target.h b/tcg/ia64/tcg-target.h
index 9a829ae..42aea03 100644
--- a/tcg/ia64/tcg-target.h
+++ b/tcg/ia64/tcg-target.h
@@ -144,6 +144,8 @@ typedef enum {
 #define TCG_TARGET_HAS_clz_i64          0
 #define TCG_TARGET_HAS_ctz_i32          0
 #define TCG_TARGET_HAS_ctz_i64          0
+#define TCG_TARGET_HAS_ctpop_i32        0
+#define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_nor_i64          1
 #define TCG_TARGET_HAS_orc_i32          1
 #define TCG_TARGET_HAS_orc_i64          1
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index a680f16..f46d64a 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -165,6 +165,7 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_rot_i32          use_mips32r2_instructions
 #define TCG_TARGET_HAS_clz_i32          use_mips32r2_instructions
 #define TCG_TARGET_HAS_ctz_i32          0
+#define TCG_TARGET_HAS_ctpop_i32        0
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_movcond_i64      use_movnz_instructions
@@ -179,6 +180,7 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_rot_i64          use_mips32r2_instructions
 #define TCG_TARGET_HAS_clz_i64          use_mips32r2_instructions
 #define TCG_TARGET_HAS_ctz_i64          0
+#define TCG_TARGET_HAS_ctpop_i64        0
 #endif
 
 /* optional instructions automatically implemented */
diff --git a/tcg/optimize.c b/tcg/optimize.c
index e7ecce4..adfc56c 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -308,6 +308,12 @@ static TCGArg do_constant_folding_2(TCGOpcode op, TCGArg x, TCGArg y)
     case INDEX_op_ctz_i64:
         return x ? ctz64(x) : y;
 
+    case INDEX_op_ctpop_i32:
+        return ctpop32(x);
+
+    case INDEX_op_ctpop_i64:
+        return ctpop64(x);
+
     CASE_OP_32_64(ext8s):
         return (int8_t)x;
 
@@ -918,6 +924,13 @@ void tcg_optimize(TCGContext *s)
             mask = temps[args[2]].mask | 63;
             break;
 
+        case INDEX_op_ctpop_i32:
+            mask = 32 | 31;
+            break;
+        case INDEX_op_ctpop_i64:
+            mask = 64 | 63;
+            break;
+
         CASE_OP_32_64(setcond):
         case INDEX_op_setcond2_i32:
             mask = 1;
@@ -1031,6 +1044,7 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(ext8u):
         CASE_OP_32_64(ext16s):
         CASE_OP_32_64(ext16u):
+        CASE_OP_32_64(ctpop):
         case INDEX_op_ext32s_i64:
         case INDEX_op_ext32u_i64:
         case INDEX_op_ext_i32_i64:
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index c798c9c..57e66cf 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -72,6 +72,7 @@ extern bool have_isa_3_00;
 #define TCG_TARGET_HAS_nor_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          have_isa_3_00
+#define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     0
@@ -107,6 +108,7 @@ extern bool have_isa_3_00;
 #define TCG_TARGET_HAS_nor_i64          1
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          have_isa_3_00
+#define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     0
diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index 22500ba..cbdd2a6 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -79,6 +79,7 @@ extern uint64_t s390_facilities;
 #define TCG_TARGET_HAS_nor_i32        0
 #define TCG_TARGET_HAS_clz_i32        0
 #define TCG_TARGET_HAS_ctz_i32        0
+#define TCG_TARGET_HAS_ctpop_i32      0
 #define TCG_TARGET_HAS_deposit_i32    (s390_facilities & FACILITY_GEN_INST_EXT)
 #define TCG_TARGET_HAS_extract_i32    (s390_facilities & FACILITY_GEN_INST_EXT)
 #define TCG_TARGET_HAS_sextract_i32   0
@@ -112,6 +113,7 @@ extern uint64_t s390_facilities;
 #define TCG_TARGET_HAS_nor_i64        0
 #define TCG_TARGET_HAS_clz_i64        (s390_facilities & FACILITY_EXT_IMM)
 #define TCG_TARGET_HAS_ctz_i64        0
+#define TCG_TARGET_HAS_ctpop_i64      0
 #define TCG_TARGET_HAS_deposit_i64    (s390_facilities & FACILITY_GEN_INST_EXT)
 #define TCG_TARGET_HAS_extract_i64    (s390_facilities & FACILITY_GEN_INST_EXT)
 #define TCG_TARGET_HAS_sextract_i64   0
diff --git a/tcg/sparc/tcg-target.h b/tcg/sparc/tcg-target.h
index 340837a..b8b74f96f 100644
--- a/tcg/sparc/tcg-target.h
+++ b/tcg/sparc/tcg-target.h
@@ -112,6 +112,7 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          0
 #define TCG_TARGET_HAS_ctz_i32          0
+#define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_deposit_i32      0
 #define TCG_TARGET_HAS_extract_i32      0
 #define TCG_TARGET_HAS_sextract_i32     0
@@ -146,6 +147,7 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          0
 #define TCG_TARGET_HAS_ctz_i64          0
+#define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_deposit_i64      0
 #define TCG_TARGET_HAS_extract_i64      0
 #define TCG_TARGET_HAS_sextract_i64     0
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 620e268..6f4b1b6 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -550,6 +550,21 @@ void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
+void tcg_gen_ctpop_i32(TCGv_i32 ret, TCGv_i32 arg1)
+{
+    if (TCG_TARGET_HAS_ctpop_i32) {
+        tcg_gen_op2_i32(INDEX_op_ctpop_i32, ret, arg1);
+    } else if (TCG_TARGET_HAS_ctpop_i64) {
+        TCGv_i64 t = tcg_temp_new_i64();
+        tcg_gen_extu_i32_i64(t, arg1);
+        tcg_gen_ctpop_i64(t, t);
+        tcg_gen_extrl_i64_i32(ret, t);
+        tcg_temp_free_i64(t);
+    } else {
+        gen_helper_ctpop_i32(ret, arg1);
+    }
+}
+
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_rot_i32) {
@@ -1874,6 +1889,20 @@ void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
+void tcg_gen_ctpop_i64(TCGv_i64 ret, TCGv_i64 arg1)
+{
+    if (TCG_TARGET_HAS_ctpop_i64) {
+        tcg_gen_op2_i64(INDEX_op_ctpop_i64, ret, arg1);
+    } else if (TCG_TARGET_REG_BITS == 32 && TCG_TARGET_HAS_ctpop_i32) {
+        tcg_gen_ctpop_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1));
+        tcg_gen_ctpop_i32(TCGV_LOW(ret), TCGV_LOW(arg1));
+        tcg_gen_add_i32(TCGV_LOW(ret), TCGV_LOW(ret), TCGV_HIGH(ret));
+        tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
+    } else {
+        gen_helper_ctpop_i64(ret, arg1);
+    }
+}
+
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_HAS_rot_i64) {
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index c2f3db9..c68e300 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -291,6 +291,7 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
+void tcg_gen_ctpop_i32(TCGv_i32 a1, TCGv_i32 a2);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2);
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -479,6 +480,7 @@ void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
+void tcg_gen_ctpop_i64(TCGv_i64 a1, TCGv_i64 a2);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2);
 void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
@@ -973,6 +975,7 @@ void tcg_gen_atomic_xor_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
 #define tcg_gen_clzi_tl tcg_gen_clzi_i64
 #define tcg_gen_ctzi_tl tcg_gen_ctzi_i64
 #define tcg_gen_clrsb_tl tcg_gen_clrsb_i64
+#define tcg_gen_ctpop_tl tcg_gen_ctpop_i64
 #define tcg_gen_rotl_tl tcg_gen_rotl_i64
 #define tcg_gen_rotli_tl tcg_gen_rotli_i64
 #define tcg_gen_rotr_tl tcg_gen_rotr_i64
@@ -1069,6 +1072,7 @@ void tcg_gen_atomic_xor_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
 #define tcg_gen_clzi_tl tcg_gen_clzi_i32
 #define tcg_gen_ctzi_tl tcg_gen_ctzi_i32
 #define tcg_gen_clrsb_tl tcg_gen_clrsb_i32
+#define tcg_gen_ctpop_tl tcg_gen_ctpop_i32
 #define tcg_gen_rotl_tl tcg_gen_rotl_i32
 #define tcg_gen_rotli_tl tcg_gen_rotli_i32
 #define tcg_gen_rotr_tl tcg_gen_rotr_i32
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index d00db4f..f06f894 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -106,6 +106,7 @@ DEF(nand_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_nand_i32))
 DEF(nor_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_nor_i32))
 DEF(clz_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_clz_i32))
 DEF(ctz_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_ctz_i32))
+DEF(ctpop_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ctpop_i32))
 
 DEF(mov_i64, 1, 1, 0, TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT)
 DEF(movi_i64, 1, 0, 1, TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT)
@@ -175,6 +176,7 @@ DEF(nand_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_nand_i64))
 DEF(nor_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_nor_i64))
 DEF(clz_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_clz_i64))
 DEF(ctz_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ctz_i64))
+DEF(ctpop_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ctpop_i64))
 
 DEF(add2_i64, 2, 4, 0, IMPL64 | IMPL(TCG_TARGET_HAS_add2_i64))
 DEF(sub2_i64, 2, 4, 0, IMPL64 | IMPL(TCG_TARGET_HAS_sub2_i64))
diff --git a/tcg/tcg-runtime.h b/tcg/tcg-runtime.h
index 0d30f1a..114ea6f 100644
--- a/tcg/tcg-runtime.h
+++ b/tcg/tcg-runtime.h
@@ -21,6 +21,8 @@ DEF_HELPER_FLAGS_2(clz_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(ctz_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_1(clrsb_i32, TCG_CALL_NO_RWG_SE, i32, i32)
 DEF_HELPER_FLAGS_1(clrsb_i64, TCG_CALL_NO_RWG_SE, i64, i64)
+DEF_HELPER_FLAGS_1(ctpop_i32, TCG_CALL_NO_RWG_SE, i32, i32)
+DEF_HELPER_FLAGS_1(ctpop_i64, TCG_CALL_NO_RWG_SE, i64, i64)
 
 DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
 
diff --git a/tcg/tcg.h b/tcg/tcg.h
index e026282..631c6f6 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -113,6 +113,7 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          0
 #define TCG_TARGET_HAS_ctz_i64          0
+#define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_deposit_i64      0
 #define TCG_TARGET_HAS_extract_i64      0
 #define TCG_TARGET_HAS_sextract_i64     0
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 0646444..838bf3a 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -76,6 +76,7 @@
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          0
 #define TCG_TARGET_HAS_ctz_i32          0
+#define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_neg_i32          1
 #define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_orc_i32          0
@@ -108,6 +109,7 @@
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          0
 #define TCG_TARGET_HAS_ctz_i64          0
+#define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_neg_i64          1
 #define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_orc_i64          0
-- 
2.9.3
