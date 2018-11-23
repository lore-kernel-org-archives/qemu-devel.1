Received: from eggs.gnu.org ([2001:4830:134:3::10]:44220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCj4-0000Hc-J9
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCj3-0003jY-Dy
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:34 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gQCj1-0003fW-Od
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:32 -0500
Received: by mail-wm1-x343.google.com with SMTP id 125so12200375wmh.0
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 06:46:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 23 Nov 2018 15:45:52 +0100
Message-Id: <20181123144558.5048-32-richard.henderson@linaro.org>
In-Reply-To: <20181123144558.5048-1-richard.henderson@linaro.org>
References: <20181123144558.5048-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 v2 31/37] tcg/aarch64: Set
 TCG_TARGET_HAS_MEMORY_BSWAP to false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com

This allows us to remove some code from the backend, allowing
the generic code to emit any extra bswaps.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h     |  2 +-
 tcg/aarch64/tcg-target.inc.c | 51 +++++++-----------------------------
 2 files changed, 10 insertions(+), 43 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 0788f2eecb..7f55d50400 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -137,7 +137,7 @@ typedef enum {
 #define TCG_TARGET_HAS_mul_vec          1
 
 #define TCG_TARGET_DEFAULT_MO (0)
-#define TCG_TARGET_HAS_MEMORY_BSWAP     1
+#define TCG_TARGET_HAS_MEMORY_BSWAP     0
 
 static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
 {
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 8edea527f7..34f9347cdf 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -1485,8 +1485,6 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGMemOp memop, TCGType ext,
                                    TCGReg data_r, TCGReg addr_r,
                                    TCGType otype, TCGReg off_r)
 {
-    const TCGMemOp bswap = memop & MO_BSWAP;
-
     switch (memop & MO_SSIZE) {
     case MO_UB:
         tcg_out_ldst_r(s, I3312_LDRB, data_r, addr_r, otype, off_r);
@@ -1497,43 +1495,22 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGMemOp memop, TCGType ext,
         break;
     case MO_UW:
         tcg_out_ldst_r(s, I3312_LDRH, data_r, addr_r, otype, off_r);
-        if (bswap) {
-            tcg_out_rev16(s, data_r, data_r);
-        }
         break;
     case MO_SW:
-        if (bswap) {
-            tcg_out_ldst_r(s, I3312_LDRH, data_r, addr_r, otype, off_r);
-            tcg_out_rev16(s, data_r, data_r);
-            tcg_out_sxt(s, ext, MO_16, data_r, data_r);
-        } else {
-            tcg_out_ldst_r(s, (ext ? I3312_LDRSHX : I3312_LDRSHW),
-                           data_r, addr_r, otype, off_r);
-        }
+        tcg_out_ldst_r(s, (ext ? I3312_LDRSHX : I3312_LDRSHW),
+                       data_r, addr_r, otype, off_r);
         break;
     case MO_UL:
         tcg_out_ldst_r(s, I3312_LDRW, data_r, addr_r, otype, off_r);
-        if (bswap) {
-            tcg_out_rev32(s, data_r, data_r);
-        }
         break;
     case MO_SL:
-        if (bswap) {
-            tcg_out_ldst_r(s, I3312_LDRW, data_r, addr_r, otype, off_r);
-            tcg_out_rev32(s, data_r, data_r);
-            tcg_out_sxt(s, TCG_TYPE_I64, MO_32, data_r, data_r);
-        } else {
-            tcg_out_ldst_r(s, I3312_LDRSWX, data_r, addr_r, otype, off_r);
-        }
+        tcg_out_ldst_r(s, I3312_LDRSWX, data_r, addr_r, otype, off_r);
         break;
     case MO_Q:
         tcg_out_ldst_r(s, I3312_LDRX, data_r, addr_r, otype, off_r);
-        if (bswap) {
-            tcg_out_rev64(s, data_r, data_r);
-        }
         break;
     default:
-        tcg_abort();
+        g_assert_not_reached();
     }
 }
 
@@ -1541,35 +1518,21 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGMemOp memop,
                                    TCGReg data_r, TCGReg addr_r,
                                    TCGType otype, TCGReg off_r)
 {
-    const TCGMemOp bswap = memop & MO_BSWAP;
-
     switch (memop & MO_SIZE) {
     case MO_8:
         tcg_out_ldst_r(s, I3312_STRB, data_r, addr_r, otype, off_r);
         break;
     case MO_16:
-        if (bswap && data_r != TCG_REG_XZR) {
-            tcg_out_rev16(s, TCG_REG_TMP, data_r);
-            data_r = TCG_REG_TMP;
-        }
         tcg_out_ldst_r(s, I3312_STRH, data_r, addr_r, otype, off_r);
         break;
     case MO_32:
-        if (bswap && data_r != TCG_REG_XZR) {
-            tcg_out_rev32(s, TCG_REG_TMP, data_r);
-            data_r = TCG_REG_TMP;
-        }
         tcg_out_ldst_r(s, I3312_STRW, data_r, addr_r, otype, off_r);
         break;
     case MO_64:
-        if (bswap && data_r != TCG_REG_XZR) {
-            tcg_out_rev64(s, TCG_REG_TMP, data_r);
-            data_r = TCG_REG_TMP;
-        }
         tcg_out_ldst_r(s, I3312_STRX, data_r, addr_r, otype, off_r);
         break;
     default:
-        tcg_abort();
+        g_assert_not_reached();
     }
 }
 
@@ -1578,6 +1541,8 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
 {
     TCGMemOp memop = get_memop(oi);
 
+    tcg_debug_assert(!(memop & MO_BSWAP));
+
 #ifdef CONFIG_SOFTMMU
     /* Ignore the requested "ext".  We get the same correct result from
      * a 16-bit sign-extended to 64-bit as we do sign-extended to 32-bit,
@@ -1608,6 +1573,8 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
 {
     TCGMemOp memop = get_memop(oi);
 
+    tcg_debug_assert(!(memop & MO_BSWAP));
+
 #ifdef CONFIG_SOFTMMU
     bool is_64 = (memop & MO_SIZE) == MO_64;
 
-- 
2.17.2
