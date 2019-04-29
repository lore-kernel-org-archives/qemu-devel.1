Received: from eggs.gnu.org ([209.51.188.92]:56769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLBF2-0003Hh-6G
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:43:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLBF1-0002R2-68
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:43:03 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Mon, 29 Apr 2019 20:42:36 +0200
Message-Id: <74e443f4cd78fb5afa8d184af5be19de3691af38.1556562150.git.berto@igalia.com>
In-Reply-To: <cover.1556562150.git.berto@igalia.com>
References: <cover.1556562150.git.berto@igalia.com>
In-Reply-To: <cover.1556562150.git.berto@igalia.com>
References: <cover.1556562150.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 1/5] qcow2: Replace bdrv_write() with
 bdrv_pwrite()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

There's only one bdrv_write() call left in the qcow2 code, and it can
be trivially replaced with the byte-based bdrv_pwrite().

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-refcount.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index e0fe322500..83f66eed7a 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -2409,8 +2409,8 @@ write_refblocks:
         on_disk_refblock = (void *)((char *) *refcount_table +
                                     refblock_index * s->cluster_size);
 
-        ret = bdrv_write(bs->file, refblock_offset / BDRV_SECTOR_SIZE,
-                         on_disk_refblock, s->cluster_sectors);
+        ret = bdrv_pwrite(bs->file, refblock_offset, on_disk_refblock,
+                          s->cluster_size);
         if (ret < 0) {
             fprintf(stderr, "ERROR writing refblock: %s\n", strerror(-ret));
             goto fail;
-- 
2.11.0
