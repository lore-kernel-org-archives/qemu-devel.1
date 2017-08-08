Received: from eggs.gnu.org ([2001:4830:134:3::10]:42516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52R-0000Ld-1h
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52L-0002BA-Ee
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:15 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  8 Aug 2017 15:58:31 +0200
Message-Id: <20170808135838.11525-12-kwolf@redhat.com>
In-Reply-To: <20170808135838.11525-1-kwolf@redhat.com>
References: <20170808135838.11525-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 11/18] parallels: respect error code of
 bdrv_getlength() in allocate_clusters()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

From: "Denis V. Lunev" <den@openvz.org>

If we can not get the file length, the state of BDS is broken completely.
Return error to the caller.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Markus Armbruster <armbru@redhat.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/parallels.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 5bbdfabb7a..6794e53c0b 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -192,7 +192,7 @@ static int64_t allocate_clusters(BlockDriverState *bs, int64_t sector_num,
                                  int nb_sectors, int *pnum)
 {
     BDRVParallelsState *s = bs->opaque;
-    int64_t pos, space, idx, to_allocate, i;
+    int64_t pos, space, idx, to_allocate, i, len;
 
     pos = block_status(s, sector_num, nb_sectors, pnum);
     if (pos > 0) {
@@ -214,7 +214,11 @@ static int64_t allocate_clusters(BlockDriverState *bs, int64_t sector_num,
     assert(idx < s->bat_size && idx + to_allocate <= s->bat_size);
 
     space = to_allocate * s->tracks;
-    if (s->data_end + space > bdrv_getlength(bs->file->bs) >> BDRV_SECTOR_BITS) {
+    len = bdrv_getlength(bs->file->bs);
+    if (len < 0) {
+        return len;
+    }
+    if (s->data_end + space > (len >> BDRV_SECTOR_BITS)) {
         int ret;
         space += s->prealloc_size;
         if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE) {
-- 
2.13.4
