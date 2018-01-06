Received: from eggs.gnu.org ([2001:4830:134:3::10]:48477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eXewD-0007mR-4k
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eXewC-0005ml-5K
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:25 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:42486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eXewB-0005l6-Vh
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:24 -0500
Received: by mail-pg0-x241.google.com with SMTP id q67so2709803pga.9
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 19:14:23 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-183-164.tukw.qwest.net.
	[97.113.183.164]) by smtp.gmail.com with ESMTPSA id
	g10sm17740595pfe.77.2018.01.05.19.14.21 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Jan 2018 19:14:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  5 Jan 2018 19:13:44 -0800
Message-Id: <20180106031346.6650-22-richard.henderson@linaro.org>
In-Reply-To: <20180106031346.6650-1-richard.henderson@linaro.org>
References: <20180106031346.6650-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v8 21/23] target/arm: Use vector infrastructure
 for aa64 widening shifts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 48caba3d9f..4f15e58556 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -8705,12 +8705,7 @@ static void handle_vec_simd_wshli(DisasContext *s, bool is_q, bool is_u,
     int size = 32 - clz32(immh) - 1;
     int immhb = immh << 3 | immb;
     int shift = immhb - (8 << size);
-    int dsize = 64;
-    int esize = 8 << size;
-    int elements = dsize/esize;
-    TCGv_i64 tcg_rn = new_tmp_a64(s);
-    TCGv_i64 tcg_rd = new_tmp_a64(s);
-    int i;
+    GVecGen2Fn *gvec_fn;
 
     if (size >= 3) {
         unallocated_encoding(s);
@@ -8721,18 +8716,18 @@ static void handle_vec_simd_wshli(DisasContext *s, bool is_q, bool is_u,
         return;
     }
 
-    /* For the LL variants the store is larger than the load,
-     * so if rd == rn we would overwrite parts of our input.
-     * So load everything right now and use shifts in the main loop.
-     */
-    read_vec_element(s, tcg_rn, rn, is_q ? 1 : 0, MO_64);
-
-    for (i = 0; i < elements; i++) {
-        tcg_gen_shri_i64(tcg_rd, tcg_rn, i * esize);
-        ext_and_shift_reg(tcg_rd, tcg_rd, size | (!is_u << 2), 0);
-        tcg_gen_shli_i64(tcg_rd, tcg_rd, shift);
-        write_vec_element(s, tcg_rd, rd, i, size + 1);
+    if (is_u) {
+        gvec_fn = is_q ? tcg_gen_gvec_extuh : tcg_gen_gvec_extul;
+    } else {
+        gvec_fn = is_q ? tcg_gen_gvec_extsh : tcg_gen_gvec_extsl;
     }
+    gvec_fn(size, vec_full_reg_offset(s, rd),
+            vec_full_reg_offset(s, rn), 16, 16);
+
+    /* Perform the shift in the wider format.  */
+    tcg_gen_gvec_shli(size + 1, vec_full_reg_offset(s, rd),
+                      vec_full_reg_offset(s, rd),
+                      16, vec_full_reg_size(s), shift);
 }
 
 /* SHRN/RSHRN - Shift right with narrowing (and potential rounding) */
-- 
2.14.3
