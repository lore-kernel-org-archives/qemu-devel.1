Received: from eggs.gnu.org ([2001:4830:134:3::10]:53505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dehIv-0003WA-3E
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dehIp-0003In-VA
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:38:41 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Mon,  7 Aug 2017 08:38:20 -0400
Message-Id: <b750ff8d579d000c010c7465185801cfe8bb7a7d.1502109078.git.jcody@redhat.com>
In-Reply-To: <cover.1502109078.git.jcody@redhat.com>
References: <cover.1502109078.git.jcody@redhat.com>
In-Reply-To: <cover.1502109078.git.jcody@redhat.com>
References: <cover.1502109078.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.10 2/4] block/vhdx: check for offset
 overflow to bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, kwolf@redhat.com, eblake@redhat.com

VHDX uses uint64_t types for most offsets, following the VHDX spec.
However, bdrv_truncate() takes an int64_t value for the truncating
offset.  Check for overflow before calling bdrv_truncate().

While we are here, replace the bit shifting with QEMU_ALIGN_UP as well.

N.B.: For a compliant image this is not an issue, as the maximum VHDX
image size is defined per the spec to be 64TB.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/vhdx-log.c | 6 +++++-
 block/vhdx.c     | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index 2e26fd4..9597223 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -553,7 +553,11 @@ static int vhdx_log_flush(BlockDriverState *bs, BDRVVHDXState *s,
             new_file_size = desc_entries->hdr.last_file_offset;
             if (new_file_size % (1024*1024)) {
                 /* round up to nearest 1MB boundary */
-                new_file_size = ((new_file_size >> 20) + 1) << 20;
+                new_file_size = QEMU_ALIGN_UP(new_file_size, MiB);
+                if (new_file_size > INT64_MAX) {
+                    ret = -EINVAL;
+                    goto exit;
+                }
                 bdrv_truncate(bs->file, new_file_size, PREALLOC_MODE_OFF, NULL);
             }
         }
diff --git a/block/vhdx.c b/block/vhdx.c
index 37224b8..7ae4589 100644
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
