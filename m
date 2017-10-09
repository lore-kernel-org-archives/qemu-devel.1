Received: from eggs.gnu.org ([2001:4830:134:3::10]:55201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gzs-0006ap-1E
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gzr-0005Ox-9p
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1gzr-0005Od-3T
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:03 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:56:09 +0200
Message-Id: <20171009225623.29232-29-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 28/42] tpm-passthrough: don't save guessed
 cancel_path in options
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

The value is later unneeded, and may leak if the free visitor doesn't
consider it since has_cancel_path is false. And for consistency with
"path" it shouldn't be returned in get_tpm_options().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_passthrough.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 8c002e4da6..048edb1a1a 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -226,9 +226,7 @@ static int tpm_passthrough_open_sysfs_cancel(TPMPasst=
hruState *tpm_pt)
         if (snprintf(path, sizeof(path), "/sys/class/misc/%s/device/canc=
el",
                      dev) < sizeof(path)) {
             fd =3D qemu_open(path, O_WRONLY);
-            if (fd >=3D 0) {
-                tpm_pt->options->cancel_path =3D g_strdup(path);
-            } else {
+            if (fd < 0) {
                 error_report("tpm_passthrough: Could not open TPM cancel=
 "
                              "path %s : %s", path, strerror(errno));
             }
--=20
2.14.1.146.gd35faa819
