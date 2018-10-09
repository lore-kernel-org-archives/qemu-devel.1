Received: from eggs.gnu.org ([2001:4830:134:3::10]:41028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g9i36-0000bT-RY
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 22:47:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g9hvr-00073g-8o
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 22:39:38 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:38796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1g9hvr-00072q-15
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 22:39:35 -0400
Received: by mail-pg1-x52a.google.com with SMTP id f8-v6so47772pgq.5
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 19:39:33 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Mon,  8 Oct 2018 19:39:20 -0700
Message-Id: <1539052760-11730-1-git-send-email-liq3ea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] vl.c: print error message if load fw_cfg
 file failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, f4bug@amsat.org
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

It makes sense to print the error message while reading
file failed.

Change since v1:
free error

Signed-off-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 vl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index 4e25c78..69fc77c 100644
--- a/vl.c
+++ b/vl.c
@@ -2207,8 +2207,10 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
         size = strlen(str); /* NUL terminator NOT included in fw_cfg blob */
         buf = g_memdup(str, size);
     } else {
-        if (!g_file_get_contents(file, &buf, &size, NULL)) {
-            error_report("can't load %s", file);
+        GError *error = NULL;
+        if (!g_file_get_contents(file, &buf, &size, &error)) {
+            error_report("can't load %s, %s", file, error->message);
+            g_error_free(error);
             return -1;
         }
     }
-- 
1.8.3.1
