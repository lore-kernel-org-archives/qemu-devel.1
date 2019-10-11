Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36A3C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 17:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 775EB2084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 17:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775EB2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIySA-000204-4T
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 13:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIxRF-0006nn-PO
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:06:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIxR5-0004jg-1W
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:06:45 -0400
Received: from relay.sw.ru ([185.231.240.75]:48052)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIxR4-0004Et-2r; Fri, 11 Oct 2019 12:06:34 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIxQe-0003XG-6g; Fri, 11 Oct 2019 19:06:08 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [RFC v5 033/126] ARM Machines: introduce ERRP_AUTO_PROPAGATE
Date: Fri, 11 Oct 2019 19:04:19 +0300
Message-Id: <20191011160552.22907-34-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011160552.22907-1-vsementsov@virtuozzo.com>
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, vsementsov@virtuozzo.com,
 Antony Pavlov <antonynpavlov@gmail.com>, Andrew Jeffery <andrew@aj.id.au>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 armbru@redhat.com, Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Greg Kurz <groug@kaod.org>, Beniamino Galvani <b.galvani@gmail.com>,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we want to add some info to errp (by error_prepend() or
error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
Otherwise, this info will not be added when errp == &fatal_err
(the program will exit prior to the error_append_hint() or
error_prepend() call).  Fix such cases.

If we want to check error after errp-function call, we need to
introduce local_err and than propagate it to errp. Instead, use
ERRP_AUTO_PROPAGATE macro, benefits are:
1. No need of explicit error_propagate call
2. No need of explicit local_err variable: use errp directly
3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
   &error_fatel, this means that we don't break error_abort
   (we'll abort on error_set, not on error_propagate)

This commit (together with its neighbors) was generated by

for f in $(git grep -l errp \*.[ch]); do \
    spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
    --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff $f; \
done;

then fix a bit of compilation problems: coccinelle for some reason
leaves several
f() {
    ...
    goto out;
    ...
    out:
}
patterns, with "out:" at function end.

then
./python/commit-per-subsystem.py MAINTAINERS "$(< auto-msg)"

(auto-msg was a file with this commit message)

Still, for backporting it may be more comfortable to use only the first
command and then do one huge commit.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Reported-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 hw/arm/allwinner-a10.c          | 27 +++++------
 hw/arm/aspeed_soc.c             |  1 +
 hw/arm/bcm2835_peripherals.c    | 85 ++++++++++++++------------------
 hw/arm/bcm2836.c                | 41 +++++++---------
 hw/arm/digic.c                  | 22 ++++-----
 hw/arm/fsl-imx25.c              | 62 ++++++++++--------------
 hw/arm/fsl-imx31.c              | 57 +++++++++-------------
 hw/arm/fsl-imx6.c               | 81 +++++++++++++------------------
 hw/arm/integratorcp.c           |  7 ++-
 hw/arm/msf2-soc.c               | 22 ++++-----
 hw/arm/nrf51_soc.c              | 47 ++++++++----------
 hw/arm/stm32f205_soc.c          | 39 ++++++---------
 hw/arm/virt.c                   |  2 +
 hw/arm/xlnx-versal-virt.c       |  7 ++-
 hw/arm/xlnx-zynqmp.c            | 86 ++++++++++++++-------------------
 hw/cpu/realview_mpcore.c        | 12 ++---
 hw/display/bcm2835_fb.c         |  6 +--
 hw/dma/bcm2835_dma.c            |  6 +--
 hw/dma/xilinx_axidma.c          | 22 ++++-----
 hw/gpio/aspeed_gpio.c           |  7 ++-
 hw/gpio/bcm2835_gpio.c          | 10 ++--
 hw/intc/arm_gic.c               |  7 ++-
 hw/intc/arm_gic_kvm.c           | 12 ++---
 hw/intc/arm_gicv3.c             | 12 ++---
 hw/intc/arm_gicv3_its_kvm.c     |  7 ++-
 hw/intc/arm_gicv3_kvm.c         | 17 +++----
 hw/intc/armv7m_nvic.c           | 12 ++---
 hw/intc/realview_gic.c          |  7 ++-
 hw/microblaze/xlnx-zynqmp-pmu.c | 12 ++---
 hw/misc/bcm2835_mbox.c          |  6 +--
 hw/misc/bcm2835_property.c      | 10 ++--
 hw/misc/msf2-sysreg.c           |  1 +
 hw/net/xilinx_axienet.c         | 22 ++++-----
 hw/nvram/nrf51_nvm.c            |  7 ++-
 hw/timer/aspeed_timer.c         |  6 +--
 hw/watchdog/wdt_aspeed.c        |  5 +-
 36 files changed, 332 insertions(+), 460 deletions(-)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 118032c8c7..d33af2939c 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -47,23 +47,21 @@ static void aw_a10_init(Object *obj)
 
 static void aw_a10_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     AwA10State *s = AW_A10(dev);
     SysBusDevice *sysbusdev;
     uint8_t i;
     qemu_irq fiq, irq;
-    Error *err = NULL;
 
-    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->cpu), true, "realized", errp);
+    if (*errp) {
         return;
     }
     irq = qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_IRQ);
     fiq = qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ);
 
-    object_property_set_bool(OBJECT(&s->intc), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->intc), true, "realized", errp);
+    if (*errp) {
         return;
     }
     sysbusdev = SYS_BUS_DEVICE(&s->intc);
@@ -74,9 +72,8 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
         s->irq[i] = qdev_get_gpio_in(DEVICE(&s->intc), i);
     }
 
-    object_property_set_bool(OBJECT(&s->timer), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->timer), true, "realized", errp);
+    if (*errp) {
         return;
     }
     sysbusdev = SYS_BUS_DEVICE(&s->timer);
@@ -98,18 +95,16 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
         qemu_check_nic_model(&nd_table[0], TYPE_AW_EMAC);
         qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
     }
-    object_property_set_bool(OBJECT(&s->emac), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->emac), true, "realized", errp);
+    if (*errp) {
         return;
     }
     sysbusdev = SYS_BUS_DEVICE(&s->emac);
     sysbus_mmio_map(sysbusdev, 0, AW_A10_EMAC_BASE);
     sysbus_connect_irq(sysbusdev, 0, s->irq[55]);
 
-    object_property_set_bool(OBJECT(&s->sata), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->sata), true, "realized", errp);
+    if (*errp) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sata), 0, AW_A10_SATA_BASE);
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index cf1d0cf921..929ed713ac 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -234,6 +234,7 @@ static void aspeed_soc_init(Object *obj)
 
 static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     int i;
     AspeedSoCState *s = ASPEED_SOC(dev);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 8984e2e91f..36b9e9b9cf 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -109,17 +109,17 @@ static void bcm2835_peripherals_init(Object *obj)
 
 static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     BCM2835PeripheralState *s = BCM2835_PERIPHERALS(dev);
     Object *obj;
     MemoryRegion *ram;
-    Error *err = NULL;
     uint64_t ram_size, vcram_size;
     int n;
 
-    obj = object_property_get_link(OBJECT(dev), "ram", &err);
+    obj = object_property_get_link(OBJECT(dev), "ram", errp);
     if (obj == NULL) {
         error_setg(errp, "%s: required ram link not found: %s",
-                   __func__, error_get_pretty(err));
+                   __func__, error_get_pretty(*errp));
         return;
     }
 
@@ -143,9 +143,8 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     }
 
     /* Interrupt Controller */
-    object_property_set_bool(OBJECT(&s->ic), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->ic), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
@@ -155,9 +154,8 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
 
     /* UART0 */
     qdev_prop_set_chr(DEVICE(&s->uart0), "chardev", serial_hd(0));
-    object_property_set_bool(OBJECT(&s->uart0), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->uart0), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
@@ -169,9 +167,8 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     /* AUX / UART1 */
     qdev_prop_set_chr(DEVICE(&s->aux), "chardev", serial_hd(1));
 
-    object_property_set_bool(OBJECT(&s->aux), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->aux), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
@@ -182,9 +179,8 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                                INTERRUPT_AUX));
 
     /* Mailboxes */
-    object_property_set_bool(OBJECT(&s->mboxes), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->mboxes), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
@@ -195,22 +191,19 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                                INTERRUPT_ARM_MAILBOX));
 
     /* Framebuffer */
-    vcram_size = object_property_get_uint(OBJECT(s), "vcram-size", &err);
-    if (err) {
-        error_propagate(errp, err);
+    vcram_size = object_property_get_uint(OBJECT(s), "vcram-size", errp);
+    if (*errp) {
         return;
     }
 
     object_property_set_uint(OBJECT(&s->fb), ram_size - vcram_size,
-                             "vcram-base", &err);
-    if (err) {
-        error_propagate(errp, err);
+                             "vcram-base", errp);
+    if (*errp) {
         return;
     }
 
-    object_property_set_bool(OBJECT(&s->fb), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->fb), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
@@ -220,9 +213,8 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                        qdev_get_gpio_in(DEVICE(&s->mboxes), MBOX_CHAN_FB));
 
     /* Property channel */
-    object_property_set_bool(OBJECT(&s->property), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->property), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
@@ -233,9 +225,8 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                       qdev_get_gpio_in(DEVICE(&s->mboxes), MBOX_CHAN_PROPERTY));
 
     /* Random Number Generator */
-    object_property_set_bool(OBJECT(&s->rng), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->rng), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
@@ -252,19 +243,17 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
      * For the exact details please refer to the Arasan documentation:
      *   SD3.0_Host_AHB_eMMC4.4_Usersguide_ver5.9_jan11_10.pdf
      */
-    object_property_set_uint(OBJECT(&s->sdhci), 3, "sd-spec-version", &err);
+    object_property_set_uint(OBJECT(&s->sdhci), 3, "sd-spec-version", errp);
     object_property_set_uint(OBJECT(&s->sdhci), BCM2835_SDHC_CAPAREG, "capareg",
-                             &err);
+                             errp);
     object_property_set_bool(OBJECT(&s->sdhci), true, "pending-insert-quirk",
-                             &err);
-    if (err) {
-        error_propagate(errp, err);
+                             errp);
+    if (*errp) {
         return;
     }
 
-    object_property_set_bool(OBJECT(&s->sdhci), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->sdhci), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
@@ -275,9 +264,8 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                                INTERRUPT_ARASANSDIO));
 
     /* SDHOST */
-    object_property_set_bool(OBJECT(&s->sdhost), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->sdhost), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
@@ -288,9 +276,8 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                                INTERRUPT_SDIO));
 
     /* DMA Channels */
-    object_property_set_bool(OBJECT(&s->dma), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->dma), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
@@ -307,9 +294,8 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     }
 
     /* GPIO */
-    object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->gpio), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
@@ -317,9 +303,8 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gpio), 0));
 
     object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->gpio), "sd-bus",
-                              &err);
-    if (err) {
-        error_propagate(errp, err);
+                              errp);
+    if (*errp) {
         return;
     }
 }
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 493a913f89..c8cfdd4ee9 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -68,38 +68,35 @@ static void bcm2836_init(Object *obj)
 
 static void bcm2836_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     BCM283XState *s = BCM283X(dev);
     BCM283XClass *bc = BCM283X_GET_CLASS(dev);
     const BCM283XInfo *info = bc->info;
     Object *obj;
-    Error *err = NULL;
     int n;
 
     /* common peripherals from bcm2835 */
 
-    obj = object_property_get_link(OBJECT(dev), "ram", &err);
+    obj = object_property_get_link(OBJECT(dev), "ram", errp);
     if (obj == NULL) {
         error_setg(errp, "%s: required ram link not found: %s",
-                   __func__, error_get_pretty(err));
+                   __func__, error_get_pretty(*errp));
         return;
     }
 
-    object_property_add_const_link(OBJECT(&s->peripherals), "ram", obj, &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_add_const_link(OBJECT(&s->peripherals), "ram", obj, errp);
+    if (*errp) {
         return;
     }
 
-    object_property_set_bool(OBJECT(&s->peripherals), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->peripherals), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
     object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->peripherals),
-                              "sd-bus", &err);
-    if (err) {
-        error_propagate(errp, err);
+                              "sd-bus", errp);
+    if (*errp) {
         return;
     }
 
@@ -107,9 +104,8 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
                             BCM2836_PERI_BASE, 1);
 
     /* bcm2836 interrupt controller (and mailboxes, etc.) */
-    object_property_set_bool(OBJECT(&s->control), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->control), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
@@ -127,23 +123,20 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         /* set periphbase/CBAR value for CPU-local registers */
         object_property_set_int(OBJECT(&s->cpus[n]),
                                 BCM2836_PERI_BASE + MCORE_OFFSET,
-                                "reset-cbar", &err);
-        if (err) {
-            error_propagate(errp, err);
+                                "reset-cbar", errp);
+        if (*errp) {
             return;
         }
 
         /* start powered off if not enabled */
         object_property_set_bool(OBJECT(&s->cpus[n]), n >= s->enabled_cpus,
-                                 "start-powered-off", &err);
-        if (err) {
-            error_propagate(errp, err);
+                                 "start-powered-off", errp);
+        if (*errp) {
             return;
         }
 
-        object_property_set_bool(OBJECT(&s->cpus[n]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->cpus[n]), true, "realized", errp);
+        if (*errp) {
             return;
         }
 
diff --git a/hw/arm/digic.c b/hw/arm/digic.c
index 22434a65a2..25e872305d 100644
--- a/hw/arm/digic.c
+++ b/hw/arm/digic.c
@@ -55,27 +55,24 @@ static void digic_init(Object *obj)
 
 static void digic_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     DigicState *s = DIGIC(dev);
-    Error *err = NULL;
     SysBusDevice *sbd;
     int i;
 
-    object_property_set_bool(OBJECT(&s->cpu), true, "reset-hivecs", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->cpu), true, "reset-hivecs", errp);
+    if (*errp) {
         return;
     }
 
-    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->cpu), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
     for (i = 0; i < DIGIC4_NB_TIMERS; i++) {
-        object_property_set_bool(OBJECT(&s->timer[i]), true, "realized", &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->timer[i]), true, "realized", errp);
+        if (*errp) {
             return;
         }
 
@@ -84,9 +81,8 @@ static void digic_realize(DeviceState *dev, Error **errp)
     }
 
     qdev_prop_set_chr(DEVICE(&s->uart), "chardev", serial_hd(0));
-    object_property_set_bool(OBJECT(&s->uart), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->uart), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 3cb5a8fdfd..22a8e889bf 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -75,19 +75,17 @@ static void fsl_imx25_init(Object *obj)
 
 static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     FslIMX25State *s = FSL_IMX25(dev);
     uint8_t i;
-    Error *err = NULL;
 
-    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->cpu), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
-    object_property_set_bool(OBJECT(&s->avic), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->avic), true, "realized", errp);
+    if (*errp) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->avic), 0, FSL_IMX25_AVIC_ADDR);
@@ -96,9 +94,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->avic), 1,
                        qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
 
-    object_property_set_bool(OBJECT(&s->ccm), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->ccm), true, "realized", errp);
+    if (*errp) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccm), 0, FSL_IMX25_CCM_ADDR);
@@ -118,9 +115,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
         qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
 
-        object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", errp);
+        if (*errp) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, serial_table[i].addr);
@@ -143,9 +139,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
         s->gpt[i].ccm = IMX_CCM(&s->ccm);
 
-        object_property_set_bool(OBJECT(&s->gpt[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->gpt[i]), true, "realized", errp);
+        if (*errp) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpt[i]), 0, gpt_table[i].addr);
@@ -166,9 +161,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
         s->epit[i].ccm = IMX_CCM(&s->ccm);
 
-        object_property_set_bool(OBJECT(&s->epit[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->epit[i]), true, "realized", errp);
+        if (*errp) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->epit[i]), 0, epit_table[i].addr);
@@ -179,9 +173,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
     qdev_set_nic_properties(DEVICE(&s->fec), &nd_table[0]);
 
-    object_property_set_bool(OBJECT(&s->fec), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->fec), true, "realized", errp);
+    if (*errp) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->fec), 0, FSL_IMX25_FEC_ADDR);
@@ -200,9 +193,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
             { FSL_IMX25_I2C3_ADDR, FSL_IMX25_I2C3_IRQ }
         };
 
-        object_property_set_bool(OBJECT(&s->i2c[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->i2c[i]), true, "realized", errp);
+        if (*errp) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c[i]), 0, i2c_table[i].addr);
@@ -223,9 +215,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
             { FSL_IMX25_GPIO4_ADDR, FSL_IMX25_GPIO4_IRQ }
         };
 
-        object_property_set_bool(OBJECT(&s->gpio[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->gpio[i]), true, "realized", errp);
+        if (*errp) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0, gpio_table[i].addr);
@@ -237,17 +228,15 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
     /* initialize 2 x 16 KB ROM */
     memory_region_init_rom(&s->rom[0], NULL,
-                           "imx25.rom0", FSL_IMX25_ROM0_SIZE, &err);
-    if (err) {
-        error_propagate(errp, err);
+                           "imx25.rom0", FSL_IMX25_ROM0_SIZE, errp);
+    if (*errp) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX25_ROM0_ADDR,
                                 &s->rom[0]);
     memory_region_init_rom(&s->rom[1], NULL,
-                           "imx25.rom1", FSL_IMX25_ROM1_SIZE, &err);
-    if (err) {
-        error_propagate(errp, err);
+                           "imx25.rom1", FSL_IMX25_ROM1_SIZE, errp);
+    if (*errp) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX25_ROM1_ADDR,
@@ -255,9 +244,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
     /* initialize internal RAM (128 KB) */
     memory_region_init_ram(&s->iram, NULL, "imx25.iram", FSL_IMX25_IRAM_SIZE,
-                           &err);
-    if (err) {
-        error_propagate(errp, err);
+                           errp);
+    if (*errp) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX25_IRAM_ADDR,
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 55e90d104b..d818d8882a 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -67,19 +67,17 @@ static void fsl_imx31_init(Object *obj)
 
 static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     FslIMX31State *s = FSL_IMX31(dev);
     uint16_t i;
-    Error *err = NULL;
 
-    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->cpu), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
-    object_property_set_bool(OBJECT(&s->avic), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->avic), true, "realized", errp);
+    if (*errp) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->avic), 0, FSL_IMX31_AVIC_ADDR);
@@ -88,9 +86,8 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->avic), 1,
                        qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
 
-    object_property_set_bool(OBJECT(&s->ccm), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->ccm), true, "realized", errp);
+    if (*errp) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccm), 0, FSL_IMX31_CCM_ADDR);
@@ -107,9 +104,8 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
         qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
 
-        object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", errp);
+        if (*errp) {
             return;
         }
 
@@ -121,9 +117,8 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
     s->gpt.ccm = IMX_CCM(&s->ccm);
 
-    object_property_set_bool(OBJECT(&s->gpt), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->gpt), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
@@ -143,9 +138,8 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
         s->epit[i].ccm = IMX_CCM(&s->ccm);
 
-        object_property_set_bool(OBJECT(&s->epit[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->epit[i]), true, "realized", errp);
+        if (*errp) {
             return;
         }
 
@@ -167,9 +161,8 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
         };
 
         /* Initialize the I2C */
-        object_property_set_bool(OBJECT(&s->i2c[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->i2c[i]), true, "realized", errp);
+        if (*errp) {
             return;
         }
         /* Map I2C memory */
@@ -193,9 +186,8 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
         object_property_set_bool(OBJECT(&s->gpio[i]), false, "has-edge-sel",
                                  &error_abort);
-        object_property_set_bool(OBJECT(&s->gpio[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->gpio[i]), true, "realized", errp);
+        if (*errp) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0, gpio_table[i].addr);
@@ -207,9 +199,8 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
     /* On a real system, the first 16k is a `secure boot rom' */
     memory_region_init_rom(&s->secure_rom, NULL, "imx31.secure_rom",
-                           FSL_IMX31_SECURE_ROM_SIZE, &err);
-    if (err) {
-        error_propagate(errp, err);
+                           FSL_IMX31_SECURE_ROM_SIZE, errp);
+    if (*errp) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX31_SECURE_ROM_ADDR,
@@ -217,9 +208,8 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
     /* There is also a 16k ROM */
     memory_region_init_rom(&s->rom, NULL, "imx31.rom",
-                           FSL_IMX31_ROM_SIZE, &err);
-    if (err) {
-        error_propagate(errp, err);
+                           FSL_IMX31_ROM_SIZE, errp);
+    if (*errp) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX31_ROM_ADDR,
@@ -227,9 +217,8 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
     /* initialize internal RAM (16 KB) */
     memory_region_init_ram(&s->iram, NULL, "imx31.iram", FSL_IMX31_IRAM_SIZE,
-                           &err);
-    if (err) {
-        error_propagate(errp, err);
+                           errp);
+    if (*errp) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX31_IRAM_ADDR,
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 552145b24e..d2ac86dfda 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -97,10 +97,10 @@ static void fsl_imx6_init(Object *obj)
 
 static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     MachineState *ms = MACHINE(qdev_get_machine());
     FslIMX6State *s = FSL_IMX6(dev);
     uint16_t i;
-    Error *err = NULL;
     unsigned int smp_cpus = ms->smp.cpus;
 
     if (smp_cpus > FSL_IMX6_NUM_CPUS) {
@@ -123,9 +123,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                      "start-powered-off", &error_abort);
         }
 
-        object_property_set_bool(OBJECT(&s->cpu[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->cpu[i]), true, "realized", errp);
+        if (*errp) {
             return;
         }
     }
@@ -137,9 +136,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                             FSL_IMX6_MAX_IRQ + GIC_INTERNAL, "num-irq",
                             &error_abort);
 
-    object_property_set_bool(OBJECT(&s->a9mpcore), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->a9mpcore), true, "realized", errp);
+    if (*errp) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->a9mpcore), 0, FSL_IMX6_A9MPCORE_ADDR);
@@ -151,16 +149,14 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(DEVICE(&s->cpu[i]), ARM_CPU_FIQ));
     }
 
-    object_property_set_bool(OBJECT(&s->ccm), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->ccm), true, "realized", errp);
+    if (*errp) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccm), 0, FSL_IMX6_CCM_ADDR);
 
-    object_property_set_bool(OBJECT(&s->src), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->src), true, "realized", errp);
+    if (*errp) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->src), 0, FSL_IMX6_SRC_ADDR);
@@ -180,9 +176,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
         qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
 
-        object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", errp);
+        if (*errp) {
             return;
         }
 
@@ -194,9 +189,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
     s->gpt.ccm = IMX_CCM(&s->ccm);
 
-    object_property_set_bool(OBJECT(&s->gpt), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->gpt), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
@@ -217,9 +211,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
         s->epit[i].ccm = IMX_CCM(&s->ccm);
 
-        object_property_set_bool(OBJECT(&s->epit[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->epit[i]), true, "realized", errp);
+        if (*errp) {
             return;
         }
 
@@ -240,9 +233,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
             { FSL_IMX6_I2C3_ADDR, FSL_IMX6_I2C3_IRQ }
         };
 
-        object_property_set_bool(OBJECT(&s->i2c[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->i2c[i]), true, "realized", errp);
+        if (*errp) {
             return;
         }
 
@@ -300,9 +292,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                  &error_abort);
         object_property_set_bool(OBJECT(&s->gpio[i]), true, "has-upper-pin-irq",
                                  &error_abort);
-        object_property_set_bool(OBJECT(&s->gpio[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->gpio[i]), true, "realized", errp);
+        if (*errp) {
             return;
         }
 
@@ -329,12 +320,11 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
         /* UHS-I SDIO3.0 SDR104 1.8V ADMA */
         object_property_set_uint(OBJECT(&s->esdhc[i]), 3, "sd-spec-version",
-                                 &err);
+                                 errp);
         object_property_set_uint(OBJECT(&s->esdhc[i]), IMX6_ESDHC_CAPABILITIES,
-                                 "capareg", &err);
-        object_property_set_bool(OBJECT(&s->esdhc[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+                                 "capareg", errp);
+        object_property_set_bool(OBJECT(&s->esdhc[i]), true, "realized", errp);
+        if (*errp) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->esdhc[i]), 0, esdhc_table[i].addr);
@@ -357,9 +347,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         };
 
         /* Initialize the SPI */
-        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized", errp);
+        if (*errp) {
             return;
         }
 
@@ -370,9 +359,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
     }
 
     qdev_set_nic_properties(DEVICE(&s->eth), &nd_table[0]);
-    object_property_set_bool(OBJECT(&s->eth), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->eth), true, "realized", errp);
+    if (*errp) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->eth), 0, FSL_IMX6_ENET_ADDR);
@@ -385,9 +373,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
     /* ROM memory */
     memory_region_init_rom(&s->rom, NULL, "imx6.rom",
-                           FSL_IMX6_ROM_SIZE, &err);
-    if (err) {
-        error_propagate(errp, err);
+                           FSL_IMX6_ROM_SIZE, errp);
+    if (*errp) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX6_ROM_ADDR,
@@ -395,9 +382,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
     /* CAAM memory */
     memory_region_init_rom(&s->caam, NULL, "imx6.caam",
-                           FSL_IMX6_CAAM_MEM_SIZE, &err);
-    if (err) {
-        error_propagate(errp, err);
+                           FSL_IMX6_CAAM_MEM_SIZE, errp);
+    if (*errp) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX6_CAAM_MEM_ADDR,
@@ -405,9 +391,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
     /* OCRAM memory */
     memory_region_init_ram(&s->ocram, NULL, "imx6.ocram", FSL_IMX6_OCRAM_SIZE,
-                           &err);
-    if (err) {
-        error_propagate(errp, err);
+                           errp);
+    if (*errp) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX6_OCRAM_ADDR,
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 524970840d..5049a78fb9 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -284,14 +284,13 @@ static void integratorcm_init(Object *obj)
 
 static void integratorcm_realize(DeviceState *d, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     IntegratorCMState *s = INTEGRATOR_CM(d);
     SysBusDevice *dev = SYS_BUS_DEVICE(d);
-    Error *local_err = NULL;
 
     memory_region_init_ram(&s->flash, OBJECT(d), "integrator.flash", 0x100000,
-                           &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+                           errp);
+    if (*errp) {
         return;
     }
 
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 008fd9327a..82808c4b15 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -85,10 +85,10 @@ static void m2sxxx_soc_initfn(Object *obj)
 
 static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     MSF2State *s = MSF2_SOC(dev_soc);
     DeviceState *dev, *armv7m;
     SysBusDevice *busdev;
-    Error *err = NULL;
     int i;
 
     MemoryRegion *system_memory = get_system_memory();
@@ -120,9 +120,8 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memory()),
                                      "memory", &error_abort);
-    object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->armv7m), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
@@ -148,9 +147,8 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     dev = DEVICE(&s->timer);
     /* APB0 clock is the timer input clock */
     qdev_prop_set_uint32(dev, "clock-frequency", s->m3clk / s->apb0div);
-    object_property_set_bool(OBJECT(&s->timer), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->timer), true, "realized", errp);
+    if (*errp) {
         return;
     }
     busdev = SYS_BUS_DEVICE(dev);
@@ -163,9 +161,8 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     dev = DEVICE(&s->sysreg);
     qdev_prop_set_uint32(dev, "apb0divisor", s->apb0div);
     qdev_prop_set_uint32(dev, "apb1divisor", s->apb1div);
-    object_property_set_bool(OBJECT(&s->sysreg), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->sysreg), true, "realized", errp);
+    if (*errp) {
         return;
     }
     busdev = SYS_BUS_DEVICE(dev);
@@ -174,9 +171,8 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     for (i = 0; i < MSF2_NUM_SPIS; i++) {
         gchar *bus_name;
 
-        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized", &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized", errp);
+        if (*errp) {
             return;
         }
 
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 74029169d0..b7025d0830 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -54,9 +54,9 @@ static const MemoryRegionOps clock_ops = {
 
 static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     NRF51State *s = NRF51_SOC(dev_soc);
     MemoryRegion *mr;
-    Error *err = NULL;
     uint8_t i = 0;
     hwaddr base_addr = 0;
 
@@ -66,31 +66,27 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
     }
 
     object_property_set_link(OBJECT(&s->cpu), OBJECT(&s->container), "memory",
-            &err);
-    if (err) {
-        error_propagate(errp, err);
+            errp);
+    if (*errp) {
         return;
     }
-    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->cpu), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
     memory_region_add_subregion_overlap(&s->container, 0, s->board_memory, -1);
 
     memory_region_init_ram(&s->sram, OBJECT(s), "nrf51.sram", s->sram_size,
-                           &err);
-    if (err) {
-        error_propagate(errp, err);
+                           errp);
+    if (*errp) {
         return;
     }
     memory_region_add_subregion(&s->container, NRF51_SRAM_BASE, &s->sram);
 
     /* UART */
-    object_property_set_bool(OBJECT(&s->uart), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->uart), true, "realized", errp);
+    if (*errp) {
         return;
     }
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart), 0);
@@ -100,9 +96,8 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
                        BASE_TO_IRQ(NRF51_UART_BASE)));
 
     /* RNG */
-    object_property_set_bool(OBJECT(&s->rng), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->rng), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
@@ -114,15 +109,13 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
 
     /* UICR, FICR, NVMC, FLASH */
     object_property_set_uint(OBJECT(&s->nvm), s->flash_size, "flash-size",
-                             &err);
-    if (err) {
-        error_propagate(errp, err);
+                             errp);
+    if (*errp) {
         return;
     }
 
-    object_property_set_bool(OBJECT(&s->nvm), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->nvm), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
@@ -136,9 +129,8 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion_overlap(&s->container, NRF51_FLASH_BASE, mr, 0);
 
     /* GPIO */
-    object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->gpio), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
@@ -150,9 +142,8 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
 
     /* TIMER */
     for (i = 0; i < NRF51_NUM_TIMERS; i++) {
-        object_property_set_bool(OBJECT(&s->timer[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->timer[i]), true, "realized", errp);
+        if (*errp) {
             return;
         }
 
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index f5a5c2d80c..f475ed0661 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -82,10 +82,10 @@ static void stm32f205_soc_initfn(Object *obj)
 
 static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     STM32F205State *s = STM32F205_SOC(dev_soc);
     DeviceState *dev, *armv7m;
     SysBusDevice *busdev;
-    Error *err = NULL;
     int i;
 
     MemoryRegion *system_memory = get_system_memory();
@@ -114,17 +114,15 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memory()),
                                      "memory", &error_abort);
-    object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->armv7m), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
     /* System configuration controller */
     dev = DEVICE(&s->syscfg);
-    object_property_set_bool(OBJECT(&s->syscfg), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->syscfg), true, "realized", errp);
+    if (*errp) {
         return;
     }
     busdev = SYS_BUS_DEVICE(dev);
@@ -135,9 +133,8 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     for (i = 0; i < STM_NUM_USARTS; i++) {
         dev = DEVICE(&(s->usart[i]));
         qdev_prop_set_chr(dev, "chardev", serial_hd(i));
-        object_property_set_bool(OBJECT(&s->usart[i]), true, "realized", &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->usart[i]), true, "realized", errp);
+        if (*errp) {
             return;
         }
         busdev = SYS_BUS_DEVICE(dev);
@@ -149,9 +146,8 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     for (i = 0; i < STM_NUM_TIMERS; i++) {
         dev = DEVICE(&(s->timer[i]));
         qdev_prop_set_uint64(dev, "clock-frequency", 1000000000);
-        object_property_set_bool(OBJECT(&s->timer[i]), true, "realized", &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->timer[i]), true, "realized", errp);
+        if (*errp) {
             return;
         }
         busdev = SYS_BUS_DEVICE(dev);
@@ -161,10 +157,9 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
 
     /* ADC 1 to 3 */
     object_property_set_int(OBJECT(s->adc_irqs), STM_NUM_ADCS,
-                            "num-lines", &err);
-    object_property_set_bool(OBJECT(s->adc_irqs), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+                            "num-lines", errp);
+    object_property_set_bool(OBJECT(s->adc_irqs), true, "realized", errp);
+    if (*errp) {
         return;
     }
     qdev_connect_gpio_out(DEVICE(s->adc_irqs), 0,
@@ -172,9 +167,8 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
 
     for (i = 0; i < STM_NUM_ADCS; i++) {
         dev = DEVICE(&(s->adc[i]));
-        object_property_set_bool(OBJECT(&s->adc[i]), true, "realized", &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->adc[i]), true, "realized", errp);
+        if (*errp) {
             return;
         }
         busdev = SYS_BUS_DEVICE(dev);
@@ -186,9 +180,8 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     /* SPI 1 and 2 */
     for (i = 0; i < STM_NUM_SPIS; i++) {
         dev = DEVICE(&(s->spi[i]));
-        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized", &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized", errp);
+        if (*errp) {
             return;
         }
         busdev = SYS_BUS_DEVICE(dev);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d74538b021..ce2e57fd59 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1793,6 +1793,7 @@ static char *virt_get_gic_version(Object *obj, Error **errp)
 
 static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     VirtMachineState *vms = VIRT_MACHINE(obj);
 
     if (!strcmp(value, "3")) {
@@ -1825,6 +1826,7 @@ static char *virt_get_iommu(Object *obj, Error **errp)
 
 static void virt_set_iommu(Object *obj, const char *value, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     VirtMachineState *vms = VIRT_MACHINE(obj);
 
     if (!strcmp(value, "smmuv3")) {
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 462493c467..7f30e56dc7 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -232,13 +232,12 @@ static void fdt_add_gem_nodes(VersalVirt *s)
 
 static void fdt_nop_memory_nodes(void *fdt, Error **errp)
 {
-    Error *err = NULL;
+    ERRP_AUTO_PROPAGATE();
     char **node_path;
     int n = 0;
 
-    node_path = qemu_fdt_node_unit_path(fdt, "memory", &err);
-    if (err) {
-        error_propagate(errp, err);
+    node_path = qemu_fdt_node_unit_path(fdt, "memory", errp);
+    if (*errp) {
         return;
     }
     while (node_path[n]) {
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index fb03c60ebb..3fe46b265b 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -176,7 +176,7 @@ static inline int arm_gic_ppi_index(int cpu_nr, int ppi_index)
 static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
                                    const char *boot_cpu, Error **errp)
 {
-    Error *err = NULL;
+    ERRP_AUTO_PROPAGATE();
     int i;
     int num_rpus = MIN(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS,
                        XLNX_ZYNQMP_NUM_RPU_CPUS);
@@ -212,9 +212,8 @@ static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
         object_property_set_bool(OBJECT(&s->rpu_cpu[i]), true, "reset-hivecs",
                                  &error_abort);
         object_property_set_bool(OBJECT(&s->rpu_cpu[i]), true, "realized",
-                                 &err);
-        if (err) {
-            error_propagate(errp, err);
+                                 errp);
+        if (*errp) {
             return;
         }
     }
@@ -294,6 +293,7 @@ static void xlnx_zynqmp_init(Object *obj)
 
 static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     MachineState *ms = MACHINE(qdev_get_machine());
     XlnxZynqMPState *s = XLNX_ZYNQMP(dev);
     MemoryRegion *system_memory = get_system_memory();
@@ -303,7 +303,6 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     const char *boot_cpu = s->boot_cpu ? s->boot_cpu : "apu-cpu[0]";
     ram_addr_t ddr_low_size, ddr_high_size;
     qemu_irq gic_spi[GIC_NUM_SPI_INTR];
-    Error *err = NULL;
 
     ram_size = memory_region_size(s->ddr_ram);
 
@@ -384,16 +383,14 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         object_property_set_int(OBJECT(&s->apu_cpu[i]), num_apus,
                                 "core-count", &error_abort);
         object_property_set_bool(OBJECT(&s->apu_cpu[i]), true, "realized",
-                                 &err);
-        if (err) {
-            error_propagate(errp, err);
+                                 errp);
+        if (*errp) {
             return;
         }
     }
 
-    object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->gic), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
@@ -461,9 +458,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
                     "RPUs just use -smp 6.");
     }
 
-    xlnx_zynqmp_create_rpu(ms, s, boot_cpu, &err);
-    if (err) {
-        error_propagate(errp, err);
+    xlnx_zynqmp_create_rpu(ms, s, boot_cpu, errp);
+    if (*errp) {
         return;
     }
 
@@ -487,9 +483,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
                                 &error_abort);
         object_property_set_int(OBJECT(&s->gem[i]), 2, "num-priority-queues",
                                 &error_abort);
-        object_property_set_bool(OBJECT(&s->gem[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->gem[i]), true, "realized", errp);
+        if (*errp) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem[i]), 0, gem_addr[i]);
@@ -499,9 +494,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_UARTS; i++) {
         qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
-        object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", errp);
+        if (*errp) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, uart_addr[i]);
@@ -511,9 +505,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
 
     object_property_set_int(OBJECT(&s->sata), SATA_NUM_PORTS, "num-ports",
                             &error_abort);
-    object_property_set_bool(OBJECT(&s->sata), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->sata), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
@@ -530,12 +523,11 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
          * - SDIO Specification Version 3.0
          * - eMMC Specification Version 4.51
          */
-        object_property_set_uint(sdhci, 3, "sd-spec-version", &err);
-        object_property_set_uint(sdhci, SDHCI_CAPABILITIES, "capareg", &err);
-        object_property_set_uint(sdhci, UHS_I, "uhs", &err);
-        object_property_set_bool(sdhci, true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_uint(sdhci, 3, "sd-spec-version", errp);
+        object_property_set_uint(sdhci, SDHCI_CAPABILITIES, "capareg", errp);
+        object_property_set_uint(sdhci, UHS_I, "uhs", errp);
+        object_property_set_bool(sdhci, true, "realized", errp);
+        if (*errp) {
             return;
         }
         sysbus_mmio_map(sbd, 0, sdhci_addr[i]);
@@ -550,7 +542,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < XLNX_ZYNQMP_NUM_SPIS; i++) {
         gchar *bus_name;
 
-        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized", &err);
+        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized", errp);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0, spi_addr[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
@@ -564,7 +556,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         g_free(bus_name);
     }
 
-    object_property_set_bool(OBJECT(&s->qspi), true, "realized", &err);
+    object_property_set_bool(OBJECT(&s->qspi), true, "realized", errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->qspi), 0, QSPI_ADDR);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->qspi), 1, LQSPI_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->qspi), 0, gic_spi[QSPI_IRQ]);
@@ -583,17 +575,15 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         g_free(target_bus);
     }
 
-    object_property_set_bool(OBJECT(&s->dp), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->dp), true, "realized", errp);
+    if (*errp) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->dp), 0, DP_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->dp), 0, gic_spi[DP_IRQ]);
 
-    object_property_set_bool(OBJECT(&s->dpdma), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->dpdma), true, "realized", errp);
+    if (*errp) {
         return;
     }
     object_property_set_link(OBJECT(&s->dp), OBJECT(&s->dpdma), "dpdma",
@@ -601,27 +591,24 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->dpdma), 0, DPDMA_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->dpdma), 0, gic_spi[DPDMA_IRQ]);
 
-    object_property_set_bool(OBJECT(&s->ipi), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->ipi), true, "realized", errp);
+    if (*errp) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ipi), 0, IPI_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->ipi), 0, gic_spi[IPI_IRQ]);
 
-    object_property_set_bool(OBJECT(&s->rtc), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->rtc), true, "realized", errp);
+    if (*errp) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, RTC_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0, gic_spi[RTC_IRQ]);
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_GDMA_CH; i++) {
-        object_property_set_uint(OBJECT(&s->gdma[i]), 128, "bus-width", &err);
-        object_property_set_bool(OBJECT(&s->gdma[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_uint(OBJECT(&s->gdma[i]), 128, "bus-width", errp);
+        object_property_set_bool(OBJECT(&s->gdma[i]), true, "realized", errp);
+        if (*errp) {
             return;
         }
 
@@ -631,9 +618,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     }
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_ADMA_CH; i++) {
-        object_property_set_bool(OBJECT(&s->adma[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->adma[i]), true, "realized", errp);
+        if (*errp) {
             return;
         }
 
diff --git a/hw/cpu/realview_mpcore.c b/hw/cpu/realview_mpcore.c
index ae2c9913f6..c48a0140c6 100644
--- a/hw/cpu/realview_mpcore.c
+++ b/hw/cpu/realview_mpcore.c
@@ -60,19 +60,18 @@ static void mpcore_rirq_set_irq(void *opaque, int irq, int level)
 
 static void realview_mpcore_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     mpcore_rirq_state *s = REALVIEW_MPCORE_RIRQ(dev);
     DeviceState *priv = DEVICE(&s->priv);
     DeviceState *gic;
     SysBusDevice *gicbusdev;
-    Error *err = NULL;
     int n;
     int i;
 
     qdev_prop_set_uint32(priv, "num-cpu", s->num_cpu);
-    object_property_set_bool(OBJECT(&s->priv), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->priv), true, "realized", errp);
+    if (*errp) {
         return;
     }
     sysbus_pass_irq(sbd, SYS_BUS_DEVICE(&s->priv));
@@ -81,9 +80,8 @@ static void realview_mpcore_realize(DeviceState *dev, Error **errp)
     }
     /* ??? IRQ routing is hardcoded to "normal" mode.  */
     for (n = 0; n < 4; n++) {
-        object_property_set_bool(OBJECT(&s->gic[n]), true, "realized", &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->gic[n]), true, "realized", errp);
+        if (*errp) {
             return;
         }
         gic = DEVICE(&s->gic[n]);
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index 8f856878cd..fa2bca37c4 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -401,8 +401,8 @@ static void bcm2835_fb_reset(DeviceState *dev)
 
 static void bcm2835_fb_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     BCM2835FBState *s = BCM2835_FB(dev);
-    Error *err = NULL;
     Object *obj;
 
     if (s->vcram_base == 0) {
@@ -410,10 +410,10 @@ static void bcm2835_fb_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    obj = object_property_get_link(OBJECT(dev), "dma-mr", &err);
+    obj = object_property_get_link(OBJECT(dev), "dma-mr", errp);
     if (obj == NULL) {
         error_setg(errp, "%s: required dma-mr link not found: %s",
-                   __func__, error_get_pretty(err));
+                   __func__, error_get_pretty(*errp));
         return;
     }
 
diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
index 192bd377a0..a455f4dc57 100644
--- a/hw/dma/bcm2835_dma.c
+++ b/hw/dma/bcm2835_dma.c
@@ -371,14 +371,14 @@ static void bcm2835_dma_reset(DeviceState *dev)
 
 static void bcm2835_dma_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     BCM2835DMAState *s = BCM2835_DMA(dev);
-    Error *err = NULL;
     Object *obj;
 
-    obj = object_property_get_link(OBJECT(dev), "dma-mr", &err);
+    obj = object_property_get_link(OBJECT(dev), "dma-mr", errp);
     if (obj == NULL) {
         error_setg(errp, "%s: required dma-mr link not found: %s",
-                   __func__, error_get_pretty(err));
+                   __func__, error_get_pretty(*errp));
         return;
     }
 
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index a254275b64..872ef84635 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -520,29 +520,29 @@ static const MemoryRegionOps axidma_ops = {
 
 static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     XilinxAXIDMA *s = XILINX_AXI_DMA(dev);
     XilinxAXIDMAStreamSlave *ds = XILINX_AXI_DMA_DATA_STREAM(&s->rx_data_dev);
     XilinxAXIDMAStreamSlave *cs = XILINX_AXI_DMA_CONTROL_STREAM(
                                                             &s->rx_control_dev);
-    Error *local_err = NULL;
 
     object_property_add_link(OBJECT(ds), "dma", TYPE_XILINX_AXI_DMA,
                              (Object **)&ds->dma,
                              object_property_allow_set_link,
                              OBJ_PROP_LINK_STRONG,
-                             &local_err);
+                             errp);
     object_property_add_link(OBJECT(cs), "dma", TYPE_XILINX_AXI_DMA,
                              (Object **)&cs->dma,
                              object_property_allow_set_link,
                              OBJ_PROP_LINK_STRONG,
-                             &local_err);
-    if (local_err) {
-        goto xilinx_axidma_realize_fail;
+                             errp);
+    if (*errp) {
+        return;
     }
-    object_property_set_link(OBJECT(ds), OBJECT(s), "dma", &local_err);
-    object_property_set_link(OBJECT(cs), OBJECT(s), "dma", &local_err);
-    if (local_err) {
-        goto xilinx_axidma_realize_fail;
+    object_property_set_link(OBJECT(ds), OBJECT(s), "dma", errp);
+    object_property_set_link(OBJECT(cs), OBJECT(s), "dma", errp);
+    if (*errp) {
+        return;
     }
 
     int i;
@@ -555,10 +555,6 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
         st->ptimer = ptimer_init(st->bh, PTIMER_POLICY_DEFAULT);
         ptimer_set_freq(st->ptimer, s->freqhz);
     }
-    return;
-
-xilinx_axidma_realize_fail:
-    error_propagate(errp, local_err);
 }
 
 static void xilinx_axidma_init(Object *obj)
diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index 25fbfec3b8..7683b16ea9 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -679,16 +679,15 @@ static void aspeed_gpio_get_pin(Object *obj, Visitor *v, const char *name,
 static void aspeed_gpio_set_pin(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
-    Error *local_err = NULL;
+    ERRP_AUTO_PROPAGATE();
     bool level;
     int pin = 0xfff;
     char group[3];
     AspeedGPIOState *s = ASPEED_GPIO(obj);
     int set_idx, group_idx = 0;
 
-    visit_type_bool(v, name, &level, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_bool(v, name, &level, errp);
+    if (*errp) {
         return;
     }
     if (sscanf(name, "gpio%2[A-Z]%1d", group, &pin) != 2) {
diff --git a/hw/gpio/bcm2835_gpio.c b/hw/gpio/bcm2835_gpio.c
index 91ce3d10cc..0d94f45635 100644
--- a/hw/gpio/bcm2835_gpio.c
+++ b/hw/gpio/bcm2835_gpio.c
@@ -310,22 +310,22 @@ static void bcm2835_gpio_init(Object *obj)
 
 static void bcm2835_gpio_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     BCM2835GpioState *s = BCM2835_GPIO(dev);
     Object *obj;
-    Error *err = NULL;
 
-    obj = object_property_get_link(OBJECT(dev), "sdbus-sdhci", &err);
+    obj = object_property_get_link(OBJECT(dev), "sdbus-sdhci", errp);
     if (obj == NULL) {
         error_setg(errp, "%s: required sdhci link not found: %s",
-                __func__, error_get_pretty(err));
+                __func__, error_get_pretty(*errp));
         return;
     }
     s->sdbus_sdhci = SD_BUS(obj);
 
-    obj = object_property_get_link(OBJECT(dev), "sdbus-sdhost", &err);
+    obj = object_property_get_link(OBJECT(dev), "sdbus-sdhost", errp);
     if (obj == NULL) {
         error_setg(errp, "%s: required sdhost link not found: %s",
-                __func__, error_get_pretty(err));
+                __func__, error_get_pretty(*errp));
         return;
     }
     s->sdbus_sdhost = SD_BUS(obj);
diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 1d7da7baa2..5d100b03c7 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -2036,16 +2036,15 @@ static const MemoryRegionOps gic_viface_ops = {
 
 static void arm_gic_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     /* Device instance realize function for the GIC sysbus device */
     int i;
     GICState *s = ARM_GIC(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     ARMGICClass *agc = ARM_GIC_GET_CLASS(s);
-    Error *local_err = NULL;
 
-    agc->parent_realize(dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    agc->parent_realize(dev, errp);
+    if (*errp) {
         return;
     }
 
diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
index b56fda144f..25d87e489e 100644
--- a/hw/intc/arm_gic_kvm.c
+++ b/hw/intc/arm_gic_kvm.c
@@ -493,15 +493,14 @@ static void kvm_arm_gic_reset(DeviceState *dev)
 
 static void kvm_arm_gic_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     int i;
     GICState *s = KVM_ARM_GIC(dev);
     KVMARMGICClass *kgc = KVM_ARM_GIC_GET_CLASS(s);
-    Error *local_err = NULL;
     int ret;
 
-    kgc->parent_realize(dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    kgc->parent_realize(dev, errp);
+    if (*errp) {
         return;
     }
 
@@ -520,9 +519,8 @@ static void kvm_arm_gic_realize(DeviceState *dev, Error **errp)
     if (!kvm_arm_gic_can_save_restore(s)) {
         error_setg(&s->migration_blocker, "This operating system kernel does "
                                           "not support vGICv2 migration");
-        migrate_add_blocker(s->migration_blocker, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        migrate_add_blocker(s->migration_blocker, errp);
+        if (*errp) {
             error_free(s->migration_blocker);
             return;
         }
diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
index 66eaa97198..ad8e7d92c0 100644
--- a/hw/intc/arm_gicv3.c
+++ b/hw/intc/arm_gicv3.c
@@ -363,14 +363,13 @@ static const MemoryRegionOps gic_ops[] = {
 
 static void arm_gic_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     /* Device instance realize function for the GIC sysbus device */
     GICv3State *s = ARM_GICV3(dev);
     ARMGICv3Class *agc = ARM_GICV3_GET_CLASS(s);
-    Error *local_err = NULL;
 
-    agc->parent_realize(dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    agc->parent_realize(dev, errp);
+    if (*errp) {
         return;
     }
 
@@ -380,9 +379,8 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    gicv3_init_irqs_and_mmio(s, gicv3_set_irq, gic_ops, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    gicv3_init_irqs_and_mmio(s, gicv3_set_irq, gic_ops, errp);
+    if (*errp) {
         return;
     }
 
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index d66f2431ee..e619bad96e 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -90,8 +90,8 @@ static void vm_change_state_handler(void *opaque, int running,
 
 static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     GICv3ITSState *s = ARM_GICV3_ITS_COMMON(dev);
-    Error *local_err = NULL;
 
     s->dev_fd = kvm_create_device(kvm_state, KVM_DEV_TYPE_ARM_VGIC_ITS, false);
     if (s->dev_fd < 0) {
@@ -113,9 +113,8 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
         GITS_CTLR)) {
         error_setg(&s->migration_blocker, "This operating system kernel "
                    "does not support vITS migration");
-        migrate_add_blocker(s->migration_blocker, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        migrate_add_blocker(s->migration_blocker, errp);
+        if (*errp) {
             error_free(s->migration_blocker);
             return;
         }
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 9c7f4ab871..9b9a0931f0 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -766,17 +766,16 @@ static void vm_change_state_handler(void *opaque, int running,
 
 static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     GICv3State *s = KVM_ARM_GICV3(dev);
     KVMARMGICv3Class *kgc = KVM_ARM_GICV3_GET_CLASS(s);
     bool multiple_redist_region_allowed;
-    Error *local_err = NULL;
     int i;
 
     DPRINTF("kvm_arm_gicv3_realize\n");
 
-    kgc->parent_realize(dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    kgc->parent_realize(dev, errp);
+    if (*errp) {
         return;
     }
 
@@ -786,9 +785,8 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    gicv3_init_irqs_and_mmio(s, kvm_arm_gicv3_set_irq, NULL, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    gicv3_init_irqs_and_mmio(s, kvm_arm_gicv3_set_irq, NULL, errp);
+    if (*errp) {
         return;
     }
 
@@ -863,9 +861,8 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
                                GICD_CTLR)) {
         error_setg(&s->migration_blocker, "This operating system kernel does "
                                           "not support vGICv3 migration");
-        migrate_add_blocker(s->migration_blocker, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        migrate_add_blocker(s->migration_blocker, errp);
+        if (*errp) {
             error_free(s->migration_blocker);
             return;
         }
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 8e93e51e81..7e111e34a7 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2608,8 +2608,8 @@ static void nvic_systick_trigger(void *opaque, int n, int level)
 
 static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     NVICState *s = NVIC(dev);
-    Error *err = NULL;
     int regionlen;
 
     /* The armv7m container object will have set our CPU pointer */
@@ -2631,9 +2631,8 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
     s->num_prio_bits = arm_feature(&s->cpu->env, ARM_FEATURE_V7) ? 8 : 2;
 
     object_property_set_bool(OBJECT(&s->systick[M_REG_NS]), true,
-                             "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+                             "realized", errp);
+    if (*errp) {
         return;
     }
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->systick[M_REG_NS]), 0,
@@ -2650,9 +2649,8 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
                               sizeof(s->systick[M_REG_S]), TYPE_SYSTICK);
 
         object_property_set_bool(OBJECT(&s->systick[M_REG_S]), true,
-                                 "realized", &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+                                 "realized", errp);
+        if (*errp) {
             return;
         }
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->systick[M_REG_S]), 0,
diff --git a/hw/intc/realview_gic.c b/hw/intc/realview_gic.c
index 73fe8cd815..1335a41f80 100644
--- a/hw/intc/realview_gic.c
+++ b/hw/intc/realview_gic.c
@@ -23,10 +23,10 @@ static void realview_gic_set_irq(void *opaque, int irq, int level)
 
 static void realview_gic_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     RealViewGICState *s = REALVIEW_GIC(dev);
     SysBusDevice *busdev;
-    Error *err = NULL;
     /* The GICs on the RealView boards have a fixed nonconfigurable
      * number of interrupt lines, so we don't need to expose this as
      * a qdev property.
@@ -34,9 +34,8 @@ static void realview_gic_realize(DeviceState *dev, Error **errp)
     int numirq = 96;
 
     qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", numirq);
-    object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->gic), true, "realized", errp);
+    if (*errp) {
         return;
     }
     busdev = SYS_BUS_DEVICE(&s->gic);
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 028f31894d..5cc03eba45 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -78,8 +78,8 @@ static void xlnx_zynqmp_pmu_soc_init(Object *obj)
 
 static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     XlnxZynqMPPMUSoCState *s = XLNX_ZYNQMP_PMU_SOC(dev);
-    Error *err = NULL;
 
     object_property_set_uint(OBJECT(&s->cpu), XLNX_ZYNQMP_PMU_ROM_ADDR,
                              "base-vectors", &error_abort);
@@ -99,9 +99,8 @@ static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
     object_property_set_str(OBJECT(&s->cpu), "8.40.b", "version",
                             &error_abort);
     object_property_set_uint(OBJECT(&s->cpu), 0, "pvr", &error_abort);
-    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->cpu), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
@@ -111,9 +110,8 @@ static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
                              &error_abort);
     object_property_set_uint(OBJECT(&s->intc), 0xffff, "intc-positive",
                              &error_abort);
-    object_property_set_bool(OBJECT(&s->intc), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->intc), true, "realized", errp);
+    if (*errp) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->intc), 0, XLNX_ZYNQMP_PMU_INTC_ADDR);
diff --git a/hw/misc/bcm2835_mbox.c b/hw/misc/bcm2835_mbox.c
index 79bad11631..d20343b846 100644
--- a/hw/misc/bcm2835_mbox.c
+++ b/hw/misc/bcm2835_mbox.c
@@ -298,14 +298,14 @@ static void bcm2835_mbox_reset(DeviceState *dev)
 
 static void bcm2835_mbox_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     BCM2835MboxState *s = BCM2835_MBOX(dev);
     Object *obj;
-    Error *err = NULL;
 
-    obj = object_property_get_link(OBJECT(dev), "mbox-mr", &err);
+    obj = object_property_get_link(OBJECT(dev), "mbox-mr", errp);
     if (obj == NULL) {
         error_setg(errp, "%s: required mbox-mr link not found: %s",
-                   __func__, error_get_pretty(err));
+                   __func__, error_get_pretty(*errp));
         return;
     }
 
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index d86d510572..647c630eb9 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -382,23 +382,23 @@ static void bcm2835_property_reset(DeviceState *dev)
 
 static void bcm2835_property_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     BCM2835PropertyState *s = BCM2835_PROPERTY(dev);
     Object *obj;
-    Error *err = NULL;
 
-    obj = object_property_get_link(OBJECT(dev), "fb", &err);
+    obj = object_property_get_link(OBJECT(dev), "fb", errp);
     if (obj == NULL) {
         error_setg(errp, "%s: required fb link not found: %s",
-                   __func__, error_get_pretty(err));
+                   __func__, error_get_pretty(*errp));
         return;
     }
 
     s->fbdev = BCM2835_FB(obj);
 
-    obj = object_property_get_link(OBJECT(dev), "dma-mr", &err);
+    obj = object_property_get_link(OBJECT(dev), "dma-mr", errp);
     if (obj == NULL) {
         error_setg(errp, "%s: required dma-mr link not found: %s",
-                   __func__, error_get_pretty(err));
+                   __func__, error_get_pretty(*errp));
         return;
     }
 
diff --git a/hw/misc/msf2-sysreg.c b/hw/misc/msf2-sysreg.c
index ddc5a30c80..343351480d 100644
--- a/hw/misc/msf2-sysreg.c
+++ b/hw/misc/msf2-sysreg.c
@@ -127,6 +127,7 @@ static Property msf2_sysreg_properties[] = {
 
 static void msf2_sysreg_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     MSF2SysregState *s = MSF2_SYSREG(dev);
 
     if ((s->apb0div > 32 || !is_power_of_2(s->apb0div))
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 2c8c065401..7fd7fd06a8 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -947,29 +947,29 @@ static NetClientInfo net_xilinx_enet_info = {
 
 static void xilinx_enet_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     XilinxAXIEnet *s = XILINX_AXI_ENET(dev);
     XilinxAXIEnetStreamSlave *ds = XILINX_AXI_ENET_DATA_STREAM(&s->rx_data_dev);
     XilinxAXIEnetStreamSlave *cs = XILINX_AXI_ENET_CONTROL_STREAM(
                                                             &s->rx_control_dev);
-    Error *local_err = NULL;
 
     object_property_add_link(OBJECT(ds), "enet", "xlnx.axi-ethernet",
                              (Object **) &ds->enet,
                              object_property_allow_set_link,
                              OBJ_PROP_LINK_STRONG,
-                             &local_err);
+                             errp);
     object_property_add_link(OBJECT(cs), "enet", "xlnx.axi-ethernet",
                              (Object **) &cs->enet,
                              object_property_allow_set_link,
                              OBJ_PROP_LINK_STRONG,
-                             &local_err);
-    if (local_err) {
-        goto xilinx_enet_realize_fail;
+                             errp);
+    if (*errp) {
+        return;
     }
-    object_property_set_link(OBJECT(ds), OBJECT(s), "enet", &local_err);
-    object_property_set_link(OBJECT(cs), OBJECT(s), "enet", &local_err);
-    if (local_err) {
-        goto xilinx_enet_realize_fail;
+    object_property_set_link(OBJECT(ds), OBJECT(s), "enet", errp);
+    object_property_set_link(OBJECT(cs), OBJECT(s), "enet", errp);
+    if (*errp) {
+        return;
     }
 
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
@@ -983,10 +983,6 @@ static void xilinx_enet_realize(DeviceState *dev, Error **errp)
     s->TEMAC.parent = s;
 
     s->rxmem = g_malloc(s->c_rxmem);
-    return;
-
-xilinx_enet_realize_fail:
-    error_propagate(errp, local_err);
 }
 
 static void xilinx_enet_init(Object *obj)
diff --git a/hw/nvram/nrf51_nvm.c b/hw/nvram/nrf51_nvm.c
index 4d678f994e..be72841a5c 100644
--- a/hw/nvram/nrf51_nvm.c
+++ b/hw/nvram/nrf51_nvm.c
@@ -326,13 +326,12 @@ static void nrf51_nvm_init(Object *obj)
 
 static void nrf51_nvm_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     NRF51NVMState *s = NRF51_NVM(dev);
-    Error *err = NULL;
 
     memory_region_init_rom_device(&s->flash, OBJECT(dev), &flash_ops, s,
-        "nrf51_soc.flash", s->flash_size, &err);
-    if (err) {
-        error_propagate(errp, err);
+        "nrf51_soc.flash", s->flash_size, errp);
+    if (*errp) {
         return;
     }
 
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 2bda826882..27bd62fb29 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -482,15 +482,15 @@ static void aspeed_init_one_timer(AspeedTimerCtrlState *s, uint8_t id)
 
 static void aspeed_timer_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     int i;
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     AspeedTimerCtrlState *s = ASPEED_TIMER(dev);
     Object *obj;
-    Error *err = NULL;
 
-    obj = object_property_get_link(OBJECT(dev), "scu", &err);
+    obj = object_property_get_link(OBJECT(dev), "scu", errp);
     if (!obj) {
-        error_propagate_prepend(errp, err, "required link 'scu' not found: ");
+        error_prepend(errp, "required link 'scu' not found: ");
         return;
     }
     s->scu = ASPEED_SCU(obj);
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 9b93213417..80c797b0c5 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -243,14 +243,13 @@ static void aspeed_wdt_timer_expired(void *dev)
 
 static void aspeed_wdt_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     AspeedWDTState *s = ASPEED_WDT(dev);
-    Error *err = NULL;
     Object *obj;
 
-    obj = object_property_get_link(OBJECT(dev), "scu", &err);
+    obj = object_property_get_link(OBJECT(dev), "scu", errp);
     if (!obj) {
-        error_propagate(errp, err);
         error_prepend(errp, "required link 'scu' not found: ");
         return;
     }
-- 
2.21.0


