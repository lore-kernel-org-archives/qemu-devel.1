Received: from eggs.gnu.org ([2001:4830:134:3::10]:55723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ebQvT-0002n7-26
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:05:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ebQvJ-0006VK-Jc
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:05:15 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 16 Jan 2018 16:04:27 +0300
Message-Id: <1516107870-8110-7-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1516107870-8110-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1516107870-8110-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 6/9] block: support BDRV_REQ_ALLOCATE in
 passthrough drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

Support the flag if the underlying BDS supports it

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/blkdebug.c   | 3 ++-
 block/blkverify.c  | 2 +-
 block/mirror.c     | 2 +-
 block/raw-format.c | 3 ++-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index e216699..7d5773d 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -400,7 +400,8 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
 
     bs->supported_write_flags = BDRV_REQ_FUA &
         bs->file->bs->supported_write_flags;
-    bs->supported_zero_flags = (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
+    bs->supported_zero_flags =
+        (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_ALLOCATE) &
         bs->file->bs->supported_zero_flags;
     ret = -EINVAL;
 
diff --git a/block/blkverify.c b/block/blkverify.c
index 9ba65d0..b249636 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -145,7 +145,7 @@ static int blkverify_open(BlockDriverState *bs, QDict *options, int flags,
         s->test_file->bs->supported_write_flags;
 
     bs->supported_zero_flags =
-        (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
+        (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_ALLOCATE) &
         bs->file->bs->supported_zero_flags &
         s->test_file->bs->supported_zero_flags;
 
diff --git a/block/mirror.c b/block/mirror.c
index d18ec65..eb41deb 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1067,7 +1067,7 @@ static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs, QDict *opts)
     bs->supported_write_flags = BDRV_REQ_FUA &
         bs->backing->bs->supported_write_flags;
     bs->supported_zero_flags =
-        (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
+        (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_ALLOCATE) &
         bs->backing->bs->supported_zero_flags;
 }
 
diff --git a/block/raw-format.c b/block/raw-format.c
index ab552c0..b1deb93 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -416,7 +416,8 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
     bs->sg = bs->file->bs->sg;
     bs->supported_write_flags = BDRV_REQ_FUA &
         bs->file->bs->supported_write_flags;
-    bs->supported_zero_flags = (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
+    bs->supported_zero_flags =
+        (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_ALLOCATE) &
         bs->file->bs->supported_zero_flags;
 
     if (bs->probed && !bdrv_is_read_only(bs)) {
-- 
2.7.4
