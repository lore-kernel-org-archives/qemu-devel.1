Received: from eggs.gnu.org ([2001:4830:134:3::10]:52701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNm0-0004AC-8u
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNlz-0001XM-3v
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:20 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 16:25:43 +0200
Message-Id: <20180611142611.6609-2-mreitz@redhat.com>
In-Reply-To: <20180611142611.6609-1-mreitz@redhat.com>
References: <20180611142611.6609-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 01/29] block/file-posix: Pass FD to locking
 helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

raw_apply_lock_bytes() and raw_check_lock_bytes() currently take a
BDRVRawState *, but they only use the lock_fd field.  During image
creation, we do not have a BDRVRawState, but we do have an FD; so if we
want to reuse the functions there, we should modify them to receive only
the FD.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20180509215336.31304-2-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/file-posix.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 513d371bb1..7583bbfbb3 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -643,7 +643,7 @@ typedef enum {
  * file; if @unlock == true, also unlock the unneeded bytes.
  * @shared_perm_lock_bits is the mask of all permissions that are NOT shared.
  */
-static int raw_apply_lock_bytes(BDRVRawState *s,
+static int raw_apply_lock_bytes(int fd,
                                 uint64_t perm_lock_bits,
                                 uint64_t shared_perm_lock_bits,
                                 bool unlock, Error **errp)
@@ -654,13 +654,13 @@ static int raw_apply_lock_bytes(BDRVRawState *s,
     PERM_FOREACH(i) {
         int off = RAW_LOCK_PERM_BASE + i;
         if (perm_lock_bits & (1ULL << i)) {
-            ret = qemu_lock_fd(s->lock_fd, off, 1, false);
+            ret = qemu_lock_fd(fd, off, 1, false);
             if (ret) {
                 error_setg(errp, "Failed to lock byte %d", off);
                 return ret;
             }
         } else if (unlock) {
-            ret = qemu_unlock_fd(s->lock_fd, off, 1);
+            ret = qemu_unlock_fd(fd, off, 1);
             if (ret) {
                 error_setg(errp, "Failed to unlock byte %d", off);
                 return ret;
@@ -670,13 +670,13 @@ static int raw_apply_lock_bytes(BDRVRawState *s,
     PERM_FOREACH(i) {
         int off = RAW_LOCK_SHARED_BASE + i;
         if (shared_perm_lock_bits & (1ULL << i)) {
-            ret = qemu_lock_fd(s->lock_fd, off, 1, false);
+            ret = qemu_lock_fd(fd, off, 1, false);
             if (ret) {
                 error_setg(errp, "Failed to lock byte %d", off);
                 return ret;
             }
         } else if (unlock) {
-            ret = qemu_unlock_fd(s->lock_fd, off, 1);
+            ret = qemu_unlock_fd(fd, off, 1);
             if (ret) {
                 error_setg(errp, "Failed to unlock byte %d", off);
                 return ret;
@@ -687,8 +687,7 @@ static int raw_apply_lock_bytes(BDRVRawState *s,
 }
 
 /* Check "unshared" bytes implied by @perm and ~@shared_perm in the file. */
-static int raw_check_lock_bytes(BDRVRawState *s,
-                                uint64_t perm, uint64_t shared_perm,
+static int raw_check_lock_bytes(int fd, uint64_t perm, uint64_t shared_perm,
                                 Error **errp)
 {
     int ret;
@@ -698,7 +697,7 @@ static int raw_check_lock_bytes(BDRVRawState *s,
         int off = RAW_LOCK_SHARED_BASE + i;
         uint64_t p = 1ULL << i;
         if (perm & p) {
-            ret = qemu_lock_fd_test(s->lock_fd, off, 1, true);
+            ret = qemu_lock_fd_test(fd, off, 1, true);
             if (ret) {
                 char *perm_name = bdrv_perm_names(p);
                 error_setg(errp,
@@ -715,7 +714,7 @@ static int raw_check_lock_bytes(BDRVRawState *s,
         int off = RAW_LOCK_PERM_BASE + i;
         uint64_t p = 1ULL << i;
         if (!(shared_perm & p)) {
-            ret = qemu_lock_fd_test(s->lock_fd, off, 1, true);
+            ret = qemu_lock_fd_test(fd, off, 1, true);
             if (ret) {
                 char *perm_name = bdrv_perm_names(p);
                 error_setg(errp,
@@ -752,11 +751,11 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
 
     switch (op) {
     case RAW_PL_PREPARE:
-        ret = raw_apply_lock_bytes(s, s->perm | new_perm,
+        ret = raw_apply_lock_bytes(s->lock_fd, s->perm | new_perm,
                                    ~s->shared_perm | ~new_shared,
                                    false, errp);
         if (!ret) {
-            ret = raw_check_lock_bytes(s, new_perm, new_shared, errp);
+            ret = raw_check_lock_bytes(s->lock_fd, new_perm, new_shared, errp);
             if (!ret) {
                 return 0;
             }
@@ -764,7 +763,8 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
         op = RAW_PL_ABORT;
         /* fall through to unlock bytes. */
     case RAW_PL_ABORT:
-        raw_apply_lock_bytes(s, s->perm, ~s->shared_perm, true, &local_err);
+        raw_apply_lock_bytes(s->lock_fd, s->perm, ~s->shared_perm,
+                             true, &local_err);
         if (local_err) {
             /* Theoretically the above call only unlocks bytes and it cannot
              * fail. Something weird happened, report it.
@@ -773,7 +773,8 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
         }
         break;
     case RAW_PL_COMMIT:
-        raw_apply_lock_bytes(s, new_perm, ~new_shared, true, &local_err);
+        raw_apply_lock_bytes(s->lock_fd, new_perm, ~new_shared,
+                             true, &local_err);
         if (local_err) {
             /* Theoretically the above call only unlocks bytes and it cannot
              * fail. Something weird happened, report it.
-- 
2.17.1
