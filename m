Received: from eggs.gnu.org ([2001:4830:134:3::10]:48151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1duDHw-00019B-20
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:49:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1duDHv-0001ZV-5M
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:49:48 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 19 Sep 2017 09:46:43 +0200
Message-Id: <1505807208-9063-12-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1505807208-9063-1-git-send-email-eric.auger@redhat.com>
References: <1505807208-9063-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v4 11/16] hw/arm/virt: Add 2.11 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, jean-philippe.brucker@arm.com
Cc: will.deacon@arm.com, kevin.tian@intel.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, drjones@redhat.com, wei@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com, linuc.decode@gmail.com

The new machine type allows virtio-iommu instantiation.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
---
 hw/arm/virt.c         | 23 +++++++++++++++++++++--
 include/hw/arm/virt.h |  1 +
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index cfd834d..9737a5f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1648,7 +1648,7 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
-static void virt_2_10_instance_init(Object *obj)
+static void virt_2_11_instance_init(Object *obj)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
@@ -1708,10 +1708,29 @@ static void virt_2_10_instance_init(Object *obj)
     vms->irqmap = a15irqmap;
 }
 
+static void virt_machine_2_11_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(2, 11)
+
+#define VIRT_COMPAT_2_10 \
+    HW_COMPAT_2_10
+
+static void virt_2_10_instance_init(Object *obj)
+{
+    virt_2_11_instance_init(obj);
+}
+
 static void virt_machine_2_10_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
+    virt_machine_2_11_options(mc);
+    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_10);
+
+    vmc->no_iommu = true;
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(2, 10)
+DEFINE_VIRT_MACHINE(2, 10)
 
 #define VIRT_COMPAT_2_9 \
     HW_COMPAT_2_9
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 33b0ff3..ff27551 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -84,6 +84,7 @@ typedef struct {
     bool disallow_affinity_adjustment;
     bool no_its;
     bool no_pmu;
+    bool no_iommu;
     bool claim_edge_triggered_timers;
 } VirtMachineClass;
 
-- 
2.5.5
