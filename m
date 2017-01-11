Received: from eggs.gnu.org ([2001:4830:134:3::10]:35222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Ut-0006Ej-V9
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Us-0003Fu-Nc
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:43 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8Us-0003FC-EK
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:42 -0500
Received: by mail-pf0-x243.google.com with SMTP id f144so12525073pfa.2
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:18:42 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:17:38 -0800
Message-Id: <20170111021820.24416-24-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 23/65] tcg: Allow an operand to be matching or a
 constant
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

This allows an output operand to match an input operand
only when the input operand needs a register.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/README | 13 +++++++++----
 tcg/tcg.c  | 63 +++++++++++++++++++++++++++++++-------------------------------
 2 files changed, 41 insertions(+), 35 deletions(-)

diff --git a/tcg/README b/tcg/README
index 065d9c2..6946b5b 100644
--- a/tcg/README
+++ b/tcg/README
@@ -539,24 +539,29 @@ version. Aliases are specified in the input operands as for GCC.
 The same register may be used for both an input and an output, even when
 they are not explicitly aliased.  If an op expands to multiple target
 instructions then care must be taken to avoid clobbering input values.
-GCC style "early clobber" outputs are not currently supported.
+GCC style "early clobber" outputs are supported, with '&'.
 
 A target can define specific register or constant constraints. If an
 operation uses a constant input constraint which does not allow all
 constants, it must also accept registers in order to have a fallback.
+The constraint 'i' is defined generically to accept any constant.
+The constraint 'r' is not defined generically, but is consistently
+used by each backend to indicate all registers.
 
 The movi_i32 and movi_i64 operations must accept any constants.
 
 The mov_i32 and mov_i64 operations must accept any registers of the
 same type.
 
-The ld/st instructions must accept signed 32 bit constant offsets. It
-can be implemented by reserving a specific register to compute the
-address if the offset is too big.
+The ld/st/sti instructions must accept signed 32 bit constant offsets.
+This can be implemented by reserving a specific register in which to
+compute the address if the offset is too big.
 
 The ld/st instructions must accept any destination (ld) or source (st)
 register.
 
+The sti instruction may fail if it cannot store the given constant.
+
 4.3) Function call assumptions
 
 - The only supported types for parameters and return value are: 32 and
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 8b4dce7..cb898f1 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1256,37 +1256,37 @@ static void process_op_defs(TCGContext *s)
 
             tcg_regset_clear(def->args_ct[i].u.regs);
             def->args_ct[i].ct = 0;
-            if (ct_str[0] >= '0' && ct_str[0] <= '9') {
-                int oarg;
-                oarg = ct_str[0] - '0';
-                tcg_debug_assert(oarg < def->nb_oargs);
-                tcg_debug_assert(def->args_ct[oarg].ct & TCG_CT_REG);
-                /* TCG_CT_ALIAS is for the output arguments. The input
-                   argument is tagged with TCG_CT_IALIAS. */
-                def->args_ct[i] = def->args_ct[oarg];
-                def->args_ct[oarg].ct = TCG_CT_ALIAS;
-                def->args_ct[oarg].alias_index = i;
-                def->args_ct[i].ct |= TCG_CT_IALIAS;
-                def->args_ct[i].alias_index = oarg;
-            } else {
-                for(;;) {
-                    if (*ct_str == '\0')
-                        break;
-                    switch(*ct_str) {
-                    case '&':
-                        def->args_ct[i].ct |= TCG_CT_NEWREG;
-                        ct_str++;
-                        break;
-                    case 'i':
-                        def->args_ct[i].ct |= TCG_CT_CONST;
-                        ct_str++;
-                        break;
-                    default:
-                        ct_str = target_parse_constraint(&def->args_ct[i],
-                                                         ct_str, type);
-                        /* Typo in TCGTargetOpDef constraint. */
-                        tcg_debug_assert(ct_str != NULL);
+            while (*ct_str != '\0') {
+                switch(*ct_str) {
+                case '0' ... '9':
+                    {
+                        int oarg = *ct_str - '0';
+                        tcg_debug_assert(ct_str == tdefs->args_ct_str[i]);
+                        tcg_debug_assert(oarg < def->nb_oargs);
+                        tcg_debug_assert(def->args_ct[oarg].ct & TCG_CT_REG);
+                        /* TCG_CT_ALIAS is for the output arguments.
+                           The input is tagged with TCG_CT_IALIAS. */
+                        def->args_ct[i] = def->args_ct[oarg];
+                        def->args_ct[oarg].ct |= TCG_CT_ALIAS;
+                        def->args_ct[oarg].alias_index = i;
+                        def->args_ct[i].ct |= TCG_CT_IALIAS;
+                        def->args_ct[i].alias_index = oarg;
                     }
+                    ct_str++;
+                    break;
+                case '&':
+                    def->args_ct[i].ct |= TCG_CT_NEWREG;
+                    ct_str++;
+                    break;
+                case 'i':
+                    def->args_ct[i].ct |= TCG_CT_CONST;
+                    ct_str++;
+                    break;
+                default:
+                    ct_str = target_parse_constraint(&def->args_ct[i],
+                                                     ct_str, type);
+                    /* Typo in TCGTargetOpDef constraint. */
+                    tcg_debug_assert(ct_str != NULL);
                 }
             }
         }
@@ -2296,7 +2296,8 @@ static void tcg_reg_alloc_op(TCGContext *s,
             arg = args[i];
             arg_ct = &def->args_ct[i];
             ts = &s->temps[arg];
-            if (arg_ct->ct & TCG_CT_ALIAS) {
+            if ((arg_ct->ct & TCG_CT_ALIAS)
+                && !const_args[arg_ct->alias_index]) {
                 reg = new_args[arg_ct->alias_index];
             } else if (arg_ct->ct & TCG_CT_NEWREG) {
                 reg = tcg_reg_alloc(s, arg_ct->u.regs,
-- 
2.9.3
