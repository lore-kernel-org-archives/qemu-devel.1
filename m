Received: from eggs.gnu.org ([2001:4830:134:3::10]:39963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmKV-0007VD-6h
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:41:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmKU-0005CO-AL
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:41:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eBmKU-0005Bu-4N
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:41:02 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  6 Nov 2017 19:39:16 +0100
Message-Id: <20171106183925.16747-20-marcandre.lureau@redhat.com>
In-Reply-To: <20171106183925.16747-1-marcandre.lureau@redhat.com>
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 19/28] tpm: add TPM interface to lookup TPM
 version
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

Do not hardcode TPM device model to lookup version, use an interface
instead.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 include/sysemu/tpm.h | 5 ++---
 hw/tpm/tpm_tis.c     | 5 +++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 2fe0f1e120..650b4b8565 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -42,6 +42,7 @@ typedef struct TPMIfClass {
=20
     enum TpmModel model;
     void (*request_completed)(TPMIf *obj);
+    enum TPMVersion (*get_version)(TPMIf *obj);
 } TPMIfClass;
=20
 #define TYPE_TPM_TIS                "tpm-tis"
@@ -54,15 +55,13 @@ static inline TPMIf *tpm_find(void)
     return TPM_IF(obj);
 }
=20
-TPMVersion tpm_tis_get_tpm_version(Object *obj);
-
 static inline TPMVersion tpm_get_version(TPMIf *ti)
 {
     if (!ti) {
         return TPM_VERSION_UNSPEC;
     }
=20
-    return tpm_tis_get_tpm_version(OBJECT(ti));
+    return TPM_IF_GET_CLASS(ti)->get_version(ti);
 }
=20
 #endif /* QEMU_TPM_H */
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 1e846f1201..a0b39b6211 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -990,9 +990,9 @@ static void tpm_tis_realloc_buffer(TPMSizedBuffer *sb=
)
 /*
  * Get the TPMVersion of the backend device being used
  */
-TPMVersion tpm_tis_get_tpm_version(Object *obj)
+static enum TPMVersion tpm_tis_get_tpm_version(TPMIf *ti)
 {
-    TPMState *s =3D TPM(obj);
+    TPMState *s =3D TPM(ti);
=20
     return tpm_backend_get_tpm_version(s->be_driver);
 }
@@ -1098,6 +1098,7 @@ static void tpm_tis_class_init(ObjectClass *klass, =
void *data)
     dc->reset =3D tpm_tis_reset;
     dc->vmsd  =3D &vmstate_tpm_tis;
     tc->model =3D TPM_MODEL_TPM_TIS;
+    tc->get_version =3D tpm_tis_get_tpm_version;
     tc->request_completed =3D tpm_tis_request_completed;
 }
=20
--=20
2.15.0.rc0.40.gaefcc5f6f
