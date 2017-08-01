Received: from eggs.gnu.org ([2001:4830:134:3::10]:43069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dcY1G-0000OC-Co
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dcY1F-0002Qc-DW
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:19:34 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue,  1 Aug 2017 17:19:03 +0300
Message-Id: <1501597152-25342-7-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1501597152-25342-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1501597152-25342-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 06/15] block: support BDRV_REQ_ALLOCATE in
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
Cc: qemu-block@nongnu.org, den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

Support the flag if the underlying BDS supports it

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 block/blkdebug.c   | 3 ++-
 block/blkverify.c  | 2 +-
 block/mirror.c     | 2 +-
 block/raw-format.c | 3 ++-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 234c8fb9..2ac3e12 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -414,7 +414,8 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
 
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
index 7e539f1..5510776 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1059,7 +1059,7 @@ static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs, QDict *opts)
     bs->supported_write_flags = BDRV_REQ_FUA &
         bs->backing->bs->supported_write_flags;
     bs->supported_zero_flags =
-        (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
+        (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_ALLOCATE) &
         bs->backing->bs->supported_zero_flags;
 }
 
diff --git a/block/raw-format.c b/block/raw-format.c
index 22c7e98..434af74 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -417,7 +417,8 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
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
