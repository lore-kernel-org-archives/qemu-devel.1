Received: from eggs.gnu.org ([2001:4830:134:3::10]:37018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1du68r-0005bR-Qd
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 20:11:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1du68q-0004T9-C5
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 20:11:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1du68q-0004Sg-4A
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 20:11:56 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 18 Sep 2017 20:11:38 -0400
Message-Id: <20170919001147.23182-6-jsnow@redhat.com>
In-Reply-To: <20170919001147.23182-1-jsnow@redhat.com>
References: <20170919001147.23182-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 04/13] IDE: Add register hints to tracing
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

Name the registers for tracing purposes.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20170901001502.29915-3-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/core.c       | 88 +++++++++++++++++++++++++++++++++++++++++------------
 hw/ide/trace-events |  8 ++---
 2 files changed, 72 insertions(+), 24 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 31fd593..cb250e6 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -1185,13 +1185,37 @@ static void ide_clear_hob(IDEBus *bus)
     bus->ifs[1].select &= ~(1 << 7);
 }
 
+/* IOport [W]rite [R]egisters */
+enum ATA_IOPORT_WR {
+    ATA_IOPORT_WR_DATA = 0,
+    ATA_IOPORT_WR_FEATURES = 1,
+    ATA_IOPORT_WR_SECTOR_COUNT = 2,
+    ATA_IOPORT_WR_SECTOR_NUMBER = 3,
+    ATA_IOPORT_WR_CYLINDER_LOW = 4,
+    ATA_IOPORT_WR_CYLINDER_HIGH = 5,
+    ATA_IOPORT_WR_DEVICE_HEAD = 6,
+    ATA_IOPORT_WR_COMMAND = 7,
+    ATA_IOPORT_WR_NUM_REGISTERS,
+};
+
+const char *ATA_IOPORT_WR_lookup[ATA_IOPORT_WR_NUM_REGISTERS] = {
+    [ATA_IOPORT_WR_DATA] = "Data",
+    [ATA_IOPORT_WR_FEATURES] = "Features",
+    [ATA_IOPORT_WR_SECTOR_COUNT] = "Sector Count",
+    [ATA_IOPORT_WR_SECTOR_NUMBER] = "Sector Number",
+    [ATA_IOPORT_WR_CYLINDER_LOW] = "Cylinder Low",
+    [ATA_IOPORT_WR_CYLINDER_HIGH] = "Cylinder High",
+    [ATA_IOPORT_WR_DEVICE_HEAD] = "Device/Head",
+    [ATA_IOPORT_WR_COMMAND] = "Command"
+};
+
 void ide_ioport_write(void *opaque, uint32_t addr, uint32_t val)
 {
     IDEBus *bus = opaque;
     IDEState *s = idebus_active_if(bus);
     int reg_num = addr & 7;
 
-    trace_ide_ioport_write(addr, val, bus, s);
+    trace_ide_ioport_write(addr, ATA_IOPORT_WR_lookup[reg_num], val, bus, s);
 
     /* ignore writes to command block while busy with previous command */
     if (reg_num != 7 && (s->status & (BUSY_STAT|DRQ_STAT))) {
@@ -1201,43 +1225,43 @@ void ide_ioport_write(void *opaque, uint32_t addr, uint32_t val)
     switch (reg_num) {
     case 0:
         break;
-    case 1:
-	ide_clear_hob(bus);
+    case ATA_IOPORT_WR_FEATURES:
+        ide_clear_hob(bus);
         /* NOTE: data is written to the two drives */
-	bus->ifs[0].hob_feature = bus->ifs[0].feature;
-	bus->ifs[1].hob_feature = bus->ifs[1].feature;
+        bus->ifs[0].hob_feature = bus->ifs[0].feature;
+        bus->ifs[1].hob_feature = bus->ifs[1].feature;
         bus->ifs[0].feature = val;
         bus->ifs[1].feature = val;
         break;
-    case 2:
+    case ATA_IOPORT_WR_SECTOR_COUNT:
 	ide_clear_hob(bus);
 	bus->ifs[0].hob_nsector = bus->ifs[0].nsector;
 	bus->ifs[1].hob_nsector = bus->ifs[1].nsector;
         bus->ifs[0].nsector = val;
         bus->ifs[1].nsector = val;
         break;
-    case 3:
+    case ATA_IOPORT_WR_SECTOR_NUMBER:
 	ide_clear_hob(bus);
 	bus->ifs[0].hob_sector = bus->ifs[0].sector;
 	bus->ifs[1].hob_sector = bus->ifs[1].sector;
         bus->ifs[0].sector = val;
         bus->ifs[1].sector = val;
         break;
-    case 4:
+    case ATA_IOPORT_WR_CYLINDER_LOW:
 	ide_clear_hob(bus);
 	bus->ifs[0].hob_lcyl = bus->ifs[0].lcyl;
 	bus->ifs[1].hob_lcyl = bus->ifs[1].lcyl;
         bus->ifs[0].lcyl = val;
         bus->ifs[1].lcyl = val;
         break;
-    case 5:
+    case ATA_IOPORT_WR_CYLINDER_HIGH:
 	ide_clear_hob(bus);
 	bus->ifs[0].hob_hcyl = bus->ifs[0].hcyl;
 	bus->ifs[1].hob_hcyl = bus->ifs[1].hcyl;
         bus->ifs[0].hcyl = val;
         bus->ifs[1].hcyl = val;
         break;
-    case 6:
+    case ATA_IOPORT_WR_DEVICE_HEAD:
 	/* FIXME: HOB readback uses bit 7 */
         bus->ifs[0].select = (val & ~0x10) | 0xa0;
         bus->ifs[1].select = (val | 0x10) | 0xa0;
@@ -1245,7 +1269,7 @@ void ide_ioport_write(void *opaque, uint32_t addr, uint32_t val)
         bus->unit = (val >> 4) & 1;
         break;
     default:
-    case 7:
+    case ATA_IOPORT_WR_COMMAND:
         /* command */
         ide_exec_cmd(bus, val);
         break;
@@ -2052,6 +2076,30 @@ void ide_exec_cmd(IDEBus *bus, uint32_t val)
     }
 }
 
+/* IOport [R]ead [R]egisters */
+enum ATA_IOPORT_RR {
+    ATA_IOPORT_RR_DATA = 0,
+    ATA_IOPORT_RR_ERROR = 1,
+    ATA_IOPORT_RR_SECTOR_COUNT = 2,
+    ATA_IOPORT_RR_SECTOR_NUMBER = 3,
+    ATA_IOPORT_RR_CYLINDER_LOW = 4,
+    ATA_IOPORT_RR_CYLINDER_HIGH = 5,
+    ATA_IOPORT_RR_DEVICE_HEAD = 6,
+    ATA_IOPORT_RR_STATUS = 7,
+    ATA_IOPORT_RR_NUM_REGISTERS,
+};
+
+const char *ATA_IOPORT_RR_lookup[ATA_IOPORT_RR_NUM_REGISTERS] = {
+    [ATA_IOPORT_RR_DATA] = "Data",
+    [ATA_IOPORT_RR_ERROR] = "Error",
+    [ATA_IOPORT_RR_SECTOR_COUNT] = "Sector Count",
+    [ATA_IOPORT_RR_SECTOR_NUMBER] = "Sector Number",
+    [ATA_IOPORT_RR_CYLINDER_LOW] = "Cylinder Low",
+    [ATA_IOPORT_RR_CYLINDER_HIGH] = "Cylinder High",
+    [ATA_IOPORT_RR_DEVICE_HEAD] = "Device/Head",
+    [ATA_IOPORT_RR_STATUS] = "Status"
+};
+
 uint32_t ide_ioport_read(void *opaque, uint32_t addr)
 {
     IDEBus *bus = opaque;
@@ -2064,10 +2112,10 @@ uint32_t ide_ioport_read(void *opaque, uint32_t addr)
     //hob = s->select & (1 << 7);
     hob = 0;
     switch (reg_num) {
-    case 0:
+    case ATA_IOPORT_RR_DATA:
         ret = 0xff;
         break;
-    case 1:
+    case ATA_IOPORT_RR_ERROR:
         if ((!bus->ifs[0].blk && !bus->ifs[1].blk) ||
             (s != bus->ifs && !s->blk)) {
             ret = 0;
@@ -2077,7 +2125,7 @@ uint32_t ide_ioport_read(void *opaque, uint32_t addr)
 	    ret = s->hob_feature;
         }
         break;
-    case 2:
+    case ATA_IOPORT_RR_SECTOR_COUNT:
         if (!bus->ifs[0].blk && !bus->ifs[1].blk) {
             ret = 0;
         } else if (!hob) {
@@ -2086,7 +2134,7 @@ uint32_t ide_ioport_read(void *opaque, uint32_t addr)
 	    ret = s->hob_nsector;
         }
         break;
-    case 3:
+    case ATA_IOPORT_RR_SECTOR_NUMBER:
         if (!bus->ifs[0].blk && !bus->ifs[1].blk) {
             ret = 0;
         } else if (!hob) {
@@ -2095,7 +2143,7 @@ uint32_t ide_ioport_read(void *opaque, uint32_t addr)
 	    ret = s->hob_sector;
         }
         break;
-    case 4:
+    case ATA_IOPORT_RR_CYLINDER_LOW:
         if (!bus->ifs[0].blk && !bus->ifs[1].blk) {
             ret = 0;
         } else if (!hob) {
@@ -2104,7 +2152,7 @@ uint32_t ide_ioport_read(void *opaque, uint32_t addr)
 	    ret = s->hob_lcyl;
         }
         break;
-    case 5:
+    case ATA_IOPORT_RR_CYLINDER_HIGH:
         if (!bus->ifs[0].blk && !bus->ifs[1].blk) {
             ret = 0;
         } else if (!hob) {
@@ -2113,7 +2161,7 @@ uint32_t ide_ioport_read(void *opaque, uint32_t addr)
 	    ret = s->hob_hcyl;
         }
         break;
-    case 6:
+    case ATA_IOPORT_RR_DEVICE_HEAD:
         if (!bus->ifs[0].blk && !bus->ifs[1].blk) {
             ret = 0;
         } else {
@@ -2121,7 +2169,7 @@ uint32_t ide_ioport_read(void *opaque, uint32_t addr)
         }
         break;
     default:
-    case 7:
+    case ATA_IOPORT_RR_STATUS:
         if ((!bus->ifs[0].blk && !bus->ifs[1].blk) ||
             (s != bus->ifs && !s->blk)) {
             ret = 0;
@@ -2132,7 +2180,7 @@ uint32_t ide_ioport_read(void *opaque, uint32_t addr)
         break;
     }
 
-    trace_ide_ioport_read(addr, ret, bus, s);
+    trace_ide_ioport_read(addr, ATA_IOPORT_RR_lookup[reg_num], ret, bus, s);
     return ret;
 }
 
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index b9792812..bff8f39 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -2,10 +2,10 @@
 
 # hw/ide/core.c
 # portio
-ide_ioport_read(uint32_t addr, uint32_t val, void *bus, void *s)  "IDE PIO rd @ 0x%"PRIx32"; val 0x%02"PRIx32"; bus %p IDEState %p"
-ide_ioport_write(uint32_t addr, uint32_t val, void *bus, void *s) "IDE PIO wr @ 0x%"PRIx32"; val 0x%02"PRIx32"; bus %p IDEState %p"
-ide_status_read(uint32_t addr, uint32_t val, void *bus, void *s)  "IDE PIO rd @ 0x%"PRIx32" (Alt Status); val 0x%02"PRIx32"; bus %p; IDEState %p"
-ide_cmd_write(uint32_t addr, uint32_t val, void *bus)             "IDE PIO wr @ 0x%"PRIx32" (Device Control); val 0x%02"PRIx32"; bus %p"
+ide_ioport_read(uint32_t addr, const char *reg, uint32_t val, void *bus, void *s)  "IDE PIO rd @ 0x%"PRIx32" (%s); val 0x%02"PRIx32"; bus %p IDEState %p"
+ide_ioport_write(uint32_t addr, const char *reg, uint32_t val, void *bus, void *s) "IDE PIO wr @ 0x%"PRIx32" (%s); val 0x%02"PRIx32"; bus %p IDEState %p"
+ide_status_read(uint32_t addr, uint32_t val, void *bus, void *s)                   "IDE PIO rd @ 0x%"PRIx32" (Alt Status); val 0x%02"PRIx32"; bus %p; IDEState %p"
+ide_cmd_write(uint32_t addr, uint32_t val, void *bus)                              "IDE PIO wr @ 0x%"PRIx32" (Device Control); val 0x%02"PRIx32"; bus %p"
 # misc
 ide_exec_cmd(void *bus, void *state, uint32_t cmd) "IDE exec cmd: bus %p; state %p; cmd 0x%02x"
 ide_cancel_dma_sync_buffered(void *fn, void *req) "invoking cb %p of buffered request %p with -ECANCELED"
-- 
2.9.5
