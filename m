Received: from eggs.gnu.org ([2001:4830:134:3::10]:38010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1f88F3-0000KG-TK
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 13:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1f88Ey-00089n-P6
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 13:48:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1f88Ey-00087b-Fo
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 13:48:32 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3GHjGu7131718
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 13:48:29 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hcy58kwch-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 13:48:28 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 16 Apr 2018 13:48:27 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 16 Apr 2018 13:48:17 -0400
Message-Id: <1523900897-6630-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] tests: request access to locality 0 before
 sending command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@gmail.com, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>

Recent changes to the CRB code now require that access to locality 0
be requested before the locality can be used for sending a command.
This patch adds the request to access the locality.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 tests/tpm-util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/tpm-util.c b/tests/tpm-util.c
index 4967a4e..6910503 100644
--- a/tests/tpm-util.c
+++ b/tests/tpm-util.c
@@ -25,6 +25,8 @@ void tpm_util_crb_transfer(QTestState *s,
     uint64_t caddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_LADDR);
     uint64_t raddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_ADDR);
 
+    qtest_writeb(s, TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL, 1);
+
     qtest_memwrite(s, caddr, req, req_size);
 
     uint32_t sts, start = 1;
-- 
2.5.5
