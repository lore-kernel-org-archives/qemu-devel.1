Received: from eggs.gnu.org ([2001:4830:134:3::10]:52505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fDU6Q-0005bH-4y
	for qemu-devel@nongnu.org; Tue, 01 May 2018 08:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fDU6P-0003TD-5T
	for qemu-devel@nongnu.org; Tue, 01 May 2018 08:09:50 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue,  1 May 2018 14:08:42 +0200
Message-Id: <1525176522-200354-6-git-send-email-imammedo@redhat.com>
In-Reply-To: <1525176522-200354-1-git-send-email-imammedo@redhat.com>
References: <1525176522-200354-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 5/5] make sure that we aren't overwriting
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
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, eric.auger@redhat.com

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/arm/virt.c              | 1 +
 hw/i386/pc.c               | 1 +
 hw/ppc/e500plat.c          | 1 +
 hw/ppc/spapr.c             | 1 +
 hw/s390x/s390-virtio-ccw.c | 1 +
 5 files changed, 5 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 71661c6..9b0a931 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1578,6 +1578,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
+    assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
     hc->plug = virt_machine_device_plug_cb;
 }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 018fd8d..019be25 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2355,6 +2355,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->acpi_data_size = 0x20000 + 0x8000;
     pcmc->save_tsc_khz = true;
     pcmc->linuxboot_dma_enabled = true;
+    assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = pc_get_hotpug_handler;
     mc->cpu_index_to_instance_props = pc_cpu_index_to_props;
     mc->get_default_cpu_node_id = pc_get_default_cpu_node_id;
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index 1a469ba..d8e3f20 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -74,6 +74,7 @@ static void e500plat_machine_class_init(ObjectClass *oc, void *data)
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
 
+    assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = e500plat_machine_get_hotpug_handler;
     hc->plug = e500plat_machine_device_plug_cb;
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b35aff5..5b2b00a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3995,6 +3995,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->kvm_type = spapr_kvm_type;
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SPAPR_PCI_HOST_BRIDGE);
     mc->pci_allow_0_address = true;
+    assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = spapr_get_hotplug_handler;
     hc->pre_plug = spapr_machine_device_pre_plug;
     hc->plug = spapr_machine_device_plug;
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 435f7c9..905583a 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -476,6 +476,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     mc->use_sclp = 1;
     mc->max_cpus = S390_MAX_CPUS;
     mc->has_hotpluggable_cpus = true;
+    assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = s390_get_hotplug_handler;
     mc->cpu_index_to_instance_props = s390_cpu_index_to_props;
     mc->possible_cpu_arch_ids = s390_possible_cpu_arch_ids;
-- 
2.7.4
