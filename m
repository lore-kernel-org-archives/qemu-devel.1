Received: from eggs.gnu.org ([2001:4830:134:3::10]:44616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fWDzY-0007Mj-Tp
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:48:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fWDzX-0004rB-Ts
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:48:12 -0400
From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 21 Jun 2018 21:47:51 -0700
Message-Id: <1529642871-14214-1-git-send-email-linux@roeck-us.net>
Subject: [Qemu-devel] [PATCH] ppc: Fix sam460ex devicetree when booting the
 Linux kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>

sam4660ex (or at least this emulation) does not support the "ibm,cpm" power
management. As a result, Linux crashes when trying to access it. Remove
its devicetree node. Also, if/when we boot the Linux kernel directly,
u-boot will not fix up serial frequencies in the devicetree file, and
serial port initialization will fail. Add plausible frequency values to the
first serial port to be able to use it. Disable the second serial port
since it is not available on the board.  Also set valid values for the
other clock nodes otherwise set by u-boot.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/ppc/sam460ex.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index bdc53d2..045a255 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -308,6 +308,24 @@ static int sam460ex_load_device_tree(hwaddr addr,
     qemu_fdt_setprop_cell(fdt, "/cpus/cpu@0", "timebase-frequency",
                               tb_freq);
 
+    /* Remove cpm node (not emulated) */
+    qemu_fdt_nop_node(fdt, "/cpm");
+    /* set serial port clock and speed */
+    qemu_fdt_setprop_cell(fdt, "/plb/opb/serial@ef600300", "clock-frequency",
+                              50000000);
+    qemu_fdt_setprop_cell(fdt, "/plb/opb/serial@ef600300", "current-speed",
+                              38400);
+    /* disable second serial port */
+    qemu_fdt_setprop_string(fdt, "/plb/opb/serial@ef600400", "status",
+                              "disabled");
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
