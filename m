Received: from eggs.gnu.org ([2001:4830:134:3::10]:57399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71qs-0002Eq-Qz
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71qk-0006ub-9z
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:18 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  1 Oct 2018 19:18:39 +0200
Message-Id: <20181001171901.11004-2-kwolf@redhat.com>
In-Reply-To: <20181001171901.11004-1-kwolf@redhat.com>
References: <20181001171901.11004-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 01/23] file-posix: Include filename in locking
 error message
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

From: Fam Zheng <famz@redhat.com>

Image locking errors happening at device initialization time doesn't say
which file cannot be locked, for instance,

    -device scsi-disk,drive=drive-1: Failed to get shared "write" lock
    Is another process using the image?

could refer to either the overlay image or its backing image.

Hoist the error_append_hint to the caller of raw_check_lock_bytes where
file name is known, and include it in the error hint.

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c         | 10 +++---
 tests/qemu-iotests/153.out | 76 +++++++++++++++++++++++-----------------------
 tests/qemu-iotests/182.out |  2 +-
 3 files changed, 45 insertions(+), 43 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index fe83cbf0eb..327f39ca45 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -741,8 +741,6 @@ static int raw_check_lock_bytes(int fd, uint64_t perm, uint64_t shared_perm,
                            "Failed to get \"%s\" lock",
                            perm_name);
                 g_free(perm_name);
-                error_append_hint(errp,
-                                  "Is another process using the image?\n");
                 return ret;
             }
         }
@@ -758,8 +756,6 @@ static int raw_check_lock_bytes(int fd, uint64_t perm, uint64_t shared_perm,
                            "Failed to get shared \"%s\" lock",
                            perm_name);
                 g_free(perm_name);
-                error_append_hint(errp,
-                                  "Is another process using the image?\n");
                 return ret;
             }
         }
@@ -796,6 +792,9 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
             if (!ret) {
                 return 0;
             }
+            error_append_hint(errp,
+                              "Is another process using the image [%s]?\n",
+                              bs->filename);
         }
         op = RAW_PL_ABORT;
         /* fall through to unlock bytes. */
@@ -2217,6 +2216,9 @@ raw_co_create(BlockdevCreateOptions *options, Error **errp)
     /* Step two: Check that nobody else has taken conflicting locks */
     result = raw_check_lock_bytes(fd, perm, shared, errp);
     if (result < 0) {
+        error_append_hint(errp,
+                          "Is another process using the image [%s]?\n",
+                          file_opts->filename);
         goto out_unlock;
     }
 
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
index 93eaf10486..884254868c 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -12,11 +12,11 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t
 
 == Launching another QEMU, opts: '' ==
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,: Failed to get "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 == Launching another QEMU, opts: 'read-only=on' ==
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,read-only=on: Failed to get shared "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 == Launching another QEMU, opts: 'read-only=on,force-share=on' ==
 
@@ -24,77 +24,77 @@ Is another process using the image?
 
 _qemu_io_wrapper -c read 0 512 TEST_DIR/t.qcow2
 can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 _qemu_io_wrapper -r -c read 0 512 TEST_DIR/t.qcow2
 can't open device TEST_DIR/t.qcow2: Failed to get shared "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 _qemu_io_wrapper -c open  TEST_DIR/t.qcow2 -c read 0 512
 can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 no file open, try 'help open'
 
 _qemu_io_wrapper -c open -r  TEST_DIR/t.qcow2 -c read 0 512
 can't open device TEST_DIR/t.qcow2: Failed to get shared "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 no file open, try 'help open'
 
 _qemu_img_wrapper info TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 _qemu_img_wrapper check TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 _qemu_img_wrapper compare TEST_DIR/t.qcow2 TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 _qemu_img_wrapper map TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 _qemu_img_wrapper amend -o  TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 _qemu_img_wrapper commit TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 _qemu_img_wrapper resize TEST_DIR/t.qcow2 32M
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 _qemu_img_wrapper rebase TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 _qemu_img_wrapper snapshot -l TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 _qemu_img_wrapper convert TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.convert
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 _qemu_img_wrapper dd if=TEST_DIR/t.qcow2 of=TEST_DIR/t.qcow2.convert bs=512 count=1
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 _qemu_img_wrapper bench -c 1 TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 _qemu_img_wrapper bench -w -c 1 TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 _qemu_img_wrapper create -f qcow2 TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
 qemu-img: TEST_DIR/t.qcow2: Failed to get "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 file format: IMGFMT
 
 == Running utility commands -U ==
@@ -132,7 +132,7 @@ Try 'qemu-img --help' for more information
 
 _qemu_img_wrapper rebase -U TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 _qemu_img_wrapper snapshot -l -U TEST_DIR/t.qcow2
 
@@ -157,7 +157,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t
 
 == Launching another QEMU, opts: '' ==
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,: Failed to get "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 == Launching another QEMU, opts: 'read-only=on' ==
 
@@ -167,13 +167,13 @@ Is another process using the image?
 
 _qemu_io_wrapper -c read 0 512 TEST_DIR/t.qcow2
 can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 _qemu_io_wrapper -r -c read 0 512 TEST_DIR/t.qcow2
 
 _qemu_io_wrapper -c open  TEST_DIR/t.qcow2 -c read 0 512
 can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 no file open, try 'help open'
 
 _qemu_io_wrapper -c open -r  TEST_DIR/t.qcow2 -c read 0 512
@@ -188,19 +188,19 @@ _qemu_img_wrapper map TEST_DIR/t.qcow2
 
 _qemu_img_wrapper amend -o  TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 _qemu_img_wrapper commit TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 _qemu_img_wrapper resize TEST_DIR/t.qcow2 32M
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 _qemu_img_wrapper rebase TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 _qemu_img_wrapper snapshot -l TEST_DIR/t.qcow2
 
@@ -212,11 +212,11 @@ _qemu_img_wrapper bench -c 1 TEST_DIR/t.qcow2
 
 _qemu_img_wrapper bench -w -c 1 TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 _qemu_img_wrapper create -f qcow2 TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
 qemu-img: TEST_DIR/t.qcow2: Failed to get "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 file format: IMGFMT
 
 == Running utility commands -U ==
@@ -254,7 +254,7 @@ Try 'qemu-img --help' for more information
 
 _qemu_img_wrapper rebase -U TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 _qemu_img_wrapper snapshot -l -U TEST_DIR/t.qcow2
 
@@ -372,17 +372,17 @@ Round done
 
 == Two devices with the same image (read-only=off - read-only=off) ==
 QEMU_PROG: -drive if=none,file=TEST_DIR/t.qcow2,read-only=off: Failed to get "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 == Two devices with the same image (read-only=off - read-only=on) ==
 QEMU_PROG: -drive if=none,file=TEST_DIR/t.qcow2,read-only=on: Failed to get shared "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 == Two devices with the same image (read-only=off - read-only=on,force-share=on) ==
 
 == Two devices with the same image (read-only=on - read-only=off) ==
 QEMU_PROG: -drive if=none,file=TEST_DIR/t.qcow2,read-only=off: Failed to get "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 == Two devices with the same image (read-only=on - read-only=on) ==
 
@@ -403,13 +403,13 @@ Formatting 'TEST_DIR/t.IMGFMT.c', fmt=IMGFMT size=33554432 backing_file=TEST_DIR
 
 == Backing image also as an active device ==
 QEMU_PROG: -drive if=none,file=TEST_DIR/t.qcow2: Failed to get "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 == Backing image also as an active device (ro) ==
 
 == Symbolic link ==
 QEMU_PROG: -drive if=none,file=TEST_DIR/t.qcow2: Failed to get "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 
 == Active commit to intermediate layer should work when base in use ==
 {"return": {}}
@@ -420,7 +420,7 @@ Adding drive
 
 _qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
 can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 Creating overlay with qemu-img when the guest is running should be allowed
 
 _qemu_img_wrapper create -f qcow2 -b TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.overlay
@@ -433,7 +433,7 @@ _qemu_img_wrapper info TEST_DIR/t.qcow2
 
 _qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
 can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 Closing the other
 
 _qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
diff --git a/tests/qemu-iotests/182.out b/tests/qemu-iotests/182.out
index 23a4dbf809..f1463c8862 100644
--- a/tests/qemu-iotests/182.out
+++ b/tests/qemu-iotests/182.out
@@ -4,5 +4,5 @@ Starting QEMU
 
 Starting a second QEMU using the same image should fail
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,id=drive0,file.locking=on: Failed to get "write" lock
-Is another process using the image?
+Is another process using the image [TEST_DIR/t.qcow2]?
 *** done
-- 
2.13.6
