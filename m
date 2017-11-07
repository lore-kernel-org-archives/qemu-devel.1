Received: from eggs.gnu.org ([2001:4830:134:3::10]:44575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <namhyung@gmail.com>) id 1eC5tG-0008Gm-Sl
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:34:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <namhyung@gmail.com>) id 1eC5tB-0007wX-5G
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:34:14 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:49336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <namhyung@gmail.com>) id 1eC5tB-0007w9-04
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:34:09 -0500
Received: by mail-pg0-x243.google.com with SMTP id g6so11308338pgn.6
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 07:34:08 -0800 (PST)
From: Namhyung Kim <namhyung@gmail.com>
Date: Wed,  8 Nov 2017 00:31:35 +0900
Message-Id: <20171107153136.19426-2-namhyung@gmail.com>
In-Reply-To: <20171107153136.19426-1-namhyung@gmail.com>
References: <20171107153136.19426-1-namhyung@gmail.com>
Subject: [Qemu-devel] [PATCH 2/3] trace: Generalize searching for debugfs
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

The find_debugfs() can be shared to find a different filesystem like
tracefs.  So make it more general and rename to find_mount().

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
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
