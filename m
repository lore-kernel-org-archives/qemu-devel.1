Received: from eggs.gnu.org ([209.51.188.92]:54081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMLL-00084G-IV
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMLK-0004ue-Bh
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:43 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:34785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guMLJ-0004mo-W2
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:42 -0500
Received: by mail-wr1-x42e.google.com with SMTP id f14so7752111wrg.1
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 11:06:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	n184sm7798471wmf.5.2019.02.14.11.06.25 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 14 Feb 2019 11:06:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 19:05:53 +0000
Message-Id: <20190214190603.25030-18-peter.maydell@linaro.org>
In-Reply-To: <20190214190603.25030-1-peter.maydell@linaro.org>
References: <20190214190603.25030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/27] target/arm: Use vector minmax expanders
 for aarch32
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
Message-id: 20190209033847.9014-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index eaa6e297384..61760dab917 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -6368,6 +6368,25 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             tcg_gen_gvec_cmp(u ? TCG_COND_GEU : TCG_COND_GE, size,
                              rd_ofs, rn_ofs, rm_ofs, vec_size, vec_size);
             return 0;
+
+        case NEON_3R_VMAX:
+            if (u) {
+                tcg_gen_gvec_umax(size, rd_ofs, rn_ofs, rm_ofs,
+                                  vec_size, vec_size);
+            } else {
+                tcg_gen_gvec_smax(size, rd_ofs, rn_ofs, rm_ofs,
+                                  vec_size, vec_size);
+            }
+            return 0;
+        case NEON_3R_VMIN:
+            if (u) {
+                tcg_gen_gvec_umin(size, rd_ofs, rn_ofs, rm_ofs,
+                                  vec_size, vec_size);
+            } else {
+                tcg_gen_gvec_smin(size, rd_ofs, rn_ofs, rm_ofs,
+                                  vec_size, vec_size);
+            }
+            return 0;
         }
 
         if (size == 3) {
@@ -6533,12 +6552,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VQRSHL:
             GEN_NEON_INTEGER_OP_ENV(qrshl);
             break;
-        case NEON_3R_VMAX:
-            GEN_NEON_INTEGER_OP(max);
-            break;
-        case NEON_3R_VMIN:
-            GEN_NEON_INTEGER_OP(min);
-            break;
         case NEON_3R_VABD:
             GEN_NEON_INTEGER_OP(abd);
             break;
-- 
2.20.1
