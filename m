Received: from eggs.gnu.org ([2001:4830:134:3::10]:39711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmK6-00079L-Iz
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmK1-0004hW-O0
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eBmK1-0004hD-HY
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:33 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  6 Nov 2017 19:39:10 +0100
Message-Id: <20171106183925.16747-14-marcandre.lureau@redhat.com>
In-Reply-To: <20171106183925.16747-1-marcandre.lureau@redhat.com>
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 13/28] tpm-passthrough: make it safer to
 destroy after creation
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

Check fds values before closing, to avoid close(-1).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_passthrough.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 7371d50739..aa9167e3c6 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -347,8 +347,12 @@ static void tpm_passthrough_inst_finalize(Object *ob=
j)
=20
     tpm_passthrough_cancel_cmd(TPM_BACKEND(obj));
=20
-    qemu_close(tpm_pt->tpm_fd);
-    qemu_close(tpm_pt->cancel_fd);
+    if (tpm_pt->tpm_fd >=3D 0) {
+        qemu_close(tpm_pt->tpm_fd);
+    }
+    if (tpm_pt->cancel_fd >=3D 0) {
+        qemu_close(tpm_pt->cancel_fd);
+    }
     qapi_free_TPMPassthroughOptions(tpm_pt->options);
 }
=20
--=20
2.15.0.rc0.40.gaefcc5f6f
