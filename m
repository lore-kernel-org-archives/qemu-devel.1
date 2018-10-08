Received: from eggs.gnu.org ([2001:4830:134:3::10]:46254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5a-0001Gj-Rb
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5V-0007DJ-EP
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:50 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1g9W5U-00073I-UM
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:45 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W54-0003g9-70
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:00:18 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  8 Oct 2018 14:59:41 +0100
Message-Id: <20181008140004.12612-11-peter.maydell@linaro.org>
In-Reply-To: <20181008140004.12612-1-peter.maydell@linaro.org>
References: <20181008140004.12612-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/33] target/arm: Clear unused predicate bits
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

From: Richard Henderson <richard.henderson@linaro.org>

The 16-byte load only uses 16 predicate bits.  But while
reusing the other load infrastructure, we find other bits
that are set and trigger an assert.  To avoid this and
retain the assert, zero-extend the predicate that we pass
to the LD1 helper.

Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181005175350.30752-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 667879564f8..4ee3bbca29d 100644
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
2.19.0
