Received: from eggs.gnu.org ([2001:4830:134:3::10]:34923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Ud-0005nA-Ou
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Ua-00031g-SC
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:27 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:36447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8Ua-000318-GK
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:24 -0500
Received: by mail-pf0-x242.google.com with SMTP id b22so15070808pfd.3
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:18:24 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:17:16 -0800
Message-Id: <20170111021820.24416-2-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/65] tcg: Add field extraction primitives
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

Adds tcg_gen_extract_* and tcg_gen_sextract_* for extraction of
fixed position bitfields, much like we already have for deposit.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/README               |  20 ++-
 tcg/aarch64/tcg-target.h |   4 +
 tcg/arm/tcg-target.h     |   2 +
 tcg/i386/tcg-target.h    |   4 +
 tcg/ia64/tcg-target.h    |   4 +
 tcg/mips/tcg-target.h    |   2 +
 tcg/optimize.c           |  29 +++++
 tcg/ppc/tcg-target.h     |   4 +
 tcg/s390/tcg-target.h    |   4 +
 tcg/sparc/tcg-target.h   |   4 +
 tcg/tcg-op.c             | 323 +++++++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg-op.h             |  12 ++
 tcg/tcg-opc.h            |   4 +
 tcg/tcg.h                |   8 ++
 tcg/tci/tcg-target.h     |   4 +
 15 files changed, 426 insertions(+), 2 deletions(-)

diff --git a/tcg/README b/tcg/README
index ae31388..065d9c2 100644
--- a/tcg/README
+++ b/tcg/README
@@ -314,11 +314,27 @@ The bitfield is described by POS/LEN, which are immediate values:
   LEN - the length of the bitfield
   POS - the position of the first bit, counting from the LSB
 
-For example, pos=8, len=4 indicates a 4-bit field at bit 8.
-This operation would be equivalent to
+For example, "deposit_i32 dest, t1, t2, 8, 4" indicates a 4-bit field
+at bit 8.  This operation would be equivalent to
 
   dest = (t1 & ~0x0f00) | ((t2 << 8) & 0x0f00)
 
+* extract_i32/i64 dest, t1, pos, len
+* sextract_i32/i64 dest, t1, pos, len
+
+Extract a bitfield from T1, placing the result in DEST.
+The bitfield is described by POS/LEN, which are immediate values,
+as above for deposit.  For extract_*, the result will be extended
+to the left with zeros; for sextract_*, the result will be extended
+to the left with copies of the bitfield sign bit at pos + len - 1.
+
+For example, "sextract_i32 dest, t1, 8, 4" indicates a 4-bit field
+at bit 8.  This operation would be equivalent to
+
+  dest = (t1 << 20) >> 28
+
+(using an arithmetic right shift).
+
 * extrl_i64_i32 t0, t1
 
 For 64-bit hosts only, extract the low 32-bits of input T1 and place it
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index a1d101f..410c31b 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -63,6 +63,8 @@ typedef enum {
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_deposit_i32      1
+#define TCG_TARGET_HAS_extract_i32      0
+#define TCG_TARGET_HAS_sextract_i32     0
 #define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
@@ -93,6 +95,8 @@ typedef enum {
 #define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_deposit_i64      1
+#define TCG_TARGET_HAS_extract_i64      0
+#define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index a0e1acf..8e724be 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -80,6 +80,8 @@ extern bool use_idiv_instructions;
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_deposit_i32      1
+#define TCG_TARGET_HAS_extract_i32      0
+#define TCG_TARGET_HAS_sextract_i32     0
 #define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_mulu2_i32        1
 #define TCG_TARGET_HAS_muls2_i32        1
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 524cfc6..7625188 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -94,6 +94,8 @@ extern bool have_bmi1;
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_deposit_i32      1
+#define TCG_TARGET_HAS_extract_i32      0
+#define TCG_TARGET_HAS_sextract_i32     0
 #define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
@@ -124,6 +126,8 @@ extern bool have_bmi1;
 #define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_deposit_i64      1
+#define TCG_TARGET_HAS_extract_i64      0
+#define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
diff --git a/tcg/ia64/tcg-target.h b/tcg/ia64/tcg-target.h
index 6dddb7f..8856dc8 100644
--- a/tcg/ia64/tcg-target.h
+++ b/tcg/ia64/tcg-target.h
@@ -149,6 +149,10 @@ typedef enum {
 #define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_deposit_i64      1
+#define TCG_TARGET_HAS_extract_i32      0
+#define TCG_TARGET_HAS_extract_i64      0
+#define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i32         0
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index d352c97..fcc2986 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -158,6 +158,8 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_movcond_i32      use_movnz_instructions
 #define TCG_TARGET_HAS_bswap16_i32      use_mips32r2_instructions
 #define TCG_TARGET_HAS_deposit_i32      use_mips32r2_instructions
+#define TCG_TARGET_HAS_extract_i32      0
+#define TCG_TARGET_HAS_sextract_i32     0
 #define TCG_TARGET_HAS_ext8s_i32        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i32       use_mips32r2_instructions
 #define TCG_TARGET_HAS_rot_i32          use_mips32r2_instructions
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 0f13490..f41ed2c 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -878,6 +878,19 @@ void tcg_optimize(TCGContext *s)
                              temps[args[2]].mask);
             break;
 
+        CASE_OP_32_64(extract):
+            mask = extract64(temps[args[1]].mask, args[2], args[3]);
+            if (args[2] == 0) {
+                affected = temps[args[1]].mask & ~mask;
+            }
+            break;
+        CASE_OP_32_64(sextract):
+            mask = sextract64(temps[args[1]].mask, args[2], args[3]);
+            if (args[2] == 0 && (tcg_target_long)mask >= 0) {
+                affected = temps[args[1]].mask & ~mask;
+            }
+            break;
+
         CASE_OP_32_64(or):
         CASE_OP_32_64(xor):
             mask = temps[args[1]].mask | temps[args[2]].mask;
@@ -1048,6 +1061,22 @@ void tcg_optimize(TCGContext *s)
             }
             goto do_default;
 
+        CASE_OP_32_64(extract):
+            if (temp_is_const(args[1])) {
+                tmp = extract64(temps[args[1]].val, args[2], args[3]);
+                tcg_opt_gen_movi(s, op, args, args[0], tmp);
+                break;
+            }
+            goto do_default;
+
+        CASE_OP_32_64(sextract):
+            if (temp_is_const(args[1])) {
+                tmp = sextract64(temps[args[1]].val, args[2], args[3]);
+                tcg_opt_gen_movi(s, op, args, args[0], tmp);
+                break;
+            }
+            goto do_default;
+
         CASE_OP_32_64(setcond):
             tmp = do_constant_folding_cond(opc, args[1], args[2], args[3]);
             if (tmp != 2) {
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index dd032f2..c765d3e 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -69,6 +69,8 @@ typedef enum {
 #define TCG_TARGET_HAS_nand_i32         1
 #define TCG_TARGET_HAS_nor_i32          1
 #define TCG_TARGET_HAS_deposit_i32      1
+#define TCG_TARGET_HAS_extract_i32      0
+#define TCG_TARGET_HAS_sextract_i32     0
 #define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_mulu2_i32        0
 #define TCG_TARGET_HAS_muls2_i32        0
@@ -100,6 +102,8 @@ typedef enum {
 #define TCG_TARGET_HAS_nand_i64         1
 #define TCG_TARGET_HAS_nor_i64          1
 #define TCG_TARGET_HAS_deposit_i64      1
+#define TCG_TARGET_HAS_extract_i64      0
+#define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index 0c1af24..9583df4 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -66,6 +66,8 @@ typedef enum TCGReg {
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_deposit_i32      1
+#define TCG_TARGET_HAS_extract_i32      0
+#define TCG_TARGET_HAS_sextract_i32     0
 #define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
@@ -95,6 +97,8 @@ typedef enum TCGReg {
 #define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_deposit_i64      1
+#define TCG_TARGET_HAS_extract_i64      0
+#define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
diff --git a/tcg/sparc/tcg-target.h b/tcg/sparc/tcg-target.h
index 88f9c90..a212167 100644
--- a/tcg/sparc/tcg-target.h
+++ b/tcg/sparc/tcg-target.h
@@ -111,6 +111,8 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_deposit_i32      0
+#define TCG_TARGET_HAS_extract_i32      0
+#define TCG_TARGET_HAS_sextract_i32     0
 #define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
@@ -141,6 +143,8 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_deposit_i64      0
+#define TCG_TARGET_HAS_extract_i64      0
+#define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6e2fb35..c185b9c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -560,6 +560,131 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
     tcg_temp_free_i32(t1);
 }
 
+void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
+                         unsigned int ofs, unsigned int len)
+{
+    tcg_debug_assert(ofs < 32);
+    tcg_debug_assert(len > 0);
+    tcg_debug_assert(len <= 32);
+    tcg_debug_assert(ofs + len <= 32);
+
+    /* Canonicalize certain special cases, even if extract is supported.  */
+    if (ofs + len == 32) {
+        tcg_gen_shri_i32(ret, arg, 32 - len);
+        return;
+    }
+    if (ofs == 0) {
+        tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
+        return;
+    }
+
+    if (TCG_TARGET_HAS_extract_i32
+        && TCG_TARGET_extract_i32_valid(ofs, len)) {
+        tcg_gen_op4ii_i32(INDEX_op_extract_i32, ret, arg, ofs, len);
+        return;
+    }
+
+    /* Assume that zero-extension, if available, is cheaper than a shift.  */
+    switch (ofs + len) {
+    case 16:
+        if (TCG_TARGET_HAS_ext16u_i32) {
+            tcg_gen_ext16u_i32(ret, arg);
+            tcg_gen_shri_i32(ret, ret, ofs);
+            return;
+        }
+        break;
+    case 8:
+        if (TCG_TARGET_HAS_ext8u_i32) {
+            tcg_gen_ext8u_i32(ret, arg);
+            tcg_gen_shri_i32(ret, ret, ofs);
+            return;
+        }
+        break;
+    }
+
+    /* ??? Ideally we'd know what values are available for immediate AND.
+       Assume that 8 bits are available, plus the special case of 16,
+       so that we get ext8u, ext16u.  */
+    switch (len) {
+    case 1 ... 8: case 16:
+        tcg_gen_shri_i32(ret, arg, ofs);
+        tcg_gen_andi_i32(ret, ret, (1u << len) - 1);
+        break;
+    default:
+        tcg_gen_shli_i32(ret, arg, 32 - len - ofs);
+        tcg_gen_shri_i32(ret, ret, 32 - len);
+        break;
+    }
+}
+
+void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
+                          unsigned int ofs, unsigned int len)
+{
+    tcg_debug_assert(ofs < 32);
+    tcg_debug_assert(len > 0);
+    tcg_debug_assert(len <= 32);
+    tcg_debug_assert(ofs + len <= 32);
+
+    /* Canonicalize certain special cases, even if extract is supported.  */
+    if (ofs + len == 32) {
+        tcg_gen_sari_i32(ret, arg, 32 - len);
+        return;
+    }
+    if (ofs == 0) {
+        switch (len) {
+        case 16:
+            tcg_gen_ext16s_i32(ret, arg);
+            return;
+        case 8:
+            tcg_gen_ext8s_i32(ret, arg);
+            return;
+        }
+    }
+
+    if (TCG_TARGET_HAS_sextract_i32
+        && TCG_TARGET_extract_i32_valid(ofs, len)) {
+        tcg_gen_op4ii_i32(INDEX_op_sextract_i32, ret, arg, ofs, len);
+        return;
+    }
+
+    /* Assume that sign-extension, if available, is cheaper than a shift.  */
+    switch (ofs + len) {
+    case 16:
+        if (TCG_TARGET_HAS_ext16s_i32) {
+            tcg_gen_ext16s_i32(ret, arg);
+            tcg_gen_sari_i32(ret, ret, ofs);
+            return;
+        }
+        break;
+    case 8:
+        if (TCG_TARGET_HAS_ext8s_i32) {
+            tcg_gen_ext8s_i32(ret, arg);
+            tcg_gen_sari_i32(ret, ret, ofs);
+            return;
+        }
+        break;
+    }
+    switch (len) {
+    case 16:
+        if (TCG_TARGET_HAS_ext16s_i32) {
+            tcg_gen_shri_i32(ret, arg, ofs);
+            tcg_gen_ext16s_i32(ret, ret);
+            return;
+        }
+        break;
+    case 8:
+        if (TCG_TARGET_HAS_ext8s_i32) {
+            tcg_gen_shri_i32(ret, arg, ofs);
+            tcg_gen_ext8s_i32(ret, ret);
+            return;
+        }
+        break;
+    }
+
+    tcg_gen_shli_i32(ret, arg, 32 - len - ofs);
+    tcg_gen_sari_i32(ret, ret, 32 - len);
+}
+
 void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
                          TCGv_i32 c2, TCGv_i32 v1, TCGv_i32 v2)
 {
@@ -1635,6 +1760,204 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
     tcg_temp_free_i64(t1);
 }
 
+void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
+                         unsigned int ofs, unsigned int len)
+{
+    tcg_debug_assert(ofs < 64);
+    tcg_debug_assert(len > 0);
+    tcg_debug_assert(len <= 64);
+    tcg_debug_assert(ofs + len <= 64);
+
+    /* Canonicalize certain special cases, even if extract is supported.  */
+    if (ofs + len == 64) {
+        tcg_gen_shri_i64(ret, arg, 64 - len);
+        return;
+    }
+    if (ofs == 0) {
+        tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
+        return;
+    }
+
+    if (TCG_TARGET_REG_BITS == 32) {
+        /* Look for a 32-bit extract within one of the two words.  */
+        if (ofs >= 32) {
+            tcg_gen_extract_i32(TCGV_LOW(ret), TCGV_HIGH(arg), ofs - 32, len);
+            tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
+            return;
+        }
+        if (ofs + len <= 32) {
+            tcg_gen_extract_i32(TCGV_LOW(ret), TCGV_LOW(arg), ofs, len);
+            tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
+            return;
+        }
+        /* The field is split across two words.  One double-word
+           shift is better than two double-word shifts.  */
+        goto do_shift_and;
+    }
+
+    if (TCG_TARGET_HAS_extract_i64
+        && TCG_TARGET_extract_i64_valid(ofs, len)) {
+        tcg_gen_op4ii_i64(INDEX_op_extract_i64, ret, arg, ofs, len);
+        return;
+    }
+
+    /* Assume that zero-extension, if available, is cheaper than a shift.  */
+    switch (ofs + len) {
+    case 32:
+        if (TCG_TARGET_HAS_ext32u_i64) {
+            tcg_gen_ext32u_i64(ret, arg);
+            tcg_gen_shri_i64(ret, ret, ofs);
+            return;
+        }
+        break;
+    case 16:
+        if (TCG_TARGET_HAS_ext16u_i64) {
+            tcg_gen_ext16u_i64(ret, arg);
+            tcg_gen_shri_i64(ret, ret, ofs);
+            return;
+        }
+        break;
+    case 8:
+        if (TCG_TARGET_HAS_ext8u_i64) {
+            tcg_gen_ext8u_i64(ret, arg);
+            tcg_gen_shri_i64(ret, ret, ofs);
+            return;
+        }
+        break;
+    }
+
+    /* ??? Ideally we'd know what values are available for immediate AND.
+       Assume that 8 bits are available, plus the special cases of 16 and 32,
+       so that we get ext8u, ext16u, and ext32u.  */
+    switch (len) {
+    case 1 ... 8: case 16: case 32:
+    do_shift_and:
+        tcg_gen_shri_i64(ret, arg, ofs);
+        tcg_gen_andi_i64(ret, ret, (1ull << len) - 1);
+        break;
+    default:
+        tcg_gen_shli_i64(ret, arg, 64 - len - ofs);
+        tcg_gen_shri_i64(ret, ret, 64 - len);
+        break;
+    }
+}
+
+void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
+                          unsigned int ofs, unsigned int len)
+{
+    tcg_debug_assert(ofs < 64);
+    tcg_debug_assert(len > 0);
+    tcg_debug_assert(len <= 64);
+    tcg_debug_assert(ofs + len <= 64);
+
+    /* Canonicalize certain special cases, even if sextract is supported.  */
+    if (ofs + len == 64) {
+        tcg_gen_sari_i64(ret, arg, 64 - len);
+        return;
+    }
+    if (ofs == 0) {
+        switch (len) {
+        case 32:
+            tcg_gen_ext32s_i64(ret, arg);
+            return;
+        case 16:
+            tcg_gen_ext16s_i64(ret, arg);
+            return;
+        case 8:
+            tcg_gen_ext8s_i64(ret, arg);
+            return;
+        }
+    }
+
+    if (TCG_TARGET_REG_BITS == 32) {
+        /* Look for a 32-bit extract within one of the two words.  */
+        if (ofs >= 32) {
+            tcg_gen_sextract_i32(TCGV_LOW(ret), TCGV_HIGH(arg), ofs - 32, len);
+        } else if (ofs + len <= 32) {
+            tcg_gen_sextract_i32(TCGV_LOW(ret), TCGV_LOW(arg), ofs, len);
+        } else if (ofs == 0) {
+            tcg_gen_mov_i32(TCGV_LOW(ret), TCGV_LOW(arg));
+            tcg_gen_sextract_i32(TCGV_HIGH(ret), TCGV_HIGH(arg), 0, len - 32);
+            return;
+        } else if (len > 32) {
+            TCGv_i32 t = tcg_temp_new_i32();
+            /* Extract the bits for the high word normally.  */
+            tcg_gen_sextract_i32(t, TCGV_HIGH(arg), ofs + 32, len - 32);
+            /* Shift the field down for the low part.  */
+            tcg_gen_shri_i64(ret, arg, ofs);
+            /* Overwrite the shift into the high part.  */
+            tcg_gen_mov_i32(TCGV_HIGH(ret), t);
+            tcg_temp_free_i32(t);
+            return;
+        } else {
+            /* Shift the field down for the low part, such that the
+               field sits at the MSB.  */
+            tcg_gen_shri_i64(ret, arg, ofs + len - 32);
+            /* Shift the field down from the MSB, sign extending.  */
+            tcg_gen_sari_i32(TCGV_LOW(ret), TCGV_LOW(ret), 32 - len);
+        }
+        /* Sign-extend the field from 32 bits.  */
+        tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
+        return;
+    }
+
+    if (TCG_TARGET_HAS_sextract_i64
+        && TCG_TARGET_extract_i64_valid(ofs, len)) {
+        tcg_gen_op4ii_i64(INDEX_op_sextract_i64, ret, arg, ofs, len);
+        return;
+    }
+
+    /* Assume that sign-extension, if available, is cheaper than a shift.  */
+    switch (ofs + len) {
+    case 32:
+        if (TCG_TARGET_HAS_ext32s_i64) {
+            tcg_gen_ext32s_i64(ret, arg);
+            tcg_gen_sari_i64(ret, ret, ofs);
+            return;
+        }
+        break;
+    case 16:
+        if (TCG_TARGET_HAS_ext16s_i64) {
+            tcg_gen_ext16s_i64(ret, arg);
+            tcg_gen_sari_i64(ret, ret, ofs);
+            return;
+        }
+        break;
+    case 8:
+        if (TCG_TARGET_HAS_ext8s_i64) {
+            tcg_gen_ext8s_i64(ret, arg);
+            tcg_gen_sari_i64(ret, ret, ofs);
+            return;
+        }
+        break;
+    }
+    switch (len) {
+    case 32:
+        if (TCG_TARGET_HAS_ext32s_i64) {
+            tcg_gen_shri_i64(ret, arg, ofs);
+            tcg_gen_ext32s_i64(ret, ret);
+            return;
+        }
+        break;
+    case 16:
+        if (TCG_TARGET_HAS_ext16s_i64) {
+            tcg_gen_shri_i64(ret, arg, ofs);
+            tcg_gen_ext16s_i64(ret, ret);
+            return;
+        }
+        break;
+    case 8:
+        if (TCG_TARGET_HAS_ext8s_i64) {
+            tcg_gen_shri_i64(ret, arg, ofs);
+            tcg_gen_ext8s_i64(ret, ret);
+            return;
+        }
+        break;
+    }
+    tcg_gen_shli_i64(ret, arg, 64 - len - ofs);
+    tcg_gen_sari_i64(ret, ret, 64 - len);
+}
+
 void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
                          TCGv_i64 c2, TCGv_i64 v1, TCGv_i64 v2)
 {
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 6d044b7..b515e6f 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -292,6 +292,10 @@ void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2);
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len);
+void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
+                         unsigned int ofs, unsigned int len);
+void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
+                          unsigned int ofs, unsigned int len);
 void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *);
 void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *);
 void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
@@ -469,6 +473,10 @@ void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2);
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len);
+void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
+                         unsigned int ofs, unsigned int len);
+void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
+                          unsigned int ofs, unsigned int len);
 void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *);
 void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *);
 void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
@@ -951,6 +959,8 @@ void tcg_gen_atomic_xor_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
 #define tcg_gen_rotr_tl tcg_gen_rotr_i64
 #define tcg_gen_rotri_tl tcg_gen_rotri_i64
 #define tcg_gen_deposit_tl tcg_gen_deposit_i64
+#define tcg_gen_extract_tl tcg_gen_extract_i64
+#define tcg_gen_sextract_tl tcg_gen_sextract_i64
 #define tcg_const_tl tcg_const_i64
 #define tcg_const_local_tl tcg_const_local_i64
 #define tcg_gen_movcond_tl tcg_gen_movcond_i64
@@ -1039,6 +1049,8 @@ void tcg_gen_atomic_xor_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
 #define tcg_gen_rotr_tl tcg_gen_rotr_i32
 #define tcg_gen_rotri_tl tcg_gen_rotri_i32
 #define tcg_gen_deposit_tl tcg_gen_deposit_i32
+#define tcg_gen_extract_tl tcg_gen_extract_i32
+#define tcg_gen_sextract_tl tcg_gen_sextract_i32
 #define tcg_const_tl tcg_const_i32
 #define tcg_const_local_tl tcg_const_local_i32
 #define tcg_gen_movcond_tl tcg_gen_movcond_i32
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index 45528d2..11563ac 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -77,6 +77,8 @@ DEF(sar_i32, 1, 2, 0, 0)
 DEF(rotl_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_rot_i32))
 DEF(rotr_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_rot_i32))
 DEF(deposit_i32, 1, 2, 2, IMPL(TCG_TARGET_HAS_deposit_i32))
+DEF(extract_i32, 1, 1, 2, IMPL(TCG_TARGET_HAS_extract_i32))
+DEF(sextract_i32, 1, 1, 2, IMPL(TCG_TARGET_HAS_sextract_i32))
 
 DEF(brcond_i32, 0, 2, 2, TCG_OPF_BB_END)
 
@@ -139,6 +141,8 @@ DEF(sar_i64, 1, 2, 0, IMPL64)
 DEF(rotl_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_rot_i64))
 DEF(rotr_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_rot_i64))
 DEF(deposit_i64, 1, 2, 2, IMPL64 | IMPL(TCG_TARGET_HAS_deposit_i64))
+DEF(extract_i64, 1, 1, 2, IMPL64 | IMPL(TCG_TARGET_HAS_extract_i64))
+DEF(sextract_i64, 1, 1, 2, IMPL64 | IMPL(TCG_TARGET_HAS_sextract_i64))
 
 /* size changing ops */
 DEF(ext_i32_i64, 1, 1, 0, IMPL64)
diff --git a/tcg/tcg.h b/tcg/tcg.h
index a35e4c4..5fd3733 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -112,6 +112,8 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_deposit_i64      0
+#define TCG_TARGET_HAS_extract_i64      0
+#define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_movcond_i64      0
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i64         0
@@ -130,6 +132,12 @@ typedef uint64_t TCGRegSet;
 #ifndef TCG_TARGET_deposit_i64_valid
 #define TCG_TARGET_deposit_i64_valid(ofs, len) 1
 #endif
+#ifndef TCG_TARGET_extract_i32_valid
+#define TCG_TARGET_extract_i32_valid(ofs, len) 1
+#endif
+#ifndef TCG_TARGET_extract_i64_valid
+#define TCG_TARGET_extract_i64_valid(ofs, len) 1
+#endif
 
 /* Only one of DIV or DIV2 should be defined.  */
 #if defined(TCG_TARGET_HAS_div_i32)
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 868228b..2065042 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -69,6 +69,8 @@
 #define TCG_TARGET_HAS_ext16u_i32       1
 #define TCG_TARGET_HAS_andc_i32         0
 #define TCG_TARGET_HAS_deposit_i32      1
+#define TCG_TARGET_HAS_extract_i32      0
+#define TCG_TARGET_HAS_sextract_i32     0
 #define TCG_TARGET_HAS_eqv_i32          0
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
@@ -88,6 +90,8 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_deposit_i64      1
+#define TCG_TARGET_HAS_extract_i64      0
+#define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_div_i64          0
 #define TCG_TARGET_HAS_rem_i64          0
 #define TCG_TARGET_HAS_ext8s_i64        1
-- 
2.9.3
