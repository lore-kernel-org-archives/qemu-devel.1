Received: from eggs.gnu.org ([2001:4830:134:3::10]:37834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1faFuW-0005J0-Pn
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 03:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1faFuT-0004gg-Ko
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 03:39:40 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue,  3 Jul 2018 09:19:57 +0200
Message-Id: <1530602398-16127-15-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1530602398-16127-1-git-send-email-eric.auger@redhat.com>
References: <1530602398-16127-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v3 14/15] hw/arm/boot: Expose the pmem nodes in
 the DT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com
Cc: dgilbert@redhat.com, agraf@suse.de, david@gibson.dropbear.id.au, drjones@redhat.com, wei@redhat.com

In case of NV-DIMM slots, let's add /pmem DT nodes.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/boot.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 2c7d558..3381c66 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -444,6 +444,36 @@ out:
     return ret;
 }
 
+static int fdt_add_pmem_node(void *fdt, uint32_t acells, hwaddr mem_base,
+                             uint32_t scells, hwaddr mem_len,
+                             int numa_node_id)
+{
+    char *nodename = NULL;
+    int ret;
+
+    nodename = g_strdup_printf("/pmem@%" PRIx64, mem_base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "pmem-region");
+    ret = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg", acells, mem_base,
+                                       scells, mem_len);
+    if (ret < 0) {
+        fprintf(stderr, "couldn't set %s/reg\n", nodename);
+        goto out;
+    }
+    if (numa_node_id < 0) {
+        goto out;
+    }
+
+    ret = qemu_fdt_setprop_cell(fdt, nodename, "numa-node-id", numa_node_id);
+    if (ret < 0) {
+        fprintf(stderr, "couldn't set %s/numa-node-id\n", nodename);
+    }
+
+out:
+    g_free(nodename);
+    return ret;
+}
+
 static void fdt_add_psci_node(void *fdt)
 {
     uint32_t cpu_suspend_fn;
@@ -532,7 +562,8 @@ static int fdt_add_hotpluggable_memory_nodes(void *fdt,
         di = !is_nvdimm ? mi->u.dimm.data : mi->u.nvdimm.data;
 
         if (is_nvdimm) {
-            ret = -ENOENT; /* NV-DIMM not yet supported */
+            ret = fdt_add_pmem_node(fdt, acells, di->addr,
+                                    scells, di->size, di->node);
         } else {
             ret = fdt_add_memory_node(fdt, acells, di->addr,
                                       scells, di->size, di->node);
-- 
2.5.5
