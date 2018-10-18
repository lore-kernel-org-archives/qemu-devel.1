Received: from eggs.gnu.org ([2001:4830:134:3::10]:44050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gD9hH-0008Lk-4j
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gD9hG-0002SP-AB
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:54:47 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Thu, 18 Oct 2018 16:54:28 +0200
Message-Id: <20181018145428.31134-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v2] hw/arm/boot: introduce fdt_add_memory_node
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com
Cc: drjones@redhat.com

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

We introduce an helper to create a memory node. This avoids some
code duplication in arm_load_dtb(). Also in the future we will need
to add some more memory nodes (for DIMMs) and this helper will be
useful.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

---
v1 -> v2:
improve the commit message
---
 hw/arm/boot.c | 54 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 20c71d7d96..ba2004da5c 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -413,6 +413,36 @@ static void set_kernel_args_old(const struct arm_boot_info *info,
     }
 }
 
+static int fdt_add_memory_node(void *fdt, uint32_t acells, hwaddr mem_base,
+                               uint32_t scells, hwaddr mem_len,
+                               int numa_node_id)
+{
+    char *nodename = NULL;
+    int ret;
+
+    nodename = g_strdup_printf("/memory@%" PRIx64, mem_base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
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
@@ -492,7 +522,6 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     void *fdt = NULL;
     int size, rc, n = 0;
     uint32_t acells, scells;
-    char *nodename;
     unsigned int i;
     hwaddr mem_base, mem_len;
     char **node_path;
@@ -566,35 +595,20 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         mem_base = binfo->loader_start;
         for (i = 0; i < nb_numa_nodes; i++) {
             mem_len = numa_info[i].node_mem;
-            nodename = g_strdup_printf("/memory@%" PRIx64, mem_base);
-            qemu_fdt_add_subnode(fdt, nodename);
-            qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
-            rc = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg",
-                                              acells, mem_base,
-                                              scells, mem_len);
+            rc = fdt_add_memory_node(fdt, acells, mem_base,
+                                     scells, mem_len, i);
             if (rc < 0) {
-                fprintf(stderr, "couldn't set %s/reg for node %d\n", nodename,
-                        i);
                 goto fail;
             }
 
-            qemu_fdt_setprop_cell(fdt, nodename, "numa-node-id", i);
             mem_base += mem_len;
-            g_free(nodename);
         }
     } else {
-        nodename = g_strdup_printf("/memory@%" PRIx64, binfo->loader_start);
-        qemu_fdt_add_subnode(fdt, nodename);
-        qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
-
-        rc = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg",
-                                          acells, binfo->loader_start,
-                                          scells, binfo->ram_size);
+        rc = fdt_add_memory_node(fdt, acells, binfo->loader_start,
+                                 scells, binfo->ram_size, -1);
         if (rc < 0) {
-            fprintf(stderr, "couldn't set %s reg\n", nodename);
             goto fail;
         }
-        g_free(nodename);
     }
 
     rc = fdt_path_offset(fdt, "/chosen");
-- 
2.17.1
