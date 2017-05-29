Received: from eggs.gnu.org ([2001:4830:134:3::10]:48173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dFOcE-0005M1-W9
	for qemu-devel@nongnu.org; Mon, 29 May 2017 13:38:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dFOcE-0002SF-58
	for qemu-devel@nongnu.org; Mon, 29 May 2017 13:38:03 -0400
From: Andrew Jones <drjones@redhat.com>
Date: Mon, 29 May 2017 19:37:51 +0200
Message-Id: <20170529173751.3443-3-drjones@redhat.com>
In-Reply-To: <20170529173751.3443-1-drjones@redhat.com>
References: <20170529173751.3443-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] hw/arm/virt: fdt: generate distance-map
 when needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: zhaoshenglong@huawei.com, peter.maydell@linaro.org

This is based on patch Shannon Zhao originally posted.

Cc: Shannon Zhao <zhaoshenglong@huawei.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 hw/arm/virt.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index c7c8159dfd59..4db2d4207cf2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -219,6 +219,27 @@ static void create_fdt(VirtMachineState *vms)
                                 "clk24mhz");
     qemu_fdt_setprop_cell(fdt, "/apb-pclk", "phandle", vms->clock_phandle);
 
+    if (have_numa_distance) {
+        int size = nb_numa_nodes * nb_numa_nodes * 3 * sizeof(uint32_t);
+        uint32_t *matrix = g_malloc0(size);
+        int idx, i, j;
+
+        for (i = 0; i < nb_numa_nodes; i++) {
+            for (j = 0; j < nb_numa_nodes; j++) {
+                idx = (i * nb_numa_nodes + j) * 3;
+                matrix[idx + 0] = cpu_to_be32(i);
+                matrix[idx + 1] = cpu_to_be32(j);
+                matrix[idx + 2] = cpu_to_be32(numa_info[i].distance[j]);
+            }
+        }
+
+        qemu_fdt_add_subnode(fdt, "/distance-map");
+        qemu_fdt_setprop_string(fdt, "/distance-map", "compatible",
+                                "numa-distance-map-v1");
+        qemu_fdt_setprop(fdt, "/distance-map", "distance-matrix",
+                         matrix, size);
+        g_free(matrix);
+    }
 }
 
 static void fdt_add_psci_node(const VirtMachineState *vms)
-- 
2.9.4
