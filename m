Received: from eggs.gnu.org ([2001:4830:134:3::10]:38516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1ehIfc-00034z-9z
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:29:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1ehIfb-0005Om-DQ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:29:08 -0500
From: Wei Huang <wei@redhat.com>
Date: Thu,  1 Feb 2018 12:28:08 -0500
Message-Id: <1517506091-10396-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] hw/arm/virt: Set default machine and CPU
 types for mach-virt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, wei@redhat.com, drjones@redhat.com

Unlike most other QEMU architectures, the default machine type for
mach-virt is not set. This causes problems in situations where the
default machine types are not provided (e.g. qtest_start() function
in many QEMU tests). This patch designates the latest mach-virt
machine type (alias of "virt") as the default machine type. It also
changes the default CPU depending on the target.

Signed-off-by: Wei Huang <wei@redhat.com>
---
 hw/arm/virt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b334c82..f6b1408 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -68,6 +68,7 @@
         mc->desc = "QEMU " # major "." # minor " ARM Virtual Machine"; \
         if (latest) { \
             mc->alias = "virt"; \
+            mc->is_default = 1; \
         } \
     } \
     static const TypeInfo machvirt_##major##_##minor##_info = { \
@@ -1603,7 +1604,12 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->minimum_page_bits = 12;
     mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
+#ifdef TARGET_AARCH64
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a57");
+#else
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
+#endif
+
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
 }
 
-- 
1.8.3.1
