Received: from eggs.gnu.org ([2001:4830:134:3::10]:44055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSv25-0002IW-Ue
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSv25-0006G9-6G
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:57:10 -0400
Received: from mail-pl0-x231.google.com ([2607:f8b0:400e:c01::231]:39474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fSv25-0006Fw-08
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:57:09 -0400
Received: by mail-pl0-x231.google.com with SMTP id f1-v6so549743plt.6
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 18:57:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 12 Jun 2018 15:56:30 -1000
Message-Id: <20180613015641.5667-8-richard.henderson@linaro.org>
In-Reply-To: <20180613015641.5667-1-richard.henderson@linaro.org>
References: <20180613015641.5667-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4b 07/18] target/arm: Implement SVE copy to
 vector (predicated)
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 19 +++++++++++++++++++
 target/arm/sve.decode      |  6 ++++++
 2 files changed, 25 insertions(+)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index feb4c09f1b..eed59524a9 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -2624,6 +2624,25 @@ static bool trans_LASTB_r(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
     return do_last_general(s, a, true);
 }
 
+static bool trans_CPY_m_r(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    if (sve_access_check(s)) {
+        do_cpy_m(s, a->esz, a->rd, a->rd, a->pg, cpu_reg_sp(s, a->rn));
+    }
+    return true;
+}
+
+static bool trans_CPY_m_v(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    if (sve_access_check(s)) {
+        int ofs = vec_reg_offset(s, a->rn, 0, a->esz);
+        TCGv_i64 t = load_esz(cpu_env, ofs, a->esz);
+        do_cpy_m(s, a->esz, a->rd, a->rd, a->pg, t);
+        tcg_temp_free_i64(t);
+    }
+    return true;
+}
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 1226867f69..519139f684 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -450,6 +450,12 @@ LASTB_v         00000101 .. 10001 1 100 ... ..... .....         @rd_pg_rn
 LASTA_r         00000101 .. 10000 0 101 ... ..... .....         @rd_pg_rn
 LASTB_r         00000101 .. 10000 1 101 ... ..... .....         @rd_pg_rn
 
+# SVE copy element from SIMD&FP scalar register
+CPY_m_v         00000101 .. 100000 100 ... ..... .....          @rd_pg_rn
+
+# SVE copy element from general register to vector (predicated)
+CPY_m_r         00000101 .. 101000 101 ... ..... .....          @rd_pg_rn
+
 ### SVE Predicate Logical Operations Group
 
 # SVE predicate logical operations
-- 
2.17.1
