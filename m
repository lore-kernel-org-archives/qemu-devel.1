Received: from eggs.gnu.org ([2001:4830:134:3::10]:50297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZBEq-0005lD-2h
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 02:55:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZBEo-0000gj-Tb
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 02:55:56 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:38981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZBEo-0000fz-Ny
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 02:55:54 -0500
Received: by mail-pl0-x241.google.com with SMTP id bi12so6826171plb.6
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 23:55:54 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-183-164.tukw.qwest.net.
	[97.113.183.164]) by smtp.gmail.com with ESMTPSA id
	h80sm15740147pfj.12.2018.01.09.23.55.52 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 09 Jan 2018 23:55:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue,  9 Jan 2018 23:55:47 -0800
Message-Id: <20180110075547.15841-3-richard.henderson@linaro.org>
In-Reply-To: <20180110075547.15841-1-richard.henderson@linaro.org>
References: <20180110075547.15841-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] tcg/ppc: Allow a 32-bit offset to the
 constant pool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We recently relaxed the limit of the number of opcodes that can
appear in a TranslationBlock.  In certain cases this has resulted
in relocation overflow.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 67 ++++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 28 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 74f9b4aa34..86f7de5f7e 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -222,33 +222,6 @@ static inline void tcg_out_bc_noaddr(TCGContext *s, int insn)
     tcg_out32(s, insn | retrans);
 }
 
-static void patch_reloc(tcg_insn_unit *code_ptr, int type,
-                        intptr_t value, intptr_t addend)
-{
-    tcg_insn_unit *target;
-    tcg_insn_unit old;
-
-    value += addend;
-    target = (tcg_insn_unit *)value;
-
-    switch (type) {
-    case R_PPC_REL14:
-        reloc_pc14(code_ptr, target);
-        break;
-    case R_PPC_REL24:
-        reloc_pc24(code_ptr, target);
-        break;
-    case R_PPC_ADDR16:
-        assert(value == (int16_t)value);
-        old = *code_ptr;
-        old = deposit32(old, 0, 16, value);
-        *code_ptr = old;
-        break;
-    default:
-        tcg_abort();
-    }
-}
-
 /* parse target specific constraints */
 static const char *target_parse_constraint(TCGArgConstraint *ct,
                                            const char *ct_str, TCGType type)
@@ -552,6 +525,43 @@ static const uint32_t tcg_to_isel[] = {
     [TCG_COND_GTU] = ISEL | BC_(7, CR_GT),
 };
 
+static void patch_reloc(tcg_insn_unit *code_ptr, int type,
+                        intptr_t value, intptr_t addend)
+{
+    tcg_insn_unit *target;
+    tcg_insn_unit old;
+
+    value += addend;
+    target = (tcg_insn_unit *)value;
+
+    switch (type) {
+    case R_PPC_REL14:
+        reloc_pc14(code_ptr, target);
+        break;
+    case R_PPC_REL24:
+        reloc_pc24(code_ptr, target);
+        break;
+    case R_PPC_ADDR16:
+        /* We are abusing this relocation type.  This points to a pair
+           of insns, addis + load.  If the displacement is small, we
+           can nop out the addis.  */
+        if (value == (int16_t)value) {
+            code_ptr[0] = NOP;
+            old = deposit32(code_ptr[1], 0, 16, value);
+            code_ptr[1] = deposit32(old, 16, 5, TCG_REG_TB);
+        } else {
+            int16_t lo = value;
+            int hi = value - lo;
+            assert(hi + lo == value);
+            code_ptr[0] = deposit32(code_ptr[0], 0, 16, hi >> 16);
+            code_ptr[1] = deposit32(code_ptr[1], 0, 16, lo);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void tcg_out_mem_long(TCGContext *s, int opi, int opx, TCGReg rt,
                              TCGReg base, tcg_target_long offset);
 
@@ -690,7 +700,8 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     if (!in_prologue && USE_REG_TB) {
         new_pool_label(s, arg, R_PPC_ADDR16, s->code_ptr,
                        -(intptr_t)s->code_gen_ptr);
-        tcg_out32(s, LD | TAI(ret, TCG_REG_TB, 0));
+        tcg_out32(s, ADDIS | TAI(ret, TCG_REG_TB, 0));
+        tcg_out32(s, LD | TAI(ret, ret, 0));
         return;
     }
 
-- 
2.14.3
