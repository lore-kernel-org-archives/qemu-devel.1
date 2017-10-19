Received: from eggs.gnu.org ([2001:4830:134:3::10]:36360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5FAS-0007SE-DR
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5FAL-0007QX-FD
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e5FAL-0007OS-5I
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:33 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9JI0KHF042817
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:03:28 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dpykvbh42-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:03:28 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 19 Oct 2017 14:03:26 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 19 Oct 2017 14:02:39 -0400
In-Reply-To: <1508436175-1596-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1508436175-1596-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1508436175-1596-6-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 05/21] tpm: replace tpm_get_backend_driver()
 to drop be_drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, marcandre.lureau@gmail.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Use tpm_driver_find_by_type() instead.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 tpm.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tpm.c b/tpm.c
index 04de8da..ad2ed6a 100644
--- a/tpm.c
+++ b/tpm.c
@@ -31,13 +31,6 @@ void tpm_register_model(enum TpmModel model)
     tpm_models[model] =3D true;
 }
=20
-static const TPMDriverOps *tpm_get_backend_driver(const char *type)
-{
-    int i =3D qapi_enum_parse(&TpmType_lookup, type, -1, NULL);
-
-    return i >=3D 0 ? be_drivers[i] : NULL;
-}
-
 #ifdef CONFIG_TPM
=20
 void tpm_register_driver(const TPMDriverOps *tdo)
@@ -110,6 +103,7 @@ static int configure_tpm(QemuOpts *opts)
     const TPMDriverOps *be;
     TPMBackend *drv;
     Error *local_err =3D NULL;
+    int i;
=20
     if (!QLIST_EMPTY(&tpm_backends)) {
         error_report("Only one TPM is allowed.");
@@ -129,7 +123,8 @@ static int configure_tpm(QemuOpts *opts)
         return 1;
     }
=20
-    be =3D tpm_get_backend_driver(value);
+    i =3D qapi_enum_parse(&TpmType_lookup, value, -1, NULL);
+    be =3D i >=3D 0 ? tpm_driver_find_by_type(i) : NULL;
     if (be =3D=3D NULL) {
         error_report(QERR_INVALID_PARAMETER_VALUE,
                      "type", "a TPM backend type");
--=20
2.5.5
