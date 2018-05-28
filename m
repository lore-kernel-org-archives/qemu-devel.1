Received: from eggs.gnu.org ([2001:4830:134:3::10]:53744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNBO1-00082b-UA
	for qemu-devel@nongnu.org; Mon, 28 May 2018 02:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNBNw-0007TF-V2
	for qemu-devel@nongnu.org; Mon, 28 May 2018 02:12:05 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:39213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNBNw-0007T0-Qb
	for qemu-devel@nongnu.org; Mon, 28 May 2018 02:12:00 -0400
Received: by mail-qt0-x242.google.com with SMTP id f1-v6so13711949qtj.6
	for <qemu-devel@nongnu.org>; Sun, 27 May 2018 23:12:00 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 28 May 2018 03:11:54 -0300
Message-Id: <20180528061154.25367-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH] hw/misc/unimp: Add
 create_unimplemented_subregion_device()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Alexey Korolev <akorolex@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

The create_unimplemented_device() function is very useful to
register unimplemented devices to the SysBus 'absolute' address.

Some devices are modelled as container of memory subregions,
the subregions being mmio-mapped relatively to the container
base address.

With these container devices, the current create_unimplemented_device()
does not work.
Add a function to remove the current limitation, and allow
containerized devices to use the helpful UnimplementedDevice.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
I don't like the function name much, I first tried with
create_unimplemented_device_mr() :( Would it be cleaner renaming current
create_unimplemented_device() -> create_unimplemented_sysbus_device()?

Also, is this useful to have this code inlined?
---
 include/hw/misc/unimp.h | 42 +++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/include/hw/misc/unimp.h b/include/hw/misc/unimp.h
index 2a291ca42d..7ae1ace885 100644
--- a/include/hw/misc/unimp.h
+++ b/include/hw/misc/unimp.h
@@ -23,9 +23,12 @@ typedef struct {
 } UnimplementedDeviceState;
 
 /**
- * create_unimplemented_device: create and map a dummy device
+ * create_unimplemented_subregion_device: create and map a dummy device
+ *
+ * @mr: the #MemoryRegion to contain the new device.
  * @name: name of the device for debug logging
- * @base: base address of the device's MMIO region
+ * @addr: base address of the device's MMIO region, or
+ *        offset relative to @mr where the device is added.
  * @size: size of the device's MMIO region
  *
  * This utility function creates and maps an instance of unimplemented-device,
@@ -35,9 +38,10 @@ typedef struct {
  * use it to cover a large region and then map other devices on top of it
  * if necessary.
  */
-static inline void create_unimplemented_device(const char *name,
-                                               hwaddr base,
-                                               hwaddr size)
+static inline void create_unimplemented_subregion_device(MemoryRegion *mr,
+                                                         const char *name,
+                                                         hwaddr addr,
+                                                         hwaddr size)
 {
     DeviceState *dev = qdev_create(NULL, TYPE_UNIMPLEMENTED_DEVICE);
 
@@ -45,7 +49,33 @@ static inline void create_unimplemented_device(const char *name,
     qdev_prop_set_uint64(dev, "size", size);
     qdev_init_nofail(dev);
 
-    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(dev), 0, base, -1000);
+    if (mr) {
+        MemoryRegion *submr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+        memory_region_add_subregion_overlap(mr, addr, submr, -1000);
+    } else {
+        sysbus_mmio_map_overlap(SYS_BUS_DEVICE(dev), 0, addr, -1000);
+    }
+}
+
+/**
+ * create_unimplemented_device: create and map a dummy SysBus device
+ *
+ * @name: name of the device for debug logging
+ * @base: base address of the device's MMIO region
+ * @size: size of the device's MMIO region
+ *
+ * This utility function creates and maps an instance of unimplemented-device,
+ * which is a dummy device which simply logs all guest accesses to
+ * it via the qemu_log LOG_UNIMP debug log.
+ * The device is mapped at priority -1000, which means that you can
+ * use it to cover a large region and then map other devices on top of it
+ * if necessary.
+ */
+static inline void create_unimplemented_device(const char *name,
+                                               hwaddr base,
+                                               hwaddr size)
+{
+    create_unimplemented_subregion_device(NULL, name, base, size);
 }
 
 #endif
-- 
2.17.0
