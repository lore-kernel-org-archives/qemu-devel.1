Received: from eggs.gnu.org ([2001:4830:134:3::10]:33305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cO8oI-0001qX-Un
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:02:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cO8oH-0003vX-QD
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:02:22 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Mon,  2 Jan 2017 21:01:47 +0100
Message-Id: <20170102200153.28864-11-drjones@redhat.com>
In-Reply-To: <20170102200153.28864-1-drjones@redhat.com>
References: <20170102200153.28864-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH v2 10/16] hw/arm/virt: pass VirtMachineState
 instead of VirtGuestInfo
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

Only two functions take VirtGuestInfo parameters. Now that guest-info
is part of VirtMachineState, and VirtMachineState is defined in the
virt header, pass that instead.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/arm/virt-acpi-build.c | 3 ++-
 hw/arm/virt.c            | 8 ++++----
 include/hw/arm/virt.h    | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index dbd359063781..0c36ee83d065 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -823,8 +823,9 @@ static const VMStateDescription vmstate_virt_acpi_build = {
     },
 };
 
-void virt_acpi_setup(VirtGuestInfo *guest_info)
+void virt_acpi_setup(VirtMachineState *vms)
 {
+    VirtGuestInfo *guest_info = &vms->acpi_guest_info;
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 51cb094d80f7..51f4d8c78c19 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1155,9 +1155,9 @@ static void *machvirt_dtb(const struct arm_boot_info *binfo, int *fdt_size)
     return board->fdt;
 }
 
-static void virt_build_smbios(VirtGuestInfo *guest_info)
+static void virt_build_smbios(VirtMachineState *vms)
 {
-    FWCfgState *fw_cfg = guest_info->fw_cfg;
+    FWCfgState *fw_cfg = vms->acpi_guest_info.fw_cfg;
     uint8_t *smbios_tables, *smbios_anchor;
     size_t smbios_tables_len, smbios_anchor_len;
     const char *product = "QEMU Virtual Machine";
@@ -1190,8 +1190,8 @@ void virt_machine_done(Notifier *notifier, void *data)
     VirtMachineState *vms = container_of(notifier, VirtMachineState,
                                          machine_done);
 
-    virt_acpi_setup(&vms->acpi_guest_info);
-    virt_build_smbios(&vms->acpi_guest_info);
+    virt_acpi_setup(vms);
+    virt_build_smbios(vms);
 }
 
 static void machvirt_init(MachineState *machine)
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 59ce353f5e71..8ac2d8585e0d 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -126,6 +126,6 @@ typedef struct {
     OBJECT_CLASS_CHECK(VirtMachineClass, klass, TYPE_VIRT_MACHINE)
 
 
-void virt_acpi_setup(VirtGuestInfo *guest_info);
+void virt_acpi_setup(VirtMachineState *vms);
 
 #endif /* QEMU_ARM_VIRT_H */
-- 
2.9.3
