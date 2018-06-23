Received: from eggs.gnu.org ([2001:4830:134:3::10]:42726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fWXCW-0006j7-9L
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 21:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fWXCV-0004O4-BQ
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 21:18:52 -0400
From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 22 Jun 2018 18:18:41 -0700
Message-Id: <1529716721-28400-1-git-send-email-linux@roeck-us.net>
Subject: [Qemu-devel] [PATCH v2] ppc: Fix sam460ex devicetree when booting
 the Linux kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, Guenter Roeck <linux@roeck-us.net>

sam4660ex (or at least this emulation) does not support the "ibm,cpm" power
management. As a result, Linux crashes when trying to access it. Remove
its devicetree node. Also, if/when we boot the Linux kernel directly,
serial port clock frequencies in the devicetree file will be unset, and
serial port initialization will fail. Add plausible frequency values to
the serials port to be able to use it. Also set valid values for the other
clock nodes otherwise set by u-boot.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Initialize all serial nodes to match u-boot behavior more closely.
    Use direct fdt API functions and ignore errors when clearing out
    /cpm and for setting the serial port clocks.

 hw/ppc/sam460ex.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index bdc53d2..a91382c 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -37,6 +37,8 @@
 #include "hw/i2c/smbus.h"
 #include "hw/usb/hcd-ehci.h"
 
+#include <libfdt.h>
+
 #define BINARY_DEVICE_TREE_FILE "canyonlands.dtb"
 #define UBOOT_FILENAME "u-boot-sam460-20100605.bin"
 /* to extract the official U-Boot bin from the updater: */
@@ -255,6 +257,7 @@ static int sam460ex_load_device_tree(hwaddr addr,
     void *fdt;
     uint32_t tb_freq = CPU_FREQ;
     uint32_t clock_freq = CPU_FREQ;
+    int offset;
 
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, BINARY_DEVICE_TREE_FILE);
     if (!filename) {
@@ -308,6 +311,26 @@ static int sam460ex_load_device_tree(hwaddr addr,
     qemu_fdt_setprop_cell(fdt, "/cpus/cpu@0", "timebase-frequency",
                               tb_freq);
 
+    /* Remove cpm node if it exists (it is not emulated) */
+    offset = fdt_path_offset(fdt, "/cpm");
+    if (offset >= 0)
+        fdt_nop_node(fdt, offset);
+
+    /* set serial port clocks */
+    offset = fdt_node_offset_by_compatible(fdt, -1, "ns16550");
+    while (offset >= 0) {
+        fdt_setprop_cell(fdt, offset, "clock-frequency", 50000000);
+        offset = fdt_node_offset_by_compatible(fdt, offset, "ns16550");
+    }
+
+    /* some more clocks */
+    qemu_fdt_setprop_cell(fdt, "/plb", "clock-frequency",
+                              50000000);
+    qemu_fdt_setprop_cell(fdt, "/plb/opb", "clock-frequency",
+                              50000000);
+    qemu_fdt_setprop_cell(fdt, "/plb/opb/ebc", "clock-frequency",
+                              50000000);
+
     rom_add_blob_fixed(BINARY_DEVICE_TREE_FILE, fdt, fdt_size, addr);
     g_free(fdt);
     ret = fdt_size;
-- 
2.7.4
