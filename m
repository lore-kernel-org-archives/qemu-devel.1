Received: from eggs.gnu.org ([2001:4830:134:3::10]:53348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cncNM-0002Uz-AN
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 22:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cncNL-0008GC-7v
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 22:39:52 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 14 Mar 2017 10:39:33 +0800
Message-Id: <20170314023933.12118-4-famz@redhat.com>
In-Reply-To: <20170314023933.12118-1-famz@redhat.com>
References: <20170314023933.12118-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 3/3] qemu-io: Add --unsafe-read option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qemu-io.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/qemu-io.c b/qemu-io.c
index 427cbae..f3616ee 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -53,7 +53,8 @@ static const cmdinfo_t close_cmd = {
     .oneline    = "close the current open file",
 };
 
-static int openfile(char *name, int flags, bool writethrough, QDict *opts)
+static int openfile(char *name, int flags, bool writethrough, bool unsafe_read,
+                    QDict *opts)
 {
     Error *local_err = NULL;
     BlockDriverState *bs;
@@ -64,6 +65,9 @@ static int openfile(char *name, int flags, bool writethrough, QDict *opts)
         return 1;
     }
 
+    if (unsafe_read) {
+        flags |= BDRV_O_UNSAFE_READ;
+    }
     qemuio_blk = blk_new_open(name, NULL, opts, flags, &local_err);
     if (!qemuio_blk) {
         error_reportf_err(local_err, "can't open%s%s: ",
@@ -108,6 +112,7 @@ static void open_help(void)
 " -r, -- open file read-only\n"
 " -s, -- use snapshot file\n"
 " -n, -- disable host cache, short for -t none\n"
+" -U, -- accept unsafe opening of the image even if it's in use by another process\n"
 " -k, -- use kernel AIO implementation (on Linux only)\n"
 " -t, -- use the given cache mode for the image\n"
 " -d, -- use the given discard mode for the image\n"
@@ -124,7 +129,7 @@ static const cmdinfo_t open_cmd = {
     .argmin     = 1,
     .argmax     = -1,
     .flags      = CMD_NOFILE_OK,
-    .args       = "[-rsnk] [-t cache] [-d discard] [-o options] [path]",
+    .args       = "[-rsnkU] [-t cache] [-d discard] [-o options] [path]",
     .oneline    = "open the file specified by path",
     .help       = open_help,
 };
@@ -147,8 +152,9 @@ static int open_f(BlockBackend *blk, int argc, char **argv)
     int c;
     QemuOpts *qopts;
     QDict *opts;
+    bool unsafe_read = false;
 
-    while ((c = getopt(argc, argv, "snro:kt:d:")) != -1) {
+    while ((c = getopt(argc, argv, "snro:kt:d:U")) != -1) {
         switch (c) {
         case 's':
             flags |= BDRV_O_SNAPSHOT;
@@ -188,6 +194,9 @@ static int open_f(BlockBackend *blk, int argc, char **argv)
                 return 0;
             }
             break;
+        case 'U':
+            unsafe_read = true;
+            break;
         default:
             qemu_opts_reset(&empty_opts);
             return qemuio_command_usage(&open_cmd);
@@ -211,9 +220,9 @@ static int open_f(BlockBackend *blk, int argc, char **argv)
     qemu_opts_reset(&empty_opts);
 
     if (optind == argc - 1) {
-        return openfile(argv[optind], flags, writethrough, opts);
+        return openfile(argv[optind], flags, writethrough, unsafe_read, opts);
     } else if (optind == argc) {
-        return openfile(NULL, flags, writethrough, opts);
+        return openfile(NULL, flags, writethrough, unsafe_read, opts);
     } else {
         QDECREF(opts);
         return qemuio_command_usage(&open_cmd);
@@ -452,6 +461,7 @@ int main(int argc, char **argv)
         { "trace", required_argument, NULL, 'T' },
         { "object", required_argument, NULL, OPTION_OBJECT },
         { "image-opts", no_argument, NULL, OPTION_IMAGE_OPTS },
+        { "unsafe-read", no_argument, 0, 'U'},
         { NULL, 0, NULL, 0 }
     };
     int c;
@@ -462,6 +472,7 @@ int main(int argc, char **argv)
     QDict *opts = NULL;
     const char *format = NULL;
     char *trace_file = NULL;
+    bool unsafe_read = false;
 
 #ifdef CONFIG_POSIX
     signal(SIGPIPE, SIG_IGN);
@@ -524,6 +535,9 @@ int main(int argc, char **argv)
         case 'h':
             usage(progname);
             exit(0);
+        case 'U':
+            unsafe_read = true;
+            break;
         case OPTION_OBJECT: {
             QemuOpts *qopts;
             qopts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -595,7 +609,7 @@ int main(int argc, char **argv)
                 exit(1);
             }
             opts = qemu_opts_to_qdict(qopts, NULL);
-            if (openfile(NULL, flags, writethrough, opts)) {
+            if (openfile(NULL, flags, writethrough, unsafe_read, opts)) {
                 exit(1);
             }
         } else {
@@ -603,7 +617,7 @@ int main(int argc, char **argv)
                 opts = qdict_new();
                 qdict_put(opts, "driver", qstring_from_str(format));
             }
-            if (openfile(argv[optind], flags, writethrough, opts)) {
+            if (openfile(argv[optind], flags, writethrough, unsafe_read, opts)) {
                 exit(1);
             }
         }
-- 
2.9.3
