Received: from eggs.gnu.org ([2001:4830:134:3::10]:39765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1cedYY-00056B-Hg
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:06:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1cedYX-0004dK-HN
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:06:18 -0500
From: Pankaj Gupta <pagupta@redhat.com>
Date: Fri, 17 Feb 2017 13:36:04 +0530
Message-Id: <1487318764-29513-1-git-send-email-pagupta@redhat.com>
Subject: [Qemu-devel] [PATCH] block,
 migration: Use qemu_madvise inplace of madvise
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, quintela@redhat.com, dgilbert@redhat.com

 To maintain consistency at all the places use qemu_madvise wrapper
 inplace of madvise call.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 block/qcow2-cache.c      | 2 +-
 migration/postcopy-ram.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 1d25147..4991ca5 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -74,7 +74,7 @@ static void qcow2_cache_table_release(BlockDriverState *bs, Qcow2Cache *c,
     size_t offset = QEMU_ALIGN_UP((uintptr_t) t, align) - (uintptr_t) t;
     size_t length = QEMU_ALIGN_DOWN(mem_size - offset, align);
     if (length > 0) {
-        madvise((uint8_t *) t + offset, length, MADV_DONTNEED);
+        qemu_madvise((uint8_t *) t + offset, length, QEMU_MADV_DONTNEED);
     }
 #endif
 }
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index a40dddb..558fec1 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -213,7 +213,7 @@ int postcopy_ram_discard_range(MigrationIncomingState *mis, uint8_t *start,
                                size_t length)
 {
     trace_postcopy_ram_discard_range(start, length);
-    if (madvise(start, length, MADV_DONTNEED)) {
+    if (qemu_madvise(start, length, QEMU_MADV_DONTNEED)) {
         error_report("%s MADV_DONTNEED: %s", __func__, strerror(errno));
         return -1;
     }
-- 
2.7.4
