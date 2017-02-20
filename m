Received: from eggs.gnu.org ([2001:4830:134:3::10]:44246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cfkym-00014P-BE
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:14:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cfkyi-0002wn-MF
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:14:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cfkyi-0002wJ-Cp
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:13:56 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KAA34R118112
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 05:13:55 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28pnxq8s7d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 05:13:55 -0500
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 20 Feb 2017 20:13:52 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Mon, 20 Feb 2017 15:41:59 +0530
In-Reply-To: <1487585521-19445-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487585521-19445-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487585521-19445-9-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 08/10] target/ppc: add ov32 flag for
 multiply low insns
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
---
 target/ppc/translate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 0168e1c..69ec0b2 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1286,6 +1286,7 @@ static void gen_mullwo(DisasContext *ctx)
     tcg_gen_sari_i32(t0, t0, 31);
     tcg_gen_setcond_i32(TCG_COND_NE, t0, t0, t1);
     tcg_gen_extu_i32_tl(cpu_ov, t0);
+    tcg_gen_mov_tl(cpu_ov32, cpu_ov);
     tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
 
     tcg_temp_free_i32(t0);
@@ -1347,6 +1348,7 @@ static void gen_mulldo(DisasContext *ctx)
 
     tcg_gen_sari_i64(t0, t0, 63);
     tcg_gen_setcond_i64(TCG_COND_NE, cpu_ov, t0, t1);
+    tcg_gen_mov_tl(cpu_ov32, cpu_ov);
     tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
 
     tcg_temp_free_i64(t0);
-- 
2.7.4
