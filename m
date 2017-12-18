Received: from eggs.gnu.org ([2001:4830:134:3::10]:55569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUN-00086M-05
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUL-0001sB-A2
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:07 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:46628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQzUL-0001rY-34
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:05 -0500
Received: by mail-pg0-x244.google.com with SMTP id b11so9421599pgu.13
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:46:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:45:35 -0800
Message-Id: <20171218174552.18871-7-richard.henderson@linaro.org>
In-Reply-To: <20171218174552.18871-1-richard.henderson@linaro.org>
References: <20171218174552.18871-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 06/23] target/arm: Implement SVE load
 vector/predicate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |  2 ++
 target/arm/sve_helper.c    | 31 +++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 32 ++++++++++++++++++++++++++++++++
 target/arm/sve.def         | 16 ++++++++++++++++
 4 files changed, 81 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 4a923a33b8..8b382a962d 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -35,3 +35,5 @@ DEF_HELPER_FLAGS_5(sve_orns_pred, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_nors_pred, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_nands_pred, TCG_CALL_NO_RWG,
                    i32, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldr, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 5d2a6b2239..a605e623f7 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 
@@ -124,3 +125,33 @@ LOGICAL_PRED_FLAGS(sve_nands_pred, DO_NAND)
 #undef DO_NOR
 #undef DO_NAND
 #undef DO_SEL
+
+void HELPER(sve_ldr)(CPUARMState *env, void *d, target_ulong addr, uint32_t len)
+{
+    intptr_t i, len_align = QEMU_ALIGN_DOWN(len, 8);
+
+    for (i = 0; i < len_align; i += 8) {
+        *(uint64_t *)(d + i) = cpu_ldq_data(env, addr + i);
+    }
+
+    /* For LDR of predicate registers, we can have any multiple of 2.  */
+    switch (len % 8) {
+    case 0:
+        break;
+    case 2:
+        *(uint64_t *)(d + i) = cpu_lduw_data(env, addr + i);
+        break;
+    case 4:
+        *(uint64_t *)(d + i) = (uint32_t)cpu_ldl_data(env, addr + i);
+        break;
+    case 6:
+        {
+            uint32_t t0 = cpu_ldl_data(env, addr + i);
+            uint32_t t1 = cpu_lduw_data(env, addr + i + 2);
+            *(uint64_t *)(d + i) = deposit64(t0, 32, 32, t1);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index ab03ead000..0e988c03aa 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -526,3 +526,35 @@ void trans_NANDS_pppp(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
 {
     do_logical_pppp_flags(s, a, gen_helper_sve_nands_pred);
 }
+
+static void do_ldr(DisasContext *s, uint32_t vofs, uint32_t len,
+                   int rn, int imm)
+{
+    TCGv_ptr vptr;
+    TCGv_i32 tlen;
+    TCGv_i64 addr = tcg_temp_new_i64();
+
+    tcg_gen_addi_i64(addr, cpu_reg_sp(s, rn), imm);
+
+    vptr = tcg_temp_new_ptr();
+    tlen = tcg_const_i32(len);
+    tcg_gen_addi_ptr(vptr, cpu_env, vofs);
+
+    gen_helper_sve_ldr(cpu_env, vptr, addr, tlen);
+
+    tcg_temp_free_ptr(vptr);
+    tcg_temp_free_i32(tlen);
+    tcg_temp_free_i64(addr);
+}
+
+void trans_LDR_zri(DisasContext *s, arg_rri *a, uint32_t insn)
+{
+    int size = vec_full_reg_size(s);
+    do_ldr(s, vec_full_reg_offset(s, a->rd), size, a->rn, a->imm * size);
+}
+
+void trans_LDR_pri(DisasContext *s, arg_rri *a, uint32_t insn)
+{
+    int size = pred_full_reg_size(s);
+    do_ldr(s, pred_full_reg_offset(s, a->rd), size, a->rn, a->imm * size);
+}
diff --git a/target/arm/sve.def b/target/arm/sve.def
index 77f96510d8..d1172296e0 100644
--- a/target/arm/sve.def
+++ b/target/arm/sve.def
@@ -19,11 +19,17 @@
 # This file is processed by scripts/decodetree.py
 #
 
+###########################################################################
+# Named fields.  These are primarily for disjoint fields.
+
+%imm9_16_10		16:s6 10:3
+
 ###########################################################################
 # Named attribute sets.  These are used to make nice(er) names
 # when creating helpers common to those for the individual
 # instruction patterns.
 
+&rri			rd rn imm
 &rrr_esz		rd rn rm esz
 &rprr_esz		rd pg rn rm esz
 &pred_set		rd pat esz i s
@@ -38,6 +44,10 @@
 # Three prediate operand, with governing predicate, unused vector element size
 @pd_pg_pn_pm		........ .... rm:4 .. pg:4 . rn:4 . rd:4	&rprr_esz esz=0
 
+# Basic Load/Store with 9-bit immediate offset
+@pd_rn_i9		........ ........ ...... rn:5 . rd:4		&rri imm=%imm9_16_10
+@rd_rn_i9		........ ........ ...... rn:5 rd:5		&rri imm=%imm9_16_10
+
 ###########################################################################
 # Instruction patterns.  Grouped according to the SVE encodingindex.xhtml.
 
@@ -76,3 +86,9 @@ ORRS_pppp		00100101 11 00 .... 01 .... 0 .... 0 ....	@pd_pg_pn_pm
 ORNS_pppp		00100101 11 00 .... 01 .... 0 .... 1 ....	@pd_pg_pn_pm
 NORS_pppp		00100101 11 00 .... 01 .... 1 .... 0 ....	@pd_pg_pn_pm
 NANDS_pppp		00100101 11 00 .... 01 .... 1 .... 1 ....	@pd_pg_pn_pm
+
+# SVE load predicate register
+LDR_pri			10000101 10 ...... 000 ... ..... 0 ....		@pd_rn_i9
+
+# SVE load vector register
+LDR_zri			1000010110 ...... 010 ... ..... .....		@rd_rn_i9
-- 
2.14.3
