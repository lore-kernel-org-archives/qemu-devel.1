Received: from eggs.gnu.org ([2001:4830:134:3::10]:47213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1dUaGK-0001Ow-Kv
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1dUaGJ-0000QA-PK
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:06:12 -0400
From: "Denis V. Lunev" <den@openvz.org>
Date: Mon, 10 Jul 2017 18:05:59 +0300
Message-Id: <20170710150559.30163-1-den@openvz.org>
Subject: [Qemu-devel] [PATCH v2 1/1] block: fix shadowed variable in
 bdrv_co_pdiscard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

We've had a shadowed 'ret' variable, which risks returning the wrong
value, introduced in commit b9c64947.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Fam Zheng <famz@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Eric Blake <eblake@redhat.com>
---
 block/io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index 23170a57ee..87208990c4 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2327,7 +2327,6 @@ int coroutine_fn bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
     assert(max_pdiscard >= bs->bl.request_alignment);
 
     while (bytes > 0) {
-        int ret;
         int num = bytes;
 
         if (head) {
-- 
2.11.0
