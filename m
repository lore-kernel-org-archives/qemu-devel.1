Received: from eggs.gnu.org ([2001:4830:134:3::10]:45919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTi-00062C-E3
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTe-0008TJ-Gt
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eQGTe-0008S0-7n
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:22 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBGHfpHC019071
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:21 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2evypbcgur-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:21 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 16 Dec 2017 10:42:20 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat, 16 Dec 2017 12:41:31 -0500
In-Reply-To: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513446109-9013-15-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 14/32] tpm-passthrough: simplify create()
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

Use a similar code as tpm_emulator_create(), call handle_opts() and
handle failure cleanup with object_unref() in create().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_passthrough.c | 36 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index aa9167e..788be38 100644
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
2.5.5
