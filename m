Received: from eggs.gnu.org ([2001:4830:134:3::10]:55189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gzq-0006ZH-HW
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gzp-0005ON-As
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1gzp-0005No-2f
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:01 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:56:08 +0200
Message-Id: <20171009225623.29232-28-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 27/42] tpm: remove unused opened code
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/tpm_backend.h | 12 ------------
 backends/tpm.c               | 42 --------------------------------------=
----
 tpm.c                        |  6 ------
 3 files changed, 60 deletions(-)

diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index b12ae5b625..a893e586ae 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -81,8 +81,6 @@ struct TPMBackendClass {
=20
     TpmTypeOptions *(*get_tpm_options)(TPMBackend *t);
=20
-    void (*opened)(TPMBackend *s, Error **errp);
-
     void (*handle_request)(TPMBackend *s, TPMBackendCmd *cmd);
 };
=20
@@ -172,16 +170,6 @@ bool tpm_backend_get_tpm_established_flag(TPMBackend=
 *s);
  */
 int tpm_backend_reset_tpm_established_flag(TPMBackend *s, uint8_t locty)=
;
=20
-/**
- * tpm_backend_open:
- * @s: the backend to open
- * @errp: a pointer to return the #Error object if an error occurs.
- *
- * This function will open the backend if it is not already open.  Calli=
ng this
- * function on an already opened backend will not result in an error.
- */
-void tpm_backend_open(TPMBackend *s, Error **errp);
-
 /**
  * tpm_backend_get_tpm_version:
  * @s: the backend to call into
diff --git a/backends/tpm.c b/backends/tpm.c
index 0c48d18775..7e636fbc7a 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -159,52 +159,10 @@ TPMInfo *tpm_backend_query_tpm(TPMBackend *s)
     return info;
 }
=20
-static bool tpm_backend_prop_get_opened(Object *obj, Error **errp)
-{
-    TPMBackend *s =3D TPM_BACKEND(obj);
-
-    return s->opened;
-}
-
-void tpm_backend_open(TPMBackend *s, Error **errp)
-{
-    object_property_set_bool(OBJECT(s), true, "opened", errp);
-}
-
-static void tpm_backend_prop_set_opened(Object *obj, bool value, Error *=
*errp)
-{
-    TPMBackend *s =3D TPM_BACKEND(obj);
-    TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
-    Error *local_err =3D NULL;
-
-    if (value =3D=3D s->opened) {
-        return;
-    }
-
-    if (!value && s->opened) {
-        error_setg(errp, QERR_PERMISSION_DENIED);
-        return;
-    }
-
-    if (k->opened) {
-        k->opened(s, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
-    }
-
-    s->opened =3D true;
-}
-
 static void tpm_backend_instance_init(Object *obj)
 {
     TPMBackend *s =3D TPM_BACKEND(obj);
=20
-    object_property_add_bool(obj, "opened",
-                             tpm_backend_prop_get_opened,
-                             tpm_backend_prop_set_opened,
-                             NULL);
     s->bh =3D qemu_bh_new(tpm_backend_request_completed_bh, s);
 }
=20
diff --git a/tpm.c b/tpm.c
index ce1543fcb4..a46ee5f144 100644
--- a/tpm.c
+++ b/tpm.c
@@ -134,12 +134,6 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *op=
ts, Error **errp)
         return 1;
     }
=20
-    tpm_backend_open(drv, &local_err);
-    if (local_err) {
-        error_report_err(local_err);
-        return 1;
-    }
-
     QLIST_INSERT_HEAD(&tpm_backends, drv, list);
=20
     return 0;
--=20
2.14.1.146.gd35faa819
