Received: from eggs.gnu.org ([2001:4830:134:3::10]:54088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK37-0003Ut-RH
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK36-0004wz-7o
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:13 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:51425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gMK35-0004wd-Uh
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:12 -0500
Received: by mail-wm1-x32f.google.com with SMTP id w7-v6so9934060wmc.1
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 13:47:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 12 Nov 2018 22:44:50 +0100
Message-Id: <20181112214503.22941-5-richard.henderson@linaro.org>
In-Reply-To: <20181112214503.22941-1-richard.henderson@linaro.org>
References: <20181112214503.22941-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 04/17] tcg/i386: Force qemu_ld/st
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
Cc: cota@braap.org

This is an incremental step toward moving the qemu_ld/st
code sequence out of line.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 193 +++++++++++++++++++++++++++++++-------
 1 file changed, 159 insertions(+), 34 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 2a96ca4274..8a3e7690b6 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -171,6 +171,56 @@ static bool have_lzcnt;
 
 static tcg_insn_unit *tb_ret_addr;
 
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
+ * private convention that uses 4 of the 6 available host registers, and
+ * we reserve EAX and EDX as temporaries for use by the thunk.
+ */
+static inline TCGReg softmmu_arg(unsigned n)
+{
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_debug_assert(n < ARRAY_SIZE(tcg_target_call_iarg_regs) - 1);
+        return tcg_target_call_iarg_regs[n + 1];
+    } else {
+        static const TCGReg local_order[] = {
+            TCG_REG_ESI, TCG_REG_EDI, TCG_REG_ECX, TCG_REG_EBX
+        };
+        tcg_debug_assert(n < ARRAY_SIZE(local_order));
+        return local_order[n];
+    }
+}
+
+#define qemu_memop_arg(N)          one_reg_constraint[softmmu_arg(N)]
+#define qemu_memop_ret(N)          (N ? "d" : "a")
+#else
+#define qemu_memop_arg(N)          "L"
+#define qemu_memop_ret(N)          "L"
+#endif /* CONFIG_SOFTMMU */
+
 static void patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
@@ -1677,11 +1727,15 @@ static TCGReg tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
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
@@ -2006,16 +2060,22 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
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
@@ -2024,6 +2084,15 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is64)
         tcg_insn_unit *label_ptr[2];
         TCGReg base;
 
+        tcg_debug_assert(datalo == tcg_target_call_oarg_regs[0]);
+        if (TCG_TARGET_REG_BITS == 32 && is64) {
+            tcg_debug_assert(datahi == tcg_target_call_oarg_regs[1]);
+        }
+        tcg_debug_assert(addrlo == softmmu_arg(0));
+        if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
+            tcg_debug_assert(addrhi == softmmu_arg(1));
+        }
+
         base = tcg_out_tlb_load(s, addrlo, addrhi, mem_index, opc,
                                 label_ptr, offsetof(CPUTLBEntry, addr_read));
 
@@ -2146,16 +2215,22 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
 
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
@@ -2164,6 +2239,16 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
         tcg_insn_unit *label_ptr[2];
         TCGReg base;
 
+        i = -1;
+        tcg_debug_assert(addrlo == softmmu_arg(++i));
+        if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
+            tcg_debug_assert(addrhi == softmmu_arg(++i));
+        }
+        tcg_debug_assert(datalo == softmmu_arg(++i));
+        if (TCG_TARGET_REG_BITS == 32 && is64) {
+            tcg_debug_assert(datahi == softmmu_arg(++i));
+        }
+
         base = tcg_out_tlb_load(s, addrlo, addrhi, mem_index, opc,
                                 label_ptr, offsetof(CPUTLBEntry, addr_write));
 
@@ -2833,15 +2918,6 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
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
@@ -3023,17 +3099,66 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         }
 
     case INDEX_op_qemu_ld_i32:
-        return TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &r_L : &r_L_L;
-    case INDEX_op_qemu_st_i32:
-        return TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &L_L : &L_L_L;
+        {
+            static TCGTargetOpDef ld32;
+            ld32.args_ct_str[0] = qemu_memop_ret(0);
+            ld32.args_ct_str[1] = qemu_memop_arg(0);
+            if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
+                ld32.args_ct_str[2] = qemu_memop_arg(1);
+            }
+            return &ld32;
+        }
     case INDEX_op_qemu_ld_i64:
-        return (TCG_TARGET_REG_BITS == 64 ? &r_L
-                : TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &r_r_L
-                : &r_r_L_L);
+        {
+            static TCGTargetOpDef ld64;
+            if (TCG_TARGET_REG_BITS == 64) {
+                ld64.args_ct_str[0] = qemu_memop_ret(0);
+                ld64.args_ct_str[1] = qemu_memop_arg(0);
+            } else if (TARGET_LONG_BITS <= TCG_TARGET_REG_BITS) {
+                ld64.args_ct_str[0] = qemu_memop_ret(0);
+                ld64.args_ct_str[1] = qemu_memop_ret(1);
+                ld64.args_ct_str[2] = qemu_memop_arg(0);
+            } else {
+                ld64.args_ct_str[0] = qemu_memop_ret(0);
+                ld64.args_ct_str[1] = qemu_memop_ret(1);
+                ld64.args_ct_str[2] = qemu_memop_arg(0);
+                ld64.args_ct_str[3] = qemu_memop_arg(1);
+            }
+            return &ld64;
+        }
+
+    /* Recall the store value comes before addr in the opcode args
+       and after addr in helper args.  */
+    case INDEX_op_qemu_st_i32:
+        {
+            static TCGTargetOpDef st32;
+            st32.args_ct_str[1] = qemu_memop_arg(0);
+            if (TARGET_LONG_BITS <= TCG_TARGET_REG_BITS) {
+                st32.args_ct_str[0] = qemu_memop_arg(1);
+            } else {
+                st32.args_ct_str[2] = qemu_memop_arg(1);
+                st32.args_ct_str[0] = qemu_memop_arg(2);
+            }
+            return &st32;
+        }
     case INDEX_op_qemu_st_i64:
-        return (TCG_TARGET_REG_BITS == 64 ? &L_L
-                : TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &L_L_L
-                : &L_L_L_L);
+        {
+            static TCGTargetOpDef st64;
+            if (TCG_TARGET_REG_BITS == 64) {
+                st64.args_ct_str[1] = qemu_memop_arg(0);
+                st64.args_ct_str[0] = qemu_memop_arg(1);
+            } else if (TARGET_LONG_BITS <= TCG_TARGET_REG_BITS) {
+                st64.args_ct_str[2] = qemu_memop_arg(0);
+                st64.args_ct_str[0] = qemu_memop_arg(1);
+                st64.args_ct_str[1] = qemu_memop_arg(2);
+            } else {
+                st64.args_ct_str[2] = qemu_memop_arg(0);
+                st64.args_ct_str[3] = qemu_memop_arg(1);
+                st64.args_ct_str[0] = qemu_memop_arg(2);
+                st64.args_ct_str[1] = qemu_memop_arg(3);
+            }
+            return &st64;
+        }
 
     case INDEX_op_brcond2_i32:
         {
-- 
2.17.2
