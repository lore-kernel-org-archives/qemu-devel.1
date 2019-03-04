Received: from eggs.gnu.org ([209.51.188.92]:37933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1h0pp1-00040b-Uu
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:48:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1h0pov-0005oF-Oi
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:48:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40944
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1h0pou-0005dG-UP
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:48:01 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x24FiWAI000849
	for <qemu-devel@nongnu.org>; Mon, 4 Mar 2019 10:47:48 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2r16k6ha30-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:47:47 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 4 Mar 2019 15:47:47 -0000
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon,  4 Mar 2019 10:47:38 -0500
In-Reply-To: <20190304154739.758486-1-stefanb@linux.vnet.ibm.com>
References: <20190304154739.758486-1-stefanb@linux.vnet.ibm.com>
Message-Id: <20190304154739.758486-2-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v1 1/2] tpm_tis: fix loop that cancels any
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
Cc: peter.maydell@linaro.org, Liam Merwick <liam.merwick@oracle.com>, Liam Merwick <Liam.Merwick@oracle.com>, Stefan Berger <stefanb@linux.ibm.com>

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
---
 hw/tpm/tpm_tis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index fd6bb9b59a..61a130beef 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -624,7 +624,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
                 }
 
                 /* cancel any seize by a lower locality */
-                for (l = 0; l < locty - 1; l++) {
+                for (l = 0; l < locty; l++) {
                     s->loc[l].access &= ~TPM_TIS_ACCESS_SEIZE;
                 }
 
-- 
2.17.2
