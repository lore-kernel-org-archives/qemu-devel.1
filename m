Received: from eggs.gnu.org ([2001:4830:134:3::10]:40981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1duqAa-0008BW-F1
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 21:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1duqAZ-00073h-2q
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 21:20:48 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed, 20 Sep 2017 21:20:37 -0400
Message-Id: <20170921012037.553-3-jsnow@redhat.com>
In-Reply-To: <20170921012037.553-1-jsnow@redhat.com>
References: <20170921012037.553-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] ide: generic ide_data_write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/core.c             | 86 +++++++++++++++++++++--------------------------
 hw/ide/trace-events       |  3 +-
 include/hw/ide/internal.h |  1 +
 3 files changed, 40 insertions(+), 50 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 393f523..af49de5 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2266,6 +2266,42 @@ static bool ide_is_pio_out(IDEState *s)
     abort();
 }
 
+void ide_data_write(void *opaque, uint32_t addr, short nbytes, uint32_t val)
+{
+    IDEBus *bus = opaque;
+    IDEState *s = idebus_active_if(bus);
+    uint8_t *p;
+
+    trace_ide_data_write(addr, nbytes, val, bus, s);
+
+    /* PIO data access allowed only when DRQ bit is set. The result of a write
+     * during PIO out is indeterminate, just ignore it. */
+    if (!(s->status & DRQ_STAT) || ide_is_pio_out(s)) {
+        return;
+    }
+
+    if (nbytes != 2 && nbytes != 4) {
+        return;
+    }
+
+    p = s->data_ptr;
+    if (p + nbytes > s->data_end) {
+        return;
+    }
+
+    if (nbytes == 2) {
+        *(uint16_t *)p = le16_to_cpu(val);
+    } else if (nbytes == 4) {
+        *(uint32_t *)p = le32_to_cpu(val);
+    }
+    p += nbytes;
+    s->data_ptr = p;
+    if (p >= s->data_end) {
+        s->status &= ~DRQ_STAT;
+        s->end_transfer_func(s);
+    }
+}
+
 uint32_t ide_data_read(void *opaque, uint32_t addr, short nbytes)
 {
     IDEBus *bus = opaque;
@@ -2311,30 +2347,7 @@ uint32_t ide_data_read(void *opaque, uint32_t addr, short nbytes)
 
 void ide_data_writew(void *opaque, uint32_t addr, uint32_t val)
 {
-    IDEBus *bus = opaque;
-    IDEState *s = idebus_active_if(bus);
-    uint8_t *p;
-
-    trace_ide_data_writew(addr, val, bus, s);
-
-    /* PIO data access allowed only when DRQ bit is set. The result of a write
-     * during PIO out is indeterminate, just ignore it. */
-    if (!(s->status & DRQ_STAT) || ide_is_pio_out(s)) {
-        return;
-    }
-
-    p = s->data_ptr;
-    if (p + 2 > s->data_end) {
-        return;
-    }
-
-    *(uint16_t *)p = le16_to_cpu(val);
-    p += 2;
-    s->data_ptr = p;
-    if (p >= s->data_end) {
-        s->status &= ~DRQ_STAT;
-        s->end_transfer_func(s);
-    }
+    return ide_data_write(opaque, addr, 2, val);
 }
 
 uint32_t ide_data_readw(void *opaque, uint32_t addr)
@@ -2344,30 +2357,7 @@ uint32_t ide_data_readw(void *opaque, uint32_t addr)
 
 void ide_data_writel(void *opaque, uint32_t addr, uint32_t val)
 {
-    IDEBus *bus = opaque;
-    IDEState *s = idebus_active_if(bus);
-    uint8_t *p;
-
-    trace_ide_data_writel(addr, val, bus, s);
-
-    /* PIO data access allowed only when DRQ bit is set. The result of a write
-     * during PIO out is indeterminate, just ignore it. */
-    if (!(s->status & DRQ_STAT) || ide_is_pio_out(s)) {
-        return;
-    }
-
-    p = s->data_ptr;
-    if (p + 4 > s->data_end) {
-        return;
-    }
-
-    *(uint32_t *)p = le32_to_cpu(val);
-    p += 4;
-    s->data_ptr = p;
-    if (p >= s->data_end) {
-        s->status &= ~DRQ_STAT;
-        s->end_transfer_func(s);
-    }
+    return ide_data_write(opaque, addr, 4, val);
 }
 
 uint32_t ide_data_readl(void *opaque, uint32_t addr)
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index e42c428..e92c0bb 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -7,9 +7,8 @@ ide_ioport_write(uint32_t addr, const char *reg, uint32_t val, void *bus, void *
 ide_status_read(uint32_t addr, uint32_t val, void *bus, void *s)                   "IDE PIO rd @ 0x%"PRIx32" (Alt Status); val 0x%02"PRIx32"; bus %p; IDEState %p"
 ide_cmd_write(uint32_t addr, uint32_t val, void *bus)                              "IDE PIO wr @ 0x%"PRIx32" (Device Control); val 0x%02"PRIx32"; bus %p"
 # Warning: verbose
-ide_data_writew(uint32_t addr, uint32_t val, void *bus, void *s)                   "IDE PIO wr @ 0x%"PRIx32" (Data: Word); val 0x%04"PRIx32"; bus %p; IDEState %p"
-ide_data_writel(uint32_t addr, uint32_t val, void *bus, void *s)                   "IDE PIO wr @ 0x%"PRIx32" (Data: Long); val 0x%08"PRIx32"; bus %p; IDEState %p"
 ide_data_read(uint32_t addr, short nbytes, uint32_t val, void *bus, void *s)       "IDE PIO rd @ 0x%"PRIx32" (Data: %d bytes); val 0x%08"PRIx32"; bus %p; IDEState %p"
+ide_data_write(uint32_t addr, short nbytes, uint32_t val, void *bus, void *s)      "IDE PIO wr @ 0x%"PRIx32" (Data: %d bytes); val 0x%08"PRIx32"; bus %p; IDEState %p"
 
 # misc
 ide_exec_cmd(void *bus, void *state, uint32_t cmd) "IDE exec cmd: bus %p; state %p; cmd 0x%02x"
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 3159c66..deb592d 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -598,6 +598,7 @@ void ide_ioport_write(void *opaque, uint32_t addr, uint32_t val);
 uint32_t ide_ioport_read(void *opaque, uint32_t addr1);
 uint32_t ide_status_read(void *opaque, uint32_t addr);
 void ide_cmd_write(void *opaque, uint32_t addr, uint32_t val);
+void ide_data_write(void *opaque, uint32_t addr, short nbytes, uint32_t val);
 void ide_data_writew(void *opaque, uint32_t addr, uint32_t val);
 void ide_data_writel(void *opaque, uint32_t addr, uint32_t val);
 uint32_t ide_data_read(void *opaque, uint32_t addr, short nbytes);
-- 
2.9.5
