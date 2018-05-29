Received: from eggs.gnu.org ([2001:4830:134:3::10]:34845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fNV0l-0007x5-Ez
	for qemu-devel@nongnu.org; Mon, 28 May 2018 23:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fNV0k-0007DU-Eu
	for qemu-devel@nongnu.org; Mon, 28 May 2018 23:09:23 -0400
From: Shannon Zhao <zhaoshenglong@huawei.com>
Date: Tue, 29 May 2018 11:08:03 +0800
Message-ID: <1527563283-13148-1-git-send-email-zhaoshenglong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] ARM: ACPI: Fix use-after-free due to memory
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
Cc: peter.maydell@linaro.org, eric.auger@redhat.com, qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, Shannon Zhao <zhaoshenglong@huawei.com>

acpi_data_push uses g_array_set_size to resize the memory size. If there
is no enough contiguous memory, the address will be changed. So previous
pointer could not be used any more. It must update the pointer and use
the new one.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
---
V2: add comments for iort_node_offset and reviewed tags
---
 hw/arm/virt-acpi-build.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 92ceee9..6209138 100644
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
@@ -415,6 +415,12 @@ build_iort(GArray *table_data, BIOSLinker *linker, V=
irtMachineState *vms)
     iort->node_count =3D cpu_to_le32(nb_nodes);
     iort->node_offset =3D cpu_to_le32(sizeof(*iort));
=20
+    /*
+     * Use a copy in case table_data->data moves duringa acpi_data_push
+     * operations.
+     */
+    iort_node_offset =3D sizeof(*iort);
+
     /* ITS group node */
     node_size =3D  sizeof(*its) + sizeof(uint32_t);
     iort_length +=3D node_size;
@@ -429,7 +435,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
         int irq =3D  vms->irqmap[VIRT_SMMU];
=20
         /* SMMUv3 node */
-        smmu_offset =3D iort->node_offset + node_size;
+        smmu_offset =3D iort_node_offset + node_size;
         node_size =3D sizeof(*smmu) + sizeof(*idmap);
         iort_length +=3D node_size;
         smmu =3D acpi_data_push(table_data, node_size);
@@ -450,7 +456,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
         idmap->id_count =3D cpu_to_le32(0xFFFF);
         idmap->output_base =3D 0;
         /* output IORT node is the ITS group node (the first node) */
-        idmap->output_reference =3D cpu_to_le32(iort->node_offset);
+        idmap->output_reference =3D cpu_to_le32(iort_node_offset);
     }
=20
     /* Root Complex Node */
@@ -479,9 +485,14 @@ build_iort(GArray *table_data, BIOSLinker *linker, V=
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
