Received: from eggs.gnu.org ([2001:4830:134:3::10]:44556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <namhyung@gmail.com>) id 1eC5tF-0008Fw-6l
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:34:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <namhyung@gmail.com>) id 1eC5tC-0007xF-Mz
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:34:13 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:52494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <namhyung@gmail.com>) id 1eC5tC-0007x4-HS
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:34:10 -0500
Received: by mail-pg0-x243.google.com with SMTP id a192so11303697pge.9
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 07:34:10 -0800 (PST)
From: Namhyung Kim <namhyung@gmail.com>
Date: Wed,  8 Nov 2017 00:31:36 +0900
Message-Id: <20171107153136.19426-3-namhyung@gmail.com>
In-Reply-To: <20171107153136.19426-1-namhyung@gmail.com>
References: <20171107153136.19426-1-namhyung@gmail.com>
Subject: [Qemu-devel] [PATCH 3/3] trace: Try using tracefs first
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

Recent Linux kernel provides separate tracefs which doesn't need to be
mounted on the debugfs.  Although most systems mount it at the
traditional place on the debugfs, it'd be safer to check tracefs first.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
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
