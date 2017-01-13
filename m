Received: from eggs.gnu.org ([2001:4830:134:3::10]:41007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cS1je-0007Tr-Kh
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cS1jc-0002SF-3s
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:38 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cS1jb-0002RZ-TX
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:36 -0500
Received: by mail-wm0-x244.google.com with SMTP id r126so11632497wmr.3
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 05:17:35 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 13 Jan 2017 14:17:17 +0100
Message-Id: <20170113131731.1246-3-pbonzini@redhat.com>
In-Reply-To: <20170113131731.1246-1-pbonzini@redhat.com>
References: <20170113131731.1246-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 02/16] block-backend: allow blk_prw from
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
Cc: famz@redhat.com, stefanha@redhat.com

qcow2_create2 calls this.  Do not run a nested event loop, as that
breaks when aio_co_wake tries to queue the coroutine on the co_queue_wakeup
list of the currently running one.

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
