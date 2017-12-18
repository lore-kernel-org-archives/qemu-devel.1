Received: from eggs.gnu.org ([2001:4830:134:3::10]:37629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz3u-0000le-3p
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz3q-0001a6-0E
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:46 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:34426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQz3p-0001Z7-R2
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:41 -0500
Received: by mail-pl0-x241.google.com with SMTP id d21so5190272pll.1
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:18:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:17:57 -0800
Message-Id: <20171218171758.16964-26-richard.henderson@linaro.org>
In-Reply-To: <20171218171758.16964-1-richard.henderson@linaro.org>
References: <20171218171758.16964-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v7 25/26] tcg: Add support for 5 operand vector
 ops
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.h |  7 +++++++
 tcg/tcg-op-gvec.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index 91459b9c38..3a927ce24d 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -54,6 +54,13 @@ void tcg_gen_gvec_4_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                         uint32_t cofs, uint32_t oprsz, uint32_t maxsz,
                         int32_t data, gen_helper_gvec_4 *fn);
 
+/* Similarly, with five vector operands.  */
+typedef void gen_helper_gvec_5(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr,
+                               TCGv_ptr, TCGv_i32);
+void tcg_gen_gvec_5_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                        uint32_t cofs, uint32_t xofs, uint32_t oprsz,
+                        uint32_t maxsz, int32_t data, gen_helper_gvec_5 *fn);
+
 typedef void gen_helper_gvec_3_ptr(TCGv_ptr, TCGv_ptr, TCGv_ptr,
                                    TCGv_ptr, TCGv_i32);
 void tcg_gen_gvec_3_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 5f58859a1e..a6df90b284 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -157,6 +157,36 @@ void tcg_gen_gvec_4_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     tcg_temp_free_i32(desc);
 }
 
+/* Generate a call to a gvec-style helper with five vector operands.  */
+void tcg_gen_gvec_5_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                        uint32_t cofs, uint32_t xofs, uint32_t oprsz,
+                        uint32_t maxsz, int32_t data, gen_helper_gvec_5 *fn)
+{
+    TCGv_ptr a0, a1, a2, a3, a4;
+    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
+
+    a0 = tcg_temp_new_ptr();
+    a1 = tcg_temp_new_ptr();
+    a2 = tcg_temp_new_ptr();
+    a3 = tcg_temp_new_ptr();
+    a4 = tcg_temp_new_ptr();
+
+    tcg_gen_addi_ptr(a0, cpu_env, dofs);
+    tcg_gen_addi_ptr(a1, cpu_env, aofs);
+    tcg_gen_addi_ptr(a2, cpu_env, bofs);
+    tcg_gen_addi_ptr(a3, cpu_env, cofs);
+    tcg_gen_addi_ptr(a4, cpu_env, xofs);
+
+    fn(a0, a1, a2, a3, a4, desc);
+
+    tcg_temp_free_ptr(a0);
+    tcg_temp_free_ptr(a1);
+    tcg_temp_free_ptr(a2);
+    tcg_temp_free_ptr(a3);
+    tcg_temp_free_ptr(a4);
+    tcg_temp_free_i32(desc);
+}
+
 /* Generate a call to a gvec-style helper with three vector operands
    and an extra pointer operand.  */
 void tcg_gen_gvec_2_ptr(uint32_t dofs, uint32_t aofs,
-- 
2.14.3
