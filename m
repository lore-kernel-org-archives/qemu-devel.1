Received: from eggs.gnu.org ([2001:4830:134:3::10]:54280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaXfT-0007Gy-R1
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 21:05:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaXfO-0006zo-QF
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 21:05:03 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Jan 2018 23:04:12 -0300
Message-Id: <20180114020412.26160-4-f4bug@amsat.org>
In-Reply-To: <20180114020412.26160-1-f4bug@amsat.org>
References: <20180114020412.26160-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 3/3] qdev: use
 device_class_set_parent_realize/unrealize/reset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>, Fam Zheng <famz@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, Anthony Green <green@moxielogic.com>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Max Filippov <jcmvbkbc@gmail.com>, "open list:ARM cores" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>, "open list:S390" <qemu-s390x@nongnu.org>

changes generated using the following Coccinelle patch:

  @@
  type DeviceParentClass;
  DeviceParentClass *pc;
  DeviceClass *dc;
  identifier parent_fn;
  identifier child_fn;
  @@
  (
  +device_class_set_parent_realize(dc, child_fn, &pc->parent_fn);
  -pc->parent_fn = dc->realize;
  ...
  -dc->realize = child_fn;
  |
  +device_class_set_parent_unrealize(dc, child_fn, &pc->parent_fn);
  -pc->parent_fn = dc->unrealize;
  ...
  -dc->unrealize = child_fn;
  |
  +device_class_set_parent_reset(dc, child_fn, &pc->parent_fn);
  -pc->parent_fn = dc->reset;
  ...
  -dc->reset = child_fn;
  )

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/i386/kvm/i8254.c                | 4 ++--
 hw/i386/kvm/i8259.c                | 3 +--
 hw/input/adb-kbd.c                 | 4 ++--
 hw/input/adb-mouse.c               | 4 ++--
 hw/intc/arm_gic.c                  | 3 +--
 hw/intc/arm_gic_kvm.c              | 7 +++----
 hw/intc/arm_gicv3.c                | 3 +--
 hw/intc/arm_gicv3_its_kvm.c        | 3 +--
 hw/intc/arm_gicv3_kvm.c            | 7 +++----
 hw/intc/i8259.c                    | 3 +--
 hw/net/vmxnet3.c                   | 4 ++--
 hw/pci-bridge/gen_pcie_root_port.c | 3 +--
 hw/scsi/vmw_pvscsi.c               | 4 ++--
 hw/timer/i8254.c                   | 3 +--
 hw/vfio/amd-xgbe.c                 | 4 ++--
 hw/vfio/calxeda-xgmac.c            | 4 ++--
 hw/virtio/virtio-pci.c             | 4 ++--
 target/alpha/cpu.c                 | 4 ++--
 target/arm/cpu.c                   | 4 ++--
 target/cris/cpu.c                  | 4 ++--
 target/hppa/cpu.c                  | 4 ++--
 target/i386/cpu.c                  | 8 ++++----
 target/lm32/cpu.c                  | 5 ++---
 target/m68k/cpu.c                  | 5 ++---
 target/microblaze/cpu.c            | 5 ++---
 target/mips/cpu.c                  | 5 ++---
 target/moxie/cpu.c                 | 5 ++---
 target/nios2/cpu.c                 | 4 ++--
 target/openrisc/cpu.c              | 5 ++---
 target/ppc/translate_init.c        | 8 ++++----
 target/s390x/cpu.c                 | 4 ++--
 target/sh4/cpu.c                   | 4 ++--
 target/sparc/cpu.c                 | 4 ++--
 target/tilegx/cpu.c                | 4 ++--
 target/tricore/cpu.c               | 4 ++--
 target/unicore32/cpu.c             | 4 ++--
 target/xtensa/cpu.c                | 4 ++--
 37 files changed, 73 insertions(+), 88 deletions(-)

diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index 521a58498a..13f20f47d9 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -315,8 +315,8 @@ static void kvm_pit_class_init(ObjectClass *klass, void *data)
     PITCommonClass *k = PIT_COMMON_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    kpc->parent_realize = dc->realize;
-    dc->realize = kvm_pit_realizefn;
+    device_class_set_parent_realize(dc, kvm_pit_realizefn,
+                                    &kpc->parent_realize);
     k->set_channel_gate = kvm_pit_set_gate;
     k->get_channel_info = kvm_pit_get_channel_info;
     dc->reset = kvm_pit_reset;
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index b91e98074e..05394cdb7b 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -142,8 +142,7 @@ static void kvm_i8259_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->reset     = kvm_pic_reset;
-    kpc->parent_realize = dc->realize;
-    dc->realize   = kvm_pic_realize;
+    device_class_set_parent_realize(dc, kvm_pic_realize, &kpc->parent_realize);
     k->pre_save   = kvm_pic_get;
     k->post_load  = kvm_pic_put;
 }
diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index 354f56e41e..266aed1b7b 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -374,8 +374,8 @@ static void adb_kbd_class_init(ObjectClass *oc, void *data)
     ADBDeviceClass *adc = ADB_DEVICE_CLASS(oc);
     ADBKeyboardClass *akc = ADB_KEYBOARD_CLASS(oc);
 
-    akc->parent_realize = dc->realize;
-    dc->realize = adb_kbd_realizefn;
+    device_class_set_parent_realize(dc, adb_kbd_realizefn,
+                                    &akc->parent_realize);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 
     adc->devreq = adb_kbd_request;
diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
index c9004233b8..47e88faf25 100644
--- a/hw/input/adb-mouse.c
+++ b/hw/input/adb-mouse.c
@@ -228,8 +228,8 @@ static void adb_mouse_class_init(ObjectClass *oc, void *data)
     ADBDeviceClass *adc = ADB_DEVICE_CLASS(oc);
     ADBMouseClass *amc = ADB_MOUSE_CLASS(oc);
 
-    amc->parent_realize = dc->realize;
-    dc->realize = adb_mouse_realizefn;
+    device_class_set_parent_realize(dc, adb_mouse_realizefn,
+                                    &amc->parent_realize);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 
     adc->devreq = adb_mouse_request;
diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index d701e49ff9..9e0a5ea725 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -1444,8 +1444,7 @@ static void arm_gic_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     ARMGICClass *agc = ARM_GIC_CLASS(klass);
 
-    agc->parent_realize = dc->realize;
-    dc->realize = arm_gic_realize;
+    device_class_set_parent_realize(dc, arm_gic_realize, &agc->parent_realize);
 }
 
 static const TypeInfo arm_gic_info = {
diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
index ae095d08a3..6f467e68a8 100644
--- a/hw/intc/arm_gic_kvm.c
+++ b/hw/intc/arm_gic_kvm.c
@@ -591,10 +591,9 @@ static void kvm_arm_gic_class_init(ObjectClass *klass, void *data)
 
     agcc->pre_save = kvm_arm_gic_get;
     agcc->post_load = kvm_arm_gic_put;
-    kgc->parent_realize = dc->realize;
-    kgc->parent_reset = dc->reset;
-    dc->realize = kvm_arm_gic_realize;
-    dc->reset = kvm_arm_gic_reset;
+    device_class_set_parent_realize(dc, kvm_arm_gic_realize,
+                                    &kgc->parent_realize);
+    device_class_set_parent_reset(dc, kvm_arm_gic_reset, &kgc->parent_reset);
 }
 
 static const TypeInfo kvm_arm_gic_info = {
diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
index f0c967b304..479c66733c 100644
--- a/hw/intc/arm_gicv3.c
+++ b/hw/intc/arm_gicv3.c
@@ -385,8 +385,7 @@ static void arm_gicv3_class_init(ObjectClass *klass, void *data)
     ARMGICv3Class *agc = ARM_GICV3_CLASS(klass);
 
     agcc->post_load = arm_gicv3_post_load;
-    agc->parent_realize = dc->realize;
-    dc->realize = arm_gic_realize;
+    device_class_set_parent_realize(dc, arm_gic_realize, &agc->parent_realize);
 }
 
 static const TypeInfo arm_gicv3_info = {
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index bf290b8bff..eea6a73df2 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -245,11 +245,10 @@ static void kvm_arm_its_class_init(ObjectClass *klass, void *data)
 
     dc->realize = kvm_arm_its_realize;
     dc->props   = kvm_arm_its_props;
-    ic->parent_reset = dc->reset;
+    device_class_set_parent_reset(dc, kvm_arm_its_reset, &ic->parent_reset);
     icc->send_msi = kvm_its_send_msi;
     icc->pre_save = kvm_arm_its_pre_save;
     icc->post_load = kvm_arm_its_post_load;
-    dc->reset = kvm_arm_its_reset;
 }
 
 static const TypeInfo kvm_arm_its_info = {
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 481fe5405a..ec371772b3 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -795,10 +795,9 @@ static void kvm_arm_gicv3_class_init(ObjectClass *klass, void *data)
 
     agcc->pre_save = kvm_arm_gicv3_get;
     agcc->post_load = kvm_arm_gicv3_put;
-    kgc->parent_realize = dc->realize;
-    kgc->parent_reset = dc->reset;
-    dc->realize = kvm_arm_gicv3_realize;
-    dc->reset = kvm_arm_gicv3_reset;
+    device_class_set_parent_realize(dc, kvm_arm_gicv3_realize,
+                                    &kgc->parent_realize);
+    device_class_set_parent_reset(dc, kvm_arm_gicv3_reset, &kgc->parent_reset);
 }
 
 static const TypeInfo kvm_arm_gicv3_info = {
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 1602255a87..76f3d873b8 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -443,8 +443,7 @@ static void i8259_class_init(ObjectClass *klass, void *data)
     PICClass *k = PIC_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    k->parent_realize = dc->realize;
-    dc->realize = pic_realize;
+    device_class_set_parent_realize(dc, pic_realize, &k->parent_realize);
     dc->reset = pic_reset;
 }
 
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 0654d594c1..3648630386 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2664,8 +2664,8 @@ static void vmxnet3_class_init(ObjectClass *class, void *data)
     c->class_id = PCI_CLASS_NETWORK_ETHERNET;
     c->subsystem_vendor_id = PCI_VENDOR_ID_VMWARE;
     c->subsystem_id = PCI_DEVICE_ID_VMWARE_VMXNET3;
-    vc->parent_dc_realize = dc->realize;
-    dc->realize = vmxnet3_realize;
+    device_class_set_parent_realize(dc, vmxnet3_realize,
+                                    &vc->parent_dc_realize);
     dc->desc = "VMWare Paravirtualized Ethernet v3";
     dc->reset = vmxnet3_qdev_reset;
     dc->vmsd = &vmstate_vmxnet3;
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index ad4e6aa7ff..4a3b13d02c 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -132,8 +132,7 @@ static void gen_rp_dev_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_rp_dev;
     dc->props = gen_rp_props;
 
-    rpc->parent_realize = dc->realize;
-    dc->realize = gen_rp_realize;
+    device_class_set_parent_realize(dc, gen_rp_realize, &rpc->parent_realize);
 
     rpc->aer_vector = gen_rp_aer_vector;
     rpc->interrupts_init = gen_rp_interrupts_init;
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 27749c0e42..a3a019e30a 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1284,8 +1284,8 @@ static void pvscsi_class_init(ObjectClass *klass, void *data)
     k->device_id = PCI_DEVICE_ID_VMWARE_PVSCSI;
     k->class_id = PCI_CLASS_STORAGE_SCSI;
     k->subsystem_id = 0x1000;
-    pvs_k->parent_dc_realize = dc->realize;
-    dc->realize = pvscsi_realize;
+    device_class_set_parent_realize(dc, pvscsi_realize,
+                                    &pvs_k->parent_dc_realize);
     dc->reset = pvscsi_reset;
     dc->vmsd = &vmstate_pvscsi;
     dc->props = pvscsi_properties;
diff --git a/hw/timer/i8254.c b/hw/timer/i8254.c
index dbc4a0baec..1057850808 100644
--- a/hw/timer/i8254.c
+++ b/hw/timer/i8254.c
@@ -358,8 +358,7 @@ static void pit_class_initfn(ObjectClass *klass, void *data)
     PITCommonClass *k = PIT_COMMON_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    pc->parent_realize = dc->realize;
-    dc->realize = pit_realizefn;
+    device_class_set_parent_realize(dc, pit_realizefn, &pc->parent_realize);
     k->set_channel_gate = pit_set_channel_gate;
     k->get_channel_info = pit_get_channel_info_common;
     k->post_load = pit_post_load;
diff --git a/hw/vfio/amd-xgbe.c b/hw/vfio/amd-xgbe.c
index fab196cebf..0c4ec4ba25 100644
--- a/hw/vfio/amd-xgbe.c
+++ b/hw/vfio/amd-xgbe.c
@@ -34,8 +34,8 @@ static void vfio_amd_xgbe_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     VFIOAmdXgbeDeviceClass *vcxc =
         VFIO_AMD_XGBE_DEVICE_CLASS(klass);
-    vcxc->parent_realize = dc->realize;
-    dc->realize = amd_xgbe_realize;
+    device_class_set_parent_realize(dc, amd_xgbe_realize,
+                                    &vcxc->parent_realize);
     dc->desc = "VFIO AMD XGBE";
     dc->vmsd = &vfio_platform_amd_xgbe_vmstate;
     /* Supported by TYPE_VIRT_MACHINE */
diff --git a/hw/vfio/calxeda-xgmac.c b/hw/vfio/calxeda-xgmac.c
index 7bb17af7ad..24cee6d065 100644
--- a/hw/vfio/calxeda-xgmac.c
+++ b/hw/vfio/calxeda-xgmac.c
@@ -34,8 +34,8 @@ static void vfio_calxeda_xgmac_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     VFIOCalxedaXgmacDeviceClass *vcxc =
         VFIO_CALXEDA_XGMAC_DEVICE_CLASS(klass);
-    vcxc->parent_realize = dc->realize;
-    dc->realize = calxeda_xgmac_realize;
+    device_class_set_parent_realize(dc, calxeda_xgmac_realize,
+                                    &vcxc->parent_realize);
     dc->desc = "VFIO Calxeda XGMAC";
     dc->vmsd = &vfio_platform_calxeda_xgmac_vmstate;
     /* Supported by TYPE_VIRT_MACHINE */
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 6c75cca88a..3eeb98c4cf 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1907,8 +1907,8 @@ static void virtio_pci_class_init(ObjectClass *klass, void *data)
     k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
     k->revision = VIRTIO_PCI_ABI_VERSION;
     k->class_id = PCI_CLASS_OTHERS;
-    vpciklass->parent_dc_realize = dc->realize;
-    dc->realize = virtio_pci_dc_realize;
+    device_class_set_parent_realize(dc, virtio_pci_dc_realize,
+                                    &vpciklass->parent_dc_realize);
     dc->reset = virtio_pci_reset;
 }
 
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 7d6366bae9..55675ce419 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -233,8 +233,8 @@ static void alpha_cpu_class_init(ObjectClass *oc, void *data)
     CPUClass *cc = CPU_CLASS(oc);
     AlphaCPUClass *acc = ALPHA_CPU_CLASS(oc);
 
-    acc->parent_realize = dc->realize;
-    dc->realize = alpha_cpu_realizefn;
+    device_class_set_parent_realize(dc, alpha_cpu_realizefn,
+                                    &acc->parent_realize);
 
     cc->class_by_name = alpha_cpu_class_by_name;
     cc->has_work = alpha_cpu_has_work;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index cc1856c32b..2b29747b9f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1722,8 +1722,8 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     CPUClass *cc = CPU_CLASS(acc);
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    acc->parent_realize = dc->realize;
-    dc->realize = arm_cpu_realizefn;
+    device_class_set_parent_realize(dc, arm_cpu_realizefn,
+                                    &acc->parent_realize);
     dc->props = arm_cpu_properties;
 
     acc->parent_reset = cc->reset;
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 949c7a6e25..db8d0884a1 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -260,8 +260,8 @@ static void cris_cpu_class_init(ObjectClass *oc, void *data)
     CPUClass *cc = CPU_CLASS(oc);
     CRISCPUClass *ccc = CRIS_CPU_CLASS(oc);
 
-    ccc->parent_realize = dc->realize;
-    dc->realize = cris_cpu_realizefn;
+    device_class_set_parent_realize(dc, cris_cpu_realizefn,
+                                    &ccc->parent_realize);
 
     ccc->parent_reset = cc->reset;
     cc->reset = cris_cpu_reset;
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 9e7b0d4ccb..899464ae87 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -121,8 +121,8 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
     CPUClass *cc = CPU_CLASS(oc);
     HPPACPUClass *acc = HPPA_CPU_CLASS(oc);
 
-    acc->parent_realize = dc->realize;
-    dc->realize = hppa_cpu_realizefn;
+    device_class_set_parent_realize(dc, hppa_cpu_realizefn,
+                                    &acc->parent_realize);
 
     cc->class_by_name = hppa_cpu_class_by_name;
     cc->do_interrupt = hppa_cpu_do_interrupt;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3818d72831..3573cfab65 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4216,10 +4216,10 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     CPUClass *cc = CPU_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    xcc->parent_realize = dc->realize;
-    xcc->parent_unrealize = dc->unrealize;
-    dc->realize = x86_cpu_realizefn;
-    dc->unrealize = x86_cpu_unrealizefn;
+    device_class_set_parent_realize(dc, x86_cpu_realizefn,
+                                    &xcc->parent_realize);
+    device_class_set_parent_unrealize(dc, x86_cpu_unrealizefn,
+                                      &xcc->parent_unrealize);
     dc->props = x86_cpu_properties;
 
     xcc->parent_reset = cc->reset;
diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
index 6f5c14767b..96c2499d0b 100644
--- a/target/lm32/cpu.c
+++ b/target/lm32/cpu.c
@@ -236,9 +236,8 @@ static void lm32_cpu_class_init(ObjectClass *oc, void *data)
     CPUClass *cc = CPU_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    lcc->parent_realize = dc->realize;
-    dc->realize = lm32_cpu_realizefn;
-
+    device_class_set_parent_realize(dc, lm32_cpu_realizefn,
+                                    &lcc->parent_realize);
     lcc->parent_reset = cc->reset;
     cc->reset = lm32_cpu_reset;
 
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 03126ba543..a07c568297 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -255,9 +255,8 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
     CPUClass *cc = CPU_CLASS(c);
     DeviceClass *dc = DEVICE_CLASS(c);
 
-    mcc->parent_realize = dc->realize;
-    dc->realize = m68k_cpu_realizefn;
-
+    device_class_set_parent_realize(dc, m68k_cpu_realizefn,
+                                    &mcc->parent_realize);
     mcc->parent_reset = cc->reset;
     cc->reset = m68k_cpu_reset;
 
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 5700652e06..d8df2fb07e 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -258,9 +258,8 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
     CPUClass *cc = CPU_CLASS(oc);
     MicroBlazeCPUClass *mcc = MICROBLAZE_CPU_CLASS(oc);
 
-    mcc->parent_realize = dc->realize;
-    dc->realize = mb_cpu_realizefn;
-
+    device_class_set_parent_realize(dc, mb_cpu_realizefn,
+                                    &mcc->parent_realize);
     mcc->parent_reset = cc->reset;
     cc->reset = mb_cpu_reset;
 
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 069f93560e..497706b669 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -174,9 +174,8 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
     CPUClass *cc = CPU_CLASS(c);
     DeviceClass *dc = DEVICE_CLASS(c);
 
-    mcc->parent_realize = dc->realize;
-    dc->realize = mips_cpu_realizefn;
-
+    device_class_set_parent_realize(dc, mips_cpu_realizefn,
+                                    &mcc->parent_realize);
     mcc->parent_reset = cc->reset;
     cc->reset = mips_cpu_reset;
 
diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
index f1389e5097..4170284da6 100644
--- a/target/moxie/cpu.c
+++ b/target/moxie/cpu.c
@@ -102,9 +102,8 @@ static void moxie_cpu_class_init(ObjectClass *oc, void *data)
     CPUClass *cc = CPU_CLASS(oc);
     MoxieCPUClass *mcc = MOXIE_CPU_CLASS(oc);
 
-    mcc->parent_realize = dc->realize;
-    dc->realize = moxie_cpu_realizefn;
-
+    device_class_set_parent_realize(dc, moxie_cpu_realizefn,
+                                    &mcc->parent_realize);
     mcc->parent_reset = cc->reset;
     cc->reset = moxie_cpu_reset;
 
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index 4742e52c78..fbfaa2ce26 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -187,8 +187,8 @@ static void nios2_cpu_class_init(ObjectClass *oc, void *data)
     CPUClass *cc = CPU_CLASS(oc);
     Nios2CPUClass *ncc = NIOS2_CPU_CLASS(oc);
 
-    ncc->parent_realize = dc->realize;
-    dc->realize = nios2_cpu_realizefn;
+    device_class_set_parent_realize(dc, nios2_cpu_realizefn,
+                                    &ncc->parent_realize);
     dc->props = nios2_properties;
     ncc->parent_reset = cc->reset;
     cc->reset = nios2_cpu_reset;
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index e0394b8b06..20b115afae 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -132,9 +132,8 @@ static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
     CPUClass *cc = CPU_CLASS(occ);
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    occ->parent_realize = dc->realize;
-    dc->realize = openrisc_cpu_realizefn;
-
+    device_class_set_parent_realize(dc, openrisc_cpu_realizefn,
+                                    &occ->parent_realize);
     occ->parent_reset = cc->reset;
     cc->reset = openrisc_cpu_reset;
 
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 70ff15a51a..566cf552e0 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10556,12 +10556,12 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
     CPUClass *cc = CPU_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    pcc->parent_realize = dc->realize;
-    pcc->parent_unrealize = dc->unrealize;
+    device_class_set_parent_realize(dc, ppc_cpu_realizefn,
+                                    &pcc->parent_realize);
+    device_class_set_parent_unrealize(dc, ppc_cpu_unrealizefn,
+                                      &pcc->parent_unrealize);
     pcc->pvr_match = ppc_pvr_match_default;
     pcc->interrupts_big_endian = ppc_cpu_interrupts_big_endian_always;
-    dc->realize = ppc_cpu_realizefn;
-    dc->unrealize = ppc_cpu_unrealizefn;
     dc->props = ppc_cpu_properties;
 
     pcc->parent_reset = cc->reset;
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index ae3cee91a2..4c068cedff 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -463,8 +463,8 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     CPUClass *cc = CPU_CLASS(scc);
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    scc->parent_realize = dc->realize;
-    dc->realize = s390_cpu_realizefn;
+    device_class_set_parent_realize(dc, s390_cpu_realizefn,
+                                    &scc->parent_realize);
     dc->props = s390x_cpu_properties;
     dc->user_creatable = true;
 
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index e0b99fbc89..e37c187ca2 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -236,8 +236,8 @@ static void superh_cpu_class_init(ObjectClass *oc, void *data)
     CPUClass *cc = CPU_CLASS(oc);
     SuperHCPUClass *scc = SUPERH_CPU_CLASS(oc);
 
-    scc->parent_realize = dc->realize;
-    dc->realize = superh_cpu_realizefn;
+    device_class_set_parent_realize(dc, superh_cpu_realizefn,
+                                    &scc->parent_realize);
 
     scc->parent_reset = cc->reset;
     cc->reset = superh_cpu_reset;
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index c7adc281de..ff6ed91f9a 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -858,8 +858,8 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
     CPUClass *cc = CPU_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    scc->parent_realize = dc->realize;
-    dc->realize = sparc_cpu_realizefn;
+    device_class_set_parent_realize(dc, sparc_cpu_realizefn,
+                                    &scc->parent_realize);
     dc->props = sparc_cpu_properties;
 
     scc->parent_reset = cc->reset;
diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
index 2ef8ea7daa..54b6c50878 100644
--- a/target/tilegx/cpu.c
+++ b/target/tilegx/cpu.c
@@ -141,8 +141,8 @@ static void tilegx_cpu_class_init(ObjectClass *oc, void *data)
     CPUClass *cc = CPU_CLASS(oc);
     TileGXCPUClass *tcc = TILEGX_CPU_CLASS(oc);
 
-    tcc->parent_realize = dc->realize;
-    dc->realize = tilegx_cpu_realizefn;
+    device_class_set_parent_realize(dc, tilegx_cpu_realizefn,
+                                    &tcc->parent_realize);
 
     tcc->parent_reset = cc->reset;
     cc->reset = tilegx_cpu_reset;
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 179c997aa4..2edaef1aef 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -153,8 +153,8 @@ static void tricore_cpu_class_init(ObjectClass *c, void *data)
     CPUClass *cc = CPU_CLASS(c);
     DeviceClass *dc = DEVICE_CLASS(c);
 
-    mcc->parent_realize = dc->realize;
-    dc->realize = tricore_cpu_realizefn;
+    device_class_set_parent_realize(dc, tricore_cpu_realizefn,
+                                    &mcc->parent_realize);
 
     mcc->parent_reset = cc->reset;
     cc->reset = tricore_cpu_reset;
diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index 17dc1504d7..fb837aab4c 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -132,8 +132,8 @@ static void uc32_cpu_class_init(ObjectClass *oc, void *data)
     CPUClass *cc = CPU_CLASS(oc);
     UniCore32CPUClass *ucc = UNICORE32_CPU_CLASS(oc);
 
-    ucc->parent_realize = dc->realize;
-    dc->realize = uc32_cpu_realizefn;
+    device_class_set_parent_realize(dc, uc32_cpu_realizefn,
+                                    &ucc->parent_realize);
 
     cc->class_by_name = uc32_cpu_class_by_name;
     cc->has_work = uc32_cpu_has_work;
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 1c982a0b2e..4573388a45 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -151,8 +151,8 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
     CPUClass *cc = CPU_CLASS(oc);
     XtensaCPUClass *xcc = XTENSA_CPU_CLASS(cc);
 
-    xcc->parent_realize = dc->realize;
-    dc->realize = xtensa_cpu_realizefn;
+    device_class_set_parent_realize(dc, xtensa_cpu_realizefn,
+                                    &xcc->parent_realize);
 
     xcc->parent_reset = cc->reset;
     cc->reset = xtensa_cpu_reset;
-- 
2.15.1
