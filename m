Received: from eggs.gnu.org ([2001:4830:134:3::10]:49905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cRcyq-0005GH-CF
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:51:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cRcyn-0001ra-Au
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:51:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cRcyn-0001rQ-5A
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:51:37 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 12 Jan 2017 11:51:32 +0100
Message-Id: <20170112105132.10394-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] ide: avoid unbounded recursion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Lieven <pl@kamp.de>, John Snow <jsnow@redhat.com>

The end_transfer_func can call ide_transfer_start immediately, before
returning, and unbounded recursion can happen at least for
ide_atapi_cmd_reply_end.  Use a bottom half to defer the call and
limit stack usage.

Cc: Peter Lieven <pl@kamp.de>
Cc: John Snow <jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ide/core.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 43709e5..7b9831f 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -482,6 +482,13 @@ static void ide_clear_retry(IDEState *s)
     s->bus->retry_nsector = 0;
 }
 
+static void ide_start_transfer_bh_cb(void *opaque)
+{
+    IDEDMA *dma = opaque;
+
+    dma->ops->start_transfer(dma);
+}
+
 /* prepare data transfer and tell what to do after */
 void ide_transfer_start(IDEState *s, uint8_t *buf, int size,
                         EndTransferFunc *end_transfer_func)
@@ -494,7 +501,12 @@ void ide_transfer_start(IDEState *s, uint8_t *buf, int size,
         s->status |= DRQ_STAT;
     }
     if (s->bus->dma->ops->start_transfer) {
-        s->bus->dma->ops->start_transfer(s->bus->dma);
+        /* There can be unbounded recursion between ops->start_transfer
+         * and end_transfer_func, so defer to a bottom half.
+         */
+        aio_bh_schedule_oneshot(qemu_get_aio_context(),
+                                ide_start_transfer_bh_cb,
+                                s->bus->dma);
     }
 }
 
-- 
2.9.3
