Received: from eggs.gnu.org ([2001:4830:134:3::10]:35914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gUCFh-0000sw-0I
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:04:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gUCFc-0004e7-Si
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:04:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33656
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1gUCFc-0004dh-Iz
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:04:40 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB4F08HH118094
	for <qemu-devel@nongnu.org>; Tue, 4 Dec 2018 10:04:40 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p5ue1sruj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 10:04:39 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 4 Dec 2018 15:04:38 -0000
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue,  4 Dec 2018 10:04:27 -0500
In-Reply-To: <20181204150427.2459814-1-stefanb@linux.vnet.ibm.com>
References: <20181204150427.2459814-1-stefanb@linux.vnet.ibm.com>
Message-Id: <20181204150427.2459814-4-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 3/3] tpm: Make sure the locality received
 from backend is valid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ppandit@redhat.com, marcandre.lureau@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>

Make sure that the locality passed from the backend to
tpm_tis_request_completed() is valid.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_tis.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 04e4ad9212..2563d7501f 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -295,6 +295,8 @@ static void tpm_tis_request_completed(TPMIf *ti, int ret)
     uint8_t locty = s->cmd.locty;
     uint8_t l;
 
+    assert(TPM_TIS_IS_VALID_LOCTY(locty));
+
     if (s->cmd.selftest_done) {
         for (l = 0; l < TPM_TIS_NUM_LOCALITIES; l++) {
             s->loc[l].sts |= TPM_TIS_STS_SELFTEST_DONE;
-- 
2.17.1
