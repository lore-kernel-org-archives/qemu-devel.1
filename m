Received: from eggs.gnu.org ([2001:4830:134:3::10]:35481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gI63z-0001RQ-0M
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 02:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gI63u-0007sV-2M
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 02:02:38 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gI63t-0007s3-Si
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 02:02:33 -0400
Received: by mail-pg1-x542.google.com with SMTP id r9-v6so8513387pgv.6
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 23:02:33 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 31 Oct 2018 23:02:28 -0700
Message-Id: <1541052148-28752-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] hw: fw_cfg: Improve error message when can't
 load splash file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, armbru@redhat.com, philmd@redhat.com, lersek@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

read_splashfile() reports "failed to read splash file" without
further details. Get the details from g_file_get_contents(), and
include them in the error message. Also remove unnecessary 'res'
variable.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/nvram/fw_cfg.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 946f765..3fcfa35 100644
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
+        error_report("failed to read splash file '%s': %s",
+                     filename, err->message);
         g_error_free(err);
         return NULL;
     }
-- 
1.8.3.1
