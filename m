Received: from eggs.gnu.org ([2001:4830:134:3::10]:52677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0mAK-0004Lp-V1
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0mAK-0005al-7O
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:44:48 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 19 Apr 2017 17:43:48 +0800
Message-Id: <20170419094356.19826-9-famz@redhat.com>
In-Reply-To: <20170419094356.19826-1-famz@redhat.com>
References: <20170419094356.19826-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/16] mirror: Request aio context change
 permission on target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

What's done in the source's context change notifier is moving the
target's context to follow the new one, so we request this permission
here.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/mirror.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/mirror.c b/block/mirror.c
index 7ab3289..fe2fb7a 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1189,6 +1189,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     target_is_backing = bdrv_chain_contains(bs, target);
     target_graph_mod = (backing_mode != MIRROR_LEAVE_BACKING_CHAIN);
     s->target = blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE |
+                        BLK_PERM_AIO_CONTEXT_CHANGE |
                         (target_graph_mod ? BLK_PERM_GRAPH_MOD : 0),
                         BLK_PERM_WRITE_UNCHANGED |
                         (target_is_backing ? BLK_PERM_CONSISTENT_READ |
-- 
2.9.3
