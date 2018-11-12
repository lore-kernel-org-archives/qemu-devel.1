Received: from eggs.gnu.org ([2001:4830:134:3::10]:59862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfm-0000hE-HK
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:06:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfh-00079L-FT
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:06:50 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 12 Nov 2018 18:05:55 +0100
Message-Id: <20181112170603.23986-7-kwolf@redhat.com>
In-Reply-To: <20181112170603.23986-1-kwolf@redhat.com>
References: <20181112170603.23986-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/14] file-posix: Skip effectiveless OFD lock
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

If we know we've already locked the bytes, don't do it again; similarly
don't unlock a byte if we haven't locked it. This doesn't change the
behavior, but fixes a corner case explained below.

Libvirt had an error handling bug that an image can get its (ownership,
file mode, SELinux) permissions changed (RHBZ 1584982) by mistake behind
QEMU. Specifically, an image in use by Libvirt VM has:

    $ ls -lhZ b.img
    -rw-r--r--. qemu qemu system_u:object_r:svirt_image_t:s0:c600,c690 b.=
img

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
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 54 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 10 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 074f0ce2b3..1b4ff8de00 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -152,6 +152,11 @@ typedef struct BDRVRawState {
     uint64_t perm;
     uint64_t shared_perm;
=20
+    /* The perms bits whose corresponding bytes are already locked in
+     * s->lock_fd. */
+    uint64_t locked_perm;
+    uint64_t locked_shared_perm;
+
 #ifdef CONFIG_XFS
     bool is_xfs:1;
 #endif
@@ -689,43 +694,72 @@ typedef enum {
  * file; if @unlock =3D=3D true, also unlock the unneeded bytes.
  * @shared_perm_lock_bits is the mask of all permissions that are NOT sh=
ared.
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
+        locked_perm =3D s->locked_perm;
+        locked_shared_perm =3D s->locked_shared_perm;
+    } else {
+        /*
+         * We don't have the previous bits, just lock/unlock for each of=
 the
+         * requested bits.
+         */
+        if (unlock) {
+            locked_perm =3D BLK_PERM_ALL;
+            locked_shared_perm =3D BLK_PERM_ALL;
+        } else {
+            locked_perm =3D 0;
+            locked_shared_perm =3D 0;
+        }
+    }
=20
     PERM_FOREACH(i) {
         int off =3D RAW_LOCK_PERM_BASE + i;
-        if (perm_lock_bits & (1ULL << i)) {
+        uint64_t bit =3D (1ULL << i);
+        if ((perm_lock_bits & bit) && !(locked_perm & bit)) {
             ret =3D qemu_lock_fd(fd, off, 1, false);
             if (ret) {
                 error_setg(errp, "Failed to lock byte %d", off);
                 return ret;
+            } else if (s) {
+                s->locked_perm |=3D bit;
             }
-        } else if (unlock) {
+        } else if (unlock && (locked_perm & bit) && !(perm_lock_bits & b=
it)) {
             ret =3D qemu_unlock_fd(fd, off, 1);
             if (ret) {
                 error_setg(errp, "Failed to unlock byte %d", off);
                 return ret;
+            } else if (s) {
+                s->locked_perm &=3D ~bit;
             }
         }
     }
     PERM_FOREACH(i) {
         int off =3D RAW_LOCK_SHARED_BASE + i;
-        if (shared_perm_lock_bits & (1ULL << i)) {
+        uint64_t bit =3D (1ULL << i);
+        if ((shared_perm_lock_bits & bit) && !(locked_shared_perm & bit)=
) {
             ret =3D qemu_lock_fd(fd, off, 1, false);
             if (ret) {
                 error_setg(errp, "Failed to lock byte %d", off);
                 return ret;
+            } else if (s) {
+                s->locked_shared_perm |=3D bit;
             }
-        } else if (unlock) {
+        } else if (unlock && (locked_shared_perm & bit) &&
+                   !(shared_perm_lock_bits & bit)) {
             ret =3D qemu_unlock_fd(fd, off, 1);
             if (ret) {
                 error_setg(errp, "Failed to unlock byte %d", off);
                 return ret;
+            } else if (s) {
+                s->locked_shared_perm &=3D ~bit;
             }
         }
     }
@@ -793,7 +827,7 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
=20
     switch (op) {
     case RAW_PL_PREPARE:
-        ret =3D raw_apply_lock_bytes(s->lock_fd, s->perm | new_perm,
+        ret =3D raw_apply_lock_bytes(s, s->lock_fd, s->perm | new_perm,
                                    ~s->shared_perm | ~new_shared,
                                    false, errp);
         if (!ret) {
@@ -808,7 +842,7 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
         op =3D RAW_PL_ABORT;
         /* fall through to unlock bytes. */
     case RAW_PL_ABORT:
-        raw_apply_lock_bytes(s->lock_fd, s->perm, ~s->shared_perm,
+        raw_apply_lock_bytes(s, s->lock_fd, s->perm, ~s->shared_perm,
                              true, &local_err);
         if (local_err) {
             /* Theoretically the above call only unlocks bytes and it ca=
nnot
@@ -818,7 +852,7 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
         }
         break;
     case RAW_PL_COMMIT:
-        raw_apply_lock_bytes(s->lock_fd, new_perm, ~new_shared,
+        raw_apply_lock_bytes(s, s->lock_fd, new_perm, ~new_shared,
                              true, &local_err);
         if (local_err) {
             /* Theoretically the above call only unlocks bytes and it ca=
nnot
@@ -2220,7 +2254,7 @@ raw_co_create(BlockdevCreateOptions *options, Error=
 **errp)
     shared =3D BLK_PERM_ALL & ~BLK_PERM_RESIZE;
=20
     /* Step one: Take locks */
-    result =3D raw_apply_lock_bytes(fd, perm, ~shared, false, errp);
+    result =3D raw_apply_lock_bytes(NULL, fd, perm, ~shared, false, errp=
);
     if (result < 0) {
         goto out_close;
     }
@@ -2264,7 +2298,7 @@ raw_co_create(BlockdevCreateOptions *options, Error=
 **errp)
     }
=20
 out_unlock:
-    raw_apply_lock_bytes(fd, 0, 0, true, &local_err);
+    raw_apply_lock_bytes(NULL, fd, 0, 0, true, &local_err);
     if (local_err) {
         /* The above call should not fail, and if it does, that does
          * not mean the whole creation operation has failed.  So
--=20
2.19.1
