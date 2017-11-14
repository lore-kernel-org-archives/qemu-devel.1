Received: from eggs.gnu.org ([2001:4830:134:3::10]:60440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eEYb8-0002Rj-0H
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:37:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eEYb4-0004Jb-Tb
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:37:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eEYb4-0004IQ-NE
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:37:38 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 14 Nov 2017 10:37:17 +0000
Message-Id: <20171114103721.13869-2-stefanha@redhat.com>
In-Reply-To: <20171114103721.13869-1-stefanha@redhat.com>
References: <20171114103721.13869-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.11-rc2 1/5] block: all I/O should be
 completed before removing throttle timers.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhengui <lizhengui@huawei.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Zhengui <lizhengui@huawei.com>

In blk_remove_bs, all I/O should be completed before removing throttle
timers. If there has inflight I/O, removing throttle timers here will
cause the inflight I/O never return.
This patch add bdrv_drained_begin before throttle_timers_detach_aio_context
to let all I/O completed before removing throttle timers.

[Moved declaration of bs as suggested by Alberto Garcia
<berto@igalia.com>.
--Stefan]

Signed-off-by: Zhengui <lizhengui@huawei.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-id: 1508564040-120700-1-git-send-email-lizhengui@huawei.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/block-backend.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 45d9101be3..18e543780d 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -655,12 +655,16 @@ BlockBackend *blk_by_public(BlockBackendPublic *public)
  */
 void blk_remove_bs(BlockBackend *blk)
 {
+    BlockDriverState *bs;
     ThrottleTimers *tt;
 
     notifier_list_notify(&blk->remove_bs_notifiers, blk);
     if (blk->public.throttle_group_member.throttle_state) {
         tt = &blk->public.throttle_group_member.throttle_timers;
+        bs = blk_bs(blk);
+        bdrv_drained_begin(bs);
         throttle_timers_detach_aio_context(tt);
+        bdrv_drained_end(bs);
     }
 
     blk_update_root_state(blk);
-- 
2.13.6
