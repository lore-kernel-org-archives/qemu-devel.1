Received: from eggs.gnu.org ([209.51.188.92]:42852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB476-0003fZ-Pn
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB475-0004yG-Lf
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42666
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB475-0004oD-G4
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:03 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4fnT183532
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:04:50 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rksyp8n0h-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:04:44 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:01:56 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:03 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-30-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 29/97] target/xtensa: fix FPU2000 bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>

From: Max Filippov <jcmvbkbc@gmail.com>

- FPU2000 defines rfr and wfr opcodes, not rfr.s and wfr.s;
- movcond.s uses incorrect operand in tcg_gen_movcond: in case the
  condition is not satisfied it must not change its argument 0.

Fixes: c04e1692e3aa ("target/xtensa: extract FPU2000 opcode
translators")
Cc: qemu-stable@nongnu.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
(cherry picked from commit e8e05fd472cbe77650353eaa50d5a9703a91c1db)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/xtensa/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index d22cdcdb16..25399058a0 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -4706,7 +4706,7 @@ static void translate_movcond_s(DisasContext *dc, const uint32_t arg[],
 
         tcg_gen_movcond_i32(par[0], cpu_FR[arg[0]],
                             cpu_R[arg[2]], zero,
-                            cpu_FR[arg[1]], cpu_FR[arg[2]]);
+                            cpu_FR[arg[1]], cpu_FR[arg[0]]);
         tcg_temp_free(zero);
     }
 }
@@ -4867,7 +4867,7 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
         .translate = translate_compare_s,
         .par = (const uint32_t[]){COMPARE_OLT},
     }, {
-        .name = "rfr.s",
+        .name = "rfr",
         .translate = translate_rfr_s,
     }, {
         .name = "round.s",
@@ -4921,7 +4921,7 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
         .translate = translate_ftoi_s,
         .par = (const uint32_t[]){float_round_to_zero, true},
     }, {
-        .name = "wfr.s",
+        .name = "wfr",
         .translate = translate_wfr_s,
     },
 };
-- 
2.17.1
