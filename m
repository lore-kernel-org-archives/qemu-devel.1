Received: from eggs.gnu.org ([208.118.235.92]:54147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gfSIq-0005uI-85
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:26:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gfSIn-0002sD-AM
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:26:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gfSIn-0002kP-2b
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:26:29 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  4 Jan 2019 17:25:56 +0100
Message-Id: <20190104162559.20760-2-philmd@redhat.com>
In-Reply-To: <20190104162559.20760-1-philmd@redhat.com>
References: <20190104162559.20760-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/4] fw_cfg: Improve error message when can't
 load splash file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=83=C2=A9?= <philmd@redhat.com>, Li Qiang <liq3ea@gmail.com>

From: Li Qiang <liq3ea@gmail.com>

read_splashfile() reports "failed to read splash file" without
further details. Get the details from g_file_get_contents(), and
include them in the error message. Also remove unnecessary 'res'
variable.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <1541052148-28752-1-git-send-email-liq3ea@gmail.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/nvram/fw_cfg.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 3cb726ff68..9c4409be5e 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -68,15 +68,14 @@ static char *read_splashfile(char *filename, gsize *f=
ile_sizep,
                              int *file_typep)
 {
     GError *err =3D NULL;
-    gboolean res;
     gchar *content;
     int file_type;
     unsigned int filehead;
     int bmp_bpp;
=20
-    res =3D g_file_get_contents(filename, &content, file_sizep, &err);
-    if (res =3D=3D FALSE) {
-        error_report("failed to read splash file '%s'", filename);
+    if (!g_file_get_contents(filename, &content, file_sizep, &err)) {
+        error_report("failed to read splash file '%s': %s",
+                     filename, err->message);
         g_error_free(err);
         return NULL;
     }
--=20
2.17.2
