Received: from eggs.gnu.org ([2001:4830:134:3::10]:60351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5anA-0003gL-DB
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5an7-0008Ot-7T
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:36:48 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  3 May 2017 00:35:41 +0800
Message-Id: <20170502163558.7611-7-famz@redhat.com>
In-Reply-To: <20170502163558.7611-1-famz@redhat.com>
References: <20170502163558.7611-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v17 06/23] qemu-io: Add --force-share option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, famz@redhat.com, Max Reitz <mreitz@redhat.com>, eblake@redhat.com

Add --force-share/-U to program options and -U to open subcommand.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qemu-io.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/qemu-io.c b/qemu-io.c
index 427cbae..cf4b876 100644
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
+static int openfile(char *name, int flags, bool writethrough, bool force_share,
+                    QDict *opts)
 {
     Error *local_err = NULL;
     BlockDriverState *bs;
@@ -64,6 +66,18 @@ static int openfile(char *name, int flags, bool writethrough, QDict *opts)
         return 1;
     }
 
+    if (force_share) {
+        if (!opts) {
+            opts = qdict_new();
+        }
+        if (qdict_haskey(opts, BDRV_OPT_FORCE_SHARE)
+            && !qdict_get_bool(opts, BDRV_OPT_FORCE_SHARE)) {
+            error_report("-U conflicts with image options");
+            QDECREF(opts);
+            return 1;
+        }
+        qdict_put(opts, BDRV_OPT_FORCE_SHARE, qbool_from_bool(true));
+    }
     qemuio_blk = blk_new_open(name, NULL, opts, flags, &local_err);
     if (!qemuio_blk) {
         error_reportf_err(local_err, "can't open%s%s: ",
@@ -108,6 +122,7 @@ static void open_help(void)
 " -r, -- open file read-only\n"
 " -s, -- use snapshot file\n"
 " -n, -- disable host cache, short for -t none\n"
+" -U, -- force shared permissions\n"
 " -k, -- use kernel AIO implementation (on Linux only)\n"
 " -t, -- use the given cache mode for the image\n"
 " -d, -- use the given discard mode for the image\n"
@@ -124,7 +139,7 @@ static const cmdinfo_t open_cmd = {
     .argmin     = 1,
     .argmax     = -1,
     .flags      = CMD_NOFILE_OK,
-    .args       = "[-rsnk] [-t cache] [-d discard] [-o options] [path]",
+    .args       = "[-rsnkU] [-t cache] [-d discard] [-o options] [path]",
     .oneline    = "open the file specified by path",
     .help       = open_help,
 };
@@ -147,8 +162,9 @@ static int open_f(BlockBackend *blk, int argc, char **argv)
     int c;
     QemuOpts *qopts;
     QDict *opts;
+    bool force_share = false;
 
-    while ((c = getopt(argc, argv, "snro:kt:d:")) != -1) {
+    while ((c = getopt(argc, argv, "snro:kt:d:U")) != -1) {
         switch (c) {
         case 's':
             flags |= BDRV_O_SNAPSHOT;
@@ -188,6 +204,9 @@ static int open_f(BlockBackend *blk, int argc, char **argv)
                 return 0;
             }
             break;
+        case 'U':
+            force_share = true;
+            break;
         default:
             qemu_opts_reset(&empty_opts);
             return qemuio_command_usage(&open_cmd);
@@ -211,9 +230,9 @@ static int open_f(BlockBackend *blk, int argc, char **argv)
     qemu_opts_reset(&empty_opts);
 
     if (optind == argc - 1) {
-        return openfile(argv[optind], flags, writethrough, opts);
+        return openfile(argv[optind], flags, writethrough, force_share, opts);
     } else if (optind == argc) {
-        return openfile(NULL, flags, writethrough, opts);
+        return openfile(NULL, flags, writethrough, force_share, opts);
     } else {
         QDECREF(opts);
         return qemuio_command_usage(&open_cmd);
@@ -257,6 +276,7 @@ static void usage(const char *name)
 "  -T, --trace [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
 "                       specify tracing options\n"
 "                       see qemu-img(1) man page for full description\n"
+"  -U, --force-share    force shared permissions\n"
 "  -h, --help           display this help and exit\n"
 "  -V, --version        output version information and exit\n"
 "\n"
@@ -436,7 +456,7 @@ static QemuOptsList file_opts = {
 int main(int argc, char **argv)
 {
     int readonly = 0;
-    const char *sopt = "hVc:d:f:rsnmkt:T:";
+    const char *sopt = "hVc:d:f:rsnmkt:T:U";
     const struct option lopt[] = {
         { "help", no_argument, NULL, 'h' },
         { "version", no_argument, NULL, 'V' },
@@ -452,6 +472,7 @@ int main(int argc, char **argv)
         { "trace", required_argument, NULL, 'T' },
         { "object", required_argument, NULL, OPTION_OBJECT },
         { "image-opts", no_argument, NULL, OPTION_IMAGE_OPTS },
+        { "force-share", no_argument, 0, 'U'},
         { NULL, 0, NULL, 0 }
     };
     int c;
@@ -462,6 +483,7 @@ int main(int argc, char **argv)
     QDict *opts = NULL;
     const char *format = NULL;
     char *trace_file = NULL;
+    bool force_share = false;
 
 #ifdef CONFIG_POSIX
     signal(SIGPIPE, SIG_IGN);
@@ -524,6 +546,9 @@ int main(int argc, char **argv)
         case 'h':
             usage(progname);
             exit(0);
+        case 'U':
+            force_share = true;
+            break;
         case OPTION_OBJECT: {
             QemuOpts *qopts;
             qopts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -595,7 +620,7 @@ int main(int argc, char **argv)
                 exit(1);
             }
             opts = qemu_opts_to_qdict(qopts, NULL);
-            if (openfile(NULL, flags, writethrough, opts)) {
+            if (openfile(NULL, flags, writethrough, force_share, opts)) {
                 exit(1);
             }
         } else {
@@ -603,7 +628,8 @@ int main(int argc, char **argv)
                 opts = qdict_new();
                 qdict_put(opts, "driver", qstring_from_str(format));
             }
-            if (openfile(argv[optind], flags, writethrough, opts)) {
+            if (openfile(argv[optind], flags, writethrough,
+                         force_share, opts)) {
                 exit(1);
             }
         }
-- 
2.9.3
