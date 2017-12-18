Received: from eggs.gnu.org ([2001:4830:134:3::10]:51498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwiK-0000Re-AK
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:48:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwiG-0007ui-I8
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:48:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eQwiG-0007tb-CZ
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:48:16 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 18 Dec 2017 14:47:58 +0000
Message-Id: <20171218144800.27337-3-stefanha@redhat.com>
In-Reply-To: <20171218144800.27337-1-stefanha@redhat.com>
References: <20171218144800.27337-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 2/4] trace: Generalize searching for debugfs
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

The find_debugfs() can be shared to find a different filesystem like
tracefs.  So make it more general and rename to find_mount().

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 trace/ftrace.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/trace/ftrace.c b/trace/ftrace.c
index bfa38e71f0..213cb2205f 100644
--- a/trace/ftrace.c
+++ b/trace/ftrace.c
@@ -15,7 +15,7 @@
 
 int trace_marker_fd;
 
-static int find_debugfs(char *debugfs)
+static int find_mount(char *mount_point, const char *fstype)
 {
     char type[100];
     FILE *fp;
@@ -27,8 +27,8 @@ static int find_debugfs(char *debugfs)
     }
 
     while (fscanf(fp, "%*s %" STR(PATH_MAX) "s %99s %*s %*d %*d\n",
-                  debugfs, type) == 2) {
-        if (strcmp(type, "debugfs") == 0) {
+                  mount_point, type) == 2) {
+        if (strcmp(type, fstype) == 0) {
             ret = 1;
             break;
         }
@@ -40,14 +40,14 @@ static int find_debugfs(char *debugfs)
 
 bool ftrace_init(void)
 {
-    char debugfs[PATH_MAX];
+    char mount_point[PATH_MAX];
     char path[PATH_MAX];
     int debugfs_found;
     int trace_fd = -1;
 
-    debugfs_found = find_debugfs(debugfs);
+    debugfs_found = find_mount(mount_point, "debugfs");
     if (debugfs_found) {
-        snprintf(path, PATH_MAX, "%s/tracing/tracing_on", debugfs);
+        snprintf(path, PATH_MAX, "%s/tracing/tracing_on", mount_point);
         trace_fd = open(path, O_WRONLY);
         if (trace_fd < 0) {
             if (errno == EACCES) {
@@ -66,7 +66,7 @@ bool ftrace_init(void)
             }
             close(trace_fd);
         }
-        snprintf(path, PATH_MAX, "%s/tracing/trace_marker", debugfs);
+        snprintf(path, PATH_MAX, "%s/tracing/trace_marker", mount_point);
         trace_marker_fd = open(path, O_WRONLY);
         if (trace_marker_fd < 0) {
             perror("Could not open ftrace 'trace_marker' file");
-- 
2.14.3
