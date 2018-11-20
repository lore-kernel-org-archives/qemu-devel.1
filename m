Received: from eggs.gnu.org ([2001:4830:134:3::10]:43720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gP4x9-0001mQ-9B
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:16:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gP4x8-00053m-5D
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:16:27 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gP4x7-00053X-Vk
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:16:26 -0500
Received: by mail-pl1-x642.google.com with SMTP id v1-v6so930592plo.2
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 04:16:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 20 Nov 2018 13:15:57 +0100
Message-Id: <20181120121558.7660-5-richard.henderson@linaro.org>
In-Reply-To: <20181120121558.7660-1-richard.henderson@linaro.org>
References: <20181120121558.7660-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 4/5] tcg/aarch64: Set
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
 tcg/aarch64/tcg-target.inc.c | 63 ++++++++----------------------------
 2 files changed, 14 insertions(+), 51 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index f966a4fcb3..ef9e9084b2 100644
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
index 083592a4d7..784c31d783 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -1383,9 +1383,6 @@ static void * const qemu_ld_helpers[16] = {
     [MO_LEUW] = helper_le_lduw_mmu,
     [MO_LEUL] = helper_le_ldul_mmu,
     [MO_LEQ]  = helper_le_ldq_mmu,
-    [MO_BEUW] = helper_be_lduw_mmu,
-    [MO_BEUL] = helper_be_ldul_mmu,
-    [MO_BEQ]  = helper_be_ldq_mmu,
 };
 
 /* helper signature: helper_ret_st_mmu(CPUState *env, target_ulong addr,
@@ -1397,9 +1394,6 @@ static void * const qemu_st_helpers[16] = {
     [MO_LEUW] = helper_le_stw_mmu,
     [MO_LEUL] = helper_le_stl_mmu,
     [MO_LEQ]  = helper_le_stq_mmu,
-    [MO_BEUW] = helper_be_stw_mmu,
-    [MO_BEUL] = helper_be_stl_mmu,
-    [MO_BEQ]  = helper_be_stq_mmu,
 };
 
 static inline void tcg_out_adr(TCGContext *s, TCGReg rd, void *target)
@@ -1421,7 +1415,7 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     tcg_out_mov(s, TARGET_LONG_BITS == 64, TCG_REG_X1, lb->addrlo_reg);
     tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_X2, oi);
     tcg_out_adr(s, TCG_REG_X3, lb->raddr);
-    tcg_out_call(s, qemu_ld_helpers[opc & (MO_BSWAP | MO_SIZE)]);
+    tcg_out_call(s, qemu_ld_helpers[opc & MO_SIZE]);
     if (opc & MO_SIGN) {
         tcg_out_sxt(s, lb->type, size, lb->datalo_reg, TCG_REG_X0);
     } else {
@@ -1444,7 +1438,7 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     tcg_out_mov(s, size == MO_64, TCG_REG_X2, lb->datalo_reg);
     tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_X3, oi);
     tcg_out_adr(s, TCG_REG_X4, lb->raddr);
-    tcg_out_call(s, qemu_st_helpers[opc & (MO_BSWAP | MO_SIZE)]);
+    tcg_out_call(s, qemu_st_helpers[opc & MO_SIZE]);
     tcg_out_goto(s, lb->raddr);
 }
 
@@ -1544,8 +1538,6 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGMemOp memop, TCGType ext,
                                    TCGReg data_r, TCGReg addr_r,
                                    TCGType otype, TCGReg off_r)
 {
-    const TCGMemOp bswap = memop & MO_BSWAP;
-
     switch (memop & MO_SSIZE) {
     case MO_UB:
         tcg_out_ldst_r(s, I3312_LDRB, data_r, addr_r, otype, off_r);
@@ -1556,43 +1548,22 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGMemOp memop, TCGType ext,
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
 
@@ -1600,35 +1571,21 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGMemOp memop,
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
 
@@ -1637,6 +1594,9 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
 {
     TCGMemOp memop = get_memop(oi);
     const TCGType otype = TARGET_LONG_BITS == 64 ? TCG_TYPE_I64 : TCG_TYPE_I32;
+
+    tcg_debug_assert(!(memop & MO_BSWAP));
+
 #ifdef CONFIG_SOFTMMU
     unsigned mem_index = get_mmuidx(oi);
     tcg_insn_unit *label_ptr;
@@ -1662,6 +1622,9 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
 {
     TCGMemOp memop = get_memop(oi);
     const TCGType otype = TARGET_LONG_BITS == 64 ? TCG_TYPE_I64 : TCG_TYPE_I32;
+
+    tcg_debug_assert(!(memop & MO_BSWAP));
+
 #ifdef CONFIG_SOFTMMU
     unsigned mem_index = get_mmuidx(oi);
     tcg_insn_unit *label_ptr;
-- 
2.17.2
