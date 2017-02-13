Received: from eggs.gnu.org ([2001:4830:134:3::10]:37983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cdCUg-0006Ae-4L
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:00:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cdCUa-00070k-83
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:00:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cdCUZ-000704-Ub
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:00:16 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1D8rvjb024888
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 04:00:14 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28hxta7pbm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 04:00:14 -0500
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 13 Feb 2017 19:00:10 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 684BD2CE8054
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 20:00:09 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v1D901c521627120
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 20:00:09 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
	by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v1D8xaPa016457
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 19:59:37 +1100
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Mon, 13 Feb 2017 14:29:12 +0530
In-Reply-To: <1486976352-549-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1486976352-549-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1486976352-549-2-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 2/2] risu_ppc64le: distinguish real illegal
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, joserz@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

While executing qemu_ppc64le, found an issue that the real illegal
instructions are handled as risu_op which results in wrong info at the
master end. Even the master needs to distinguish real illegal
instructions versus risu_op.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 risu_ppc64le.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/risu_ppc64le.c b/risu_ppc64le.c
index 9c1fafd..54a9bcb 100644
--- a/risu_ppc64le.c
+++ b/risu_ppc64le.c
@@ -55,7 +55,6 @@ int send_register_info(int sock, void *uc)
     switch (op) {
     case OP_COMPARE:
     case OP_TESTEND:
-    default:
         return send_data_pkt(sock, &ri, sizeof(ri));
     case OP_SETMEMBLOCK:
         memblock = (void*)ri.gregs[0];
@@ -66,6 +65,11 @@ int send_register_info(int sock, void *uc)
     case OP_COMPAREMEM:
         return send_data_pkt(sock, memblock, MEMBLOCKLEN);
         break;
+    default:
+      fprintf(stderr, "apprentice: Unhandled instruction\n");
+      fprintf(stderr, "  faulting insn        0x%x\n", ri.faulting_insn);
+      fprintf(stderr, "  insn addr            0x%" PRIx64 "\n\n", ri.nip);
+      return -1;
     }
     return 0;
 }
@@ -85,7 +89,6 @@ int recv_and_compare_register_info(int sock, void *uc)
     switch (op) {
     case OP_COMPARE:
     case OP_TESTEND:
-    default:
         if (recv_data_pkt(sock, &apprentice_ri, sizeof(apprentice_ri))) {
             packet_mismatch = 1;
             resp = 2;
@@ -113,6 +116,11 @@ int recv_and_compare_register_info(int sock, void *uc)
         }
         send_response_byte(sock, resp);
         break;
+    default:
+      fprintf(stderr, "master: Unhandled instruction\n");
+      fprintf(stderr, "  faulting insn    0x%x\n", master_ri.faulting_insn);
+      fprintf(stderr, "  insn addr        0x%" PRIx64 "\n\n", master_ri.nip);
+      return -1;
     }
     return resp;
 }
-- 
2.7.4
