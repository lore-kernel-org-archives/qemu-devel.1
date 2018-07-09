Received: from eggs.gnu.org ([2001:4830:134:3::10]:44383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQqC-00057Y-AH
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQqA-0002I9-SD
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:12 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  9 Jul 2018 17:43:48 +1000
Message-Id: <20180709074350.27086-15-david@gibson.dropbear.id.au>
In-Reply-To: <20180709074350.27086-1-david@gibson.dropbear.id.au>
References: <20180709074350.27086-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 14/16] sam460ex: Check for errors from libfdt
 functions
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

In a couple of places sam460ex_load_device_tree() calls "raw" libfdt
functions which can fail, but doesn't check for error codes.  At best,
if these fail the guest will be silently started in a non-standard state,
or it could fail entirely.

Fix this by using the _FDT() helper macro which aborts on a libfdt failure.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/sam460ex.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 7eed2ec601..1661e036f3 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -36,6 +36,7 @@
 #include "hw/i2c/ppc4xx_i2c.h"
 #include "hw/i2c/smbus.h"
 #include "hw/usb/hcd-ehci.h"
+#include "hw/ppc/fdt.h"
 
 #include <libfdt.h>
 
@@ -318,13 +319,13 @@ static int sam460ex_load_device_tree(hwaddr addr,
     /* Remove cpm node if it exists (it is not emulated) */
     offset = fdt_path_offset(fdt, "/cpm");
     if (offset >= 0) {
-        fdt_nop_node(fdt, offset);
+        _FDT(fdt_nop_node(fdt, offset));
     }
 
     /* set serial port clocks */
     offset = fdt_node_offset_by_compatible(fdt, -1, "ns16550");
     while (offset >= 0) {
-        fdt_setprop_cell(fdt, offset, "clock-frequency", UART_FREQ);
+        _FDT(fdt_setprop_cell(fdt, offset, "clock-frequency", UART_FREQ));
         offset = fdt_node_offset_by_compatible(fdt, offset, "ns16550");
     }
 
-- 
2.17.1
