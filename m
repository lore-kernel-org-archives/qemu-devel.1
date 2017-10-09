Received: from eggs.gnu.org ([2001:4830:134:3::10]:55314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1h06-0006pC-Qs
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1h03-0005Uv-PG
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1h03-0005Uj-J3
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:15 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:56:13 +0200
Message-Id: <20171009225623.29232-33-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 32/42] tpm-passthrough: make it safer to
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
2.14.1.146.gd35faa819
