Received: from eggs.gnu.org ([209.51.188.92]:47908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hDo2C-0006Il-09
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hDo2A-0007Oh-Sj
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:31:19 -0400
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Date: Tue, 9 Apr 2019 11:29:34 +0100
Message-ID: <20190409102935.28292-8-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
References: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 7/8] hw/arm/boot: Add "hotpluggable"
 property to DT memory node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, eric.auger@redhat.com, imammedo@redhat.com
Cc: peter.maydell@linaro.org, shannon.zhaosl@gmail.com, sameo@linux.intel.com, sebastien.boeuf@intel.com, xuwei5@hisilicon.com, lersek@redhat.com, ard.biesheuvel@linaro.org, linuxarm@huawei.com

Currently firmware has no way of differentiating the memory
nodes and as a result device memory nodes might get exposed
to Guest Kernel via UEFI GetMemoryMap() as early boot memory
even if Guest boots with ACPI. This will prevent hot-unplug
of the device memory. To address this, an additional
"hotpluggable" property is introduced here similar to
the MEM_AFFINITY_HOTPLUGGABLE flag used in ACPI SRAT table.

Firmware can now check for "hotpluggable" property in the
memory node and treat them differently.

This is in preparation of exposing device memory nodes in DT.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/boot.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index a830655..8c840ba 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -425,7 +425,7 @@ static void set_kernel_args_old(const struct arm_boot_info *info,
 
 static int fdt_add_memory_node(void *fdt, uint32_t acells, hwaddr mem_base,
                                uint32_t scells, hwaddr mem_len,
-                               int numa_node_id)
+                               int numa_node_id, bool hotplug)
 {
     char *nodename;
     int ret;
@@ -444,6 +444,22 @@ static int fdt_add_memory_node(void *fdt, uint32_t acells, hwaddr mem_base,
         ret = qemu_fdt_setprop_cell(fdt, nodename,
                                     "numa-node-id", numa_node_id);
     }
+
+    /*
+     * Firmware has no way of differentiating the memory nodes currently
+     * and in the case of device memory nodes this is a problem if Guest
+     * boots with ACPI as these nodes might get exposed to Guest Kernel
+     * via UEFI GetMemoryMap() as early boot memory. This will prevent
+     * the memory being hot-unpluggable. To address this, an additional
+     * "hotpluggable" property is introduced here, similar to the
+     * MEM_AFFINITY_HOTPLUGGABLE flag used in ACPI SRAT table.
+     * Firmware can now check for "hotpluggable" property in the memory
+     * node and treat them differently.
+     */
+
+    if (hotplug) {
+        ret = qemu_fdt_setprop(fdt, nodename, "hotpluggable", NULL, 0);
+    }
 out:
     g_free(nodename);
     return ret;
@@ -602,7 +618,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         for (i = 0; i < nb_numa_nodes; i++) {
             mem_len = numa_info[i].node_mem;
             rc = fdt_add_memory_node(fdt, acells, mem_base,
-                                     scells, mem_len, i);
+                                     scells, mem_len, i, false);
             if (rc < 0) {
                 fprintf(stderr, "couldn't add /memory@%"PRIx64" node\n",
                         mem_base);
@@ -613,7 +629,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         }
     } else {
         rc = fdt_add_memory_node(fdt, acells, binfo->loader_start,
-                                 scells, binfo->ram_size, -1);
+                                 scells, binfo->ram_size, -1, false);
         if (rc < 0) {
             fprintf(stderr, "couldn't add /memory@%"PRIx64" node\n",
                     binfo->loader_start);
-- 
2.7.4
