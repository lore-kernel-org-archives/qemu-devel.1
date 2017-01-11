Received: from eggs.gnu.org ([2001:4830:134:3::10]:35213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Ut-0006EB-FQ
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Ur-0003Et-Sp
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:43 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8Ur-0003E6-Jy
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:41 -0500
Received: by mail-pf0-x242.google.com with SMTP id f144so12525008pfa.2
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:18:41 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:17:37 -0800
Message-Id: <20170111021820.24416-23-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/65] tcg: Pass the opcode width to
 target_parse_constraint
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

This will let us choose how to interpret a given constraint
depending on whether the opcode is 32- or 64-bit.  Which will
let us share more constraint combinations between opcodes.

At the same time, change the interface to return the advanced
pointer instead of passing it in/out by reference.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/aarch64/tcg-target.inc.c | 15 +++++----------
 tcg/arm/tcg-target.inc.c     | 15 +++++----------
 tcg/i386/tcg-target.inc.c    | 14 +++++---------
 tcg/ia64/tcg-target.inc.c    | 14 +++++---------
 tcg/mips/tcg-target.inc.c    | 14 +++++---------
 tcg/ppc/tcg-target.inc.c     | 14 +++++---------
 tcg/s390/tcg-target.inc.c    | 14 +++++---------
 tcg/sparc/tcg-target.inc.c   | 14 +++++---------
 tcg/tcg.c                    | 12 ++++++++----
 tcg/tci/tcg-target.inc.c     | 12 +++++-------
 10 files changed, 53 insertions(+), 85 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 416db45..17c0b20 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -115,12 +115,10 @@ static inline void patch_reloc(tcg_insn_unit *code_ptr, int type,
 #define TCG_CT_CONST_MONE 0x800
 
 /* parse target specific constraints */
-static int target_parse_constraint(TCGArgConstraint *ct,
-                                   const char **pct_str)
+static const char *target_parse_constraint(TCGArgConstraint *ct,
+                                           const char *ct_str, TCGType type)
 {
-    const char *ct_str = *pct_str;
-
-    switch (ct_str[0]) {
+    switch (*ct_str++) {
     case 'r':
         ct->ct |= TCG_CT_REG;
         tcg_regset_set32(ct->u.regs, 0, (1ULL << TCG_TARGET_NB_REGS) - 1);
@@ -150,12 +148,9 @@ static int target_parse_constraint(TCGArgConstraint *ct,
         ct->ct |= TCG_CT_CONST_ZERO;
         break;
     default:
-        return -1;
+        return NULL;
     }
-
-    ct_str++;
-    *pct_str = ct_str;
-    return 0;
+    return ct_str;
 }
 
 static inline bool is_aimm(uint64_t val)
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index eeabcf8..ec0b861 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -114,12 +114,10 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int type,
 #define TCG_CT_CONST_ZERO 0x800
 
 /* parse target specific constraints */
-static int target_parse_constraint(TCGArgConstraint *ct, const char **pct_str)
+static const char *target_parse_constraint(TCGArgConstraint *ct,
+                                           const char *ct_str, TCGType type)
 {
-    const char *ct_str;
-
-    ct_str = *pct_str;
-    switch (ct_str[0]) {
+    switch (*ct_str++) {
     case 'I':
         ct->ct |= TCG_CT_CONST_ARM;
         break;
@@ -172,12 +170,9 @@ static int target_parse_constraint(TCGArgConstraint *ct, const char **pct_str)
         break;
 
     default:
-        return -1;
+        return NULL;
     }
-    ct_str++;
-    *pct_str = ct_str;
-
-    return 0;
+    return ct_str;
 }
 
 static inline uint32_t rotl(uint32_t val, int n)
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 595c399..aa5a248 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -166,12 +166,10 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int type,
 }
 
 /* parse target specific constraints */
-static int target_parse_constraint(TCGArgConstraint *ct, const char **pct_str)
+static const char *target_parse_constraint(TCGArgConstraint *ct,
+                                           const char *ct_str, TCGType type)
 {
-    const char *ct_str;
-
-    ct_str = *pct_str;
-    switch(ct_str[0]) {
+    switch(*ct_str++) {
     case 'a':
         ct->ct |= TCG_CT_REG;
         tcg_regset_set_reg(ct->u.regs, TCG_REG_EAX);
@@ -249,11 +247,9 @@ static int target_parse_constraint(TCGArgConstraint *ct, const char **pct_str)
         break;
 
     default:
-        return -1;
+        return NULL;
     }
-    ct_str++;
-    *pct_str = ct_str;
-    return 0;
+    return ct_str;
 }
 
 /* test if a constant matches the constraint */
diff --git a/tcg/ia64/tcg-target.inc.c b/tcg/ia64/tcg-target.inc.c
index e4d419d..bf9a97d 100644
--- a/tcg/ia64/tcg-target.inc.c
+++ b/tcg/ia64/tcg-target.inc.c
@@ -721,12 +721,10 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int type,
  */
 
 /* parse target specific constraints */
-static int target_parse_constraint(TCGArgConstraint *ct, const char **pct_str)
+static const char *target_parse_constraint(TCGArgConstraint *ct,
+                                           const char *ct_str, TCGType type)
 {
-    const char *ct_str;
-
-    ct_str = *pct_str;
-    switch(ct_str[0]) {
+    switch(*ct_str++) {
     case 'r':
         ct->ct |= TCG_CT_REG;
         tcg_regset_set(ct->u.regs, 0xffffffffffffffffull);
@@ -750,11 +748,9 @@ static int target_parse_constraint(TCGArgConstraint *ct, const char **pct_str)
         ct->ct |= TCG_CT_CONST_ZERO;
         break;
     default:
-        return -1;
+        return NULL;
     }
-    ct_str++;
-    *pct_str = ct_str;
-    return 0;
+    return ct_str;
 }
 
 /* test if a constant matches the constraint */
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index a8f031a..ea20891 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -186,12 +186,10 @@ static inline bool is_p2m1(tcg_target_long val)
 }
 
 /* parse target specific constraints */
-static int target_parse_constraint(TCGArgConstraint *ct, const char **pct_str)
+static const char *target_parse_constraint(TCGArgConstraint *ct,
+                                           const char *ct_str, TCGType type)
 {
-    const char *ct_str;
-
-    ct_str = *pct_str;
-    switch(ct_str[0]) {
+    switch(*ct_str++) {
     case 'r':
         ct->ct |= TCG_CT_REG;
         tcg_regset_set(ct->u.regs, 0xffffffff);
@@ -238,11 +236,9 @@ static int target_parse_constraint(TCGArgConstraint *ct, const char **pct_str)
         ct->ct |= TCG_CT_CONST_ZERO;
         break;
     default:
-        return -1;
+        return NULL;
     }
-    ct_str++;
-    *pct_str = ct_str;
-    return 0;
+    return ct_str;
 }
 
 /* test if a constant matches the constraint */
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index a1b7412..bf17161 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -259,12 +259,10 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int type,
 }
 
 /* parse target specific constraints */
-static int target_parse_constraint(TCGArgConstraint *ct, const char **pct_str)
+static const char *target_parse_constraint(TCGArgConstraint *ct,
+                                           const char *ct_str, TCGType type)
 {
-    const char *ct_str;
-
-    ct_str = *pct_str;
-    switch (ct_str[0]) {
+    switch (*ct_str++) {
     case 'A': case 'B': case 'C': case 'D':
         ct->ct |= TCG_CT_REG;
         tcg_regset_set_reg(ct->u.regs, 3 + ct_str[0] - 'A');
@@ -311,11 +309,9 @@ static int target_parse_constraint(TCGArgConstraint *ct, const char **pct_str)
         ct->ct |= TCG_CT_CONST_ZERO;
         break;
     default:
-        return -1;
+        return NULL;
     }
-    ct_str++;
-    *pct_str = ct_str;
-    return 0;
+    return ct_str;
 }
 
 /* test if a constant matches the constraint */
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index b686f3a..c36a9ff 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -359,11 +359,10 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int type,
 }
 
 /* parse target specific constraints */
-static int target_parse_constraint(TCGArgConstraint *ct, const char **pct_str)
+static const char *target_parse_constraint(TCGArgConstraint *ct,
+                                           const char *ct_str, TCGType type)
 {
-    const char *ct_str = *pct_str;
-
-    switch (ct_str[0]) {
+    switch (*ct_str++) {
     case 'r':                  /* all registers */
         ct->ct |= TCG_CT_REG;
         tcg_regset_set32(ct->u.regs, 0, 0xffff);
@@ -404,12 +403,9 @@ static int target_parse_constraint(TCGArgConstraint *ct, const char **pct_str)
         ct->ct |= TCG_CT_CONST_ZERO;
         break;
     default:
-        return -1;
+        return NULL;
     }
-    ct_str++;
-    *pct_str = ct_str;
-
-    return 0;
+    return ct_str;
 }
 
 /* Immediates to be used with logical OR.  This is an optimization only,
diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index f2cbf50..d1f4c0d 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -319,12 +319,10 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int type,
 }
 
 /* parse target specific constraints */
-static int target_parse_constraint(TCGArgConstraint *ct, const char **pct_str)
+static const char *target_parse_constraint(TCGArgConstraint *ct,
+                                           const char *ct_str, TCGType type)
 {
-    const char *ct_str;
-
-    ct_str = *pct_str;
-    switch (ct_str[0]) {
+    switch (*ct_str++) {
     case 'r':
         ct->ct |= TCG_CT_REG;
         tcg_regset_set32(ct->u.regs, 0, 0xffffffff);
@@ -360,11 +358,9 @@ static int target_parse_constraint(TCGArgConstraint *ct, const char **pct_str)
         ct->ct |= TCG_CT_CONST_ZERO;
         break;
     default:
-        return -1;
+        return NULL;
     }
-    ct_str++;
-    *pct_str = ct_str;
-    return 0;
+    return ct_str;
 }
 
 /* test if a constant matches the constraint */
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 5792c1e..8b4dce7 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -96,7 +96,8 @@ static void tcg_register_jit_int(void *buf, size_t size,
     __attribute__((unused));
 
 /* Forward declarations for functions declared and used in tcg-target.inc.c. */
-static int target_parse_constraint(TCGArgConstraint *ct, const char **pct_str);
+static const char *target_parse_constraint(TCGArgConstraint *ct,
+                                           const char *ct_str, TCGType type);
 static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1,
                        intptr_t arg2);
 static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg);
@@ -1231,7 +1232,8 @@ static void process_op_defs(TCGContext *s)
     for (op = 0; op < NB_OPS; op++) {
         TCGOpDef *def = &tcg_op_defs[op];
         const TCGTargetOpDef *tdefs;
-        int i, nb_args, ok;
+        TCGType type;
+        int i, nb_args;
 
         if (def->flags & TCG_OPF_NOT_PRESENT) {
             continue;
@@ -1246,6 +1248,7 @@ static void process_op_defs(TCGContext *s)
         /* Missing TCGTargetOpDef entry. */
         tcg_debug_assert(tdefs != NULL);
 
+        type = (def->flags & TCG_OPF_64BIT ? TCG_TYPE_I64 : TCG_TYPE_I32);
         for (i = 0; i < nb_args; i++) {
             const char *ct_str = tdefs->args_ct_str[i];
             /* Incomplete TCGTargetOpDef entry. */
@@ -1279,9 +1282,10 @@ static void process_op_defs(TCGContext *s)
                         ct_str++;
                         break;
                     default:
-                        ok = target_parse_constraint(&def->args_ct[i], &ct_str);
+                        ct_str = target_parse_constraint(&def->args_ct[i],
+                                                         ct_str, type);
                         /* Typo in TCGTargetOpDef constraint. */
-                        tcg_debug_assert(ok == 0);
+                        tcg_debug_assert(ct_str != NULL);
                     }
                 }
             }
diff --git a/tcg/tci/tcg-target.inc.c b/tcg/tci/tcg-target.inc.c
index 42d4bd6..26ee9b1 100644
--- a/tcg/tci/tcg-target.inc.c
+++ b/tcg/tci/tcg-target.inc.c
@@ -384,10 +384,10 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int type,
 }
 
 /* Parse target specific constraints. */
-static int target_parse_constraint(TCGArgConstraint *ct, const char **pct_str)
+static const char *target_parse_constraint(TCGArgConstraint *ct,
+                                           const char *ct_str, TCGType type)
 {
-    const char *ct_str = *pct_str;
-    switch (ct_str[0]) {
+    switch (*ct_str++) {
     case 'r':
     case 'L':                   /* qemu_ld constraint */
     case 'S':                   /* qemu_st constraint */
@@ -395,11 +395,9 @@ static int target_parse_constraint(TCGArgConstraint *ct, const char **pct_str)
         tcg_regset_set32(ct->u.regs, 0, BIT(TCG_TARGET_NB_REGS) - 1);
         break;
     default:
-        return -1;
+        return NULL;
     }
-    ct_str++;
-    *pct_str = ct_str;
-    return 0;
+    return ct_str;
 }
 
 #if defined(CONFIG_DEBUG_TCG_INTERPRETER)
-- 
2.9.3
