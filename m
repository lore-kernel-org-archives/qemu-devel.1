Received: from eggs.gnu.org ([2001:4830:134:3::10]:39202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmJi-0006gS-8N
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmJd-0004No-7l
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eBmJc-0004NR-VM
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:09 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  6 Nov 2017 19:39:05 +0100
Message-Id: <20171106183925.16747-9-marcandre.lureau@redhat.com>
In-Reply-To: <20171106183925.16747-1-marcandre.lureau@redhat.com>
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 08/28] tpm: remove unused opened code
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
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 include/sysemu/tpm_backend.h | 12 ------------
 backends/tpm.c               | 42 --------------------------------------=
----
 tpm.c                        |  6 ------
 3 files changed, 60 deletions(-)

diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 665e807a73..904e5b1026 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -80,8 +80,6 @@ struct TPMBackendClass {
=20
     TpmTypeOptions *(*get_tpm_options)(TPMBackend *t);
=20
-    void (*opened)(TPMBackend *s, Error **errp);
-
     void (*handle_request)(TPMBackend *s, TPMBackendCmd *cmd);
 };
=20
@@ -171,16 +169,6 @@ bool tpm_backend_get_tpm_established_flag(TPMBackend=
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
index 4320f44c9f..32d398aadf 100644
--- a/tpm.c
+++ b/tpm.c
@@ -132,12 +132,6 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *op=
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
2.15.0.rc0.40.gaefcc5f6f
