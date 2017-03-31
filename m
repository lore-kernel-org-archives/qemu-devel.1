Received: from eggs.gnu.org ([2001:4830:134:3::10]:56552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1ctzjN-0004v8-CV
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 12:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1ctzjJ-0004qN-MX
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 12:48:57 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gsomlo@gmail.com>) id 1ctzjJ-0004pv-I7
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 12:48:53 -0400
Received: by mail-qt0-x243.google.com with SMTP id n37so10938424qtb.3
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 09:48:53 -0700 (PDT)
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
Date: Fri, 31 Mar 2017 12:48:40 -0400
Message-Id: <1490978921-3782-3-git-send-email-gsomlo@gmail.com>
In-Reply-To: <1490978921-3782-1-git-send-email-gsomlo@gmail.com>
References: <1490978921-3782-1-git-send-email-gsomlo@gmail.com>
Subject: [Qemu-devel] [PATCH v1 2/3] applesmc: consolidate port i/o into
 single contiguous region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: agraf@suse.de, eshelton@pobox.com

Newer AppleSMC revisions support an error status (read) port
in addition to the data and command ports currently supported.

Register the full 32-bit region at once, and handle individual
ports at various offsets within the region from the top-level
applesmc_io_[write|read]() methods (ctual support for reading
the error status port to be added by a subsequent patch).

Originally proposed by Eric Shelton <eshelton@pobox.com>

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 hw/misc/applesmc.c | 56 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 986f2ac..e581e02 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -75,8 +75,7 @@ typedef struct AppleSMCState AppleSMCState;
 struct AppleSMCState {
     ISADevice parent_obj;
 
-    MemoryRegion io_data;
-    MemoryRegion io_cmd;
+    MemoryRegion io_reg;
     uint32_t iobase;
     uint8_t cmd;
     uint8_t status;
@@ -207,19 +206,36 @@ static void qdev_applesmc_isa_reset(DeviceState *dev)
     applesmc_add_key(s, "MSSD", 1, "\0x3");
 }
 
-static const MemoryRegionOps applesmc_data_io_ops = {
-    .write = applesmc_io_data_write,
-    .read = applesmc_io_data_read,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .impl = {
-        .min_access_size = 1,
-        .max_access_size = 1,
-    },
-};
+static void applesmc_io_write(void *opaque, hwaddr addr, uint64_t val,
+                              unsigned size)
+{
+    switch (addr) {
+    case APPLESMC_DATA_PORT:
+        applesmc_io_data_write(opaque, addr, val, size);
+        break;
+    case APPLESMC_CMD_PORT:
+        applesmc_io_cmd_write(opaque, addr, val, size);
+        break;
+    default:
+        break;
+    }
+}
 
-static const MemoryRegionOps applesmc_cmd_io_ops = {
-    .write = applesmc_io_cmd_write,
-    .read = applesmc_io_cmd_read,
+static uint64_t applesmc_io_read(void *opaque, hwaddr addr, unsigned size)
+{
+    switch (addr) {
+    case APPLESMC_DATA_PORT:
+        return applesmc_io_data_read(opaque, addr, size);
+    case APPLESMC_CMD_PORT:
+        return applesmc_io_cmd_read(opaque, addr, size);
+    default:
+        return 0xff;
+    }
+}
+
+static const MemoryRegionOps applesmc_io_ops = {
+    .write = applesmc_io_write,
+    .read = applesmc_io_read,
     .endianness = DEVICE_NATIVE_ENDIAN,
     .impl = {
         .min_access_size = 1,
@@ -231,15 +247,9 @@ static void applesmc_isa_realize(DeviceState *dev, Error **errp)
 {
     AppleSMCState *s = APPLE_SMC(dev);
 
-    memory_region_init_io(&s->io_data, OBJECT(s), &applesmc_data_io_ops, s,
-                          "applesmc-data", 4);
-    isa_register_ioport(&s->parent_obj, &s->io_data,
-                        s->iobase + APPLESMC_DATA_PORT);
-
-    memory_region_init_io(&s->io_cmd, OBJECT(s), &applesmc_cmd_io_ops, s,
-                          "applesmc-cmd", 4);
-    isa_register_ioport(&s->parent_obj, &s->io_cmd,
-                        s->iobase + APPLESMC_CMD_PORT);
+    memory_region_init_io(&s->io_reg, OBJECT(s), &applesmc_io_ops, s,
+                          "applesmc", APPLESMC_NUM_PORTS);
+    isa_register_ioport(&s->parent_obj, &s->io_reg, s->iobase);
 
     if (!s->osk || (strlen(s->osk) != 64)) {
         fprintf(stderr, "WARNING: Using AppleSMC with invalid key\n");
-- 
2.7.4
