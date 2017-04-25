Received: from eggs.gnu.org ([2001:4830:134:3::10]:52617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d36cM-000760-4Y
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d36cK-00042Y-5C
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:59:22 -0400
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Wed, 26 Apr 2017 01:29:08 +0530
Message-Id: <1493150351-28918-6-git-send-email-ashijeetacharya@gmail.com>
In-Reply-To: <1493150351-28918-1-git-send-email-ashijeetacharya@gmail.com>
References: <1493150351-28918-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v1 5/8] dmg: Handle zlib compressed chunks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com
Cc: kwolf@redhat.com, jsnow@redhat.com, mreitz@redhat.com, famz@redhat.com, peter@lekensteyn.nl, qemu-devel@nongnu.org, qemu-block@nongnu.org, Ashijeet Acharya <ashijeetacharya@gmail.com>

Set the output buffer size to be equal to the size of number of sectors
stored in @sectors_read. Start inflating to a max output buffer size of
2MB and cache our access point to aid random access later if required.

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
---
 block/dmg.c | 48 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/block/dmg.c b/block/dmg.c
index dc356b0..749c151 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -621,27 +621,47 @@ static inline int dmg_read_chunk(BlockDriverState *bs, uint64_t sector_num,
 
     switch (s->types[chunk]) { /* block entry type */
     case 0x80000005: { /* zlib compressed */
-        /* we need to buffer, because only the chunk as whole can be
-         * inflated. */
-        ret = bdrv_pread(bs->file, s->offsets[chunk],
-                         s->compressed_chunk, s->lengths[chunk]);
-        if (ret != s->lengths[chunk]) {
-            return -1;
+        /* check for cached random access point */
+        if (drs->saved_next_in == NULL) {
+            /* we need to buffer, because only the chunk as whole can be
+             * inflated. */
+            ret = bdrv_pread(bs->file, s->offsets[chunk],
+                             s->compressed_chunk, s->lengths[chunk]);
+            if (ret != s->lengths[chunk]) {
+                return -1;
+            }
+
+            s->zstream.next_in = s->compressed_chunk;
+            s->zstream.avail_in = s->lengths[chunk];
+        } else {
+            s->zstream.next_in = drs->saved_next_in;
+            s->zstream.avail_in = drs->saved_avail_in;
         }
 
-        s->zstream.next_in = s->compressed_chunk;
-        s->zstream.avail_in = s->lengths[chunk];
         s->zstream.next_out = s->uncompressed_chunk;
-        s->zstream.avail_out = 512 * s->sectorcounts[chunk];
-        ret = inflateReset(&s->zstream);
-        if (ret != Z_OK) {
-            return -1;
+
+        s->zstream.avail_out = sectors_read * BDRV_SECTOR_SIZE;
+
+        if (drs->saved_next_in == NULL) {
+            ret = inflateReset(&s->zstream);
+            if (ret != Z_OK) {
+                return -1;
+            }
+        }
+        /* reset total_out for each successive call */
+        s->zstream.total_out = 0;
+        ret = inflate(&s->zstream, Z_SYNC_FLUSH);
+        if (ret == Z_OK &&
+            s->zstream.total_out == 512 * sectors_read) {
+            goto update;
         }
-        ret = inflate(&s->zstream, Z_FINISH);
         if (ret != Z_STREAM_END ||
-            s->zstream.total_out != 512 * s->sectorcounts[chunk]) {
+            s->zstream.total_out != 512 * sectors_read) {
             return -1;
         }
+update:
+        cache_access_point(drs, s->zstream.next_in, s->zstream.avail_in,
+                           chunk, sectors_read, sector_offset);
         break; }
     case 0x80000006: /* bzip2 compressed */
         if (!dmg_uncompress_bz2) {
-- 
2.6.2
