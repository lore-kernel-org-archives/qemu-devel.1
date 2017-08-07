Received: from eggs.gnu.org ([2001:4830:134:3::10]:58944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1deYP9-0003h3-4o
	for qemu-devel@nongnu.org; Sun, 06 Aug 2017 23:08:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1deYP8-0005q2-0Y
	for qemu-devel@nongnu.org; Sun, 06 Aug 2017 23:08:31 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Sun,  6 Aug 2017 23:08:20 -0400
Message-Id: <403586fbd705655c9e861b9e57648b598b651896.1502075213.git.jcody@redhat.com>
In-Reply-To: <cover.1502075213.git.jcody@redhat.com>
References: <cover.1502075213.git.jcody@redhat.com>
In-Reply-To: <cover.1502075213.git.jcody@redhat.com>
References: <cover.1502075213.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] block/vhdx: check for offset overflow to
 bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com

VHDX uses uint64_t types for most offsets, following the VHDX spec.
However, bdrv_truncate() takes an int64_t value for the truncating
offset.  Check for overflow before calling bdrv_truncate().

N.B.: For a compliant image this is not an issue, as the maximum VHDX
image size is defined per the spec to be 64TB.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/vhdx-log.c | 4 ++++
 block/vhdx.c     | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index fd4e7af..3b74e5d 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -554,6 +554,10 @@ static int vhdx_log_flush(BlockDriverState *bs, BDRVVHDXState *s,
             if (new_file_size % (1024*1024)) {
                 /* round up to nearest 1MB boundary */
                 new_file_size = ((new_file_size >> 20) + 1) << 20;
+                if (new_file_size > INT64_MAX) {
+                    ret = -EINVAL;
+                    goto exit;
+                }
                 bdrv_truncate(bs->file, new_file_size, PREALLOC_MODE_OFF, NULL);
             }
         }
diff --git a/block/vhdx.c b/block/vhdx.c
index 6a14999..c45af73 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1177,6 +1177,9 @@ static int vhdx_allocate_block(BlockDriverState *bs, BDRVVHDXState *s,
 
     /* per the spec, the address for a block is in units of 1MB */
     *new_offset = ROUND_UP(*new_offset, 1024 * 1024);
+    if (*new_offset > INT64_MAX) {
+        return -EINVAL;
+    }
 
     return bdrv_truncate(bs->file, *new_offset + s->block_size,
                          PREALLOC_MODE_OFF, NULL);
-- 
2.9.4
