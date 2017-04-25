Received: from eggs.gnu.org ([2001:4830:134:3::10]:52555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d36c7-0006v6-Dh
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:59:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d36c6-0003yH-Kv
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:59:07 -0400
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Wed, 26 Apr 2017 01:29:06 +0530
Message-Id: <1493150351-28918-4-git-send-email-ashijeetacharya@gmail.com>
In-Reply-To: <1493150351-28918-1-git-send-email-ashijeetacharya@gmail.com>
References: <1493150351-28918-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v1 3/8] dmg: Limit the output buffer size to a
 max of 2MB
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

The size of the output buffer is limited to a maximum of 2MB so that
QEMU doesn't end up allocating huge amounts of memory while
decompressing compressed input streams.

2MB is an appropriate size because "qemu-img convert" has the same I/O
buffer size and the most important use case for DMG files is to be
compatible with qemu-img convert.

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
---
 block/dmg.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/dmg.c b/block/dmg.c
index c6fe8b0..7ae30e3 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -37,8 +37,8 @@ enum {
     /* Limit chunk sizes to prevent unreasonable amounts of memory being used
      * or truncating when converting to 32-bit types
      */
-    DMG_LENGTHS_MAX = 64 * 1024 * 1024, /* 64 MB */
-    DMG_SECTORCOUNTS_MAX = DMG_LENGTHS_MAX / 512,
+    DMG_MAX_OUTPUT = 2 * 1024 * 1024, /* 2 MB */
+    DMG_SECTOR_MAX = DMG_MAX_OUTPUT / 512,
 };
 
 static int dmg_probe(const uint8_t *buf, int buf_size, const char *filename)
@@ -260,10 +260,10 @@ static int dmg_read_mish_block(BDRVDMGState *s, DmgHeaderState *ds,
 
         /* all-zeroes sector (type 2) does not need to be "uncompressed" and can
          * therefore be unbounded. */
-        if (s->types[i] != 2 && s->sectorcounts[i] > DMG_SECTORCOUNTS_MAX) {
+        if (s->types[i] != 2 && s->sectorcounts[i] > DMG_SECTOR_MAX) {
             error_report("sector count %" PRIu64 " for chunk %" PRIu32
                          " is larger than max (%u)",
-                         s->sectorcounts[i], i, DMG_SECTORCOUNTS_MAX);
+                         s->sectorcounts[i], i, DMG_SECTOR_MAX);
             ret = -EINVAL;
             goto fail;
         }
@@ -275,10 +275,10 @@ static int dmg_read_mish_block(BDRVDMGState *s, DmgHeaderState *ds,
         /* length in (compressed) data fork */
         s->lengths[i] = buff_read_uint64(buffer, offset + 0x20);
 
-        if (s->lengths[i] > DMG_LENGTHS_MAX) {
+        if (s->lengths[i] > DMG_MAX_OUTPUT) {
             error_report("length %" PRIu64 " for chunk %" PRIu32
                          " is larger than max (%u)",
-                         s->lengths[i], i, DMG_LENGTHS_MAX);
+                         s->lengths[i], i, DMG_MAX_OUTPUT);
             ret = -EINVAL;
             goto fail;
         }
-- 
2.6.2
