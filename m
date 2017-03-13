Received: from eggs.gnu.org ([2001:4830:134:3::10]:38464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cnMKH-0001px-2J
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 05:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cnMKD-000349-SK
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 05:31:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cnMKD-00033F-Ix
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 05:31:33 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2D9O0rg125597
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 05:31:31 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
	by mx0a-001b2d01.pphosted.com with ESMTP id 294de12xxm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 05:31:30 -0400
Received: from localhost
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 13 Mar 2017 15:01:27 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Mon, 13 Mar 2017 15:01:04 +0530
Message-Id: <20170313093104.1280-1-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH fix for-2.9] target/ppc: fix cpu_ov setting for
 32-bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, mark.cave-ayland@ilande.co.uk
Cc: qemu-devel@nongnu.org, rth@twiddle.net, nikunj@linux.vnet.ibm.com

A bug was introduced in following commit:

    dc0ad84 target/ppc: update overflow flags for add/sub

As for 32-bit ppc target extracting bit 63 for overflow is not correct.
Made it dependent on TARGET_LOG_BITS. This had broken booting MacOS
9.2.1 image

Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b6abc60..f40b5a1 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -818,7 +818,7 @@ static inline void gen_op_arith_compute_ov(DisasContext *ctx, TCGv arg0,
         if (is_isa300(ctx)) {
             tcg_gen_extract_tl(cpu_ov32, cpu_ov, 31, 1);
         }
-        tcg_gen_extract_tl(cpu_ov, cpu_ov, 63, 1);
+        tcg_gen_extract_tl(cpu_ov, cpu_ov, TARGET_LONG_BITS - 1, 1);
     }
     tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
 }
-- 
2.9.3
