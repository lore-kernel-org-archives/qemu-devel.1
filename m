Received: from eggs.gnu.org ([2001:4830:134:3::10]:60513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eEYbD-0002T1-5H
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:37:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eEYbC-0004P6-AM
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:37:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eEYbC-0004Oc-47
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:37:46 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 14 Nov 2017 10:37:19 +0000
Message-Id: <20171114103721.13869-4-stefanha@redhat.com>
In-Reply-To: <20171114103721.13869-1-stefanha@redhat.com>
References: <20171114103721.13869-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.11-rc2 3/5] block: Check for inserted
 BlockDriverState in blk_io_limits_disable()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Alberto Garcia <berto@igalia.com>

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
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 0d3a67ce8d948bb33e08672564714dcfb76a3d8c.1510339534.git.berto@igalia.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/block-backend.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index ab75da32c9..df92a6280d 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1980,10 +1980,16 @@ void blk_set_io_limits(BlockBackend *blk, ThrottleConfig *cfg)
 
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
2.13.6
