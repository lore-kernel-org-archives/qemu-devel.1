Received: from eggs.gnu.org ([2001:4830:134:3::10]:41532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fWJA9-0000Ok-U0
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fWJA6-0005dO-O5
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:19:29 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 22 Jun 2018 12:19:07 +0200
Message-Id: <1529662749-32069-4-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1529662749-32069-1-git-send-email-eric.auger@redhat.com>
References: <1529662749-32069-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 3/5] hw/arm/boot: introduce fdt_add_memory_node
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, imammedo@redhat.com

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

We introduce an helper to create a memory node. Also we nop
existing /memory node in numa and non numa case.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

---

the nop related change should disappear if the following series
lands upstream:
[PATCH v2 0/3] ARM virt: Silence dtc warnings
---
 hw/arm/boot.c | 70 +++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 31 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 1e48166..cc425ce 100644
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
     int size, rc;
     uint32_t acells, scells;
-    char *nodename;
     unsigned int i;
     hwaddr mem_base, mem_len;
 
@@ -545,49 +574,28 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
                 "RAM size > 4GB\n");
         goto fail;
     }
+    /*
+     * Turn the /memory node created before into a NOP node, then create
+     * /memory@addr nodes.
+     */
+    qemu_fdt_nop_node(fdt, "/memory");
 
     if (nb_numa_nodes > 0) {
-        /*
-         * Turn the /memory node created before into a NOP node, then create
-         * /memory@addr nodes for all numa nodes respectively.
-         */
-        qemu_fdt_nop_node(fdt, "/memory");
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
-        Error *err = NULL;
-
-        rc = fdt_path_offset(fdt, "/memory");
+        rc = fdt_add_memory_node(fdt, acells, binfo->loader_start,
+                                 scells, binfo->ram_size, -1);
         if (rc < 0) {
-            qemu_fdt_add_subnode(fdt, "/memory");
-        }
-
-        if (!qemu_fdt_getprop(fdt, "/memory", "device_type", NULL, &err)) {
-            qemu_fdt_setprop_string(fdt, "/memory", "device_type", "memory");
-        }
-
-        rc = qemu_fdt_setprop_sized_cells(fdt, "/memory", "reg",
-                                          acells, binfo->loader_start,
-                                          scells, binfo->ram_size);
-        if (rc < 0) {
-            fprintf(stderr, "couldn't set /memory/reg\n");
             goto fail;
         }
     }
-- 
2.5.5
