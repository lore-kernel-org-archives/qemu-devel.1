Received: from eggs.gnu.org ([209.51.188.92]:46349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gjcg2-0006BI-4P
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 23:19:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gjcfz-0004Cv-1c
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 23:19:40 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 16 Jan 2019 15:19:16 +1100
Message-Id: <20190116041916.130523-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] spapr: Fix fdt warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org

The FDT blob which the spapr machine renders at reset time produces
warnings like this:

my-181211-154309.dts: Warning (unit_address_format): Node /memory@0000000080000000 unit name should not have leading 0s
my-181211-154309.dts: Warning (unit_address_format): Node /memory@0000000040000000 unit name should not have leading 0s
my-181211-154309.dts: Warning (unit_address_format): Node /memory@0000000020000000 unit name should not have leading 0s
my-181211-154309.dts: Warning (unit_address_format): Node /memory@0000000010000000 unit name should not have leading 0s
my-181211-154309.dts: Warning (unit_address_format): Node /memory@0000000000000000 unit name should not have leading 0s

because TARGET_FMT_lx is defined as "%016"PRIx64.

This uses simple "%lx" to suppress the warning. Since it is spapr which
is always 64bit, we assume here that hwaddr is always "long".

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/ppc/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 83081de..37cdadb 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -375,7 +375,7 @@ static int spapr_populate_memory_node(void *fdt, int nodeid, hwaddr start,
     mem_reg_property[0] = cpu_to_be64(start);
     mem_reg_property[1] = cpu_to_be64(size);
 
-    sprintf(mem_name, "memory@" TARGET_FMT_lx, start);
+    sprintf(mem_name, "memory@%lx", start);
     off = fdt_add_subnode(fdt, 0, mem_name);
     _FDT(off);
     _FDT((fdt_setprop_string(fdt, off, "device_type", "memory")));
-- 
2.17.1
