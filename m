Received: from eggs.gnu.org ([2001:4830:134:3::10]:58710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1PgS-0005rL-Dz
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 23:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1PgR-0003n1-CZ
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 23:56:36 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 21 Apr 2017 11:55:52 +0800
Message-Id: <20170421035606.448-7-famz@redhat.com>
In-Reply-To: <20170421035606.448-1-famz@redhat.com>
References: <20170421035606.448-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v14 06/20] qemu-io: Add --share-rw option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Add --share-rw/-U to program options and -U to open subcommand.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qemu-io.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/qemu-io.c b/qemu-io.c
index 427cbae..c4d824f 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -20,6 +20,7 @@
 #include "qemu/readline.h"
 #include "qemu/log.h"
 #include "qapi/qmp/qstring.h"
+#include "qapi/qmp/qbool.h"
 #include "qom/object_interfaces.h"
 #include "sysemu/block-backend.h"
 #include "block/block_int.h"
@@ -53,7 +54,8 @@ static const cmdinfo_t close_cmd = {
     .oneline    = "close the current open file",
 };
 
-static int openfile(char *name, int flags, bool writethrough, QDict *opts)
+static int openfile(char *name, int flags, bool writethrough, bool share_rw,
+                    QDict *opts)
 {
     Error *local_err = NULL;
     BlockDriverState *bs;
@@ -64,6 +66,12 @@ static int openfile(char *name, int flags, bool writethrough, QDict *opts)
         return 1;
     }
 
+    if (share_rw) {
+        if (!opts) {
+            opts = qdict_new();
+        }
+        qdict_put(opts, BDRV_OPT_FORCE_SHARED_WRITE, qbool_from_bool(true));
+    }
     qemuio_blk = blk_new_open(name, NULL, opts, flags, &local_err);
     if (!qemuio_blk) {
         error_reportf_err(local_err, "can't open%s%s: ",
@@ -108,6 +116,7 @@ static void open_help(void)
 " -r, -- open file read-only\n"
 " -s, -- use snapshot file\n"
 " -n, -- disable host cache, short for -t none\n"
+" -U, -- allow shared write, don't lock image\n"
 " -k, -- use kernel AIO implementation (on Linux only)\n"
 " -t, -- use the given cache mode for the image\n"
 " -d, -- use the given discard mode for the image\n"
@@ -124,7 +133,7 @@ static const cmdinfo_t open_cmd = {
     .argmin     = 1,
     .argmax     = -1,
     .flags      = CMD_NOFILE_OK,
-    .args       = "[-rsnk] [-t cache] [-d discard] [-o options] [path]",
+    .args       = "[-rsnkU] [-t cache] [-d discard] [-o options] [path]",
     .oneline    = "open the file specified by path",
     .help       = open_help,
 };
@@ -147,8 +156,9 @@ static int open_f(BlockBackend *blk, int argc, char **argv)
     int c;
     QemuOpts *qopts;
     QDict *opts;
+    bool share_rw = false;
 
-    while ((c = getopt(argc, argv, "snro:kt:d:")) != -1) {
+    while ((c = getopt(argc, argv, "snro:kt:d:U")) != -1) {
         switch (c) {
         case 's':
             flags |= BDRV_O_SNAPSHOT;
@@ -188,6 +198,9 @@ static int open_f(BlockBackend *blk, int argc, char **argv)
                 return 0;
             }
             break;
+        case 'U':
+            share_rw = true;
+            break;
         default:
             qemu_opts_reset(&empty_opts);
             return qemuio_command_usage(&open_cmd);
@@ -211,9 +224,9 @@ static int open_f(BlockBackend *blk, int argc, char **argv)
     qemu_opts_reset(&empty_opts);
 
     if (optind == argc - 1) {
-        return openfile(argv[optind], flags, writethrough, opts);
+        return openfile(argv[optind], flags, writethrough, share_rw, opts);
     } else if (optind == argc) {
-        return openfile(NULL, flags, writethrough, opts);
+        return openfile(NULL, flags, writethrough, share_rw, opts);
     } else {
         QDECREF(opts);
         return qemuio_command_usage(&open_cmd);
@@ -257,6 +270,7 @@ static void usage(const char *name)
 "  -T, --trace [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
 "                       specify tracing options\n"
 "                       see qemu-img(1) man page for full description\n"
+"  -U, --share-rw       allow shared write\n"
 "  -h, --help           display this help and exit\n"
 "  -V, --version        output version information and exit\n"
 "\n"
@@ -436,7 +450,7 @@ static QemuOptsList file_opts = {
 int main(int argc, char **argv)
 {
     int readonly = 0;
-    const char *sopt = "hVc:d:f:rsnmkt:T:";
+    const char *sopt = "hVc:d:f:rsnmkt:T:U";
     const struct option lopt[] = {
         { "help", no_argument, NULL, 'h' },
         { "version", no_argument, NULL, 'V' },
@@ -452,6 +466,7 @@ int main(int argc, char **argv)
         { "trace", required_argument, NULL, 'T' },
         { "object", required_argument, NULL, OPTION_OBJECT },
         { "image-opts", no_argument, NULL, OPTION_IMAGE_OPTS },
+        { "share-rw", no_argument, 0, 'U'},
         { NULL, 0, NULL, 0 }
     };
     int c;
@@ -462,6 +477,7 @@ int main(int argc, char **argv)
     QDict *opts = NULL;
     const char *format = NULL;
     char *trace_file = NULL;
+    bool share_rw = false;
 
 #ifdef CONFIG_POSIX
     signal(SIGPIPE, SIG_IGN);
@@ -524,6 +540,9 @@ int main(int argc, char **argv)
         case 'h':
             usage(progname);
             exit(0);
+        case 'U':
+            share_rw = true;
+            break;
         case OPTION_OBJECT: {
             QemuOpts *qopts;
             qopts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -595,7 +614,7 @@ int main(int argc, char **argv)
                 exit(1);
             }
             opts = qemu_opts_to_qdict(qopts, NULL);
-            if (openfile(NULL, flags, writethrough, opts)) {
+            if (openfile(NULL, flags, writethrough, share_rw, opts)) {
                 exit(1);
             }
         } else {
@@ -603,7 +622,7 @@ int main(int argc, char **argv)
                 opts = qdict_new();
                 qdict_put(opts, "driver", qstring_from_str(format));
             }
-            if (openfile(argv[optind], flags, writethrough, opts)) {
+            if (openfile(argv[optind], flags, writethrough, share_rw, opts)) {
                 exit(1);
             }
         }
-- 
2.9.3
