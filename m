Received: from eggs.gnu.org ([2001:4830:134:3::10]:50667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fvkQZ-0001A5-5g
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 10:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fvkMA-0000kY-0T
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 10:25:08 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 31 Aug 2018 16:24:36 +0200
Message-Id: <20180831142446.22264-2-mreitz@redhat.com>
In-Reply-To: <20180831142446.22264-1-mreitz@redhat.com>
References: <20180831142446.22264-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 01/11] file-posix: Skip effectiveless OFD lock
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>

From: Fam Zheng <famz@redhat.com>

If we know we've already locked the bytes, don't do it again; similarly
don't unlock a byte if we haven't locked it. This doesn't change the
behavior, but fixes a corner case explained below.

Libvirt had an error handling bug that an image can get its (ownership,
file mode, SELinux) permissions changed (RHBZ 1584982) by mistake behind
QEMU. Specifically, an image in use by Libvirt VM has:

    $ ls -lhZ b.img
    -rw-r--r--. qemu qemu system_u:object_r:svirt_image_t:s0:c600,c690 b.img

Trying to attach it a second time won't work because of image locking.
And after the error, it becomes:

    $ ls -lhZ b.img
    -rw-r--r--. root root system_u:object_r:virt_image_t:s0 b.img

Then, we won't be able to do OFD lock operations with the existing fd.
In other words, the code such as in blk_detach_dev:

    blk_set_perm(blk, 0, BLK_PERM_ALL, &error_abort);

can abort() QEMU, out of environmental changes.

This patch is an easy fix to this and the change is regardlessly
reasonable, so do it.

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index fe83cbf0eb..73ae00c8c5 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -680,23 +680,42 @@ typedef enum {
  * file; if @unlock == true, also unlock the unneeded bytes.
  * @shared_perm_lock_bits is the mask of all permissions that are NOT shared.
  */
-static int raw_apply_lock_bytes(int fd,
+static int raw_apply_lock_bytes(BDRVRawState *s, int fd,
                                 uint64_t perm_lock_bits,
                                 uint64_t shared_perm_lock_bits,
                                 bool unlock, Error **errp)
 {
     int ret;
     int i;
+    uint64_t locked_perm, locked_shared_perm;
+
+    if (s) {
+        locked_perm = s->perm;
+        locked_shared_perm = ~s->shared_perm & BLK_PERM_ALL;
+    } else {
+        /*
+         * We don't have the previous bits, just lock/unlock for each of the
+         * requested bits.
+         */
+        if (unlock) {
+            locked_perm = BLK_PERM_ALL;
+            locked_shared_perm = BLK_PERM_ALL;
+        } else {
+            locked_perm = 0;
+            locked_shared_perm = 0;
+        }
+    }
 
     PERM_FOREACH(i) {
         int off = RAW_LOCK_PERM_BASE + i;
-        if (perm_lock_bits & (1ULL << i)) {
+        uint64_t bit = (1ULL << i);
+        if ((perm_lock_bits & bit) && !(locked_perm & bit)) {
             ret = qemu_lock_fd(fd, off, 1, false);
             if (ret) {
                 error_setg(errp, "Failed to lock byte %d", off);
                 return ret;
             }
-        } else if (unlock) {
+        } else if (unlock && (locked_perm & bit) && !(perm_lock_bits & bit)) {
             ret = qemu_unlock_fd(fd, off, 1);
             if (ret) {
                 error_setg(errp, "Failed to unlock byte %d", off);
@@ -706,13 +725,15 @@ static int raw_apply_lock_bytes(int fd,
     }
     PERM_FOREACH(i) {
         int off = RAW_LOCK_SHARED_BASE + i;
-        if (shared_perm_lock_bits & (1ULL << i)) {
+        uint64_t bit = (1ULL << i);
+        if ((shared_perm_lock_bits & bit) && !(locked_shared_perm & bit)) {
             ret = qemu_lock_fd(fd, off, 1, false);
             if (ret) {
                 error_setg(errp, "Failed to lock byte %d", off);
                 return ret;
             }
-        } else if (unlock) {
+        } else if (unlock && (locked_shared_perm & bit) &&
+                   !(shared_perm_lock_bits & bit)) {
             ret = qemu_unlock_fd(fd, off, 1);
             if (ret) {
                 error_setg(errp, "Failed to unlock byte %d", off);
@@ -788,7 +809,7 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
 
     switch (op) {
     case RAW_PL_PREPARE:
-        ret = raw_apply_lock_bytes(s->lock_fd, s->perm | new_perm,
+        ret = raw_apply_lock_bytes(s, s->lock_fd, s->perm | new_perm,
                                    ~s->shared_perm | ~new_shared,
                                    false, errp);
         if (!ret) {
@@ -800,7 +821,7 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
         op = RAW_PL_ABORT;
         /* fall through to unlock bytes. */
     case RAW_PL_ABORT:
-        raw_apply_lock_bytes(s->lock_fd, s->perm, ~s->shared_perm,
+        raw_apply_lock_bytes(s, s->lock_fd, s->perm, ~s->shared_perm,
                              true, &local_err);
         if (local_err) {
             /* Theoretically the above call only unlocks bytes and it cannot
@@ -810,7 +831,7 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
         }
         break;
     case RAW_PL_COMMIT:
-        raw_apply_lock_bytes(s->lock_fd, new_perm, ~new_shared,
+        raw_apply_lock_bytes(s, s->lock_fd, new_perm, ~new_shared,
                              true, &local_err);
         if (local_err) {
             /* Theoretically the above call only unlocks bytes and it cannot
@@ -2209,7 +2230,7 @@ raw_co_create(BlockdevCreateOptions *options, Error **errp)
     shared = BLK_PERM_ALL & ~BLK_PERM_RESIZE;
 
     /* Step one: Take locks */
-    result = raw_apply_lock_bytes(fd, perm, ~shared, false, errp);
+    result = raw_apply_lock_bytes(NULL, fd, perm, ~shared, false, errp);
     if (result < 0) {
         goto out_close;
     }
@@ -2250,7 +2271,7 @@ raw_co_create(BlockdevCreateOptions *options, Error **errp)
     }
 
 out_unlock:
-    raw_apply_lock_bytes(fd, 0, 0, true, &local_err);
+    raw_apply_lock_bytes(NULL, fd, 0, 0, true, &local_err);
     if (local_err) {
         /* The above call should not fail, and if it does, that does
          * not mean the whole creation operation has failed.  So
-- 
2.17.1
