Received: from eggs.gnu.org ([2001:4830:134:3::10]:57031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgVMP-0000Rs-Rh
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:45:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgVMK-0003cb-UB
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:45:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgVMK-0003c7-Ks
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:45:24 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1MBiDo8125503
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 06:45:23 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28s7ww5kpu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 06:45:23 -0500
Received: from localhost
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 22 Feb 2017 17:15:20 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Wed, 22 Feb 2017 17:14:39 +0530
In-Reply-To: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487763883-4877-7-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 06/10] target/ppc: update overflow flags for
 add/sub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

* SO and OV reflects overflow of the 64-bit result in 64-bit mode and
  overflow of the low-order 32-bit result in 32-bit mode

* OV32 reflects overflow of the low-order 32-bit independent of the mode

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/translate.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index f3f92aa..43366e7 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -809,10 +809,19 @@ static inline void gen_op_arith_compute_ov(DisasContext *ctx, TCGv arg0,
         tcg_gen_andc_tl(cpu_ov, cpu_ov, t0);
     }
     tcg_temp_free(t0);
-    if (NARROW_MODE(ctx)) {
-        tcg_gen_ext32s_tl(cpu_ov, cpu_ov);
+    if (is_isa300(ctx)) {
+        tcg_gen_extract_tl(cpu_ov32, cpu_ov, 31, 1);
+        if (NARROW_MODE(ctx)) {
+            tcg_gen_mov_tl(cpu_ov, cpu_ov32);
+        } else {
+            tcg_gen_extract_tl(cpu_ov, cpu_ov, 63, 1);
+        }
+    } else {
+        if (NARROW_MODE(ctx)) {
+            tcg_gen_ext32s_tl(cpu_ov, cpu_ov);
+        }
+        tcg_gen_shri_tl(cpu_ov, cpu_ov, TARGET_LONG_BITS - 1);
     }
-    tcg_gen_shri_tl(cpu_ov, cpu_ov, TARGET_LONG_BITS - 1);
     tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
 }
 
-- 
2.7.4
