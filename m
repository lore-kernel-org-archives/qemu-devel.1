Received: from eggs.gnu.org ([2001:4830:134:3::10]:54024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g90lG-0008Nc-BV
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 00:33:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g90lB-0002N7-RB
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 00:33:46 -0400
Received: from m12-11.163.com ([220.181.12.11]:34711)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g90lB-0002JK-00
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 00:33:41 -0400
From: Li Qiang <liq3ea@163.com>
Date: Sat,  6 Oct 2018 21:33:35 -0700
Message-Id: <20181007043335.23631-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH] vl.c: print error message if load fw_cfg file
 failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

It makes sense to print the error message while reading
file failed.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 vl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index cc55fe04a2..3db410e771 100644
--- a/vl.c
+++ b/vl.c
@@ -2207,8 +2207,9 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
         size = strlen(str); /* NUL terminator NOT included in fw_cfg blob */
         buf = g_memdup(str, size);
     } else {
-        if (!g_file_get_contents(file, &buf, &size, NULL)) {
-            error_report("can't load %s", file);
+        GError *error = NULL;
+        if (!g_file_get_contents(file, &buf, &size, &error)) {
+            error_report("can't load %s, %s", file, error->message);
             return -1;
         }
     }
-- 
2.17.1
