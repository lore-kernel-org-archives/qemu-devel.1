Received: from eggs.gnu.org ([2001:4830:134:3::10]:54058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncSw-0000sl-GW
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncSv-0007Kh-KA
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:26 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:41706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fncSv-0007K5-DF
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:25 -0400
Received: by mail-pg1-x52d.google.com with SMTP id z8-v6so2107869pgu.8
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 21:22:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  8 Aug 2018 21:21:57 -0700
Message-Id: <20180809042206.15726-12-richard.henderson@linaro.org>
In-Reply-To: <20180809042206.15726-1-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 11/20] target/arm: Clear unused predicate bits
 for LD1RQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org

The 16-byte load only uses 16 predicate bits.  But while
reusing the other load infrastructure, we find other bits
that are set and trigger an assert.  To avoid this and
retain the assert, zero-extend the predicate that we pass
to the LD1 helper.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index d27bc8c946..bef6b8242d 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4765,12 +4765,33 @@ static void do_ldrq(DisasContext *s, int zt, int pg, TCGv_i64 addr, int msz)
     unsigned vsz = vec_full_reg_size(s);
     TCGv_ptr t_pg;
     TCGv_i32 desc;
+    int poff;
 
     /* Load the first quadword using the normal predicated load helpers.  */
     desc = tcg_const_i32(simd_desc(16, 16, zt));
-    t_pg = tcg_temp_new_ptr();
 
-    tcg_gen_addi_ptr(t_pg, cpu_env, pred_full_reg_offset(s, pg));
+    poff = pred_full_reg_offset(s, pg);
+    if (vsz > 16) {
+        /*
+         * Zero-extend the first 16 bits of the predicate into a temporary.
+         * This avoids triggering an assert making sure we don't have bits
+         * set within a predicate beyond VQ, but we have lowered VQ to 1
+         * for this load operation.
+         */
+        TCGv_i64 tmp = tcg_temp_new_i64();
+#ifdef HOST_WORDS_BIGENDIAN
+        poff += 6;
+#endif
+        tcg_gen_ld16u_i64(tmp, cpu_env, poff);
+
+        poff = offsetof(CPUARMState, vfp.preg_tmp);
+        tcg_gen_st_i64(tmp, cpu_env, poff);
+        tcg_temp_free_i64(tmp);
+    }
+
+    t_pg = tcg_temp_new_ptr();
+    tcg_gen_addi_ptr(t_pg, cpu_env, poff);
+
     fns[msz](cpu_env, t_pg, addr, desc);
 
     tcg_temp_free_ptr(t_pg);
-- 
2.17.1
