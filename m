Received: from eggs.gnu.org ([2001:4830:134:3::10]:43907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCij-00080S-Pr
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCig-0003BO-9c
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:13 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gQCig-00039W-0i
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:10 -0500
Received: by mail-wm1-x341.google.com with SMTP id s11so12262538wmh.1
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 06:46:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 23 Nov 2018 15:45:29 +0100
Message-Id: <20181123144558.5048-9-richard.henderson@linaro.org>
In-Reply-To: <20181123144558.5048-1-richard.henderson@linaro.org>
References: <20181123144558.5048-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 v2 08/37] tcg/i386: Force qemu_ld/st
 arguments into fixed registers
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

This is an incremental step toward moving the qemu_ld/st
code sequence out of line.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 203 +++++++++++++++++++++++++++++++-------
 1 file changed, 169 insertions(+), 34 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 07df4b2b12..50e5dc31b3 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -171,6 +171,80 @@ static bool have_lzcnt;
 
 static tcg_insn_unit *tb_ret_addr;
 
+typedef enum {
+    ARG_ADDR,
+    ARG_STVAL,
+    ARG_LDVAL,
+} QemuMemArgType;
+
+#ifdef CONFIG_SOFTMMU
+/*
+ * Constraint to choose a particular register.  This is used for softmmu
+ * loads and stores.  Registers with no assignment get an empty string.
+ */
+static const char * const one_reg_constraint[TCG_TARGET_NB_REGS] = {
+    [TCG_REG_EAX] = "a",
+    [TCG_REG_EBX] = "b",
+    [TCG_REG_ECX] = "c",
+    [TCG_REG_EDX] = "d",
+    [TCG_REG_ESI] = "S",
+    [TCG_REG_EDI] = "D",
+#if TCG_TARGET_REG_BITS == 64
+    [TCG_REG_R8]  = "E",
+    [TCG_REG_R9]  = "N",
+#endif
+};
+
+/*
+ * Calling convention for the softmmu load and store thunks.
+ *
+ * For 64-bit, we mostly use the host calling convention, therefore the
+ * real first argument is reserved for the ENV parameter that is passed
+ * on to the slow path helpers.
+ *
+ * For 32-bit, the host calling convention is stack based; we invent a
+ * private convention that uses 4 of the 6 available host registers.
+ * We reserve EAX and EDX as temporaries for use by the thunk, we require
+ * INDEX_op_qemu_st_i32 to have a 'q' register from which to store, and
+ * further complicate this last by wanting a call-clobbered for that store.
+ * The 'q' requirement allows MO_8 stores at all; the call-clobbered part
+ * allows bswap to operate in-place, clobbering the input.
+ */
+static TCGReg softmmu_arg(QemuMemArgType type, bool is_64, int hi)
+{
+    switch (type) {
+    case ARG_ADDR:
+        tcg_debug_assert(!hi || TARGET_LONG_BITS > TCG_TARGET_REG_BITS);
+        if (TCG_TARGET_REG_BITS == 64) {
+            return tcg_target_call_iarg_regs[1];
+        } else {
+            return hi ? TCG_REG_EDI : TCG_REG_ESI;
+        }
+    case ARG_STVAL:
+        tcg_debug_assert(!hi || (TCG_TARGET_REG_BITS == 32 && is_64));
+        if (TCG_TARGET_REG_BITS == 64) {
+            return tcg_target_call_iarg_regs[2];
+        } else {
+            return hi ? TCG_REG_EBX : TCG_REG_ECX;
+        }
+    case ARG_LDVAL:
+        tcg_debug_assert(!hi || (TCG_TARGET_REG_BITS == 32 && is_64));
+        return tcg_target_call_oarg_regs[hi];
+    }
+    g_assert_not_reached();
+}
+
+static const char *constrain_memop_arg(QemuMemArgType type, bool is_64, int hi)
+{
+    return one_reg_constraint[softmmu_arg(type, is_64, hi)];
+}
+#else
+static const char *constrain_memop_arg(QemuMemArgType type, bool is_64, int hi)
+{
+    return "L";
+}
+#endif /* CONFIG_SOFTMMU */
+
 static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
@@ -1680,11 +1754,15 @@ static TCGReg tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
        copies the entire guest address for the slow path, while truncation
        for the 32-bit host happens with the fastpath ADDL below.  */
     if (TCG_TARGET_REG_BITS == 64) {
-        base = tcg_target_call_iarg_regs[1];
+        tcg_debug_assert(addrlo == tcg_target_call_iarg_regs[1]);
+        if (TARGET_LONG_BITS == 32) {
+            tcg_out_ext32u(s, addrlo, addrlo);
+        }
+        base = addrlo;
     } else {
         base = r1;
+        tcg_out_mov(s, ttype, base, addrlo);
     }
-    tcg_out_mov(s, ttype, base, addrlo);
 
     /* jne slow_path */
     tcg_out_opc(s, OPC_JCC_long + JCC_JNE, 0, 0, 0);
@@ -2009,16 +2087,22 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
    common. */
 static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is64)
 {
-    TCGReg datalo, datahi, addrlo;
-    TCGReg addrhi __attribute__((unused));
+    TCGReg datalo, addrlo;
+    TCGReg datahi __attribute__((unused)) = -1;
+    TCGReg addrhi __attribute__((unused)) = -1;
     TCGMemOpIdx oi;
     TCGMemOp opc;
+    int i = -1;
 
-    datalo = *args++;
-    datahi = (TCG_TARGET_REG_BITS == 32 && is64 ? *args++ : 0);
-    addrlo = *args++;
-    addrhi = (TARGET_LONG_BITS > TCG_TARGET_REG_BITS ? *args++ : 0);
-    oi = *args++;
+    datalo = args[++i];
+    if (TCG_TARGET_REG_BITS == 32 && is64) {
+        datahi = args[++i];
+    }
+    addrlo = args[++i];
+    if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
+        addrhi = args[++i];
+    }
+    oi = args[++i];
     opc = get_memop(oi);
 
 #if defined(CONFIG_SOFTMMU)
@@ -2027,6 +2111,15 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is64)
         tcg_insn_unit *label_ptr[2];
         TCGReg base;
 
+        tcg_debug_assert(datalo == softmmu_arg(ARG_LDVAL, is64, 0));
+        if (TCG_TARGET_REG_BITS == 32 && is64) {
+            tcg_debug_assert(datahi == softmmu_arg(ARG_LDVAL, is64, 1));
+        }
+        tcg_debug_assert(addrlo == softmmu_arg(ARG_ADDR, 0, 0));
+        if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
+            tcg_debug_assert(addrhi == softmmu_arg(ARG_ADDR, 0, 1));
+        }
+
         base = tcg_out_tlb_load(s, addrlo, addrhi, mem_index, opc,
                                 label_ptr, offsetof(CPUTLBEntry, addr_read));
 
@@ -2149,16 +2242,22 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
 
 static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
 {
-    TCGReg datalo, datahi, addrlo;
-    TCGReg addrhi __attribute__((unused));
+    TCGReg datalo, addrlo;
+    TCGReg datahi __attribute__((unused)) = -1;
+    TCGReg addrhi __attribute__((unused)) = -1;
     TCGMemOpIdx oi;
     TCGMemOp opc;
+    int i = -1;
 
-    datalo = *args++;
-    datahi = (TCG_TARGET_REG_BITS == 32 && is64 ? *args++ : 0);
-    addrlo = *args++;
-    addrhi = (TARGET_LONG_BITS > TCG_TARGET_REG_BITS ? *args++ : 0);
-    oi = *args++;
+    datalo = args[++i];
+    if (TCG_TARGET_REG_BITS == 32 && is64) {
+        datahi = args[++i];
+    }
+    addrlo = args[++i];
+    if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
+        addrhi = args[++i];
+    }
+    oi = args[++i];
     opc = get_memop(oi);
 
 #if defined(CONFIG_SOFTMMU)
@@ -2167,6 +2266,15 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
         tcg_insn_unit *label_ptr[2];
         TCGReg base;
 
+        tcg_debug_assert(datalo == softmmu_arg(ARG_STVAL, is64, 0));
+        if (TCG_TARGET_REG_BITS == 32 && is64) {
+            tcg_debug_assert(datahi == softmmu_arg(ARG_STVAL, is64, 1));
+        }
+        tcg_debug_assert(addrlo == softmmu_arg(ARG_ADDR, 0, 0));
+        if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
+            tcg_debug_assert(addrhi == softmmu_arg(ARG_ADDR, 0, 1));
+        }
+
         base = tcg_out_tlb_load(s, addrlo, addrhi, mem_index, opc,
                                 label_ptr, offsetof(CPUTLBEntry, addr_write));
 
@@ -2836,15 +2944,6 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     static const TCGTargetOpDef r_r_re = { .args_ct_str = { "r", "r", "re" } };
     static const TCGTargetOpDef r_0_re = { .args_ct_str = { "r", "0", "re" } };
     static const TCGTargetOpDef r_0_ci = { .args_ct_str = { "r", "0", "ci" } };
-    static const TCGTargetOpDef r_L = { .args_ct_str = { "r", "L" } };
-    static const TCGTargetOpDef L_L = { .args_ct_str = { "L", "L" } };
-    static const TCGTargetOpDef r_L_L = { .args_ct_str = { "r", "L", "L" } };
-    static const TCGTargetOpDef r_r_L = { .args_ct_str = { "r", "r", "L" } };
-    static const TCGTargetOpDef L_L_L = { .args_ct_str = { "L", "L", "L" } };
-    static const TCGTargetOpDef r_r_L_L
-        = { .args_ct_str = { "r", "r", "L", "L" } };
-    static const TCGTargetOpDef L_L_L_L
-        = { .args_ct_str = { "L", "L", "L", "L" } };
     static const TCGTargetOpDef x_x = { .args_ct_str = { "x", "x" } };
     static const TCGTargetOpDef x_x_x = { .args_ct_str = { "x", "x", "x" } };
     static const TCGTargetOpDef x_x_x_x
@@ -3026,17 +3125,53 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         }
 
     case INDEX_op_qemu_ld_i32:
-        return TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &r_L : &r_L_L;
-    case INDEX_op_qemu_st_i32:
-        return TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &L_L : &L_L_L;
+        {
+            static TCGTargetOpDef ld32;
+            int i;
+
+            ld32.args_ct_str[0] = constrain_memop_arg(ARG_LDVAL, 0, 0);
+            for (i = 0; i * TCG_TARGET_REG_BITS < TARGET_LONG_BITS; ++i) {
+                ld32.args_ct_str[i + 1] = constrain_memop_arg(ARG_ADDR, 0, i);
+            }
+            return &ld32;
+        }
     case INDEX_op_qemu_ld_i64:
-        return (TCG_TARGET_REG_BITS == 64 ? &r_L
-                : TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &r_r_L
-                : &r_r_L_L);
+        {
+            static TCGTargetOpDef ld64;
+            int i, j = 0;
+
+            for (i = 0; i * TCG_TARGET_REG_BITS < 64; ++i) {
+                ld64.args_ct_str[j++] = constrain_memop_arg(ARG_LDVAL, 1, i);
+            }
+            for (i = 0; i * TCG_TARGET_REG_BITS < TARGET_LONG_BITS; ++i) {
+                ld64.args_ct_str[j++] = constrain_memop_arg(ARG_ADDR, 0, i);
+            }
+            return &ld64;
+        }
+    case INDEX_op_qemu_st_i32:
+        {
+            static TCGTargetOpDef st32;
+            int i;
+
+            st32.args_ct_str[0] = constrain_memop_arg(ARG_STVAL, 0, 0);
+            for (i = 0; i * TCG_TARGET_REG_BITS < TARGET_LONG_BITS; ++i) {
+                st32.args_ct_str[i + 1] = constrain_memop_arg(ARG_ADDR, 0, i);
+            }
+            return &st32;
+        }
     case INDEX_op_qemu_st_i64:
-        return (TCG_TARGET_REG_BITS == 64 ? &L_L
-                : TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &L_L_L
-                : &L_L_L_L);
+        {
+            static TCGTargetOpDef st64;
+            int i, j = 0;
+
+            for (i = 0; i * TCG_TARGET_REG_BITS < 64; ++i) {
+                st64.args_ct_str[j++] = constrain_memop_arg(ARG_STVAL, 1, i);
+            }
+            for (i = 0; i * TCG_TARGET_REG_BITS < TARGET_LONG_BITS; ++i) {
+                st64.args_ct_str[j++] = constrain_memop_arg(ARG_ADDR, 0, i);
+            }
+            return &st64;
+        }
 
     case INDEX_op_brcond2_i32:
         {
-- 
2.17.2
