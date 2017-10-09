Received: from eggs.gnu.org ([2001:4830:134:3::10]:55261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gzz-0006iK-Kl
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gzy-0005T6-ND
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1gzy-0005SL-E5
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:10 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:56:12 +0200
Message-Id: <20171009225623.29232-32-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 31/42] tpm-backend: move set 'id' to common code
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
 include/sysemu/tpm_backend.h |  2 +-
 hw/tpm/tpm_emulator.c        | 12 +++---------
 hw/tpm/tpm_passthrough.c     |  9 +++------
 tpm.c                        |  3 ++-
 4 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 594bb50782..881be97ee3 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -64,7 +64,7 @@ struct TPMBackendClass {
     /* get a descriptive text of the backend to display to the user */
     const char *desc;
=20
-    TPMBackend *(*create)(QemuOpts *opts, const char *id);
+    TPMBackend *(*create)(QemuOpts *opts);
=20
     /* start up the TPM on the backend - optional */
     int (*startup_tpm)(TPMBackend *t);
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 36454837b3..315819329b 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -453,22 +453,16 @@ err:
     return -1;
 }
=20
-static TPMBackend *tpm_emulator_create(QemuOpts *opts, const char *id)
+static TPMBackend *tpm_emulator_create(QemuOpts *opts)
 {
     TPMBackend *tb =3D TPM_BACKEND(object_new(TYPE_TPM_EMULATOR));
=20
-    tb->id =3D g_strdup(id);
-
     if (tpm_emulator_handle_device_opts(TPM_EMULATOR(tb), opts)) {
-        goto err_exit;
+        object_unref(OBJECT(tb));
+        return NULL;
     }
=20
     return tb;
-
-err_exit:
-    object_unref(OBJECT(tb));
-
-    return NULL;
 }
=20
 static TpmTypeOptions *tpm_emulator_get_tpm_options(TPMBackend *tb)
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 9326cbfdc9..7371d50739 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -284,13 +284,10 @@ tpm_passthrough_handle_device_opts(TPMPassthruState=
 *tpm_pt, QemuOpts *opts)
     return 1;
 }
=20
-static TPMBackend *tpm_passthrough_create(QemuOpts *opts, const char *id=
)
+static TPMBackend *tpm_passthrough_create(QemuOpts *opts)
 {
     Object *obj =3D object_new(TYPE_TPM_PASSTHROUGH);
-    TPMBackend *tb =3D TPM_BACKEND(obj);
-    TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
-
-    tb->id =3D g_strdup(id);
+    TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(obj);
=20
     if (tpm_passthrough_handle_device_opts(tpm_pt, opts)) {
         goto err_exit;
@@ -301,7 +298,7 @@ static TPMBackend *tpm_passthrough_create(QemuOpts *o=
pts, const char *id)
         goto err_exit;
     }
=20
-    return tb;
+    return TPM_BACKEND(obj);
=20
 err_exit:
     object_unref(obj);
diff --git a/tpm.c b/tpm.c
index a46ee5f144..37298f3f03 100644
--- a/tpm.c
+++ b/tpm.c
@@ -129,11 +129,12 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *o=
pts, Error **errp)
         return 1;
     }
=20
-    drv =3D be->create(opts, id);
+    drv =3D be->create(opts);
     if (!drv) {
         return 1;
     }
=20
+    drv->id =3D g_strdup(id);
     QLIST_INSERT_HEAD(&tpm_backends, drv, list);
=20
     return 0;
--=20
2.14.1.146.gd35faa819
