Received: from eggs.gnu.org ([2001:4830:134:3::10]:59822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cfkLT-0006cl-VF
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:33:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cfkLT-000792-Ae
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:33:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cfkLT-00078e-5v
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:33:23 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 20 Feb 2017 09:32:43 +0000
Message-Id: <20170220093304.20515-4-stefanha@redhat.com>
In-Reply-To: <20170220093304.20515-1-stefanha@redhat.com>
References: <20170220093304.20515-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 03/24] block-backend: allow blk_prw from
 coroutine context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

qcow2_create2 calls this.  Do not run a nested event loop, as that
breaks when aio_co_wake tries to queue the coroutine on the co_queue_wakeup
list of the currently running one.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20170213135235.12274-4-pbonzini@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/block-backend.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index efbf398..1177598 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -880,7 +880,6 @@ static int blk_prw(BlockBackend *blk, int64_t offset, uint8_t *buf,
 {
     QEMUIOVector qiov;
     struct iovec iov;
-    Coroutine *co;
     BlkRwCo rwco;
 
     iov = (struct iovec) {
@@ -897,9 +896,14 @@ static int blk_prw(BlockBackend *blk, int64_t offset, uint8_t *buf,
         .ret    = NOT_DONE,
     };
 
-    co = qemu_coroutine_create(co_entry, &rwco);
-    qemu_coroutine_enter(co);
-    BDRV_POLL_WHILE(blk_bs(blk), rwco.ret == NOT_DONE);
+    if (qemu_in_coroutine()) {
+        /* Fast-path if already in coroutine context */
+        co_entry(&rwco);
+    } else {
+        Coroutine *co = qemu_coroutine_create(co_entry, &rwco);
+        qemu_coroutine_enter(co);
+        BDRV_POLL_WHILE(blk_bs(blk), rwco.ret == NOT_DONE);
+    }
 
     return rwco.ret;
 }
-- 
2.9.3
