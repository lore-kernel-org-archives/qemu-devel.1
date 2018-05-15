Received: from eggs.gnu.org ([2001:4830:134:3::10]:39207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4l-00074y-6k
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4g-0001ol-2J
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:19 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 15 May 2018 17:40:25 +0200
Message-Id: <20180515154033.19899-30-kwolf@redhat.com>
In-Reply-To: <20180515154033.19899-1-kwolf@redhat.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 29/37] block: Support BDRV_REQ_WRITE_UNCHANGED
 in filters
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

From: Max Reitz <mreitz@redhat.com>

Update the rest of the filter drivers to support
BDRV_REQ_WRITE_UNCHANGED.  They already forward write request flags to
their children, so we just have to announce support for it.

This patch does not cover the replication driver because that currently
does not support flags at all, and because it just grabs the WRITE
permission for its children when it can, so we should be fine just
submitting the incoming WRITE_UNCHANGED requests as normal writes.

It also does not cover format drivers for similar reasons.  They all use
bdrv_format_default_perms() as their .bdrv_child_perm() implementation
so they just always grab the WRITE permission for their file children
whenever possible.  In addition, it often would be difficult to
ascertain whether incoming unchanging writes end up as unchanging writes
in their files.  So we just leave them as normal potentially changing
writes.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-id: 20180421132929.21610-7-mreitz@redhat.com
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/blkdebug.c     |  9 +++++----
 block/blkreplay.c    |  3 +++
 block/blkverify.c    |  3 +++
 block/copy-on-read.c | 10 ++++++----
 block/mirror.c       |  2 ++
 block/raw-format.c   |  9 +++++----
 block/throttle.c     |  6 ++++--
 7 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 053372c22e..526af2a808 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -398,10 +398,11 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
         goto out;
     }
 
-    bs->supported_write_flags = BDRV_REQ_FUA &
-        bs->file->bs->supported_write_flags;
-    bs->supported_zero_flags = (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
-        bs->file->bs->supported_zero_flags;
+    bs->supported_write_flags = BDRV_REQ_WRITE_UNCHANGED |
+        (BDRV_REQ_FUA & bs->file->bs->supported_write_flags);
+    bs->supported_zero_flags = BDRV_REQ_WRITE_UNCHANGED |
+        ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
+            bs->file->bs->supported_zero_flags);
     ret = -EINVAL;
 
     /* Set alignment overrides */
diff --git a/block/blkreplay.c b/block/blkreplay.c
index fe5a9b4a98..b016dbeee7 100755
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -35,6 +35,9 @@ static int blkreplay_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
+    bs->supported_write_flags = BDRV_REQ_WRITE_UNCHANGED;
+    bs->supported_zero_flags = BDRV_REQ_WRITE_UNCHANGED;
+
     ret = 0;
 fail:
     return ret;
diff --git a/block/blkverify.c b/block/blkverify.c
index 754cc9e857..da97ee5927 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -141,6 +141,9 @@ static int blkverify_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
+    bs->supported_write_flags = BDRV_REQ_WRITE_UNCHANGED;
+    bs->supported_zero_flags = BDRV_REQ_WRITE_UNCHANGED;
+
     ret = 0;
 fail:
     qemu_opts_del(opts);
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index 823ec751c4..6a97208888 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -33,11 +33,13 @@ static int cor_open(BlockDriverState *bs, QDict *options, int flags,
         return -EINVAL;
     }
 
-    bs->supported_write_flags = BDRV_REQ_FUA &
-                                    bs->file->bs->supported_write_flags;
+    bs->supported_write_flags = BDRV_REQ_WRITE_UNCHANGED |
+                                (BDRV_REQ_FUA &
+                                    bs->file->bs->supported_write_flags);
 
-    bs->supported_zero_flags = (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
-                                    bs->file->bs->supported_zero_flags;
+    bs->supported_zero_flags = BDRV_REQ_WRITE_UNCHANGED |
+                               ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
+                                    bs->file->bs->supported_zero_flags);
 
     return 0;
 }
diff --git a/block/mirror.c b/block/mirror.c
index 6aa38db114..a4197bb975 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1134,6 +1134,8 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
         mirror_top_bs->implicit = true;
     }
     mirror_top_bs->total_sectors = bs->total_sectors;
+    mirror_top_bs->supported_write_flags = BDRV_REQ_WRITE_UNCHANGED;
+    mirror_top_bs->supported_zero_flags = BDRV_REQ_WRITE_UNCHANGED;
     bdrv_set_aio_context(mirror_top_bs, bdrv_get_aio_context(bs));
 
     /* bdrv_append takes ownership of the mirror_top_bs reference, need to keep
diff --git a/block/raw-format.c b/block/raw-format.c
index a378547c99..fe33693a2d 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -415,10 +415,11 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     bs->sg = bs->file->bs->sg;
-    bs->supported_write_flags = BDRV_REQ_FUA &
-        bs->file->bs->supported_write_flags;
-    bs->supported_zero_flags = (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
-        bs->file->bs->supported_zero_flags;
+    bs->supported_write_flags = BDRV_REQ_WRITE_UNCHANGED |
+        (BDRV_REQ_FUA & bs->file->bs->supported_write_flags);
+    bs->supported_zero_flags = BDRV_REQ_WRITE_UNCHANGED |
+        ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
+            bs->file->bs->supported_zero_flags);
 
     if (bs->probed && !bdrv_is_read_only(bs)) {
         fprintf(stderr,
diff --git a/block/throttle.c b/block/throttle.c
index 95ed06acd8..e298827f95 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -81,8 +81,10 @@ static int throttle_open(BlockDriverState *bs, QDict *options,
     if (!bs->file) {
         return -EINVAL;
     }
-    bs->supported_write_flags = bs->file->bs->supported_write_flags;
-    bs->supported_zero_flags = bs->file->bs->supported_zero_flags;
+    bs->supported_write_flags = bs->file->bs->supported_write_flags |
+                                BDRV_REQ_WRITE_UNCHANGED;
+    bs->supported_zero_flags = bs->file->bs->supported_zero_flags |
+                               BDRV_REQ_WRITE_UNCHANGED;
 
     return throttle_configure_tgm(bs, tgm, options, errp);
 }
-- 
2.13.6
