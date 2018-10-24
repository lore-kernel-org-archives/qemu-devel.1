Received: from eggs.gnu.org ([2001:4830:134:3::10]:44378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gFBU8-00058k-TN
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 01:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gFBSn-0001R1-OX
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 01:12:17 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gFBSj-0001Cj-9y
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 01:12:11 -0400
Received: by mail-pg1-x542.google.com with SMTP id w3-v6so1743712pgs.11
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 22:12:07 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 23 Oct 2018 22:12:01 -0700
Message-Id: <1540357921-4199-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] fw_cfg: print error message when reading
 splashfile failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lersek@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

Also remove unnecessary 'res' variable.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/nvram/fw_cfg.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 946f765..f4a52d8 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -68,15 +68,14 @@ static char *read_splashfile(char *filename, gsize *file_sizep,
                              int *file_typep)
 {
     GError *err = NULL;
-    gboolean res;
     gchar *content;
     int file_type;
     unsigned int filehead;
     int bmp_bpp;
 
-    res = g_file_get_contents(filename, &content, file_sizep, &err);
-    if (res == FALSE) {
-        error_report("failed to read splash file '%s'", filename);
+    if (!g_file_get_contents(filename, &content, file_sizep, &err)) {
+        error_report("failed to read splash file '%s', %s",
+                     filename, err->message);
         g_error_free(err);
         return NULL;
     }
-- 
1.8.3.1
