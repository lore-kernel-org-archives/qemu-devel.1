Received: from eggs.gnu.org ([2001:4830:134:3::10]:35411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ch8id-0005d9-69
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 00:47:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ch8ia-0005jW-Ei
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 00:47:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1ch8ia-0005i1-3i
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 00:47:00 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1O5hYP0014051
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 00:46:59 -0500
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28td8busgb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 00:46:58 -0500
Received: from localhost
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 24 Feb 2017 11:16:55 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri, 24 Feb 2017 11:16:42 +0530
In-Reply-To: <1487915204-23189-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487915204-23189-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487915204-23189-7-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v5 6/8] target/ppc: add ov32 flag for multiply
 low insns
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

For Multiply Word:
SO, OV, and OV32 bits reflects overflow of the 32-bit result

For Multiply DoubleWord:
SO, OV, and OV32 bits reflects overflow of the 64-bit result

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/ppc/translate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index d4d9941..ccf3bff 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1285,6 +1285,9 @@ static void gen_mullwo(DisasContext *ctx)
     tcg_gen_sari_i32(t0, t0, 31);
     tcg_gen_setcond_i32(TCG_COND_NE, t0, t0, t1);
     tcg_gen_extu_i32_tl(cpu_ov, t0);
+    if (is_isa300(ctx)) {
+        tcg_gen_mov_tl(cpu_ov32, cpu_ov);
+    }
     tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
 
     tcg_temp_free_i32(t0);
@@ -1346,6 +1349,9 @@ static void gen_mulldo(DisasContext *ctx)
 
     tcg_gen_sari_i64(t0, t0, 63);
     tcg_gen_setcond_i64(TCG_COND_NE, cpu_ov, t0, t1);
+    if (is_isa300(ctx)) {
+        tcg_gen_mov_tl(cpu_ov32, cpu_ov);
+    }
     tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
 
     tcg_temp_free_i64(t0);
-- 
2.7.4
