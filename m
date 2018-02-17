Received: from eggs.gnu.org ([2001:4830:134:3::10]:40268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en79o-0000yY-1q
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en79n-0001sT-6E
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:20 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:37016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en79n-0001s8-1B
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:19 -0500
Received: by mail-pl0-x244.google.com with SMTP id ay8so3442958plb.4
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:24:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:22:48 -0800
Message-Id: <20180217182323.25885-33-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 32/67] target/arm: Implement SVE copy to
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
Cc: qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 13 +++++++++++++
 target/arm/sve.decode      |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 207a22a0bc..fc2a295ab7 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -2422,6 +2422,19 @@ static void trans_LASTB_r(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
     do_last_general(s, a, true);
 }
 
+static void trans_CPY_m_r(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_cpy_m(s, a->esz, a->rd, a->rd, a->pg, cpu_reg_sp(s, a->rn));
+}
+
+static void trans_CPY_m_v(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    int ofs = vec_reg_offset(s, a->rn, 0, a->esz);
+    TCGv_i64 t = load_esz(cpu_env, ofs, a->esz);
+    do_cpy_m(s, a->esz, a->rd, a->rd, a->pg, t);
+    tcg_temp_free_i64(t);
+}
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 1370802c12..5e127de88c 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -451,6 +451,12 @@ LASTB_v		00000101 .. 10001 1 100 ... ..... .....		@rd_pg_rn
 LASTA_r		00000101 .. 10000 0 101 ... ..... .....		@rd_pg_rn
 LASTB_r		00000101 .. 10000 1 101 ... ..... .....		@rd_pg_rn
 
+# SVE copy element from SIMD&FP scalar register
+CPY_m_v		00000101 .. 100000 100 ... ..... .....		@rd_pg_rn
+
+# SVE copy element from general register to vector (predicated)
+CPY_m_r		00000101 .. 101000 101 ... ..... .....		@rd_pg_rn
+
 ### SVE Predicate Logical Operations Group
 
 # SVE predicate logical operations
-- 
2.14.3
