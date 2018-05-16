Received: from eggs.gnu.org ([2001:4830:134:3::10]:54199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1fIyFt-0007vD-Kv
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1fIyFs-0005rW-C5
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:22:17 -0400
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Date: Wed, 16 May 2018 16:20:24 +0100
Message-ID: <20180516152026.2920-5-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20180516152026.2920-1-shameerali.kolothum.thodi@huawei.com>
References: <20180516152026.2920-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v2 4/6] hw/arm: Changes required to accommodate
 non-contiguous DT mem nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: drjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, eric.auger@redhat.com, zhaoshenglong@huawei.com, jonathan.cameron@huawei.com, linuxarm@huawei.com, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

This makes changes to the DT mem node creation such that its easier
to add non-contiguous mem modeled as non-pluggable and a pc-dimm
mem later.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/boot.c        | 91 ++++++++++++++++++++++++++++++++++++----------------
 include/hw/arm/arm.h | 12 +++++++
 2 files changed, 75 insertions(+), 28 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 26184bc..73db0aa 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -486,6 +486,27 @@ static void fdt_add_psci_node(void *fdt)
     qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);
 }
 
+static char *create_memory_fdt(void *fdt, uint32_t acells, hwaddr mem_base,
+                                          uint32_t scells, hwaddr mem_len)
+{
+    char *nodename = NULL;
+    int rc;
+
+    nodename = g_strdup_printf("/memory@%" PRIx64, mem_base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
+    rc = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg", acells, mem_base,
+                                      scells, mem_len);
+    if (rc < 0) {
+        fprintf(stderr, "couldn't set %s/reg\n", nodename);
+        g_free(nodename);
+        return NULL;
+    }
+
+    return nodename;
+}
+
+
 /**
  * load_dtb() - load a device tree binary image into memory
  * @addr:       the address to load the image at
@@ -567,50 +588,64 @@ static int load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         goto fail;
     }
 
+    /*
+     * Turn the /memory node created before into a NOP node, then create
+     * /memory@addr nodes for all numa nodes respectively.
+     */
+    qemu_fdt_nop_node(fdt, "/memory");
+
     if (nb_numa_nodes > 0) {
-        /*
-         * Turn the /memory node created before into a NOP node, then create
-         * /memory@addr nodes for all numa nodes respectively.
-         */
-        qemu_fdt_nop_node(fdt, "/memory");
+        hwaddr mem_sz;
+
         mem_base = binfo->loader_start;
+        mem_sz = binfo->ram_size;
         for (i = 0; i < nb_numa_nodes; i++) {
-            mem_len = numa_info[i].node_mem;
-            nodename = g_strdup_printf("/memory@%" PRIx64, mem_base);
-            qemu_fdt_add_subnode(fdt, nodename);
-            qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
-            rc = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg",
-                                              acells, mem_base,
+            mem_len = MIN(numa_info[i].node_mem, mem_sz);
+
+            nodename = create_memory_fdt(fdt, acells, mem_base,
                                               scells, mem_len);
-            if (rc < 0) {
-                fprintf(stderr, "couldn't set %s/reg for node %d\n", nodename,
-                        i);
+            if (!nodename) {
                 goto fail;
             }
 
             qemu_fdt_setprop_cell(fdt, nodename, "numa-node-id", i);
-            mem_base += mem_len;
             g_free(nodename);
+            mem_base += mem_len;
+            mem_sz -= mem_len;
+            if (!mem_sz) {
+                break;
+           }
         }
-    } else {
-        Error *err = NULL;
 
-        rc = fdt_path_offset(fdt, "/memory");
-        if (rc < 0) {
-            qemu_fdt_add_subnode(fdt, "/memory");
-        }
+        /* Create the node for initial pc-dimm ram, if any */
+        if (binfo->dimm_mem) {
 
-        if (!qemu_fdt_getprop(fdt, "/memory", "device_type", NULL, &err)) {
-            qemu_fdt_setprop_string(fdt, "/memory", "device_type", "memory");
+            nodename = create_memory_fdt(fdt, acells, binfo->dimm_mem->base,
+                                              scells, binfo->dimm_mem->size);
+            if (!nodename) {
+                goto fail;
+            }
+            qemu_fdt_setprop_cell(fdt, nodename, "numa-node-id",
+                                                 binfo->dimm_mem->node);
+            g_free(nodename);
         }
 
-        rc = qemu_fdt_setprop_sized_cells(fdt, "/memory", "reg",
-                                          acells, binfo->loader_start,
-                                          scells, binfo->ram_size);
-        if (rc < 0) {
-            fprintf(stderr, "couldn't set /memory/reg\n");
+    } else {
+
+        nodename = create_memory_fdt(fdt, acells, binfo->loader_start,
+                                         scells, binfo->ram_size);
+        if (!nodename) {
             goto fail;
         }
+
+        if (binfo->dimm_mem) {
+            nodename = create_memory_fdt(fdt, acells, binfo->dimm_mem->base,
+                                              scells, binfo->dimm_mem->size);
+            if (!nodename) {
+                goto fail;
+            }
+            g_free(nodename);
+        }
     }
 
     rc = fdt_path_offset(fdt, "/chosen");
diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
index ce769bd..0ee3b4e 100644
--- a/include/hw/arm/arm.h
+++ b/include/hw/arm/arm.h
@@ -48,6 +48,12 @@ typedef struct {
     ARMCPU *cpu; /* handle to the first cpu object */
 } ArmLoadKernelNotifier;
 
+struct dimm_mem_info {
+    int node;
+    hwaddr base;
+    hwaddr size;
+};
+
 /* arm_boot.c */
 struct arm_boot_info {
     uint64_t ram_size;
@@ -124,6 +130,12 @@ struct arm_boot_info {
     bool secure_board_setup;
 
     arm_endianness endianness;
+
+    /* This is used to model a pc-dimm based mem if the valid iova region
+     * is non-contiguous.
+     */
+    struct dimm_mem_info *dimm_mem;
+
 };
 
 /**
-- 
2.7.4
