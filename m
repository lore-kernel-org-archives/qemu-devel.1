Received: from eggs.gnu.org ([209.51.188.92]:40887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44a-0001NY-5W
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44Z-0003S1-3B
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB44Y-0003IZ-Oz
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:27 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1rdX122334
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:02:14 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksyg8qra-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:02:14 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:13 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:11 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-38-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 37/97] target/xtensa: fix s32c1i TCGMemOp flags
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

s32c1i must load and store value with target endianness, not host.
This results in an infinite loop in atomic cmpxchg sequences when target
endianness doesn't match host endianness.

Fixes: 9fb40342d4b3 ("target/xtensa: support MTTCG")
Cc: qemu-stable@nongnu.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 7a54cfbcee8dd7aa87ce655a321b622107556326)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/xtensa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 25399058a0..c626583cd9 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -2288,7 +2288,7 @@ static void translate_s32c1i(DisasContext *dc, const uint32_t arg[],
         gen_load_store_alignment(dc, 2, addr, true);
         gen_check_atomctl(dc, addr);
         tcg_gen_atomic_cmpxchg_i32(cpu_R[arg[0]], addr, cpu_SR[SCOMPARE1],
-                                   tmp, dc->cring, MO_32);
+                                   tmp, dc->cring, MO_TEUL);
         tcg_temp_free(addr);
         tcg_temp_free(tmp);
     }
-- 
2.17.1
