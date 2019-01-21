Received: from eggs.gnu.org ([209.51.188.92]:38880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gld6l-0001z8-EG
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:11:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gld3A-0005eu-2L
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:07:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gld39-0005c3-OQ
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:07:52 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0LH5CXn073955
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 12:07:50 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q5ffpfxjb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 12:07:49 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Mon, 21 Jan 2019 17:07:49 -0000
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Mon, 21 Jan 2019 12:07:30 -0500
In-Reply-To: <20190121170731.2500692-1-stefanb@linux.ibm.com>
References: <20190121170731.2500692-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190121170731.2500692-4-stefanb@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/4] tpm: Make sure new locality passed to
 tpm_tis_prep_abort() is valid
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

Make sure that the new locality passed to tpm_tis_prep_abort()
is valid.

Add a comment to aborting_locty that it may be any locality, including
TPM_TIS_NO_LOCALITY.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_tis.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index d9322692ee..9a795ce96c 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -263,7 +263,9 @@ static void tpm_tis_prep_abort(TPMState *s, uint8_t l=
octy, uint8_t newlocty)
 {
     uint8_t busy_locty;
=20
-    s->aborting_locty =3D locty;
+    assert(TPM_TIS_IS_VALID_LOCTY(newlocty));
+
+    s->aborting_locty =3D locty; /* may also be TPM_TIS_NO_LOCALITY */
     s->next_locty =3D newlocty;  /* locality after successful abort */
=20
     /*
--=20
2.17.2
