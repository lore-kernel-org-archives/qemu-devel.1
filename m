Received: from eggs.gnu.org ([2001:4830:134:3::10]:39158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmJW-0006W0-FI
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmJS-0004Kv-DR
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eBmJS-0004KM-7x
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:39:58 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  6 Nov 2017 19:39:03 +0100
Message-Id: <20171106183925.16747-7-marcandre.lureau@redhat.com>
In-Reply-To: <20171106183925.16747-1-marcandre.lureau@redhat.com>
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 06/28] tpm-be: report error instead of
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
Cc: amarnath.valluri@intel.com, stefanb@linux.vnet.ibm.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Backend can give more accurate error description, and lift out the job
from the frontend.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 include/sysemu/tpm_backend.h | 3 ++-
 backends/tpm.c               | 3 ++-
 hw/tpm/tpm_tis.c             | 4 +---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index c5d1a6818a..df9ebd0e81 100644
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
diff --git a/backends/tpm.c b/backends/tpm.c
index 58f823d54c..7b108bd5d8 100644
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
index f81aaf10c3..2febc8bd08 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -1070,9 +1070,7 @@ static void tpm_tis_realizefn(DeviceState *dev, Err=
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
--=20
2.15.0.rc0.40.gaefcc5f6f
