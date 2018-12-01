Received: from eggs.gnu.org ([2001:4830:134:3::10]:60612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gSsvt-0002Kt-HU
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 19:14:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gSsvp-0006ls-L0
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 19:14:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gSsvp-0006lc-DX
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 19:14:49 -0500
From: Alex Williamson <alex.williamson@redhat.com>
Date: Fri, 30 Nov 2018 17:14:42 -0700
Message-ID: <154362328267.7153.14787469935288240705.stgit@gimli.home>
In-Reply-To: <154362272919.7153.15101701755308287523.stgit@gimli.home>
References: <154362272919.7153.15101701755308287523.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-3.2 PATCH 8/9] q35/440fx/arm/spapr: Add QEMU 3.2
 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Including all machine types that might have a pcie-root-port.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/arm/virt.c        |   19 +++++++++++++++++--
 hw/i386/pc_piix.c    |   15 ++++++++++++---
 hw/i386/pc_q35.c     |   13 +++++++++++--
 hw/ppc/spapr.c       |   25 ++++++++++++++++++++++---
 include/hw/compat.h  |    3 +++
 include/hw/i386/pc.h |    3 +++
 6 files changed, 68 insertions(+), 10 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f69e7eb39977..edffb0309801 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1797,7 +1797,7 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
-static void virt_3_1_instance_init(Object *obj)
+static void virt_3_2_instance_init(Object *obj)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
@@ -1867,10 +1867,25 @@ static void virt_3_1_instance_init(Object *obj)
     vms->irqmap = a15irqmap;
 }
 
+static void virt_machine_3_2_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(3, 2)
+
+#define VIRT_COMPAT_3_1 \
+    HW_COMPAT_3_1
+
+static void virt_3_1_instance_init(Object *obj)
+{
+    virt_3_2_instance_init(obj);
+}
+
 static void virt_machine_3_1_options(MachineClass *mc)
 {
+    virt_machine_3_2_options(mc);
+    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_3_1);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(3, 1)
+DEFINE_VIRT_MACHINE(3, 1)
 
 #define VIRT_COMPAT_3_0 \
     HW_COMPAT_3_0
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 7092d6d13f66..f0403ad69493 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -428,21 +428,30 @@ static void pc_i440fx_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
 }
 
-static void pc_i440fx_3_1_machine_options(MachineClass *m)
+static void pc_i440fx_3_2_machine_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = 1;
 }
 
+DEFINE_I440FX_MACHINE(v3_2, "pc-i440fx-3.2", NULL,
+                      pc_i440fx_3_2_machine_options);
+
+static void pc_i440fx_3_1_machine_options(MachineClass *m)
+{
+    pc_i440fx_3_2_machine_options(m);
+    m->is_default = 0;
+    m->alias = NULL;
+    SET_MACHINE_COMPAT(m, PC_COMPAT_3_1);
+}
+
 DEFINE_I440FX_MACHINE(v3_1, "pc-i440fx-3.1", NULL,
                       pc_i440fx_3_1_machine_options);
 
 static void pc_i440fx_3_0_machine_options(MachineClass *m)
 {
     pc_i440fx_3_1_machine_options(m);
-    m->is_default = 0;
-    m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_3_0);
 }
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 4702bb13c472..92d7142d6a42 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -311,19 +311,28 @@ static void pc_q35_machine_options(MachineClass *m)
     m->max_cpus = 288;
 }
 
-static void pc_q35_3_1_machine_options(MachineClass *m)
+static void pc_q35_3_2_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
 }
 
+DEFINE_Q35_MACHINE(v3_2, "pc-q35-3.2", NULL,
+                   pc_q35_3_2_machine_options);
+
+static void pc_q35_3_1_machine_options(MachineClass *m)
+{
+    pc_q35_3_2_machine_options(m);
+    m->alias = NULL;
+    SET_MACHINE_COMPAT(m, PC_COMPAT_3_1);
+}
+
 DEFINE_Q35_MACHINE(v3_1, "pc-q35-3.1", NULL,
                    pc_q35_3_1_machine_options);
 
 static void pc_q35_3_0_machine_options(MachineClass *m)
 {
     pc_q35_3_1_machine_options(m);
-    m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_3_0);
 }
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 7afd1a175bf2..1677548e8562 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3956,19 +3956,38 @@ static const TypeInfo spapr_machine_info = {
     }                                                                \
     type_init(spapr_machine_register_##suffix)
 
- /*
+/*
+ * pseries-3.2
+ */
+static void spapr_machine_3_2_instance_options(MachineState *machine)
+{
+}
+
+static void spapr_machine_3_2_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class */
+}
+
+DEFINE_SPAPR_MACHINE(3_2, "3.2", true);
+
+/*
  * pseries-3.1
  */
+#define SPAPR_COMPAT_3_1                                              \
+    HW_COMPAT_3_1
+
 static void spapr_machine_3_1_instance_options(MachineState *machine)
 {
+    spapr_machine_3_2_instance_options(machine);
 }
 
 static void spapr_machine_3_1_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    spapr_machine_3_1_class_options(mc);
+    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_1);
 }
 
-DEFINE_SPAPR_MACHINE(3_1, "3.1", true);
+DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
 
 /*
  * pseries-3.0
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 6f4d5fc64704..70958328fe7a 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,6 +1,9 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
 
+#define HW_COMPAT_3_1 \
+    /* empty */
+
 #define HW_COMPAT_3_0 \
     /* empty */
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 136fe497b6b2..cb645bf368a3 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -294,6 +294,9 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
 int e820_get_num_entries(void);
 bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
+#define PC_COMPAT_3_1 \
+    HW_COMPAT_3_1 \
+
 #define PC_COMPAT_3_0 \
     HW_COMPAT_3_0 \
     {\
