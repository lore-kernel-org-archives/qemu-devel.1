Received: from eggs.gnu.org ([2001:4830:134:3::10]:33447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cO8oV-00024m-HP
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:02:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cO8oU-0003zw-L4
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:02:35 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Mon,  2 Jan 2017 21:01:53 +0100
Message-Id: <20170102200153.28864-17-drjones@redhat.com>
In-Reply-To: <20170102200153.28864-1-drjones@redhat.com>
References: <20170102200153.28864-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH v2 16/16] hw/arm/virt-acpi-build: madt: add
 vgic maint irq
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

When virtualization is enabled and we have a v3 gic, then we add
the vgic maintenance interrupt to the DT. This patch is the ACPI
equivalent.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 hw/arm/virt-acpi-build.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 7c00ee683f44..971ee4885c43 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -607,6 +607,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         if (arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
             gicc->performance_interrupt = cpu_to_le32(PPI(VIRTUAL_PMU_IRQ));
         }
+        if (vms->virt && vms->gic_version == 3) {
+            gicc->vgic_interrupt = cpu_to_le32(PPI(ARCH_GICV3_MAINT_IRQ));
+        }
     }
 
     if (vms->gic_version == 3) {
-- 
2.9.3
