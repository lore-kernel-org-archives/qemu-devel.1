Received: from eggs.gnu.org ([2001:4830:134:3::10]:34188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dhdHX-0005Is-Ty
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:57:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dhdHW-0004L0-L8
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:57:24 -0400
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:38147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dhdHW-0004KW-FT
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:57:22 -0400
Received: by mail-pg0-x236.google.com with SMTP id l64so7001247pge.5
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 07:57:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 15 Aug 2017 07:57:14 -0700
Message-Id: <20170815145714.17635-4-richard.henderson@linaro.org>
In-Reply-To: <20170815145714.17635-1-richard.henderson@linaro.org>
References: <20170815145714.17635-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 for-2.10 3/3] target/arm: Require alignment
 for load exclusive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alistair.francis@xilinx.com, edgar.iglesias@xilinx.com

From: Alistair Francis <alistair.francis@xilinx.com>

Acording to the ARM ARM exclusive loads require the same allignment as
exclusive stores. Let's update the memops used for the load to match
that of the store. This adds the alignment requirement to the memops.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
[rth: Require 16-byte alignment for 64-bit LDXP.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index eac545e4f2..2200e25be0 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1861,7 +1861,7 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
         g_assert(size >= 2);
         if (size == 2) {
             /* The pair must be single-copy atomic for the doubleword.  */
-            memop |= MO_64;
+            memop |= MO_64 | MO_ALIGN;
             tcg_gen_qemu_ld_i64(cpu_exclusive_val, addr, idx, memop);
             if (s->be_data == MO_LE) {
                 tcg_gen_extract_i64(cpu_reg(s, rt), cpu_exclusive_val, 0, 32);
@@ -1871,10 +1871,11 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
                 tcg_gen_extract_i64(cpu_reg(s, rt2), cpu_exclusive_val, 0, 32);
             }
         } else {
-            /* The pair must be single-copy atomic for *each* doubleword,
-               but not the entire quadword.  */
+            /* The pair must be single-copy atomic for *each* doubleword, not
+               the entire quadword, however it must be quadword aligned.  */
             memop |= MO_64;
-            tcg_gen_qemu_ld_i64(cpu_exclusive_val, addr, idx, memop);
+            tcg_gen_qemu_ld_i64(cpu_exclusive_val, addr, idx,
+                                memop | MO_ALIGN_16);
 
             TCGv_i64 addr2 = tcg_temp_new_i64();
             tcg_gen_addi_i64(addr2, addr, 8);
@@ -1885,7 +1886,7 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
             tcg_gen_mov_i64(cpu_reg(s, rt2), cpu_exclusive_high);
         }
     } else {
-        memop |= size;
+        memop |= size | MO_ALIGN;
         tcg_gen_qemu_ld_i64(cpu_exclusive_val, addr, idx, memop);
         tcg_gen_mov_i64(cpu_reg(s, rt), cpu_exclusive_val);
     }
-- 
2.13.4
