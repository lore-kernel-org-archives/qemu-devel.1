Received: from eggs.gnu.org ([2001:4830:134:3::10]:45259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcHg-0002z8-Kl
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:43:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcHf-000374-MW
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:43:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUcHf-00036v-GR
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:43:27 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9680B80469
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 16:43:27 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jan 2017 17:43:07 +0100
Message-Id: <20170120164322.21851-3-pbonzini@redhat.com>
In-Reply-To: <20170120164322.21851-1-pbonzini@redhat.com>
References: <20170120164322.21851-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 02/17] block-backend: allow blk_prw from
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
Cc: stefanha@redhat.com, famz@redhat.com

qcow2_create2 calls this.  Do not run a nested event loop, as that
breaks when aio_co_wake tries to queue the coroutine on the co_queue_wakeup
list of the currently running one.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
