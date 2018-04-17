Received: from eggs.gnu.org ([2001:4830:134:3::10]:53471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8SiD-0001Q8-7r
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:40:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8Si7-0005JU-La
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:40:05 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Apr 2018 17:39:43 +0200
Message-Id: <20180417153945.20737-5-pbonzini@redhat.com>
In-Reply-To: <20180417153945.20737-1-pbonzini@redhat.com>
References: <20180417153945.20737-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 4/6] ide: make ide_transfer_stop idempotent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org

There is code checking s->end_transfer_func and it was not taught about
ide_transfer_cancel.  We can just use ide_transfer_stop because
s->end_transfer_func is only ever called in the DRQ phase.

ide_transfer_cancel can then be removed, since it would just be
calling ide_transfer_halt.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ide/core.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index edda171b47..bc3648eb13 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -548,10 +548,9 @@ static void ide_cmd_done(IDEState *s)
     }
 }
 
-static void ide_transfer_halt(IDEState *s,
-                              void(*end_transfer_func)(IDEState *))
+static void ide_transfer_halt(IDEState *s)
 {
-    s->end_transfer_func = end_transfer_func;
+    s->end_transfer_func = ide_transfer_stop;
     s->data_ptr = s->io_buffer;
     s->data_end = s->io_buffer;
     s->status &= ~DRQ_STAT;
@@ -559,15 +558,10 @@ static void ide_transfer_halt(IDEState *s,
 
 void ide_transfer_stop(IDEState *s)
 {
-    ide_transfer_halt(s, ide_transfer_stop);
+    ide_transfer_halt(s);
     ide_cmd_done(s);
 }
 
-static void ide_transfer_cancel(IDEState *s)
-{
-    ide_transfer_halt(s, ide_transfer_cancel);
-}
-
 int64_t ide_get_sector(IDEState *s)
 {
     int64_t sector_num;
@@ -1362,7 +1356,7 @@ static bool cmd_nop(IDEState *s, uint8_t cmd)
 static bool cmd_device_reset(IDEState *s, uint8_t cmd)
 {
     /* Halt PIO (in the DRQ phase), then DMA */
-    ide_transfer_cancel(s);
+    ide_transfer_halt(s);
     ide_cancel_dma_sync(s);
 
     /* Reset any PIO commands, reset signature, etc */
-- 
2.17.0
