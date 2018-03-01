Received: from eggs.gnu.org ([2001:4830:134:3::10]:45910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erRCG-0006h3-VC
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:36:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erRCE-0002tv-ME
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:36:44 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Mar 2018 17:36:15 +0100
Message-Id: <20180301163619.21072-5-pbonzini@redhat.com>
In-Reply-To: <20180301163619.21072-1-pbonzini@redhat.com>
References: <20180301163619.21072-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 4/8] qcow2: fix flushing after dirty bitmap
 metadata writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

update_header_sync itself does not need to flush the caches to disk.
The only paths that allocate clusters are:

- bitmap_list_store with in_place=false, called by update_ext_header_and_dir

- store_bitmap_data, called by store_bitmap

- store_bitmap, called by qcow2_store_persistent_dirty_bitmaps and
  followed by update_ext_header_and_dir

So in the end the central place where we need to flush the caches
is update_ext_header_and_dir.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/qcow2-bitmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index efa10c6663..a2dbd9fab4 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -110,7 +110,7 @@ static int update_header_sync(BlockDriverState *bs)
         return ret;
     }
 
-    return bdrv_flush(bs);
+    return bdrv_flush(bs->file->bs);
 }
 
 static inline void bitmap_table_to_be(uint64_t *bitmap_table, size_t size)
@@ -882,7 +882,7 @@ static int update_ext_header_and_dir(BlockDriverState *bs,
             return ret;
         }
 
-        ret = bdrv_flush(bs->file->bs);
+        ret = qcow2_flush_caches(bs);
         if (ret < 0) {
             goto fail;
         }
-- 
2.14.3
