Received: from eggs.gnu.org ([2001:4830:134:3::10]:37020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1du68r-0005bT-Th
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 20:11:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1du68p-0004So-R2
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 20:11:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1du68p-0004SJ-Hx
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 20:11:55 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 18 Sep 2017 20:11:37 -0400
Message-Id: <20170919001147.23182-5-jsnow@redhat.com>
In-Reply-To: <20170919001147.23182-1-jsnow@redhat.com>
References: <20170919001147.23182-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 03/13] IDE: replace DEBUG_IDE with tracing system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com

Remove the DEBUG_IDE preprocessor definition with something more
appropriately flexible, using the trace-events subsystem.

This will be less prone to bitrot and will more effectively allow
us to target just the functions we care about.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20170901001502.29915-2-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 Makefile.objs             |  1 +
 hw/ide/cmd646.c           | 10 +++-----
 hw/ide/core.c             | 65 +++++++++++++++++++----------------------------
 hw/ide/pci.c              | 17 ++++---------
 hw/ide/piix.c             | 11 ++++----
 hw/ide/trace-events       | 35 +++++++++++++++++++++++++
 hw/ide/via.c              | 10 +++-----
 include/hw/ide/internal.h |  1 -
 8 files changed, 80 insertions(+), 70 deletions(-)
 create mode 100644 hw/ide/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index d9cf7ad..3a6914c 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -155,6 +155,7 @@ trace-events-subdirs += hw/acpi
 trace-events-subdirs += hw/arm
 trace-events-subdirs += hw/alpha
 trace-events-subdirs += hw/xen
+trace-events-subdirs += hw/ide
 trace-events-subdirs += ui
 trace-events-subdirs += audio
 trace-events-subdirs += net
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 9ebb8d4..86b2a8f 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -32,6 +32,7 @@
 #include "sysemu/dma.h"
 
 #include "hw/ide/pci.h"
+#include "trace.h"
 
 /* CMD646 specific */
 #define CFR		0x50
@@ -195,9 +196,8 @@ static uint64_t bmdma_read(void *opaque, hwaddr addr,
         val = 0xff;
         break;
     }
-#ifdef DEBUG_IDE
-    printf("bmdma: readb " TARGET_FMT_plx " : 0x%02x\n", addr, val);
-#endif
+
+    trace_bmdma_read_cmd646(addr, val);
     return val;
 }
 
@@ -211,9 +211,7 @@ static void bmdma_write(void *opaque, hwaddr addr,
         return;
     }
 
-#ifdef DEBUG_IDE
-    printf("bmdma: writeb " TARGET_FMT_plx " : 0x%" PRIx64 "\n", addr, val);
-#endif
+    trace_bmdma_write_cmd646(addr, val);
     switch(addr & 3) {
     case 0:
         bmdma_cmd_writeb(bm, val);
diff --git a/hw/ide/core.c b/hw/ide/core.c
index bea3953..31fd593 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -36,6 +36,7 @@
 #include "qemu/cutils.h"
 
 #include "hw/ide/internal.h"
+#include "trace.h"
 
 /* These values were based on a Seagate ST3500418AS but have been modified
    to make more sense in QEMU */
@@ -656,10 +657,7 @@ void ide_cancel_dma_sync(IDEState *s)
      * write requests) pending and we can avoid to drain. */
     QLIST_FOREACH(req, &s->buffered_requests, list) {
         if (!req->orphaned) {
-#ifdef DEBUG_IDE
-            printf("%s: invoking cb %p of buffered request %p with"
-                   " -ECANCELED\n", __func__, req->original_cb, req);
-#endif
+            trace_ide_cancel_dma_sync_buffered(req->original_cb, req);
             req->original_cb(req->original_opaque, -ECANCELED);
         }
         req->orphaned = true;
@@ -678,9 +676,7 @@ void ide_cancel_dma_sync(IDEState *s)
      * aio operation with preadv/pwritev.
      */
     if (s->bus->dma->aiocb) {
-#ifdef DEBUG_IDE
-        printf("%s: draining all remaining requests", __func__);
-#endif
+        trace_ide_cancel_dma_sync_remaining();
         blk_drain(s->blk);
         assert(s->bus->dma->aiocb == NULL);
     }
@@ -741,9 +737,7 @@ static void ide_sector_read(IDEState *s)
         n = s->req_nb_sectors;
     }
 
-#if defined(DEBUG_IDE)
-    printf("sector=%" PRId64 "\n", sector_num);
-#endif
+    trace_ide_sector_read(sector_num, n);
 
     if (!ide_sect_range_ok(s, sector_num, n)) {
         ide_rw_error(s);
@@ -1005,14 +999,14 @@ static void ide_sector_write(IDEState *s)
 
     s->status = READY_STAT | SEEK_STAT | BUSY_STAT;
     sector_num = ide_get_sector(s);
-#if defined(DEBUG_IDE)
-    printf("sector=%" PRId64 "\n", sector_num);
-#endif
+
     n = s->nsector;
     if (n > s->req_nb_sectors) {
         n = s->req_nb_sectors;
     }
 
+    trace_ide_sector_write(sector_num, n);
+
     if (!ide_sect_range_ok(s, sector_num, n)) {
         ide_rw_error(s);
         block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_WRITE);
@@ -1194,18 +1188,17 @@ static void ide_clear_hob(IDEBus *bus)
 void ide_ioport_write(void *opaque, uint32_t addr, uint32_t val)
 {
     IDEBus *bus = opaque;
+    IDEState *s = idebus_active_if(bus);
+    int reg_num = addr & 7;
 
-#ifdef DEBUG_IDE
-    printf("IDE: write addr=0x%x val=0x%02x\n", addr, val);
-#endif
-
-    addr &= 7;
+    trace_ide_ioport_write(addr, val, bus, s);
 
     /* ignore writes to command block while busy with previous command */
-    if (addr != 7 && (idebus_active_if(bus)->status & (BUSY_STAT|DRQ_STAT)))
+    if (reg_num != 7 && (s->status & (BUSY_STAT|DRQ_STAT))) {
         return;
+    }
 
-    switch(addr) {
+    switch (reg_num) {
     case 0:
         break;
     case 1:
@@ -1261,9 +1254,7 @@ void ide_ioport_write(void *opaque, uint32_t addr, uint32_t val)
 
 static void ide_reset(IDEState *s)
 {
-#ifdef DEBUG_IDE
-    printf("ide: reset\n");
-#endif
+    trace_ide_reset(s);
 
     if (s->pio_aiocb) {
         blk_aio_cancel(s->pio_aiocb);
@@ -2021,10 +2012,9 @@ void ide_exec_cmd(IDEBus *bus, uint32_t val)
     IDEState *s;
     bool complete;
 
-#if defined(DEBUG_IDE)
-    printf("ide: CMD=%02x\n", val);
-#endif
     s = idebus_active_if(bus);
+    trace_ide_exec_cmd(bus, s, val);
+
     /* ignore commands to non existent slave */
     if (s != bus->ifs && !s->blk) {
         return;
@@ -2062,18 +2052,18 @@ void ide_exec_cmd(IDEBus *bus, uint32_t val)
     }
 }
 
-uint32_t ide_ioport_read(void *opaque, uint32_t addr1)
+uint32_t ide_ioport_read(void *opaque, uint32_t addr)
 {
     IDEBus *bus = opaque;
     IDEState *s = idebus_active_if(bus);
-    uint32_t addr;
+    uint32_t reg_num;
     int ret, hob;
 
-    addr = addr1 & 7;
+    reg_num = addr & 7;
     /* FIXME: HOB readback uses bit 7, but it's always set right now */
     //hob = s->select & (1 << 7);
     hob = 0;
-    switch(addr) {
+    switch (reg_num) {
     case 0:
         ret = 0xff;
         break;
@@ -2141,9 +2131,8 @@ uint32_t ide_ioport_read(void *opaque, uint32_t addr1)
         qemu_irq_lower(bus->irq);
         break;
     }
-#ifdef DEBUG_IDE
-    printf("ide: read addr=0x%x val=%02x\n", addr1, ret);
-#endif
+
+    trace_ide_ioport_read(addr, ret, bus, s);
     return ret;
 }
 
@@ -2159,9 +2148,8 @@ uint32_t ide_status_read(void *opaque, uint32_t addr)
     } else {
         ret = s->status;
     }
-#ifdef DEBUG_IDE
-    printf("ide: read status addr=0x%x val=%02x\n", addr, ret);
-#endif
+
+    trace_ide_status_read(addr, ret, bus, s);
     return ret;
 }
 
@@ -2171,9 +2159,8 @@ void ide_cmd_write(void *opaque, uint32_t addr, uint32_t val)
     IDEState *s;
     int i;
 
-#ifdef DEBUG_IDE
-    printf("ide: write control addr=0x%x val=%02x\n", addr, val);
-#endif
+    trace_ide_cmd_write(addr, val, bus);
+
     /* common for both drives */
     if (!(bus->cmd & IDE_CMD_RESET) &&
         (val & IDE_CMD_RESET)) {
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index 3cfb510..f2dcc0e 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -31,6 +31,7 @@
 #include "sysemu/dma.h"
 #include "qemu/error-report.h"
 #include "hw/ide/pci.h"
+#include "trace.h"
 
 #define BMDMA_PAGE_SIZE 4096
 
@@ -196,9 +197,7 @@ static void bmdma_reset(IDEDMA *dma)
 {
     BMDMAState *bm = DO_UPCAST(BMDMAState, dma, dma);
 
-#ifdef DEBUG_IDE
-    printf("ide: dma_reset\n");
-#endif
+    trace_bmdma_reset();
     bmdma_cancel(bm);
     bm->cmd = 0;
     bm->status = 0;
@@ -227,9 +226,7 @@ static void bmdma_irq(void *opaque, int n, int level)
 
 void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val)
 {
-#ifdef DEBUG_IDE
-    printf("%s: 0x%08x\n", __func__, val);
-#endif
+    trace_bmdma_cmd_writeb(val);
 
     /* Ignore writes to SSBM if it keeps the old value */
     if ((val & BM_CMD_START) != (bm->cmd & BM_CMD_START)) {
@@ -258,9 +255,7 @@ static uint64_t bmdma_addr_read(void *opaque, hwaddr addr,
     uint64_t data;
 
     data = (bm->addr >> (addr * 8)) & mask;
-#ifdef DEBUG_IDE
-    printf("%s: 0x%08x\n", __func__, (unsigned)data);
-#endif
+    trace_bmdma_addr_read(data);
     return data;
 }
 
@@ -271,9 +266,7 @@ static void bmdma_addr_write(void *opaque, hwaddr addr,
     int shift = addr * 8;
     uint32_t mask = (1ULL << (width * 8)) - 1;
 
-#ifdef DEBUG_IDE
-    printf("%s: 0x%08x\n", __func__, (unsigned)data);
-#endif
+    trace_bmdma_addr_write(data);
     bm->addr &= ~(mask << shift);
     bm->addr |= ((data & mask) << shift) & ~3;
 }
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index 7e2d767..dfb21f6 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -33,6 +33,7 @@
 #include "sysemu/dma.h"
 
 #include "hw/ide/pci.h"
+#include "trace.h"
 
 static uint64_t bmdma_read(void *opaque, hwaddr addr, unsigned size)
 {
@@ -54,9 +55,8 @@ static uint64_t bmdma_read(void *opaque, hwaddr addr, unsigned size)
         val = 0xff;
         break;
     }
-#ifdef DEBUG_IDE
-    printf("bmdma: readb 0x%02x : 0x%02x\n", (uint8_t)addr, val);
-#endif
+
+    trace_bmdma_read(addr, val);
     return val;
 }
 
@@ -69,9 +69,8 @@ static void bmdma_write(void *opaque, hwaddr addr,
         return;
     }
 
-#ifdef DEBUG_IDE
-    printf("bmdma: writeb 0x%02x : 0x%02x\n", (uint8_t)addr, (uint8_t)val);
-#endif
+    trace_bmdma_write(addr, val);
+
     switch(addr & 3) {
     case 0:
         bmdma_cmd_writeb(bm, val);
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
new file mode 100644
index 0000000..b9792812
--- /dev/null
+++ b/hw/ide/trace-events
@@ -0,0 +1,35 @@
+# See docs/devel/tracing.txt for syntax documentation.
+
+# hw/ide/core.c
+# portio
+ide_ioport_read(uint32_t addr, uint32_t val, void *bus, void *s)  "IDE PIO rd @ 0x%"PRIx32"; val 0x%02"PRIx32"; bus %p IDEState %p"
+ide_ioport_write(uint32_t addr, uint32_t val, void *bus, void *s) "IDE PIO wr @ 0x%"PRIx32"; val 0x%02"PRIx32"; bus %p IDEState %p"
+ide_status_read(uint32_t addr, uint32_t val, void *bus, void *s)  "IDE PIO rd @ 0x%"PRIx32" (Alt Status); val 0x%02"PRIx32"; bus %p; IDEState %p"
+ide_cmd_write(uint32_t addr, uint32_t val, void *bus)             "IDE PIO wr @ 0x%"PRIx32" (Device Control); val 0x%02"PRIx32"; bus %p"
+# misc
+ide_exec_cmd(void *bus, void *state, uint32_t cmd) "IDE exec cmd: bus %p; state %p; cmd 0x%02x"
+ide_cancel_dma_sync_buffered(void *fn, void *req) "invoking cb %p of buffered request %p with -ECANCELED"
+ide_cancel_dma_sync_remaining(void) "draining all remaining requests"
+ide_sector_read(int64_t sector_num, int nsectors) "sector=%"PRId64" nsectors=%d"
+ide_sector_write(int64_t sector_num, int nsectors) "sector=%"PRId64" nsectors=%d"
+ide_reset(void *s) "IDEstate %p"
+
+# BMDMA HBAs:
+
+# hw/ide/cmd646.c
+bmdma_read_cmd646(uint64_t addr, uint32_t val) "bmdma: readb 0x%"PRIx64" : 0x%02x"
+bmdma_write_cmd646(uint64_t addr, uint64_t val) "bmdma: writeb 0x%"PRIx64" : 0x%02"PRIx64
+
+# hw/ide/pci.c
+bmdma_reset(void) ""
+bmdma_cmd_writeb(uint32_t val) "val: 0x%08x"
+bmdma_addr_read(uint64_t data) "data: 0x%016"PRIx64
+bmdma_addr_write(uint64_t data) "data: 0x%016"PRIx64
+
+# hw/ide/piix.c
+bmdma_read(uint64_t addr, uint8_t val) "bmdma: readb 0x%"PRIx64" : 0x%02x"
+bmdma_write(uint64_t addr, uint64_t val) "bmdma: writeb 0x%"PRIx64" : 0x%02"PRIx64
+
+# hw/ide/via.c
+bmdma_read_via(uint64_t addr, uint32_t val) "bmdma: readb 0x%"PRIx64" : 0x%02x"
+bmdma_write_via(uint64_t addr, uint64_t val) "bmdma: writeb 0x%"PRIx64" : 0x%02"PRIx64
diff --git a/hw/ide/via.c b/hw/ide/via.c
index 5b32ecb..35c3059 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -33,6 +33,7 @@
 #include "sysemu/dma.h"
 
 #include "hw/ide/pci.h"
+#include "trace.h"
 
 static uint64_t bmdma_read(void *opaque, hwaddr addr,
                            unsigned size)
@@ -55,9 +56,8 @@ static uint64_t bmdma_read(void *opaque, hwaddr addr,
         val = 0xff;
         break;
     }
-#ifdef DEBUG_IDE
-    printf("bmdma: readb 0x%02x : 0x%02x\n", addr, val);
-#endif
+
+    trace_bmdma_read_via(addr, val);
     return val;
 }
 
@@ -70,9 +70,7 @@ static void bmdma_write(void *opaque, hwaddr addr,
         return;
     }
 
-#ifdef DEBUG_IDE
-    printf("bmdma: writeb 0x%02x : 0x%02x\n", addr, val);
-#endif
+    trace_bmdma_write_via(addr, val);
     switch (addr & 3) {
     case 0:
         bmdma_cmd_writeb(bm, val);
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 482a951..4a92f0a 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -14,7 +14,6 @@
 #include "block/scsi.h"
 
 /* debug IDE devices */
-//#define DEBUG_IDE
 //#define DEBUG_IDE_ATAPI
 //#define DEBUG_AIO
 #define USE_DMA_CDROM
-- 
2.9.5
