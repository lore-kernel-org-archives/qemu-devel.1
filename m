Received: from eggs.gnu.org ([2001:4830:134:3::10]:44866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwZ-0006de-GF
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwK-0003BF-67
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:17 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e]:35123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAhwJ-00035Z-Q0
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:11 -0400
Received: by mail-pl1-x62e.google.com with SMTP id f8-v6so4800267plb.2
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 13:52:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 11 Oct 2018 13:51:47 -0700
Message-Id: <20181011205206.3552-2-richard.henderson@linaro.org>
In-Reply-To: <20181011205206.3552-1-richard.henderson@linaro.org>
References: <20181011205206.3552-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 01/20] target/arm: Hoist address increment for
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
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

This can reduce the number of opcodes required for certain
complex forms of load-multiple (e.g. ld4.16b).

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate-a64.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c403b12eb9..76b5ca3606 100644
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
2.17.1
