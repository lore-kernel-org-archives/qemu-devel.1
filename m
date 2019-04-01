Received: from eggs.gnu.org ([209.51.188.92]:43019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB479-0003k8-SG
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB477-000514-RK
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42744
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB477-0004oS-He
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:05 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4g4r183541
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:04:50 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rksyp8p5p-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:04:46 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:03:06 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 16:00:00 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190401210011.16009-87-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 86/97] tpm: Make sure the locality received
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
Cc: qemu-stable@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>

From: Stefan Berger <stefanb@linux.vnet.ibm.com>

Make sure that the locality passed from the backend to
tpm_tis_request_completed() is valid.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
(cherry picked from commit a639f96111eadb3b8e3021fd3f27e2948ad1c640)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 9a795ce96c..1554026788 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -295,6 +295,8 @@ static void tpm_tis_request_completed(TPMIf *ti, int =
ret)
     uint8_t locty =3D s->cmd.locty;
     uint8_t l;
=20
+    assert(TPM_TIS_IS_VALID_LOCTY(locty));
+
     if (s->cmd.selftest_done) {
         for (l =3D 0; l < TPM_TIS_NUM_LOCALITIES; l++) {
             s->loc[l].sts |=3D TPM_TIS_STS_SELFTEST_DONE;
--=20
2.17.1
