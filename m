Received: from eggs.gnu.org ([2001:4830:134:3::10]:53471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fayq9-0001uj-H2
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 03:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fayq6-0002AD-CL
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 03:38:09 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu,  5 Jul 2018 15:37:00 +0800
Message-Id: <20180705073701.10558-9-famz@redhat.com>
In-Reply-To: <20180705073701.10558-1-famz@redhat.com>
References: <20180705073701.10558-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 8/9] block: Fix bdrv_co_truncate overlap
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

If we are growing the image and potentially using preallocation for the
new area, we need to make sure that no write requests are made to the
"preallocated" area which [@old_size, @offset), not [@offset, offset * 2
- @old_size).

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index d07849fa96..ed18eb0ca3 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3070,7 +3070,8 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
     }
 
     bdrv_inc_in_flight(bs);
-    tracked_request_begin(&req, bs, offset, new_bytes, BDRV_TRACKED_TRUNCATE);
+    tracked_request_begin(&req, bs, offset - new_bytes, new_bytes,
+                          BDRV_TRACKED_TRUNCATE);
 
     /* If we are growing the image and potentially using preallocation for the
      * new area, we need to make sure that no write requests are made to it
-- 
2.17.1
