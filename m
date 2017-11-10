Received: from eggs.gnu.org ([2001:4830:134:3::10]:55167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eD7HJ-0001jl-FL
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 06:15:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eD7HH-00010V-KT
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 06:15:17 -0500
From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Sat, 11 Nov 2017 03:19:50 +0800
Message-ID: <1510341591-22817-12-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1510341591-22817-1-git-send-email-gengdongjiu@huawei.com>
References: <1510341591-22817-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v12 11/12] hw/arm/virt: Add RAS platform
 version for migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, imammedo@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, mtosatti@redhat.com, james.morse@arm.com, lersek@redhat.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, rth@twiddle.net, ehabkost@redhat.com, kvm@vger.kernel.org, guohanjun@huawei.com, lijinyue@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com, zhengqiang10@huawei.com, linuxarm@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Support this feature since version 2.10, disable it by
default in the old version.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
Adding platform version is suggested here:
https://lkml.org/lkml/2017/8/25/821
---
 hw/arm/virt-acpi-build.c | 14 +++++++++-----
 hw/arm/virt.c            |  4 ++++
 include/hw/arm/virt.h    |  1 +
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 92c8c38..961b67d 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -801,10 +801,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     acpi_add_table(table_offsets, tables_blob);
     build_spcr(tables_blob, tables->linker, vms);
 
-    acpi_add_table(table_offsets, tables_blob);
-    build_error_block(tables->hardware_errors, tables->linker);
-    build_apei_ghes(tables_blob, tables->hardware_errors, tables->linker);
-
+    if (!vmc->no_ras) {
+        acpi_add_table(table_offsets, tables_blob);
+        build_error_block(tables->hardware_errors, tables->linker);
+        build_apei_ghes(tables_blob, tables->hardware_errors, tables->linker);
+    }
 
     if (nb_numa_nodes > 0) {
         acpi_add_table(table_offsets, tables_blob);
@@ -891,6 +892,7 @@ static const VMStateDescription vmstate_virt_acpi_build = {
 
 void virt_acpi_setup(VirtMachineState *vms)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
 
@@ -922,7 +924,9 @@ void virt_acpi_setup(VirtMachineState *vms)
     fw_cfg_add_file(vms->fw_cfg, ACPI_BUILD_TPMLOG_FILE, tables.tcpalog->data,
                     acpi_data_len(tables.tcpalog));
 
-    ghes_add_fw_cfg(vms->fw_cfg, tables.hardware_errors);
+    if (!vmc->no_ras) {
+        ghes_add_fw_cfg(vms->fw_cfg, tables.hardware_errors);
+    }
 
     build_state->rsdp_mr = acpi_add_rom_blob(build_state, tables.rsdp,
                                               ACPI_BUILD_RSDP_FILE, 0);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 68495c2..ab79988 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1732,8 +1732,12 @@ static void virt_2_9_instance_init(Object *obj)
 
 static void virt_machine_2_9_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_2_10_options(mc);
     SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_9);
+    /* memory recovery feature was introduced with 2.10 */
+    vmc->no_ras = true;
 }
 DEFINE_VIRT_MACHINE(2, 9)
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 33b0ff3..8fbd664 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -84,6 +84,7 @@ typedef struct {
     bool disallow_affinity_adjustment;
     bool no_its;
     bool no_pmu;
+    bool no_ras;
     bool claim_edge_triggered_timers;
 } VirtMachineClass;
 
-- 
1.8.3.1
