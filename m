Received: from eggs.gnu.org ([2001:4830:134:3::10]:44555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <namhyung@gmail.com>) id 1eC5tF-0008Fv-6Z
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:34:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <namhyung@gmail.com>) id 1eC5tA-0007vw-7d
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:34:13 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:51903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <namhyung@gmail.com>) id 1eC5tA-0007vX-1V
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:34:08 -0500
Received: by mail-pf0-x244.google.com with SMTP id n14so10571281pfh.8
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 07:34:07 -0800 (PST)
From: Namhyung Kim <namhyung@gmail.com>
Date: Wed,  8 Nov 2017 00:31:34 +0900
Message-Id: <20171107153136.19426-1-namhyung@gmail.com>
Subject: [Qemu-devel] [PATCH 1/3] trace: Simplify find_debugfs()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org

The return vale of find_debugfs() is 1 if it could find a mount point of
debugfs.  It can be saved in the while loop instead of checking it again.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 trace/ftrace.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/trace/ftrace.c b/trace/ftrace.c
index 7de104deba..bfa38e71f0 100644
--- a/trace/ftrace.c
+++ b/trace/ftrace.c
@@ -19,6 +19,7 @@ static int find_debugfs(char *debugfs)
 {
     char type[100];
     FILE *fp;
+    int ret = 0;
 
     fp = fopen("/proc/mounts", "r");
     if (fp == NULL) {
@@ -28,15 +29,13 @@ static int find_debugfs(char *debugfs)
     while (fscanf(fp, "%*s %" STR(PATH_MAX) "s %99s %*s %*d %*d\n",
                   debugfs, type) == 2) {
         if (strcmp(type, "debugfs") == 0) {
+            ret = 1;
             break;
         }
     }
     fclose(fp);
 
-    if (strcmp(type, "debugfs") != 0) {
-        return 0;
-    }
-    return 1;
+    return ret;
 }
 
 bool ftrace_init(void)
-- 
2.14.3
