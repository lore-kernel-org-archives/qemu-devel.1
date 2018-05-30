Received: from eggs.gnu.org ([2001:4830:134:3::10]:39478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fNvCM-0003EM-5g
	for qemu-devel@nongnu.org; Wed, 30 May 2018 03:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fNvCL-0007Y9-3P
	for qemu-devel@nongnu.org; Wed, 30 May 2018 03:07:06 -0400
From: Shannon Zhao <zhaoshenglong@huawei.com>
Date: Wed, 30 May 2018 15:05:51 +0800
Message-ID: <1527663951-14552-1-git-send-email-zhaoshenglong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3] ARM: ACPI: Fix use-after-free due to memory
 realloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, eric.auger@redhat.com, f4bug@amsat.org, qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, Shannon Zhao <zhaoshenglong@huawei.com>

acpi_data_push uses g_array_set_size to resize the memory size. If there
is no enough contiguous memory, the address will be changed. So previous
pointer could not be used any more. It must update the pointer and use
the new one.

Also, previous codes wrongly use le32 conversion of iort->node_offset
for subsequent computations that will result incorrect value if host is
not litlle endian. So use the non-converted one instead.

Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
---
V3: Fix typo and add some words in commit message to explain another bug
---
 hw/arm/virt-acpi-build.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 92ceee9..74f5744 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -400,7 +400,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
     AcpiIortItsGroup *its;
     AcpiIortTable *iort;
     AcpiIortSmmu3 *smmu;
-    size_t node_size, iort_length, smmu_offset =3D 0;
+    size_t node_size, iort_node_offset, iort_length, smmu_offset =3D 0;
     AcpiIortRC *rc;
=20
     iort =3D acpi_data_push(table_data, sizeof(*iort));
@@ -413,7 +413,12 @@ build_iort(GArray *table_data, BIOSLinker *linker, V=
irtMachineState *vms)
=20
     iort_length =3D sizeof(*iort);
     iort->node_count =3D cpu_to_le32(nb_nodes);
-    iort->node_offset =3D cpu_to_le32(sizeof(*iort));
+    /*
+     * Use a copy in case table_data->data moves during acpi_data_push
+     * operations.
+     */
+    iort_node_offset =3D sizeof(*iort);
+    iort->node_offset =3D cpu_to_le32(iort_node_offset);
=20
     /* ITS group node */
     node_size =3D  sizeof(*its) + sizeof(uint32_t);
@@ -429,7 +434,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
         int irq =3D  vms->irqmap[VIRT_SMMU];
=20
         /* SMMUv3 node */
-        smmu_offset =3D iort->node_offset + node_size;
+        smmu_offset =3D iort_node_offset + node_size;
         node_size =3D sizeof(*smmu) + sizeof(*idmap);
         iort_length +=3D node_size;
         smmu =3D acpi_data_push(table_data, node_size);
@@ -450,7 +455,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
         idmap->id_count =3D cpu_to_le32(0xFFFF);
         idmap->output_base =3D 0;
         /* output IORT node is the ITS group node (the first node) */
-        idmap->output_reference =3D cpu_to_le32(iort->node_offset);
+        idmap->output_reference =3D cpu_to_le32(iort_node_offset);
     }
=20
     /* Root Complex Node */
@@ -479,9 +484,14 @@ build_iort(GArray *table_data, BIOSLinker *linker, V=
irtMachineState *vms)
         idmap->output_reference =3D cpu_to_le32(smmu_offset);
     } else {
         /* output IORT node is the ITS group node (the first node) */
-        idmap->output_reference =3D cpu_to_le32(iort->node_offset);
+        idmap->output_reference =3D cpu_to_le32(iort_node_offset);
     }
=20
+    /*
+     * Update the pointer address in case table_data->data moves during =
above
+     * acpi_data_push operations.
+     */
+    iort =3D (AcpiIortTable *)(table_data->data + iort_start);
     iort->length =3D cpu_to_le32(iort_length);
=20
     build_header(linker, table_data, (void *)(table_data->data + iort_st=
art),
--=20
2.0.4
