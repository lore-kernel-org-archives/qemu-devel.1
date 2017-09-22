Received: from eggs.gnu.org ([2001:4830:134:3::10]:51403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1dvOMV-0003DL-DL
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1dvOMU-0004qe-Ez
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:51:23 -0400
From: Wei Huang <wei@redhat.com>
Date: Fri, 22 Sep 2017 08:51:15 -0500
Message-Id: <1506088275-31734-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [PATCH 1/1] mach-virt: Set VM's SMBIOS system version
 to mc->name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org

Instead of using "1.0" as the system version of SMBIOS, we should use
mc->name for mach-virt machine type. This matches with x86 code and
prevents the smbios_table.machine_type test of Avocado from failing.

Signed-off-by: Wei Huang <wei@redhat.com>
---
 hw/arm/virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9e18b41..8d0c6a9 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1189,6 +1189,7 @@ static void *machvirt_dtb(const struct arm_boot_info *binfo, int *fdt_size)
 
 static void virt_build_smbios(VirtMachineState *vms)
 {
+    MachineClass *mc = MACHINE_GET_CLASS(vms);
     uint8_t *smbios_tables, *smbios_anchor;
     size_t smbios_tables_len, smbios_anchor_len;
     const char *product = "QEMU Virtual Machine";
@@ -1202,7 +1203,7 @@ static void virt_build_smbios(VirtMachineState *vms)
     }
 
     smbios_set_defaults("QEMU", product,
-                        "1.0", false, true, SMBIOS_ENTRY_POINT_30);
+                        mc->name, false, true, SMBIOS_ENTRY_POINT_30);
 
     smbios_get_tables(NULL, 0, &smbios_tables, &smbios_tables_len,
                       &smbios_anchor, &smbios_anchor_len);
-- 
2.7.5
