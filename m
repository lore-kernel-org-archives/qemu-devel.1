Received: from eggsout.gnu.org ([209.51.188.92]:54790 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gfY02-0002dW-ME
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 17:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gfY01-0001Dj-QI
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 17:31:30 -0500
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141]:33664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gfY01-0001DX-MK
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 17:31:29 -0500
Received: by mail-it1-x141.google.com with SMTP id m8so2327292itk.0
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 14:31:29 -0800 (PST)
Received: from cloudburst.twiddle.net ([172.56.12.23])
	by smtp.gmail.com with ESMTPSA id
	t6sm27793259ioc.87.2019.01.04.14.31.26 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 04 Jan 2019 14:31:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  5 Jan 2019 08:31:07 +1000
Message-Id: <20190104223116.14037-2-richard.henderson@linaro.org>
In-Reply-To: <20190104223116.14037-1-richard.henderson@linaro.org>
References: <20190104223116.14037-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 01/10] tcg: Add logical simplifications
 during gvec expand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We handle many of these during integer expansion, and the
rest of them during integer optimization.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 61c25f5784..ec231b78fb 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1840,7 +1840,12 @@ void tcg_gen_gvec_and(unsigned vece, uint32_t dofs, uint32_t aofs,
         .opc = INDEX_op_and_vec,
         .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     };
-    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
+
+    if (aofs == bofs) {
+        tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz);
+    } else {
+        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
+    }
 }
 
 void tcg_gen_gvec_or(unsigned vece, uint32_t dofs, uint32_t aofs,
@@ -1853,7 +1858,12 @@ void tcg_gen_gvec_or(unsigned vece, uint32_t dofs, uint32_t aofs,
         .opc = INDEX_op_or_vec,
         .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     };
-    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
+
+    if (aofs == bofs) {
+        tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz);
+    } else {
+        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
+    }
 }
 
 void tcg_gen_gvec_xor(unsigned vece, uint32_t dofs, uint32_t aofs,
@@ -1866,7 +1876,12 @@ void tcg_gen_gvec_xor(unsigned vece, uint32_t dofs, uint32_t aofs,
         .opc = INDEX_op_xor_vec,
         .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     };
-    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
+
+    if (aofs == bofs) {
+        tcg_gen_gvec_dup8i(dofs, oprsz, maxsz, 0);
+    } else {
+        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
+    }
 }
 
 void tcg_gen_gvec_andc(unsigned vece, uint32_t dofs, uint32_t aofs,
@@ -1879,7 +1894,12 @@ void tcg_gen_gvec_andc(unsigned vece, uint32_t dofs, uint32_t aofs,
         .opc = INDEX_op_andc_vec,
         .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     };
-    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
+
+    if (aofs == bofs) {
+        tcg_gen_gvec_dup8i(dofs, oprsz, maxsz, 0);
+    } else {
+        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
+    }
 }
 
 void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs, uint32_t aofs,
@@ -1892,7 +1912,12 @@ void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs, uint32_t aofs,
         .opc = INDEX_op_orc_vec,
         .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     };
-    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
+
+    if (aofs == bofs) {
+        tcg_gen_gvec_dup8i(dofs, oprsz, maxsz, -1);
+    } else {
+        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
+    }
 }
 
 static const GVecGen2s gop_ands = {
-- 
2.17.2
