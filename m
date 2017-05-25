Received: from eggs.gnu.org ([2001:4830:134:3::10]:33064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dDufA-0004qJ-KE
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:26:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dDuf5-0002fj-IU
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:26:56 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:3242 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dDuf5-0002fA-6w
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:26:51 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 25 May 2017 18:26:26 +0300
Message-Id: <20170525152628.37628-6-vsementsov@virtuozzo.com>
In-Reply-To: <20170525152628.37628-1-vsementsov@virtuozzo.com>
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 5/7] qemu-img check: add format unallocated size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Shows format 'sparseness' of the image top level.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json |  3 ++-
 qemu-img.c           | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ea0b3e8b13..c7ed5dc970 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -185,7 +185,8 @@
            '*image-end-offset': 'int', '*corruptions': 'int', '*leaks': 'int',
            '*corruptions-fixed': 'int', '*leaks-fixed': 'int',
            '*total-clusters': 'int', '*allocated-clusters': 'int',
-           '*fragmented-clusters': 'int', '*compressed-clusters': 'int' } }
+           '*fragmented-clusters': 'int', '*compressed-clusters': 'int',
+           '*format-unallocated-size': 'uint64'} }
 
 ##
 # @MapEntry:
diff --git a/qemu-img.c b/qemu-img.c
index b506839ef0..cbd09148d2 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -601,6 +601,13 @@ static void dump_human_image_check(ImageCheck *check, bool quiet)
         qprintf(quiet,
                 "Image end offset: %" PRId64 "\n", check->image_end_offset);
     }
+
+    if (check->has_format_unallocated_size) {
+        char u_buf[128];
+        qprintf(quiet, "Format unallocated size: %s\n",
+                get_human_readable_size(u_buf, sizeof(u_buf),
+                                        check->format_unallocated_size));
+    }
 }
 
 static int collect_image_check(BlockDriverState *bs,
@@ -639,6 +646,18 @@ static int collect_image_check(BlockDriverState *bs,
     check->compressed_clusters      = result.bfi.compressed_clusters;
     check->has_compressed_clusters  = result.bfi.compressed_clusters != 0;
 
+    if (bs->file) {
+        int64_t file_size = bdrv_getlength(bs->file->bs);
+        if (file_size >= 0) {
+            int64_t format_allocated_size = bdrv_get_format_allocated_size(bs);
+            if (format_allocated_size >= 0) {
+                check->format_unallocated_size =
+                    file_size - format_allocated_size;
+                check->has_format_unallocated_size = true;
+            }
+        }
+    }
+
     return 0;
 }
 
-- 
2.11.1
