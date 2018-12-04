Received: from eggs.gnu.org ([2001:4830:134:3::10]:35895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gUCFf-0000su-48
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:04:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gUCFb-0004cy-2e
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:04:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1gUCFa-0004ca-OT
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:04:39 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB4F0inQ015189
	for <qemu-devel@nongnu.org>; Tue, 4 Dec 2018 10:04:37 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p5urbgm6a-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 10:04:37 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 4 Dec 2018 15:04:35 -0000
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue,  4 Dec 2018 10:04:26 -0500
In-Reply-To: <20181204150427.2459814-1-stefanb@linux.vnet.ibm.com>
References: <20181204150427.2459814-1-stefanb@linux.vnet.ibm.com>
Message-Id: <20181204150427.2459814-3-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 2/3] tpm: Make sure new locality passed to
 tpm_tis_prep_abort() is valid
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

Make sure that the new locality passed to tpm_tis_prep_abort()
is valid.

Add a comment to aborting_locty that it may be any locality, including
TPM_TIS_NO_LOCALITY.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_tis.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 176d424ed9..04e4ad9212 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -263,7 +263,9 @@ static void tpm_tis_prep_abort(TPMState *s, uint8_t locty, uint8_t newlocty)
 {
     uint8_t busy_locty;
 
-    s->aborting_locty = locty;
+    assert(TPM_TIS_IS_VALID_LOCTY(newlocty));
+
+    s->aborting_locty = locty; /* may also be TPM_TIS_NO_LOCALITY */
     s->next_locty = newlocty;  /* locality after successful abort */
 
     /*
-- 
2.17.1
