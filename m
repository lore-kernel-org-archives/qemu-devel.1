Received: from eggs.gnu.org ([2001:4830:134:3::10]:39736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmK9-0007Av-4w
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmK8-0004m1-7q
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eBmK8-0004kq-1o
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:40 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  6 Nov 2017 19:39:11 +0100
Message-Id: <20171106183925.16747-15-marcandre.lureau@redhat.com>
In-Reply-To: <20171106183925.16747-1-marcandre.lureau@redhat.com>
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 14/28] tpm-passthrough: simplify create()
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

Use a similar code as tpm_emulator_create(), call handle_opts() and
handle failure cleanup with object_unref() in create().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_passthrough.c | 36 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index aa9167e3c6..788be3847d 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -261,49 +261,33 @@ tpm_passthrough_handle_device_opts(TPMPassthruState=
 *tpm_pt, QemuOpts *opts)
     if (tpm_pt->tpm_fd < 0) {
         error_report("Cannot access TPM device using '%s': %s",
                      tpm_pt->tpm_dev, strerror(errno));
-        goto err_free_parameters;
+        return -1;
     }
=20
     if (tpm_util_test_tpmdev(tpm_pt->tpm_fd, &tpm_pt->tpm_version)) {
         error_report("'%s' is not a TPM device.",
                      tpm_pt->tpm_dev);
-        goto err_close_tpmdev;
+        return -1;
     }
=20
-    return 0;
-
- err_close_tpmdev:
-    qemu_close(tpm_pt->tpm_fd);
-    tpm_pt->tpm_fd =3D -1;
-
- err_free_parameters:
-    qapi_free_TPMPassthroughOptions(tpm_pt->options);
-    tpm_pt->options =3D NULL;
-    tpm_pt->tpm_dev =3D NULL;
+    tpm_pt->cancel_fd =3D tpm_passthrough_open_sysfs_cancel(tpm_pt);
+    if (tpm_pt->cancel_fd < 0) {
+        return -1;
+    }
=20
-    return 1;
+    return 0;
 }
=20
 static TPMBackend *tpm_passthrough_create(QemuOpts *opts)
 {
     Object *obj =3D object_new(TYPE_TPM_PASSTHROUGH);
-    TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(obj);
=20
-    if (tpm_passthrough_handle_device_opts(tpm_pt, opts)) {
-        goto err_exit;
-    }
-
-    tpm_pt->cancel_fd =3D tpm_passthrough_open_sysfs_cancel(tpm_pt);
-    if (tpm_pt->cancel_fd < 0) {
-        goto err_exit;
+    if (tpm_passthrough_handle_device_opts(TPM_PASSTHROUGH(obj), opts)) =
{
+        object_unref(obj);
+        return NULL;
     }
=20
     return TPM_BACKEND(obj);
-
-err_exit:
-    object_unref(obj);
-
-    return NULL;
 }
=20
 static TpmTypeOptions *tpm_passthrough_get_tpm_options(TPMBackend *tb)
--=20
2.15.0.rc0.40.gaefcc5f6f
