Received: from eggs.gnu.org ([2001:4830:134:3::10]:60723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f87TL-0007h9-Km
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f87TK-0003Ov-FP
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:59:19 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 16 Apr 2018 18:58:46 +0200
Message-Id: <20180416165849.28864-7-mreitz@redhat.com>
In-Reply-To: <20180416165849.28864-1-mreitz@redhat.com>
References: <20180416165849.28864-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 6/9] block: Support BDRV_REQ_WRITE_UNCHANGED in
 filters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

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
---
 block/blkdebug.c   |  9 +++++----
 block/blkreplay.c  |  3 +++
 block/blkverify.c  |  3 +++
 block/cor.c        | 10 ++++++----
 block/mirror.c     |  2 ++
 block/raw-format.c |  9 +++++----
 block/throttle.c   |  6 ++++--
 7 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 589712475a..762ec2527c 100644
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
index 331365be33..1646404b46 100644
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
diff --git a/block/cor.c b/block/cor.c
index a4cb4e2b84..189e5bd13e 100644
--- a/block/cor.c
+++ b/block/cor.c
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
index 820f512c7b..6fdd36d27f 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1148,6 +1148,8 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
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
2.14.3
