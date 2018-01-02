Received: from eggs.gnu.org ([2001:4830:134:3::10]:51939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWRNa-0006wy-6Q
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 13:33:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWRNZ-0005hJ-0Z
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 13:33:38 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  2 Jan 2018 19:33:17 +0100
Message-Id: <20180102183317.2571-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH] escc: introduce a selector for the register bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <Laurent@Vivier.EU>, Laurent Vivier <laurent@vivier.eu>

From: Laurent Vivier <Laurent@Vivier.EU>

On Sparc and PowerMac, the bit 0 of the address
selects the register type (control or data) and
bit 1 selects the channel (B or A).

On m68k Macintosh, the bit 0 selects the channel and
bit 1 the register type.

This patch introduces a new parameter (reg_bit) to
the device interface to indicate which bit is used
to select the register type.

For the moment all the machines use the bit 0,
but this change will be needed to emulate Quadra 800.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/char/escc.c         | 24 +++++++++++++++++-------
 hw/ppc/mac_newworld.c  |  2 +-
 hw/ppc/mac_oldworld.c  |  2 +-
 hw/sparc/sun4m.c       |  2 +-
 include/hw/char/escc.h |  2 +-
 5 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/hw/char/escc.c b/hw/char/escc.c
index 3ab831a6a7..b2bea3982e 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -45,14 +45,21 @@
  * mouse and keyboard ports don't implement all functions and they are
  * only asynchronous. There is no DMA.
  *
- * Z85C30 is also used on PowerMacs. There are some small differences
- * between Sparc version (sunzilog) and PowerMac (pmac):
+ * Z85C30 is also used on PowerMacs and m68k Macs.
+ *
+ * There are some small differences between Sparc version (sunzilog)
+ * and PowerMac (pmac):
  *  Offset between control and data registers
  *  There is some kind of lockup bug, but we can ignore it
  *  CTS is inverted
  *  DMA on pmac using DBDMA chip
  *  pmac can do IRDA and faster rates, sunzilog can only do 38400
  *  pmac baud rate generator clock is 3.6864 MHz, sunzilog 4.9152 MHz
+ *
+ * Linux driver for m68k Macs is the same as for PowerMac (pmac_zilog),
+ * but registers are grouped by type and not by channel:
+ * channel is selected by bit 0 of the address (instead of bit 1)
+ * and register is selected by bit 1 of the address (instead of bit 0).
  */
 
 /*
@@ -107,6 +114,7 @@ typedef struct ESCCState {
 
     struct ChannelState chn[2];
     uint32_t it_shift;
+    uint32_t reg_bit;
     MemoryRegion mmio;
     uint32_t disabled;
     uint32_t frequency;
@@ -479,8 +487,8 @@ static void escc_mem_write(void *opaque, hwaddr addr,
     int newreg, channel;
 
     val &= 0xff;
-    saddr = (addr >> serial->it_shift) & 1;
-    channel = (addr >> (serial->it_shift + 1)) & 1;
+    saddr = (addr >> (serial->it_shift + serial->reg_bit)) & 1;
+    channel = (addr >> (serial->it_shift + (1 - serial->reg_bit))) & 1;
     s = &serial->chn[channel];
     switch (saddr) {
     case SERIAL_CTRL:
@@ -583,8 +591,8 @@ static uint64_t escc_mem_read(void *opaque, hwaddr addr,
     uint32_t ret;
     int channel;
 
-    saddr = (addr >> serial->it_shift) & 1;
-    channel = (addr >> (serial->it_shift + 1)) & 1;
+    saddr = (addr >> (serial->it_shift + serial->reg_bit)) & 1;
+    channel = (addr >> (serial->it_shift + (1 - serial->reg_bit))) & 1;
     s = &serial->chn[channel];
     switch (saddr) {
     case SERIAL_CTRL:
@@ -691,7 +699,7 @@ static const VMStateDescription vmstate_escc = {
 
 MemoryRegion *escc_init(hwaddr base, qemu_irq irqA, qemu_irq irqB,
               Chardev *chrA, Chardev *chrB,
-              int clock, int it_shift)
+              int clock, int it_shift, int reg_bit)
 {
     DeviceState *dev;
     SysBusDevice *s;
@@ -701,6 +709,7 @@ MemoryRegion *escc_init(hwaddr base, qemu_irq irqA, qemu_irq irqB,
     qdev_prop_set_uint32(dev, "disabled", 0);
     qdev_prop_set_uint32(dev, "frequency", clock);
     qdev_prop_set_uint32(dev, "it_shift", it_shift);
+    qdev_prop_set_uint32(dev, "reg_bit", reg_bit);
     qdev_prop_set_chr(dev, "chrB", chrB);
     qdev_prop_set_chr(dev, "chrA", chrA);
     qdev_prop_set_uint32(dev, "chnBtype", ser);
@@ -1033,6 +1042,7 @@ static void escc_realize(DeviceState *dev, Error **errp)
 static Property escc_properties[] = {
     DEFINE_PROP_UINT32("frequency", ESCCState, frequency,   0),
     DEFINE_PROP_UINT32("it_shift",  ESCCState, it_shift,    0),
+    DEFINE_PROP_UINT32("reg_bit",   ESCCState, reg_bit,     0),
     DEFINE_PROP_UINT32("disabled",  ESCCState, disabled,    0),
     DEFINE_PROP_UINT32("chnBtype",  ESCCState, chn[0].type, 0),
     DEFINE_PROP_UINT32("chnAtype",  ESCCState, chn[1].type, 0),
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 3fa7c429d5..f9a5be19a8 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -370,7 +370,7 @@ static void ppc_core99_init(MachineState *machine)
 
     /* init basic PC hardware */
     escc_mem = escc_init(0, pic[0x25], pic[0x24],
-                         serial_hds[0], serial_hds[1], ESCC_CLOCK, 4);
+                         serial_hds[0], serial_hds[1], ESCC_CLOCK, 4, 0);
     memory_region_init_alias(escc_bar, NULL, "escc-bar",
                              escc_mem, 0, memory_region_size(escc_mem));
 
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 010ea36bf2..f44361f42d 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -265,7 +265,7 @@ static void ppc_heathrow_init(MachineState *machine)
     pci_vga_init(pci_bus);
 
     escc_mem = escc_init(0, pic[0x0f], pic[0x10], serial_hds[0],
-                               serial_hds[1], ESCC_CLOCK, 4);
+                               serial_hds[1], ESCC_CLOCK, 4, 0);
     memory_region_init_alias(escc_bar, NULL, "escc-bar",
                              escc_mem, 0, memory_region_size(escc_mem));
 
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index e71648404c..d492c75abc 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -932,7 +932,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     /* Slavio TTYA (base+4, Linux ttyS0) is the first QEMU serial device
        Slavio TTYB (base+0, Linux ttyS1) is the second QEMU serial device */
     escc_init(hwdef->serial_base, slavio_irq[15], slavio_irq[15],
-              serial_hds[0], serial_hds[1], ESCC_CLOCK, 1);
+              serial_hds[0], serial_hds[1], ESCC_CLOCK, 1, 0);
 
     if (hwdef->apc_base) {
         apc_init(hwdef->apc_base, qemu_allocate_irq(cpu_halt_signal, NULL, 0));
diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
index 08ae122386..3caa58e25d 100644
--- a/include/hw/char/escc.h
+++ b/include/hw/char/escc.h
@@ -6,7 +6,7 @@
 #define ESCC_SIZE 4
 MemoryRegion *escc_init(hwaddr base, qemu_irq irqA, qemu_irq irqB,
               Chardev *chrA, Chardev *chrB,
-              int clock, int it_shift);
+              int clock, int it_shift, int reg_bit);
 
 void slavio_serial_ms_kbd_init(hwaddr base, qemu_irq irq,
                                int disabled, int clock, int it_shift);
-- 
2.14.3
