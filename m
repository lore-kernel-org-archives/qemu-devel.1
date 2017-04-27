Received: from eggs.gnu.org ([2001:4830:134:3::10]:56520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d3eRZ-0003UG-NW
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:06:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d3eRX-0008UX-GN
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:06:29 -0400
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Thu, 27 Apr 2017 13:36:35 +0530
Message-Id: <1493280397-9622-6-git-send-email-ashijeetacharya@gmail.com>
In-Reply-To: <1493280397-9622-1-git-send-email-ashijeetacharya@gmail.com>
References: <1493280397-9622-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v2 5/7] dmg: Handle bz2 compressed/raw/zeroed
 chunks
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

We do not need to cache the access point for these chunks but need to
update our various supporting variables like chunk, sectors_read etc.
to keep maintaining our code structure. Call cache_access_point() after
reading chunks of these types.

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
---
 block/dmg.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/block/dmg.c b/block/dmg.c
index 073e864..f9045f9 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -680,20 +680,30 @@ update:
                                  (char *)s->uncompressed_chunk,
                                  (unsigned int)
                                     (512 * s->sectorcounts[chunk]));
+
         if (ret < 0) {
             return ret;
         }
+        cache_access_point(drs, NULL, -1, chunk, sectors_read,
+                           sector_offset);
         break;
     case 1: /* copy */
-        ret = bdrv_pread(bs->file, s->offsets[chunk],
-                         s->uncompressed_chunk, s->lengths[chunk]);
-        if (ret != s->lengths[chunk]) {
-            return -1;
+        if (drs->sectors_read == -1) {
+            ret = bdrv_pread(bs->file, s->offsets[chunk],
+                             s->uncompressed_chunk, s->lengths[chunk]);
+            if (ret != s->lengths[chunk]) {
+                return -1;
+            }
         }
+        cache_access_point(drs, NULL, -1, chunk, sectors_read,
+                           sector_offset);
         break;
     case 2: /* zero */
         /* see dmg_read, it is treated specially. No buffer needs to be
          * pre-filled, the zeroes can be set directly. */
+        cache_access_point(drs, NULL, -1, chunk, sectors_read,
+                           sector_offset);
+
         break;
     }
     s->current_chunk = chunk;
-- 
2.6.2
