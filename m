Received: from eggs.gnu.org ([2001:4830:134:3::10]:52800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d36cb-0007JN-23
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d36ca-00046n-65
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:59:37 -0400
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Wed, 26 Apr 2017 01:29:11 +0530
Message-Id: <1493150351-28918-9-git-send-email-ashijeetacharya@gmail.com>
In-Reply-To: <1493150351-28918-1-git-send-email-ashijeetacharya@gmail.com>
References: <1493150351-28918-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v1 8/8] dmg: Remove the error messages to allow
 wild images
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

We have refactored the DMG driver to accept and process images
irrespective of their chunk sizes since we now have limit of 2MB on our
output buffer size. Thus QEMU will not allocate huge amounts of memory
no matter what the chunk size is.

Remove the error messages to prevent denial-of-service in cases where
untrusted files are being accessed by the user.

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
---
 block/dmg.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/block/dmg.c b/block/dmg.c
index b0f3c84..01ec40e 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -209,7 +209,6 @@ static int dmg_read_mish_block(BDRVDMGState *s, DmgHeaderState *ds,
                                uint8_t *buffer, uint32_t count)
 {
     uint32_t type, i;
-    int ret;
     size_t new_size;
     uint32_t chunk_count;
     int64_t offset = 0;
@@ -258,16 +257,6 @@ static int dmg_read_mish_block(BDRVDMGState *s, DmgHeaderState *ds,
         /* sector count */
         s->sectorcounts[i] = buff_read_uint64(buffer, offset + 0x10);
 
-        /* all-zeroes sector (type 2) does not need to be "uncompressed" and can
-         * therefore be unbounded. */
-        if (s->types[i] != 2 && s->sectorcounts[i] > DMG_SECTOR_MAX) {
-            error_report("sector count %" PRIu64 " for chunk %" PRIu32
-                         " is larger than max (%u)",
-                         s->sectorcounts[i], i, DMG_SECTOR_MAX);
-            ret = -EINVAL;
-            goto fail;
-        }
-
         /* offset in (compressed) data fork */
         s->offsets[i] = buff_read_uint64(buffer, offset + 0x18);
         s->offsets[i] += in_offset;
@@ -275,23 +264,12 @@ static int dmg_read_mish_block(BDRVDMGState *s, DmgHeaderState *ds,
         /* length in (compressed) data fork */
         s->lengths[i] = buff_read_uint64(buffer, offset + 0x20);
 
-        if (s->lengths[i] > DMG_MAX_OUTPUT) {
-            error_report("length %" PRIu64 " for chunk %" PRIu32
-                         " is larger than max (%u)",
-                         s->lengths[i], i, DMG_MAX_OUTPUT);
-            ret = -EINVAL;
-            goto fail;
-        }
-
         update_max_chunk_size(s, i, &ds->max_compressed_size,
                               &ds->max_sectors_per_chunk);
         offset += 40;
     }
     s->n_chunks += chunk_count;
     return 0;
-
-fail:
-    return ret;
 }
 
 static int dmg_read_resource_fork(BlockDriverState *bs, DmgHeaderState *ds,
-- 
2.6.2
