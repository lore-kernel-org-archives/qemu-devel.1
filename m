Received: from eggs.gnu.org ([2001:4830:134:3::10]:32833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfh-0001uA-WF
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfg-0006Pg-VR
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:50 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfg-0006OQ-Ng
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:48 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpff-0003pc-MJ
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:47 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:25:12 +0100
Message-Id: <20180615142521.19143-35-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 34/43] target/arm: Implement FDUP/DUP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180613015641.5667-17-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 37 +++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      |  8 ++++++++
 2 files changed, 45 insertions(+)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index ae6a504f61b..13d5effff12 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3191,6 +3191,43 @@ static bool trans_WHILE(DisasContext *s, arg_WHILE *a, uint32_t insn)
     return true;
 }
 
+/*
+ *** SVE Integer Wide Immediate - Unpredicated Group
+ */
+
+static bool trans_FDUP(DisasContext *s, arg_FDUP *a, uint32_t insn)
+{
+    if (a->esz == 0) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        int dofs = vec_full_reg_offset(s, a->rd);
+        uint64_t imm;
+
+        /* Decode the VFP immediate.  */
+        imm = vfp_expand_imm(a->esz, a->imm);
+        imm = dup_const(a->esz, imm);
+
+        tcg_gen_gvec_dup64i(dofs, vsz, vsz, imm);
+    }
+    return true;
+}
+
+static bool trans_DUP_i(DisasContext *s, arg_DUP_i *a, uint32_t insn)
+{
+    if (a->esz == 0 && extract32(insn, 13, 1)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        int dofs = vec_full_reg_offset(s, a->rd);
+
+        tcg_gen_gvec_dup64i(dofs, vsz, vsz, dup_const(a->esz, a->imm));
+    }
+    return true;
+}
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 4b718060a9c..b8bd22aff7a 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -614,6 +614,14 @@ CTERM           00100101 1 sf:1 1 rm:5 001000 rn:5 ne:1 0000
 # SVE integer compare scalar count and limit
 WHILE           00100101 esz:2 1 rm:5 000 sf:1 u:1 1 rn:5 eq:1 rd:4
 
+### SVE Integer Wide Immediate - Unpredicated Group
+
+# SVE broadcast floating-point immediate (unpredicated)
+FDUP            00100101 esz:2 111 00 1110 imm:8 rd:5
+
+# SVE broadcast integer immediate (unpredicated)
+DUP_i           00100101 esz:2 111 00 011 . ........ rd:5       imm=%sh8_i8s
+
 ### SVE Memory - 32-bit Gather and Unsized Contiguous Group
 
 # SVE load predicate register
-- 
2.17.1
