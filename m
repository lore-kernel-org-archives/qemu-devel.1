Received: from eggs.gnu.org ([2001:4830:134:3::10]:36953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1duMpP-0005se-IK
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1duMpL-0008KI-0J
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:00:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60747)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1duMpK-0008D0-KQ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:00:54 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 19 Sep 2017 19:00:34 +0100
Message-Id: <20170919180038.26056-2-dgilbert@redhat.com>
In-Reply-To: <20170919180038.26056-1-dgilbert@redhat.com>
References: <20170919180038.26056-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] migration: pre_save return int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com
Cc: peter.maydell@linaro.org, cohuck@redhat.com, rth@twiddle.net

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Modify the pre_save method on VMStateDescription to return an int
rather than void so that it potentially can fail.

Changed zillions of devices to make them return 0; the only
case I've made it return non-0 is hw/intc/s390_flic_kvm.c that already
had an error_report/return case.

Note: If you add an error exit in your pre_save you must emit
an error_report to say why.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 docs/devel/migration.txt       |  2 +-
 hw/arm/pxa2xx.c                |  4 +++-
 hw/arm/strongarm.c             |  4 +++-
 hw/audio/wm8750.c              |  4 +++-
 hw/block/fdc.c                 |  4 +++-
 hw/block/m25p80.c              |  4 +++-
 hw/block/nand.c                |  4 +++-
 hw/block/onenand.c             |  4 +++-
 hw/char/serial.c               |  4 +++-
 hw/display/qxl.c               |  4 +++-
 hw/i2c/core.c                  |  4 +++-
 hw/i386/kvm/clock.c            |  4 +++-
 hw/ide/core.c                  |  4 +++-
 hw/ide/pci.c                   |  4 +++-
 hw/input/ps2.c                 |  8 ++++++--
 hw/input/tsc210x.c             |  4 +++-
 hw/intc/apic_common.c          |  4 +++-
 hw/intc/arm_gic_common.c       |  4 +++-
 hw/intc/arm_gicv3_common.c     |  4 +++-
 hw/intc/arm_gicv3_its_common.c |  4 +++-
 hw/intc/i8259_common.c         |  4 +++-
 hw/intc/ioapic_common.c        |  4 +++-
 hw/intc/s390_flic_kvm.c        |  6 ++++--
 hw/intc/xics.c                 |  8 ++++++--
 hw/net/e1000.c                 |  4 +++-
 hw/net/e1000e.c                |  4 +++-
 hw/net/rtl8139.c               |  4 +++-
 hw/net/virtio-net.c            | 16 ++++++++++++----
 hw/net/vmxnet3.c               |  4 +++-
 hw/pci-host/piix.c             |  4 +++-
 hw/ppc/ppc.c                   |  4 +++-
 hw/ppc/spapr_iommu.c           |  4 +++-
 hw/ppc/spapr_pci.c             |  6 ++++--
 hw/s390x/css.c                 | 10 +++++++---
 hw/s390x/virtio-ccw.c          |  4 +++-
 hw/scsi/lsi53c895a.c           |  4 +++-
 hw/scsi/vmw_pvscsi.c           |  4 +++-
 hw/timer/cadence_ttc.c         |  4 +++-
 hw/timer/hpet.c                |  4 +++-
 hw/timer/i8254_common.c        |  4 +++-
 hw/timer/mc146818rtc.c         |  4 +++-
 hw/timer/pl031.c               |  4 +++-
 hw/timer/twl92230.c            |  4 +++-
 hw/usb/dev-smartcard-reader.c  |  4 +++-
 hw/usb/hcd-ehci.c              |  4 +++-
 hw/usb/redirect.c              |  4 +++-
 hw/virtio/vhost-vsock.c        |  4 +++-
 include/migration/vmstate.h    |  2 +-
 migration/colo-comm.c          |  4 +++-
 migration/global_state.c       |  4 +++-
 migration/savevm.c             |  4 +++-
 replay/replay-snapshot.c       |  4 +++-
 slirp/slirp.c                  |  8 ++++++--
 target/arm/machine.c           |  4 +++-
 target/i386/machine.c          |  7 +++++--
 target/ppc/machine.c           |  4 +++-
 target/s390x/machine.c         |  4 +++-
 target/sparc/machine.c         |  4 +++-
 tests/test-vmstate.c           |  4 +++-
 59 files changed, 199 insertions(+), 70 deletions(-)

diff --git a/docs/devel/migration.txt b/docs/devel/migration.txt
index 1b940a829b..4030703726 100644
--- a/docs/devel/migration.txt
+++ b/docs/devel/migration.txt
@@ -202,7 +202,7 @@ The functions to do that are inside a vmstate definition, and are called:
 
   This function is called after we load the state of one device.
 
-- void (*pre_save)(void *opaque);
+- int (*pre_save)(void *opaque);
 
   This function is called before we save the state of one device.
 
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index b0ac3cfd64..3648f01d05 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -1143,13 +1143,15 @@ static void pxa2xx_rtc_init(Object *obj)
     sysbus_init_mmio(dev, &s->iomem);
 }
 
-static void pxa2xx_rtc_pre_save(void *opaque)
+static int pxa2xx_rtc_pre_save(void *opaque)
 {
     PXA2xxRTCState *s = (PXA2xxRTCState *) opaque;
 
     pxa2xx_rtc_hzupdate(s);
     pxa2xx_rtc_piupdate(s);
     pxa2xx_rtc_swupdate(s);
+
+    return 0;
 }
 
 static int pxa2xx_rtc_post_load(void *opaque, int version_id)
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 884242b2dc..37d7e36b35 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -406,11 +406,13 @@ static void strongarm_rtc_init(Object *obj)
     sysbus_init_mmio(dev, &s->iomem);
 }
 
-static void strongarm_rtc_pre_save(void *opaque)
+static int strongarm_rtc_pre_save(void *opaque)
 {
     StrongARMRTCState *s = opaque;
 
     strongarm_rtc_hzupdate(s);
+
+    return 0;
 }
 
 static int strongarm_rtc_post_load(void *opaque, int version_id)
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index f8b5bebfc2..fff49f8bb5 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -567,11 +567,13 @@ static int wm8750_rx(I2CSlave *i2c)
     return 0x00;
 }
 
-static void wm8750_pre_save(void *opaque)
+static int wm8750_pre_save(void *opaque)
 {
     WM8750State *s = opaque;
 
     s->rate_vmstate = s->rate - wm_rate_table;
+
+    return 0;
 }
 
 static int wm8750_post_load(void *opaque, int version_id)
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index db40e174c9..af9ba77270 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -1102,11 +1102,13 @@ static int reconstruct_phase(FDCtrl *fdctrl)
     }
 }
 
-static void fdc_pre_save(void *opaque)
+static int fdc_pre_save(void *opaque)
 {
     FDCtrl *s = opaque;
 
     s->dor_vmstate = s->dor | GET_CUR_DRV(s);
+
+    return 0;
 }
 
 static int fdc_pre_load(void *opaque)
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 190573cefa..a2438b9ed2 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1251,9 +1251,11 @@ static void m25p80_reset(DeviceState *d)
     reset_memory(s);
 }
 
-static void m25p80_pre_save(void *opaque)
+static int m25p80_pre_save(void *opaque)
 {
     flash_sync_dirty((Flash *)opaque, -1);
+
+    return 0;
 }
 
 static Property m25p80_properties[] = {
diff --git a/hw/block/nand.c b/hw/block/nand.c
index 0d33ac281f..76dcd3f76e 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -325,11 +325,13 @@ static void nand_command(NANDFlashState *s)
     }
 }
 
-static void nand_pre_save(void *opaque)
+static int nand_pre_save(void *opaque)
 {
     NANDFlashState *s = NAND(opaque);
 
     s->ioaddr_vmstate = s->ioaddr - s->io;
+
+    return 0;
 }
 
 static int nand_post_load(void *opaque, int version_id)
diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index b7423607d9..30e40f3914 100644
--- a/hw/block/onenand.c
+++ b/hw/block/onenand.c
@@ -137,7 +137,7 @@ static void onenand_intr_update(OneNANDState *s)
     qemu_set_irq(s->intr, ((s->intstatus >> 15) ^ (~s->config[0] >> 6)) & 1);
 }
 
-static void onenand_pre_save(void *opaque)
+static int onenand_pre_save(void *opaque)
 {
     OneNANDState *s = opaque;
     if (s->current == s->otp) {
@@ -147,6 +147,8 @@ static void onenand_pre_save(void *opaque)
     } else {
         s->current_direction = 0;
     }
+
+    return 0;
 }
 
 static int onenand_post_load(void *opaque, int version_id)
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 9aec6c60d8..376bd2f240 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -630,10 +630,12 @@ static void serial_event(void *opaque, int event)
         serial_receive_break(s);
 }
 
-static void serial_pre_save(void *opaque)
+static int serial_pre_save(void *opaque)
 {
     SerialState *s = opaque;
     s->fcr_vmstate = s->fcr;
+
+    return 0;
 }
 
 static int serial_pre_load(void *opaque)
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index ae3677fd1e..d92fe05f1a 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2204,7 +2204,7 @@ static void qxl_realize_secondary(PCIDevice *dev, Error **errp)
     qxl_realize_common(qxl, errp);
 }
 
-static void qxl_pre_save(void *opaque)
+static int qxl_pre_save(void *opaque)
 {
     PCIQXLDevice* d = opaque;
     uint8_t *ram_start = d->vga.vram_ptr;
@@ -2216,6 +2216,8 @@ static void qxl_pre_save(void *opaque)
         d->last_release_offset = (uint8_t *)d->last_release - ram_start;
     }
     assert(d->last_release_offset < d->vga.vram_size);
+
+    return 0;
 }
 
 static int qxl_pre_load(void *opaque)
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 2c1234cdff..59068f157e 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -41,7 +41,7 @@ static const TypeInfo i2c_bus_info = {
     .instance_size = sizeof(I2CBus),
 };
 
-static void i2c_bus_pre_save(void *opaque)
+static int i2c_bus_pre_save(void *opaque)
 {
     I2CBus *bus = opaque;
 
@@ -53,6 +53,8 @@ static void i2c_bus_pre_save(void *opaque)
             bus->saved_address = I2C_BROADCAST;
         }
     }
+
+    return 0;
 }
 
 static const VMStateDescription vmstate_i2c_bus = {
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 363d1b5743..75ad1ba6f0 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -254,11 +254,13 @@ static const VMStateDescription kvmclock_reliable_get_clock = {
  *  final pages of memory (which happens between vm_stop()
  *  and pre_save()) takes max_downtime.
  */
-static void kvmclock_pre_save(void *opaque)
+static int kvmclock_pre_save(void *opaque)
 {
     KVMClockState *s = opaque;
 
     kvm_update_clock(s);
+
+    return 0;
 }
 
 static const VMStateDescription kvmclock_vmsd = {
diff --git a/hw/ide/core.c b/hw/ide/core.c
index bea39536b0..588f375daf 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2696,7 +2696,7 @@ static int ide_drive_pio_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static void ide_drive_pio_pre_save(void *opaque)
+static int ide_drive_pio_pre_save(void *opaque)
 {
     IDEState *s = opaque;
     int idx;
@@ -2712,6 +2712,8 @@ static void ide_drive_pio_pre_save(void *opaque)
     } else {
         s->end_transfer_fn_idx = idx;
     }
+
+    return 0;
 }
 
 static bool ide_drive_pio_state_needed(void *opaque)
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index 3cfb510afe..552e4ad179 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -303,7 +303,7 @@ static bool ide_bmdma_status_needed(void *opaque)
     return ((bm->status & abused_bits) != 0);
 }
 
-static void ide_bmdma_pre_save(void *opaque)
+static int ide_bmdma_pre_save(void *opaque)
 {
     BMDMAState *bm = opaque;
     uint8_t abused_bits = BM_MIGRATION_COMPAT_STATUS_BITS;
@@ -317,6 +317,8 @@ static void ide_bmdma_pre_save(void *opaque)
     bm->migration_retry_nsector = bm->bus->retry_nsector;
     bm->migration_compat_status =
         (bm->status & ~abused_bits) | (bm->bus->error_status & abused_bits);
+
+    return 0;
 }
 
 /* This function accesses bm->bus->error_status which is loaded only after
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 77906d5f46..dff3f1e024 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -1216,12 +1216,14 @@ static int ps2_kbd_post_load(void* opaque, int version_id)
     return 0;
 }
 
-static void ps2_kbd_pre_save(void *opaque)
+static int ps2_kbd_pre_save(void *opaque)
 {
     PS2KbdState *s = (PS2KbdState *)opaque;
     PS2State *ps2 = &s->common;
 
     ps2_common_post_load(ps2);
+
+    return 0;
 }
 
 static const VMStateDescription vmstate_ps2_keyboard = {
@@ -1254,12 +1256,14 @@ static int ps2_mouse_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static void ps2_mouse_pre_save(void *opaque)
+static int ps2_mouse_pre_save(void *opaque)
 {
     PS2MouseState *s = (PS2MouseState *)opaque;
     PS2State *ps2 = &s->common;
 
     ps2_common_post_load(ps2);
+
+    return 0;
 }
 
 static const VMStateDescription vmstate_ps2_mouse = {
diff --git a/hw/input/tsc210x.c b/hw/input/tsc210x.c
index b068343771..75ac8c2ab5 100644
--- a/hw/input/tsc210x.c
+++ b/hw/input/tsc210x.c
@@ -976,10 +976,12 @@ static void tsc210x_i2s_set_rate(TSC210xState *s, int in, int out)
     s->i2s_rx_rate = in;
 }
 
-static void tsc210x_pre_save(void *opaque)
+static int tsc210x_pre_save(void *opaque)
 {
     TSC210xState *s = (TSC210xState *) opaque;
     s->now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    return 0;
 }
 
 static int tsc210x_post_load(void *opaque, int version_id)
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index e1ac33042f..78903ea909 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -360,7 +360,7 @@ static int apic_pre_load(void *opaque)
     return 0;
 }
 
-static void apic_dispatch_pre_save(void *opaque)
+static int apic_dispatch_pre_save(void *opaque)
 {
     APICCommonState *s = APIC_COMMON(opaque);
     APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
@@ -368,6 +368,8 @@ static void apic_dispatch_pre_save(void *opaque)
     if (info->pre_save) {
         info->pre_save(s);
     }
+
+    return 0;
 }
 
 static int apic_dispatch_post_load(void *opaque, int version_id)
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index 70f1134823..aee50a20e0 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -23,7 +23,7 @@
 #include "gic_internal.h"
 #include "hw/arm/linux-boot-if.h"
 
-static void gic_pre_save(void *opaque)
+static int gic_pre_save(void *opaque)
 {
     GICState *s = (GICState *)opaque;
     ARMGICCommonClass *c = ARM_GIC_COMMON_GET_CLASS(s);
@@ -31,6 +31,8 @@ static void gic_pre_save(void *opaque)
     if (c->pre_save) {
         c->pre_save(s);
     }
+
+    return 0;
 }
 
 static int gic_post_load(void *opaque, int version_id)
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 410915a2ac..7b54d52376 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -28,7 +28,7 @@
 #include "gicv3_internal.h"
 #include "hw/arm/linux-boot-if.h"
 
-static void gicv3_pre_save(void *opaque)
+static int gicv3_pre_save(void *opaque)
 {
     GICv3State *s = (GICv3State *)opaque;
     ARMGICv3CommonClass *c = ARM_GICV3_COMMON_GET_CLASS(s);
@@ -36,6 +36,8 @@ static void gicv3_pre_save(void *opaque)
     if (c->pre_save) {
         c->pre_save(s);
     }
+
+    return 0;
 }
 
 static int gicv3_post_load(void *opaque, int version_id)
diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
index 68b20fccd1..f2cce597a9 100644
--- a/hw/intc/arm_gicv3_its_common.c
+++ b/hw/intc/arm_gicv3_its_common.c
@@ -23,7 +23,7 @@
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "qemu/log.h"
 
-static void gicv3_its_pre_save(void *opaque)
+static int gicv3_its_pre_save(void *opaque)
 {
     GICv3ITSState *s = (GICv3ITSState *)opaque;
     GICv3ITSCommonClass *c = ARM_GICV3_ITS_COMMON_GET_CLASS(s);
@@ -31,6 +31,8 @@ static void gicv3_its_pre_save(void *opaque)
     if (c->pre_save) {
         c->pre_save(s);
     }
+
+    return 0;
 }
 
 static int gicv3_its_post_load(void *opaque, int version_id)
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index c2fd563b5b..18427b459a 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -46,7 +46,7 @@ void pic_reset_common(PICCommonState *s)
     /* Note: ELCR is not reset */
 }
 
-static void pic_dispatch_pre_save(void *opaque)
+static int pic_dispatch_pre_save(void *opaque)
 {
     PICCommonState *s = opaque;
     PICCommonClass *info = PIC_COMMON_GET_CLASS(s);
@@ -54,6 +54,8 @@ static void pic_dispatch_pre_save(void *opaque)
     if (info->pre_save) {
         info->pre_save(s);
     }
+
+    return 0;
 }
 
 static int pic_dispatch_post_load(void *opaque, int version_id)
diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
index 97c4f9c2df..3b3d0a7680 100644
--- a/hw/intc/ioapic_common.c
+++ b/hw/intc/ioapic_common.c
@@ -102,7 +102,7 @@ void ioapic_reset_common(DeviceState *dev)
     }
 }
 
-static void ioapic_dispatch_pre_save(void *opaque)
+static int ioapic_dispatch_pre_save(void *opaque)
 {
     IOAPICCommonState *s = IOAPIC_COMMON(opaque);
     IOAPICCommonClass *info = IOAPIC_COMMON_GET_CLASS(s);
@@ -110,6 +110,8 @@ static void ioapic_dispatch_pre_save(void *opaque)
     if (info->pre_save) {
         info->pre_save(s);
     }
+
+    return 0;
 }
 
 static int ioapic_dispatch_post_load(void *opaque, int version_id)
diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 7ead17ac3e..d208cb81c4 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -420,7 +420,7 @@ typedef struct KVMS390FLICStateMigTmp {
     uint8_t nimm;
 } KVMS390FLICStateMigTmp;
 
-static void kvm_flic_ais_pre_save(void *opaque)
+static int kvm_flic_ais_pre_save(void *opaque)
 {
     KVMS390FLICStateMigTmp *tmp = opaque;
     KVMS390FLICState *flic = tmp->parent;
@@ -433,11 +433,13 @@ static void kvm_flic_ais_pre_save(void *opaque)
 
     if (ioctl(flic->fd, KVM_GET_DEVICE_ATTR, &attr)) {
         error_report("Failed to retrieve kvm flic ais states");
-        return;
+        return -EINVAL;
     }
 
     tmp->simm = ais.simm;
     tmp->nimm = ais.nimm;
+
+    return 0;
 }
 
 static int kvm_flic_ais_post_load(void *opaque, int version_id)
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index a84ba51ad8..4d6a25ade6 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -241,7 +241,7 @@ static void icp_irq(ICSState *ics, int server, int nr, uint8_t priority)
     }
 }
 
-static void icp_dispatch_pre_save(void *opaque)
+static int icp_dispatch_pre_save(void *opaque)
 {
     ICPState *icp = opaque;
     ICPStateClass *info = ICP_GET_CLASS(icp);
@@ -249,6 +249,8 @@ static void icp_dispatch_pre_save(void *opaque)
     if (info->pre_save) {
         info->pre_save(icp);
     }
+
+    return 0;
 }
 
 static int icp_dispatch_post_load(void *opaque, int version_id)
@@ -533,7 +535,7 @@ static void ics_simple_reset(void *dev)
     }
 }
 
-static void ics_simple_dispatch_pre_save(void *opaque)
+static int ics_simple_dispatch_pre_save(void *opaque)
 {
     ICSState *ics = opaque;
     ICSStateClass *info = ICS_BASE_GET_CLASS(ics);
@@ -541,6 +543,8 @@ static void ics_simple_dispatch_pre_save(void *opaque)
     if (info->pre_save) {
         info->pre_save(ics);
     }
+
+    return 0;
 }
 
 static int ics_simple_dispatch_post_load(void *opaque, int version_id)
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index eebe3a9c13..cae95185a5 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1343,7 +1343,7 @@ static bool is_version_1(void *opaque, int version_id)
     return version_id == 1;
 }
 
-static void e1000_pre_save(void *opaque)
+static int e1000_pre_save(void *opaque)
 {
     E1000State *s = opaque;
     NetClientState *nc = qemu_get_queue(s->nic);
@@ -1361,6 +1361,8 @@ static void e1000_pre_save(void *opaque)
     if (nc->link_down && have_autoneg(s)) {
         s->phy_reg[PHY_STATUS] |= MII_SR_AUTONEG_COMPLETE;
     }
+
+    return 0;
 }
 
 static int e1000_post_load(void *opaque, int version_id)
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 6c42b4478c..744f0f3b91 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -523,13 +523,15 @@ static void e1000e_qdev_reset(DeviceState *dev)
     e1000e_core_reset(&s->core);
 }
 
-static void e1000e_pre_save(void *opaque)
+static int e1000e_pre_save(void *opaque)
 {
     E1000EState *s = opaque;
 
     trace_e1000e_cb_pre_save();
 
     e1000e_core_pre_save(&s->core);
+
+    return 0;
 }
 
 static int e1000e_post_load(void *opaque, int version_id)
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 3be24bbee7..d6c8188ae1 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -3162,7 +3162,7 @@ static const VMStateDescription vmstate_rtl8139_hotplug_ready ={
     }
 };
 
-static void rtl8139_pre_save(void *opaque)
+static int rtl8139_pre_save(void *opaque)
 {
     RTL8139State* s = opaque;
     int64_t current_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
@@ -3170,6 +3170,8 @@ static void rtl8139_pre_save(void *opaque)
     /* for migration to older versions */
     s->TCTR = (current_time - s->TCTR_base) / PCI_PERIOD;
     s->rtl8139_mmio_io_addr_dummy = 0;
+
+    return 0;
 }
 
 static const VMStateDescription vmstate_rtl8139 = {
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 148071a396..150fd0748e 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1712,7 +1712,7 @@ struct VirtIONetMigTmp {
  * pointer and count and also validate the count.
  */
 
-static void virtio_net_tx_waiting_pre_save(void *opaque)
+static int virtio_net_tx_waiting_pre_save(void *opaque)
 {
     struct VirtIONetMigTmp *tmp = opaque;
 
@@ -1721,6 +1721,8 @@ static void virtio_net_tx_waiting_pre_save(void *opaque)
     if (tmp->parent->curr_queues == 0) {
         tmp->curr_queues_1 = 0;
     }
+
+    return 0;
 }
 
 static int virtio_net_tx_waiting_pre_load(void *opaque)
@@ -1768,11 +1770,13 @@ static int virtio_net_ufo_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static void virtio_net_ufo_pre_save(void *opaque)
+static int virtio_net_ufo_pre_save(void *opaque)
 {
     struct VirtIONetMigTmp *tmp = opaque;
 
     tmp->has_ufo = tmp->parent->has_ufo;
+
+    return 0;
 }
 
 static const VMStateDescription vmstate_virtio_net_has_ufo = {
@@ -1800,11 +1804,13 @@ static int virtio_net_vnet_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static void virtio_net_vnet_pre_save(void *opaque)
+static int virtio_net_vnet_pre_save(void *opaque)
 {
     struct VirtIONetMigTmp *tmp = opaque;
 
     tmp->has_vnet_hdr = tmp->parent->has_vnet_hdr;
+
+    return 0;
 }
 
 static const VMStateDescription vmstate_virtio_net_has_vnet = {
@@ -2079,13 +2085,15 @@ static void virtio_net_instance_init(Object *obj)
                                   DEVICE(n), NULL);
 }
 
-static void virtio_net_pre_save(void *opaque)
+static int virtio_net_pre_save(void *opaque)
 {
     VirtIONet *n = opaque;
 
     /* At this point, backend must be stopped, otherwise
      * it might keep writing to memory. */
     assert(!n->vhost_started);
+
+    return 0;
 }
 
 static const VMStateDescription vmstate_virtio_net = {
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index a19a7a31dd..b43b58be2b 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2388,11 +2388,13 @@ static int vmxnet3_mcast_list_pre_load(void *opaque)
 }
 
 
-static void vmxnet3_pre_save(void *opaque)
+static int vmxnet3_pre_save(void *opaque)
 {
     VMXNET3State *s = opaque;
 
     s->mcast_list_buff_size = s->mcast_list_len * sizeof(MACAddr);
+
+    return 0;
 }
 
 static const VMStateDescription vmxstate_vmxnet3_mcast_list = {
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 894e131c00..dec345fd24 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -579,7 +579,7 @@ static int piix3_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static void piix3_pre_save(void *opaque)
+static int piix3_pre_save(void *opaque)
 {
     int i;
     PIIX3State *piix3 = opaque;
@@ -588,6 +588,8 @@ static void piix3_pre_save(void *opaque)
         piix3->pci_irq_levels_vmstate[i] =
             pci_bus_get_irq_level(piix3->dev.bus, i);
     }
+
+    return 0;
 }
 
 static bool piix3_rcr_needed(void *opaque)
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index f76886f4d3..05da316e0b 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -937,11 +937,13 @@ void cpu_ppc_clock_vm_state_change(void *opaque, int running,
  *  final pages of memory (which happens between vm_stop()
  *  and pre_save()) takes max_downtime.
  */
-static void timebase_pre_save(void *opaque)
+static int timebase_pre_save(void *opaque)
 {
     PPCTimebase *tb = opaque;
 
     timebase_save(tb);
+
+    return 0;
 }
 
 const VMStateDescription vmstate_ppc_timebase = {
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index fa8b969840..5ccd785d5a 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -140,7 +140,7 @@ static IOMMUTLBEntry spapr_tce_translate_iommu(IOMMUMemoryRegion *iommu,
     return ret;
 }
 
-static void spapr_tce_table_pre_save(void *opaque)
+static int spapr_tce_table_pre_save(void *opaque)
 {
     sPAPRTCETable *tcet = SPAPR_TCE_TABLE(opaque);
 
@@ -149,6 +149,8 @@ static void spapr_tce_table_pre_save(void *opaque)
 
     trace_spapr_iommu_pre_save(tcet->liobn, tcet->mig_nb_table,
                                tcet->bus_offset, tcet->page_shift);
+
+    return 0;
 }
 
 static uint64_t spapr_tce_get_min_page_size(IOMMUMemoryRegion *iommu)
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index d7880f257a..a00f67b0f8 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1860,7 +1860,7 @@ static const VMStateDescription vmstate_spapr_pci_msi = {
     },
 };
 
-static void spapr_pci_pre_save(void *opaque)
+static int spapr_pci_pre_save(void *opaque)
 {
     sPAPRPHBState *sphb = opaque;
     GHashTableIter iter;
@@ -1885,7 +1885,7 @@ static void spapr_pci_pre_save(void *opaque)
     sphb->msi_devs = NULL;
     sphb->msi_devs_num = g_hash_table_size(sphb->msi);
     if (!sphb->msi_devs_num) {
-        return;
+        return 0;
     }
     sphb->msi_devs = g_malloc(sphb->msi_devs_num * sizeof(spapr_pci_msi_mig));
 
@@ -1894,6 +1894,8 @@ static void spapr_pci_pre_save(void *opaque)
         sphb->msi_devs[i].key = *(uint32_t *) key;
         sphb->msi_devs[i].value = *(spapr_pci_msi *) value;
     }
+
+    return 0;
 }
 
 static int spapr_pci_post_load(void *opaque, int version_id)
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 901dc6a0f3..ad23eaf6e6 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -196,7 +196,7 @@ static const VMStateDescription vmstate_schdev_orb = {
 };
 
 static int subch_dev_post_load(void *opaque, int version_id);
-static void subch_dev_pre_save(void *opaque);
+static int subch_dev_pre_save(void *opaque);
 
 const char err_hint_devno[] = "Devno mismatch, tried to load wrong section!"
     " Likely reason: some sequences of plug and unplug  can break"
@@ -249,7 +249,7 @@ static int post_load_ind_addr(void *opaque, int version_id)
     return 0;
 }
 
-static void pre_save_ind_addr(void *opaque)
+static int pre_save_ind_addr(void *opaque)
 {
     IndAddrPtrTmp *ptmp = opaque;
     IndAddr *ind_addr = *(ptmp->parent);
@@ -261,6 +261,8 @@ static void pre_save_ind_addr(void *opaque)
         ptmp->len = 0;
         ptmp->addr = 0L;
     }
+
+    return 0;
 }
 
 const VMStateDescription vmstate_ind_addr_tmp = {
@@ -358,12 +360,14 @@ static ChannelSubSys channel_subsys = {
         QTAILQ_HEAD_INITIALIZER(channel_subsys.indicator_addresses),
 };
 
-static void subch_dev_pre_save(void *opaque)
+static int subch_dev_pre_save(void *opaque)
 {
     SubchDev *s = opaque;
 
     /* Prepare remote_schid for save */
     s->migrated_schid = s->schid;
+
+    return 0;
 }
 
 static int subch_dev_post_load(void *opaque, int version_id)
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index b1976fdd19..7553ec1253 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -62,13 +62,15 @@ typedef struct VirtioCcwDeviceTmp {
     uint16_t config_vector;
 } VirtioCcwDeviceTmp;
 
-static void virtio_ccw_dev_tmp_pre_save(void *opaque)
+static int virtio_ccw_dev_tmp_pre_save(void *opaque)
 {
     VirtioCcwDeviceTmp *tmp = opaque;
     VirtioCcwDevice *dev = tmp->parent;
     VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
 
     tmp->config_vector = vdev->config_vector;
+
+    return 0;
 }
 
 static int virtio_ccw_dev_tmp_post_load(void *opaque, int version_id)
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 3e56ab267c..a67ee074d9 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2083,7 +2083,7 @@ static void lsi_scsi_reset(DeviceState *dev)
     lsi_soft_reset(s);
 }
 
-static void lsi_pre_save(void *opaque)
+static int lsi_pre_save(void *opaque)
 {
     LSIState *s = opaque;
 
@@ -2092,6 +2092,8 @@ static void lsi_pre_save(void *opaque)
         assert(s->current->dma_len == 0);
     }
     assert(QTAILQ_EMPTY(&s->queue));
+
+    return 0;
 }
 
 static const VMStateDescription vmstate_lsi_scsi = {
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 77d8b6f9e2..b18d35248e 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1167,7 +1167,7 @@ pvscsi_reset(DeviceState *dev)
     pvscsi_reset_adapter(s);
 }
 
-static void
+static int
 pvscsi_pre_save(void *opaque)
 {
     PVSCSIState *s = (PVSCSIState *) opaque;
@@ -1176,6 +1176,8 @@ pvscsi_pre_save(void *opaque)
 
     assert(QTAILQ_EMPTY(&s->pending_queue));
     assert(QTAILQ_EMPTY(&s->completion_queue));
+
+    return 0;
 }
 
 static int
diff --git a/hw/timer/cadence_ttc.c b/hw/timer/cadence_ttc.c
index 03f5b9c206..5e65fdb5a0 100644
--- a/hw/timer/cadence_ttc.c
+++ b/hw/timer/cadence_ttc.c
@@ -421,9 +421,11 @@ static void cadence_ttc_init(Object *obj)
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
 }
 
-static void cadence_timer_pre_save(void *opaque)
+static int cadence_timer_pre_save(void *opaque)
 {
     cadence_timer_sync((CadenceTimerState *)opaque);
+
+    return 0;
 }
 
 static int cadence_timer_post_load(void *opaque, int version_id)
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index a2c18b30c3..577371bc6d 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -216,12 +216,14 @@ static void update_irq(struct HPETTimer *timer, int set)
     }
 }
 
-static void hpet_pre_save(void *opaque)
+static int hpet_pre_save(void *opaque)
 {
     HPETState *s = opaque;
 
     /* save current counter value */
     s->hpet_counter = hpet_get_ticks(s);
+
+    return 0;
 }
 
 static int hpet_pre_load(void *opaque)
diff --git a/hw/timer/i8254_common.c b/hw/timer/i8254_common.c
index ee064aa819..b623c96198 100644
--- a/hw/timer/i8254_common.c
+++ b/hw/timer/i8254_common.c
@@ -237,7 +237,7 @@ static int pit_load_old(QEMUFile *f, void *opaque, int version_id)
     return 0;
 }
 
-static void pit_dispatch_pre_save(void *opaque)
+static int pit_dispatch_pre_save(void *opaque)
 {
     PITCommonState *s = opaque;
     PITCommonClass *c = PIT_COMMON_GET_CLASS(s);
@@ -245,6 +245,8 @@ static void pit_dispatch_pre_save(void *opaque)
     if (c->pre_save) {
         c->pre_save(s);
     }
+
+    return 0;
 }
 
 static int pit_dispatch_post_load(void *opaque, int version_id)
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 82843ed03f..7764be25ec 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -795,11 +795,13 @@ static void rtc_set_date_from_host(ISADevice *dev)
     rtc_set_cmos(s, &tm);
 }
 
-static void rtc_pre_save(void *opaque)
+static int rtc_pre_save(void *opaque)
 {
     RTCState *s = opaque;
 
     rtc_update_time(s);
+
+    return 0;
 }
 
 static int rtc_post_load(void *opaque, int version_id)
diff --git a/hw/timer/pl031.c b/hw/timer/pl031.c
index dbbeb9b16b..d3aacce80d 100644
--- a/hw/timer/pl031.c
+++ b/hw/timer/pl031.c
@@ -211,7 +211,7 @@ static void pl031_init(Object *obj)
     s->timer = timer_new_ns(rtc_clock, pl031_interrupt, s);
 }
 
-static void pl031_pre_save(void *opaque)
+static int pl031_pre_save(void *opaque)
 {
     PL031State *s = opaque;
 
@@ -219,6 +219,8 @@ static void pl031_pre_save(void *opaque)
      * store the base time relative to the QEMU_CLOCK_VIRTUAL for backwards-compatibility.  */
     int64_t delta = qemu_clock_get_ns(rtc_clock) - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     s->tick_offset_vmstate = s->tick_offset + delta / NANOSECONDS_PER_SECOND;
+
+    return 0;
 }
 
 static int pl031_post_load(void *opaque, int version_id)
diff --git a/hw/timer/twl92230.c b/hw/timer/twl92230.c
index c0aa8ae3de..eb58c378e0 100644
--- a/hw/timer/twl92230.c
+++ b/hw/timer/twl92230.c
@@ -791,11 +791,13 @@ static const VMStateDescription vmstate_menelaus_tm = {
     }
 };
 
-static void menelaus_pre_save(void *opaque)
+static int menelaus_pre_save(void *opaque)
 {
     MenelausState *s = opaque;
     /* Should be <= 1000 */
     s->rtc_next_vmstate =  s->rtc.next - qemu_clock_get_ms(rtc_clock);
+
+    return 0;
 }
 
 static int menelaus_post_load(void *opaque, int version_id)
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index bef1f03c42..0c77d2a41d 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1374,7 +1374,7 @@ static int ccid_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static void ccid_pre_save(void *opaque)
+static int ccid_pre_save(void *opaque)
 {
     USBCCIDState *s = opaque;
 
@@ -1386,6 +1386,8 @@ static void ccid_pre_save(void *opaque)
          */
         s->migration_state = MIGRATION_MIGRATED;
     }
+
+    return 0;
 }
 
 static VMStateDescription bulk_in_vmstate = {
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 604912cb3e..c2bf237e6c 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -2380,7 +2380,7 @@ static USBBusOps ehci_bus_ops_standalone = {
     .wakeup_endpoint = ehci_wakeup_endpoint,
 };
 
-static void usb_ehci_pre_save(void *opaque)
+static int usb_ehci_pre_save(void *opaque)
 {
     EHCIState *ehci = opaque;
     uint32_t new_frindex;
@@ -2389,6 +2389,8 @@ static void usb_ehci_pre_save(void *opaque)
     new_frindex = ehci->frindex & ~7;
     ehci->last_run_ns -= (ehci->frindex - new_frindex) * UFRAME_TIMER_NS;
     ehci->frindex = new_frindex;
+
+    return 0;
 }
 
 static int usb_ehci_post_load(void *opaque, int version_id)
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 5e42730449..ec174309db 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -2111,11 +2111,13 @@ static void usbredir_buffered_bulk_packet(void *priv, uint64_t id,
  * Migration code
  */
 
-static void usbredir_pre_save(void *priv)
+static int usbredir_pre_save(void *priv)
 {
     USBRedirDevice *dev = priv;
 
     usbredir_fill_already_in_flight(dev);
+
+    return 0;
 }
 
 static int usbredir_post_load(void *priv, int version_id)
diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 49e0022533..5ec1c6a2a2 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -254,13 +254,15 @@ static void vhost_vsock_post_load_timer_cb(void *opaque)
     vhost_vsock_send_transport_reset(vsock);
 }
 
-static void vhost_vsock_pre_save(void *opaque)
+static int vhost_vsock_pre_save(void *opaque)
 {
     VHostVSock *vsock = opaque;
 
     /* At this point, backend must be stopped, otherwise
      * it might keep writing to memory. */
     assert(!vsock->vhost_dev.started);
+
+    return 0;
 }
 
 static int vhost_vsock_post_load(void *opaque, int version_id)
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 85e43da568..da46b1a36d 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -179,7 +179,7 @@ struct VMStateDescription {
     LoadStateHandler *load_state_old;
     int (*pre_load)(void *opaque);
     int (*post_load)(void *opaque, int version_id);
-    void (*pre_save)(void *opaque);
+    int (*pre_save)(void *opaque);
     bool (*needed)(void *opaque);
     VMStateField *fields;
     const VMStateDescription **subsections;
diff --git a/migration/colo-comm.c b/migration/colo-comm.c
index b61aa19a38..df26e4dfe7 100644
--- a/migration/colo-comm.c
+++ b/migration/colo-comm.c
@@ -34,11 +34,13 @@ COLOMode get_colo_mode(void)
     }
 }
 
-static void colo_info_pre_save(void *opaque)
+static int colo_info_pre_save(void *opaque)
 {
     COLOInfo *s = opaque;
 
     s->colo_requested = migrate_colo_enabled();
+
+    return 0;
 }
 
 static bool colo_info_need(void *opaque)
diff --git a/migration/global_state.c b/migration/global_state.c
index dfdaf63910..8e8ab5c51e 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -101,12 +101,14 @@ static int global_state_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static void global_state_pre_save(void *opaque)
+static int global_state_pre_save(void *opaque)
 {
     GlobalState *s = opaque;
 
     trace_migrate_global_state_pre_save((char *)s->runstate);
     s->size = strlen((char *)s->runstate) + 1;
+
+    return 0;
 }
 
 static const VMStateDescription vmstate_globalstate = {
diff --git a/migration/savevm.c b/migration/savevm.c
index 7a55023d1a..8d18a57ca0 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -295,7 +295,7 @@ static SaveState savevm_state = {
     .global_section_id = 0,
 };
 
-static void configuration_pre_save(void *opaque)
+static int configuration_pre_save(void *opaque)
 {
     SaveState *state = opaque;
     const char *current_name = MACHINE_GET_CLASS(current_machine)->name;
@@ -303,6 +303,8 @@ static void configuration_pre_save(void *opaque)
     state->len = strlen(current_name);
     state->name = current_name;
     state->target_page_bits = qemu_target_page_bits();
+
+    return 0;
 }
 
 static int configuration_pre_load(void *opaque)
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index a4ded2956d..b2e10769a6 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -21,10 +21,12 @@
 #include "migration/vmstate.h"
 #include "migration/snapshot.h"
 
-static void replay_pre_save(void *opaque)
+static int replay_pre_save(void *opaque)
 {
     ReplayState *state = opaque;
     state->file_offset = ftell(replay_file);
+
+    return 0;
 }
 
 static int replay_post_load(void *opaque, int version_id)
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 1d6756821c..1cb6b07004 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -1203,11 +1203,13 @@ struct sbuf_tmp {
     uint32_t roff, woff;
 };
 
-static void sbuf_tmp_pre_save(void *opaque)
+static int sbuf_tmp_pre_save(void *opaque)
 {
     struct sbuf_tmp *tmp = opaque;
     tmp->woff = tmp->parent->sb_wptr - tmp->parent->sb_data;
     tmp->roff = tmp->parent->sb_rptr - tmp->parent->sb_data;
+
+    return 0;
 }
 
 static int sbuf_tmp_post_load(void *opaque, int version)
@@ -1303,7 +1305,7 @@ typedef struct SS_FamilyTmpStruct {
 #define SS_FAMILY_MIG_IPV6  10  /* Linux */
 #define SS_FAMILY_MIG_OTHER 0xffff
 
-static void ss_family_pre_save(void *opaque)
+static int ss_family_pre_save(void *opaque)
 {
     SS_FamilyTmpStruct *tss = opaque;
 
@@ -1314,6 +1316,8 @@ static void ss_family_pre_save(void *opaque)
     } else if (tss->parent->ss.ss_family == AF_INET6) {
         tss->portable_family = SS_FAMILY_MIG_IPV6;
     }
+
+    return 0;
 }
 
 static int ss_family_post_load(void *opaque, int version_id)
diff --git a/target/arm/machine.c b/target/arm/machine.c
index e5fe083da4..29df7ac87d 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -394,7 +394,7 @@ static const VMStateInfo vmstate_powered_off = {
     .put = put_power,
 };
 
-static void cpu_pre_save(void *opaque)
+static int cpu_pre_save(void *opaque)
 {
     ARMCPU *cpu = opaque;
 
@@ -415,6 +415,8 @@ static void cpu_pre_save(void *opaque)
            cpu->cpreg_array_len * sizeof(uint64_t));
     memcpy(cpu->cpreg_vmstate_values, cpu->cpreg_values,
            cpu->cpreg_array_len * sizeof(uint64_t));
+
+    return 0;
 }
 
 static int cpu_post_load(void *opaque, int version_id)
diff --git a/target/i386/machine.c b/target/i386/machine.c
index eab33725a3..3bc11b74b7 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -160,13 +160,15 @@ static floatx80 cpu_set_fp80(uint64_t mant, uint16_t upper)
     return temp.d;
 }
 
-static void fpreg_pre_save(void *opaque)
+static int fpreg_pre_save(void *opaque)
 {
     x86_FPReg_tmp *tmp = opaque;
 
     /* we save the real CPU data (in case of MMX usage only 'mant'
        contains the MMX register */
     cpu_get_fp80(&tmp->tmp_mant, &tmp->tmp_exp, tmp->parent->d);
+
+    return 0;
 }
 
 static int fpreg_post_load(void *opaque, int version)
@@ -196,7 +198,7 @@ static const VMStateDescription vmstate_fpreg = {
     }
 };
 
-static void cpu_pre_save(void *opaque)
+static int cpu_pre_save(void *opaque)
 {
     X86CPU *cpu = opaque;
     CPUX86State *env = &cpu->env;
@@ -228,6 +230,7 @@ static void cpu_pre_save(void *opaque)
         env->segs[R_SS].flags &= ~(env->segs[R_SS].flags & DESC_DPL_MASK);
     }
 
+    return 0;
 }
 
 static int cpu_post_load(void *opaque, int version_id)
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index e36b7100cb..384caee800 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -146,7 +146,7 @@ static bool cpu_pre_2_8_migration(void *opaque, int version_id)
     return cpu->pre_2_8_migration;
 }
 
-static void cpu_pre_save(void *opaque)
+static int cpu_pre_save(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
     CPUPPCState *env = &cpu->env;
@@ -195,6 +195,8 @@ static void cpu_pre_save(void *opaque)
         cpu->mig_insns_flags2 = env->insns_flags2 & insns_compat_mask2;
         cpu->mig_nb_BATs = env->nb_BATs;
     }
+
+    return 0;
 }
 
 /*
diff --git a/target/s390x/machine.c b/target/s390x/machine.c
index 097a147dbb..e1b7015d20 100644
--- a/target/s390x/machine.c
+++ b/target/s390x/machine.c
@@ -37,13 +37,15 @@ static int cpu_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static void cpu_pre_save(void *opaque)
+static int cpu_pre_save(void *opaque)
 {
     S390CPU *cpu = opaque;
 
     if (kvm_enabled()) {
         kvm_s390_vcpu_interrupt_pre_save(cpu);
     }
+
+    return 0;
 }
 
 static inline bool fpu_needed(void *opaque)
diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index 6bd6b8ee3e..8ff9dea297 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -88,7 +88,7 @@ static const VMStateInfo vmstate_psr = {
     .put = put_psr,
 };
 
-static void cpu_pre_save(void *opaque)
+static int cpu_pre_save(void *opaque)
 {
     SPARCCPU *cpu = opaque;
     CPUSPARCState *env = &cpu->env;
@@ -97,6 +97,8 @@ static void cpu_pre_save(void *opaque)
      * window as the outs of the first window
      */
     cpu_set_cwp(env, env->cwp);
+
+    return 0;
 }
 
 /* 32-bit SPARC retains migration compatibility with older versions
diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index ee292c7bee..e643ac662b 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -765,11 +765,13 @@ typedef struct TmpTestStruct {
     int64_t diff;
 } TmpTestStruct;
 
-static void tmp_child_pre_save(void *opaque)
+static int tmp_child_pre_save(void *opaque)
 {
     struct TmpTestStruct *tts = opaque;
 
     tts->diff = tts->parent->b - tts->parent->a;
+
+    return 0;
 }
 
 static int tmp_child_post_load(void *opaque, int version_id)
-- 
2.13.5
