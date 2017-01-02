Received: from eggs.gnu.org ([2001:4830:134:3::10]:33356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cO8oM-0001vV-Sx
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:02:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cO8oL-0003xP-RX
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:02:26 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Mon,  2 Jan 2017 21:01:49 +0100
Message-Id: <20170102200153.28864-13-drjones@redhat.com>
In-Reply-To: <20170102200153.28864-1-drjones@redhat.com>
References: <20170102200153.28864-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH v2 12/16] hw/arm/virt-acpi-build: don't save
 VirtGuestInfo on AcpiBuildState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: imammedo@redhat.com, peter.maydell@linaro.org, zhaoshenglong@huawei.com, shannon.zhao@linaro.org, mst@redhat.com, ehabkost@redhat.com

We can get to VirtMachineState without the need for saving a pointer
on AcpiBuildState. This is the mach-virt equivalent to "acpi: Don't save
PcGuestInfo on AcpiBuildState"

Signed-off-by: Andrew Jones <drjones@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/arm/virt-acpi-build.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index e34167030dd1..0b9c2c0d0a3b 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -707,7 +707,6 @@ struct AcpiBuildState {
     MemoryRegion *linker_mr;
     /* Is table patched? */
     bool patched;
-    VirtGuestInfo *guest_info;
 } AcpiBuildState;
 
 static
@@ -791,8 +790,7 @@ static void virt_acpi_build_update(void *build_opaque)
 
     acpi_build_tables_init(&tables);
 
-    virt_acpi_build(container_of(build_state->guest_info,
-                                 VirtMachineState, acpi_guest_info), &tables);
+    virt_acpi_build(VIRT_MACHINE(qdev_get_machine()), &tables);
 
     acpi_ram_update(build_state->table_mr, tables.table_data);
     acpi_ram_update(build_state->rsdp_mr, tables.rsdp);
@@ -842,7 +840,6 @@ void virt_acpi_setup(VirtMachineState *vms)
     }
 
     build_state = g_malloc0(sizeof *build_state);
-    build_state->guest_info = guest_info;
 
     acpi_build_tables_init(&tables);
     virt_acpi_build(vms, &tables);
-- 
2.9.3
