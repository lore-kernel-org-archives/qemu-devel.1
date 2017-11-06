Received: from eggs.gnu.org ([2001:4830:134:3::10]:39611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmJy-00071w-E2
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmJw-0004ei-Jy
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eBmJw-0004e9-6d
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:28 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  6 Nov 2017 19:39:09 +0100
Message-Id: <20171106183925.16747-13-marcandre.lureau@redhat.com>
In-Reply-To: <20171106183925.16747-1-marcandre.lureau@redhat.com>
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 12/28] tpm-backend: move set 'id' to common
 code
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
 include/sysemu/tpm_backend.h |  2 +-
 hw/tpm/tpm_emulator.c        | 12 +++---------
 hw/tpm/tpm_passthrough.c     |  9 +++------
 tpm.c                        |  3 ++-
 4 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index ce8dee58cf..1ad27ec374 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -63,7 +63,7 @@ struct TPMBackendClass {
     /* get a descriptive text of the backend to display to the user */
     const char *desc;
=20
-    TPMBackend *(*create)(QemuOpts *opts, const char *id);
+    TPMBackend *(*create)(QemuOpts *opts);
=20
     /* start up the TPM on the backend - optional */
     int (*startup_tpm)(TPMBackend *t);
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 883e8c0c2d..ff5fcbae03 100644
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
index 32d398aadf..520f449234 100644
--- a/tpm.c
+++ b/tpm.c
@@ -127,11 +127,12 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *o=
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
2.15.0.rc0.40.gaefcc5f6f
