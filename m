Received: from eggs.gnu.org ([2001:4830:134:3::10]:51507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu7Bd-0004QE-OY
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu7BZ-0005mL-Ro
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:46:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cu7BZ-0005m9-G6
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:46:33 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 31 Mar 2017 21:46:06 -0300
Message-Id: <20170401004624.30886-2-ehabkost@redhat.com>
In-Reply-To: <20170401004624.30886-1-ehabkost@redhat.com>
References: <20170401004624.30886-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 01/19] qdev: Replace
 cannot_instantiate_with_device_add_yet with !user_creatable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>

cannot_instantiate_with_device_add_yet was introduced by commit
837d37167dc446af8a91189108b363c04609e296 to replace no_user. It
was supposed to be a temporary measure.

When it was introduced, we had 54
cannot_instantiate_with_device_add_yet=true lines in the code.
Today (3 years later) this number has not shrinked: we now have
57 cannot_instantiate_with_device_add_yet=true lines. I think it
is safe to say it is not a temporary measure, and we won't see
the flag go away soon.

Instead of a long field name that misleads people to believe it
is temporary, replace it a shorter and less misleading field:
user_creatable.

Except for code comments, changes were generated using the
following Coccinelle patch:

  @@
  expression DC;
  @@
  (
  -DC->cannot_instantiate_with_device_add_yet = false;
  +DC->user_creatable = true;
  |
  -DC->cannot_instantiate_with_device_add_yet = true;
  +DC->user_creatable = false;
  )

  @@
  typedef ObjectClass;
  expression dc;
  identifier class, data;
  @@
   static void device_class_init(ObjectClass *class, void *data)
   {
   ...
   dc->hotpluggable = true;
  +dc->user_creatable = true;
   ...
   }

  @@
  @@
   struct DeviceClass {
   ...
  -bool cannot_instantiate_with_device_add_yet;
  +bool user_creatable;
   ...
  }

  @@
  expression DC;
  @@
  (
  -!DC->cannot_instantiate_with_device_add_yet
  +DC->user_creatable
  |
  -DC->cannot_instantiate_with_device_add_yet
  +!DC->user_creatable
  )

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/qdev-core.h              | 10 +++++-----
 include/hw/qdev-properties.h        |  4 ++--
 hw/acpi/piix4.c                     |  2 +-
 hw/arm/spitz.c                      |  2 +-
 hw/audio/marvell_88w8618.c          |  2 +-
 hw/audio/pcspk.c                    |  2 +-
 hw/core/or-irq.c                    |  2 +-
 hw/core/qdev.c                      |  1 +
 hw/core/register.c                  |  2 +-
 hw/dma/i8257.c                      |  2 +-
 hw/dma/sparc32_dma.c                |  2 +-
 hw/gpio/omap_gpio.c                 |  4 ++--
 hw/i2c/omap_i2c.c                   |  2 +-
 hw/i2c/smbus_eeprom.c               |  2 +-
 hw/i2c/smbus_ich9.c                 |  2 +-
 hw/i386/pc.c                        |  2 +-
 hw/input/vmmouse.c                  |  2 +-
 hw/intc/apic_common.c               |  2 +-
 hw/intc/etraxfs_pic.c               |  2 +-
 hw/intc/grlib_irqmp.c               |  2 +-
 hw/intc/i8259_common.c              |  2 +-
 hw/intc/nios2_iic.c                 |  2 +-
 hw/intc/omap_intc.c                 |  4 ++--
 hw/isa/lpc_ich9.c                   |  2 +-
 hw/isa/piix4.c                      |  2 +-
 hw/isa/vt82c686.c                   |  2 +-
 hw/mips/gt64xxx_pci.c               |  2 +-
 hw/misc/vmport.c                    |  2 +-
 hw/net/dp8393x.c                    |  2 +-
 hw/net/etraxfs_eth.c                |  2 +-
 hw/net/lance.c                      |  2 +-
 hw/pci-bridge/dec.c                 |  2 +-
 hw/pci-bridge/pci_expander_bridge.c |  2 +-
 hw/pci-host/apb.c                   |  2 +-
 hw/pci-host/bonito.c                |  2 +-
 hw/pci-host/gpex.c                  |  2 +-
 hw/pci-host/grackle.c               |  2 +-
 hw/pci-host/piix.c                  |  6 +++---
 hw/pci-host/ppce500.c               |  2 +-
 hw/pci-host/prep.c                  |  2 +-
 hw/pci-host/q35.c                   |  4 ++--
 hw/pci-host/uninorth.c              |  8 ++++----
 hw/pci-host/versatile.c             |  2 +-
 hw/pci-host/xilinx-pcie.c           |  2 +-
 hw/ppc/ppc4xx_pci.c                 |  2 +-
 hw/ppc/spapr_drc.c                  |  2 +-
 hw/s390x/s390-pci-bus.c             |  2 +-
 hw/sd/milkymist-memcard.c           |  2 +-
 hw/sd/pl181.c                       |  2 +-
 hw/sh4/sh_pci.c                     |  2 +-
 hw/timer/i8254_common.c             |  2 +-
 hw/timer/mc146818rtc.c              |  2 +-
 monitor.c                           |  2 +-
 qdev-monitor.c                      |  6 +++---
 qom/cpu.c                           |  2 +-
 target/i386/cpu.c                   |  2 +-
 56 files changed, 71 insertions(+), 70 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index b44b476765..bc4e6f0486 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -103,16 +103,16 @@ typedef struct DeviceClass {
     Property *props;
 
     /*
-     * Shall we hide this device model from -device / device_add?
+     * Can this device be instantiated with -device / device_add?
      * All devices should support instantiation with device_add, and
      * this flag should not exist.  But we're not there, yet.  Some
      * devices fail to instantiate with cryptic error messages.
      * Others instantiate, but don't work.  Exposing users to such
-     * behavior would be cruel; this flag serves to protect them.  It
-     * should never be set without a comment explaining why it is set.
-     * TODO remove once we're there
+     * behavior would be cruel; clearing this flag will protect them.
+     * It should never be cleared without a comment explaining why it
+     * is cleared.
      */
-    bool cannot_instantiate_with_device_add_yet;
+    bool user_creatable;
     /*
      * Does this device model survive object_unref(object_new(TNAME))?
      * All device models should, and this flag shouldn't exist.  Some
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 7ac315331a..5c6e13b993 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -134,12 +134,12 @@ extern PropertyInfo qdev_prop_arraylen;
  *   device_add, so add code like this:
  *   |* Reason: pointer property "NAME-OF-YOUR-PROP" *|
  *   DeviceClass *dc = DEVICE_CLASS(class);
- *   dc->cannot_instantiate_with_device_add_yet = true;
+ *   dc->user_creatable = false;
  *
  * - If the property may safely remain null, document it like this:
  *   |*
  *    * Note: pointer property "interrupt_vector" may remain null, thus
- *    * no need for dc->cannot_instantiate_with_device_add_yet = true;
+ *    * no need for dc->user_creatable = false;
  *    *|
  */
 #define DEFINE_PROP_PTR(_n, _s, _f)             \
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index a553a7e110..f4fd5907b8 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -700,7 +700,7 @@ static void piix4_pm_class_init(ObjectClass *klass, void *data)
      * Reason: part of PIIX4 southbridge, needs to be wired up,
      * e.g. by mips_malta_init()
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
     dc->hotpluggable = false;
     hc->plug = piix4_device_plug_cb;
     hc->unplug_request = piix4_device_unplug_request_cb;
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index fe2d5a764c..324626847c 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -1076,7 +1076,7 @@ static void sl_nand_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_sl_nand_info;
     dc->props = sl_nand_properties;
     /* Reason: init() method uses drive_get() */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo sl_nand_info = {
diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
index 511b004287..4f65f8c199 100644
--- a/hw/audio/marvell_88w8618.c
+++ b/hw/audio/marvell_88w8618.c
@@ -292,7 +292,7 @@ static void mv88w8618_audio_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &mv88w8618_audio_vmsd;
     dc->props = mv88w8618_audio_properties;
     /* Reason: pointer property "wm8750" */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo mv88w8618_audio_info = {
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 798002277b..9b99358d87 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -223,7 +223,7 @@ static void pcspk_class_initfn(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_spk;
     dc->props = pcspk_properties;
     /* Reason: realize sets global pcspk_state */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo pcspk_info = {
diff --git a/hw/core/or-irq.c b/hw/core/or-irq.c
index 1485d5b285..f9d76c4641 100644
--- a/hw/core/or-irq.c
+++ b/hw/core/or-irq.c
@@ -91,7 +91,7 @@ static void or_irq_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_or_irq;
 
     /* Reason: Needs to be wired up to work, e.g. see stm32f205_soc.c */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo or_irq_type_info = {
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 1e7fb33246..4132a8bee3 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -1159,6 +1159,7 @@ static void device_class_init(ObjectClass *class, void *data)
      * should override it in their class_init()
      */
     dc->hotpluggable = true;
+    dc->user_creatable = true;
 }
 
 void device_reset(DeviceState *dev)
diff --git a/hw/core/register.c b/hw/core/register.c
index dc335a79a9..da38ef3a54 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -288,7 +288,7 @@ static void register_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     /* Reason: needs to be wired up to work */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo register_info = {
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 8bd82e8bc8..bd23e893bf 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -601,7 +601,7 @@ static void i8257_class_init(ObjectClass *klass, void *data)
     idc->schedule = i8257_dma_schedule;
     idc->register_channel = i8257_dma_register_channel;
     /* Reason: needs to be wired up by isa_bus_dma() to work */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo i8257_info = {
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 9d545e412e..9c6bdc6295 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -305,7 +305,7 @@ static void sparc32_dma_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_dma;
     dc->props = sparc32_dma_properties;
     /* Reason: pointer property "iommu_opaque" */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo sparc32_dma_info = {
diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index dabef4a119..1df394eb12 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -773,7 +773,7 @@ static void omap_gpio_class_init(ObjectClass *klass, void *data)
     dc->reset = omap_gpif_reset;
     dc->props = omap_gpio_properties;
     /* Reason: pointer property "clk" */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo omap_gpio_info = {
@@ -804,7 +804,7 @@ static void omap2_gpio_class_init(ObjectClass *klass, void *data)
     dc->reset = omap2_gpif_reset;
     dc->props = omap2_gpio_properties;
     /* Reason: pointer properties "iclk", "fclk0", ..., "fclk5" */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo omap2_gpio_info = {
diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
index f7c92ea00c..f6e80bee25 100644
--- a/hw/i2c/omap_i2c.c
+++ b/hw/i2c/omap_i2c.c
@@ -491,7 +491,7 @@ static void omap_i2c_class_init(ObjectClass *klass, void *data)
     dc->props = omap_i2c_properties;
     dc->reset = omap_i2c_reset;
     /* Reason: pointer properties "iclk", "fclk" */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
     dc->realize = omap_i2c_realize;
 }
 
diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 5b7bd891bc..b13ec0fe7a 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -123,7 +123,7 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
     sc->read_data = eeprom_read_data;
     dc->props = smbus_eeprom_properties;
     /* Reason: pointer property "data" */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo smbus_eeprom_info = {
diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
index 48fab22625..ea51e09186 100644
--- a/hw/i2c/smbus_ich9.c
+++ b/hw/i2c/smbus_ich9.c
@@ -103,7 +103,7 @@ static void ich9_smb_class_init(ObjectClass *klass, void *data)
      * Reason: part of ICH9 southbridge, needs to be wired up by
      * pc_q35_init()
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 I2CBus *ich9_smb_init(PCIBus *bus, int devfn, uint32_t smb_io_base)
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d24388e05f..610050eb4f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -597,7 +597,7 @@ static void port92_class_initfn(ObjectClass *klass, void *data)
      * wiring: its A20 output line needs to be wired up by
      * port92_init().
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo port92_info = {
diff --git a/hw/input/vmmouse.c b/hw/input/vmmouse.c
index 6d15a887c6..4747da9a8d 100644
--- a/hw/input/vmmouse.c
+++ b/hw/input/vmmouse.c
@@ -286,7 +286,7 @@ static void vmmouse_class_initfn(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_vmmouse;
     dc->props = vmmouse_properties;
     /* Reason: pointer property "ps2_mouse" */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo vmmouse_info = {
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index c3829e31b5..1ef56f8d10 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -501,7 +501,7 @@ static void apic_common_class_init(ObjectClass *klass, void *data)
      * Reason: APIC and CPU need to be wired up by
      * x86_cpu_apic_create()
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo apic_common_type = {
diff --git a/hw/intc/etraxfs_pic.c b/hw/intc/etraxfs_pic.c
index 64a6f4b4ba..1bfde2f09e 100644
--- a/hw/intc/etraxfs_pic.c
+++ b/hw/intc/etraxfs_pic.c
@@ -173,7 +173,7 @@ static void etraxfs_pic_class_init(ObjectClass *klass, void *data)
     dc->props = etraxfs_pic_properties;
     /*
      * Note: pointer property "interrupt_vector" may remain null, thus
-     * no need for dc->cannot_instantiate_with_device_add_yet = true;
+     * no need for dc->user_creatable = false;
      */
 }
 
diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index ac7e63f38b..94659ee256 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -360,7 +360,7 @@ static void grlib_irqmp_class_init(ObjectClass *klass, void *data)
     dc->reset = grlib_irqmp_reset;
     dc->props = grlib_irqmp_properties;
     /* Reason: pointer properties "set_pil_in", "set_pil_in_opaque" */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
     dc->realize = grlib_irqmp_realize;
 }
 
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index d9a5e8b217..c2fd563b5b 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -144,7 +144,7 @@ static void pic_common_class_init(ObjectClass *klass, void *data)
      * wiring of the slave to the master is hard-coded in device model
      * code.
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo pic_common_type = {
diff --git a/hw/intc/nios2_iic.c b/hw/intc/nios2_iic.c
index 190b6fdbf3..016426f964 100644
--- a/hw/intc/nios2_iic.c
+++ b/hw/intc/nios2_iic.c
@@ -80,7 +80,7 @@ static void altera_iic_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     /* Reason: needs to be wired up, e.g. by nios2_10m50_ghrd_init() */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
     dc->realize = altera_iic_realize;
 }
 
diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
index 877be67971..ccdda89dab 100644
--- a/hw/intc/omap_intc.c
+++ b/hw/intc/omap_intc.c
@@ -401,7 +401,7 @@ static void omap_intc_class_init(ObjectClass *klass, void *data)
     dc->reset = omap_inth_reset;
     dc->props = omap_intc_properties;
     /* Reason: pointer property "clk" */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
     dc->realize = omap_intc_realize;
 }
 
@@ -656,7 +656,7 @@ static void omap2_intc_class_init(ObjectClass *klass, void *data)
     dc->reset = omap_inth_reset;
     dc->props = omap2_intc_properties;
     /* Reason: pointer property "iclk", "fclk" */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
     dc->realize = omap2_intc_realize;
 }
 
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 59930dd9d0..cdc854a822 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -810,7 +810,7 @@ static void ich9_lpc_class_init(ObjectClass *klass, void *data)
      * Reason: part of ICH9 southbridge, needs to be wired up by
      * pc_q35_init()
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
     hc->plug = ich9_pm_device_plug_cb;
     hc->unplug_request = ich9_pm_device_unplug_request_cb;
     hc->unplug = ich9_pm_device_unplug_cb;
diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 5500fcc4d6..f811eba59d 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -123,7 +123,7 @@ static void piix4_class_init(ObjectClass *klass, void *data)
      * Reason: part of PIIX4 southbridge, needs to be wired up,
      * e.g. by mips_malta_init()
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
     dc->hotpluggable = false;
 }
 
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 41d5254f8e..50dc83df77 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -494,7 +494,7 @@ static void via_class_init(ObjectClass *klass, void *data)
      * Reason: part of VIA VT82C686 southbridge, needs to be wired up,
      * e.g. by mips_fulong2e_init()
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo via_info = {
diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index 4811843ab6..e8b2eef688 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -1224,7 +1224,7 @@ static void gt64120_pci_class_init(ObjectClass *klass, void *data)
      * PCI-facing part of the host bridge, not usable without the
      * host-facing part, which can't be device_add'ed, yet.
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo gt64120_pci_info = {
diff --git a/hw/misc/vmport.c b/hw/misc/vmport.c
index be40930b8b..165500223f 100644
--- a/hw/misc/vmport.c
+++ b/hw/misc/vmport.c
@@ -163,7 +163,7 @@ static void vmport_class_initfn(ObjectClass *klass, void *data)
 
     dc->realize = vmport_realizefn;
     /* Reason: realize sets global port_state */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo vmport_info = {
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index efa33ad40a..b53fcaa8bc 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -934,7 +934,7 @@ static void dp8393x_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_dp8393x;
     dc->props = dp8393x_properties;
     /* Reason: dma_mr property can't be set */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo dp8393x_info = {
diff --git a/hw/net/etraxfs_eth.c b/hw/net/etraxfs_eth.c
index efaa49faae..013c8d0a41 100644
--- a/hw/net/etraxfs_eth.c
+++ b/hw/net/etraxfs_eth.c
@@ -630,7 +630,7 @@ static void etraxfs_eth_class_init(ObjectClass *klass, void *data)
     k->init = fs_eth_init;
     dc->props = etraxfs_eth_properties;
     /* Reason: pointer properties "dma_out", "dma_in" */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo etraxfs_eth_info = {
diff --git a/hw/net/lance.c b/hw/net/lance.c
index 573d724bcf..92b0c68274 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -165,7 +165,7 @@ static void lance_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_lance;
     dc->props = lance_properties;
     /* Reason: pointer property "dma" */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo lance_info = {
diff --git a/hw/pci-bridge/dec.c b/hw/pci-bridge/dec.c
index 840c96198a..cca93620ac 100644
--- a/hw/pci-bridge/dec.c
+++ b/hw/pci-bridge/dec.c
@@ -128,7 +128,7 @@ static void dec_21154_pci_host_class_init(ObjectClass *klass, void *data)
      * PCI-facing part of the host bridge, not usable without the
      * host-facing part, which can't be device_add'ed, yet.
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo dec_21154_pci_host_info = {
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 6ac187fa32..ff59abf208 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -150,7 +150,7 @@ static void pxb_host_class_init(ObjectClass *class, void *data)
 
     dc->fw_name = "pci";
     /* Reason: Internal part of the pxb/pxb-pcie device, not usable by itself */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
     sbc->explicit_ofw_unit_address = pxb_host_ofw_unit_address;
     hc->root_bus_path = pxb_host_root_bus_path;
 }
diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index 653e711121..edc88f4c65 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -810,7 +810,7 @@ static void pbm_pci_host_class_init(ObjectClass *klass, void *data)
      * PCI-facing part of the host bridge, not usable without the
      * host-facing part, which can't be device_add'ed, yet.
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo pbm_pci_host_info = {
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 1999ece590..85a3bb0dd2 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -825,7 +825,7 @@ static void bonito_class_init(ObjectClass *klass, void *data)
      * PCI-facing part of the host bridge, not usable without the
      * host-facing part, which can't be device_add'ed, yet.
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo bonito_info = {
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index 66055ee5cc..e2629ce70d 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -136,7 +136,7 @@ static void gpex_root_class_init(ObjectClass *klass, void *data)
      * PCI-facing part of the host bridge, not usable without the
      * host-facing part, which can't be device_add'ed, yet.
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo gpex_root_info = {
diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index 2c8acdaaca..2e281f6155 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -134,7 +134,7 @@ static void grackle_pci_class_init(ObjectClass *klass, void *data)
      * PCI-facing part of the host bridge, not usable without the
      * host-facing part, which can't be device_add'ed, yet.
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo grackle_pci_info = {
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index f9218aa952..81f3a9e211 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -691,7 +691,7 @@ static void pci_piix3_class_init(ObjectClass *klass, void *data)
      * Reason: part of PIIX3 southbridge, needs to be wired up by
      * pc_piix.c's pc_init1()
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo piix3_pci_type_info = {
@@ -745,7 +745,7 @@ static void i440fx_class_init(ObjectClass *klass, void *data)
      * PCI-facing part of the host bridge, not usable without the
      * host-facing part, which can't be device_add'ed, yet.
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
     dc->hotpluggable   = false;
 }
 
@@ -874,7 +874,7 @@ static void i440fx_pcihost_class_init(ObjectClass *klass, void *data)
     dc->fw_name = "pci";
     dc->props = i440fx_props;
     /* Reason: needs to be wired up by pc_init1 */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo i440fx_pcihost_info = {
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index e502bc0505..becc0eeb76 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -508,7 +508,7 @@ static void e500_host_bridge_class_init(ObjectClass *klass, void *data)
      * PCI-facing part of the host bridge, not usable without the
      * host-facing part, which can't be device_add'ed, yet.
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo e500_host_bridge_info = {
diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 260a119a9e..900a6edfcf 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -364,7 +364,7 @@ static void raven_class_init(ObjectClass *klass, void *data)
      * Reason: PCI-facing part of the host bridge, not usable without
      * the host-facing part, which can't be device_add'ed, yet.
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo raven_info = {
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 344f77b10c..cd5c49616e 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -156,7 +156,7 @@ static void q35_host_class_init(ObjectClass *klass, void *data)
     dc->realize = q35_host_realize;
     dc->props = mch_props;
     /* Reason: needs to be wired up by pc_q35_init */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "pci";
 }
@@ -549,7 +549,7 @@ static void mch_class_init(ObjectClass *klass, void *data)
      * PCI-facing part of the host bridge, not usable without the
      * host-facing part, which can't be device_add'ed, yet.
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo mch_info = {
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index df342ac3cb..6cf5e59f86 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -366,7 +366,7 @@ static void unin_main_pci_host_class_init(ObjectClass *klass, void *data)
      * PCI-facing part of the host bridge, not usable without the
      * host-facing part, which can't be device_add'ed, yet.
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo unin_main_pci_host_info = {
@@ -390,7 +390,7 @@ static void u3_agp_pci_host_class_init(ObjectClass *klass, void *data)
      * PCI-facing part of the host bridge, not usable without the
      * host-facing part, which can't be device_add'ed, yet.
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo u3_agp_pci_host_info = {
@@ -414,7 +414,7 @@ static void unin_agp_pci_host_class_init(ObjectClass *klass, void *data)
      * PCI-facing part of the host bridge, not usable without the
      * host-facing part, which can't be device_add'ed, yet.
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo unin_agp_pci_host_info = {
@@ -438,7 +438,7 @@ static void unin_internal_pci_host_class_init(ObjectClass *klass, void *data)
      * PCI-facing part of the host bridge, not usable without the
      * host-facing part, which can't be device_add'ed, yet.
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo unin_internal_pci_host_info = {
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index 467cbb9cb8..cc51fc87a3 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -479,7 +479,7 @@ static void versatile_pci_host_class_init(ObjectClass *klass, void *data)
      * PCI-facing part of the host bridge, not usable without the
      * host-facing part, which can't be device_add'ed, yet.
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo versatile_pci_host_info = {
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 8b71e2d950..a968cea2af 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -309,7 +309,7 @@ static void xilinx_pcie_root_class_init(ObjectClass *klass, void *data)
      * PCI-facing part of the host bridge, not usable without the
      * host-facing part, which can't be device_add'ed, yet.
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo xilinx_pcie_root_info = {
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index dc19682970..6953f8b9ac 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -351,7 +351,7 @@ static void ppc4xx_host_bridge_class_init(ObjectClass *klass, void *data)
      * PCI-facing part of the host bridge, not usable without the
      * host-facing part, which can't be device_add'ed, yet.
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo ppc4xx_host_bridge_info = {
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index a1cdc875b1..9fa5545991 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -675,7 +675,7 @@ static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
     /*
      * Reason: it crashes FIXME find and document the real reason
      */
-    dk->cannot_instantiate_with_device_add_yet = true;
+    dk->user_creatable = false;
 }
 
 static const TypeInfo spapr_dr_connector_info = {
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 69b0291e8a..1ec30c45ce 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -867,7 +867,7 @@ static void s390_pcihost_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
 
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
     dc->reset = s390_pcihost_reset;
     k->init = s390_pcihost_init;
     hc->plug = s390_pcihost_hot_plug;
diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 1f2f0ed44a..4008c81002 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -299,7 +299,7 @@ static void milkymist_memcard_class_init(ObjectClass *klass, void *data)
     dc->reset = milkymist_memcard_reset;
     dc->vmsd = &vmstate_milkymist_memcard;
     /* Reason: init() method uses drive_get_next() */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo milkymist_memcard_info = {
diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 82c63a4fb5..55c8098ecd 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -515,7 +515,7 @@ static void pl181_class_init(ObjectClass *klass, void *data)
     k->vmsd = &vmstate_pl181;
     k->reset = pl181_reset;
     /* Reason: init() method uses drive_get_next() */
-    k->cannot_instantiate_with_device_add_yet = true;
+    k->user_creatable = false;
     k->realize = pl181_realize;
 }
 
diff --git a/hw/sh4/sh_pci.c b/hw/sh4/sh_pci.c
index 1747628f3d..38395c082b 100644
--- a/hw/sh4/sh_pci.c
+++ b/hw/sh4/sh_pci.c
@@ -171,7 +171,7 @@ static void sh_pci_host_class_init(ObjectClass *klass, void *data)
      * PCI-facing part of the host bridge, not usable without the
      * host-facing part, which can't be device_add'ed, yet.
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo sh_pci_host_info = {
diff --git a/hw/timer/i8254_common.c b/hw/timer/i8254_common.c
index e18299a482..976d5200f1 100644
--- a/hw/timer/i8254_common.c
+++ b/hw/timer/i8254_common.c
@@ -287,7 +287,7 @@ static void pit_common_class_init(ObjectClass *klass, void *data)
      * wired to the HPET, and because of that, some wiring is always
      * done by board code.
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo pit_common_type = {
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 4165450250..93de3e1cc5 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -973,7 +973,7 @@ static void rtc_class_initfn(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_rtc;
     dc->props = mc146818rtc_properties;
     /* Reason: needs to be wired up by rtc_init() */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static void rtc_finalize(Object *obj)
diff --git a/monitor.c b/monitor.c
index be282ecb80..e06edec2bd 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3156,7 +3156,7 @@ void device_add_completion(ReadLineState *rs, int nb_args, const char *str)
                                              TYPE_DEVICE);
         name = object_class_get_name(OBJECT_CLASS(dc));
 
-        if (!dc->cannot_instantiate_with_device_add_yet
+        if (dc->user_creatable
             && !strncmp(name, str, len)) {
             readline_add_completion(rs, name);
         }
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 5f2fcdfc45..e4c180c6bc 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -113,7 +113,7 @@ static void qdev_print_devinfo(DeviceClass *dc)
     if (dc->desc) {
         error_printf(", desc \"%s\"", dc->desc);
     }
-    if (dc->cannot_instantiate_with_device_add_yet) {
+    if (!dc->user_creatable) {
         error_printf(", no-user");
     }
     error_printf("\n");
@@ -155,7 +155,7 @@ static void qdev_print_devinfos(bool show_no_user)
                  ? !test_bit(i, dc->categories)
                  : !bitmap_empty(dc->categories, DEVICE_CATEGORY_MAX))
                 || (!show_no_user
-                    && dc->cannot_instantiate_with_device_add_yet)) {
+                    && !dc->user_creatable)) {
                 continue;
             }
             if (!cat_printed) {
@@ -240,7 +240,7 @@ static DeviceClass *qdev_get_device_class(const char **driver, Error **errp)
     }
 
     dc = DEVICE_CLASS(oc);
-    if (dc->cannot_instantiate_with_device_add_yet ||
+    if (!dc->user_creatable ||
         (qdev_hotplug && !dc->hotpluggable)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "driver",
                    "pluggable device type");
diff --git a/qom/cpu.c b/qom/cpu.c
index f02e9c0fae..73ae140d7e 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -449,7 +449,7 @@ static void cpu_class_init(ObjectClass *klass, void *data)
      * Reason: CPUs still need special care by board code: wiring up
      * IRQs, adding reset handlers, halting non-first CPUs, ...
      */
-    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo cpu_type_info = {
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 13c0985f11..4b3bfb3802 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4066,7 +4066,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->cpu_exec_enter = x86_cpu_exec_enter;
     cc->cpu_exec_exit = x86_cpu_exec_exit;
 
-    dc->cannot_instantiate_with_device_add_yet = false;
+    dc->user_creatable = true;
 }
 
 static const TypeInfo x86_cpu_type_info = {
-- 
2.11.0.259.g40922b1
