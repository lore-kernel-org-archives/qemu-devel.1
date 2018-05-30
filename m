Received: from eggs.gnu.org ([2001:4830:134:3::10]:33764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fO5Q1-0002B9-J8
	for qemu-devel@nongnu.org; Wed, 30 May 2018 14:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fO5Px-0004on-LL
	for qemu-devel@nongnu.org; Wed, 30 May 2018 14:01:53 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:37307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fO5Px-0004oC-E3
	for qemu-devel@nongnu.org; Wed, 30 May 2018 14:01:49 -0400
Received: by mail-pf0-x243.google.com with SMTP id e9-v6so9408629pfi.4
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 11:01:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 30 May 2018 11:01:18 -0700
Message-Id: <20180530180120.13355-17-richard.henderson@linaro.org>
In-Reply-To: <20180530180120.13355-1-richard.henderson@linaro.org>
References: <20180530180120.13355-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3b 16/18] target/arm: Implement FDUP/DUP
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
 target/arm/translate-sve.c | 37 +++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      |  8 ++++++++
 2 files changed, 45 insertions(+)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 75eb36f110..e470f3b745 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3183,6 +3183,43 @@ static bool trans_WHILE(DisasContext *s, arg_WHILE *a, uint32_t insn)
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
index 4b718060a9..b8bd22aff7 100644
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
2.17.0
