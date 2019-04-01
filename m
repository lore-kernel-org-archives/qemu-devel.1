Received: from eggs.gnu.org ([209.51.188.92]:43044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB47A-0003lB-Jy
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB478-00052G-AO
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43908
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB477-0004qt-NN
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:06 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4hvR183611
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:04:54 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rksyp8p94-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:04:49 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:03:12 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 16:00:05 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-92-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 91/97] tpm_tis: fix loop that cancels any
 seizure by a lower locality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Liam Merwick <liam.merwick@oracle.com>, Liam Merwick <Liam.Merwick@oracle.com>, Stefan Berger <stefanb@linux.ibm.com>

From: Liam Merwick <liam.merwick@oracle.com>

In tpm_tis_mmio_write() if the requesting locality is seizing
access, any seizure by a lower locality is cancelled.  However the
loop doing the seizure had an off-by-one error and the locality
immediately preceding the requesting locality was not being cleared.
This is fixed by adjusting the test in the for loop to check the
localities up to the requesting locality.

Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
(cherry picked from commit 37b55d67c0f001b20b7831db3f9f24f1d453e1de)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 1554026788..fb08b483bc 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -620,7 +620,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
                 }
 
                 /* cancel any seize by a lower locality */
-                for (l = 0; l < locty - 1; l++) {
+                for (l = 0; l < locty; l++) {
                     s->loc[l].access &= ~TPM_TIS_ACCESS_SEIZE;
                 }
 
-- 
2.17.1
