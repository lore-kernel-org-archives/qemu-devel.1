Received: from eggs.gnu.org ([2001:4830:134:3::10]:33647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1evKWK-0002nA-VI
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1evKWH-0006oF-6q
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:17:32 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 12 Mar 2018 13:16:56 +0300
Message-Id: <1520849818-6915-8-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1520849818-6915-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1520849818-6915-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v8 7/9] block: support BDRV_REQ_ALLOCATE in
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
 block/quorum.c     | 3 ++-
 block/raw-format.c | 3 ++-
 5 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 5897124..d46f6c9 100644
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
index de2fdc1..03bec62 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -146,7 +146,7 @@ static int blkverify_open(BlockDriverState *bs, QDict *options, int flags,
         s->test_file->bs->supported_write_flags;
 
     bs->supported_zero_flags =
-        (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
+        (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_ALLOCATE) &
         bs->file->bs->supported_zero_flags &
         s->test_file->bs->supported_zero_flags;
 
diff --git a/block/mirror.c b/block/mirror.c
index 2fb786f..58f006f 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1105,7 +1105,7 @@ static void mirror_top_set_supported_flags(BlockDriverState *bs)
     bs->supported_write_flags = BDRV_REQ_FUA &
         bs->backing->bs->supported_write_flags;
     bs->supported_zero_flags =
-        (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
+        (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_ALLOCATE) &
         bs->backing->bs->supported_zero_flags;
 }
 
diff --git a/block/quorum.c b/block/quorum.c
index dc77a23..e369e79 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -873,7 +873,8 @@ static void quorum_set_supported_flags(BlockDriverState *bs)
     int i;
 
     bs->supported_write_flags = BDRV_REQ_FUA;
-    bs->supported_zero_flags  = BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP;
+    bs->supported_zero_flags  =
+        BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_ALLOCATE;
 
     for (i = 0; i < s->num_children; i++) {
         bs->supported_write_flags &= s->children[i]->bs->supported_write_flags;
diff --git a/block/raw-format.c b/block/raw-format.c
index a378547..ca65f86 100644
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
