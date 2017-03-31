Received: from eggs.gnu.org ([2001:4830:134:3::10]:35365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctzzK-0002w4-Cg
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctzzJ-00042F-7Q
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:05:26 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 31 Mar 2017 19:05:12 +0200
Message-Id: <20170331170512.10381-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9] block/parallels: Avoid overflows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Change the types of variables in allocate_clusters() to int64_t so we do
not have to worry about potential overflows.

Add an assertion that our accesses to s->bat[] do not result in a buffer
overflow and that the implicit conversion performed when invoking
bat_entry_off() does not result in an integer overflow.

Coverity-id: 1307776
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
This supercedes Peter's patch "block/parallels.c: avoid integer overflow
in allocate_clusters()".
---
 block/parallels.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 4173b3fb9d..90acf79687 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -192,8 +192,7 @@ static int64_t allocate_clusters(BlockDriverState *bs, int64_t sector_num,
                                  int nb_sectors, int *pnum)
 {
     BDRVParallelsState *s = bs->opaque;
-    uint32_t idx, to_allocate, i;
-    int64_t pos, space;
+    int64_t pos, space, idx, to_allocate, i;
 
     pos = block_status(s, sector_num, nb_sectors, pnum);
     if (pos > 0) {
@@ -201,11 +200,19 @@ static int64_t allocate_clusters(BlockDriverState *bs, int64_t sector_num,
     }
 
     idx = sector_num / s->tracks;
-    if (idx >= s->bat_size) {
-        return -EINVAL;
-    }
-
     to_allocate = DIV_ROUND_UP(sector_num + *pnum, s->tracks) - idx;
+
+    /* This function is called only by parallels_co_writev(), which will never
+     * pass a sector_num at or beyond the end of the image (because the block
+     * layer never passes such a sector_num to that function). Therefore, idx
+     * is always below s->bat_size.
+     * block_status() will limit *pnum so that sector_num + *pnum will not
+     * exceed the image end. Therefore, idx + to_allocate cannot exceed
+     * s->bat_size.
+     * Note that s->bat_size is an unsigned int, therefore idx + to_allocate
+     * will always fit into a uint32_t. */
+    assert(idx < s->bat_size && idx + to_allocate <= s->bat_size);
+
     space = to_allocate * s->tracks;
     if (s->data_end + space > bdrv_getlength(bs->file->bs) >> BDRV_SECTOR_BITS) {
         int ret;
-- 
2.12.1
