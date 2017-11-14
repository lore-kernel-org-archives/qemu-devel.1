Received: from eggs.gnu.org ([2001:4830:134:3::10]:56120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEg9R-0003wg-JP
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 13:41:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEg9Q-0000x3-Gq
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 13:41:37 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 14 Nov 2017 19:41:27 +0100
Message-Id: <20171114184127.24238-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11] qcow2: Fix overly broad madvise()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

@mem_size and @offset are both size_t, thus subtracting them from one
another will just return a big size_t if mem_size < offset -- even more
obvious here because the result is stored in another size_t.

Checking that result to be positive is therefore not sufficient to
excluse the case that offset > mem_size.  Thus, we currently sometimes
issue an madvise() over a very large address range.

This is triggered by iotest 163, but with -m64, this does not result in
tangible problems.  But with -m32, this test produces three segfaults,
all of which are fixed by this patch.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 75746a7f43..5222a7b94d 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -73,7 +73,7 @@ static void qcow2_cache_table_release(BlockDriverState *bs, Qcow2Cache *c,
     size_t mem_size = (size_t) s->cluster_size * num_tables;
     size_t offset = QEMU_ALIGN_UP((uintptr_t) t, align) - (uintptr_t) t;
     size_t length = QEMU_ALIGN_DOWN(mem_size - offset, align);
-    if (length > 0) {
+    if (mem_size > offset && length > 0) {
         madvise((uint8_t *) t + offset, length, MADV_DONTNEED);
     }
 #endif
-- 
2.13.6
