Received: from eggs.gnu.org ([209.51.188.92]:54388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hEWrq-0002Us-Nq
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hEWox-0003X1-4W
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:20:40 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 11 Apr 2019 12:20:25 +0200
Message-Id: <20190411102025.22559-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH for-4.1] hw: add compat machines for 4.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>

Add 4.1 machine types for arm/i440fx/q35/s390x/spapr.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---

IIRC, we agreed last time that we want to merge a patch introducing
the new compat machines first thing in a new development cycle. So
here's that patch for 4.1.

---
 hw/arm/virt.c              |  9 ++++++++-
 hw/core/machine.c          |  3 +++
 hw/i386/pc.c               |  3 +++
 hw/i386/pc_piix.c          | 14 +++++++++++++-
 hw/i386/pc_q35.c           | 13 ++++++++++++-
 hw/ppc/spapr.c             | 15 +++++++++++++--
 hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
 include/hw/boards.h        |  3 +++
 include/hw/i386/pc.h       |  3 +++
 9 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ce2664a30b7f..16ba67f7a768 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1978,10 +1978,17 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
+static void virt_machine_4_1_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(4, 1)
+
 static void virt_machine_4_0_options(MachineClass *mc)
 {
+    virt_machine_4_1_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_len);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(4, 0)
+DEFINE_VIRT_MACHINE(4, 0)
 
 static void virt_machine_3_1_options(MachineClass *mc)
 {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 743fef28982c..5d046a43e3d2 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -24,6 +24,9 @@
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
 
+GlobalProperty hw_compat_4_0[] = {};
+const size_t hw_compat_4_0_len = G_N_ELEMENTS(hw_compat_4_0);
+
 GlobalProperty hw_compat_3_1[] = {
     { "pcie-root-port", "x-speed", "2_5" },
     { "pcie-root-port", "x-width", "1" },
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f2c15bf1f2c3..868303cf6427 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -115,6 +115,9 @@ struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
 /* Physical Address of PVH entry point read from kernel ELF NOTE */
 static size_t pvh_start_addr;
 
+GlobalProperty pc_compat_4_0[] ={};
+const size_t pc_compat_4_0_len = G_N_ELEMENTS(pc_compat_4_0);
+
 GlobalProperty pc_compat_3_1[] = {
     { "intel-iommu", "dma-drain", "off" },
     { "Opteron_G3" "-" TYPE_X86_CPU, "rdtscp", "off" },
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 8ad8e885c6b1..2a7700b564d3 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -428,13 +428,25 @@ static void pc_i440fx_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
 }
 
-static void pc_i440fx_4_0_machine_options(MachineClass *m)
+static void pc_i440fx_4_1_machine_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = 1;
 }
 
+DEFINE_I440FX_MACHINE(v4_1, "pc-i440fx-4.1", NULL,
+                      pc_i440fx_4_1_machine_options);
+
+static void pc_i440fx_4_0_machine_options(MachineClass *m)
+{
+    pc_i440fx_4_1_machine_options(m);
+    m->alias = NULL;
+    m->is_default = 0;
+    compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
+    compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
+}
+
 DEFINE_I440FX_MACHINE(v4_0, "pc-i440fx-4.0", NULL,
                       pc_i440fx_4_0_machine_options);
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 372c6b73bebd..37dd350511a9 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -365,12 +365,23 @@ static void pc_q35_machine_options(MachineClass *m)
     m->max_cpus = 288;
 }
 
-static void pc_q35_4_0_machine_options(MachineClass *m)
+static void pc_q35_4_1_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
 }
 
+DEFINE_Q35_MACHINE(v4_1, "pc-q35-4.1", NULL,
+                   pc_q35_4_1_machine_options);
+
+static void pc_q35_4_0_machine_options(MachineClass *m)
+{
+    pc_q35_4_1_machine_options(m);
+    m->alias = NULL;
+    compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
+    compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
+}
+
 DEFINE_Q35_MACHINE(v4_0, "pc-q35-4.0", NULL,
                    pc_q35_4_0_machine_options);
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b52b82d298ef..8438741ec23c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4344,15 +4344,26 @@ static const TypeInfo spapr_machine_info = {
     }                                                                \
     type_init(spapr_machine_register_##suffix)
 
+/*
+ * pseries-4.1
+ */
+static void spapr_machine_4_1_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class */
+}
+
+DEFINE_SPAPR_MACHINE(4_1, "4.1", true);
+
 /*
  * pseries-4.0
  */
 static void spapr_machine_4_0_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    spapr_machine_4_1_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_len);
 }
 
-DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
+DEFINE_SPAPR_MACHINE(4_0, "4.0", false);
 
 /*
  * pseries-3.1
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index d11069b860b4..02470e78c74d 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -646,14 +646,26 @@ bool css_migration_enabled(void)
     }                                                                         \
     type_init(ccw_machine_register_##suffix)
 
+static void ccw_machine_4_1_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_4_1_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE(4_1, "4.1", true);
+
 static void ccw_machine_4_0_instance_options(MachineState *machine)
 {
+    ccw_machine_4_1_instance_options(machine);
 }
 
 static void ccw_machine_4_0_class_options(MachineClass *mc)
 {
+    ccw_machine_4_1_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_len);
 }
-DEFINE_CCW_MACHINE(4_0, "4.0", true);
+DEFINE_CCW_MACHINE(4_0, "4.0", false);
 
 static void ccw_machine_3_1_instance_options(MachineState *machine)
 {
diff --git a/include/hw/boards.h b/include/hw/boards.h
index e231860666a1..fe1885cbffa0 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -293,6 +293,9 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
 
+extern GlobalProperty hw_compat_4_0[];
+extern const size_t hw_compat_4_0_len;
+
 extern GlobalProperty hw_compat_3_1[];
 extern const size_t hw_compat_3_1_len;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ca65ef18afb4..43df7230a22b 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -293,6 +293,9 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
 int e820_get_num_entries(void);
 bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
+extern GlobalProperty pc_compat_4_0[];
+extern const size_t pc_compat_4_0_len;
+
 extern GlobalProperty pc_compat_3_1[];
 extern const size_t pc_compat_3_1_len;
 
-- 
2.17.2
