Received: from eggs.gnu.org ([209.51.188.92]:47490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gyd8W-0000Bv-8E
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:51:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gyd8V-00074v-6z
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:51:08 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 26 Feb 2019 14:50:04 +0100
Message-Id: <20190226135014.31854-9-eric.auger@redhat.com>
In-Reply-To: <20190226135014.31854-1-eric.auger@redhat.com>
References: <20190226135014.31854-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 08/18] hw/arm/virt: Implement kvm_type
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
Cc: dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com, pbonzini@redhat.com

This patch implements the machine class kvm_type() callback.
It returns the number of bits requested to implement the whole GPA
range including the RAM and IO regions located beyond.
The returned value in passed though the KVM_CREATE_VM ioctl and
this allows KVM to set the stage2 tables dynamically.

To compute the highest GPA used in the memory map, kvm_type()
must freeze the memory map by calling virt_set_memmap().

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v7 -> v8:
- remove vmc->no_extended_memmap and vms->extended_memmap

v6 -> v7:
- Introduce RAMBASE and rename add LEGACY_ prefix in that patch
- use local variables with explicit names in virt_set_memmap:
  device_memory_base, device_memory_size
- add an extended_memmap field in the class

v5 -> v6:
- add some comments
- high IO region cannot start before 256GiB
---
 hw/arm/virt.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 172bb6c140..3981916931 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1828,6 +1828,36 @@ static HotplugHandler *virt_machine_get_hotplug_ha=
ndler(MachineState *machine,
     return NULL;
 }
=20
+/*
+ * for arm64 kvm_type [7-0] encodes the requested number of bits
+ * in the IPA address space
+ */
+static int virt_kvm_type(MachineState *ms, const char *type_str)
+{
+    VirtMachineState *vms =3D VIRT_MACHINE(ms);
+    int max_vm_pa_size =3D kvm_arm_get_max_vm_ipa_size(ms);
+    int requested_pa_size;
+
+    /* we freeze the memory map to compute the highest gpa */
+    virt_set_memmap(vms);
+
+    requested_pa_size =3D 64 - clz64(vms->highest_gpa);
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
     MachineClass *mc =3D MACHINE_CLASS(oc);
@@ -1852,6 +1882,7 @@ static void virt_machine_class_init(ObjectClass *oc=
, void *data)
     mc->cpu_index_to_instance_props =3D virt_cpu_index_to_props;
     mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a15");
     mc->get_default_cpu_node_id =3D virt_get_default_cpu_node_id;
+    mc->kvm_type =3D virt_kvm_type;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler =3D virt_machine_get_hotplug_handler;
     hc->plug =3D virt_machine_device_plug_cb;
@@ -1923,7 +1954,13 @@ static void virt_instance_init(Object *obj)
                                     "Valid values are none and smmuv3",
                                     NULL);
=20
-    virt_set_memmap(vms);
+    /*
+     * In accelerated mode, the memory map is computed in kvm_type()
+     * to create a VM with the right number of IPA bits.
+     */
+    if (!kvm_enabled()) {
+        virt_set_memmap(vms);
+    }
=20
     vms->irqmap =3D a15irqmap;
 }
--=20
2.20.1
