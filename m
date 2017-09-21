Received: from eggs.gnu.org ([2001:4830:134:3::10]:40979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1duqAa-0008BT-De
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 21:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1duqAZ-00073a-1S
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 21:20:48 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed, 20 Sep 2017 21:20:36 -0400
Message-Id: <20170921012037.553-2-jsnow@redhat.com>
In-Reply-To: <20170921012037.553-1-jsnow@redhat.com>
References: <20170921012037.553-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] ide: generic ide_data_read
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
 hw/ide/core.c             | 99 +++++++++++++++++++++--------------------------
 hw/ide/trace-events       |  4 +-
 include/hw/ide/internal.h |  3 +-
 3 files changed, 49 insertions(+), 57 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index a19bd90..393f523 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2266,6 +2266,49 @@ static bool ide_is_pio_out(IDEState *s)
     abort();
 }
 
+uint32_t ide_data_read(void *opaque, uint32_t addr, short nbytes)
+{
+    IDEBus *bus = opaque;
+    IDEState *s = idebus_active_if(bus);
+    uint8_t *p;
+    int ret;
+
+    g_assert(nbytes == 2 || nbytes == 4);
+
+    /* PIO data access allowed only when DRQ bit is set. The result of a read
+     * during PIO in is indeterminate, return 0 and don't move forward. */
+    if (!(s->status & DRQ_STAT) || !ide_is_pio_out(s)) {
+        ret = 0;
+        goto out;
+    }
+
+    p = s->data_ptr;
+    if (p + nbytes > s->data_end) {
+        ret = 0;
+        goto out;
+    }
+
+    if (nbytes == 2) {
+        ret = cpu_to_le16(*(uint16_t *)p);
+    } else if (nbytes == 4) {
+        ret = cpu_to_le32(*(uint32_t *)p);
+    } else {
+        ret = 0;
+        goto out;
+    }
+
+    p += nbytes;
+    s->data_ptr = p;
+    if (p >= s->data_end) {
+        s->status &= ~DRQ_STAT;
+        s->end_transfer_func(s);
+    }
+
+ out:
+    trace_ide_data_read(addr, nbytes, ret, bus, s);
+    return ret;
+}
+
 void ide_data_writew(void *opaque, uint32_t addr, uint32_t val)
 {
     IDEBus *bus = opaque;
@@ -2296,32 +2339,7 @@ void ide_data_writew(void *opaque, uint32_t addr, uint32_t val)
 
 uint32_t ide_data_readw(void *opaque, uint32_t addr)
 {
-    IDEBus *bus = opaque;
-    IDEState *s = idebus_active_if(bus);
-    uint8_t *p;
-    int ret;
-
-    /* PIO data access allowed only when DRQ bit is set. The result of a read
-     * during PIO in is indeterminate, return 0 and don't move forward. */
-    if (!(s->status & DRQ_STAT) || !ide_is_pio_out(s)) {
-        return 0;
-    }
-
-    p = s->data_ptr;
-    if (p + 2 > s->data_end) {
-        return 0;
-    }
-
-    ret = cpu_to_le16(*(uint16_t *)p);
-    p += 2;
-    s->data_ptr = p;
-    if (p >= s->data_end) {
-        s->status &= ~DRQ_STAT;
-        s->end_transfer_func(s);
-    }
-
-    trace_ide_data_readw(addr, ret, bus, s);
-    return ret;
+    return ide_data_read(opaque, addr, 2);
 }
 
 void ide_data_writel(void *opaque, uint32_t addr, uint32_t val)
@@ -2354,34 +2372,7 @@ void ide_data_writel(void *opaque, uint32_t addr, uint32_t val)
 
 uint32_t ide_data_readl(void *opaque, uint32_t addr)
 {
-    IDEBus *bus = opaque;
-    IDEState *s = idebus_active_if(bus);
-    uint8_t *p;
-    int ret;
-
-    /* PIO data access allowed only when DRQ bit is set. The result of a read
-     * during PIO in is indeterminate, return 0 and don't move forward. */
-    if (!(s->status & DRQ_STAT) || !ide_is_pio_out(s)) {
-        ret = 0;
-        goto out;
-    }
-
-    p = s->data_ptr;
-    if (p + 4 > s->data_end) {
-        return 0;
-    }
-
-    ret = cpu_to_le32(*(uint32_t *)p);
-    p += 4;
-    s->data_ptr = p;
-    if (p >= s->data_end) {
-        s->status &= ~DRQ_STAT;
-        s->end_transfer_func(s);
-    }
-
-out:
-    trace_ide_data_readl(addr, ret, bus, s);
-    return ret;
+    return ide_data_read(opaque, addr, 4);
 }
 
 static void ide_dummy_transfer_stop(IDEState *s)
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index 601bd97..e42c428 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -7,10 +7,10 @@ ide_ioport_write(uint32_t addr, const char *reg, uint32_t val, void *bus, void *
 ide_status_read(uint32_t addr, uint32_t val, void *bus, void *s)                   "IDE PIO rd @ 0x%"PRIx32" (Alt Status); val 0x%02"PRIx32"; bus %p; IDEState %p"
 ide_cmd_write(uint32_t addr, uint32_t val, void *bus)                              "IDE PIO wr @ 0x%"PRIx32" (Device Control); val 0x%02"PRIx32"; bus %p"
 # Warning: verbose
-ide_data_readw(uint32_t addr, uint32_t val, void *bus, void *s)                    "IDE PIO rd @ 0x%"PRIx32" (Data: Word); val 0x%04"PRIx32"; bus %p; IDEState %p"
 ide_data_writew(uint32_t addr, uint32_t val, void *bus, void *s)                   "IDE PIO wr @ 0x%"PRIx32" (Data: Word); val 0x%04"PRIx32"; bus %p; IDEState %p"
-ide_data_readl(uint32_t addr, uint32_t val, void *bus, void *s)                    "IDE PIO rd @ 0x%"PRIx32" (Data: Long); val 0x%08"PRIx32"; bus %p; IDEState %p"
 ide_data_writel(uint32_t addr, uint32_t val, void *bus, void *s)                   "IDE PIO wr @ 0x%"PRIx32" (Data: Long); val 0x%08"PRIx32"; bus %p; IDEState %p"
+ide_data_read(uint32_t addr, short nbytes, uint32_t val, void *bus, void *s)       "IDE PIO rd @ 0x%"PRIx32" (Data: %d bytes); val 0x%08"PRIx32"; bus %p; IDEState %p"
+
 # misc
 ide_exec_cmd(void *bus, void *state, uint32_t cmd) "IDE exec cmd: bus %p; state %p; cmd 0x%02x"
 ide_cancel_dma_sync_buffered(void *fn, void *req) "invoking cb %p of buffered request %p with -ECANCELED"
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 180e00e..3159c66 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -599,8 +599,9 @@ uint32_t ide_ioport_read(void *opaque, uint32_t addr1);
 uint32_t ide_status_read(void *opaque, uint32_t addr);
 void ide_cmd_write(void *opaque, uint32_t addr, uint32_t val);
 void ide_data_writew(void *opaque, uint32_t addr, uint32_t val);
-uint32_t ide_data_readw(void *opaque, uint32_t addr);
 void ide_data_writel(void *opaque, uint32_t addr, uint32_t val);
+uint32_t ide_data_read(void *opaque, uint32_t addr, short nbytes);
+uint32_t ide_data_readw(void *opaque, uint32_t addr);
 uint32_t ide_data_readl(void *opaque, uint32_t addr);
 
 int ide_init_drive(IDEState *s, BlockBackend *blk, IDEDriveKind kind,
-- 
2.9.5
