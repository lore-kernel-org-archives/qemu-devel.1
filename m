Received: from eggs.gnu.org ([2001:4830:134:3::10]:55344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gTrbF-0003ON-9D
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:01:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gTrbB-0002vr-Lg
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:01:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1gTrbB-0002lk-7T
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:01:33 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB3GuE2r033901
	for <qemu-devel@nongnu.org>; Mon, 3 Dec 2018 12:01:15 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p57kp3pgb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 12:01:14 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 3 Dec 2018 17:01:13 -0000
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon,  3 Dec 2018 12:01:05 -0500
In-Reply-To: <20181203170105.2367492-1-stefanb@linux.vnet.ibm.com>
References: <20181203170105.2367492-1-stefanb@linux.vnet.ibm.com>
Message-Id: <20181203170105.2367492-3-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 2/2] tpm: Make sure new locality passed to
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
is valid. This is merely a precaution since none of the current
callers passes an invalid locality number into this function.

Add a comment to aborting_locty that it may be any locality, including
TPM_TIS_NO_LOCALITY.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_tis.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 176d424ed9..9b2737b5bf 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -263,7 +263,10 @@ static void tpm_tis_prep_abort(TPMState *s, uint8_t locty, uint8_t newlocty)
 {
     uint8_t busy_locty;
 
-    s->aborting_locty = locty;
+    if (!TPM_TIS_IS_VALID_LOCTY(newlocty))
+        return;
+
+    s->aborting_locty = locty; /* may also be TPM_TIS_NO_LOCALITY */
     s->next_locty = newlocty;  /* locality after successful abort */
 
     /*
-- 
2.17.1
