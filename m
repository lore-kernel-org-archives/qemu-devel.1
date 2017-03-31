Received: from eggs.gnu.org ([2001:4830:134:3::10]:41715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ctwMV-00040W-Ct
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ctwMU-0001sz-JA
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:13:07 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Mar 2017 14:13:00 +0100
Message-Id: <1490965980-513-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] block/parallels.c: avoid integer overflow in
 allocate_clusters()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Coverity (CID 1307776) points out that in the multiply:
  space = to_allocate * s->tracks;
we are trying to calculate a 64 bit result but the types
of to_allocate and s->tracks mean that we actually calculate
a 32 bit result. Add an explicit cast to force a 64 bit
multiply.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
NB: compile-and-make-check tested only...
---
 block/parallels.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/parallels.c b/block/parallels.c
index 4173b3f..3886c30 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -206,7 +206,7 @@ static int64_t allocate_clusters(BlockDriverState *bs, int64_t sector_num,
     }
 
     to_allocate = DIV_ROUND_UP(sector_num + *pnum, s->tracks) - idx;
-    space = to_allocate * s->tracks;
+    space = (int64_t)to_allocate * s->tracks;
     if (s->data_end + space > bdrv_getlength(bs->file->bs) >> BDRV_SECTOR_BITS) {
         int ret;
         space += s->prealloc_size;
-- 
2.7.4
