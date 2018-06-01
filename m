Received: from eggs.gnu.org ([2001:4830:134:3::10]:54022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fOgD0-0001ei-0g
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fOgCx-0002Dp-U2
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:18:53 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  1 Jun 2018 17:18:35 +0800
Message-Id: <20180601091835.21620-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] file-posix: Consolidate the locking error
 message
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

When hot-plugging a block device fails due to image locking errors,
users won't see the helpful 'Is another process using the image?'
message in QMP because currently the error hint is not carried over
there.

Even though extending QMP to include hint is a conceivably easy task,
Libvirt will need some change to consume that data.

Before that is fully sorted out, let's just do the easy fix by joining
the two lines.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/file-posix.c         | 10 ++--
 tests/qemu-iotests/153.out | 99 +++++++++++++-------------------------
 tests/qemu-iotests/182.out |  3 +-
 3 files changed, 38 insertions(+), 74 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 5a602cfe37..03776e13b1 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -699,11 +699,10 @@ static int raw_check_lock_bytes(BDRVRawState *s,
             if (ret) {
                 char *perm_name = bdrv_perm_names(p);
                 error_setg(errp,
-                           "Failed to get \"%s\" lock",
+                           "Failed to get \"%s\" lock. "
+                           "Is another process using the image?",
                            perm_name);
                 g_free(perm_name);
-                error_append_hint(errp,
-                                  "Is another process using the image?\n");
                 return ret;
             }
         }
@@ -716,11 +715,10 @@ static int raw_check_lock_bytes(BDRVRawState *s,
             if (ret) {
                 char *perm_name = bdrv_perm_names(p);
                 error_setg(errp,
-                           "Failed to get shared \"%s\" lock",
+                           "Failed to get shared \"%s\" lock. "
+                           "Is another process using the image?",
                            perm_name);
                 g_free(perm_name);
-                error_append_hint(errp,
-                                  "Is another process using the image?\n");
                 return ret;
             }
         }
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
index 2510762ba1..e256a9f714 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -11,86 +11,67 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t
 == Launching QEMU, opts: '' ==
 
 == Launching another QEMU, opts: '' ==
-QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,: Failed to get "write" lock
-Is another process using the image?
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,: Failed to get "write" lock. Is another process using the image?
 
 == Launching another QEMU, opts: 'read-only=on' ==
-QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,read-only=on: Failed to get shared "write" lock
-Is another process using the image?
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,read-only=on: Failed to get shared "write" lock. Is another process using the image?
 
 == Launching another QEMU, opts: 'read-only=on,force-share=on' ==
 
 == Running utility commands  ==
 
 _qemu_io_wrapper -c read 0 512 TEST_DIR/t.qcow2
-can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
-Is another process using the image?
+can't open device TEST_DIR/t.qcow2: Failed to get "write" lock. Is another process using the image?
 
 _qemu_io_wrapper -r -c read 0 512 TEST_DIR/t.qcow2
-can't open device TEST_DIR/t.qcow2: Failed to get shared "write" lock
-Is another process using the image?
+can't open device TEST_DIR/t.qcow2: Failed to get shared "write" lock. Is another process using the image?
 
 _qemu_io_wrapper -c open  TEST_DIR/t.qcow2 -c read 0 512
-can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
-Is another process using the image?
+can't open device TEST_DIR/t.qcow2: Failed to get "write" lock. Is another process using the image?
 no file open, try 'help open'
 
 _qemu_io_wrapper -c open -r  TEST_DIR/t.qcow2 -c read 0 512
-can't open device TEST_DIR/t.qcow2: Failed to get shared "write" lock
-Is another process using the image?
+can't open device TEST_DIR/t.qcow2: Failed to get shared "write" lock. Is another process using the image?
 no file open, try 'help open'
 
 _qemu_img_wrapper info TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock
-Is another process using the image?
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock. Is another process using the image?
 
 _qemu_img_wrapper check TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock
-Is another process using the image?
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock. Is another process using the image?
 
 _qemu_img_wrapper compare TEST_DIR/t.qcow2 TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock
-Is another process using the image?
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock. Is another process using the image?
 
 _qemu_img_wrapper map TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock
-Is another process using the image?
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock. Is another process using the image?
 
 _qemu_img_wrapper amend -o  TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
-Is another process using the image?
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock. Is another process using the image?
 
 _qemu_img_wrapper commit TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
-Is another process using the image?
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock. Is another process using the image?
 
 _qemu_img_wrapper resize TEST_DIR/t.qcow2 32M
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
-Is another process using the image?
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock. Is another process using the image?
 
 _qemu_img_wrapper rebase TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
-Is another process using the image?
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock. Is another process using the image?
 
 _qemu_img_wrapper snapshot -l TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock
-Is another process using the image?
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock. Is another process using the image?
 
 _qemu_img_wrapper convert TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.convert
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock
-Is another process using the image?
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock. Is another process using the image?
 
 _qemu_img_wrapper dd if=TEST_DIR/t.qcow2 of=TEST_DIR/t.qcow2.convert bs=512 count=1
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock
-Is another process using the image?
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock. Is another process using the image?
 
 _qemu_img_wrapper bench -c 1 TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock
-Is another process using the image?
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock. Is another process using the image?
 
 _qemu_img_wrapper bench -w -c 1 TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
-Is another process using the image?
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock. Is another process using the image?
 
 == Running utility commands -U ==
 
@@ -126,8 +107,7 @@ qemu-img: unrecognized option '-U'
 Try 'qemu-img --help' for more information
 
 _qemu_img_wrapper rebase -U TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
-Is another process using the image?
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock. Is another process using the image?
 
 _qemu_img_wrapper snapshot -l -U TEST_DIR/t.qcow2
 
@@ -151,8 +131,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t
 == Launching QEMU, opts: 'read-only=on' ==
 
 == Launching another QEMU, opts: '' ==
-QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,: Failed to get "write" lock
-Is another process using the image?
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,: Failed to get "write" lock. Is another process using the image?
 
 == Launching another QEMU, opts: 'read-only=on' ==
 
@@ -161,14 +140,12 @@ Is another process using the image?
 == Running utility commands  ==
 
 _qemu_io_wrapper -c read 0 512 TEST_DIR/t.qcow2
-can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
-Is another process using the image?
+can't open device TEST_DIR/t.qcow2: Failed to get "write" lock. Is another process using the image?
 
 _qemu_io_wrapper -r -c read 0 512 TEST_DIR/t.qcow2
 
 _qemu_io_wrapper -c open  TEST_DIR/t.qcow2 -c read 0 512
-can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
-Is another process using the image?
+can't open device TEST_DIR/t.qcow2: Failed to get "write" lock. Is another process using the image?
 no file open, try 'help open'
 
 _qemu_io_wrapper -c open -r  TEST_DIR/t.qcow2 -c read 0 512
@@ -182,20 +159,16 @@ _qemu_img_wrapper compare TEST_DIR/t.qcow2 TEST_DIR/t.qcow2
 _qemu_img_wrapper map TEST_DIR/t.qcow2
 
 _qemu_img_wrapper amend -o  TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
-Is another process using the image?
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock. Is another process using the image?
 
 _qemu_img_wrapper commit TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
-Is another process using the image?
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock. Is another process using the image?
 
 _qemu_img_wrapper resize TEST_DIR/t.qcow2 32M
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
-Is another process using the image?
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock. Is another process using the image?
 
 _qemu_img_wrapper rebase TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
-Is another process using the image?
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock. Is another process using the image?
 
 _qemu_img_wrapper snapshot -l TEST_DIR/t.qcow2
 
@@ -206,8 +179,7 @@ _qemu_img_wrapper dd if=TEST_DIR/t.qcow2 of=TEST_DIR/t.qcow2.convert bs=512 coun
 _qemu_img_wrapper bench -c 1 TEST_DIR/t.qcow2
 
 _qemu_img_wrapper bench -w -c 1 TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
-Is another process using the image?
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock. Is another process using the image?
 
 == Running utility commands -U ==
 
@@ -243,8 +215,7 @@ qemu-img: unrecognized option '-U'
 Try 'qemu-img --help' for more information
 
 _qemu_img_wrapper rebase -U TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
-Is another process using the image?
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock. Is another process using the image?
 
 _qemu_img_wrapper snapshot -l -U TEST_DIR/t.qcow2
 
@@ -364,14 +335,12 @@ Formatting 'TEST_DIR/t.IMGFMT.c', fmt=IMGFMT size=33554432 backing_file=TEST_DIR
 == Two devices sharing the same file in backing chain ==
 
 == Backing image also as an active device ==
-QEMU_PROG: -drive if=none,file=TEST_DIR/t.qcow2: Failed to get "write" lock
-Is another process using the image?
+QEMU_PROG: -drive if=none,file=TEST_DIR/t.qcow2: Failed to get "write" lock. Is another process using the image?
 
 == Backing image also as an active device (ro) ==
 
 == Symbolic link ==
-QEMU_PROG: -drive if=none,file=TEST_DIR/t.qcow2: Failed to get "write" lock
-Is another process using the image?
+QEMU_PROG: -drive if=none,file=TEST_DIR/t.qcow2: Failed to get "write" lock. Is another process using the image?
 
 == Active commit to intermediate layer should work when base in use ==
 {"return": {}}
@@ -381,8 +350,7 @@ _qemu_img_wrapper commit -b TEST_DIR/t.qcow2.b TEST_DIR/t.qcow2.c
 Adding drive
 
 _qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
-can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
-Is another process using the image?
+can't open device TEST_DIR/t.qcow2: Failed to get "write" lock. Is another process using the image?
 Creating overlay with qemu-img when the guest is running should be allowed
 
 _qemu_img_wrapper create -f qcow2 -b TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.overlay
@@ -394,8 +362,7 @@ Adding two and closing one
 _qemu_img_wrapper info TEST_DIR/t.qcow2
 
 _qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
-can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
-Is another process using the image?
+can't open device TEST_DIR/t.qcow2: Failed to get "write" lock. Is another process using the image?
 Closing the other
 
 _qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
diff --git a/tests/qemu-iotests/182.out b/tests/qemu-iotests/182.out
index 23a4dbf809..66abaa3357 100644
--- a/tests/qemu-iotests/182.out
+++ b/tests/qemu-iotests/182.out
@@ -3,6 +3,5 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432
 Starting QEMU
 
 Starting a second QEMU using the same image should fail
-QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,id=drive0,file.locking=on: Failed to get "write" lock
-Is another process using the image?
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,id=drive0,file.locking=on: Failed to get "write" lock. Is another process using the image?
 *** done
-- 
2.17.0
