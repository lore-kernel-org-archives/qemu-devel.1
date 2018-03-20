Received: from eggs.gnu.org ([2001:4830:134:3::10]:46708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eyOFm-0008LC-NE
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 16:53:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eyOFj-00022V-2j
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 16:53:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55364
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eyOFi-00022Q-SK
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 16:53:03 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2KKmeB5052592
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 16:53:02 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gu5x9swcf-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 16:53:01 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 20 Mar 2018 14:53:01 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 20 Mar 2018 16:52:51 -0400
In-Reply-To: <1521579171-26213-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1521579171-26213-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1521579171-26213-5-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 4/4] tpm: CRB: query backend for TPM
 established flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_crb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index e8c42f6..ef8b80e 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -84,6 +84,12 @@ static uint64_t tpm_crb_mmio_read(void *opaque, hwaddr addr,
     unsigned offset = addr & 3;
     uint32_t val = *(uint32_t *)regs >> (8 * offset);
 
+    switch (addr) {
+    case A_CRB_LOC_STATE:
+        val |= !tpm_backend_get_tpm_established_flag(s->tpmbe);
+        break;
+    }
+
     trace_tpm_crb_mmio_read(addr, size, val);
 
     return val;
-- 
2.5.5
