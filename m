Received: from eggs.gnu.org ([2001:4830:134:3::10]:45442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhlcindy@gmail.com>) id 1dEBR8-0002ga-H2
	for qemu-devel@nongnu.org; Fri, 26 May 2017 05:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhlcindy@gmail.com>) id 1dEBR7-0005Zq-MZ
	for qemu-devel@nongnu.org; Fri, 26 May 2017 05:21:34 -0400
From: Li Zhang <zhlcindy@gmail.com>
Date: Fri, 26 May 2017 17:21:08 +0800
Message-Id: <1495790468-23862-4-git-send-email-zhlcindy@gmail.com>
In-Reply-To: <1495790468-23862-1-git-send-email-zhlcindy@gmail.com>
References: <1495790468-23862-1-git-send-email-zhlcindy@gmail.com>
Subject: [Qemu-devel] [PATCH 3/3] arm/virt: Implement hot_add_cpu interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Li Zhang <li.zhang@hxt-semitech.com>

From: Li Zhang <li.zhang@hxt-semitech.com>

This patch is to add add_hot_cpu interface.

Signed-off-by: Li Zhang <li.zhang@hxt-semitech.com>
---
 hw/arm/virt.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 31314c1..c7e8322 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -527,6 +527,24 @@ out:
     error_propagate(errp, err);
 }
 
+static void virt_hot_add_cpu(const int64_t id, Error **errp)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    VirtMachineState *vms = VIRT_MACHINE(ms);
+
+    if (id < 0 || id >= max_cpus) {
+        error_setg(errp, "Invalid CPU id: %" PRIi64, id);
+        return;
+    }
+
+    virt_new_cpu(ms, id, errp);
+    if (errp) {
+        return;
+    }
+
+    fdt_add_cpu_node(vms, id);
+}
+
 static void fdt_add_its_gic_node(VirtMachineState *vms)
 {
     vms->msi_phandle = qemu_fdt_alloc_phandle(vms->fdt);
@@ -1654,6 +1672,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->minimum_page_bits = 12;
     mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
+    mc->hot_add_cpu = virt_hot_add_cpu;
 }
 
 static const TypeInfo virt_machine_info = {
-- 
2.7.4
