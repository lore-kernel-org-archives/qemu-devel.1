Received: from eggs.gnu.org ([2001:4830:134:3::10]:44249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqgNp-0006vk-TS
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:33:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqgNn-0001iM-L0
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:33:01 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 22 Mar 2017 14:32:27 +0100
Message-Id: <1490189568-167621-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 02/23] hw/arm/virt: extract
 mp-affinity calculation in separate function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/arm/virt.c | 59 ++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 17 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 5f62a03..484754e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1194,6 +1194,45 @@ void virt_machine_done(Notifier *notifier, void *data)
     virt_build_smbios(vms);
 }
 
+static uint64_t virt_idx2mp_affinity(VirtMachineState *vms, int idx)
+{
+    uint64_t mp_affinity;
+    uint8_t clustersz;
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
+
+    if (!vmc->disallow_affinity_adjustment) {
+        uint8_t aff0, aff1;
+
+        if (vms->gic_version == 3) {
+            clustersz = GICV3_TARGETLIST_BITS;
+        } else {
+            clustersz = GIC_TARGETLIST_BITS;
+        }
+
+        /* Adjust MPIDR like 64-bit KVM hosts, which incorporate the
+         * GIC's target-list limitations. 32-bit KVM hosts currently
+         * always create clusters of 4 CPUs, but that is expected to
+         * change when they gain support for gicv3. When KVM is enabled
+         * it will override the changes we make here, therefore our
+         * purposes are to make TCG consistent (with 64-bit KVM hosts)
+         * and to improve SGI efficiency.
+         */
+        aff1 = idx / clustersz;
+        aff0 = idx % clustersz;
+        mp_affinity = (aff1 << ARM_AFF1_SHIFT) | aff0;
+    } else {
+        /* This cpu-id-to-MPIDR affinity is used only for TCG;
+         * KVM will override it. We don't support setting cluster ID
+         * ([16..23]) (known as Aff2 in later ARM ARM versions), or any of
+         * the higher affinity level fields, so these bits always RAZ.
+         */
+        uint32_t Aff1 = idx / ARM_DEFAULT_CPUS_PER_CLUSTER;
+        uint32_t Aff0 = idx % ARM_DEFAULT_CPUS_PER_CLUSTER;
+        mp_affinity = (Aff1 << ARM_AFF1_SHIFT) | Aff0;
+    }
+    return mp_affinity;
+}
+
 static void machvirt_init(MachineState *machine)
 {
     VirtMachineState *vms = VIRT_MACHINE(machine);
@@ -1210,7 +1249,6 @@ static void machvirt_init(MachineState *machine)
     CPUClass *cc;
     Error *err = NULL;
     bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
-    uint8_t clustersz;
 
     if (!cpu_model) {
         cpu_model = "cortex-a15";
@@ -1263,10 +1301,8 @@ static void machvirt_init(MachineState *machine)
      */
     if (vms->gic_version == 3) {
         virt_max_cpus = vms->memmap[VIRT_GIC_REDIST].size / 0x20000;
-        clustersz = GICV3_TARGETLIST_BITS;
     } else {
         virt_max_cpus = GIC_NCPU;
-        clustersz = GIC_TARGETLIST_BITS;
     }
 
     if (max_cpus > virt_max_cpus) {
@@ -1326,20 +1362,9 @@ static void machvirt_init(MachineState *machine)
 
     for (n = 0; n < smp_cpus; n++) {
         Object *cpuobj = object_new(typename);
-        if (!vmc->disallow_affinity_adjustment) {
-            /* Adjust MPIDR like 64-bit KVM hosts, which incorporate the
-             * GIC's target-list limitations. 32-bit KVM hosts currently
-             * always create clusters of 4 CPUs, but that is expected to
-             * change when they gain support for gicv3. When KVM is enabled
-             * it will override the changes we make here, therefore our
-             * purposes are to make TCG consistent (with 64-bit KVM hosts)
-             * and to improve SGI efficiency.
-             */
-            uint8_t aff1 = n / clustersz;
-            uint8_t aff0 = n % clustersz;
-            object_property_set_int(cpuobj, (aff1 << ARM_AFF1_SHIFT) | aff0,
-                                    "mp-affinity", NULL);
-        }
+
+        object_property_set_int(cpuobj, virt_idx2mp_affinity(vms, n),
+                                "mp-affinity", NULL);
 
         if (!vms->secure) {
             object_property_set_bool(cpuobj, false, "has_el3", NULL);
-- 
2.7.4
