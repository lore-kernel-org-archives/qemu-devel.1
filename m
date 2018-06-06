Received: from eggs.gnu.org ([2001:4830:134:3::10]:38383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fQdop-0000hQ-25
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:10:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fQdon-0000kT-M7
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:10:02 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed,  6 Jun 2018 15:09:55 -0400
Message-Id: <20180606190955.20845-8-jsnow@redhat.com>
In-Reply-To: <20180606190955.20845-1-jsnow@redhat.com>
References: <20180606190955.20845-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 7/7] ide: introduce ide_transfer_start_norecurse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

For the case where the end_transfer_func is also the caller of
ide_transfer_start, the mutual recursion can lead to unlimited
stack usage.  Introduce a new version that can be used to change
tail recursion into a loop, and use it in trace_ide_atapi_cmd_reply_end.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/atapi.c            | 42 +++++++++++++++++++++++-------------------
 hw/ide/core.c             | 16 ++++++++++++----
 include/hw/ide/internal.h |  2 ++
 3 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index 7168ff55a7..39e473f9c2 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -245,15 +245,11 @@ static uint16_t atapi_byte_count_limit(IDEState *s)
 void ide_atapi_cmd_reply_end(IDEState *s)
 {
     int byte_count_limit, size, ret;
-    trace_ide_atapi_cmd_reply_end(s, s->packet_transfer_size,
-                                  s->elementary_transfer_size,
-                                  s->io_buffer_index);
-    if (s->packet_transfer_size <= 0) {
-        /* end of transfer */
-        ide_atapi_cmd_ok(s);
-        ide_set_irq(s->bus);
-        trace_ide_atapi_cmd_reply_end_eot(s, s->status);
-    } else {
+    while (s->packet_transfer_size > 0) {
+        trace_ide_atapi_cmd_reply_end(s, s->packet_transfer_size,
+                                      s->elementary_transfer_size,
+                                      s->io_buffer_index);
+
         /* see if a new sector must be read */
         if (s->lba != -1 && s->io_buffer_index >= s->cd_sector_size) {
             if (!s->elementary_transfer_size) {
@@ -279,11 +275,6 @@ void ide_atapi_cmd_reply_end(IDEState *s)
             size = s->cd_sector_size - s->io_buffer_index;
             if (size > s->elementary_transfer_size)
                 size = s->elementary_transfer_size;
-            s->packet_transfer_size -= size;
-            s->elementary_transfer_size -= size;
-            s->io_buffer_index += size;
-            ide_transfer_start(s, s->io_buffer + s->io_buffer_index - size,
-                               size, ide_atapi_cmd_reply_end);
         } else {
             /* a new transfer is needed */
             s->nsector = (s->nsector & ~7) | ATAPI_INT_REASON_IO;
@@ -306,13 +297,26 @@ void ide_atapi_cmd_reply_end(IDEState *s)
                     size = (s->cd_sector_size - s->io_buffer_index);
             }
             trace_ide_atapi_cmd_reply_end_new(s, s->status);
-            s->packet_transfer_size -= size;
-            s->elementary_transfer_size -= size;
-            s->io_buffer_index += size;
-            ide_transfer_start(s, s->io_buffer + s->io_buffer_index - size,
-                               size, ide_atapi_cmd_reply_end);
+        }
+        s->packet_transfer_size -= size;
+        s->elementary_transfer_size -= size;
+        s->io_buffer_index += size;
+
+        /* Some adapters process PIO data right away.  In that case, we need
+         * to avoid mutual recursion between ide_transfer_start
+         * and ide_atapi_cmd_reply_end.
+         */
+        if (!ide_transfer_start_norecurse(s,
+                                          s->io_buffer + s->io_buffer_index - size,
+                                          size, ide_atapi_cmd_reply_end)) {
+            return;
         }
     }
+
+    /* end of transfer */
+    trace_ide_atapi_cmd_reply_end_eot(s, s->status);
+    ide_atapi_cmd_ok(s);
+    ide_set_irq(s->bus);
 }
 
 /* send a reply of 'size' bytes in s->io_buffer to an ATAPI command */
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 9c4864ae54..2c62efc536 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -523,8 +523,8 @@ static void ide_clear_retry(IDEState *s)
 }
 
 /* prepare data transfer and tell what to do after */
-void ide_transfer_start(IDEState *s, uint8_t *buf, int size,
-                        EndTransferFunc *end_transfer_func)
+bool ide_transfer_start_norecurse(IDEState *s, uint8_t *buf, int size,
+                                  EndTransferFunc *end_transfer_func)
 {
     s->data_ptr = buf;
     s->data_end = buf + size;
@@ -534,10 +534,18 @@ void ide_transfer_start(IDEState *s, uint8_t *buf, int size,
     }
     if (!s->bus->dma->ops->pio_transfer) {
         s->end_transfer_func = end_transfer_func;
-        return;
+        return false;
     }
     s->bus->dma->ops->pio_transfer(s->bus->dma);
-    end_transfer_func(s);
+    return true;
+}
+
+void ide_transfer_start(IDEState *s, uint8_t *buf, int size,
+                        EndTransferFunc *end_transfer_func)
+{
+    if (ide_transfer_start_norecurse(s, buf, size, end_transfer_func)) {
+        end_transfer_func(s);
+    }
 }
 
 static void ide_cmd_done(IDEState *s)
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index f3de6f9b73..594081e57f 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -623,6 +623,8 @@ void ide_exec_cmd(IDEBus *bus, uint32_t val);
 
 void ide_transfer_start(IDEState *s, uint8_t *buf, int size,
                         EndTransferFunc *end_transfer_func);
+bool ide_transfer_start_norecurse(IDEState *s, uint8_t *buf, int size,
+                                  EndTransferFunc *end_transfer_func);
 void ide_transfer_stop(IDEState *s);
 void ide_set_inactive(IDEState *s, bool more);
 BlockAIOCB *ide_issue_trim(
-- 
2.14.3
