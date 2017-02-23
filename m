Received: from eggs.gnu.org ([2001:4830:134:3::10]:41305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVm-0005QT-PU
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVl-0001nU-6q
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46958
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgzVk-0001mq-Ve
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:09 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1NJsArJ069998
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:08 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28t39t0ek0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:07 -0500
Received: from localhost
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 24 Feb 2017 01:27:05 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri, 24 Feb 2017 01:26:38 +0530
In-Reply-To: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487879800-12352-14-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 13/15] target/ppc: update OV/OV32 flags for
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
index f7d37b0..dc75cca 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -874,6 +874,7 @@ static inline void gen_op_arith_compute_ov(DisasContext *ctx, TCGv arg0,
 {
     TCGv t0 = tcg_temp_new();
     TCGv ov = tcg_temp_new();
+    TCGv ov32 = tcg_temp_new();
 
     tcg_gen_xor_tl(ov, arg0, arg2);
     tcg_gen_xor_tl(t0, arg1, arg2);
@@ -884,11 +885,19 @@ static inline void gen_op_arith_compute_ov(DisasContext *ctx, TCGv arg0,
     }
     tcg_temp_free(t0);
     if (NARROW_MODE(ctx)) {
-        tcg_gen_ext32s_tl(ov, ov);
+        tcg_gen_extract_tl(ov, ov, 31, 1);
+        if (is_isa300(ctx)) {
+            tcg_gen_mov_tl(ov32, ov);
+        }
+    } else {
+        if (is_isa300(ctx)) {
+            tcg_gen_extract_tl(ov32, ov, 31, 1);
+        }
+        tcg_gen_extract_tl(ov, ov, 63, 1);
     }
-    tcg_gen_shri_tl(ov, ov, TARGET_LONG_BITS - 1);
-    gen_op_update_ov_legacy(ov);
+    gen_op_update_ov(ctx, ov, ov32);
     tcg_temp_free(ov);
+    tcg_temp_free(ov32);
 }
 
 static inline void gen_op_arith_compute_ca32(DisasContext *ctx, TCGv ca32,
-- 
2.7.4
