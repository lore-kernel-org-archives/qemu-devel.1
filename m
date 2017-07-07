Received: from eggs.gnu.org ([2001:4830:134:3::10]:41196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWko-0004X8-Dz
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWkm-0007Wm-My
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:18 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:07:16 +0200
Message-Id: <1499447335-6125-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 001/100] qemu-io: Don't die on second open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Most callback commands in qemu-io return 0 to keep the interpreter
loop running, or 1 to quit immediately.  However, open_f() just
passed through the return value of openfile(), which has different
semantics of returning 0 if a file was opened, or 1 on any failure.

As a result of mixing the return semantics, we are forcing the
qemu-io interpreter to exit early on any failures, which is rather
annoying when some of the failures are obviously trying to give
the user a hint of how to proceed (if we didn't then kill qemu-io
out from under the user's feet):

$ qemu-io
qemu-io> open foo
qemu-io> open foo
file open already, try 'help close'
$ echo $?
0

In general, we WANT openfile() to report failures, since it is the
function used in the form 'qemu-io -c "$something" no_such_file'
for performing one or more -c options on a single file, and it is
not worth attempting $something if the file itself cannot be opened.
So the solution is to fix open_f() to always return 0 (when we are
in interactive mode, even failure to open should not end the
session), and save the return value of openfile() for command line
use in main().

Note, however, that we do have some qemu-iotests that do 'qemu-io
-c "open file" -c "$something"'; such tests will now proceed to
attempt $something whether or not the open succeeded, the same way
as if the two commands had been attempted in interactive mode.  As
such, the expected output for those tests has to be modified.  But it
also means that it is now possible to use -c close and have a single
qemu-io command line operate on more than one file even without
using interactive mode.  Although the '-c open' action is a subtle
change in behavior, remember that qemu-io is for debugging purposes,
so as long as it serves the needs of qemu-iotests while still being
reasonable for interactive use, it should not be a problem that we
are changing tests to the new behavior.

This has been awkward since at least as far back as commit
e3aff4f, in 2009.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-io.c                  | 7 ++++---
 tests/qemu-iotests/060.out | 1 +
 tests/qemu-iotests/114.out | 5 +++--
 tests/qemu-iotests/153.out | 6 ++++++
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/qemu-io.c b/qemu-io.c
index 8e38b28..8074656 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -230,13 +230,14 @@ static int open_f(BlockBackend *blk, int argc, char **argv)
     qemu_opts_reset(&empty_opts);
 
     if (optind == argc - 1) {
-        return openfile(argv[optind], flags, writethrough, force_share, opts);
+        openfile(argv[optind], flags, writethrough, force_share, opts);
     } else if (optind == argc) {
-        return openfile(NULL, flags, writethrough, force_share, opts);
+        openfile(NULL, flags, writethrough, force_share, opts);
     } else {
         QDECREF(opts);
-        return qemuio_command_usage(&open_cmd);
+        qemuio_command_usage(&open_cmd);
     }
+    return 0;
 }
 
 static int quit_f(BlockBackend *blk, int argc, char **argv)
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index 3bc1461..5ca3af4 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -21,6 +21,7 @@ Format specific information:
     refcount bits: 16
     corrupt: true
 can't open device TEST_DIR/t.IMGFMT: IMGFMT: Image is corrupt; cannot be opened read/write
+no file open, try 'help open'
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
diff --git a/tests/qemu-iotests/114.out b/tests/qemu-iotests/114.out
index b6d10e4..1a47a52 100644
--- a/tests/qemu-iotests/114.out
+++ b/tests/qemu-iotests/114.out
@@ -1,6 +1,6 @@
 QA output created by 114
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base 
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 64M (67108864 bytes)
@@ -8,6 +8,7 @@ cluster_size: 65536
 backing file: TEST_DIR/t.IMGFMT.base
 backing file format: foo
 can't open device TEST_DIR/t.qcow2: Could not open backing file: Unknown driver 'foo'
+no file open, try 'help open'
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
index 5ba0b63..5b917b1 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -33,10 +33,12 @@ Is another process using the image?
 _qemu_io_wrapper -c open  TEST_DIR/t.qcow2 -c read 0 512
 can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
 Is another process using the image?
+no file open, try 'help open'
 
 _qemu_io_wrapper -c open -r  TEST_DIR/t.qcow2 -c read 0 512
 can't open device TEST_DIR/t.qcow2: Failed to get shared "write" lock
 Is another process using the image?
+no file open, try 'help open'
 
 _qemu_img_wrapper info TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock
@@ -99,6 +101,7 @@ _qemu_io_wrapper -U -r -c read 0 512 TEST_DIR/t.qcow2
 
 _qemu_io_wrapper -c open -U TEST_DIR/t.qcow2 -c read 0 512
 can't open device TEST_DIR/t.qcow2: force-share=on can only be used with read-only images
+no file open, try 'help open'
 
 _qemu_io_wrapper -c open -r -U TEST_DIR/t.qcow2 -c read 0 512
 
@@ -166,6 +169,7 @@ _qemu_io_wrapper -r -c read 0 512 TEST_DIR/t.qcow2
 _qemu_io_wrapper -c open  TEST_DIR/t.qcow2 -c read 0 512
 can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
 Is another process using the image?
+no file open, try 'help open'
 
 _qemu_io_wrapper -c open -r  TEST_DIR/t.qcow2 -c read 0 512
 
@@ -214,6 +218,7 @@ _qemu_io_wrapper -U -r -c read 0 512 TEST_DIR/t.qcow2
 
 _qemu_io_wrapper -c open -U TEST_DIR/t.qcow2 -c read 0 512
 can't open device TEST_DIR/t.qcow2: force-share=on can only be used with read-only images
+no file open, try 'help open'
 
 _qemu_io_wrapper -c open -r -U TEST_DIR/t.qcow2 -c read 0 512
 
@@ -313,6 +318,7 @@ _qemu_io_wrapper -U -r -c read 0 512 TEST_DIR/t.qcow2
 
 _qemu_io_wrapper -c open -U TEST_DIR/t.qcow2 -c read 0 512
 can't open device TEST_DIR/t.qcow2: force-share=on can only be used with read-only images
+no file open, try 'help open'
 
 _qemu_io_wrapper -c open -r -U TEST_DIR/t.qcow2 -c read 0 512
 
-- 
1.8.3.1
