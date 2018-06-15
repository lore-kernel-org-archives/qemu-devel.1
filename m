Received: from eggs.gnu.org ([2001:4830:134:3::10]:60949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfb-0001kU-HU
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfa-0006KR-Ax
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:43 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfZ-0006JR-Rp
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:42 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfY-0003lb-Tc
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:40 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:25:03 +0100
Message-Id: <20180615142521.19143-26-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 25/43] target/arm: Implement SVE copy to vector
 (predicated)
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
Message-id: 20180613015641.5667-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 19 +++++++++++++++++++
 target/arm/sve.decode      |  6 ++++++
 2 files changed, 25 insertions(+)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index feb4c09f1b8..eed59524a9c 100644
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
index 1226867f698..519139f6844 100644
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
