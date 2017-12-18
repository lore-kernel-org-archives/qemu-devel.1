Received: from eggs.gnu.org ([2001:4830:134:3::10]:51454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwiC-0000L5-NC
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:48:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwiB-0007pQ-QK
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:48:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eQwiB-0007ov-Kh
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:48:11 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 18 Dec 2017 14:47:57 +0000
Message-Id: <20171218144800.27337-2-stefanha@redhat.com>
In-Reply-To: <20171218144800.27337-1-stefanha@redhat.com>
References: <20171218144800.27337-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 1/4] trace: Simplify find_debugfs()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Namhyung Kim <namhyung@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Namhyung Kim <namhyung@gmail.com>

The return vale of find_debugfs() is 1 if it could find a mount point of
debugfs.  It can be saved in the while loop instead of checking it again.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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
