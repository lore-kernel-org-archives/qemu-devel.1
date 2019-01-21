Received: from eggs.gnu.org ([209.51.188.92]:38880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gld6h-0001z8-BB
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:11:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gld3D-0005hg-Cx
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:07:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gld3D-0005ga-2n
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:07:55 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0LH5Ou1094175
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 12:07:53 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q5gjhmjnw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 12:07:52 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Mon, 21 Jan 2019 17:07:51 -0000
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Mon, 21 Jan 2019 12:07:31 -0500
In-Reply-To: <20190121170731.2500692-1-stefanb@linux.ibm.com>
References: <20190121170731.2500692-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190121170731.2500692-5-stefanb@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/4] tpm: Make sure the locality received from
 backend is valid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-stable@nongnu.org, mdroth@linux.ibm.com
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>

From: Stefan Berger <stefanb@linux.vnet.ibm.com>

Make sure that the locality passed from the backend to
tpm_tis_request_completed() is valid.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
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
2.17.2
