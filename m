Received: from eggs.gnu.org ([209.51.188.92]:54759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHi-0001i3-Px
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHi-00016F-1w
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:18 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:33898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1DHh-00015G-Q5
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:17 -0500
Received: by mail-wr1-x42c.google.com with SMTP id f14so10259923wrg.1
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 08:51:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id 2sm10071495wrg.89.2019.03.05.08.51.15
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Mar 2019 08:51:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Mar 2019 16:50:49 +0000
Message-Id: <20190305165051.26860-21-peter.maydell@linaro.org>
In-Reply-To: <20190305165051.26860-1-peter.maydell@linaro.org>
References: <20190305165051.26860-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/22] hw/arm/virt: Check the VCPU PA range in
 TCG mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

We are about to allow the memory map to grow beyond 1TB and
potentially overshoot the VCPU AA64MMFR0.PARANGE.

In aarch64 mode and when highmem is set, let's check the VCPU
PA range is sufficient to address the highest GPA of the memory
map.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20190304101339.25970-10-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3ac6b152f55..d725daefdf8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -60,6 +60,7 @@
 #include "standard-headers/linux/input.h"
 #include "hw/arm/smmuv3.h"
 #include "hw/acpi/acpi.h"
+#include "target/arm/internals.h"
 
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -1608,6 +1609,22 @@ static void machvirt_init(MachineState *machine)
     fdt_add_timer_nodes(vms);
     fdt_add_cpu_nodes(vms);
 
+   if (!kvm_enabled()) {
+        ARMCPU *cpu = ARM_CPU(first_cpu);
+        bool aarch64 = object_property_get_bool(OBJECT(cpu), "aarch64", NULL);
+
+        if (aarch64 && vms->highmem) {
+            int requested_pa_size, pamax = arm_pamax(cpu);
+
+            requested_pa_size = 64 - clz64(vms->highest_gpa);
+            if (pamax < requested_pa_size) {
+                error_report("VCPU supports less PA bits (%d) than requested "
+                            "by the memory map (%d)", pamax, requested_pa_size);
+                exit(1);
+            }
+        }
+    }
+
     memory_region_allocate_system_memory(ram, NULL, "mach-virt.ram",
                                          machine->ram_size);
     memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base, ram);
-- 
2.20.1
