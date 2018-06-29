Received: from eggs.gnu.org ([2001:4830:134:3::10]:33697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumg-0007KL-1N
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumd-0006FE-Ta
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:02 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYumd-00063g-Ko
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:53:59 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumX-0004WD-5F
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:53:53 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:52:58 +0100
Message-Id: <20180629145347.652-7-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 06/55] hw/arm/virt: Silence dtc /memory warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

When running dtc on the guest /proc/device-tree we get the
following warning: Warning (unit_address_vs_reg): Node /memory
has a reg or ranges property, but no unit name".

Let's fix that by adding the unit address to the node name. We also
don't create the /memory node anymore in create_fdt(). We directly
create it in load_dtb. /chosen still needs to be created in create_fdt
as the uart needs it. In case the user provided his own dtb, we nop
all memory nodes found in root and create new one(s).

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-id: 1530044492-24921-4-git-send-email-eric.auger@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 41 +++++++++++++++++++++++------------------
 hw/arm/virt.c |  7 +------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 1e481662adb..e09201cc97c 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -490,11 +490,13 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
                  hwaddr addr_limit, AddressSpace *as)
 {
     void *fdt = NULL;
-    int size, rc;
+    int size, rc, n = 0;
     uint32_t acells, scells;
     char *nodename;
     unsigned int i;
     hwaddr mem_base, mem_len;
+    char **node_path;
+    Error *err = NULL;
 
     if (binfo->dtb_filename) {
         char *filename;
@@ -546,12 +548,21 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         goto fail;
     }
 
+    /* nop all root nodes matching /memory or /memory@unit-address */
+    node_path = qemu_fdt_node_unit_path(fdt, "memory", &err);
+    if (err) {
+        error_report_err(err);
+        goto fail;
+    }
+    while (node_path[n]) {
+        if (g_str_has_prefix(node_path[n], "/memory")) {
+            qemu_fdt_nop_node(fdt, node_path[n]);
+        }
+        n++;
+    }
+    g_strfreev(node_path);
+
     if (nb_numa_nodes > 0) {
-        /*
-         * Turn the /memory node created before into a NOP node, then create
-         * /memory@addr nodes for all numa nodes respectively.
-         */
-        qemu_fdt_nop_node(fdt, "/memory");
         mem_base = binfo->loader_start;
         for (i = 0; i < nb_numa_nodes; i++) {
             mem_len = numa_info[i].node_mem;
@@ -572,24 +583,18 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
             g_free(nodename);
         }
     } else {
-        Error *err = NULL;
+        nodename = g_strdup_printf("/memory@%" PRIx64, binfo->loader_start);
+        qemu_fdt_add_subnode(fdt, nodename);
+        qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
 
-        rc = fdt_path_offset(fdt, "/memory");
-        if (rc < 0) {
-            qemu_fdt_add_subnode(fdt, "/memory");
-        }
-
-        if (!qemu_fdt_getprop(fdt, "/memory", "device_type", NULL, &err)) {
-            qemu_fdt_setprop_string(fdt, "/memory", "device_type", "memory");
-        }
-
-        rc = qemu_fdt_setprop_sized_cells(fdt, "/memory", "reg",
+        rc = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg",
                                           acells, binfo->loader_start,
                                           scells, binfo->ram_size);
         if (rc < 0) {
-            fprintf(stderr, "couldn't set /memory/reg\n");
+            fprintf(stderr, "couldn't set %s reg\n", nodename);
             goto fail;
         }
+        g_free(nodename);
     }
 
     rc = fdt_path_offset(fdt, "/chosen");
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6cce2828f7c..281ddcdf6e2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -204,13 +204,8 @@ static void create_fdt(VirtMachineState *vms)
     qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
     qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
 
-    /*
-     * /chosen and /memory nodes must exist for load_dtb
-     * to fill in necessary properties later
-     */
+    /* /chosen must exist for load_dtb to fill in necessary properties later */
     qemu_fdt_add_subnode(fdt, "/chosen");
-    qemu_fdt_add_subnode(fdt, "/memory");
-    qemu_fdt_setprop_string(fdt, "/memory", "device_type", "memory");
 
     /* Clock node, for the benefit of the UART. The kernel device tree
      * binding documentation claims the PL011 node clock properties are
-- 
2.17.1
