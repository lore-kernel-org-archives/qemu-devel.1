Received: from eggs.gnu.org ([2001:4830:134:3::10]:51374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gFA3q-0001ir-3r
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 23:42:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gFA1B-00019N-FU
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 23:39:42 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gFA1B-0000on-4S
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 23:39:37 -0400
Received: by mail-pl1-x644.google.com with SMTP id x6-v6so1609453pln.0
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 20:39:21 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 23 Oct 2018 20:39:09 -0700
Message-Id: <1540352349-12737-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] vl.c: print error message if loading fw_cfg
 file failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, philmd@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

It makes sense to print the error message while reading
file failed.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 vl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index b2a405f..ee6f982 100644
--- a/vl.c
+++ b/vl.c
@@ -2234,8 +2234,10 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
         size = strlen(str); /* NUL terminator NOT included in fw_cfg blob */
         buf = g_memdup(str, size);
     } else {
-        if (!g_file_get_contents(file, &buf, &size, NULL)) {
-            error_setg(errp, "can't load %s", file);
+        GError *err = NULL;
+        if (!g_file_get_contents(file, &buf, &size, &err)) {
+            error_setg(errp, "can't load %s, %s", file, err->message);
+            g_error_free(err);
             return -1;
         }
     }
-- 
1.8.3.1
