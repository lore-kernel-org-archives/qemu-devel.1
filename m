Received: from eggs.gnu.org ([2001:4830:134:3::10]:40674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1duT9Y-0004R8-2T
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1duT9O-0005dm-FL
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55284
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1duT9O-0005d4-1Y
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:02 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8K0hblp139549
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 20:46:01 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d39xyvars-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 20:46:01 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 19 Sep 2017 18:46:00 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 19 Sep 2017 19:45:12 -0500
In-Reply-To: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
References: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20170920004521.9417-4-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 03/12] target/arm: Fix aa64 ldp register
 writeback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

For "ldp x0, x1, [x0]", if the second load is on a second page and
the second page is unmapped, the exception would be raised with x0
already modified.  This means the instruction couldn't be restarted.

Cc: qemu-arm@nongnu.org
Cc: qemu-stable@nongnu.org
Reported-by: Andrew <andrew@fubar.geek.nz>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20170825224833.4463-1-richard.henderson@linaro.org
Fixes: https://bugs.launchpad.net/qemu/+bug/1713066
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
[PMM: tweaked comment format]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

(cherry picked from commit 3e4d91b94ce400326fae0850578d9e9f30a71adb)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/translate-a64.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2200e25be0..cb44632d16 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -2217,29 +2217,34 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
         } else {
             do_fp_st(s, rt, tcg_addr, size);
         }
-    } else {
-        TCGv_i64 tcg_rt = cpu_reg(s, rt);
-        if (is_load) {
-            do_gpr_ld(s, tcg_rt, tcg_addr, size, is_signed, false,
-                      false, 0, false, false);
-        } else {
-            do_gpr_st(s, tcg_rt, tcg_addr, size,
-                      false, 0, false, false);
-        }
-    }
-    tcg_gen_addi_i64(tcg_addr, tcg_addr, 1 << size);
-    if (is_vector) {
+        tcg_gen_addi_i64(tcg_addr, tcg_addr, 1 << size);
         if (is_load) {
             do_fp_ld(s, rt2, tcg_addr, size);
         } else {
             do_fp_st(s, rt2, tcg_addr, size);
         }
     } else {
+        TCGv_i64 tcg_rt = cpu_reg(s, rt);
         TCGv_i64 tcg_rt2 = cpu_reg(s, rt2);
+
         if (is_load) {
+            TCGv_i64 tmp = tcg_temp_new_i64();
+
+            /* Do not modify tcg_rt before recognizing any exception
+             * from the second load.
+             */
+            do_gpr_ld(s, tmp, tcg_addr, size, is_signed, false,
+                      false, 0, false, false);
+            tcg_gen_addi_i64(tcg_addr, tcg_addr, 1 << size);
             do_gpr_ld(s, tcg_rt2, tcg_addr, size, is_signed, false,
                       false, 0, false, false);
+
+            tcg_gen_mov_i64(tcg_rt, tmp);
+            tcg_temp_free_i64(tmp);
         } else {
+            do_gpr_st(s, tcg_rt, tcg_addr, size,
+                      false, 0, false, false);
+            tcg_gen_addi_i64(tcg_addr, tcg_addr, 1 << size);
             do_gpr_st(s, tcg_rt2, tcg_addr, size,
                       false, 0, false, false);
         }
-- 
2.11.0
