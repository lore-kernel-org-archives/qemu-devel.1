Received: from eggs.gnu.org ([2001:4830:134:3::10]:55475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUI-00081V-1C
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUG-0001nn-LM
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:02 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:40516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQzUG-0001nA-F9
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:00 -0500
Received: by mail-pg0-x241.google.com with SMTP id k15so9432616pgr.7
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:46:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:45:32 -0800
Message-Id: <20171218174552.18871-4-richard.henderson@linaro.org>
In-Reply-To: <20171218174552.18871-1-richard.henderson@linaro.org>
References: <20171218174552.18871-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 03/23] target/arm: Implement SVE Bitwise
 Logical - Unpredicated Group
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

These were the instructions that were stubbed out when
introducing the decode skeleton.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 61 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 67ad94e310..43420fa124 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -32,6 +32,10 @@
 #include "trace-tcg.h"
 #include "translate-a64.h"
 
+typedef void GVecGen2Fn(unsigned, uint32_t, uint32_t, uint32_t, uint32_t);
+typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
+                        uint32_t, uint32_t, uint32_t);
+
 /*
  * Include the generated decoder.
  */
@@ -42,7 +46,56 @@
  * Implement all of the translator functions referenced by the decoder.
  */
 
-void trans_AND_zzz(DisasContext *s, arg_AND_zzz *a, uint32_t insn) { unsupported_encoding(s, insn); }
-void trans_ORR_zzz(DisasContext *s, arg_ORR_zzz *a, uint32_t insn) { unsupported_encoding(s, insn); }
-void trans_EOR_zzz(DisasContext *s, arg_EOR_zzz *a, uint32_t insn) { unsupported_encoding(s, insn); }
-void trans_BIC_zzz(DisasContext *s, arg_BIC_zzz *a, uint32_t insn) { unsupported_encoding(s, insn); }
+static unsigned size_for_gvec(unsigned s)
+{
+    if (s <= 8) {
+        return 8;
+    } else {
+        return QEMU_ALIGN_UP(s, 16);
+    }
+}
+
+static void do_genfn2(DisasContext *s, GVecGen2Fn *gvec_fn,
+                      int esz, int rd, int rn)
+{
+    unsigned vsz = size_for_gvec(vec_full_reg_size(s));
+    gvec_fn(esz, vec_full_reg_offset(s, rd),
+            vec_full_reg_offset(s, rn), vsz, vsz);
+}
+
+static void do_genfn3(DisasContext *s, GVecGen3Fn *gvec_fn,
+                      int esz, int rd, int rn, int rm)
+{
+    unsigned vsz = size_for_gvec(vec_full_reg_size(s));
+    gvec_fn(esz, vec_full_reg_offset(s, rd), vec_full_reg_offset(s, rn),
+            vec_full_reg_offset(s, rm), vsz, vsz);
+}
+
+static void do_zzz_genfn(DisasContext *s, arg_rrr_esz *a, GVecGen3Fn *gvec_fn)
+{
+    do_genfn3(s, gvec_fn, a->esz, a->rd, a->rn, a->rm);
+}
+
+void trans_AND_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    do_zzz_genfn(s, a, tcg_gen_gvec_and);
+}
+
+void trans_ORR_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    if (a->rn == a->rm) { /* MOV */
+        do_genfn2(s, tcg_gen_gvec_mov, 0, a->rd, a->rn);
+    } else {
+        do_genfn3(s, tcg_gen_gvec_or, 0, a->rd, a->rn, a->rm);
+    }
+}
+
+void trans_EOR_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    do_zzz_genfn(s, a, tcg_gen_gvec_xor);
+}
+
+void trans_BIC_zzz(DisasContext *s, arg_BIC_zzz *a, uint32_t insn)
+{
+    do_zzz_genfn(s, a, tcg_gen_gvec_andc);
+}
-- 
2.14.3
