Received: from eggs.gnu.org ([2001:4830:134:3::10]:45793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTW-0005qz-In
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTU-0008FY-L2
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56580
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eQGTU-0008Ex-GT
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:12 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBGHddN6066420
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:09 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2evxh66924-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:08 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 16 Dec 2017 10:42:08 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat, 16 Dec 2017 12:41:23 -0500
In-Reply-To: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513446109-9013-7-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 06/32] tpm-be: report error instead of
 front-end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Backend can give more accurate error description, and lift out the job
from the frontend.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 backends/tpm.c               | 3 ++-
 hw/tpm/tpm_tis.c             | 4 +---
 include/sysemu/tpm_backend.h | 3 ++-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/backends/tpm.c b/backends/tpm.c
index 58f823d..7b108bd 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -54,9 +54,10 @@ enum TpmType tpm_backend_get_type(TPMBackend *s)
     return k->type;
 }
=20
-int tpm_backend_init(TPMBackend *s, TPMIf *tpmif)
+int tpm_backend_init(TPMBackend *s, TPMIf *tpmif, Error **errp)
 {
     if (s->tpmif) {
+        error_setg(errp, "TPM backend '%s' is already initialized", s->i=
d);
         return -1;
     }
=20
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 95d3afc..bf291e6 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -1074,9 +1074,7 @@ static void tpm_tis_realizefn(DeviceState *dev, Err=
or **errp)
=20
     s->be_driver->fe_model =3D TPM_MODEL_TPM_TIS;
=20
-    if (tpm_backend_init(s->be_driver, TPM_IF(s))) {
-        error_setg(errp, "tpm_tis: backend driver with id %s could not b=
e "
-                   "initialized", s->backend);
+    if (tpm_backend_init(s->be_driver, TPM_IF(s), errp)) {
         return;
     }
=20
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index c5d1a68..df9ebd0 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -99,12 +99,13 @@ enum TpmType tpm_backend_get_type(TPMBackend *s);
  * @s: the backend to initialized
  * @tpmif: TPM interface
  * @datacb: callback for sending data to frontend
+ * @errp: a pointer to return the #Error object if an error occurs.
  *
  * Initialize the backend with the given variables.
  *
  * Returns 0 on success.
  */
-int tpm_backend_init(TPMBackend *s, TPMIf *tpmif);
+int tpm_backend_init(TPMBackend *s, TPMIf *tpmif, Error **errp);
=20
 /**
  * tpm_backend_startup_tpm:
--=20
2.5.5
