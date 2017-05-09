Received: from eggs.gnu.org ([2001:4830:134:3::10]:54799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d89aC-00040o-Q2
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:10:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d89aA-0004qm-Tu
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:10:00 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  9 May 2017 14:09:46 -0400
Message-Id: <20170509180946.17046-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2] qemu-img: Check for backing image if
 specified during create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, John Snow <jsnow@redhat.com>

Or, rather, force the open of a backing image if one was specified
for creation. Using a similar -unsafe option as rebase, allow qemu-img
to ignore the backing file validation if possible.

It may not always be possible, as in the existing case when a filesize
for the new image was not specified.

This is accomplished by shifting around the conditionals in
bdrv_img_create, such that a backing file is always opened unless we
provide BDRV_O_NO_BACKING. qemu-img is adjusted to pass this new flag
when -u is provided to create.

Sorry for the heinous looking diffstat, but it's mostly whitespace.

Inspired by: https://bugzilla.redhat.com/show_bug.cgi?id=1213786

Signed-off-by: John Snow <jsnow@redhat.com>
---

v2: Rebased for 2.10
    Corrected some of my less cromulent grammar


 block.c                    | 75 +++++++++++++++++++++++-----------------------
 qemu-img-cmds.hx           |  4 +--
 qemu-img.c                 | 16 ++++++----
 tests/qemu-iotests/082     |  4 +--
 tests/qemu-iotests/082.out |  4 +--
 5 files changed, 55 insertions(+), 48 deletions(-)

diff --git a/block.c b/block.c
index 6c6bb3e..ca3e195 100644
--- a/block.c
+++ b/block.c
@@ -4284,38 +4284,38 @@ void bdrv_img_create(const char *filename, const char *fmt,
     // The size for the image must always be specified, with one exception:
     // If we are using a backing file, we can obtain the size from there
     size = qemu_opt_get_size(opts, BLOCK_OPT_SIZE, 0);
-    if (size == -1) {
-        if (backing_file) {
-            BlockDriverState *bs;
-            char *full_backing = g_new0(char, PATH_MAX);
-            int64_t size;
-            int back_flags;
-            QDict *backing_options = NULL;
-
-            bdrv_get_full_backing_filename_from_filename(filename, backing_file,
-                                                         full_backing, PATH_MAX,
-                                                         &local_err);
-            if (local_err) {
-                g_free(full_backing);
-                goto out;
-            }
-
-            /* backing files always opened read-only */
-            back_flags = flags;
-            back_flags &= ~(BDRV_O_RDWR | BDRV_O_SNAPSHOT | BDRV_O_NO_BACKING);
-
-            if (backing_fmt) {
-                backing_options = qdict_new();
-                qdict_put(backing_options, "driver",
-                          qstring_from_str(backing_fmt));
-            }
-
-            bs = bdrv_open(full_backing, NULL, backing_options, back_flags,
-                           &local_err);
+    if (backing_file && !(flags & BDRV_O_NO_BACKING)) {
+        BlockDriverState *bs;
+        char *full_backing = g_new0(char, PATH_MAX);
+        int back_flags;
+        QDict *backing_options = NULL;
+
+        bdrv_get_full_backing_filename_from_filename(filename, backing_file,
+                                                     full_backing, PATH_MAX,
+                                                     &local_err);
+        if (local_err) {
             g_free(full_backing);
-            if (!bs) {
-                goto out;
-            }
+            goto out;
+        }
+
+        /* backing files always opened read-only */
+        back_flags = flags;
+        back_flags &= ~(BDRV_O_RDWR | BDRV_O_SNAPSHOT | BDRV_O_NO_BACKING);
+
+        if (backing_fmt) {
+            backing_options = qdict_new();
+            qdict_put(backing_options, "driver",
+                      qstring_from_str(backing_fmt));
+        }
+
+        bs = bdrv_open(full_backing, NULL, backing_options, back_flags,
+                       &local_err);
+        g_free(full_backing);
+        if (!bs) {
+            goto out;
+        }
+
+        if (size == -1) {
             size = bdrv_getlength(bs);
             if (size < 0) {
                 error_setg_errno(errp, -size, "Could not get size of '%s'",
@@ -4323,14 +4323,15 @@ void bdrv_img_create(const char *filename, const char *fmt,
                 bdrv_unref(bs);
                 goto out;
             }
-
             qemu_opt_set_number(opts, BLOCK_OPT_SIZE, size, &error_abort);
-
-            bdrv_unref(bs);
-        } else {
-            error_setg(errp, "Image creation needs a size parameter");
-            goto out;
         }
+
+        bdrv_unref(bs);
+    }
+
+    if (size == -1) {
+        error_setg(errp, "Image creation needs a size parameter");
+        goto out;
     }
 
     if (!quiet) {
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index bf4ce59..1d230c6 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -22,9 +22,9 @@ STEXI
 ETEXI
 
 DEF("create", img_create,
-    "create [-q] [--object objectdef] [-f fmt] [-b backing_file] [-F backing_fmt] [-o options] filename [size]")
+    "create [-q] [--object objectdef] [-f fmt] [-b backing_file] [-F backing_fmt] [-u] [-o options] filename [size]")
 STEXI
-@item create [--object @var{objectdef}] [-q] [-f @var{fmt}] [-b @var{backing_file}] [-F @var{backing_fmt}] [-o @var{options}] @var{filename} [@var{size}]
+@item create [--object @var{objectdef}] [-q] [-f @var{fmt}] [-b @var{backing_file}] [-F @var{backing_fmt}] [-u] [-o @var{options}] @var{filename} [@var{size}]
 ETEXI
 
 DEF("commit", img_commit,
diff --git a/qemu-img.c b/qemu-img.c
index c719636..9686110 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -145,9 +145,11 @@ static void QEMU_NORETURN help(void)
            "  'snapshot_id_or_name' is deprecated, use 'snapshot_param'\n"
            "    instead\n"
            "  '-c' indicates that target image must be compressed (qcow format only)\n"
-           "  '-u' enables unsafe rebasing. It is assumed that old and new backing file\n"
-           "       match exactly. The image doesn't need a working backing file before\n"
-           "       rebasing in this case (useful for renaming the backing file)\n"
+           "  '-u' allows unsafe backing chains. For rebasing, it is assumed that old and new\n"
+           "       backing file match exactly. The image doesn't need a working backing file\n"
+           "       before rebasing in this case (useful for renaming the backing file)\n"
+           "       For image creation, allow creating without attempting to"
+           "       open the backing file.\n"
            "  '-h' with or without a command shows this help and lists the supported formats\n"
            "  '-p' show progress of command (only certain commands)\n"
            "  '-q' use Quiet mode - do not print any output (except errors)\n"
@@ -409,6 +411,7 @@ static int img_create(int argc, char **argv)
     char *options = NULL;
     Error *local_err = NULL;
     bool quiet = false;
+    int flags = 0;
 
     for(;;) {
         static const struct option long_options[] = {
@@ -416,7 +419,7 @@ static int img_create(int argc, char **argv)
             {"object", required_argument, 0, OPTION_OBJECT},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":F:b:f:he6o:q",
+        c = getopt_long(argc, argv, ":F:b:f:he6o:qu",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -464,6 +467,9 @@ static int img_create(int argc, char **argv)
         case 'q':
             quiet = true;
             break;
+        case 'u':
+            flags |= BDRV_O_NO_BACKING;
+            break;
         case OPTION_OBJECT: {
             QemuOpts *opts;
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -516,7 +522,7 @@ static int img_create(int argc, char **argv)
     }
 
     bdrv_img_create(filename, fmt, base_filename, base_fmt,
-                    options, img_size, 0, quiet, &local_err);
+                    options, img_size, flags, quiet, &local_err);
     if (local_err) {
         error_reportf_err(local_err, "%s: ", filename);
         goto fail;
diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
index ad1d9fa..d5c83d4 100755
--- a/tests/qemu-iotests/082
+++ b/tests/qemu-iotests/082
@@ -85,8 +85,8 @@ run_qemu_img create -f $IMGFMT -o cluster_size=4k -o help "$TEST_IMG" $size
 run_qemu_img create -f $IMGFMT -o cluster_size=4k -o \? "$TEST_IMG" $size
 
 # Looks like a help option, but is part of the backing file name
-run_qemu_img create -f $IMGFMT -o backing_file="$TEST_IMG",,help "$TEST_IMG" $size
-run_qemu_img create -f $IMGFMT -o backing_file="$TEST_IMG",,\? "$TEST_IMG" $size
+run_qemu_img create -f $IMGFMT -u -o backing_file="$TEST_IMG",,help "$TEST_IMG" $size
+run_qemu_img create -f $IMGFMT -u -o backing_file="$TEST_IMG",,\? "$TEST_IMG" $size
 
 # Try to trick qemu-img into creating escaped commas
 run_qemu_img create -f $IMGFMT -o backing_file="$TEST_IMG", -o help "$TEST_IMG" $size
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index a952330..f2732e4 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -146,10 +146,10 @@ lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
 nocow            Turn off copy-on-write (valid only on btrfs)
 
-Testing: create -f qcow2 -o backing_file=TEST_DIR/t.qcow2,,help TEST_DIR/t.qcow2 128M
+Testing: create -f qcow2 -u -o backing_file=TEST_DIR/t.qcow2,,help TEST_DIR/t.qcow2 128M
 Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2,,help encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
-Testing: create -f qcow2 -o backing_file=TEST_DIR/t.qcow2,,? TEST_DIR/t.qcow2 128M
+Testing: create -f qcow2 -u -o backing_file=TEST_DIR/t.qcow2,,? TEST_DIR/t.qcow2 128M
 Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2,,? encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 Testing: create -f qcow2 -o backing_file=TEST_DIR/t.qcow2, -o help TEST_DIR/t.qcow2 128M
-- 
2.9.3
