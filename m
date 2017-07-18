Received: from eggs.gnu.org ([2001:4830:134:3::10]:53647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXTKs-00012z-4Y
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXTKp-0007uy-Ls
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:18:50 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 18 Jul 2017 16:18:06 +0200
Message-Id: <1500387486-5469-22-git-send-email-kwolf@redhat.com>
In-Reply-To: <1500387486-5469-1-git-send-email-kwolf@redhat.com>
References: <1500387486-5469-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 21/21] qemu-img: Check for backing image if
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: John Snow <jsnow@redhat.com>

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
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c                    | 94 +++++++++++++++++++++++++---------------------
 qemu-img-cmds.hx           |  4 +-
 qemu-img.c                 | 16 +++++---
 qemu-img.texi              |  9 ++++-
 tests/qemu-iotests/082     |  4 +-
 tests/qemu-iotests/082.out |  4 +-
 tests/qemu-iotests/085     |  2 +-
 tests/qemu-iotests/111.out |  1 +
 tests/qemu-iotests/139     |  2 +-
 tests/qemu-iotests/156     |  2 +-
 tests/qemu-iotests/158     |  2 +-
 tests/qemu-iotests/189     |  2 +-
 12 files changed, 83 insertions(+), 59 deletions(-)

diff --git a/block.c b/block.c
index 98a9209..2dd9262 100644
--- a/block.c
+++ b/block.c
@@ -4396,55 +4396,65 @@ void bdrv_img_create(const char *filename, const char *fmt,
 
     backing_fmt = qemu_opt_get(opts, BLOCK_OPT_BACKING_FMT);
 
-    // The size for the image must always be specified, with one exception:
-    // If we are using a backing file, we can obtain the size from there
+    /* The size for the image must always be specified, unless we have a backing
+     * file and we have not been forbidden from opening it. */
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
+            g_free(full_backing);
+            goto out;
+        }
 
-            /* backing files always opened read-only */
-            back_flags = flags;
-            back_flags &= ~(BDRV_O_RDWR | BDRV_O_SNAPSHOT | BDRV_O_NO_BACKING);
+        /* backing files always opened read-only */
+        back_flags = flags;
+        back_flags &= ~(BDRV_O_RDWR | BDRV_O_SNAPSHOT | BDRV_O_NO_BACKING);
 
-            if (backing_fmt) {
-                backing_options = qdict_new();
-                qdict_put_str(backing_options, "driver", backing_fmt);
-            }
+        if (backing_fmt) {
+            backing_options = qdict_new();
+            qdict_put_str(backing_options, "driver", backing_fmt);
+        }
 
-            bs = bdrv_open(full_backing, NULL, backing_options, back_flags,
-                           &local_err);
-            g_free(full_backing);
-            if (!bs) {
-                goto out;
-            }
-            size = bdrv_getlength(bs);
-            if (size < 0) {
-                error_setg_errno(errp, -size, "Could not get size of '%s'",
-                                 backing_file);
-                bdrv_unref(bs);
-                goto out;
+        bs = bdrv_open(full_backing, NULL, backing_options, back_flags,
+                       &local_err);
+        g_free(full_backing);
+        if (!bs && size != -1) {
+            /* Couldn't open BS, but we have a size, so it's nonfatal */
+            warn_reportf_err(local_err,
+                            "Could not verify backing image. "
+                            "This may become an error in future versions.\n");
+            local_err = NULL;
+        } else if (!bs) {
+            /* Couldn't open bs, do not have size */
+            error_append_hint(&local_err,
+                              "Could not open backing image to determine size.\n");
+            goto out;
+        } else {
+            if (size == -1) {
+                /* Opened BS, have no size */
+                size = bdrv_getlength(bs);
+                if (size < 0) {
+                    error_setg_errno(errp, -size, "Could not get size of '%s'",
+                                     backing_file);
+                    bdrv_unref(bs);
+                    goto out;
+                }
+                qemu_opt_set_number(opts, BLOCK_OPT_SIZE, size, &error_abort);
             }
-
-            qemu_opt_set_number(opts, BLOCK_OPT_SIZE, size, &error_abort);
-
             bdrv_unref(bs);
-        } else {
-            error_setg(errp, "Image creation needs a size parameter");
-            goto out;
         }
+    } /* (backing_file && !(flags & BDRV_O_NO_BACKING)) */
+
+    if (size == -1) {
+        error_setg(errp, "Image creation needs a size parameter");
+        goto out;
     }
 
     if (!quiet) {
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index ac5946b..3763f13 100644
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
index 182e697..eb32b93 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -150,9 +150,11 @@ static void QEMU_NORETURN help(void)
            "  'snapshot_id_or_name' is deprecated, use 'snapshot_param'\n"
            "    instead\n"
            "  '-c' indicates that target image must be compressed (qcow format only)\n"
-           "  '-u' enables unsafe rebasing. It is assumed that old and new backing file\n"
-           "       match exactly. The image doesn't need a working backing file before\n"
-           "       rebasing in this case (useful for renaming the backing file)\n"
+           "  '-u' allows unsafe backing chains. For rebasing, it is assumed that old and\n"
+           "       new backing file match exactly. The image doesn't need a working\n"
+           "       backing file before rebasing in this case (useful for renaming the\n"
+           "       backing file). For image creation, allow creating without attempting\n"
+           "       to open the backing file.\n"
            "  '-h' with or without a command shows this help and lists the supported formats\n"
            "  '-p' show progress of command (only certain commands)\n"
            "  '-q' use Quiet mode - do not print any output (except errors)\n"
@@ -429,6 +431,7 @@ static int img_create(int argc, char **argv)
     char *options = NULL;
     Error *local_err = NULL;
     bool quiet = false;
+    int flags = 0;
 
     for(;;) {
         static const struct option long_options[] = {
@@ -436,7 +439,7 @@ static int img_create(int argc, char **argv)
             {"object", required_argument, 0, OPTION_OBJECT},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":F:b:f:ho:q",
+        c = getopt_long(argc, argv, ":F:b:f:ho:qu",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -476,6 +479,9 @@ static int img_create(int argc, char **argv)
         case 'q':
             quiet = true;
             break;
+        case 'u':
+            flags |= BDRV_O_NO_BACKING;
+            break;
         case OPTION_OBJECT: {
             QemuOpts *opts;
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -528,7 +534,7 @@ static int img_create(int argc, char **argv)
     }
 
     bdrv_img_create(filename, fmt, base_filename, base_fmt,
-                    options, img_size, 0, quiet, &local_err);
+                    options, img_size, flags, quiet, &local_err);
     if (local_err) {
         error_reportf_err(local_err, "%s: ", filename);
         goto fail;
diff --git a/qemu-img.texi b/qemu-img.texi
index f11f603..72dabd6 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -233,7 +233,7 @@ If @code{-r} is specified, exit codes representing the image state refer to the
 state after (the attempt at) repairing it. That is, a successful @code{-r all}
 will yield the exit code 0, independently of the image state before.
 
-@item create [-f @var{fmt}] [-b @var{backing_file}] [-F @var{backing_fmt}] [-o @var{options}] @var{filename} [@var{size}]
+@item create [-f @var{fmt}] [-b @var{backing_file}] [-F @var{backing_fmt}] [-u] [-o @var{options}] @var{filename} [@var{size}]
 
 Create the new disk image @var{filename} of size @var{size} and format
 @var{fmt}. Depending on the file format, you can add one or more @var{options}
@@ -244,6 +244,13 @@ only the differences from @var{backing_file}. No size needs to be specified in
 this case. @var{backing_file} will never be modified unless you use the
 @code{commit} monitor command (or qemu-img commit).
 
+Note that a given backing file will be opened to check that it is valid. Use
+the @code{-u} option to enable unsafe backing file mode, which means that the
+image will be created even if the associated backing file cannot be opened. A
+matching backing file must be created or additional options be used to make the
+backing file specification valid when you want to use an image created this
+way.
+
 The size can also be specified using the @var{size} option with @code{-o},
 it doesn't need to be specified separately in this case.
 
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
index dbed67f..1527fbe 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -210,10 +210,10 @@ lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
 nocow            Turn off copy-on-write (valid only on btrfs)
 
-Testing: create -f qcow2 -o backing_file=TEST_DIR/t.qcow2,,help TEST_DIR/t.qcow2 128M
+Testing: create -f qcow2 -u -o backing_file=TEST_DIR/t.qcow2,,help TEST_DIR/t.qcow2 128M
 Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2,,help cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
-Testing: create -f qcow2 -o backing_file=TEST_DIR/t.qcow2,,? TEST_DIR/t.qcow2 128M
+Testing: create -f qcow2 -u -o backing_file=TEST_DIR/t.qcow2,,? TEST_DIR/t.qcow2 128M
 Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2,,? cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 Testing: create -f qcow2 -o backing_file=TEST_DIR/t.qcow2, -o help TEST_DIR/t.qcow2 128M
diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
index b97adcd..71efe50 100755
--- a/tests/qemu-iotests/085
+++ b/tests/qemu-iotests/085
@@ -104,7 +104,7 @@ function add_snapshot_image()
 {
     base_image="${TEST_DIR}/$((${1}-1))-${snapshot_virt0}"
     snapshot_file="${TEST_DIR}/${1}-${snapshot_virt0}"
-    _make_test_img -b "${base_image}" "$size"
+    _make_test_img -u -b "${base_image}" "$size"
     mv "${TEST_IMG}" "${snapshot_file}"
     do_blockdev_add "$1" "'backing': '', " "${snapshot_file}"
 }
diff --git a/tests/qemu-iotests/111.out b/tests/qemu-iotests/111.out
index 683c01a..5279c46 100644
--- a/tests/qemu-iotests/111.out
+++ b/tests/qemu-iotests/111.out
@@ -1,3 +1,4 @@
 QA output created by 111
 qemu-img: TEST_DIR/t.IMGFMT: Could not open 'TEST_DIR/t.IMGFMT.inexistent': No such file or directory
+Could not open backing image to determine size.
 *** done
diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
index 175d8f0..9ff51d9 100644
--- a/tests/qemu-iotests/139
+++ b/tests/qemu-iotests/139
@@ -65,7 +65,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
     # Add a BlockDriverState that will be used as overlay for the base_img BDS
     def addBlockDriverStateOverlay(self, node):
         self.checkBlockDriverState(node, False)
-        iotests.qemu_img('create', '-f', iotests.imgfmt,
+        iotests.qemu_img('create', '-u', '-f', iotests.imgfmt,
                          '-b', base_img, new_img, '1M')
         opts = {'driver': iotests.imgfmt,
                 'node-name': node,
diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index d799b73..2c4a06e 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -66,7 +66,7 @@ _send_qemu_cmd $QEMU_HANDLE \
     'return'
 
 # Create snapshot
-TEST_IMG="$TEST_IMG.overlay" _make_test_img -b "$TEST_IMG" 1M
+TEST_IMG="$TEST_IMG.overlay" _make_test_img -u -b "$TEST_IMG" 1M
 _send_qemu_cmd $QEMU_HANDLE \
     "{ 'execute': 'blockdev-snapshot-sync',
        'arguments': { 'device': 'source',
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index 823c120..24ac600 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -66,7 +66,7 @@ echo "== verify pattern =="
 $QEMU_IO --object $SECRET -c "read -P 0xa 0 $size" --image-opts $IMGSPECBASE | _filter_qemu_io | _filter_testdir
 
 echo "== create overlay =="
-_make_test_img --object $SECRET -o "encryption=on,encrypt.key-secret=sec0" -b "$TEST_IMG_BASE" $size
+_make_test_img -u --object $SECRET -o "encryption=on,encrypt.key-secret=sec0" -b "$TEST_IMG_BASE" $size
 
 echo
 echo "== writing part of a cluster =="
diff --git a/tests/qemu-iotests/189 b/tests/qemu-iotests/189
index 54ad980..e695475 100755
--- a/tests/qemu-iotests/189
+++ b/tests/qemu-iotests/189
@@ -66,7 +66,7 @@ echo "== verify pattern =="
 $QEMU_IO --object $SECRET0 -c "read -P 0xa 0 $size" --image-opts $IMGSPECBASE | _filter_qemu_io | _filter_testdir
 
 echo "== create overlay =="
-_make_test_img --object $SECRET1 -o "encrypt.format=luks,encrypt.key-secret=sec1,encrypt.iter-time=10" -b "$TEST_IMG_BASE" $size
+_make_test_img --object $SECRET1 -o "encrypt.format=luks,encrypt.key-secret=sec1,encrypt.iter-time=10" -u -b "$TEST_IMG_BASE" $size
 
 echo
 echo "== writing part of a cluster =="
-- 
1.8.3.1
