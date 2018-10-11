Received: from eggs.gnu.org ([2001:4830:134:3::10]:49257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gAVI5-0006ky-FI
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 03:21:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gAVI4-00038A-Kx
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 03:21:49 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 11 Oct 2018 15:21:34 +0800
Message-Id: <20181011072135.588-3-famz@redhat.com>
In-Reply-To: <20181011072135.588-1-famz@redhat.com>
References: <20181011072135.588-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 2/3] file-posix: Drop s->lock_fd
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

The lock_fd field is not strictly necessary because transferring locked
bytes from old fd to the new one shouldn't fail anyway. This spares the
user one fd per image.

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/file-posix.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index cf5eb98caa..d493357b89 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -142,7 +142,6 @@ do { \
 
 typedef struct BDRVRawState {
     int fd;
-    int lock_fd;
     bool use_lock;
     int type;
     int open_flags;
@@ -153,7 +152,7 @@ typedef struct BDRVRawState {
     uint64_t shared_perm;
 
     /* The perms bits whose corresponding bytes are already locked in
-     * s->lock_fd. */
+     * s->fd. */
     uint64_t locked_perm;
     uint64_t locked_shared_perm;
 
@@ -542,18 +541,6 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     }
     s->fd = fd;
 
-    s->lock_fd = -1;
-    if (s->use_lock) {
-        fd = qemu_open(filename, s->open_flags);
-        if (fd < 0) {
-            ret = -errno;
-            error_setg_errno(errp, errno, "Could not open '%s' for locking",
-                             filename);
-            qemu_close(s->fd);
-            goto fail;
-        }
-        s->lock_fd = fd;
-    }
     s->perm = 0;
     s->shared_perm = BLK_PERM_ALL;
 
@@ -814,15 +801,13 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
         return 0;
     }
 
-    assert(s->lock_fd > 0);
-
     switch (op) {
     case RAW_PL_PREPARE:
-        ret = raw_apply_lock_bytes(s, s->lock_fd, s->perm | new_perm,
+        ret = raw_apply_lock_bytes(s, s->fd, s->perm | new_perm,
                                    ~s->shared_perm | ~new_shared,
                                    false, errp);
         if (!ret) {
-            ret = raw_check_lock_bytes(s->lock_fd, new_perm, new_shared, errp);
+            ret = raw_check_lock_bytes(s->fd, new_perm, new_shared, errp);
             if (!ret) {
                 return 0;
             }
@@ -833,7 +818,7 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
         op = RAW_PL_ABORT;
         /* fall through to unlock bytes. */
     case RAW_PL_ABORT:
-        raw_apply_lock_bytes(s, s->lock_fd, s->perm, ~s->shared_perm,
+        raw_apply_lock_bytes(s, s->fd, s->perm, ~s->shared_perm,
                              true, &local_err);
         if (local_err) {
             /* Theoretically the above call only unlocks bytes and it cannot
@@ -843,7 +828,7 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
         }
         break;
     case RAW_PL_COMMIT:
-        raw_apply_lock_bytes(s, s->lock_fd, new_perm, ~new_shared,
+        raw_apply_lock_bytes(s, s->fd, new_perm, ~new_shared,
                              true, &local_err);
         if (local_err) {
             /* Theoretically the above call only unlocks bytes and it cannot
@@ -960,10 +945,18 @@ static void raw_reopen_commit(BDRVReopenState *state)
 {
     BDRVRawReopenState *rs = state->opaque;
     BDRVRawState *s = state->bs->opaque;
+    Error *local_err = NULL;
 
     s->check_cache_dropped = rs->check_cache_dropped;
     s->open_flags = rs->open_flags;
 
+    /* Copy locks to the new fd before closing the old one. */
+    raw_apply_lock_bytes(NULL, rs->fd, s->locked_perm,
+                         ~s->locked_shared_perm, false, &local_err);
+    if (local_err) {
+        /* shouldn't fail in a sane host, but report it just in case. */
+        error_report_err(local_err);
+    }
     qemu_close(s->fd);
     s->fd = rs->fd;
 
@@ -1956,10 +1949,6 @@ static void raw_close(BlockDriverState *bs)
         qemu_close(s->fd);
         s->fd = -1;
     }
-    if (s->lock_fd >= 0) {
-        qemu_close(s->lock_fd);
-        s->lock_fd = -1;
-    }
 }
 
 /**
-- 
2.17.1
