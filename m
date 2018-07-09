Received: from eggs.gnu.org ([2001:4830:134:3::10]:44338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQqB-00055u-5g
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQqA-0002H5-0G
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:11 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  9 Jul 2018 17:43:49 +1000
Message-Id: <20180709074350.27086-16-david@gibson.dropbear.id.au>
In-Reply-To: <20180709074350.27086-1-david@gibson.dropbear.id.au>
References: <20180709074350.27086-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 15/16] sam460ex: Don't check for errors from
 qemu_fdt_*()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The qemu_fdt_*() helper functions already exit with a message instead of
returning errors, so we don't need to check for errors in the caller.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/sam460ex.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 1661e036f3..8194f32cd3 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -276,32 +276,18 @@ static int sam460ex_load_device_tree(hwaddr addr,
 
     /* Manipulate device tree in memory. */
 
-    ret = qemu_fdt_setprop(fdt, "/memory", "reg", mem_reg_property,
-                               sizeof(mem_reg_property));
-    if (ret < 0) {
-        error_report("couldn't set /memory/reg");
-    }
+    qemu_fdt_setprop(fdt, "/memory", "reg", mem_reg_property,
+                     sizeof(mem_reg_property));
 
     /* default FDT doesn't have a /chosen node... */
     qemu_fdt_add_subnode(fdt, "/chosen");
 
-    ret = qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start",
-                                    initrd_base);
-    if (ret < 0) {
-        error_report("couldn't set /chosen/linux,initrd-start");
-    }
+    qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start", initrd_base);
 
-    ret = qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
-                                    (initrd_base + initrd_size));
-    if (ret < 0) {
-        error_report("couldn't set /chosen/linux,initrd-end");
-    }
+    qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
+                          (initrd_base + initrd_size));
 
-    ret = qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
-                                      kernel_cmdline);
-    if (ret < 0) {
-        error_report("couldn't set /chosen/bootargs");
-    }
+    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", kernel_cmdline);
 
     /* Copy data from the host device tree into the guest. Since the guest can
      * directly access the timebase without host involvement, we must expose
-- 
2.17.1
