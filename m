Received: from eggs.gnu.org ([2001:4830:134:3::10]:36871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eDESO-0000m5-SA
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 13:55:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eDESK-0001sw-V6
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 13:55:12 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 10 Nov 2017 20:54:46 +0200
Message-Id: <0d3a67ce8d948bb33e08672564714dcfb76a3d8c.1510339534.git.berto@igalia.com>
In-Reply-To: <cover.1510339534.git.berto@igalia.com>
References: <cover.1510339534.git.berto@igalia.com>
In-Reply-To: <cover.1510339534.git.berto@igalia.com>
References: <cover.1510339534.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 1/3] block: Check for inserted BlockDriverState
 in blk_io_limits_disable()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, sochin jiang <sochin.jiang@huawei.com>

When you set I/O limits using block_set_io_throttle or the command
line throttling.* options they are kept in the BlockBackend regardless
of whether a BlockDriverState is attached to the backend or not.

Therefore when removing the limits using blk_io_limits_disable() we
need to check if there's a BDS before attempting to drain it, else it
will crash QEMU. This can be reproduced very easily using HMP:

     (qemu) drive_add 0 if=none,throttling.iops-total=5000
     (qemu) drive_del none0

Reported-by: sochin jiang <sochin.jiang@huawei.com>
Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/block-backend.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 18e543780d..193a080096 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1978,10 +1978,16 @@ void blk_set_io_limits(BlockBackend *blk, ThrottleConfig *cfg)
 
 void blk_io_limits_disable(BlockBackend *blk)
 {
-    assert(blk->public.throttle_group_member.throttle_state);
-    bdrv_drained_begin(blk_bs(blk));
-    throttle_group_unregister_tgm(&blk->public.throttle_group_member);
-    bdrv_drained_end(blk_bs(blk));
+    BlockDriverState *bs = blk_bs(blk);
+    ThrottleGroupMember *tgm = &blk->public.throttle_group_member;
+    assert(tgm->throttle_state);
+    if (bs) {
+        bdrv_drained_begin(bs);
+    }
+    throttle_group_unregister_tgm(tgm);
+    if (bs) {
+        bdrv_drained_end(bs);
+    }
 }
 
 /* should be called before blk_set_io_limits if a limit is set */
-- 
2.11.0
