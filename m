Received: from eggs.gnu.org ([2001:4830:134:3::10]:48434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpd9-0004zA-FG
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpd8-0000q3-9s
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:27 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fGpd7-0000mP-Us
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:26 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpd6-0003VC-Lx
	for qemu-devel@nongnu.org; Thu, 10 May 2018 18:45:24 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 18:45:04 +0100
Message-Id: <20180510174519.11264-7-peter.maydell@linaro.org>
In-Reply-To: <20180510174519.11264-1-peter.maydell@linaro.org>
References: <20180510174519.11264-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/21] make sure that we aren't overwriting
 mc->get_hotplug_handler by accident
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Igor Mammedov <imammedo@redhat.com>

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1525691524-32265-5-git-send-email-imammedo@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c              | 1 +
 hw/i386/pc.c               | 1 +
 hw/ppc/e500plat.c          | 1 +
 hw/ppc/spapr.c             | 1 +
 hw/s390x/s390-virtio-ccw.c | 1 +
 5 files changed, 5 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6710be226f..a3a28e20e8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1669,6 +1669,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
+    assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
     hc->plug = virt_machine_device_plug_cb;
 }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b2374febbb..d768930d02 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2350,6 +2350,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->acpi_data_size = 0x20000 + 0x8000;
     pcmc->save_tsc_khz = true;
     pcmc->linuxboot_dma_enabled = true;
+    assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = pc_get_hotpug_handler;
     mc->cpu_index_to_instance_props = pc_cpu_index_to_props;
     mc->get_default_cpu_node_id = pc_get_default_cpu_node_id;
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index 1a469ba69f..d8e3f2066e 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -74,6 +74,7 @@ static void e500plat_machine_class_init(ObjectClass *oc, void *data)
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
 
+    assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = e500plat_machine_get_hotpug_handler;
     hc->plug = e500plat_machine_device_plug_cb;
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a1abcba6ad..ebf30dd60b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3980,6 +3980,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->kvm_type = spapr_kvm_type;
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SPAPR_PCI_HOST_BRIDGE);
     mc->pci_allow_0_address = true;
+    assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = spapr_get_hotplug_handler;
     hc->pre_plug = spapr_machine_device_pre_plug;
     hc->plug = spapr_machine_device_plug;
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 100dfdc96d..5796e24bd8 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -491,6 +491,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     mc->no_sdcard = 1;
     mc->max_cpus = S390_MAX_CPUS;
     mc->has_hotpluggable_cpus = true;
+    assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = s390_get_hotplug_handler;
     mc->cpu_index_to_instance_props = s390_cpu_index_to_props;
     mc->possible_cpu_arch_ids = s390_possible_cpu_arch_ids;
-- 
2.17.0
