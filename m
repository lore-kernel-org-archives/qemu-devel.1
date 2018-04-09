Received: from eggs.gnu.org ([2001:4830:134:3::10]:39973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1f5Z30-0002ZV-VO
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 11:49:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1f5Z30-0004kC-2p
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 11:49:35 -0400
From: Wei Huang <wei@redhat.com>
Date: Mon,  9 Apr 2018 10:49:21 -0500
Message-Id: <20180409154921.29906-1-wei@redhat.com>
Subject: [Qemu-devel] [PATCH 1/1] mach-virt: Change default cpu and
 gic-version setting to "max"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, drjones@redhat.com, abologna@redhat.com

Running mach-virt machine types (i.e. "-M virt") on different systems can
result in various misleading warnings if -cpu and/or gic-version not specified.
For KVM, this can be solved mostly by using "host" type. But the "host" type
doesn't work for TCG. Compared with "host", the "max" type not only supports
auto detection under KVM mode, but also works with TCG. So this patch set
"max" as the default types for both -cpu and gic-version.

Signed-off-by: Wei Huang <wei@redhat.com>
---
 hw/arm/virt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 94dcb125d3..1a9d68b8d5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1555,7 +1555,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->minimum_page_bits = 12;
     mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("max");
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
 }
 
@@ -1609,13 +1609,13 @@ static void virt_2_12_instance_init(Object *obj)
                                     "Set on/off to enable/disable using "
                                     "physical address space above 32 bits",
                                     NULL);
-    /* Default GIC type is v2 */
-    vms->gic_version = 2;
+    /* Default GIC type is max */
+    vms->gic_version = -1;
     object_property_add_str(obj, "gic-version", virt_get_gic_version,
                         virt_set_gic_version, NULL);
     object_property_set_description(obj, "gic-version",
-                                    "Set GIC version. "
-                                    "Valid values are 2, 3 and host", NULL);
+                                    "Set GIC version. Valid values are 2, 3, "
+                                    "host, and max", NULL);
 
     if (vmc->no_its) {
         vms->its = false;
-- 
2.14.3
