Received: from eggs.gnu.org ([2001:4830:134:3::10]:44627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcuno-0005Oc-8V
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunn-0001ms-Ev
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:44 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 10 Jul 2018 17:43:03 +0200
Message-Id: <20180710154304.18304-24-kwolf@redhat.com>
In-Reply-To: <20180710154304.18304-1-kwolf@redhat.com>
References: <20180710154304.18304-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 23/24] block: Fix bdrv_co_truncate overlap check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

If we are growing the image and potentially using preallocation for the
new area, we need to make sure that no write requests are made to the
"preallocated" area which is [@old_size, @offset), not
[@offset, offset * 2 - @old_size).

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index 2832214db4..77d38ca1d3 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3136,7 +3136,8 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
     }
 
     bdrv_inc_in_flight(bs);
-    tracked_request_begin(&req, bs, offset, new_bytes, BDRV_TRACKED_TRUNCATE);
+    tracked_request_begin(&req, bs, offset - new_bytes, new_bytes,
+                          BDRV_TRACKED_TRUNCATE);
 
     /* If we are growing the image and potentially using preallocation for the
      * new area, we need to make sure that no write requests are made to it
-- 
2.13.6
