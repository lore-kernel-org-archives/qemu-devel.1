Received: from eggs.gnu.org ([2001:4830:134:3::10]:39376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gWavo-0001tc-2g
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 00:50:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gWavn-0003x5-3l
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 00:50:07 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue, 11 Dec 2018 16:49:26 +1100
Message-Id: <20181211054926.56717-4-aik@ozlabs.ru>
In-Reply-To: <20181211054926.56717-1-aik@ozlabs.ru>
References: <20181211054926.56717-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu 3/3] spapr: Fix fdt warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>

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
index 984bf32..be565f0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -376,7 +376,7 @@ static int spapr_populate_memory_node(void *fdt, int nodeid, hwaddr start,
     mem_reg_property[0] = cpu_to_be64(start);
     mem_reg_property[1] = cpu_to_be64(size);
 
-    sprintf(mem_name, "memory@" TARGET_FMT_lx, start);
+    sprintf(mem_name, "memory@%lx", start);
     off = fdt_add_subnode(fdt, 0, mem_name);
     _FDT(off);
     _FDT((fdt_setprop_string(fdt, off, "device_type", "memory")));
-- 
2.17.1
