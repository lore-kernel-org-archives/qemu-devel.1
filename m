Received: from eggs.gnu.org ([2001:4830:134:3::10]:49155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ezRlO-00018I-23
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:50:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ezRlN-0004Fd-3a
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:50:06 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ezRlM-0004EB-Ss
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:50:05 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ezRlL-0007fu-JK
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:50:03 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Mar 2018 18:49:54 +0000
Message-Id: <20180323184958.14252-7-peter.maydell@linaro.org>
In-Reply-To: <20180323184958.14252-1-peter.maydell@linaro.org>
References: <20180323184958.14252-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 06/10] mach-virt: Set VM's SMBIOS system version
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

From: Wei Huang <wei@redhat.com>

Instead of using "1.0" as the system version of SMBIOS, we should use
mc->name for mach-virt machine type to be consistent other architectures.
With this patch, "dmidecode -t 1" (e.g., "-M virt-2.12,accel=kvm") will
show:

    Handle 0x0100, DMI type 1, 27 bytes
    System Information
            Manufacturer: QEMU
            Product Name: KVM Virtual Machine
            Version: virt-2.12
            Serial Number: Not Specified
            ...

instead of:

    Handle 0x0100, DMI type 1, 27 bytes
    System Information
            Manufacturer: QEMU
            Product Name: KVM Virtual Machine
            Version: 1.0
            Serial Number: Not Specified
            ...

For backward compatibility, we allow older machine types to keep "1.0"
as the default system version.

Signed-off-by: Wei Huang <wei@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Message-id: 20180322212318.7182-1-wei@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h | 1 +
 hw/arm/virt.c         | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 33b0ff3892..ba0c1a4faa 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -85,6 +85,7 @@ typedef struct {
     bool no_its;
     bool no_pmu;
     bool claim_edge_triggered_timers;
+    bool smbios_old_sys_ver;
 } VirtMachineClass;
 
 typedef struct {
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 2c07245047..94dcb125d3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1132,6 +1132,8 @@ static void *machvirt_dtb(const struct arm_boot_info *binfo, int *fdt_size)
 
 static void virt_build_smbios(VirtMachineState *vms)
 {
+    MachineClass *mc = MACHINE_GET_CLASS(vms);
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     uint8_t *smbios_tables, *smbios_anchor;
     size_t smbios_tables_len, smbios_anchor_len;
     const char *product = "QEMU Virtual Machine";
@@ -1145,7 +1147,8 @@ static void virt_build_smbios(VirtMachineState *vms)
     }
 
     smbios_set_defaults("QEMU", product,
-                        "1.0", false, true, SMBIOS_ENTRY_POINT_30);
+                        vmc->smbios_old_sys_ver ? "1.0" : mc->name, false,
+                        true, SMBIOS_ENTRY_POINT_30);
 
     smbios_get_tables(NULL, 0, &smbios_tables, &smbios_tables_len,
                       &smbios_anchor, &smbios_anchor_len);
@@ -1646,8 +1649,11 @@ static void virt_2_11_instance_init(Object *obj)
 
 static void virt_machine_2_11_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_2_12_options(mc);
     SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_11);
+    vmc->smbios_old_sys_ver = true;
 }
 DEFINE_VIRT_MACHINE(2, 11)
 
-- 
2.16.2
