Received: from eggs.gnu.org ([2001:4830:134:3::10]:41119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1gWYRy-0003PX-OH
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 22:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1gWYRy-0005Xn-1V
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 22:11:10 -0500
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 11 Dec 2018 13:40:43 +1030
Message-Id: <20181211031044.27628-2-joel@jms.id.au>
In-Reply-To: <20181211031044.27628-1-joel@jms.id.au>
References: <20181211031044.27628-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/2] aspeed: Add syscon-poweroff to guest
 device tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

This adds a node to the guest's device tree that allows it to cause Qemu
to exit when the guest shuts down.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/arm/aspeed.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 515898548284..00060d44ad51 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -21,8 +21,10 @@
 #include "hw/i2c/smbus.h"
 #include "qemu/log.h"
 #include "sysemu/block-backend.h"
+#include "sysemu/device_tree.h"
 #include "hw/loader.h"
 #include "qemu/error-report.h"
+#include <libfdt.h>
 
 static struct arm_boot_info aspeed_board_binfo = {
     .board_id = -1, /* device-tree-only board */
@@ -126,6 +128,36 @@ static void write_boot_rom(DriveInfo *dinfo, hwaddr addr, size_t rom_size,
     g_free(storage);
 }
 
+static void fdt_add_shutdown_node(void *fdt)
+{
+    const char *nodename = "/syscon-poweroff";
+    uint32_t phandle;
+    int offset;
+
+    /* Find the scu phandle */
+    offset = fdt_path_offset(fdt, "/ahb/apb/syscon@1e6e2000");
+    if (offset < 0) {
+        error_report("%s couldn't find syscon, guest shutdown unavailable: %s",
+                     __func__, fdt_strerror(offset));
+        return;
+    }
+    phandle = fdt_get_phandle(fdt, offset);
+
+    /* Add syscon-poweroff node and use 0x1A0, an un-used SCU register */
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "syscon-poweroff");
+    qemu_fdt_setprop_cells(fdt, nodename, "regmap", phandle);
+    qemu_fdt_setprop_cells(fdt, nodename, "offset", 0x1A0);
+    qemu_fdt_setprop_cells(fdt, nodename, "value", 1);
+}
+
+static void aspeed_board_modify_dtb(const struct arm_boot_info *binfo,
+                                    void *fdt)
+{
+    fdt_add_shutdown_node(fdt);
+}
+
+
 static void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
                                       Error **errp)
 {
@@ -228,6 +260,7 @@ static void aspeed_board_init(MachineState *machine,
     aspeed_board_binfo.kernel_cmdline = machine->kernel_cmdline;
     aspeed_board_binfo.ram_size = ram_size;
     aspeed_board_binfo.loader_start = sc->info->sdram_base;
+    aspeed_board_binfo.modify_dtb = aspeed_board_modify_dtb;
 
     if (cfg->i2c_init) {
         cfg->i2c_init(bmc);
-- 
2.19.1
