Received: from eggs.gnu.org ([2001:4830:134:3::10]:51512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwiM-0000SO-4u
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:48:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwiL-00080t-9T
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:48:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:26831)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eQwiL-0007zu-32
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:48:21 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 18 Dec 2017 14:47:59 +0000
Message-Id: <20171218144800.27337-4-stefanha@redhat.com>
In-Reply-To: <20171218144800.27337-1-stefanha@redhat.com>
References: <20171218144800.27337-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 3/4] trace: Try using tracefs first
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

Recent Linux kernel provides separate tracefs which doesn't need to be
mounted on the debugfs.  Although most systems mount it at the
traditional place on the debugfs, it'd be safer to check tracefs first.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 trace/ftrace.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/trace/ftrace.c b/trace/ftrace.c
index 213cb2205f..61692a8682 100644
--- a/trace/ftrace.c
+++ b/trace/ftrace.c
@@ -42,12 +42,18 @@ bool ftrace_init(void)
 {
     char mount_point[PATH_MAX];
     char path[PATH_MAX];
-    int debugfs_found;
+    int tracefs_found;
     int trace_fd = -1;
+    const char *subdir = "";
 
-    debugfs_found = find_mount(mount_point, "debugfs");
-    if (debugfs_found) {
-        snprintf(path, PATH_MAX, "%s/tracing/tracing_on", mount_point);
+    tracefs_found = find_mount(mount_point, "tracefs");
+    if (!tracefs_found) {
+        tracefs_found = find_mount(mount_point, "debugfs");
+        subdir = "/tracing";
+    }
+
+    if (tracefs_found) {
+        snprintf(path, PATH_MAX, "%s%s/tracing_on", mount_point, subdir);
         trace_fd = open(path, O_WRONLY);
         if (trace_fd < 0) {
             if (errno == EACCES) {
@@ -66,14 +72,14 @@ bool ftrace_init(void)
             }
             close(trace_fd);
         }
-        snprintf(path, PATH_MAX, "%s/tracing/trace_marker", mount_point);
+        snprintf(path, PATH_MAX, "%s%s/trace_marker", mount_point, subdir);
         trace_marker_fd = open(path, O_WRONLY);
         if (trace_marker_fd < 0) {
             perror("Could not open ftrace 'trace_marker' file");
             return false;
         }
     } else {
-        fprintf(stderr, "debugfs is not mounted\n");
+        fprintf(stderr, "tracefs is not mounted\n");
         return false;
     }
 
-- 
2.14.3
