Received: from eggs.gnu.org ([2001:4830:134:3::10]:53965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cGutU-0002gr-Sq
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:45:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cGutU-0007gB-66
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:45:52 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Tue, 13 Dec 2016 22:45:20 +0100
Message-Id: <20161213214522.25548-10-drjones@redhat.com>
In-Reply-To: <20161213214522.25548-1-drjones@redhat.com>
References: <20161213214522.25548-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH 09/11] hw/arm/virt-acpi-build: don't save
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
Cc: peter.maydell@linaro.org, zhaoshenglong@huawei.com, mst@redhat.com, imammedo@redhat.com, ehabkost@redhat.com

We can get to VirtMachineState without the need for saving a pointer
on AcpiBuildState. This is the mach-virt equivalent to "acpi: Don't save
PcGuestInfo on AcpiBuildState"

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 hw/arm/virt-acpi-build.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 7a1efd0dc538..137781646bec 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -706,7 +706,6 @@ struct AcpiBuildState {
     MemoryRegion *linker_mr;
     /* Is table patched? */
     bool patched;
-    VirtGuestInfo *guest_info;
 } AcpiBuildState;
 
 static
@@ -779,6 +778,8 @@ static void acpi_ram_update(MemoryRegion *mr, GArray *data)
 
 static void virt_acpi_build_update(void *build_opaque)
 {
+    MachineState *machine = MACHINE(qdev_get_machine());
+    VirtMachineState *vms = VIRT_MACHINE(machine);
     AcpiBuildState *build_state = build_opaque;
     AcpiBuildTables tables;
 
@@ -790,8 +791,7 @@ static void virt_acpi_build_update(void *build_opaque)
 
     acpi_build_tables_init(&tables);
 
-    virt_acpi_build(container_of(build_state->guest_info,
-                                 VirtMachineState, acpi_guest_info), &tables);
+    virt_acpi_build(vms, &tables);
 
     acpi_ram_update(build_state->table_mr, tables.table_data);
     acpi_ram_update(build_state->rsdp_mr, tables.rsdp);
@@ -841,7 +841,6 @@ void virt_acpi_setup(VirtMachineState *vms)
     }
 
     build_state = g_malloc0(sizeof *build_state);
-    build_state->guest_info = guest_info;
 
     acpi_build_tables_init(&tables);
     virt_acpi_build(vms, &tables);
-- 
2.9.3
