Received: from eggs.gnu.org ([2001:4830:134:3::10]:46471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmi-0001Fy-Fw
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmY-0008Oj-FA
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:56 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36327)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpmY-0008O7-9L
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:46 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:04:14 -0400
Message-Id: <1500235468-15341-32-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 31/45] tci: move tci_regs to
 tcg_qemu_tb_exec's stack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

Groundwork for supporting multiple TCG contexts.

Compile-tested for all targets on an x86_64 host.

Suggested-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/tci.c | 552 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 279 insertions(+), 273 deletions(-)

diff --git a/tcg/tci.c b/tcg/tci.c
index 4bdc645..f3216c1 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -55,93 +55,95 @@ typedef uint64_t (*helper_function)(tcg_target_ulong, tcg_target_ulong,
                                     tcg_target_ulong);
 #endif
 
-static tcg_target_ulong tci_reg[TCG_TARGET_NB_REGS];
-
-static tcg_target_ulong tci_read_reg(TCGReg index)
+static tcg_target_ulong tci_read_reg(const tcg_target_ulong *regs, TCGReg index)
 {
-    tci_assert(index < ARRAY_SIZE(tci_reg));
-    return tci_reg[index];
+    tci_assert(index < TCG_TARGET_NB_REGS);
+    return regs[index];
 }
 
 #if TCG_TARGET_HAS_ext8s_i32 || TCG_TARGET_HAS_ext8s_i64
-static int8_t tci_read_reg8s(TCGReg index)
+static int8_t tci_read_reg8s(const tcg_target_ulong *regs, TCGReg index)
 {
-    return (int8_t)tci_read_reg(index);
+    return (int8_t)tci_read_reg(regs, index);
 }
 #endif
 
 #if TCG_TARGET_HAS_ext16s_i32 || TCG_TARGET_HAS_ext16s_i64
-static int16_t tci_read_reg16s(TCGReg index)
+static int16_t tci_read_reg16s(const tcg_target_ulong *regs, TCGReg index)
 {
-    return (int16_t)tci_read_reg(index);
+    return (int16_t)tci_read_reg(regs, index);
 }
 #endif
 
 #if TCG_TARGET_REG_BITS == 64
-static int32_t tci_read_reg32s(TCGReg index)
+static int32_t tci_read_reg32s(const tcg_target_ulong *regs, TCGReg index)
 {
-    return (int32_t)tci_read_reg(index);
+    return (int32_t)tci_read_reg(regs, index);
 }
 #endif
 
-static uint8_t tci_read_reg8(TCGReg index)
+static uint8_t tci_read_reg8(const tcg_target_ulong *regs, TCGReg index)
 {
-    return (uint8_t)tci_read_reg(index);
+    return (uint8_t)tci_read_reg(regs, index);
 }
 
-static uint16_t tci_read_reg16(TCGReg index)
+static uint16_t tci_read_reg16(const tcg_target_ulong *regs, TCGReg index)
 {
-    return (uint16_t)tci_read_reg(index);
+    return (uint16_t)tci_read_reg(regs, index);
 }
 
-static uint32_t tci_read_reg32(TCGReg index)
+static uint32_t tci_read_reg32(const tcg_target_ulong *regs, TCGReg index)
 {
-    return (uint32_t)tci_read_reg(index);
+    return (uint32_t)tci_read_reg(regs, index);
 }
 
 #if TCG_TARGET_REG_BITS == 64
-static uint64_t tci_read_reg64(TCGReg index)
+static uint64_t tci_read_reg64(const tcg_target_ulong *regs, TCGReg index)
 {
-    return tci_read_reg(index);
+    return tci_read_reg(regs, index);
 }
 #endif
 
-static void tci_write_reg(TCGReg index, tcg_target_ulong value)
+static void
+tci_write_reg(tcg_target_ulong *regs, TCGReg index, tcg_target_ulong value)
 {
-    tci_assert(index < ARRAY_SIZE(tci_reg));
+    tci_assert(index < TCG_TARGET_NB_REGS);
     tci_assert(index != TCG_AREG0);
     tci_assert(index != TCG_REG_CALL_STACK);
-    tci_reg[index] = value;
+    regs[index] = value;
 }
 
 #if TCG_TARGET_REG_BITS == 64
-static void tci_write_reg32s(TCGReg index, int32_t value)
+static void
+tci_write_reg32s(tcg_target_ulong *regs, TCGReg index, int32_t value)
 {
-    tci_write_reg(index, value);
+    tci_write_reg(regs, index, value);
 }
 #endif
 
-static void tci_write_reg8(TCGReg index, uint8_t value)
+static void tci_write_reg8(tcg_target_ulong *regs, TCGReg index, uint8_t value)
 {
-    tci_write_reg(index, value);
+    tci_write_reg(regs, index, value);
 }
 
-static void tci_write_reg32(TCGReg index, uint32_t value)
+static void
+tci_write_reg32(tcg_target_ulong *regs, TCGReg index, uint32_t value)
 {
-    tci_write_reg(index, value);
+    tci_write_reg(regs, index, value);
 }
 
 #if TCG_TARGET_REG_BITS == 32
-static void tci_write_reg64(uint32_t high_index, uint32_t low_index,
-                            uint64_t value)
+static void tci_write_reg64(tcg_target_ulong *regs, uint32_t high_index,
+                            uint32_t low_index, uint64_t value)
 {
-    tci_write_reg(low_index, value);
-    tci_write_reg(high_index, value >> 32);
+    tci_write_reg(regs, low_index, value);
+    tci_write_reg(regs, high_index, value >> 32);
 }
 #elif TCG_TARGET_REG_BITS == 64
-static void tci_write_reg64(TCGReg index, uint64_t value)
+static void
+tci_write_reg64(tcg_target_ulong *regs, TCGReg index, uint64_t value)
 {
-    tci_write_reg(index, value);
+    tci_write_reg(regs, index, value);
 }
 #endif
 
@@ -188,94 +190,97 @@ static uint64_t tci_read_i64(uint8_t **tb_ptr)
 #endif
 
 /* Read indexed register (native size) from bytecode. */
-static tcg_target_ulong tci_read_r(uint8_t **tb_ptr)
+static tcg_target_ulong
+tci_read_r(const tcg_target_ulong *regs, uint8_t **tb_ptr)
 {
-    tcg_target_ulong value = tci_read_reg(**tb_ptr);
+    tcg_target_ulong value = tci_read_reg(regs, **tb_ptr);
     *tb_ptr += 1;
     return value;
 }
 
 /* Read indexed register (8 bit) from bytecode. */
-static uint8_t tci_read_r8(uint8_t **tb_ptr)
+static uint8_t tci_read_r8(const tcg_target_ulong *regs, uint8_t **tb_ptr)
 {
-    uint8_t value = tci_read_reg8(**tb_ptr);
+    uint8_t value = tci_read_reg8(regs, **tb_ptr);
     *tb_ptr += 1;
     return value;
 }
 
 #if TCG_TARGET_HAS_ext8s_i32 || TCG_TARGET_HAS_ext8s_i64
 /* Read indexed register (8 bit signed) from bytecode. */
-static int8_t tci_read_r8s(uint8_t **tb_ptr)
+static int8_t tci_read_r8s(const tcg_target_ulong *regs, uint8_t **tb_ptr)
 {
-    int8_t value = tci_read_reg8s(**tb_ptr);
+    int8_t value = tci_read_reg8s(regs, **tb_ptr);
     *tb_ptr += 1;
     return value;
 }
 #endif
 
 /* Read indexed register (16 bit) from bytecode. */
-static uint16_t tci_read_r16(uint8_t **tb_ptr)
+static uint16_t tci_read_r16(const tcg_target_ulong *regs, uint8_t **tb_ptr)
 {
-    uint16_t value = tci_read_reg16(**tb_ptr);
+    uint16_t value = tci_read_reg16(regs, **tb_ptr);
     *tb_ptr += 1;
     return value;
 }
 
 #if TCG_TARGET_HAS_ext16s_i32 || TCG_TARGET_HAS_ext16s_i64
 /* Read indexed register (16 bit signed) from bytecode. */
-static int16_t tci_read_r16s(uint8_t **tb_ptr)
+static int16_t tci_read_r16s(const tcg_target_ulong *regs, uint8_t **tb_ptr)
 {
-    int16_t value = tci_read_reg16s(**tb_ptr);
+    int16_t value = tci_read_reg16s(regs, **tb_ptr);
     *tb_ptr += 1;
     return value;
 }
 #endif
 
 /* Read indexed register (32 bit) from bytecode. */
-static uint32_t tci_read_r32(uint8_t **tb_ptr)
+static uint32_t tci_read_r32(const tcg_target_ulong *regs, uint8_t **tb_ptr)
 {
-    uint32_t value = tci_read_reg32(**tb_ptr);
+    uint32_t value = tci_read_reg32(regs, **tb_ptr);
     *tb_ptr += 1;
     return value;
 }
 
 #if TCG_TARGET_REG_BITS == 32
 /* Read two indexed registers (2 * 32 bit) from bytecode. */
-static uint64_t tci_read_r64(uint8_t **tb_ptr)
+static uint64_t tci_read_r64(const tcg_target_ulong *regs, uint8_t **tb_ptr)
 {
-    uint32_t low = tci_read_r32(tb_ptr);
-    return tci_uint64(tci_read_r32(tb_ptr), low);
+    uint32_t low = tci_read_r32(regs, tb_ptr);
+    return tci_uint64(tci_read_r32(regs, tb_ptr), low);
 }
 #elif TCG_TARGET_REG_BITS == 64
 /* Read indexed register (32 bit signed) from bytecode. */
-static int32_t tci_read_r32s(uint8_t **tb_ptr)
+static int32_t tci_read_r32s(const tcg_target_ulong *regs, uint8_t **tb_ptr)
 {
-    int32_t value = tci_read_reg32s(**tb_ptr);
+    int32_t value = tci_read_reg32s(regs, **tb_ptr);
     *tb_ptr += 1;
     return value;
 }
 
 /* Read indexed register (64 bit) from bytecode. */
-static uint64_t tci_read_r64(uint8_t **tb_ptr)
+static uint64_t tci_read_r64(const tcg_target_ulong *regs, uint8_t **tb_ptr)
 {
-    uint64_t value = tci_read_reg64(**tb_ptr);
+    uint64_t value = tci_read_reg64(regs, **tb_ptr);
     *tb_ptr += 1;
     return value;
 }
 #endif
 
 /* Read indexed register(s) with target address from bytecode. */
-static target_ulong tci_read_ulong(uint8_t **tb_ptr)
+static target_ulong
+tci_read_ulong(const tcg_target_ulong *regs, uint8_t **tb_ptr)
 {
-    target_ulong taddr = tci_read_r(tb_ptr);
+    target_ulong taddr = tci_read_r(regs, tb_ptr);
 #if TARGET_LONG_BITS > TCG_TARGET_REG_BITS
-    taddr += (uint64_t)tci_read_r(tb_ptr) << 32;
+    taddr += (uint64_t)tci_read_r(regs, tb_ptr) << 32;
 #endif
     return taddr;
 }
 
 /* Read indexed register or constant (native size) from bytecode. */
-static tcg_target_ulong tci_read_ri(uint8_t **tb_ptr)
+static tcg_target_ulong
+tci_read_ri(const tcg_target_ulong *regs, uint8_t **tb_ptr)
 {
     tcg_target_ulong value;
     TCGReg r = **tb_ptr;
@@ -283,13 +288,13 @@ static tcg_target_ulong tci_read_ri(uint8_t **tb_ptr)
     if (r == TCG_CONST) {
         value = tci_read_i(tb_ptr);
     } else {
-        value = tci_read_reg(r);
+        value = tci_read_reg(regs, r);
     }
     return value;
 }
 
 /* Read indexed register or constant (32 bit) from bytecode. */
-static uint32_t tci_read_ri32(uint8_t **tb_ptr)
+static uint32_t tci_read_ri32(const tcg_target_ulong *regs, uint8_t **tb_ptr)
 {
     uint32_t value;
     TCGReg r = **tb_ptr;
@@ -297,21 +302,21 @@ static uint32_t tci_read_ri32(uint8_t **tb_ptr)
     if (r == TCG_CONST) {
         value = tci_read_i32(tb_ptr);
     } else {
-        value = tci_read_reg32(r);
+        value = tci_read_reg32(regs, r);
     }
     return value;
 }
 
 #if TCG_TARGET_REG_BITS == 32
 /* Read two indexed registers or constants (2 * 32 bit) from bytecode. */
-static uint64_t tci_read_ri64(uint8_t **tb_ptr)
+static uint64_t tci_read_ri64(const tcg_target_ulong *regs, uint8_t **tb_ptr)
 {
-    uint32_t low = tci_read_ri32(tb_ptr);
-    return tci_uint64(tci_read_ri32(tb_ptr), low);
+    uint32_t low = tci_read_ri32(regs, tb_ptr);
+    return tci_uint64(tci_read_ri32(regs, tb_ptr), low);
 }
 #elif TCG_TARGET_REG_BITS == 64
 /* Read indexed register or constant (64 bit) from bytecode. */
-static uint64_t tci_read_ri64(uint8_t **tb_ptr)
+static uint64_t tci_read_ri64(const tcg_target_ulong *regs, uint8_t **tb_ptr)
 {
     uint64_t value;
     TCGReg r = **tb_ptr;
@@ -319,7 +324,7 @@ static uint64_t tci_read_ri64(uint8_t **tb_ptr)
     if (r == TCG_CONST) {
         value = tci_read_i64(tb_ptr);
     } else {
-        value = tci_read_reg64(r);
+        value = tci_read_reg64(regs, r);
     }
     return value;
 }
@@ -465,12 +470,13 @@ static bool tci_compare64(uint64_t u0, uint64_t u1, TCGCond condition)
 /* Interpret pseudo code in tb. */
 uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
 {
+    tcg_target_ulong regs[TCG_TARGET_NB_REGS];
     long tcg_temps[CPU_TEMP_BUF_NLONGS];
     uintptr_t sp_value = (uintptr_t)(tcg_temps + CPU_TEMP_BUF_NLONGS);
     uintptr_t ret = 0;
 
-    tci_reg[TCG_AREG0] = (tcg_target_ulong)env;
-    tci_reg[TCG_REG_CALL_STACK] = sp_value;
+    regs[TCG_AREG0] = (tcg_target_ulong)env;
+    regs[TCG_REG_CALL_STACK] = sp_value;
     tci_assert(tb_ptr);
 
     for (;;) {
@@ -503,27 +509,27 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
 
         switch (opc) {
         case INDEX_op_call:
-            t0 = tci_read_ri(&tb_ptr);
+            t0 = tci_read_ri(regs, &tb_ptr);
 #if TCG_TARGET_REG_BITS == 32
-            tmp64 = ((helper_function)t0)(tci_read_reg(TCG_REG_R0),
-                                          tci_read_reg(TCG_REG_R1),
-                                          tci_read_reg(TCG_REG_R2),
-                                          tci_read_reg(TCG_REG_R3),
-                                          tci_read_reg(TCG_REG_R5),
-                                          tci_read_reg(TCG_REG_R6),
-                                          tci_read_reg(TCG_REG_R7),
-                                          tci_read_reg(TCG_REG_R8),
-                                          tci_read_reg(TCG_REG_R9),
-                                          tci_read_reg(TCG_REG_R10));
-            tci_write_reg(TCG_REG_R0, tmp64);
-            tci_write_reg(TCG_REG_R1, tmp64 >> 32);
+            tmp64 = ((helper_function)t0)(tci_read_reg(regs, TCG_REG_R0),
+                                          tci_read_reg(regs, TCG_REG_R1),
+                                          tci_read_reg(regs, TCG_REG_R2),
+                                          tci_read_reg(regs, TCG_REG_R3),
+                                          tci_read_reg(regs, TCG_REG_R5),
+                                          tci_read_reg(regs, TCG_REG_R6),
+                                          tci_read_reg(regs, TCG_REG_R7),
+                                          tci_read_reg(regs, TCG_REG_R8),
+                                          tci_read_reg(regs, TCG_REG_R9),
+                                          tci_read_reg(regs, TCG_REG_R10));
+            tci_write_reg(regs, TCG_REG_R0, tmp64);
+            tci_write_reg(regs, TCG_REG_R1, tmp64 >> 32);
 #else
-            tmp64 = ((helper_function)t0)(tci_read_reg(TCG_REG_R0),
-                                          tci_read_reg(TCG_REG_R1),
-                                          tci_read_reg(TCG_REG_R2),
-                                          tci_read_reg(TCG_REG_R3),
-                                          tci_read_reg(TCG_REG_R5));
-            tci_write_reg(TCG_REG_R0, tmp64);
+            tmp64 = ((helper_function)t0)(tci_read_reg(regs, TCG_REG_R0),
+                                          tci_read_reg(regs, TCG_REG_R1),
+                                          tci_read_reg(regs, TCG_REG_R2),
+                                          tci_read_reg(regs, TCG_REG_R3),
+                                          tci_read_reg(regs, TCG_REG_R5));
+            tci_write_reg(regs, TCG_REG_R0, tmp64);
 #endif
             break;
         case INDEX_op_br:
@@ -533,46 +539,46 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
             continue;
         case INDEX_op_setcond_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_r32(&tb_ptr);
-            t2 = tci_read_ri32(&tb_ptr);
+            t1 = tci_read_r32(regs, &tb_ptr);
+            t2 = tci_read_ri32(regs, &tb_ptr);
             condition = *tb_ptr++;
-            tci_write_reg32(t0, tci_compare32(t1, t2, condition));
+            tci_write_reg32(regs, t0, tci_compare32(t1, t2, condition));
             break;
 #if TCG_TARGET_REG_BITS == 32
         case INDEX_op_setcond2_i32:
             t0 = *tb_ptr++;
-            tmp64 = tci_read_r64(&tb_ptr);
-            v64 = tci_read_ri64(&tb_ptr);
+            tmp64 = tci_read_r64(regs, &tb_ptr);
+            v64 = tci_read_ri64(regs, &tb_ptr);
             condition = *tb_ptr++;
-            tci_write_reg32(t0, tci_compare64(tmp64, v64, condition));
+            tci_write_reg32(regs, t0, tci_compare64(tmp64, v64, condition));
             break;
 #elif TCG_TARGET_REG_BITS == 64
         case INDEX_op_setcond_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_r64(&tb_ptr);
-            t2 = tci_read_ri64(&tb_ptr);
+            t1 = tci_read_r64(regs, &tb_ptr);
+            t2 = tci_read_ri64(regs, &tb_ptr);
             condition = *tb_ptr++;
-            tci_write_reg64(t0, tci_compare64(t1, t2, condition));
+            tci_write_reg64(regs, t0, tci_compare64(t1, t2, condition));
             break;
 #endif
         case INDEX_op_mov_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_r32(&tb_ptr);
-            tci_write_reg32(t0, t1);
+            t1 = tci_read_r32(regs, &tb_ptr);
+            tci_write_reg32(regs, t0, t1);
             break;
         case INDEX_op_movi_i32:
             t0 = *tb_ptr++;
             t1 = tci_read_i32(&tb_ptr);
-            tci_write_reg32(t0, t1);
+            tci_write_reg32(regs, t0, t1);
             break;
 
             /* Load/store operations (32 bit). */
 
         case INDEX_op_ld8u_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_r(&tb_ptr);
+            t1 = tci_read_r(regs, &tb_ptr);
             t2 = tci_read_s32(&tb_ptr);
-            tci_write_reg8(t0, *(uint8_t *)(t1 + t2));
+            tci_write_reg8(regs, t0, *(uint8_t *)(t1 + t2));
             break;
         case INDEX_op_ld8s_i32:
         case INDEX_op_ld16u_i32:
@@ -583,25 +589,25 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
             break;
         case INDEX_op_ld_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_r(&tb_ptr);
+            t1 = tci_read_r(regs, &tb_ptr);
             t2 = tci_read_s32(&tb_ptr);
-            tci_write_reg32(t0, *(uint32_t *)(t1 + t2));
+            tci_write_reg32(regs, t0, *(uint32_t *)(t1 + t2));
             break;
         case INDEX_op_st8_i32:
-            t0 = tci_read_r8(&tb_ptr);
-            t1 = tci_read_r(&tb_ptr);
+            t0 = tci_read_r8(regs, &tb_ptr);
+            t1 = tci_read_r(regs, &tb_ptr);
             t2 = tci_read_s32(&tb_ptr);
             *(uint8_t *)(t1 + t2) = t0;
             break;
         case INDEX_op_st16_i32:
-            t0 = tci_read_r16(&tb_ptr);
-            t1 = tci_read_r(&tb_ptr);
+            t0 = tci_read_r16(regs, &tb_ptr);
+            t1 = tci_read_r(regs, &tb_ptr);
             t2 = tci_read_s32(&tb_ptr);
             *(uint16_t *)(t1 + t2) = t0;
             break;
         case INDEX_op_st_i32:
-            t0 = tci_read_r32(&tb_ptr);
-            t1 = tci_read_r(&tb_ptr);
+            t0 = tci_read_r32(regs, &tb_ptr);
+            t1 = tci_read_r(regs, &tb_ptr);
             t2 = tci_read_s32(&tb_ptr);
             tci_assert(t1 != sp_value || (int32_t)t2 < 0);
             *(uint32_t *)(t1 + t2) = t0;
@@ -611,46 +617,46 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
 
         case INDEX_op_add_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_ri32(&tb_ptr);
-            t2 = tci_read_ri32(&tb_ptr);
-            tci_write_reg32(t0, t1 + t2);
+            t1 = tci_read_ri32(regs, &tb_ptr);
+            t2 = tci_read_ri32(regs, &tb_ptr);
+            tci_write_reg32(regs, t0, t1 + t2);
             break;
         case INDEX_op_sub_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_ri32(&tb_ptr);
-            t2 = tci_read_ri32(&tb_ptr);
-            tci_write_reg32(t0, t1 - t2);
+            t1 = tci_read_ri32(regs, &tb_ptr);
+            t2 = tci_read_ri32(regs, &tb_ptr);
+            tci_write_reg32(regs, t0, t1 - t2);
             break;
         case INDEX_op_mul_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_ri32(&tb_ptr);
-            t2 = tci_read_ri32(&tb_ptr);
-            tci_write_reg32(t0, t1 * t2);
+            t1 = tci_read_ri32(regs, &tb_ptr);
+            t2 = tci_read_ri32(regs, &tb_ptr);
+            tci_write_reg32(regs, t0, t1 * t2);
             break;
 #if TCG_TARGET_HAS_div_i32
         case INDEX_op_div_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_ri32(&tb_ptr);
-            t2 = tci_read_ri32(&tb_ptr);
-            tci_write_reg32(t0, (int32_t)t1 / (int32_t)t2);
+            t1 = tci_read_ri32(regs, &tb_ptr);
+            t2 = tci_read_ri32(regs, &tb_ptr);
+            tci_write_reg32(regs, t0, (int32_t)t1 / (int32_t)t2);
             break;
         case INDEX_op_divu_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_ri32(&tb_ptr);
-            t2 = tci_read_ri32(&tb_ptr);
-            tci_write_reg32(t0, t1 / t2);
+            t1 = tci_read_ri32(regs, &tb_ptr);
+            t2 = tci_read_ri32(regs, &tb_ptr);
+            tci_write_reg32(regs, t0, t1 / t2);
             break;
         case INDEX_op_rem_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_ri32(&tb_ptr);
-            t2 = tci_read_ri32(&tb_ptr);
-            tci_write_reg32(t0, (int32_t)t1 % (int32_t)t2);
+            t1 = tci_read_ri32(regs, &tb_ptr);
+            t2 = tci_read_ri32(regs, &tb_ptr);
+            tci_write_reg32(regs, t0, (int32_t)t1 % (int32_t)t2);
             break;
         case INDEX_op_remu_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_ri32(&tb_ptr);
-            t2 = tci_read_ri32(&tb_ptr);
-            tci_write_reg32(t0, t1 % t2);
+            t1 = tci_read_ri32(regs, &tb_ptr);
+            t2 = tci_read_ri32(regs, &tb_ptr);
+            tci_write_reg32(regs, t0, t1 % t2);
             break;
 #elif TCG_TARGET_HAS_div2_i32
         case INDEX_op_div2_i32:
@@ -660,71 +666,71 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
 #endif
         case INDEX_op_and_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_ri32(&tb_ptr);
-            t2 = tci_read_ri32(&tb_ptr);
-            tci_write_reg32(t0, t1 & t2);
+            t1 = tci_read_ri32(regs, &tb_ptr);
+            t2 = tci_read_ri32(regs, &tb_ptr);
+            tci_write_reg32(regs, t0, t1 & t2);
             break;
         case INDEX_op_or_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_ri32(&tb_ptr);
-            t2 = tci_read_ri32(&tb_ptr);
-            tci_write_reg32(t0, t1 | t2);
+            t1 = tci_read_ri32(regs, &tb_ptr);
+            t2 = tci_read_ri32(regs, &tb_ptr);
+            tci_write_reg32(regs, t0, t1 | t2);
             break;
         case INDEX_op_xor_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_ri32(&tb_ptr);
-            t2 = tci_read_ri32(&tb_ptr);
-            tci_write_reg32(t0, t1 ^ t2);
+            t1 = tci_read_ri32(regs, &tb_ptr);
+            t2 = tci_read_ri32(regs, &tb_ptr);
+            tci_write_reg32(regs, t0, t1 ^ t2);
             break;
 
             /* Shift/rotate operations (32 bit). */
 
         case INDEX_op_shl_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_ri32(&tb_ptr);
-            t2 = tci_read_ri32(&tb_ptr);
-            tci_write_reg32(t0, t1 << (t2 & 31));
+            t1 = tci_read_ri32(regs, &tb_ptr);
+            t2 = tci_read_ri32(regs, &tb_ptr);
+            tci_write_reg32(regs, t0, t1 << (t2 & 31));
             break;
         case INDEX_op_shr_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_ri32(&tb_ptr);
-            t2 = tci_read_ri32(&tb_ptr);
-            tci_write_reg32(t0, t1 >> (t2 & 31));
+            t1 = tci_read_ri32(regs, &tb_ptr);
+            t2 = tci_read_ri32(regs, &tb_ptr);
+            tci_write_reg32(regs, t0, t1 >> (t2 & 31));
             break;
         case INDEX_op_sar_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_ri32(&tb_ptr);
-            t2 = tci_read_ri32(&tb_ptr);
-            tci_write_reg32(t0, ((int32_t)t1 >> (t2 & 31)));
+            t1 = tci_read_ri32(regs, &tb_ptr);
+            t2 = tci_read_ri32(regs, &tb_ptr);
+            tci_write_reg32(regs, t0, ((int32_t)t1 >> (t2 & 31)));
             break;
 #if TCG_TARGET_HAS_rot_i32
         case INDEX_op_rotl_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_ri32(&tb_ptr);
-            t2 = tci_read_ri32(&tb_ptr);
-            tci_write_reg32(t0, rol32(t1, t2 & 31));
+            t1 = tci_read_ri32(regs, &tb_ptr);
+            t2 = tci_read_ri32(regs, &tb_ptr);
+            tci_write_reg32(regs, t0, rol32(t1, t2 & 31));
             break;
         case INDEX_op_rotr_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_ri32(&tb_ptr);
-            t2 = tci_read_ri32(&tb_ptr);
-            tci_write_reg32(t0, ror32(t1, t2 & 31));
+            t1 = tci_read_ri32(regs, &tb_ptr);
+            t2 = tci_read_ri32(regs, &tb_ptr);
+            tci_write_reg32(regs, t0, ror32(t1, t2 & 31));
             break;
 #endif
 #if TCG_TARGET_HAS_deposit_i32
         case INDEX_op_deposit_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_r32(&tb_ptr);
-            t2 = tci_read_r32(&tb_ptr);
+            t1 = tci_read_r32(regs, &tb_ptr);
+            t2 = tci_read_r32(regs, &tb_ptr);
             tmp16 = *tb_ptr++;
             tmp8 = *tb_ptr++;
             tmp32 = (((1 << tmp8) - 1) << tmp16);
-            tci_write_reg32(t0, (t1 & ~tmp32) | ((t2 << tmp16) & tmp32));
+            tci_write_reg32(regs, t0, (t1 & ~tmp32) | ((t2 << tmp16) & tmp32));
             break;
 #endif
         case INDEX_op_brcond_i32:
-            t0 = tci_read_r32(&tb_ptr);
-            t1 = tci_read_ri32(&tb_ptr);
+            t0 = tci_read_r32(regs, &tb_ptr);
+            t1 = tci_read_ri32(regs, &tb_ptr);
             condition = *tb_ptr++;
             label = tci_read_label(&tb_ptr);
             if (tci_compare32(t0, t1, condition)) {
@@ -737,20 +743,20 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
         case INDEX_op_add2_i32:
             t0 = *tb_ptr++;
             t1 = *tb_ptr++;
-            tmp64 = tci_read_r64(&tb_ptr);
-            tmp64 += tci_read_r64(&tb_ptr);
-            tci_write_reg64(t1, t0, tmp64);
+            tmp64 = tci_read_r64(regs, &tb_ptr);
+            tmp64 += tci_read_r64(regs, &tb_ptr);
+            tci_write_reg64(regs, t1, t0, tmp64);
             break;
         case INDEX_op_sub2_i32:
             t0 = *tb_ptr++;
             t1 = *tb_ptr++;
-            tmp64 = tci_read_r64(&tb_ptr);
-            tmp64 -= tci_read_r64(&tb_ptr);
-            tci_write_reg64(t1, t0, tmp64);
+            tmp64 = tci_read_r64(regs, &tb_ptr);
+            tmp64 -= tci_read_r64(regs, &tb_ptr);
+            tci_write_reg64(regs, t1, t0, tmp64);
             break;
         case INDEX_op_brcond2_i32:
-            tmp64 = tci_read_r64(&tb_ptr);
-            v64 = tci_read_ri64(&tb_ptr);
+            tmp64 = tci_read_r64(regs, &tb_ptr);
+            v64 = tci_read_ri64(regs, &tb_ptr);
             condition = *tb_ptr++;
             label = tci_read_label(&tb_ptr);
             if (tci_compare64(tmp64, v64, condition)) {
@@ -762,86 +768,86 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
         case INDEX_op_mulu2_i32:
             t0 = *tb_ptr++;
             t1 = *tb_ptr++;
-            t2 = tci_read_r32(&tb_ptr);
-            tmp64 = tci_read_r32(&tb_ptr);
-            tci_write_reg64(t1, t0, t2 * tmp64);
+            t2 = tci_read_r32(regs, &tb_ptr);
+            tmp64 = tci_read_r32(regs, &tb_ptr);
+            tci_write_reg64(regs, t1, t0, t2 * tmp64);
             break;
 #endif /* TCG_TARGET_REG_BITS == 32 */
 #if TCG_TARGET_HAS_ext8s_i32
         case INDEX_op_ext8s_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_r8s(&tb_ptr);
-            tci_write_reg32(t0, t1);
+            t1 = tci_read_r8s(regs, &tb_ptr);
+            tci_write_reg32(regs, t0, t1);
             break;
 #endif
 #if TCG_TARGET_HAS_ext16s_i32
         case INDEX_op_ext16s_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_r16s(&tb_ptr);
-            tci_write_reg32(t0, t1);
+            t1 = tci_read_r16s(regs, &tb_ptr);
+            tci_write_reg32(regs, t0, t1);
             break;
 #endif
 #if TCG_TARGET_HAS_ext8u_i32
         case INDEX_op_ext8u_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_r8(&tb_ptr);
-            tci_write_reg32(t0, t1);
+            t1 = tci_read_r8(regs, &tb_ptr);
+            tci_write_reg32(regs, t0, t1);
             break;
 #endif
 #if TCG_TARGET_HAS_ext16u_i32
         case INDEX_op_ext16u_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_r16(&tb_ptr);
-            tci_write_reg32(t0, t1);
+            t1 = tci_read_r16(regs, &tb_ptr);
+            tci_write_reg32(regs, t0, t1);
             break;
 #endif
 #if TCG_TARGET_HAS_bswap16_i32
         case INDEX_op_bswap16_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_r16(&tb_ptr);
-            tci_write_reg32(t0, bswap16(t1));
+            t1 = tci_read_r16(regs, &tb_ptr);
+            tci_write_reg32(regs, t0, bswap16(t1));
             break;
 #endif
 #if TCG_TARGET_HAS_bswap32_i32
         case INDEX_op_bswap32_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_r32(&tb_ptr);
-            tci_write_reg32(t0, bswap32(t1));
+            t1 = tci_read_r32(regs, &tb_ptr);
+            tci_write_reg32(regs, t0, bswap32(t1));
             break;
 #endif
 #if TCG_TARGET_HAS_not_i32
         case INDEX_op_not_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_r32(&tb_ptr);
-            tci_write_reg32(t0, ~t1);
+            t1 = tci_read_r32(regs, &tb_ptr);
+            tci_write_reg32(regs, t0, ~t1);
             break;
 #endif
 #if TCG_TARGET_HAS_neg_i32
         case INDEX_op_neg_i32:
             t0 = *tb_ptr++;
-            t1 = tci_read_r32(&tb_ptr);
-            tci_write_reg32(t0, -t1);
+            t1 = tci_read_r32(regs, &tb_ptr);
+            tci_write_reg32(regs, t0, -t1);
             break;
 #endif
 #if TCG_TARGET_REG_BITS == 64
         case INDEX_op_mov_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_r64(&tb_ptr);
-            tci_write_reg64(t0, t1);
+            t1 = tci_read_r64(regs, &tb_ptr);
+            tci_write_reg64(regs, t0, t1);
             break;
         case INDEX_op_movi_i64:
             t0 = *tb_ptr++;
             t1 = tci_read_i64(&tb_ptr);
-            tci_write_reg64(t0, t1);
+            tci_write_reg64(regs, t0, t1);
             break;
 
             /* Load/store operations (64 bit). */
 
         case INDEX_op_ld8u_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_r(&tb_ptr);
+            t1 = tci_read_r(regs, &tb_ptr);
             t2 = tci_read_s32(&tb_ptr);
-            tci_write_reg8(t0, *(uint8_t *)(t1 + t2));
+            tci_write_reg8(regs, t0, *(uint8_t *)(t1 + t2));
             break;
         case INDEX_op_ld8s_i64:
         case INDEX_op_ld16u_i64:
@@ -850,43 +856,43 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
             break;
         case INDEX_op_ld32u_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_r(&tb_ptr);
+            t1 = tci_read_r(regs, &tb_ptr);
             t2 = tci_read_s32(&tb_ptr);
-            tci_write_reg32(t0, *(uint32_t *)(t1 + t2));
+            tci_write_reg32(regs, t0, *(uint32_t *)(t1 + t2));
             break;
         case INDEX_op_ld32s_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_r(&tb_ptr);
+            t1 = tci_read_r(regs, &tb_ptr);
             t2 = tci_read_s32(&tb_ptr);
-            tci_write_reg32s(t0, *(int32_t *)(t1 + t2));
+            tci_write_reg32s(regs, t0, *(int32_t *)(t1 + t2));
             break;
         case INDEX_op_ld_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_r(&tb_ptr);
+            t1 = tci_read_r(regs, &tb_ptr);
             t2 = tci_read_s32(&tb_ptr);
-            tci_write_reg64(t0, *(uint64_t *)(t1 + t2));
+            tci_write_reg64(regs, t0, *(uint64_t *)(t1 + t2));
             break;
         case INDEX_op_st8_i64:
-            t0 = tci_read_r8(&tb_ptr);
-            t1 = tci_read_r(&tb_ptr);
+            t0 = tci_read_r8(regs, &tb_ptr);
+            t1 = tci_read_r(regs, &tb_ptr);
             t2 = tci_read_s32(&tb_ptr);
             *(uint8_t *)(t1 + t2) = t0;
             break;
         case INDEX_op_st16_i64:
-            t0 = tci_read_r16(&tb_ptr);
-            t1 = tci_read_r(&tb_ptr);
+            t0 = tci_read_r16(regs, &tb_ptr);
+            t1 = tci_read_r(regs, &tb_ptr);
             t2 = tci_read_s32(&tb_ptr);
             *(uint16_t *)(t1 + t2) = t0;
             break;
         case INDEX_op_st32_i64:
-            t0 = tci_read_r32(&tb_ptr);
-            t1 = tci_read_r(&tb_ptr);
+            t0 = tci_read_r32(regs, &tb_ptr);
+            t1 = tci_read_r(regs, &tb_ptr);
             t2 = tci_read_s32(&tb_ptr);
             *(uint32_t *)(t1 + t2) = t0;
             break;
         case INDEX_op_st_i64:
-            t0 = tci_read_r64(&tb_ptr);
-            t1 = tci_read_r(&tb_ptr);
+            t0 = tci_read_r64(regs, &tb_ptr);
+            t1 = tci_read_r(regs, &tb_ptr);
             t2 = tci_read_s32(&tb_ptr);
             tci_assert(t1 != sp_value || (int32_t)t2 < 0);
             *(uint64_t *)(t1 + t2) = t0;
@@ -896,21 +902,21 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
 
         case INDEX_op_add_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_ri64(&tb_ptr);
-            t2 = tci_read_ri64(&tb_ptr);
-            tci_write_reg64(t0, t1 + t2);
+            t1 = tci_read_ri64(regs, &tb_ptr);
+            t2 = tci_read_ri64(regs, &tb_ptr);
+            tci_write_reg64(regs, t0, t1 + t2);
             break;
         case INDEX_op_sub_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_ri64(&tb_ptr);
-            t2 = tci_read_ri64(&tb_ptr);
-            tci_write_reg64(t0, t1 - t2);
+            t1 = tci_read_ri64(regs, &tb_ptr);
+            t2 = tci_read_ri64(regs, &tb_ptr);
+            tci_write_reg64(regs, t0, t1 - t2);
             break;
         case INDEX_op_mul_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_ri64(&tb_ptr);
-            t2 = tci_read_ri64(&tb_ptr);
-            tci_write_reg64(t0, t1 * t2);
+            t1 = tci_read_ri64(regs, &tb_ptr);
+            t2 = tci_read_ri64(regs, &tb_ptr);
+            tci_write_reg64(regs, t0, t1 * t2);
             break;
 #if TCG_TARGET_HAS_div_i64
         case INDEX_op_div_i64:
@@ -927,71 +933,71 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
 #endif
         case INDEX_op_and_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_ri64(&tb_ptr);
-            t2 = tci_read_ri64(&tb_ptr);
-            tci_write_reg64(t0, t1 & t2);
+            t1 = tci_read_ri64(regs, &tb_ptr);
+            t2 = tci_read_ri64(regs, &tb_ptr);
+            tci_write_reg64(regs, t0, t1 & t2);
             break;
         case INDEX_op_or_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_ri64(&tb_ptr);
-            t2 = tci_read_ri64(&tb_ptr);
-            tci_write_reg64(t0, t1 | t2);
+            t1 = tci_read_ri64(regs, &tb_ptr);
+            t2 = tci_read_ri64(regs, &tb_ptr);
+            tci_write_reg64(regs, t0, t1 | t2);
             break;
         case INDEX_op_xor_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_ri64(&tb_ptr);
-            t2 = tci_read_ri64(&tb_ptr);
-            tci_write_reg64(t0, t1 ^ t2);
+            t1 = tci_read_ri64(regs, &tb_ptr);
+            t2 = tci_read_ri64(regs, &tb_ptr);
+            tci_write_reg64(regs, t0, t1 ^ t2);
             break;
 
             /* Shift/rotate operations (64 bit). */
 
         case INDEX_op_shl_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_ri64(&tb_ptr);
-            t2 = tci_read_ri64(&tb_ptr);
-            tci_write_reg64(t0, t1 << (t2 & 63));
+            t1 = tci_read_ri64(regs, &tb_ptr);
+            t2 = tci_read_ri64(regs, &tb_ptr);
+            tci_write_reg64(regs, t0, t1 << (t2 & 63));
             break;
         case INDEX_op_shr_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_ri64(&tb_ptr);
-            t2 = tci_read_ri64(&tb_ptr);
-            tci_write_reg64(t0, t1 >> (t2 & 63));
+            t1 = tci_read_ri64(regs, &tb_ptr);
+            t2 = tci_read_ri64(regs, &tb_ptr);
+            tci_write_reg64(regs, t0, t1 >> (t2 & 63));
             break;
         case INDEX_op_sar_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_ri64(&tb_ptr);
-            t2 = tci_read_ri64(&tb_ptr);
-            tci_write_reg64(t0, ((int64_t)t1 >> (t2 & 63)));
+            t1 = tci_read_ri64(regs, &tb_ptr);
+            t2 = tci_read_ri64(regs, &tb_ptr);
+            tci_write_reg64(regs, t0, ((int64_t)t1 >> (t2 & 63)));
             break;
 #if TCG_TARGET_HAS_rot_i64
         case INDEX_op_rotl_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_ri64(&tb_ptr);
-            t2 = tci_read_ri64(&tb_ptr);
-            tci_write_reg64(t0, rol64(t1, t2 & 63));
+            t1 = tci_read_ri64(regs, &tb_ptr);
+            t2 = tci_read_ri64(regs, &tb_ptr);
+            tci_write_reg64(regs, t0, rol64(t1, t2 & 63));
             break;
         case INDEX_op_rotr_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_ri64(&tb_ptr);
-            t2 = tci_read_ri64(&tb_ptr);
-            tci_write_reg64(t0, ror64(t1, t2 & 63));
+            t1 = tci_read_ri64(regs, &tb_ptr);
+            t2 = tci_read_ri64(regs, &tb_ptr);
+            tci_write_reg64(regs, t0, ror64(t1, t2 & 63));
             break;
 #endif
 #if TCG_TARGET_HAS_deposit_i64
         case INDEX_op_deposit_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_r64(&tb_ptr);
-            t2 = tci_read_r64(&tb_ptr);
+            t1 = tci_read_r64(regs, &tb_ptr);
+            t2 = tci_read_r64(regs, &tb_ptr);
             tmp16 = *tb_ptr++;
             tmp8 = *tb_ptr++;
             tmp64 = (((1ULL << tmp8) - 1) << tmp16);
-            tci_write_reg64(t0, (t1 & ~tmp64) | ((t2 << tmp16) & tmp64));
+            tci_write_reg64(regs, t0, (t1 & ~tmp64) | ((t2 << tmp16) & tmp64));
             break;
 #endif
         case INDEX_op_brcond_i64:
-            t0 = tci_read_r64(&tb_ptr);
-            t1 = tci_read_ri64(&tb_ptr);
+            t0 = tci_read_r64(regs, &tb_ptr);
+            t1 = tci_read_ri64(regs, &tb_ptr);
             condition = *tb_ptr++;
             label = tci_read_label(&tb_ptr);
             if (tci_compare64(t0, t1, condition)) {
@@ -1003,29 +1009,29 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
 #if TCG_TARGET_HAS_ext8u_i64
         case INDEX_op_ext8u_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_r8(&tb_ptr);
-            tci_write_reg64(t0, t1);
+            t1 = tci_read_r8(regs, &tb_ptr);
+            tci_write_reg64(regs, t0, t1);
             break;
 #endif
 #if TCG_TARGET_HAS_ext8s_i64
         case INDEX_op_ext8s_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_r8s(&tb_ptr);
-            tci_write_reg64(t0, t1);
+            t1 = tci_read_r8s(regs, &tb_ptr);
+            tci_write_reg64(regs, t0, t1);
             break;
 #endif
 #if TCG_TARGET_HAS_ext16s_i64
         case INDEX_op_ext16s_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_r16s(&tb_ptr);
-            tci_write_reg64(t0, t1);
+            t1 = tci_read_r16s(regs, &tb_ptr);
+            tci_write_reg64(regs, t0, t1);
             break;
 #endif
 #if TCG_TARGET_HAS_ext16u_i64
         case INDEX_op_ext16u_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_r16(&tb_ptr);
-            tci_write_reg64(t0, t1);
+            t1 = tci_read_r16(regs, &tb_ptr);
+            tci_write_reg64(regs, t0, t1);
             break;
 #endif
 #if TCG_TARGET_HAS_ext32s_i64
@@ -1033,51 +1039,51 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
 #endif
         case INDEX_op_ext_i32_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_r32s(&tb_ptr);
-            tci_write_reg64(t0, t1);
+            t1 = tci_read_r32s(regs, &tb_ptr);
+            tci_write_reg64(regs, t0, t1);
             break;
 #if TCG_TARGET_HAS_ext32u_i64
         case INDEX_op_ext32u_i64:
 #endif
         case INDEX_op_extu_i32_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_r32(&tb_ptr);
-            tci_write_reg64(t0, t1);
+            t1 = tci_read_r32(regs, &tb_ptr);
+            tci_write_reg64(regs, t0, t1);
             break;
 #if TCG_TARGET_HAS_bswap16_i64
         case INDEX_op_bswap16_i64:
             TODO();
             t0 = *tb_ptr++;
-            t1 = tci_read_r16(&tb_ptr);
-            tci_write_reg64(t0, bswap16(t1));
+            t1 = tci_read_r16(regs, &tb_ptr);
+            tci_write_reg64(regs, t0, bswap16(t1));
             break;
 #endif
 #if TCG_TARGET_HAS_bswap32_i64
         case INDEX_op_bswap32_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_r32(&tb_ptr);
-            tci_write_reg64(t0, bswap32(t1));
+            t1 = tci_read_r32(regs, &tb_ptr);
+            tci_write_reg64(regs, t0, bswap32(t1));
             break;
 #endif
 #if TCG_TARGET_HAS_bswap64_i64
         case INDEX_op_bswap64_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_r64(&tb_ptr);
-            tci_write_reg64(t0, bswap64(t1));
+            t1 = tci_read_r64(regs, &tb_ptr);
+            tci_write_reg64(regs, t0, bswap64(t1));
             break;
 #endif
 #if TCG_TARGET_HAS_not_i64
         case INDEX_op_not_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_r64(&tb_ptr);
-            tci_write_reg64(t0, ~t1);
+            t1 = tci_read_r64(regs, &tb_ptr);
+            tci_write_reg64(regs, t0, ~t1);
             break;
 #endif
 #if TCG_TARGET_HAS_neg_i64
         case INDEX_op_neg_i64:
             t0 = *tb_ptr++;
-            t1 = tci_read_r64(&tb_ptr);
-            tci_write_reg64(t0, -t1);
+            t1 = tci_read_r64(regs, &tb_ptr);
+            tci_write_reg64(regs, t0, -t1);
             break;
 #endif
 #endif /* TCG_TARGET_REG_BITS == 64 */
@@ -1098,7 +1104,7 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
             continue;
         case INDEX_op_qemu_ld_i32:
             t0 = *tb_ptr++;
-            taddr = tci_read_ulong(&tb_ptr);
+            taddr = tci_read_ulong(regs, &tb_ptr);
             oi = tci_read_i(&tb_ptr);
             switch (get_memop(oi) & (MO_BSWAP | MO_SSIZE)) {
             case MO_UB:
@@ -1128,14 +1134,14 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
             default:
                 tcg_abort();
             }
-            tci_write_reg(t0, tmp32);
+            tci_write_reg(regs, t0, tmp32);
             break;
         case INDEX_op_qemu_ld_i64:
             t0 = *tb_ptr++;
             if (TCG_TARGET_REG_BITS == 32) {
                 t1 = *tb_ptr++;
             }
-            taddr = tci_read_ulong(&tb_ptr);
+            taddr = tci_read_ulong(regs, &tb_ptr);
             oi = tci_read_i(&tb_ptr);
             switch (get_memop(oi) & (MO_BSWAP | MO_SSIZE)) {
             case MO_UB:
@@ -1177,14 +1183,14 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
             default:
                 tcg_abort();
             }
-            tci_write_reg(t0, tmp64);
+            tci_write_reg(regs, t0, tmp64);
             if (TCG_TARGET_REG_BITS == 32) {
-                tci_write_reg(t1, tmp64 >> 32);
+                tci_write_reg(regs, t1, tmp64 >> 32);
             }
             break;
         case INDEX_op_qemu_st_i32:
-            t0 = tci_read_r(&tb_ptr);
-            taddr = tci_read_ulong(&tb_ptr);
+            t0 = tci_read_r(regs, &tb_ptr);
+            taddr = tci_read_ulong(regs, &tb_ptr);
             oi = tci_read_i(&tb_ptr);
             switch (get_memop(oi) & (MO_BSWAP | MO_SIZE)) {
             case MO_UB:
@@ -1207,8 +1213,8 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
             }
             break;
         case INDEX_op_qemu_st_i64:
-            tmp64 = tci_read_r64(&tb_ptr);
-            taddr = tci_read_ulong(&tb_ptr);
+            tmp64 = tci_read_r64(regs, &tb_ptr);
+            taddr = tci_read_ulong(regs, &tb_ptr);
             oi = tci_read_i(&tb_ptr);
             switch (get_memop(oi) & (MO_BSWAP | MO_SIZE)) {
             case MO_UB:
-- 
2.7.4
