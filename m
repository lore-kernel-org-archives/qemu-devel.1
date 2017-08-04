Received: from eggs.gnu.org ([2001:4830:134:3::10]:51178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1ddeFD-0001XJ-62
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:10:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1ddeFA-00046M-9Y
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:10:31 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:4459 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1ddeF9-00041I-Ts
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:10:28 -0400
From: "Denis V. Lunev" <den@openvz.org>
Date: Fri,  4 Aug 2017 18:10:12 +0300
Message-Id: <20170804151013.13057-3-den@openvz.org>
In-Reply-To: <20170804151013.13057-1-den@openvz.org>
References: <20170804151013.13057-1-den@openvz.org>
Subject: [Qemu-devel] [PATCH 2/3] parallels: respect error code of
 bdrv_getlength() in allocate_clusters()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: den@openvz.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

If we can not get the file length, the state of BDS is broken completely.
Return error to the caller.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Markus Armbruster <armbru@redhat.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
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
2.11.0
