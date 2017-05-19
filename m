Received: from eggs.gnu.org ([2001:4830:134:3::10]:46569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBXij-0001oo-8n
	for qemu-devel@nongnu.org; Thu, 18 May 2017 22:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBXig-0002Ts-5u
	for qemu-devel@nongnu.org; Thu, 18 May 2017 22:32:49 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 18 May 2017 21:32:32 -0500
Message-Id: <20170519023233.24461-4-eblake@redhat.com>
In-Reply-To: <20170519023233.24461-1-eblake@redhat.com>
References: <20170519023233.24461-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] block: Simplify use of BDRV_BLOCK_RAW.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, mreitz@redhat.com, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>

The lone caller that cares about a return of BDRV_BLOCK_RAW
completely replaces the return value, so there is no point in
passing BDRV_BLOCK_DATA.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/commit.c     | 2 +-
 block/mirror.c     | 2 +-
 block/raw-format.c | 2 +-
 block/vpc.c        | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 76a0d98..cf662ba 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -239,7 +239,7 @@ static int64_t coroutine_fn bdrv_commit_top_get_block_status(
 {
     *pnum = nb_sectors;
     *file = bs->backing->bs;
-    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID | BDRV_BLOCK_DATA |
+    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
            (sector_num << BDRV_SECTOR_BITS);
 }

diff --git a/block/mirror.c b/block/mirror.c
index e86f8f8..970c9f2 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1047,7 +1047,7 @@ static int64_t coroutine_fn bdrv_mirror_top_get_block_status(
 {
     *pnum = nb_sectors;
     *file = bs->backing->bs;
-    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID | BDRV_BLOCK_DATA |
+    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
            (sector_num << BDRV_SECTOR_BITS);
 }

diff --git a/block/raw-format.c b/block/raw-format.c
index 36e6503..1136eba 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -259,7 +259,7 @@ static int64_t coroutine_fn raw_co_get_block_status(BlockDriverState *bs,
     *pnum = nb_sectors;
     *file = bs->file->bs;
     sector_num += s->offset / BDRV_SECTOR_SIZE;
-    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID | BDRV_BLOCK_DATA |
+    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
            (sector_num << BDRV_SECTOR_BITS);
 }

diff --git a/block/vpc.c b/block/vpc.c
index ecfee77..048504b 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -701,7 +701,7 @@ static int64_t coroutine_fn vpc_co_get_block_status(BlockDriverState *bs,
     if (be32_to_cpu(footer->type) == VHD_FIXED) {
         *pnum = nb_sectors;
         *file = bs->file->bs;
-        return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID | BDRV_BLOCK_DATA |
+        return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
                (sector_num << BDRV_SECTOR_BITS);
     }

-- 
2.9.4
