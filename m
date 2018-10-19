Received: from eggs.gnu.org ([2001:4830:134:3::10]:47649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY6J-0001oh-FJ
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY6H-0002Yz-GY
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:58:15 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDY6F-0002Jh-Jg
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:58:13 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY64-0006kT-4a
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 17:58:00 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:57:12 +0100
Message-Id: <20181019165735.22511-23-peter.maydell@linaro.org>
In-Reply-To: <20181019165735.22511-1-peter.maydell@linaro.org>
References: <20181019165735.22511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/45] target/arm: Hoist address increment for
 vector memory ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <rth@twiddle.net>

This can reduce the number of opcodes required for certain
complex forms of load-multiple (e.g. ld4.16b).

Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-id: 20181011205206.3552-2-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 09c7c4af047..371909620bb 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3012,7 +3012,7 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
     bool is_store = !extract32(insn, 22, 1);
     bool is_postidx = extract32(insn, 23, 1);
     bool is_q = extract32(insn, 30, 1);
-    TCGv_i64 tcg_addr, tcg_rn;
+    TCGv_i64 tcg_addr, tcg_rn, tcg_ebytes;
 
     int ebytes = 1 << size;
     int elements = (is_q ? 128 : 64) / (8 << size);
@@ -3077,6 +3077,7 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
     tcg_rn = cpu_reg_sp(s, rn);
     tcg_addr = tcg_temp_new_i64();
     tcg_gen_mov_i64(tcg_addr, tcg_rn);
+    tcg_ebytes = tcg_const_i64(ebytes);
 
     for (r = 0; r < rpt; r++) {
         int e;
@@ -3101,7 +3102,7 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
                         clear_vec_high(s, is_q, tt);
                     }
                 }
-                tcg_gen_addi_i64(tcg_addr, tcg_addr, ebytes);
+                tcg_gen_add_i64(tcg_addr, tcg_addr, tcg_ebytes);
                 tt = (tt + 1) % 32;
             }
         }
@@ -3115,6 +3116,7 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
             tcg_gen_add_i64(tcg_rn, tcg_rn, cpu_reg(s, rm));
         }
     }
+    tcg_temp_free_i64(tcg_ebytes);
     tcg_temp_free_i64(tcg_addr);
 }
 
@@ -3157,7 +3159,7 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
     bool replicate = false;
     int index = is_q << 3 | S << 2 | size;
     int ebytes, xs;
-    TCGv_i64 tcg_addr, tcg_rn;
+    TCGv_i64 tcg_addr, tcg_rn, tcg_ebytes;
 
     switch (scale) {
     case 3:
@@ -3210,6 +3212,7 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
     tcg_rn = cpu_reg_sp(s, rn);
     tcg_addr = tcg_temp_new_i64();
     tcg_gen_mov_i64(tcg_addr, tcg_rn);
+    tcg_ebytes = tcg_const_i64(ebytes);
 
     for (xs = 0; xs < selem; xs++) {
         if (replicate) {
@@ -3252,7 +3255,7 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
                 do_vec_st(s, rt, index, tcg_addr, scale);
             }
         }
-        tcg_gen_addi_i64(tcg_addr, tcg_addr, ebytes);
+        tcg_gen_add_i64(tcg_addr, tcg_addr, tcg_ebytes);
         rt = (rt + 1) % 32;
     }
 
@@ -3264,6 +3267,7 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
             tcg_gen_add_i64(tcg_rn, tcg_rn, cpu_reg(s, rm));
         }
     }
+    tcg_temp_free_i64(tcg_ebytes);
     tcg_temp_free_i64(tcg_addr);
 }
 
-- 
2.19.1
