Received: from eggs.gnu.org ([2001:4830:134:3::10]:37291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWU-0002RR-El
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWT-00047W-3I
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:58 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cQYWS-00043I-TL
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:57 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWO-0001R0-8l
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:53:52 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 11:53:38 +0000
Message-Id: <1483962824-29185-16-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
References: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 15/21] hw/arm/virt: pass VirtMachineState
 instead of VirtGuestInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrew Jones <drjones@redhat.com>

Only two functions take VirtGuestInfo parameters. Now that guest-info
is part of VirtMachineState, and VirtMachineState is defined in the
virt header, pass that instead.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20170102200153.28864-11-drjones@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h    | 2 +-
 hw/arm/virt-acpi-build.c | 3 ++-
 hw/arm/virt.c            | 8 ++++----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 91dbd69..b1eed52 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -122,6 +122,6 @@ typedef struct {
 #define VIRT_MACHINE_CLASS(klass) \
     OBJECT_CLASS_CHECK(VirtMachineClass, klass, TYPE_VIRT_MACHINE)
 
-void virt_acpi_setup(VirtGuestInfo *guest_info);
+void virt_acpi_setup(VirtMachineState *vms);
 
 #endif /* QEMU_ARM_VIRT_H */
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 4fd52da..ac507d6 100644
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
index 8556ff2..2201517 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1131,9 +1131,9 @@ static void *machvirt_dtb(const struct arm_boot_info *binfo, int *fdt_size)
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
@@ -1166,8 +1166,8 @@ void virt_machine_done(Notifier *notifier, void *data)
     VirtMachineState *vms = container_of(notifier, VirtMachineState,
                                          machine_done);
 
-    virt_acpi_setup(&vms->acpi_guest_info);
-    virt_build_smbios(&vms->acpi_guest_info);
+    virt_acpi_setup(vms);
+    virt_build_smbios(vms);
 }
 
 static void machvirt_init(MachineState *machine)
-- 
2.7.4
