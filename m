Received: from eggs.gnu.org ([2001:4830:134:3::10]:34362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fe70H-0006PK-Ou
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 18:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fe70E-0004XL-Mk
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 18:57:33 -0400
Date: Fri, 13 Jul 2018 19:57:18 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180713225718.GP914@localhost.localdomain>
References: <1531470464-21522-1-git-send-email-thuth@redhat.com>
	<1531470464-21522-2-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531470464-21522-2-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 01/16] qom/object: Add a new function
 object_initialize_child()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>, Markus Armbruster <armbru@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Fri, Jul 13, 2018 at 10:27:29AM +0200, Thomas Huth wrote:
> A lot of code is using the object_initialize() function followed by a call
> to object_property_add_child() to add the newly initialized object as a child
> of the current object. Both functions increase the reference counter of the
> new object, but many spots that call these two functions then forget to drop
> one of the superfluous references. So the newly created object is often not
> cleaned up correctly when the parent is destroyed. In the worst case, this
> can cause crashes, e.g. because device objects are not correctly removed from
> their parent_bus.
> 
> Since this is a common pattern between many code spots, let's introdcue a
> new function that takes care of calling all three required initialization
> functions, first object_initialize(), then object_property_add_child() and
> finally object_unref().
> 
> And while we're at object.h, also fix some copy-n-paste errors in the
> comments there ("to store the area" --> "to store the error").
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Potential candidates for using the new function, found using the
following Coccinelle patch:

@@
expression child, size, type, parent, errp, propname;
@@
-object_initialize(child, size, type);
-object_property_add_child(
+object_initialize_child(
                           parent, propname, 
-                          OBJECT(child),
+                          child, size, type,
                           errp);

Some of them (very few) already call object_unref() and need to
be fixed manually.

Most of the remaining ~50 object_initialize() callers are also
candidates, even if they don't call object_property_add_child()
today.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index bb9d33848d..e5923f85af 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -189,8 +189,8 @@ static void aspeed_board_init(MachineState *machine,
     DriveInfo *drive0 = drive_get(IF_MTD, 0, 0);
 
     bmc = g_new0(AspeedBoardState, 1);
-    object_initialize(&bmc->soc, (sizeof(bmc->soc)), cfg->soc_name);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(&bmc->soc),
+    object_initialize_child(OBJECT(machine), "soc",
+                              &bmc->soc, (sizeof(bmc->soc)), cfg->soc_name,
                               &error_abort);
 
     sc = ASPEED_SOC_GET_CLASS(&bmc->soc);
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index e68911af0f..994262756f 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -106,11 +106,11 @@ static void aspeed_soc_init(Object *obj)
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     int i;
 
-    object_initialize(&s->cpu, sizeof(s->cpu), sc->info->cpu_type);
-    object_property_add_child(obj, "cpu", OBJECT(&s->cpu), NULL);
+    object_initialize_child(obj, "cpu",  &s->cpu, sizeof(s->cpu),
+                            sc->info->cpu_type, NULL);
 
-    object_initialize(&s->scu, sizeof(s->scu), TYPE_ASPEED_SCU);
-    object_property_add_child(obj, "scu", OBJECT(&s->scu), NULL);
+    object_initialize_child(obj, "scu",  &s->scu, sizeof(s->scu),
+                            TYPE_ASPEED_SCU, NULL);
     qdev_set_parent_bus(DEVICE(&s->scu), sysbus_get_default());
     qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",
                          sc->info->silicon_rev);
@@ -121,35 +121,34 @@ static void aspeed_soc_init(Object *obj)
     object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),
                               "hw-prot-key", &error_abort);
 
-    object_initialize(&s->vic, sizeof(s->vic), TYPE_ASPEED_VIC);
-    object_property_add_child(obj, "vic", OBJECT(&s->vic), NULL);
+    object_initialize_child(obj, "vic",  &s->vic, sizeof(s->vic),
+                            TYPE_ASPEED_VIC, NULL);
     qdev_set_parent_bus(DEVICE(&s->vic), sysbus_get_default());
 
-    object_initialize(&s->timerctrl, sizeof(s->timerctrl), TYPE_ASPEED_TIMER);
-    object_property_add_child(obj, "timerctrl", OBJECT(&s->timerctrl), NULL);
+    object_initialize_child(obj, "timerctrl",  &s->timerctrl,
+                            sizeof(s->timerctrl), TYPE_ASPEED_TIMER, NULL);
     object_property_add_const_link(OBJECT(&s->timerctrl), "scu",
                                    OBJECT(&s->scu), &error_abort);
     qdev_set_parent_bus(DEVICE(&s->timerctrl), sysbus_get_default());
 
-    object_initialize(&s->i2c, sizeof(s->i2c), TYPE_ASPEED_I2C);
-    object_property_add_child(obj, "i2c", OBJECT(&s->i2c), NULL);
+    object_initialize_child(obj, "i2c",  &s->i2c, sizeof(s->i2c),
+                            TYPE_ASPEED_I2C, NULL);
     qdev_set_parent_bus(DEVICE(&s->i2c), sysbus_get_default());
 
-    object_initialize(&s->fmc, sizeof(s->fmc), sc->info->fmc_typename);
-    object_property_add_child(obj, "fmc", OBJECT(&s->fmc), NULL);
+    object_initialize_child(obj, "fmc",  &s->fmc, sizeof(s->fmc),
+                            sc->info->fmc_typename, NULL);
     qdev_set_parent_bus(DEVICE(&s->fmc), sysbus_get_default());
     object_property_add_alias(obj, "num-cs", OBJECT(&s->fmc), "num-cs",
                               &error_abort);
 
     for (i = 0; i < sc->info->spis_num; i++) {
-        object_initialize(&s->spi[i], sizeof(s->spi[i]),
-                          sc->info->spi_typename[i]);
-        object_property_add_child(obj, "spi[*]", OBJECT(&s->spi[i]), NULL);
+        object_initialize_child(obj, "spi[*]",  &s->spi[i], sizeof(s->spi[i]),
+                                sc->info->spi_typename[i], NULL);
         qdev_set_parent_bus(DEVICE(&s->spi[i]), sysbus_get_default());
     }
 
-    object_initialize(&s->sdmc, sizeof(s->sdmc), TYPE_ASPEED_SDMC);
-    object_property_add_child(obj, "sdmc", OBJECT(&s->sdmc), NULL);
+    object_initialize_child(obj, "sdmc",  &s->sdmc, sizeof(s->sdmc),
+                            TYPE_ASPEED_SDMC, NULL);
     qdev_set_parent_bus(DEVICE(&s->sdmc), sysbus_get_default());
     qdev_prop_set_uint32(DEVICE(&s->sdmc), "silicon-rev",
                          sc->info->silicon_rev);
@@ -157,15 +156,15 @@ static void aspeed_soc_init(Object *obj)
                               "ram-size", &error_abort);
 
     for (i = 0; i < sc->info->wdts_num; i++) {
-        object_initialize(&s->wdt[i], sizeof(s->wdt[i]), TYPE_ASPEED_WDT);
-        object_property_add_child(obj, "wdt[*]", OBJECT(&s->wdt[i]), NULL);
+        object_initialize_child(obj, "wdt[*]",  &s->wdt[i], sizeof(s->wdt[i]),
+                                TYPE_ASPEED_WDT, NULL);
         qdev_set_parent_bus(DEVICE(&s->wdt[i]), sysbus_get_default());
         qdev_prop_set_uint32(DEVICE(&s->wdt[i]), "silicon-rev",
                                     sc->info->silicon_rev);
     }
 
-    object_initialize(&s->ftgmac100, sizeof(s->ftgmac100), TYPE_FTGMAC100);
-    object_property_add_child(obj, "ftgmac100", OBJECT(&s->ftgmac100), NULL);
+    object_initialize_child(obj, "ftgmac100",  &s->ftgmac100,
+                            sizeof(s->ftgmac100), TYPE_FTGMAC100, NULL);
     qdev_set_parent_bus(DEVICE(&s->ftgmac100), sysbus_get_default());
 }
 
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 6be7660e8c..0fbfd4e4fb 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -41,8 +41,8 @@ static void bcm2835_peripherals_init(Object *obj)
                        MBOX_CHAN_COUNT << MBOX_AS_CHAN_SHIFT);
 
     /* Interrupt Controller */
-    object_initialize(&s->ic, sizeof(s->ic), TYPE_BCM2835_IC);
-    object_property_add_child(obj, "ic", OBJECT(&s->ic), NULL);
+    object_initialize_child(obj, "ic",  &s->ic, sizeof(s->ic),
+                            TYPE_BCM2835_IC, NULL);
     qdev_set_parent_bus(DEVICE(&s->ic), sysbus_get_default());
 
     /* UART0 */
@@ -51,21 +51,21 @@ static void bcm2835_peripherals_init(Object *obj)
     qdev_set_parent_bus(DEVICE(s->uart0), sysbus_get_default());
 
     /* AUX / UART1 */
-    object_initialize(&s->aux, sizeof(s->aux), TYPE_BCM2835_AUX);
-    object_property_add_child(obj, "aux", OBJECT(&s->aux), NULL);
+    object_initialize_child(obj, "aux",  &s->aux, sizeof(s->aux),
+                            TYPE_BCM2835_AUX, NULL);
     qdev_set_parent_bus(DEVICE(&s->aux), sysbus_get_default());
 
     /* Mailboxes */
-    object_initialize(&s->mboxes, sizeof(s->mboxes), TYPE_BCM2835_MBOX);
-    object_property_add_child(obj, "mbox", OBJECT(&s->mboxes), NULL);
+    object_initialize_child(obj, "mbox",  &s->mboxes, sizeof(s->mboxes),
+                            TYPE_BCM2835_MBOX, NULL);
     qdev_set_parent_bus(DEVICE(&s->mboxes), sysbus_get_default());
 
     object_property_add_const_link(OBJECT(&s->mboxes), "mbox-mr",
                                    OBJECT(&s->mbox_mr), &error_abort);
 
     /* Framebuffer */
-    object_initialize(&s->fb, sizeof(s->fb), TYPE_BCM2835_FB);
-    object_property_add_child(obj, "fb", OBJECT(&s->fb), NULL);
+    object_initialize_child(obj, "fb",  &s->fb, sizeof(s->fb),
+                            TYPE_BCM2835_FB, NULL);
     object_property_add_alias(obj, "vcram-size", OBJECT(&s->fb), "vcram-size",
                               &error_abort);
     qdev_set_parent_bus(DEVICE(&s->fb), sysbus_get_default());
@@ -74,8 +74,8 @@ static void bcm2835_peripherals_init(Object *obj)
                                    OBJECT(&s->gpu_bus_mr), &error_abort);
 
     /* Property channel */
-    object_initialize(&s->property, sizeof(s->property), TYPE_BCM2835_PROPERTY);
-    object_property_add_child(obj, "property", OBJECT(&s->property), NULL);
+    object_initialize_child(obj, "property",  &s->property,
+                            sizeof(s->property), TYPE_BCM2835_PROPERTY, NULL);
     object_property_add_alias(obj, "board-rev", OBJECT(&s->property),
                               "board-rev", &error_abort);
     qdev_set_parent_bus(DEVICE(&s->property), sysbus_get_default());
@@ -86,31 +86,31 @@ static void bcm2835_peripherals_init(Object *obj)
                                    OBJECT(&s->gpu_bus_mr), &error_abort);
 
     /* Random Number Generator */
-    object_initialize(&s->rng, sizeof(s->rng), TYPE_BCM2835_RNG);
-    object_property_add_child(obj, "rng", OBJECT(&s->rng), NULL);
+    object_initialize_child(obj, "rng",  &s->rng, sizeof(s->rng),
+                            TYPE_BCM2835_RNG, NULL);
     qdev_set_parent_bus(DEVICE(&s->rng), sysbus_get_default());
 
     /* Extended Mass Media Controller */
-    object_initialize(&s->sdhci, sizeof(s->sdhci), TYPE_SYSBUS_SDHCI);
-    object_property_add_child(obj, "sdhci", OBJECT(&s->sdhci), NULL);
+    object_initialize_child(obj, "sdhci",  &s->sdhci, sizeof(s->sdhci),
+                            TYPE_SYSBUS_SDHCI, NULL);
     qdev_set_parent_bus(DEVICE(&s->sdhci), sysbus_get_default());
 
     /* SDHOST */
-    object_initialize(&s->sdhost, sizeof(s->sdhost), TYPE_BCM2835_SDHOST);
-    object_property_add_child(obj, "sdhost", OBJECT(&s->sdhost), NULL);
+    object_initialize_child(obj, "sdhost",  &s->sdhost, sizeof(s->sdhost),
+                            TYPE_BCM2835_SDHOST, NULL);
     qdev_set_parent_bus(DEVICE(&s->sdhost), sysbus_get_default());
 
     /* DMA Channels */
-    object_initialize(&s->dma, sizeof(s->dma), TYPE_BCM2835_DMA);
-    object_property_add_child(obj, "dma", OBJECT(&s->dma), NULL);
+    object_initialize_child(obj, "dma",  &s->dma, sizeof(s->dma),
+                            TYPE_BCM2835_DMA, NULL);
     qdev_set_parent_bus(DEVICE(&s->dma), sysbus_get_default());
 
     object_property_add_const_link(OBJECT(&s->dma), "dma-mr",
                                    OBJECT(&s->gpu_bus_mr), &error_abort);
 
     /* GPIO */
-    object_initialize(&s->gpio, sizeof(s->gpio), TYPE_BCM2835_GPIO);
-    object_property_add_child(obj, "gpio", OBJECT(&s->gpio), NULL);
+    object_initialize_child(obj, "gpio",  &s->gpio, sizeof(s->gpio),
+                            TYPE_BCM2835_GPIO, NULL);
     qdev_set_parent_bus(DEVICE(&s->gpio), sysbus_get_default());
 
     object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhci",
diff --git a/hw/arm/digic.c b/hw/arm/digic.c
index 726abb9b48..90faca0710 100644
--- a/hw/arm/digic.c
+++ b/hw/arm/digic.c
@@ -35,8 +35,8 @@ static void digic_init(Object *obj)
     DeviceState *dev;
     int i;
 
-    object_initialize(&s->cpu, sizeof(s->cpu), "arm946-" TYPE_ARM_CPU);
-    object_property_add_child(obj, "cpu", OBJECT(&s->cpu), NULL);
+    object_initialize_child(obj, "cpu",  &s->cpu, sizeof(s->cpu),
+                            "arm946-" TYPE_ARM_CPU, NULL);
 
     for (i = 0; i < DIGIC4_NB_TIMERS; i++) {
 #define DIGIC_TIMER_NAME_MLEN    11
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 9f3ee14739..76769531b2 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -72,8 +72,8 @@ static void imx25_pdk_init(MachineState *machine)
     unsigned int alias_offset;
     int i;
 
-    object_initialize(&s->soc, sizeof(s->soc), TYPE_FSL_IMX25);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
+    object_initialize_child(OBJECT(machine), "soc",
+                              &s->soc, sizeof(s->soc), TYPE_FSL_IMX25,
                               &error_abort);
 
     object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_fatal);
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 864c7bd411..42f540fcdd 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -71,8 +71,8 @@ static void kzm_init(MachineState *machine)
     unsigned int alias_offset;
     unsigned int i;
 
-    object_initialize(&s->soc, sizeof(s->soc), TYPE_FSL_IMX31);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
+    object_initialize_child(OBJECT(machine), "soc",
+                              &s->soc, sizeof(s->soc), TYPE_FSL_IMX31,
                               &error_abort);
 
     object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_fatal);
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 22180c56fb..4849f5a6d1 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -111,8 +111,8 @@ static void init_sysbus_child(Object *parent, const char *childname,
                               void *child, size_t childsize,
                               const char *childtype)
 {
-    object_initialize(child, childsize, childtype);
-    object_property_add_child(parent, childname, OBJECT(child), &error_abort);
+    object_initialize_child(parent, childname,  child, childsize, childtype,
+                            &error_abort);
     qdev_set_parent_bus(DEVICE(child), sysbus_get_default());
 
 }
@@ -301,10 +301,10 @@ static void mps2tz_common_init(MachineState *machine)
     /* The sec_resp_cfg output from the IoTKit must be split into multiple
      * lines, one for each of the PPCs we create here.
      */
-    object_initialize(&mms->sec_resp_splitter, sizeof(mms->sec_resp_splitter),
-                      TYPE_SPLIT_IRQ);
-    object_property_add_child(OBJECT(machine), "sec-resp-splitter",
-                              OBJECT(&mms->sec_resp_splitter), &error_abort);
+    object_initialize_child(OBJECT(machine), "sec-resp-splitter",
+                               &mms->sec_resp_splitter,
+                              sizeof(mms->sec_resp_splitter), TYPE_SPLIT_IRQ,
+                              &error_abort);
     object_property_set_int(OBJECT(&mms->sec_resp_splitter), 5,
                             "num-lines", &error_fatal);
     object_property_set_bool(OBJECT(&mms->sec_resp_splitter), true,
@@ -338,10 +338,10 @@ static void mps2tz_common_init(MachineState *machine)
      * Tx, Rx and "combined" IRQs are sent to the NVIC separately.
      * Create the OR gate for this.
      */
-    object_initialize(&mms->uart_irq_orgate, sizeof(mms->uart_irq_orgate),
-                      TYPE_OR_IRQ);
-    object_property_add_child(OBJECT(mms), "uart-irq-orgate",
-                              OBJECT(&mms->uart_irq_orgate), &error_abort);
+    object_initialize_child(OBJECT(mms), "uart-irq-orgate",
+                               &mms->uart_irq_orgate,
+                              sizeof(mms->uart_irq_orgate), TYPE_OR_IRQ,
+                              &error_abort);
     object_property_set_int(OBJECT(&mms->uart_irq_orgate), 10, "num-lines",
                             &error_fatal);
     object_property_set_bool(OBJECT(&mms->uart_irq_orgate), true,
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 66899c28dc..6c9f89cbfd 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -175,9 +175,9 @@ static void raspi_init(MachineState *machine, int version)
     BusState *bus;
     DeviceState *carddev;
 
-    object_initialize(&s->soc, sizeof(s->soc),
-                      version == 3 ? TYPE_BCM2837 : TYPE_BCM2836);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
+    object_initialize_child(OBJECT(machine), "soc",
+                              &s->soc, sizeof(s->soc),
+                              version == 3 ? TYPE_BCM2837 : TYPE_BCM2836,
                               &error_abort);
 
     /* Allocate and map RAM */
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index ee140e5d9e..fe094c95d4 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -55,8 +55,8 @@ static void sabrelite_init(MachineState *machine)
         exit(1);
     }
 
-    object_initialize(&s->soc, sizeof(s->soc), TYPE_FSL_IMX6);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
+    object_initialize_child(OBJECT(machine), "soc",
+                              &s->soc, sizeof(s->soc), TYPE_FSL_IMX6,
                               &error_abort);
 
     object_property_set_bool(OBJECT(&s->soc), true, "realized", &err);
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index b6bc6a93b8..1d5a4c6be8 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -91,8 +91,8 @@ static void xlnx_zcu102_init(MachineState *machine)
     memory_region_allocate_system_memory(&s->ddr_ram, NULL, "ddr-ram",
                                          ram_size);
 
-    object_initialize(&s->soc, sizeof(s->soc), TYPE_XLNX_ZYNQMP);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
+    object_initialize_child(OBJECT(machine), "soc",
+                              &s->soc, sizeof(s->soc), TYPE_XLNX_ZYNQMP,
                               &error_abort);
 
     object_property_set_link(OBJECT(&s->soc), OBJECT(&s->ddr_ram),
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index a1365b44a0..f0420df8c4 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -133,10 +133,9 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
     for (i = 0; i < num_rpus; i++) {
         char *name;
 
-        object_initialize(&s->rpu_cpu[i], sizeof(s->rpu_cpu[i]),
-                          "cortex-r5f-" TYPE_ARM_CPU);
-        object_property_add_child(OBJECT(s), "rpu-cpu[*]",
-                                  OBJECT(&s->rpu_cpu[i]), &error_abort);
+        object_initialize_child(OBJECT(s), "rpu-cpu[*]",
+                                   &s->rpu_cpu[i], sizeof(s->rpu_cpu[i]),
+                                  "cortex-r5f-" TYPE_ARM_CPU, &error_abort);
 
         name = object_get_canonical_path_component(OBJECT(&s->rpu_cpu[i]));
         if (strcmp(name, boot_cpu)) {
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 999a5657cf..62f2e43707 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -62,9 +62,8 @@ static void xlnx_zynqmp_pmu_soc_init(Object *obj)
 {
     XlnxZynqMPPMUSoCState *s = XLNX_ZYNQMP_PMU_SOC(obj);
 
-    object_initialize(&s->cpu, sizeof(s->cpu),
-                      TYPE_MICROBLAZE_CPU);
-    object_property_add_child(obj, "pmu-cpu", OBJECT(&s->cpu),
+    object_initialize_child(obj, "pmu-cpu",
+                              &s->cpu, sizeof(s->cpu), TYPE_MICROBLAZE_CPU,
                               &error_abort);
 
     object_initialize(&s->intc, sizeof(s->intc), TYPE_XLNX_PMU_IO_INTC);
@@ -163,9 +162,9 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
                                 pmu_ram);
 
     /* Create the PMU device */
-    object_initialize(pmu, sizeof(XlnxZynqMPPMUSoCState), TYPE_XLNX_ZYNQMP_PMU_SOC);
-    object_property_add_child(OBJECT(machine), "pmu", OBJECT(pmu),
-                              &error_abort);
+    object_initialize_child(OBJECT(machine), "pmu",
+                              pmu, sizeof(XlnxZynqMPPMUSoCState),
+                              TYPE_XLNX_ZYNQMP_PMU_SOC, &error_abort);
     object_property_set_bool(OBJECT(pmu), true, "realized", &error_fatal);
 
     for (i = 0; i < 32; i++) {
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 29ea313798..8590ec657b 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -721,8 +721,8 @@ static void designware_pcie_host_init(Object *obj)
     DesignwarePCIEHost *s = DESIGNWARE_PCIE_HOST(obj);
     DesignwarePCIERoot *root = &s->root;
 
-    object_initialize(root, sizeof(*root), TYPE_DESIGNWARE_PCIE_ROOT);
-    object_property_add_child(obj, "root", OBJECT(root), NULL);
+    object_initialize_child(obj, "root",  root, sizeof(*root),
+                            TYPE_DESIGNWARE_PCIE_ROOT, NULL);
     qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
     qdev_prop_set_bit(DEVICE(root), "multifunction", false);
 }
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index 2583b151a4..060e80930b 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -120,8 +120,8 @@ static void gpex_host_initfn(Object *obj)
     GPEXHost *s = GPEX_HOST(obj);
     GPEXRootState *root = &s->gpex_root;
 
-    object_initialize(root, sizeof(*root), TYPE_GPEX_ROOT_DEVICE);
-    object_property_add_child(obj, "gpex_root", OBJECT(root), NULL);
+    object_initialize_child(obj, "gpex_root",  root, sizeof(*root),
+                            TYPE_GPEX_ROOT_DEVICE, NULL);
     qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
     qdev_prop_set_bit(DEVICE(root), "multifunction", false);
 }
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 02f9576588..d590035659 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -205,8 +205,8 @@ static void q35_host_initfn(Object *obj)
     memory_region_init_io(&phb->data_mem, obj, &pci_host_data_le_ops, phb,
                           "pci-conf-data", 4);
 
-    object_initialize(&s->mch, sizeof(s->mch), TYPE_MCH_PCI_DEVICE);
-    object_property_add_child(OBJECT(s), "mch", OBJECT(&s->mch), NULL);
+    object_initialize_child(OBJECT(s), "mch",  &s->mch, sizeof(s->mch),
+                            TYPE_MCH_PCI_DEVICE, NULL);
     qdev_prop_set_int32(DEVICE(&s->mch), "addr", PCI_DEVFN(0, 0));
     qdev_prop_set_bit(DEVICE(&s->mch), "multifunction", false);
     /* mch's object_initialize resets the default value, set it again */
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 60309afe9e..f82d3f3e33 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -149,8 +149,8 @@ static void xilinx_pcie_host_init(Object *obj)
     XilinxPCIEHost *s = XILINX_PCIE_HOST(obj);
     XilinxPCIERoot *root = &s->root;
 
-    object_initialize(root, sizeof(*root), TYPE_XILINX_PCIE_ROOT);
-    object_property_add_child(obj, "root", OBJECT(root), NULL);
+    object_initialize_child(obj, "root",  root, sizeof(*root),
+                            TYPE_XILINX_PCIE_ROOT, NULL);
     qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
     qdev_prop_set_bit(DEVICE(root), "multifunction", false);
 }
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0989f6a05f..93eb2948cc 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -726,18 +726,18 @@ static void pnv_chip_power8_instance_init(Object *obj)
 {
     Pnv8Chip *chip8 = PNV8_CHIP(obj);
 
-    object_initialize(&chip8->psi, sizeof(chip8->psi), TYPE_PNV_PSI);
-    object_property_add_child(obj, "psi", OBJECT(&chip8->psi), NULL);
+    object_initialize_child(obj, "psi",  &chip8->psi, sizeof(chip8->psi),
+                            TYPE_PNV_PSI, NULL);
     object_property_add_const_link(OBJECT(&chip8->psi), "xics",
                                    OBJECT(qdev_get_machine()), &error_abort);
 
-    object_initialize(&chip8->lpc, sizeof(chip8->lpc), TYPE_PNV_LPC);
-    object_property_add_child(obj, "lpc", OBJECT(&chip8->lpc), NULL);
+    object_initialize_child(obj, "lpc",  &chip8->lpc, sizeof(chip8->lpc),
+                            TYPE_PNV_LPC, NULL);
     object_property_add_const_link(OBJECT(&chip8->lpc), "psi",
                                    OBJECT(&chip8->psi), &error_abort);
 
-    object_initialize(&chip8->occ, sizeof(chip8->occ), TYPE_PNV_OCC);
-    object_property_add_child(obj, "occ", OBJECT(&chip8->occ), NULL);
+    object_initialize_child(obj, "occ",  &chip8->occ, sizeof(chip8->occ),
+                            TYPE_PNV_OCC, NULL);
     object_property_add_const_link(OBJECT(&chip8->occ), "psi",
                                    OBJECT(&chip8->psi), &error_abort);
 }
@@ -975,9 +975,8 @@ static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
         }
 
         snprintf(core_name, sizeof(core_name), "core[%d]", core_hwid);
-        object_initialize(pnv_core, typesize, typename);
-        object_property_add_child(OBJECT(chip), core_name, OBJECT(pnv_core),
-                                  &error_fatal);
+        object_initialize_child(OBJECT(chip), core_name,
+                                  pnv_core, typesize, typename, &error_fatal);
         object_property_set_int(OBJECT(pnv_core), smp_threads, "nr-threads",
                                 &error_fatal);
         object_property_set_int(OBJECT(pnv_core), core_hwid,
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 5b969127c3..2e29089e66 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -445,8 +445,8 @@ static void pnv_psi_init(Object *obj)
 {
     PnvPsi *psi = PNV_PSI(obj);
 
-    object_initialize(&psi->ics, sizeof(psi->ics), TYPE_ICS_SIMPLE);
-    object_property_add_child(obj, "ics-psi", OBJECT(&psi->ics), NULL);
+    object_initialize_child(obj, "ics-psi",  &psi->ics, sizeof(psi->ics),
+                            TYPE_ICS_SIMPLE, NULL);
 }
 
 static const uint8_t irq_to_xivr[] = {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3f5e1d3ec2..8c4bdb147a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1700,8 +1700,8 @@ static void spapr_create_nvram(sPAPRMachineState *spapr)
 
 static void spapr_rtc_create(sPAPRMachineState *spapr)
 {
-    object_initialize(&spapr->rtc, sizeof(spapr->rtc), TYPE_SPAPR_RTC);
-    object_property_add_child(OBJECT(spapr), "rtc", OBJECT(&spapr->rtc),
+    object_initialize_child(OBJECT(spapr), "rtc",
+                              &spapr->rtc, sizeof(spapr->rtc), TYPE_SPAPR_RTC,
                               &error_fatal);
     object_property_set_bool(OBJECT(&spapr->rtc), true, "realized",
                               &error_fatal);
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 8a8dbe1c00..b323eac391 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -105,8 +105,8 @@ static void riscv_sifive_e_init(MachineState *machine)
     int i;
 
     /* Initialize SoC */
-    object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_E_SOC);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
+    object_initialize_child(OBJECT(machine), "soc",
+                              &s->soc, sizeof(s->soc), TYPE_RISCV_E_SOC,
                               &error_abort);
     object_property_set_bool(OBJECT(&s->soc), true, "realized",
                             &error_abort);
@@ -139,9 +139,9 @@ static void riscv_sifive_e_soc_init(Object *obj)
 {
     SiFiveESoCState *s = RISCV_E_SOC(obj);
 
-    object_initialize(&s->cpus, sizeof(s->cpus), TYPE_RISCV_HART_ARRAY);
-    object_property_add_child(obj, "cpus", OBJECT(&s->cpus),
-                              &error_abort);
+    object_initialize_child(obj, "cpus",
+                              &s->cpus, sizeof(s->cpus),
+                              TYPE_RISCV_HART_ARRAY, &error_abort);
     object_property_set_str(OBJECT(&s->cpus), SIFIVE_E_CPU, "cpu-type",
                             &error_abort);
     object_property_set_int(OBJECT(&s->cpus), smp_cpus, "num-harts",
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 3a6ffeb437..c94900f345 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -244,8 +244,8 @@ static void riscv_sifive_u_init(MachineState *machine)
     int i;
 
     /* Initialize SoC */
-    object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_U_SOC);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
+    object_initialize_child(OBJECT(machine), "soc",
+                              &s->soc, sizeof(s->soc), TYPE_RISCV_U_SOC,
                               &error_abort);
     object_property_set_bool(OBJECT(&s->soc), true, "realized",
                             &error_abort);
@@ -303,9 +303,9 @@ static void riscv_sifive_u_soc_init(Object *obj)
 {
     SiFiveUSoCState *s = RISCV_U_SOC(obj);
 
-    object_initialize(&s->cpus, sizeof(s->cpus), TYPE_RISCV_HART_ARRAY);
-    object_property_add_child(obj, "cpus", OBJECT(&s->cpus),
-                              &error_abort);
+    object_initialize_child(obj, "cpus",
+                              &s->cpus, sizeof(s->cpus),
+                              TYPE_RISCV_HART_ARRAY, &error_abort);
     object_property_set_str(OBJECT(&s->cpus), SIFIVE_U_CPU, "cpu-type",
                             &error_abort);
     object_property_set_int(OBJECT(&s->cpus), smp_cpus, "num-harts",
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index f94e2b6707..44639a8c99 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -171,8 +171,8 @@ static void spike_v1_10_0_board_init(MachineState *machine)
     int i;
 
     /* Initialize SOC */
-    object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_HART_ARRAY);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
+    object_initialize_child(OBJECT(machine), "soc",
+                              &s->soc, sizeof(s->soc), TYPE_RISCV_HART_ARRAY,
                               &error_abort);
     object_property_set_str(OBJECT(&s->soc), SPIKE_V1_10_0_CPU, "cpu-type",
                             &error_abort);
@@ -254,8 +254,8 @@ static void spike_v1_09_1_board_init(MachineState *machine)
     int i;
 
     /* Initialize SOC */
-    object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_HART_ARRAY);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
+    object_initialize_child(OBJECT(machine), "soc",
+                              &s->soc, sizeof(s->soc), TYPE_RISCV_HART_ARRAY,
                               &error_abort);
     object_property_set_str(OBJECT(&s->soc), SPIKE_V1_09_1_CPU, "cpu-type",
                             &error_abort);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index aeada2498d..d597916885 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -274,8 +274,8 @@ static void riscv_virt_board_init(MachineState *machine)
     void *fdt;
 
     /* Initialize SOC */
-    object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_HART_ARRAY);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
+    object_initialize_child(OBJECT(machine), "soc",
+                              &s->soc, sizeof(s->soc), TYPE_RISCV_HART_ARRAY,
                               &error_abort);
     object_property_set_str(OBJECT(&s->soc), VIRT_CPU, "cpu-type",
                             &error_abort);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index d4e4d98b59..acf7b4e40e 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2232,8 +2232,8 @@ void virtio_instance_init_common(Object *proxy_obj, void *data,
 {
     DeviceState *vdev = data;
 
-    object_initialize(vdev, vdev_size, vdev_name);
-    object_property_add_child(proxy_obj, "virtio-backend", OBJECT(vdev), NULL);
+    object_initialize_child(proxy_obj, "virtio-backend",  vdev, vdev_size,
+                            vdev_name, NULL);
     object_unref(OBJECT(vdev));
     qdev_alias_all_properties(vdev, proxy_obj);
 }
diff --git a/qom/object.c b/qom/object.c
index 7be7638db1..91ff795b38 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -396,8 +396,7 @@ void object_initialize_child(Object *parentobj, const char *propname,
                              void *childobj, size_t size, const char *type,
                              Error **errp)
 {
-    object_initialize(childobj, size, type);
-    object_property_add_child(parentobj, propname, OBJECT(childobj), errp);
+    object_initialize_child(parentobj, propname,  childobj, size, type, errp);
     /*
      * Since object_property_add_child added a reference to the child object,
      * we can drop the reference added by object_initialize(), so the child
 
-- 
Eduardo
