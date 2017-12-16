Received: from eggs.gnu.org ([2001:4830:134:3::10]:45895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTe-0005y5-K0
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTa-0008O8-Lq
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45414
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eQGTa-0008NU-Gb
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:18 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBGHdUid134479
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:16 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ew0h5k6wc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:16 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 16 Dec 2017 10:42:15 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat, 16 Dec 2017 12:41:29 -0500
In-Reply-To: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513446109-9013-13-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 12/32] tpm-backend: move set 'id' to common
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
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_emulator.c        | 12 +++---------
 hw/tpm/tpm_passthrough.c     |  9 +++------
 include/sysemu/tpm_backend.h |  2 +-
 tpm.c                        |  3 ++-
 4 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 47f37d6..94e6660 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -463,22 +463,16 @@ err:
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
index 9326cbf..7371d50 100644
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
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index ce8dee5..1ad27ec 100644
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
diff --git a/tpm.c b/tpm.c
index 32d398a..520f449 100644
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
2.5.5
