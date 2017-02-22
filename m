Received: from eggs.gnu.org ([2001:4830:134:3::10]:49957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgTGS-0000uS-Tk
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:31:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgTGO-0006bh-SQ
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:31:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgTGO-0006ad-Jk
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:31:08 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1M9SrLW048102
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 04:31:07 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28ruy09ru8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 04:31:06 -0500
Received: from localhost
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 22 Feb 2017 19:31:04 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Wed, 22 Feb 2017 14:59:43 +0530
In-Reply-To: <1487755788-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487755788-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487755788-16415-7-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 06/11] target/ppc: update overflow flags for
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
 target/ppc/translate.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 184d10f..74185ba 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -809,10 +809,18 @@ static inline void gen_op_arith_compute_ov(DisasContext *ctx, TCGv arg0,
         tcg_gen_andc_tl(cpu_ov, cpu_ov, t0);
     }
     tcg_temp_free(t0);
-    if (NARROW_MODE(ctx)) {
-        tcg_gen_ext32s_tl(cpu_ov, cpu_ov);
+    if (is_isa300(ctx)) {
+        tcg_gen_extract_tl(cpu_ov32, cpu_ov, 31, 1);
+        tcg_gen_extract_tl(cpu_ov, cpu_ov, 63, 1);
+        if (NARROW_MODE(ctx)) {
+            tcg_gen_mov_tl(cpu_ov, cpu_ov32);
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
