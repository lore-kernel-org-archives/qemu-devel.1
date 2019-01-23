Received: from eggs.gnu.org ([209.51.188.92]:34722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmFZh-0001g9-Tc
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:16:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmFZf-0007R6-Pg
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:16:01 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 23 Jan 2019 11:14:49 +0100
Message-Id: <20190123101458.12478-10-eric.auger@redhat.com>
In-Reply-To: <20190123101458.12478-1-eric.auger@redhat.com>
References: <20190123101458.12478-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 09/18] hw/arm/virt: Implement kvm_type
 function for 4.0 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com
Cc: dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com

This patch implements the machine class kvm_type() callback.
It returns the max IPA shift needed to implement the whole GPA
range including the RAM and IO regions located beyond.
The returned value in passed though the KVM_CREATE_VM ioctl and
this allows KVM to set the stage2 tables dynamically.

At this stage the RAM limit still is 255GB.

Setting all the existing highmem IO regions beyond the RAM
allows to have a single contiguous RAM region (initial RAM and
possible hotpluggable device memory). That way we do not need
to do invasive changes in the EDK2 FW to support a dynamic
RAM base.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c         | 30 ++++++++++++++++++++++++++++++
 include/hw/arm/virt.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ea1fb3ddfd..a89ffbf4d7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1771,6 +1771,32 @@ static HotplugHandler *virt_machine_get_hotplug_ha=
ndler(MachineState *machine,
     return NULL;
 }
=20
+/*
+ * for arm64 kvm_type [7-0] encodes the IPA size shift
+ */
+static int virt_kvm_type(MachineState *ms, const char *type_str)
+{
+    VirtMachineState *vms =3D VIRT_MACHINE(ms);
+    int max_vm_phys_shift =3D kvm_arm_get_max_vm_phys_shift(ms);
+    int max_pa_shift;
+
+    vms->extended_memmap =3D true;
+    /* device memory start/size aligned on 1GiB */
+    vms->high_io_base =3D ROUND_UP(GiB + ms->ram_size, GiB) +
+                        ROUND_UP(ms->maxram_size - ms->ram_size, GiB);
+
+    max_pa_shift =3D 64 - clz64(vms->high_io_base + TiB);
+
+    if (max_pa_shift > max_vm_phys_shift) {
+        error_report("-m and ,maxmem option values "
+                     "require an IPA range (%d bits) larger than "
+                     "the one supported by the host (%d bits)",
+                     max_pa_shift, max_vm_phys_shift);
+       exit(1);
+    }
+    return max_pa_shift;
+}
+
 static void virt_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
@@ -1795,6 +1821,7 @@ static void virt_machine_class_init(ObjectClass *oc=
, void *data)
     mc->cpu_index_to_instance_props =3D virt_cpu_index_to_props;
     mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a15");
     mc->get_default_cpu_node_id =3D virt_get_default_cpu_node_id;
+    mc->kvm_type =3D virt_kvm_type;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler =3D virt_machine_get_hotplug_handler;
     hc->plug =3D virt_machine_device_plug_cb;
@@ -1899,6 +1926,9 @@ static void virt_machine_3_1_options(MachineClass *=
mc)
 {
     virt_machine_4_0_options(mc);
     compat_props_add(mc->compat_props, hw_compat_3_1, hw_compat_3_1_len)=
;
+
+    /* extended memory map is enabled from 4.0 onwards */
+    mc->kvm_type =3D NULL;
 }
 DEFINE_VIRT_MACHINE(3, 1)
=20
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 3dc7a6c5d5..86d4c93120 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -132,6 +132,7 @@ typedef struct {
     uint32_t iommu_phandle;
     int psci_conduit;
     hwaddr high_io_base;
+    bool extended_memmap;
 } VirtMachineState;
=20
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
--=20
2.20.1
