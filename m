Received: from eggs.gnu.org ([2001:4830:134:3::10]:55728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWhrP-00088C-RV
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 06:05:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWhrO-0003lY-Mm
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 06:04:59 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 26 Jan 2017 11:04:33 +0000
Message-Id: <20170126110435.2777-5-berrange@redhat.com>
In-Reply-To: <20170126110435.2777-1-berrange@redhat.com>
References: <20170126110435.2777-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 4/6] qemu-img: add support for -o arg to dd
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The -o arg to the convert command allows specification of format/protocol
options for the newly created image. This adds a -o arg to the dd command
to get feature parity.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qemu-img-cmds.hx |  4 ++--
 qemu-img.c       | 32 +++++++++++++++++++++++++++++++-
 qemu-img.texi    |  6 ++++--
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 6732713..ef691fa 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -46,9 +46,9 @@ STEXI
 ETEXI
 
 DEF("dd", img_dd,
-    "dd [--image-opts] [-n] [-f fmt] [-O output_fmt] [bs=block_size] [count=blocks] [skip=blocks] if=input of=output")
+    "dd [--image-opts] [-n] [-f fmt] [-O output_fmt] [-o options] [bs=block_size] [count=blocks] [skip=blocks] if=input of=output")
 STEXI
-@item dd [--image-opts] [-n] [-f @var{fmt}] [-O @var{output_fmt}] [bs=@var{block_size}] [count=@var{blocks}] [skip=@var{blocks}] if=@var{input} of=@var{output}
+@item dd [--image-opts] [-n] [-f @var{fmt}] [-O @var{output_fmt}] [-o @var{options}] [bs=@var{block_size}] [count=@var{blocks}] [skip=@var{blocks}] if=@var{input} of=@var{output}
 ETEXI
 
 DEF("info", img_info,
diff --git a/qemu-img.c b/qemu-img.c
index 4d8d041..8f91a95 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3920,6 +3920,7 @@ static int img_dd(int argc, char **argv)
     int c, i, skip_create = 0;
     const char *out_fmt = "raw";
     const char *fmt = NULL;
+    char *optionstr = NULL;
     int64_t size = 0, out_size;
     int64_t block_count = 0, out_pos, in_pos;
     struct DdInfo dd = {
@@ -3954,7 +3955,7 @@ static int img_dd(int argc, char **argv)
         { 0, 0, 0, 0 }
     };
 
-    while ((c = getopt_long(argc, argv, "hnf:O:", long_options, NULL))) {
+    while ((c = getopt_long(argc, argv, "hno:f:O:", long_options, NULL))) {
         if (c == EOF) {
             break;
         }
@@ -3968,6 +3969,20 @@ static int img_dd(int argc, char **argv)
         case 'n':
             skip_create = 1;
             break;
+        case 'o':
+            if (!is_valid_option_list(optarg)) {
+                error_report("Invalid option list: %s", optarg);
+                ret = -1;
+                goto out;
+            }
+            if (!optionstr) {
+                optionstr = g_strdup(optarg);
+            } else {
+                char *old_options = optionstr;
+                optionstr = g_strdup_printf("%s,%s", optionstr, optarg);
+                g_free(old_options);
+            }
+            break;
         case '?':
             error_report("Try 'qemu-img --help' for more information.");
             ret = -1;
@@ -4028,6 +4043,11 @@ static int img_dd(int argc, char **argv)
         goto out;
     }
 
+    if (optionstr && has_help_option(optionstr)) {
+        ret = print_block_option_help(out.filename, out_fmt);
+        goto out;
+    }
+
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
                           NULL, NULL)) {
@@ -4072,6 +4092,15 @@ static int img_dd(int argc, char **argv)
         create_opts = qemu_opts_append(create_opts, proto_drv->create_opts);
 
         opts = qemu_opts_create(create_opts, NULL, 0, &error_abort);
+
+        if (optionstr) {
+            qemu_opts_do_parse(opts, optionstr, NULL, &local_err);
+            if (local_err) {
+                error_report_err(local_err);
+                ret = -1;
+                goto out;
+            }
+        }
     }
 
     size = blk_getlength(blk1);
@@ -4176,6 +4205,7 @@ static int img_dd(int argc, char **argv)
 
 out:
     g_free(arg);
+    g_free(optionstr);
     qemu_opts_del(opts);
     qemu_opts_free(create_opts);
     blk_unref(blk1);
diff --git a/qemu-img.texi b/qemu-img.texi
index b952d6a..9a391d4 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -326,10 +326,12 @@ skipped. This is useful for formats such as @code{rbd} if the target
 volume has already been created with site specific options that cannot
 be supplied through qemu-img.
 
-@item dd [-n] [-f @var{fmt}] [-O @var{output_fmt}] [bs=@var{block_size}] [count=@var{blocks}] [skip=@var{blocks}] if=@var{input} of=@var{output}
+@item dd [-n] [-f @var{fmt}] [-O @var{output_fmt}] [-o @var{options}] [bs=@var{block_size}] [count=@var{blocks}] [skip=@var{blocks}] if=@var{input} of=@var{output}
 
 Dd copies from @var{input} file to @var{output} file converting it from
-@var{fmt} format to @var{output_fmt} format.
+@var{fmt} format to @var{output_fmt} format. Depending on the output file
+format, you can add one or more @var{options} that enable additional
+features of this format.
 
 The data is by default read and written using blocks of 512 bytes but can be
 modified by specifying @var{block_size}. If count=@var{blocks} is specified
-- 
2.9.3
