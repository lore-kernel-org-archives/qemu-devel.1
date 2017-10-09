Received: from eggs.gnu.org ([2001:4830:134:3::10]:55530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1h0V-000791-Le
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1h0U-0005fd-Pm
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1h0U-0005fI-JK
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:42 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:56:19 +0200
Message-Id: <20171009225623.29232-39-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 38/42] tpm: add TPM interface to lookup TPM
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
---
 include/sysemu/tpm.h | 5 ++---
 hw/tpm/tpm_tis.c     | 5 +++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index dbd2b0cc7a..9439330cf1 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -38,6 +38,7 @@ typedef struct TPMIfClass {
=20
     enum TpmModel model;
     void (*request_completed)(TPMIf *obj);
+    enum TPMVersion (*get_version)(TPMIf *obj);
 } TPMIfClass;
=20
 int tpm_config_parse(QemuOptsList *opts_list, const char *optarg);
@@ -53,15 +54,13 @@ static inline TPMIf *tpm_find(void)
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
index 954b7b0e5d..6aac9bfe6b 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -989,9 +989,9 @@ static void tpm_tis_realloc_buffer(TPMSizedBuffer *sb=
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
@@ -1097,6 +1097,7 @@ static void tpm_tis_class_init(ObjectClass *klass, =
void *data)
     dc->reset =3D tpm_tis_reset;
     dc->vmsd  =3D &vmstate_tpm_tis;
     tc->model =3D TPM_MODEL_TPM_TIS;
+    tc->get_version =3D tpm_tis_get_tpm_version;
     tc->request_completed =3D tpm_tis_request_completed;
 }
=20
--=20
2.14.1.146.gd35faa819
