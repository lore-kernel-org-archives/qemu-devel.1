Received: from eggs.gnu.org ([2001:4830:134:3::10]:48643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYJtZ-00086g-6h
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 19:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYJtW-0003nC-1B
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 19:30:41 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 28 Jun 2018 01:29:47 +0200
Message-Id: <20180627232951.14725-7-laurent@vivier.eu>
In-Reply-To: <20180627232951.14725-1-laurent@vivier.eu>
References: <20180627232951.14725-1-laurent@vivier.eu>
Subject: [Qemu-devel] [RFC v3 06/10] ESP: add pseudo-DMA as used by Macintosh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Jason Wang <jasowang@redhat.com>, Fam Zheng <famz@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/mips/mips_jazz.c   |   2 +-
 hw/scsi/esp.c         | 297 ++++++++++++++++++++++++++++++++++++++++++++------
 include/hw/scsi/esp.h |  11 +-
 3 files changed, 276 insertions(+), 34 deletions(-)

diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 90cb306f53..87118f2d03 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -282,7 +282,7 @@ static void mips_jazz_init(MachineState *machine,
 
     /* SCSI adapter */
     esp = esp_init(0x80002000, 0, rc4030_dma_read, rc4030_dma_write, dmas[0],
-                   qdev_get_gpio_in(rc4030, 5), &esp_reset, &dma_enable);
+                   qdev_get_gpio_in(rc4030, 5), NULL, &esp_reset, &dma_enable);
     scsi_bus_legacy_handle_cmdline(&esp->bus);
 
     /* Floppy */
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 9ed9727744..8270abe298 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -37,6 +37,8 @@
  * http://www.ibiblio.org/pub/historic-linux/early-ports/Sparc/NCR/NCR53C9X.txt
  */
 
+/* on Macintosh Quadra it is a NCR53C96 */
+
 static void esp_raise_irq(ESPState *s)
 {
     if (!(s->rregs[ESP_RSTAT] & STAT_INT)) {
@@ -55,6 +57,16 @@ static void esp_lower_irq(ESPState *s)
     }
 }
 
+static void esp_raise_drq(ESPState *s)
+{
+    qemu_irq_raise(s->irq_data);
+}
+
+static void esp_lower_drq(ESPState *s)
+{
+    qemu_irq_lower(s->irq_data);
+}
+
 void esp_dma_enable(ESPState *s, int irq, int level)
 {
     if (level) {
@@ -81,29 +93,11 @@ void esp_request_cancelled(SCSIRequest *req)
     }
 }
 
-static uint32_t get_cmd(ESPState *s, uint8_t *buf, uint8_t buflen)
+static int get_cmd_cb(ESPState *s)
 {
-    uint32_t dmalen;
     int target;
 
     target = s->wregs[ESP_WBUSID] & BUSID_DID;
-    if (s->dma) {
-        dmalen = s->rregs[ESP_TCLO];
-        dmalen |= s->rregs[ESP_TCMID] << 8;
-        dmalen |= s->rregs[ESP_TCHI] << 16;
-        if (dmalen > buflen) {
-            return 0;
-        }
-        s->dma_memory_read(s->dma_opaque, buf, dmalen);
-    } else {
-        dmalen = s->ti_size;
-        if (dmalen > TI_BUFSZ) {
-            return 0;
-        }
-        memcpy(buf, s->ti_buf, dmalen);
-        buf[0] = buf[2] >> 5;
-    }
-    trace_esp_get_cmd(dmalen, target);
 
     s->ti_size = 0;
     s->ti_rptr = 0;
@@ -122,8 +116,48 @@ static uint32_t get_cmd(ESPState *s, uint8_t *buf, uint8_t buflen)
         s->rregs[ESP_RINTR] = INTR_DC;
         s->rregs[ESP_RSEQ] = SEQ_0;
         esp_raise_irq(s);
+        return -1;
+    }
+    return 0;
+}
+
+static uint32_t get_cmd(ESPState *s, uint8_t *buf, uint8_t buflen)
+{
+    int target;
+    uint32_t dmalen;
+
+    target = s->wregs[ESP_WBUSID] & BUSID_DID;
+    if (s->dma) {
+        dmalen = s->rregs[ESP_TCLO];
+        dmalen |= s->rregs[ESP_TCMID] << 8;
+        dmalen |= s->rregs[ESP_TCHI] << 16;
+        if (dmalen > buflen) {
+            return 0;
+        }
+        if (s->dma_memory_read) {
+            s->dma_memory_read(s->dma_opaque, buf, dmalen);
+        } else {
+            memcpy(s->pdma_buf, buf, dmalen);
+            s->pdma_len = dmalen;
+            s->pdma_start = s->pdma_buf;
+            s->pdma_cur = s->pdma_buf;
+            esp_raise_drq(s);
+            return 0;
+        }
+    } else {
+        dmalen = s->ti_size;
+        if (dmalen > TI_BUFSZ) {
+            return 0;
+        }
+        memcpy(buf, s->ti_buf, dmalen);
+        buf[0] = buf[2] >> 5;
+    }
+    trace_esp_get_cmd(dmalen, target);
+
+    if (get_cmd_cb(s) < 0) {
         return 0;
     }
+
     return dmalen;
 }
 
@@ -162,6 +196,15 @@ static void do_cmd(ESPState *s, uint8_t *buf)
     do_busid_cmd(s, &buf[1], busid);
 }
 
+static void satn_pdma_cb(ESPState *s)
+{
+    if (get_cmd_cb(s) < 0) {
+        return;
+    }
+    if (s->pdma_cur != s->pdma_start)
+        do_cmd(s, s->pdma_start);
+}
+
 static void handle_satn(ESPState *s)
 {
     uint8_t buf[32];
@@ -171,11 +214,21 @@ static void handle_satn(ESPState *s)
         s->dma_cb = handle_satn;
         return;
     }
+    s->pdma_cb = satn_pdma_cb;
     len = get_cmd(s, buf, sizeof(buf));
     if (len)
         do_cmd(s, buf);
 }
 
+static void s_without_satn_pdma_cb(ESPState *s)
+{
+    if (get_cmd_cb(s) < 0) {
+        return;
+    }
+    if (s->pdma_cur != s->pdma_start)
+        do_busid_cmd(s, s->pdma_start, 0);
+}
+
 static void handle_s_without_atn(ESPState *s)
 {
     uint8_t buf[32];
@@ -185,18 +238,36 @@ static void handle_s_without_atn(ESPState *s)
         s->dma_cb = handle_s_without_atn;
         return;
     }
+    s->pdma_cb = s_without_satn_pdma_cb;
     len = get_cmd(s, buf, sizeof(buf));
     if (len) {
         do_busid_cmd(s, buf, 0);
     }
 }
 
+static void satn_stop_pdma_cb(ESPState *s)
+{
+    if (get_cmd_cb(s) < 0) {
+        return;
+    }
+    s->cmdlen = s->pdma_cur - s->pdma_start;
+    if (s->cmdlen) {
+        trace_esp_handle_satn_stop(s->cmdlen);
+        s->do_cmd = 1;
+        s->rregs[ESP_RSTAT] = STAT_TC | STAT_CD;
+        s->rregs[ESP_RINTR] = INTR_BS | INTR_FC;
+        s->rregs[ESP_RSEQ] = SEQ_CD;
+        esp_raise_irq(s);
+    }
+}
+
 static void handle_satn_stop(ESPState *s)
 {
     if (s->dma && !s->dma_enabled) {
         s->dma_cb = handle_satn_stop;
         return;
     }
+    s->pdma_cb = satn_stop_pdma_cb;;
     s->cmdlen = get_cmd(s, s->cmdbuf, sizeof(s->cmdbuf));
     if (s->cmdlen) {
         trace_esp_handle_satn_stop(s->cmdlen);
@@ -208,16 +279,33 @@ static void handle_satn_stop(ESPState *s)
     }
 }
 
+static void write_response_pdma_cb(ESPState *s)
+{
+    s->rregs[ESP_RSTAT] = STAT_TC | STAT_ST;
+    s->rregs[ESP_RINTR] = INTR_BS | INTR_FC;
+    s->rregs[ESP_RSEQ] = SEQ_CD;
+    esp_raise_irq(s);
+}
+
 static void write_response(ESPState *s)
 {
     trace_esp_write_response(s->status);
     s->ti_buf[0] = s->status;
     s->ti_buf[1] = 0;
     if (s->dma) {
-        s->dma_memory_write(s->dma_opaque, s->ti_buf, 2);
-        s->rregs[ESP_RSTAT] = STAT_TC | STAT_ST;
-        s->rregs[ESP_RINTR] = INTR_BS | INTR_FC;
-        s->rregs[ESP_RSEQ] = SEQ_CD;
+        if (s->dma_memory_write) {
+            s->dma_memory_write(s->dma_opaque, s->ti_buf, 2);
+            s->rregs[ESP_RSTAT] = STAT_TC | STAT_ST;
+            s->rregs[ESP_RINTR] = INTR_BS | INTR_FC;
+            s->rregs[ESP_RSEQ] = SEQ_CD;
+        } else {
+            s->pdma_len = 2;
+            s->pdma_start = s->ti_buf;
+            s->pdma_cur = s->ti_buf;
+            s->pdma_cb = write_response_pdma_cb;
+            esp_raise_drq(s);
+            return;
+        }
     } else {
         s->ti_size = 2;
         s->ti_rptr = 0;
@@ -239,6 +327,39 @@ static void esp_dma_done(ESPState *s)
     esp_raise_irq(s);
 }
 
+static void do_dma_pdma_cb(ESPState *s)
+{
+    int to_device = (s->ti_size < 0);
+    int len = s->pdma_cur - s->pdma_start;
+    if (s->do_cmd) {
+        s->ti_size = 0;
+        s->cmdlen = 0;
+        s->do_cmd = 0;
+        do_cmd(s, s->cmdbuf);
+        return;
+    }
+    s->dma_left -= len;
+    s->async_buf += len;
+    s->async_len -= len;
+    if (to_device) {
+        s->ti_size += len;
+    } else {
+        s->ti_size -= len;
+    }
+    if (s->async_len == 0) {
+        scsi_req_continue(s->current_req);
+        /* If there is still data to be read from the device then
+           complete the DMA operation immediately.  Otherwise defer
+           until the scsi layer has completed.  */
+        if (to_device || s->dma_left != 0 || s->ti_size == 0) {
+            return;
+        }
+    }
+
+    /* Partially filled a scsi buffer. Complete immediately.  */
+    esp_dma_done(s);
+}
+
 static void esp_do_dma(ESPState *s)
 {
     uint32_t len;
@@ -249,10 +370,26 @@ static void esp_do_dma(ESPState *s)
         trace_esp_do_dma(s->cmdlen, len);
         assert (s->cmdlen <= sizeof(s->cmdbuf) &&
                 len <= sizeof(s->cmdbuf) - s->cmdlen);
-        s->dma_memory_read(s->dma_opaque, &s->cmdbuf[s->cmdlen], len);
+        if (s->dma_memory_read) {
+            s->dma_memory_read(s->dma_opaque, &s->cmdbuf[s->cmdlen], len);
+        } else {
+            s->pdma_len = len;
+            s->pdma_start = &s->cmdbuf[s->cmdlen];
+            s->pdma_cur = &s->cmdbuf[s->cmdlen];
+            s->pdma_cb = do_dma_pdma_cb;
+            esp_raise_drq(s);
+            return;
+        }
+        s->ti_size = 0;
+        s->cmdlen = 0;
+        s->do_cmd = 0;
+        do_cmd(s, s->cmdbuf);
         return;
     }
     if (s->async_len == 0) {
+        if (s->dma_left == 0) {
+            esp_dma_done(s);
+        }
         /* Defer until data is available.  */
         return;
     }
@@ -261,9 +398,27 @@ static void esp_do_dma(ESPState *s)
     }
     to_device = (s->ti_size < 0);
     if (to_device) {
-        s->dma_memory_read(s->dma_opaque, s->async_buf, len);
+        if (s->dma_memory_read) {
+            s->dma_memory_read(s->dma_opaque, s->async_buf, len);
+        } else {
+            s->pdma_len = len;
+            s->pdma_start = s->async_buf;
+            s->pdma_cur = s->async_buf;
+            s->pdma_cb = do_dma_pdma_cb;
+            esp_raise_drq(s);
+            return;
+        }
     } else {
-        s->dma_memory_write(s->dma_opaque, s->async_buf, len);
+        if (s->dma_memory_write) {
+            s->dma_memory_write(s->dma_opaque, s->async_buf, len);
+        } else {
+            s->pdma_len = len;
+            s->pdma_start = s->async_buf;
+            s->pdma_cur = s->async_buf;
+            s->pdma_cb = do_dma_pdma_cb;
+            esp_raise_drq(s);
+            return;
+        }
     }
     s->dma_left -= len;
     s->async_buf += len;
@@ -356,8 +511,7 @@ static void handle_ti(ESPState *s)
         s->dma_left = minlen;
         s->rregs[ESP_RSTAT] &= ~STAT_TC;
         esp_do_dma(s);
-    }
-    if (s->do_cmd) {
+    } else if (s->do_cmd) {
         trace_esp_handle_ti_cmd(s->cmdlen);
         s->ti_size = 0;
         s->cmdlen = 0;
@@ -384,6 +538,7 @@ void esp_hard_reset(ESPState *s)
 static void esp_soft_reset(ESPState *s)
 {
     qemu_irq_lower(s->irq);
+    qemu_irq_lower(s->irq_data);
     esp_hard_reset(s);
 }
 
@@ -409,6 +564,7 @@ uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
             s->ti_size--;
             s->rregs[ESP_FIFO] = s->ti_buf[s->ti_rptr++];
         }
+        esp_raise_irq(s);
         if (s->ti_rptr == s->ti_wptr) {
             s->ti_rptr = 0;
             s->ti_wptr = 0;
@@ -619,11 +775,85 @@ static const MemoryRegionOps sysbus_esp_mem_ops = {
     .valid.accepts = esp_mem_accepts,
 };
 
+static void sysbus_esp_pdma_write(void *opaque, hwaddr addr,
+                                 uint64_t val, unsigned int size)
+{
+    SysBusESPState *sysbus = opaque;
+    ESPState *s = &sysbus->esp;
+    uint32_t dmalen;
+
+    dmalen = s->rregs[ESP_TCLO];
+    dmalen |= s->rregs[ESP_TCMID] << 8;
+    dmalen |= s->rregs[ESP_TCHI] << 16;
+    if (dmalen == 0 || s->pdma_len == 0) {
+        return;
+    }
+    switch (size) {
+    case 1:
+        *s->pdma_cur++ = val;
+        s->pdma_len--;
+        dmalen--;
+        break;
+    case 2:
+        *s->pdma_cur++ = val >> 8;
+        *s->pdma_cur++ = val;
+        s->pdma_len -= 2;
+        dmalen -= 2;
+        break;
+    }
+    s->rregs[ESP_TCLO] = dmalen & 0xff;
+    s->rregs[ESP_TCMID] = dmalen >> 8;
+    s->rregs[ESP_TCHI] = dmalen >> 16;
+    if (s->pdma_len == 0 && s->pdma_cb) {
+        esp_lower_drq(s);
+        s->pdma_cb(s);
+        s->pdma_cb = NULL;
+    }
+}
+
+static uint64_t sysbus_esp_pdma_read(void *opaque, hwaddr addr,
+                                    unsigned int size)
+{
+    SysBusESPState *sysbus = opaque;
+    ESPState *s = &sysbus->esp;
+    uint64_t val = 0;
+
+    if (s->pdma_len == 0) {
+        return 0;
+    }
+    switch (size) {
+    case 1:
+        val = *s->pdma_cur++;
+        s->pdma_len--;
+        break;
+    case 2:
+        val = *s->pdma_cur++;
+        val = (val << 8) | *s->pdma_cur++;
+        s->pdma_len -= 2;
+        break;
+    }
+
+    if (s->pdma_len == 0 && s->pdma_cb) {
+        esp_lower_drq(s);
+        s->pdma_cb(s);
+        s->pdma_cb = NULL;
+    }
+    return val;
+}
+
+static const MemoryRegionOps sysbus_esp_pdma_ops = {
+    .read = sysbus_esp_pdma_read,
+    .write = sysbus_esp_pdma_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 2,
+};
+
 ESPState *esp_init(hwaddr espaddr, int it_shift,
                    ESPDMAMemoryReadWriteFunc dma_memory_read,
                    ESPDMAMemoryReadWriteFunc dma_memory_write,
-                   void *dma_opaque, qemu_irq irq, qemu_irq *reset,
-                   qemu_irq *dma_enable)
+                   void *dma_opaque, qemu_irq irq, qemu_irq irq_data,
+                   qemu_irq *reset, qemu_irq *dma_enable)
 {
     DeviceState *dev;
     SysBusDevice *s;
@@ -642,6 +872,7 @@ ESPState *esp_init(hwaddr espaddr, int it_shift,
     qdev_init_nofail(dev);
     s = SYS_BUS_DEVICE(dev);
     sysbus_connect_irq(s, 0, irq);
+    sysbus_connect_irq(s, 1, irq_data);
     sysbus_mmio_map(s, 0, espaddr);
     *reset = qdev_get_gpio_in(dev, 0);
     *dma_enable = qdev_get_gpio_in(dev, 1);
@@ -681,12 +912,16 @@ static void sysbus_esp_realize(DeviceState *dev, Error **errp)
     ESPState *s = &sysbus->esp;
 
     sysbus_init_irq(sbd, &s->irq);
+    sysbus_init_irq(sbd, &s->irq_data);
     assert(sysbus->it_shift != -1);
 
     s->chip_id = TCHI_FAS100A;
     memory_region_init_io(&sysbus->iomem, OBJECT(sysbus), &sysbus_esp_mem_ops,
-                          sysbus, "esp", ESP_REGS << sysbus->it_shift);
+                          sysbus, "esp-regs", ESP_REGS << sysbus->it_shift);
     sysbus_init_mmio(sbd, &sysbus->iomem);
+    memory_region_init_io(&sysbus->pdma, OBJECT(sysbus), &sysbus_esp_pdma_ops,
+                          sysbus, "esp-pdma", 2);
+    sysbus_init_mmio(sbd, &sysbus->pdma);
 
     qdev_init_gpio_in(dev, sysbus_esp_gpio_demux, 2);
 
diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index 93fdaced67..43312e4bc8 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -18,6 +18,7 @@ struct ESPState {
     uint8_t rregs[ESP_REGS];
     uint8_t wregs[ESP_REGS];
     qemu_irq irq;
+    qemu_irq irq_data;
     uint8_t chip_id;
     bool tchi_written;
     int32_t ti_size;
@@ -46,6 +47,11 @@ struct ESPState {
     ESPDMAMemoryReadWriteFunc dma_memory_write;
     void *dma_opaque;
     void (*dma_cb)(ESPState *s);
+    uint8_t pdma_buf[32];
+    uint32_t pdma_len;
+    uint8_t *pdma_start;
+    uint8_t *pdma_cur;
+    void (*pdma_cb)(ESPState *s);
 };
 
 #define TYPE_ESP "esp"
@@ -57,6 +63,7 @@ typedef struct {
     /*< public >*/
 
     MemoryRegion iomem;
+    MemoryRegion pdma;
     uint32_t it_shift;
     ESPState esp;
 } SysBusESPState;
@@ -134,8 +141,8 @@ typedef struct {
 ESPState *esp_init(hwaddr espaddr, int it_shift,
                    ESPDMAMemoryReadWriteFunc dma_memory_read,
                    ESPDMAMemoryReadWriteFunc dma_memory_write,
-                   void *dma_opaque, qemu_irq irq, qemu_irq *reset,
-                   qemu_irq *dma_enable);
+                   void *dma_opaque, qemu_irq irq, qemu_irq irq_data,
+                   qemu_irq *reset, qemu_irq *dma_enable);
 void esp_dma_enable(ESPState *s, int irq, int level);
 void esp_request_cancelled(SCSIRequest *req);
 void esp_command_complete(SCSIRequest *req, uint32_t status, size_t resid);
-- 
2.14.4
