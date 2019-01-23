Received: from eggs.gnu.org ([209.51.188.92]:34817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmFZn-0001lC-0I
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:16:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmFZm-0007Vw-2J
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:16:06 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 23 Jan 2019 11:14:52 +0100
Message-Id: <20190123101458.12478-13-eric.auger@redhat.com>
In-Reply-To: <20190123101458.12478-1-eric.auger@redhat.com>
References: <20190123101458.12478-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 12/18] hw/arm/boot: Expose the PC-DIMM nodes
 in the DT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com
Cc: dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

This patch add memory nodes corresponding to PC-DIMM regions.

NV_DIMM and ACPI_NVDIMM configs are not yet set for ARM so we
don't need to care about NV-DIMM at this stage.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v3 -> v4:
- git rid of @base and @len in fdt_add_hotpluggable_memory_nodes

v1 -> v2:
- added qapi_free_MemoryDeviceInfoList and simplify the loop
---
 hw/arm/boot.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 16f5da02fb..15432bb895 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -19,6 +19,7 @@
 #include "sysemu/numa.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
+#include "hw/mem/memory-device.h"
 #include "elf.h"
 #include "sysemu/device_tree.h"
 #include "qemu/config-file.h"
@@ -526,6 +527,34 @@ static void fdt_add_psci_node(void *fdt)
     qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);
 }
=20
+static int fdt_add_hotpluggable_memory_nodes(void *fdt,
+                                             uint32_t acells, uint32_t s=
cells) {
+    MemoryDeviceInfoList *info, *info_list =3D qmp_memory_device_list();
+    MemoryDeviceInfo *mi;
+    PCDIMMDeviceInfo *di;
+    bool is_nvdimm;
+    int ret =3D 0;
+
+    for (info =3D info_list; info !=3D NULL; info =3D info->next) {
+        mi =3D info->value;
+        is_nvdimm =3D (mi->type =3D=3D MEMORY_DEVICE_INFO_KIND_NVDIMM);
+        di =3D !is_nvdimm ? mi->u.dimm.data : mi->u.nvdimm.data;
+
+        if (is_nvdimm) {
+            ret =3D -ENOENT; /* NV-DIMM not yet supported */
+        } else {
+            ret =3D fdt_add_memory_node(fdt, acells, di->addr,
+                                      scells, di->size, di->node);
+        }
+        if (ret < 0) {
+            goto out;
+        }
+    }
+out:
+    qapi_free_MemoryDeviceInfoList(info_list);
+    return ret;
+}
+
 int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
                  hwaddr addr_limit, AddressSpace *as)
 {
@@ -621,6 +650,12 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_=
info *binfo,
         }
     }
=20
+    rc =3D fdt_add_hotpluggable_memory_nodes(fdt, acells, scells);
+    if (rc < 0) {
+            fprintf(stderr, "couldn't add hotpluggable memory nodes\n");
+            goto fail;
+    }
+
     rc =3D fdt_path_offset(fdt, "/chosen");
     if (rc < 0) {
         qemu_fdt_add_subnode(fdt, "/chosen");
--=20
2.20.1
