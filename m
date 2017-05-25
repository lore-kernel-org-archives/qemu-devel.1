Received: from eggs.gnu.org ([2001:4830:134:3::10]:33063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dDufA-0004qI-KK
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:26:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dDuf5-0002fw-Ik
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:26:56 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:47130 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dDuf5-0002fD-6z
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:26:51 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 25 May 2017 18:26:27 +0300
Message-Id: <20170525152628.37628-7-vsementsov@virtuozzo.com>
In-Reply-To: <20170525152628.37628-1-vsementsov@virtuozzo.com>
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 6/7] qemu-img check: add file-size
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

Add bdrv_getlength() of underlying bs->file->bs, to improve
'Format unallocated size' section of qemu-img check output.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json |  2 +-
 qemu-img.c           | 11 ++++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index c7ed5dc970..f720a29512 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -186,7 +186,7 @@
            '*corruptions-fixed': 'int', '*leaks-fixed': 'int',
            '*total-clusters': 'int', '*allocated-clusters': 'int',
            '*fragmented-clusters': 'int', '*compressed-clusters': 'int',
-           '*format-unallocated-size': 'uint64'} }
+           '*format-unallocated-size': 'uint64', '*file-size': 'uint64'} }
 
 ##
 # @MapEntry:
diff --git a/qemu-img.c b/qemu-img.c
index cbd09148d2..08a2b5ba54 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -603,10 +603,13 @@ static void dump_human_image_check(ImageCheck *check, bool quiet)
     }
 
     if (check->has_format_unallocated_size) {
-        char u_buf[128];
-        qprintf(quiet, "Format unallocated size: %s\n",
+        char buf[128], u_buf[128];
+        assert(check->has_file_size);
+        qprintf(quiet, "Format unallocated size: %s/%s = %0.2f%%\n",
                 get_human_readable_size(u_buf, sizeof(u_buf),
-                                        check->format_unallocated_size));
+                                        check->format_unallocated_size),
+                get_human_readable_size(buf, sizeof(buf), check->file_size),
+                check->format_unallocated_size * 100.0 / check->file_size);
     }
 }
 
@@ -650,6 +653,8 @@ static int collect_image_check(BlockDriverState *bs,
         int64_t file_size = bdrv_getlength(bs->file->bs);
         if (file_size >= 0) {
             int64_t format_allocated_size = bdrv_get_format_allocated_size(bs);
+            check->file_size = file_size;
+            check->has_file_size = true;
             if (format_allocated_size >= 0) {
                 check->format_unallocated_size =
                     file_size - format_allocated_size;
-- 
2.11.1
