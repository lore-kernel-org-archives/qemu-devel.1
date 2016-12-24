Received: from eggs.gnu.org ([2001:4830:134:3::10]:55375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdW5-0006hD-08
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdW3-0005da-5I
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:05 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdW2-0005dI-S1
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:03 -0500
Received: by mail-pg0-x241.google.com with SMTP id g1so2479238pgn.0
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:01:02 -0800 (PST)
Received: from bigtime.domain ([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	n25sm65339316pfi.33.2016.12.23.20.01.01 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Dec 2016 20:01:01 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 19:59:58 -0800
Message-Id: <20161224040042.12654-22-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 21/65] tcg: Transition flat op_defs array to a
 target callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This will allow the target to tailor the constraints to the
auto-detected ISA extensions.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/aarch64/tcg-target.inc.c | 14 ++++++--
 tcg/arm/tcg-target.inc.c     | 14 ++++++--
 tcg/i386/tcg-target.inc.c    | 14 ++++++--
 tcg/ia64/tcg-target.inc.c    | 14 ++++++--
 tcg/mips/tcg-target.inc.c    | 14 ++++++--
 tcg/ppc/tcg-target.inc.c     | 14 ++++++--
 tcg/s390/tcg-target.inc.c    | 14 ++++++--
 tcg/sparc/tcg-target.inc.c   | 14 ++++++--
 tcg/tcg.c                    | 86 +++++++++++++++-----------------------------
 tcg/tcg.h                    |  2 --
 tcg/tci/tcg-target.inc.c     | 13 ++++++-
 11 files changed, 136 insertions(+), 77 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index c0e9890..416db45 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -1812,6 +1812,18 @@ static const TCGTargetOpDef aarch64_op_defs[] = {
     { -1 },
 };
 
+static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
+{
+    int i, n = ARRAY_SIZE(aarch64_op_defs);
+
+    for (i = 0; i < n; ++i) {
+        if (aarch64_op_defs[i].op == op) {
+            return &aarch64_op_defs[i];
+        }
+    }
+    return NULL;
+}
+
 static void tcg_target_init(TCGContext *s)
 {
     tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_I32], 0, 0xffffffff);
@@ -1834,8 +1846,6 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_FP);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_X18); /* platform register */
-
-    tcg_add_target_add_op_defs(aarch64_op_defs);
 }
 
 /* Saving pairs: (X19, X20) .. (X27, X28), (X29(fp), X30(lr)).  */
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 2d5af0f..eeabcf8 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -2008,6 +2008,18 @@ static const TCGTargetOpDef arm_op_defs[] = {
     { -1 },
 };
 
+static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
+{
+    int i, n = ARRAY_SIZE(arm_op_defs);
+
+    for (i = 0; i < n; ++i) {
+        if (arm_op_defs[i].op == op) {
+            return &arm_op_defs[i];
+        }
+    }
+    return NULL;
+}
+
 static void tcg_target_init(TCGContext *s)
 {
     /* Only probe for the platform and capabilities if we havn't already
@@ -2038,8 +2050,6 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_CALL_STACK);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_PC);
-
-    tcg_add_target_add_op_defs(arm_op_defs);
 }
 
 static inline void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 39f62bd..595c399 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -2330,6 +2330,18 @@ static const TCGTargetOpDef x86_op_defs[] = {
     { -1 },
 };
 
+static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
+{
+    int i, n = ARRAY_SIZE(x86_op_defs);
+
+    for (i = 0; i < n; ++i) {
+        if (x86_op_defs[i].op == op) {
+            return &x86_op_defs[i];
+        }
+    }
+    return NULL;
+}
+
 static int tcg_target_callee_save_regs[] = {
 #if TCG_TARGET_REG_BITS == 64
     TCG_REG_RBP,
@@ -2471,8 +2483,6 @@ static void tcg_target_init(TCGContext *s)
 
     tcg_regset_clear(s->reserved_regs);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_CALL_STACK);
-
-    tcg_add_target_add_op_defs(x86_op_defs);
 }
 
 typedef struct {
diff --git a/tcg/ia64/tcg-target.inc.c b/tcg/ia64/tcg-target.inc.c
index b04d716..e4d419d 100644
--- a/tcg/ia64/tcg-target.inc.c
+++ b/tcg/ia64/tcg-target.inc.c
@@ -2352,6 +2352,18 @@ static const TCGTargetOpDef ia64_op_defs[] = {
     { -1 },
 };
 
+static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
+{
+    int i, n = ARRAY_SIZE(ia64_op_defs);
+
+    for (i = 0; i < n; ++i) {
+        if (ia64_op_defs[i].op == op) {
+            return &ia64_op_defs[i];
+        }
+    }
+    return NULL;
+}
+
 /* Generate global QEMU prologue and epilogue code */
 static void tcg_target_qemu_prologue(TCGContext *s)
 {
@@ -2471,6 +2483,4 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_R5);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_R6);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_R7);
-
-    tcg_add_target_add_op_defs(ia64_op_defs);
 }
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 1ecae08..7758b6d 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -1770,6 +1770,18 @@ static const TCGTargetOpDef mips_op_defs[] = {
     { -1 },
 };
 
+static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
+{
+    int i, n = ARRAY_SIZE(mips_op_defs);
+
+    for (i = 0; i < n; ++i) {
+        if (mips_op_defs[i].op == op) {
+            return &mips_op_defs[i];
+        }
+    }
+    return NULL;
+}
+
 static int tcg_target_callee_save_regs[] = {
     TCG_REG_S0,       /* used for the global env (TCG_AREG0) */
     TCG_REG_S1,
@@ -1930,8 +1942,6 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_RA);   /* return address */
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_SP);   /* stack pointer */
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_GP);   /* global pointer */
-
-    tcg_add_target_add_op_defs(mips_op_defs);
 }
 
 void tb_set_jmp_target1(uintptr_t jmp_addr, uintptr_t addr)
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 7ec54a2..a1b7412 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -2634,6 +2634,18 @@ static const TCGTargetOpDef ppc_op_defs[] = {
     { -1 },
 };
 
+static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
+{
+    int i, n = ARRAY_SIZE(ppc_op_defs);
+
+    for (i = 0; i < n; ++i) {
+        if (ppc_op_defs[i].op == op) {
+            return &ppc_op_defs[i];
+        }
+    }
+    return NULL;
+}
+
 static void tcg_target_init(TCGContext *s)
 {
     unsigned long hwcap = qemu_getauxval(AT_HWCAP);
@@ -2670,8 +2682,6 @@ static void tcg_target_init(TCGContext *s)
     if (USE_REG_RA) {
         tcg_regset_set_reg(s->reserved_regs, TCG_REG_RA);  /* return addr */
     }
-
-    tcg_add_target_add_op_defs(ppc_op_defs);
 }
 
 #ifdef __ELF__
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index f4c510e..3cb34eb 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -2321,6 +2321,18 @@ static const TCGTargetOpDef s390_op_defs[] = {
     { -1 },
 };
 
+static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
+{
+    int i, n = ARRAY_SIZE(s390_op_defs);
+
+    for (i = 0; i < n; ++i) {
+        if (s390_op_defs[i].op == op) {
+            return &s390_op_defs[i];
+        }
+    }
+    return NULL;
+}
+
 static void query_s390_facilities(void)
 {
     unsigned long hwcap = qemu_getauxval(AT_HWCAP);
@@ -2363,8 +2375,6 @@ static void tcg_target_init(TCGContext *s)
     /* XXX many insns can't be used with R0, so we better avoid it for now */
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_R0);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_CALL_STACK);
-
-    tcg_add_target_add_op_defs(s390_op_defs);
 }
 
 #define FRAME_SIZE  ((int)(TCG_TARGET_CALL_STACK_OFFSET          \
diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index 700c434..f2cbf50 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -1583,6 +1583,18 @@ static const TCGTargetOpDef sparc_op_defs[] = {
     { -1 },
 };
 
+static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
+{
+    int i, n = ARRAY_SIZE(sparc_op_defs);
+
+    for (i = 0; i < n; ++i) {
+        if (sparc_op_defs[i].op == op) {
+            return &sparc_op_defs[i];
+        }
+    }
+    return NULL;
+}
+
 static void tcg_target_init(TCGContext *s)
 {
     /* Only probe for the platform and capabilities if we havn't already
@@ -1622,8 +1634,6 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_O6); /* stack pointer */
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_T1); /* for internal use */
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_T2); /* for internal use */
-
-    tcg_add_target_add_op_defs(sparc_op_defs);
 }
 
 #if SPARC64
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 27913f0..5792c1e 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -62,6 +62,7 @@
 /* Forward declarations for functions declared in tcg-target.inc.c and
    used here. */
 static void tcg_target_init(TCGContext *s);
+static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode);
 static void tcg_target_qemu_prologue(TCGContext *s);
 static void patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend);
@@ -319,6 +320,7 @@ static const TCGHelperInfo all_helpers[] = {
 };
 
 static int indirect_reg_alloc_order[ARRAY_SIZE(tcg_target_reg_alloc_order)];
+static void process_op_defs(TCGContext *s);
 
 void tcg_context_init(TCGContext *s)
 {
@@ -362,6 +364,7 @@ void tcg_context_init(TCGContext *s)
     }
 
     tcg_target_init(s);
+    process_op_defs(s);
 
     /* Reverse the order of the saved registers, assuming they're all at
        the start of tcg_target_reg_alloc_order.  */
@@ -1221,29 +1224,33 @@ static void sort_constraints(TCGOpDef *def, int start, int n)
     }
 }
 
-void tcg_add_target_add_op_defs(const TCGTargetOpDef *tdefs)
+static void process_op_defs(TCGContext *s)
 {
     TCGOpcode op;
-    TCGOpDef *def;
-    const char *ct_str;
-    int i, nb_args;
 
-    for(;;) {
-        if (tdefs->op == (TCGOpcode)-1)
-            break;
-        op = tdefs->op;
-        tcg_debug_assert((unsigned)op < NB_OPS);
-        def = &tcg_op_defs[op];
-#if defined(CONFIG_DEBUG_TCG)
-        /* Duplicate entry in op definitions? */
-        tcg_debug_assert(!def->used);
-        def->used = 1;
-#endif
+    for (op = 0; op < NB_OPS; op++) {
+        TCGOpDef *def = &tcg_op_defs[op];
+        const TCGTargetOpDef *tdefs;
+        int i, nb_args, ok;
+
+        if (def->flags & TCG_OPF_NOT_PRESENT) {
+            continue;
+        }
+
         nb_args = def->nb_iargs + def->nb_oargs;
-        for(i = 0; i < nb_args; i++) {
-            ct_str = tdefs->args_ct_str[i];
-            /* Incomplete TCGTargetOpDef entry? */
+        if (nb_args == 0) {
+            continue;
+        }
+
+        tdefs = tcg_target_op_def(op);
+        /* Missing TCGTargetOpDef entry. */
+        tcg_debug_assert(tdefs != NULL);
+
+        for (i = 0; i < nb_args; i++) {
+            const char *ct_str = tdefs->args_ct_str[i];
+            /* Incomplete TCGTargetOpDef entry. */
             tcg_debug_assert(ct_str != NULL);
+
             tcg_regset_clear(def->args_ct[i].u.regs);
             def->args_ct[i].ct = 0;
             if (ct_str[0] >= '0' && ct_str[0] <= '9') {
@@ -1272,11 +1279,9 @@ void tcg_add_target_add_op_defs(const TCGTargetOpDef *tdefs)
                         ct_str++;
                         break;
                     default:
-                        if (target_parse_constraint(&def->args_ct[i], &ct_str) < 0) {
-                            fprintf(stderr, "Invalid constraint '%s' for arg %d of operation '%s'\n",
-                                    ct_str, i, def->name);
-                            exit(1);
-                        }
+                        ok = target_parse_constraint(&def->args_ct[i], &ct_str);
+                        /* Typo in TCGTargetOpDef constraint. */
+                        tcg_debug_assert(ok == 0);
                     }
                 }
             }
@@ -1288,42 +1293,7 @@ void tcg_add_target_add_op_defs(const TCGTargetOpDef *tdefs)
         /* sort the constraints (XXX: this is just an heuristic) */
         sort_constraints(def, 0, def->nb_oargs);
         sort_constraints(def, def->nb_oargs, def->nb_iargs);
-
-#if 0
-        {
-            int i;
-
-            printf("%s: sorted=", def->name);
-            for(i = 0; i < def->nb_oargs + def->nb_iargs; i++)
-                printf(" %d", def->sorted_args[i]);
-            printf("\n");
-        }
-#endif
-        tdefs++;
-    }
-
-#if defined(CONFIG_DEBUG_TCG)
-    i = 0;
-    for (op = 0; op < tcg_op_defs_max; op++) {
-        const TCGOpDef *def = &tcg_op_defs[op];
-        if (def->flags & TCG_OPF_NOT_PRESENT) {
-            /* Wrong entry in op definitions? */
-            if (def->used) {
-                fprintf(stderr, "Invalid op definition for %s\n", def->name);
-                i = 1;
-            }
-        } else {
-            /* Missing entry in op definitions? */
-            if (!def->used) {
-                fprintf(stderr, "Missing op definition for %s\n", def->name);
-                i = 1;
-            }
-        }
-    }
-    if (i == 1) {
-        tcg_abort();
     }
-#endif
 }
 
 void tcg_op_remove(TCGContext *s, TCGOp *op)
diff --git a/tcg/tcg.h b/tcg/tcg.h
index ebfcefd..144bdab 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -906,8 +906,6 @@ do {\
     abort();\
 } while (0)
 
-void tcg_add_target_add_op_defs(const TCGTargetOpDef *tdefs);
-
 #if UINTPTR_MAX == UINT32_MAX
 #define TCGV_NAT_TO_PTR(n) MAKE_TCGV_PTR(GET_TCGV_I32(n))
 #define TCGV_PTR_TO_NAT(n) MAKE_TCGV_I32(GET_TCGV_PTR(n))
diff --git a/tcg/tci/tcg-target.inc.c b/tcg/tci/tcg-target.inc.c
index 9dbf4d5..42d4bd6 100644
--- a/tcg/tci/tcg-target.inc.c
+++ b/tcg/tci/tcg-target.inc.c
@@ -259,6 +259,18 @@ static const TCGTargetOpDef tcg_target_op_defs[] = {
     { -1 },
 };
 
+static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
+{
+    int i, n = ARRAY_SIZE(tcg_target_op_defs);
+
+    for (i = 0; i < n; ++i) {
+        if (tcg_target_op_defs[i].op == op) {
+            return &tcg_target_op_defs[i];
+        }
+    }
+    return NULL;
+}
+
 static const int tcg_target_reg_alloc_order[] = {
     TCG_REG_R0,
     TCG_REG_R1,
@@ -875,7 +887,6 @@ static void tcg_target_init(TCGContext *s)
 
     tcg_regset_clear(s->reserved_regs);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_CALL_STACK);
-    tcg_add_target_add_op_defs(tcg_target_op_defs);
 
     /* We use negative offsets from "sp" so that we can distinguish
        stores that might pretend to be call arguments.  */
-- 
2.9.3
