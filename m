Received: from eggs.gnu.org ([2001:4830:134:3::10]:55335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1h08-0006qi-HD
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1h07-0005WL-DX
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1h07-0005Vr-7J
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:19 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:56:14 +0200
Message-Id: <20171009225623.29232-34-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 33/42] tpm-passthrough: remove error cleanup
 from handle_device_opts
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

Clean-up is handled by the create() function.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_passthrough.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index aa9167e3c6..0806cf86af 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -261,27 +261,16 @@ tpm_passthrough_handle_device_opts(TPMPassthruState=
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
     return 0;
-
- err_close_tpmdev:
-    qemu_close(tpm_pt->tpm_fd);
-    tpm_pt->tpm_fd =3D -1;
-
- err_free_parameters:
-    qapi_free_TPMPassthroughOptions(tpm_pt->options);
-    tpm_pt->options =3D NULL;
-    tpm_pt->tpm_dev =3D NULL;
-
-    return 1;
 }
=20
 static TPMBackend *tpm_passthrough_create(QemuOpts *opts)
--=20
2.14.1.146.gd35faa819
