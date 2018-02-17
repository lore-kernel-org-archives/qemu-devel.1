Received: from eggs.gnu.org ([2001:4830:134:3::10]:40504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7A2-0001DW-7n
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7A0-0001zc-M8
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:34 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:45874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en7A0-0001zM-G9
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:32 -0500
Received: by mail-pf0-x242.google.com with SMTP id w83so592594pfi.12
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:24:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:22:57 -0800
Message-Id: <20180217182323.25885-42-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 41/67] target/arm: Implement FDUP/DUP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 35 +++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      |  8 ++++++++
 2 files changed, 43 insertions(+)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 4b92a55c21..7571d02237 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -2939,6 +2939,41 @@ static void trans_WHILE(DisasContext *s, arg_WHILE *a, uint32_t insn)
     tcg_temp_free_i32(t3);
 }
 
+/*
+ *** SVE Integer Wide Immediate - Unpredicated Group
+ */
+
+static void trans_FDUP(DisasContext *s, arg_FDUP *a, uint32_t insn)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    int dofs = vec_full_reg_offset(s, a->rd);
+    uint64_t imm;
+
+    if (a->esz == 0) {
+        unallocated_encoding(s);
+        return;
+    }
+
+    /* Decode the VFP immediate.  */
+    imm = vfp_expand_imm(a->esz, a->imm);
+    imm = dup_const(a->esz, imm);
+
+    tcg_gen_gvec_dup64i(dofs, vsz, vsz, imm);
+}
+
+static void trans_DUP_i(DisasContext *s, arg_DUP_i *a, uint32_t insn)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    int dofs = vec_full_reg_offset(s, a->rd);
+
+    if (a->esz == 0 && extract32(insn, 13, 1)) {
+        unallocated_encoding(s);
+        return;
+    }
+
+    tcg_gen_gvec_dup64i(dofs, vsz, vsz, dup_const(a->esz, a->imm));
+}
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index b5bc7e9546..ea1bfe7579 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -622,6 +622,14 @@ CTERM		00100101 1 sf:1 1 rm:5 001000 rn:5 ne:1 0000
 # SVE integer compare scalar count and limit
 WHILE		00100101 esz:2 1 rm:5 000 sf:1 u:1 1 rn:5 eq:1 rd:4
 
+### SVE Integer Wide Immediate - Unpredicated Group
+
+# SVE broadcast floating-point immediate (unpredicated)
+FDUP		00100101 esz:2 111 00 1110 imm:8 rd:5
+
+# SVE broadcast integer immediate (unpredicated)
+DUP_i		00100101 esz:2 111 00 011 . ........ rd:5	imm=%sh8_i8s
+
 ### SVE Memory - 32-bit Gather and Unsized Contiguous Group
 
 # SVE load predicate register
-- 
2.14.3
