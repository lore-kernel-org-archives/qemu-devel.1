Received: from eggs.gnu.org ([209.51.188.92]:54741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHh-0001h1-OR
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHg-00014x-UT
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:17 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:38669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1DHg-00013Z-Ma
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:16 -0500
Received: by mail-wr1-x433.google.com with SMTP id g12so10247353wrm.5
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 08:51:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id 2sm10071495wrg.89.2019.03.05.08.51.14
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Mar 2019 08:51:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Mar 2019 16:50:48 +0000
Message-Id: <20190305165051.26860-20-peter.maydell@linaro.org>
In-Reply-To: <20190305165051.26860-1-peter.maydell@linaro.org>
References: <20190305165051.26860-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/22] hw/arm/virt: Implement kvm_type function
 for 4.0 machine
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

This patch implements the machine class kvm_type() callback.
It returns the number of bits requested to implement the whole GPA
range including the RAM and IO regions located beyond.
The returned value is passed though the KVM_CREATE_VM ioctl and
this allows KVM to set the stage2 tables dynamically.

To compute the highest GPA used in the memory map, kvm_type()
must freeze the memory map by calling virt_set_memmap().

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20190304101339.25970-9-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 2e788a0361e..3ac6b152f55 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1440,7 +1440,13 @@ static void machvirt_init(MachineState *machine)
     bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
     bool aarch64 = true;
 
-    virt_set_memmap(vms);
+    /*
+     * In accelerated mode, the memory map is computed earlier in kvm_type()
+     * to create a VM with the right number of IPA bits.
+     */
+    if (!vms->memmap) {
+        virt_set_memmap(vms);
+    }
 
     /* We can probe only here because during property set
      * KVM is not available yet
@@ -1829,6 +1835,36 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
     return NULL;
 }
 
+/*
+ * for arm64 kvm_type [7-0] encodes the requested number of bits
+ * in the IPA address space
+ */
+static int virt_kvm_type(MachineState *ms, const char *type_str)
+{
+    VirtMachineState *vms = VIRT_MACHINE(ms);
+    int max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms);
+    int requested_pa_size;
+
+    /* we freeze the memory map to compute the highest gpa */
+    virt_set_memmap(vms);
+
+    requested_pa_size = 64 - clz64(vms->highest_gpa);
+
+    if (requested_pa_size > max_vm_pa_size) {
+        error_report("-m and ,maxmem option values "
+                     "require an IPA range (%d bits) larger than "
+                     "the one supported by the host (%d bits)",
+                     requested_pa_size, max_vm_pa_size);
+       exit(1);
+    }
+    /*
+     * By default we return 0 which corresponds to an implicit legacy
+     * 40b IPA setting. Otherwise we return the actual requested PA
+     * logsize
+     */
+    return requested_pa_size > 40 ? requested_pa_size : 0;
+}
+
 static void virt_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -1853,6 +1889,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
+    mc->kvm_type = virt_kvm_type;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
     hc->plug = virt_machine_device_plug_cb;
-- 
2.20.1
