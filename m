Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8C9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:19:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E869A20734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aFNh/sH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E869A20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiu4k-0006CO-0n
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 02:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitMd-0005ea-7S
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:33:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31405
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitMK-0003wY-QS
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591767185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZlAxa4D7C9bnb8+T/OwTv9d+8rMtpteFFeU2ZRh1HDQ=;
 b=aFNh/sH7nCdcfY1jSpB9k2OzHEtjZux8XUVTWGCtMfWJ/S+hexAcWrl9hFRvKz+V9ML4pO
 vwkK5cBP1Wsr1u23unNE0suqCi98eGFW2NNFDwfvFHjQedWHq90W0hOHV1FiIaCR9G0Snc
 H8onCdJ9n3JHWQS7+wb/xnTtPC3v+Ds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-3SmtwaEHMDSakeSurY8EWA-1; Wed, 10 Jun 2020 01:32:59 -0400
X-MC-Unique: 3SmtwaEHMDSakeSurY8EWA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BC6A107ACF7;
 Wed, 10 Jun 2020 05:32:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F6E161983;
 Wed, 10 Jun 2020 05:32:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E58F91138486; Wed, 10 Jun 2020 07:32:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 48/58] sysbus: Convert qdev_set_parent_bus() use
 with Coccinelle, part 2
Date: Wed, 10 Jun 2020 07:32:37 +0200
Message-Id: <20200610053247.1583243-49-armbru@redhat.com>
In-Reply-To: <20200610053247.1583243-1-armbru@redhat.com>
References: <20200610053247.1583243-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the same transformation as in the previous commit, except
sysbus_init_child_obj() and realize are too separated for the commit's
Coccinelle script to handle, typically because sysbus_init_child_obj()
is in a device's instance_init() method, and the matching realize is
in its realize() method.

Perhaps a Coccinelle wizard could make it transform that pattern, but
I'm just a bungler, and the best I can do is transforming the two
separate parts separately:

    @@
    expression errp;
    expression child;
    symbol true;
    @@
    -    object_property_set_bool(OBJECT(child), true, "realized", errp);
    +    sysbus_realize(SYS_BUS_DEVICE(child), errp);
    // only correct with a matching sysbus_init_child_obj() transformation!

    @@
    expression errp;
    expression child;
    symbol true;
    @@
    -    object_property_set_bool(child, true, "realized", errp);
    +    sysbus_realize(SYS_BUS_DEVICE(child), errp);
    // only correct with a matching sysbus_init_child_obj() transformation!

    @@
    expression child;
    @@
    -    qdev_init_nofail(DEVICE(child));
    +    sysbus_realize(SYS_BUS_DEVICE(child), &error_fatal);
    // only correct with a matching sysbus_init_child_obj() transformation!

    @@
    expression child;
    expression dev;
    @@
         dev = DEVICE(child);
         ...
    -    qdev_init_nofail(dev);
    +    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
    // only correct with a matching sysbus_init_child_obj() transformation!

    @@
    expression child;
    identifier dev;
    @@
         DeviceState *dev = DEVICE(child);
         ...
    -    qdev_init_nofail(dev);
    +    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
    // only correct with a matching sysbus_init_child_obj() transformation!

    @@
    expression parent, name, size, type;
    expression child;
    symbol true;
    @@
    -    sysbus_init_child_obj(parent, name, child, size, type);
    +    sysbus_init_child_XXX(parent, name, child, size, type);

    @@
    expression parent, propname, type;
    expression child;
    @@
    -    sysbus_init_child_XXX(parent, propname, child, sizeof(*child), type)
    +    object_initialize_child(parent, propname, child, type)

    @@
    expression parent, propname, type;
    expression child;
    @@
    -    sysbus_init_child_XXX(parent, propname, &child, sizeof(child), type)
    +    object_initialize_child(parent, propname, &child, type)

This script is *unsound*: we need to manually verify init and realize
conversions are properly paired.

This commit has only the pairs where object_initialize_child()'s
@child and sysbus_realize()'s @dev argument text match exactly within
the same source file.

Note that Coccinelle chokes on ARMSSE typedef vs. macro in
hw/arm/armsse.c.  Worked around by temporarily renaming the macro for
the spatch run.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/arm/allwinner-a10.c          | 43 ++++++---------
 hw/arm/allwinner-h3.c           | 50 +++++++----------
 hw/arm/armsse.c                 | 96 ++++++++++++++------------------
 hw/arm/armv7m.c                 |  4 +-
 hw/arm/aspeed_ast2600.c         | 89 +++++++++++++-----------------
 hw/arm/aspeed_soc.c             | 69 ++++++++++-------------
 hw/arm/bcm2835_peripherals.c    | 75 +++++++++++--------------
 hw/arm/bcm2836.c                | 11 ++--
 hw/arm/digic.c                  | 10 ++--
 hw/arm/fsl-imx25.c              | 58 ++++++++-----------
 hw/arm/fsl-imx31.c              | 37 ++++++-------
 hw/arm/fsl-imx6.c               | 69 ++++++++++-------------
 hw/arm/fsl-imx6ul.c             | 98 ++++++++++++---------------------
 hw/arm/fsl-imx7.c               | 93 +++++++++++--------------------
 hw/arm/msf2-soc.c               | 25 ++++-----
 hw/arm/nrf51_soc.c              | 30 +++++-----
 hw/arm/stm32f205_soc.c          | 32 +++++------
 hw/arm/stm32f405_soc.c          | 37 ++++++-------
 hw/arm/xlnx-zynqmp.c            | 60 +++++++++-----------
 hw/cpu/a15mpcore.c              |  5 +-
 hw/cpu/a9mpcore.c               | 23 ++++----
 hw/cpu/arm11mpcore.c            | 18 +++---
 hw/cpu/realview_mpcore.c        |  5 +-
 hw/intc/realview_gic.c          |  4 +-
 hw/microblaze/xlnx-zynqmp-pmu.c | 11 ++--
 hw/misc/macio/cuda.c            |  8 +--
 hw/misc/macio/pmu.c             |  8 +--
 hw/ppc/pnv.c                    |  6 +-
 hw/riscv/opentitan.c            |  6 +-
 hw/riscv/sifive_e.c             | 13 ++---
 hw/riscv/sifive_u.c             | 31 ++++-------
 31 files changed, 463 insertions(+), 661 deletions(-)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 64449416de..e05099c757 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -44,33 +44,28 @@ static void aw_a10_init(Object *obj)
     object_initialize_child(obj, "cpu", &s->cpu,
                             ARM_CPU_TYPE_NAME("cortex-a8"));
 
-    sysbus_init_child_obj(obj, "intc", &s->intc, sizeof(s->intc),
-                          TYPE_AW_A10_PIC);
+    object_initialize_child(obj, "intc", &s->intc, TYPE_AW_A10_PIC);
 
-    sysbus_init_child_obj(obj, "timer", &s->timer, sizeof(s->timer),
-                          TYPE_AW_A10_PIT);
+    object_initialize_child(obj, "timer", &s->timer, TYPE_AW_A10_PIT);
 
-    sysbus_init_child_obj(obj, "emac", &s->emac, sizeof(s->emac), TYPE_AW_EMAC);
+    object_initialize_child(obj, "emac", &s->emac, TYPE_AW_EMAC);
 
-    sysbus_init_child_obj(obj, "sata", &s->sata, sizeof(s->sata),
-                          TYPE_ALLWINNER_AHCI);
+    object_initialize_child(obj, "sata", &s->sata, TYPE_ALLWINNER_AHCI);
 
     if (machine_usb(current_machine)) {
         int i;
 
         for (i = 0; i < AW_A10_NUM_USB; i++) {
-            sysbus_init_child_obj(obj, "ehci[*]", &s->ehci[i],
-                                  sizeof(s->ehci[i]), TYPE_PLATFORM_EHCI);
-            sysbus_init_child_obj(obj, "ohci[*]", &s->ohci[i],
-                                  sizeof(s->ohci[i]), TYPE_SYSBUS_OHCI);
+            object_initialize_child(obj, "ehci[*]", &s->ehci[i],
+                                    TYPE_PLATFORM_EHCI);
+            object_initialize_child(obj, "ohci[*]", &s->ohci[i],
+                                    TYPE_SYSBUS_OHCI);
         }
     }
 
-    sysbus_init_child_obj(obj, "mmc0", &s->mmc0, sizeof(s->mmc0),
-                          TYPE_AW_SDHOST_SUN4I);
+    object_initialize_child(obj, "mmc0", &s->mmc0, TYPE_AW_SDHOST_SUN4I);
 
-    sysbus_init_child_obj(obj, "rtc", &s->rtc, sizeof(s->rtc),
-                          TYPE_AW_RTC_SUN4I);
+    object_initialize_child(obj, "rtc", &s->rtc, TYPE_AW_RTC_SUN4I);
 }
 
 static void aw_a10_realize(DeviceState *dev, Error **errp)
@@ -85,7 +80,7 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    object_property_set_bool(OBJECT(&s->intc), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->intc), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
@@ -98,7 +93,7 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
                        qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
     qdev_pass_gpios(DEVICE(&s->intc), dev, NULL);
 
-    object_property_set_bool(OBJECT(&s->timer), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->timer), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
@@ -122,7 +117,7 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
         qemu_check_nic_model(&nd_table[0], TYPE_AW_EMAC);
         qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
     }
-    object_property_set_bool(OBJECT(&s->emac), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->emac), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
@@ -131,7 +126,7 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(sysbusdev, 0, AW_A10_EMAC_BASE);
     sysbus_connect_irq(sysbusdev, 0, qdev_get_gpio_in(dev, 55));
 
-    object_property_set_bool(OBJECT(&s->sata), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->sata), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -154,8 +149,7 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
 
             object_property_set_bool(OBJECT(&s->ehci[i]), true,
                                      "companion-enable", &error_fatal);
-            object_property_set_bool(OBJECT(&s->ehci[i]), true, "realized",
-                                     &error_fatal);
+            sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), &error_fatal);
             sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci[i]), 0,
                             AW_A10_EHCI_BASE + i * 0x8000);
             sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
@@ -163,8 +157,7 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
 
             object_property_set_str(OBJECT(&s->ohci[i]), bus, "masterbus",
                                     &error_fatal);
-            object_property_set_bool(OBJECT(&s->ohci[i]), true, "realized",
-                                     &error_fatal);
+            sysbus_realize(SYS_BUS_DEVICE(&s->ohci[i]), &error_fatal);
             sysbus_mmio_map(SYS_BUS_DEVICE(&s->ohci[i]), 0,
                             AW_A10_OHCI_BASE + i * 0x8000);
             sysbus_connect_irq(SYS_BUS_DEVICE(&s->ohci[i]), 0,
@@ -173,14 +166,14 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     }
 
     /* SD/MMC */
-    qdev_init_nofail(DEVICE(&s->mmc0));
+    sysbus_realize(SYS_BUS_DEVICE(&s->mmc0), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->mmc0), 0, AW_A10_MMC0_BASE);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->mmc0), 0, qdev_get_gpio_in(dev, 32));
     object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->mmc0),
                               "sd-bus");
 
     /* RTC */
-    qdev_init_nofail(DEVICE(&s->rtc));
+    sysbus_realize(SYS_BUS_DEVICE(&s->rtc), &error_fatal);
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->rtc), 0, AW_A10_RTC_BASE, 10);
 }
 
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index 7dc3671155..91d22640e4 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -198,45 +198,35 @@ static void allwinner_h3_init(Object *obj)
                                 ARM_CPU_TYPE_NAME("cortex-a7"));
     }
 
-    sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic),
-                          TYPE_ARM_GIC);
+    object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GIC);
 
-    sysbus_init_child_obj(obj, "timer", &s->timer, sizeof(s->timer),
-                          TYPE_AW_A10_PIT);
+    object_initialize_child(obj, "timer", &s->timer, TYPE_AW_A10_PIT);
     object_property_add_alias(obj, "clk0-freq", OBJECT(&s->timer),
                               "clk0-freq");
     object_property_add_alias(obj, "clk1-freq", OBJECT(&s->timer),
                               "clk1-freq");
 
-    sysbus_init_child_obj(obj, "ccu", &s->ccu, sizeof(s->ccu),
-                          TYPE_AW_H3_CCU);
+    object_initialize_child(obj, "ccu", &s->ccu, TYPE_AW_H3_CCU);
 
-    sysbus_init_child_obj(obj, "sysctrl", &s->sysctrl, sizeof(s->sysctrl),
-                          TYPE_AW_H3_SYSCTRL);
+    object_initialize_child(obj, "sysctrl", &s->sysctrl, TYPE_AW_H3_SYSCTRL);
 
-    sysbus_init_child_obj(obj, "cpucfg", &s->cpucfg, sizeof(s->cpucfg),
-                          TYPE_AW_CPUCFG);
+    object_initialize_child(obj, "cpucfg", &s->cpucfg, TYPE_AW_CPUCFG);
 
-    sysbus_init_child_obj(obj, "sid", &s->sid, sizeof(s->sid),
-                          TYPE_AW_SID);
+    object_initialize_child(obj, "sid", &s->sid, TYPE_AW_SID);
     object_property_add_alias(obj, "identifier", OBJECT(&s->sid),
                               "identifier");
 
-    sysbus_init_child_obj(obj, "mmc0", &s->mmc0, sizeof(s->mmc0),
-                          TYPE_AW_SDHOST_SUN5I);
+    object_initialize_child(obj, "mmc0", &s->mmc0, TYPE_AW_SDHOST_SUN5I);
 
-    sysbus_init_child_obj(obj, "emac", &s->emac, sizeof(s->emac),
-                          TYPE_AW_SUN8I_EMAC);
+    object_initialize_child(obj, "emac", &s->emac, TYPE_AW_SUN8I_EMAC);
 
-    sysbus_init_child_obj(obj, "dramc", &s->dramc, sizeof(s->dramc),
-                          TYPE_AW_H3_DRAMC);
+    object_initialize_child(obj, "dramc", &s->dramc, TYPE_AW_H3_DRAMC);
     object_property_add_alias(obj, "ram-addr", OBJECT(&s->dramc),
                              "ram-addr");
     object_property_add_alias(obj, "ram-size", OBJECT(&s->dramc),
                               "ram-size");
 
-    sysbus_init_child_obj(obj, "rtc", &s->rtc, sizeof(s->rtc),
-                          TYPE_AW_RTC_SUN6I);
+    object_initialize_child(obj, "rtc", &s->rtc, TYPE_AW_RTC_SUN6I);
 }
 
 static void allwinner_h3_realize(DeviceState *dev, Error **errp)
@@ -270,7 +260,7 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
     qdev_prop_set_uint32(DEVICE(&s->gic), "num-cpu", AW_H3_NUM_CPUS);
     qdev_prop_set_bit(DEVICE(&s->gic), "has-security-extensions", false);
     qdev_prop_set_bit(DEVICE(&s->gic), "has-virtualization-extensions", true);
-    qdev_init_nofail(DEVICE(&s->gic));
+    sysbus_realize(SYS_BUS_DEVICE(&s->gic), &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 0, s->memmap[AW_H3_GIC_DIST]);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 1, s->memmap[AW_H3_GIC_CPU]);
@@ -321,7 +311,7 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
     }
 
     /* Timer */
-    qdev_init_nofail(DEVICE(&s->timer));
+    sysbus_realize(SYS_BUS_DEVICE(&s->timer), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->timer), 0, s->memmap[AW_H3_PIT]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer), 0,
                        qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_TIMER0));
@@ -343,23 +333,23 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
                                 &s->sram_c);
 
     /* Clock Control Unit */
-    qdev_init_nofail(DEVICE(&s->ccu));
+    sysbus_realize(SYS_BUS_DEVICE(&s->ccu), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, s->memmap[AW_H3_CCU]);
 
     /* System Control */
-    qdev_init_nofail(DEVICE(&s->sysctrl));
+    sysbus_realize(SYS_BUS_DEVICE(&s->sysctrl), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysctrl), 0, s->memmap[AW_H3_SYSCTRL]);
 
     /* CPU Configuration */
-    qdev_init_nofail(DEVICE(&s->cpucfg));
+    sysbus_realize(SYS_BUS_DEVICE(&s->cpucfg), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->cpucfg), 0, s->memmap[AW_H3_CPUCFG]);
 
     /* Security Identifier */
-    qdev_init_nofail(DEVICE(&s->sid));
+    sysbus_realize(SYS_BUS_DEVICE(&s->sid), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sid), 0, s->memmap[AW_H3_SID]);
 
     /* SD/MMC */
-    qdev_init_nofail(DEVICE(&s->mmc0));
+    sysbus_realize(SYS_BUS_DEVICE(&s->mmc0), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->mmc0), 0, s->memmap[AW_H3_MMC0]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->mmc0), 0,
                        qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_MMC0));
@@ -372,7 +362,7 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
         qemu_check_nic_model(&nd_table[0], TYPE_AW_SUN8I_EMAC);
         qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
     }
-    qdev_init_nofail(DEVICE(&s->emac));
+    sysbus_realize(SYS_BUS_DEVICE(&s->emac), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->emac), 0, s->memmap[AW_H3_EMAC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->emac), 0,
                        qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_EMAC));
@@ -422,13 +412,13 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
                    115200, serial_hd(3), DEVICE_NATIVE_ENDIAN);
 
     /* DRAMC */
-    qdev_init_nofail(DEVICE(&s->dramc));
+    sysbus_realize(SYS_BUS_DEVICE(&s->dramc), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 0, s->memmap[AW_H3_DRAMCOM]);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 1, s->memmap[AW_H3_DRAMCTL]);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 2, s->memmap[AW_H3_DRAMPHY]);
 
     /* RTC */
-    qdev_init_nofail(DEVICE(&s->rtc));
+    sysbus_realize(SYS_BUS_DEVICE(&s->rtc), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, s->memmap[AW_H3_RTC]);
 
     /* Unimplemented devices */
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index f042145e6e..6571c1ed4c 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -273,16 +273,12 @@ static void armsse_init(Object *obj)
         }
     }
 
-    sysbus_init_child_obj(obj, "secctl", &s->secctl, sizeof(s->secctl),
-                          TYPE_IOTKIT_SECCTL);
-    sysbus_init_child_obj(obj, "apb-ppc0", &s->apb_ppc0, sizeof(s->apb_ppc0),
-                          TYPE_TZ_PPC);
-    sysbus_init_child_obj(obj, "apb-ppc1", &s->apb_ppc1, sizeof(s->apb_ppc1),
-                          TYPE_TZ_PPC);
+    object_initialize_child(obj, "secctl", &s->secctl, TYPE_IOTKIT_SECCTL);
+    object_initialize_child(obj, "apb-ppc0", &s->apb_ppc0, TYPE_TZ_PPC);
+    object_initialize_child(obj, "apb-ppc1", &s->apb_ppc1, TYPE_TZ_PPC);
     for (i = 0; i < info->sram_banks; i++) {
         char *name = g_strdup_printf("mpc%d", i);
-        sysbus_init_child_obj(obj, name, &s->mpc[i],
-                              sizeof(s->mpc[i]), TYPE_TZ_MPC);
+        object_initialize_child(obj, name, &s->mpc[i], TYPE_TZ_MPC);
         g_free(name);
     }
     object_initialize_child(obj, "mpc-irq-orgate", &s->mpc_irq_orgate,
@@ -295,24 +291,22 @@ static void armsse_init(Object *obj)
         object_initialize_child(obj, name, splitter, TYPE_SPLIT_IRQ);
         g_free(name);
     }
-    sysbus_init_child_obj(obj, "timer0", &s->timer0, sizeof(s->timer0),
-                          TYPE_CMSDK_APB_TIMER);
-    sysbus_init_child_obj(obj, "timer1", &s->timer1, sizeof(s->timer1),
-                          TYPE_CMSDK_APB_TIMER);
-    sysbus_init_child_obj(obj, "s32ktimer", &s->s32ktimer, sizeof(s->s32ktimer),
-                          TYPE_CMSDK_APB_TIMER);
-    sysbus_init_child_obj(obj, "dualtimer", &s->dualtimer, sizeof(s->dualtimer),
-                          TYPE_CMSDK_APB_DUALTIMER);
-    sysbus_init_child_obj(obj, "s32kwatchdog", &s->s32kwatchdog,
-                          sizeof(s->s32kwatchdog), TYPE_CMSDK_APB_WATCHDOG);
-    sysbus_init_child_obj(obj, "nswatchdog", &s->nswatchdog,
-                          sizeof(s->nswatchdog), TYPE_CMSDK_APB_WATCHDOG);
-    sysbus_init_child_obj(obj, "swatchdog", &s->swatchdog,
-                          sizeof(s->swatchdog), TYPE_CMSDK_APB_WATCHDOG);
-    sysbus_init_child_obj(obj, "armsse-sysctl", &s->sysctl,
-                          sizeof(s->sysctl), TYPE_IOTKIT_SYSCTL);
-    sysbus_init_child_obj(obj, "armsse-sysinfo", &s->sysinfo,
-                          sizeof(s->sysinfo), TYPE_IOTKIT_SYSINFO);
+    object_initialize_child(obj, "timer0", &s->timer0, TYPE_CMSDK_APB_TIMER);
+    object_initialize_child(obj, "timer1", &s->timer1, TYPE_CMSDK_APB_TIMER);
+    object_initialize_child(obj, "s32ktimer", &s->s32ktimer,
+                            TYPE_CMSDK_APB_TIMER);
+    object_initialize_child(obj, "dualtimer", &s->dualtimer,
+                            TYPE_CMSDK_APB_DUALTIMER);
+    object_initialize_child(obj, "s32kwatchdog", &s->s32kwatchdog,
+                            TYPE_CMSDK_APB_WATCHDOG);
+    object_initialize_child(obj, "nswatchdog", &s->nswatchdog,
+                            TYPE_CMSDK_APB_WATCHDOG);
+    object_initialize_child(obj, "swatchdog", &s->swatchdog,
+                            TYPE_CMSDK_APB_WATCHDOG);
+    object_initialize_child(obj, "armsse-sysctl", &s->sysctl,
+                            TYPE_IOTKIT_SYSCTL);
+    object_initialize_child(obj, "armsse-sysinfo", &s->sysinfo,
+                            TYPE_IOTKIT_SYSINFO);
     if (info->has_mhus) {
         sysbus_init_child_obj(obj, "mhu0", &s->mhu[0], sizeof(s->mhu[0]),
                               TYPE_ARMSSE_MHU);
@@ -346,9 +340,8 @@ static void armsse_init(Object *obj)
         for (i = 0; i < info->num_cpus; i++) {
             char *name = g_strdup_printf("cachectrl%d", i);
 
-            sysbus_init_child_obj(obj, name, &s->cachectrl[i],
-                                  sizeof(s->cachectrl[i]),
-                                  TYPE_UNIMPLEMENTED_DEVICE);
+            object_initialize_child(obj, name, &s->cachectrl[i],
+                                    TYPE_UNIMPLEMENTED_DEVICE);
             g_free(name);
         }
     }
@@ -356,9 +349,8 @@ static void armsse_init(Object *obj)
         for (i = 0; i < info->num_cpus; i++) {
             char *name = g_strdup_printf("cpusecctrl%d", i);
 
-            sysbus_init_child_obj(obj, name, &s->cpusecctrl[i],
-                                  sizeof(s->cpusecctrl[i]),
-                                  TYPE_UNIMPLEMENTED_DEVICE);
+            object_initialize_child(obj, name, &s->cpusecctrl[i],
+                                    TYPE_UNIMPLEMENTED_DEVICE);
             g_free(name);
         }
     }
@@ -366,9 +358,8 @@ static void armsse_init(Object *obj)
         for (i = 0; i < info->num_cpus; i++) {
             char *name = g_strdup_printf("cpuid%d", i);
 
-            sysbus_init_child_obj(obj, name, &s->cpuid[i],
-                                  sizeof(s->cpuid[i]),
-                                  TYPE_ARMSSE_CPUID);
+            object_initialize_child(obj, name, &s->cpuid[i],
+                                    TYPE_ARMSSE_CPUID);
             g_free(name);
         }
     }
@@ -669,7 +660,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     }
 
     /* Security controller */
-    object_property_set_bool(OBJECT(&s->secctl), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->secctl), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -721,7 +712,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             error_propagate(errp, err);
             return;
         }
-        object_property_set_bool(OBJECT(&s->mpc[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->mpc[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -764,7 +755,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
      * map its upstream ends to the right place in the container.
      */
     qdev_prop_set_uint32(DEVICE(&s->timer0), "pclk-frq", s->mainclk_frq);
-    object_property_set_bool(OBJECT(&s->timer0), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->timer0), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -779,7 +770,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     }
 
     qdev_prop_set_uint32(DEVICE(&s->timer1), "pclk-frq", s->mainclk_frq);
-    object_property_set_bool(OBJECT(&s->timer1), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->timer1), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -795,7 +786,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
 
 
     qdev_prop_set_uint32(DEVICE(&s->dualtimer), "pclk-frq", s->mainclk_frq);
-    object_property_set_bool(OBJECT(&s->dualtimer), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->dualtimer), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -856,7 +847,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    object_property_set_bool(OBJECT(&s->apb_ppc0), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->apb_ppc0), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -929,8 +920,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             qdev_prop_set_string(DEVICE(&s->cachectrl[i]), "name", name);
             g_free(name);
             qdev_prop_set_uint64(DEVICE(&s->cachectrl[i]), "size", 0x1000);
-            object_property_set_bool(OBJECT(&s->cachectrl[i]), true,
-                                     "realized", &err);
+            sysbus_realize(SYS_BUS_DEVICE(&s->cachectrl[i]), &err);
             if (err) {
                 error_propagate(errp, err);
                 return;
@@ -948,8 +938,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             qdev_prop_set_string(DEVICE(&s->cpusecctrl[i]), "name", name);
             g_free(name);
             qdev_prop_set_uint64(DEVICE(&s->cpusecctrl[i]), "size", 0x1000);
-            object_property_set_bool(OBJECT(&s->cpusecctrl[i]), true,
-                                     "realized", &err);
+            sysbus_realize(SYS_BUS_DEVICE(&s->cpusecctrl[i]), &err);
             if (err) {
                 error_propagate(errp, err);
                 return;
@@ -964,8 +953,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             MemoryRegion *mr;
 
             qdev_prop_set_uint32(DEVICE(&s->cpuid[i]), "CPUID", i);
-            object_property_set_bool(OBJECT(&s->cpuid[i]), true,
-                                     "realized", &err);
+            sysbus_realize(SYS_BUS_DEVICE(&s->cpuid[i]), &err);
             if (err) {
                 error_propagate(errp, err);
                 return;
@@ -981,7 +969,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
      *   0x4002f000: S32K timer
      */
     qdev_prop_set_uint32(DEVICE(&s->s32ktimer), "pclk-frq", S32KCLK);
-    object_property_set_bool(OBJECT(&s->s32ktimer), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->s32ktimer), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -995,7 +983,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    object_property_set_bool(OBJECT(&s->apb_ppc1), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->apb_ppc1), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -1033,7 +1021,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    object_property_set_bool(OBJECT(&s->sysinfo), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->sysinfo), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -1049,7 +1037,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                             "INITSVTOR0_RST", &err);
     object_property_set_int(OBJECT(&s->sysctl), s->init_svtor,
                             "INITSVTOR1_RST", &err);
-    object_property_set_bool(OBJECT(&s->sysctl), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->sysctl), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -1093,7 +1081,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                           qdev_get_gpio_in_named(DEVICE(&s->armv7m), "NMI", 0));
 
     qdev_prop_set_uint32(DEVICE(&s->s32kwatchdog), "wdogclk-frq", S32KCLK);
-    object_property_set_bool(OBJECT(&s->s32kwatchdog), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->s32kwatchdog), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -1105,7 +1093,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     /* 0x40080000 .. 0x4008ffff : ARMSSE second Base peripheral region */
 
     qdev_prop_set_uint32(DEVICE(&s->nswatchdog), "wdogclk-frq", s->mainclk_frq);
-    object_property_set_bool(OBJECT(&s->nswatchdog), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->nswatchdog), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -1115,7 +1103,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->nswatchdog), 0, 0x40081000);
 
     qdev_prop_set_uint32(DEVICE(&s->swatchdog), "wdogclk-frq", s->mainclk_frq);
-    object_property_set_bool(OBJECT(&s->swatchdog), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->swatchdog), &err);
     if (err) {
         error_propagate(errp, err);
         return;
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index f930619f53..6fd672e7d9 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -136,7 +136,7 @@ static void armv7m_instance_init(Object *obj)
 
     memory_region_init(&s->container, obj, "armv7m-container", UINT64_MAX);
 
-    sysbus_init_child_obj(obj, "nvnic", &s->nvic, sizeof(s->nvic), TYPE_NVIC);
+    object_initialize_child(obj, "nvnic", &s->nvic, TYPE_NVIC);
     object_property_add_alias(obj, "num-irq",
                               OBJECT(&s->nvic), "num-irq");
 
@@ -223,7 +223,7 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
     }
 
     /* Note that we must realize the NVIC after the CPU */
-    object_property_set_bool(OBJECT(&s->nvic), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->nvic), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 10e92643c1..7c39adb272 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -131,7 +131,7 @@ static void aspeed_soc_ast2600_init(Object *obj)
     }
 
     snprintf(typename, sizeof(typename), "aspeed.scu-%s", socname);
-    sysbus_init_child_obj(obj, "scu", &s->scu, sizeof(s->scu), typename);
+    object_initialize_child(obj, "scu", &s->scu, typename);
     qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",
                          sc->silicon_rev);
     object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu),
@@ -141,36 +141,33 @@ static void aspeed_soc_ast2600_init(Object *obj)
     object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),
                               "hw-prot-key");
 
-    sysbus_init_child_obj(obj, "a7mpcore", &s->a7mpcore,
-                          sizeof(s->a7mpcore), TYPE_A15MPCORE_PRIV);
+    object_initialize_child(obj, "a7mpcore", &s->a7mpcore,
+                            TYPE_A15MPCORE_PRIV);
 
-    sysbus_init_child_obj(obj, "rtc", &s->rtc, sizeof(s->rtc),
-                          TYPE_ASPEED_RTC);
+    object_initialize_child(obj, "rtc", &s->rtc, TYPE_ASPEED_RTC);
 
     snprintf(typename, sizeof(typename), "aspeed.timer-%s", socname);
-    sysbus_init_child_obj(obj, "timerctrl", &s->timerctrl,
-                          sizeof(s->timerctrl), typename);
+    object_initialize_child(obj, "timerctrl", &s->timerctrl, typename);
 
     snprintf(typename, sizeof(typename), "aspeed.i2c-%s", socname);
-    sysbus_init_child_obj(obj, "i2c", &s->i2c, sizeof(s->i2c), typename);
+    object_initialize_child(obj, "i2c", &s->i2c, typename);
 
     snprintf(typename, sizeof(typename), "aspeed.fmc-%s", socname);
-    sysbus_init_child_obj(obj, "fmc", &s->fmc, sizeof(s->fmc), typename);
+    object_initialize_child(obj, "fmc", &s->fmc, typename);
     object_property_add_alias(obj, "num-cs", OBJECT(&s->fmc), "num-cs");
 
     for (i = 0; i < sc->spis_num; i++) {
         snprintf(typename, sizeof(typename), "aspeed.spi%d-%s", i + 1, socname);
-        sysbus_init_child_obj(obj, "spi[*]", &s->spi[i],
-                              sizeof(s->spi[i]), typename);
+        object_initialize_child(obj, "spi[*]", &s->spi[i], typename);
     }
 
     for (i = 0; i < sc->ehcis_num; i++) {
-        sysbus_init_child_obj(obj, "ehci[*]", &s->ehci[i],
-                              sizeof(s->ehci[i]), TYPE_PLATFORM_EHCI);
+        object_initialize_child(obj, "ehci[*]", &s->ehci[i],
+                                TYPE_PLATFORM_EHCI);
     }
 
     snprintf(typename, sizeof(typename), "aspeed.sdmc-%s", socname);
-    sysbus_init_child_obj(obj, "sdmc", &s->sdmc, sizeof(s->sdmc), typename);
+    object_initialize_child(obj, "sdmc", &s->sdmc, typename);
     object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),
                               "ram-size");
     object_property_add_alias(obj, "max-ram-size", OBJECT(&s->sdmc),
@@ -178,30 +175,26 @@ static void aspeed_soc_ast2600_init(Object *obj)
 
     for (i = 0; i < sc->wdts_num; i++) {
         snprintf(typename, sizeof(typename), "aspeed.wdt-%s", socname);
-        sysbus_init_child_obj(obj, "wdt[*]", &s->wdt[i],
-                              sizeof(s->wdt[i]), typename);
+        object_initialize_child(obj, "wdt[*]", &s->wdt[i], typename);
     }
 
     for (i = 0; i < sc->macs_num; i++) {
-        sysbus_init_child_obj(obj, "ftgmac100[*]", &s->ftgmac100[i],
-                              sizeof(s->ftgmac100[i]), TYPE_FTGMAC100);
+        object_initialize_child(obj, "ftgmac100[*]", &s->ftgmac100[i],
+                                TYPE_FTGMAC100);
 
-        sysbus_init_child_obj(obj, "mii[*]", &s->mii[i], sizeof(s->mii[i]),
-                              TYPE_ASPEED_MII);
+        object_initialize_child(obj, "mii[*]", &s->mii[i], TYPE_ASPEED_MII);
     }
 
-    sysbus_init_child_obj(obj, "xdma", &s->xdma, sizeof(s->xdma),
-                          TYPE_ASPEED_XDMA);
+    object_initialize_child(obj, "xdma", &s->xdma, TYPE_ASPEED_XDMA);
 
     snprintf(typename, sizeof(typename), "aspeed.gpio-%s", socname);
-    sysbus_init_child_obj(obj, "gpio", &s->gpio, sizeof(s->gpio), typename);
+    object_initialize_child(obj, "gpio", &s->gpio, typename);
 
     snprintf(typename, sizeof(typename), "aspeed.gpio-%s-1_8v", socname);
-    sysbus_init_child_obj(obj, "gpio_1_8v", &s->gpio_1_8v,
-                          sizeof(s->gpio_1_8v), typename);
+    object_initialize_child(obj, "gpio_1_8v", &s->gpio_1_8v, typename);
 
-    sysbus_init_child_obj(obj, "sd-controller", &s->sdhci,
-                          sizeof(s->sdhci), TYPE_ASPEED_SDHCI);
+    object_initialize_child(obj, "sd-controller", &s->sdhci,
+                            TYPE_ASPEED_SDHCI);
 
     object_property_set_int(OBJECT(&s->sdhci), 2, "num-slots", &error_abort);
 
@@ -212,8 +205,8 @@ static void aspeed_soc_ast2600_init(Object *obj)
                               sizeof(s->sdhci.slots[i]), TYPE_SYSBUS_SDHCI);
     }
 
-    sysbus_init_child_obj(obj, "emmc-controller", &s->emmc,
-                          sizeof(s->emmc), TYPE_ASPEED_SDHCI);
+    object_initialize_child(obj, "emmc-controller", &s->emmc,
+                            TYPE_ASPEED_SDHCI);
 
     object_property_set_int(OBJECT(&s->emmc), 1, "num-slots", &error_abort);
 
@@ -282,8 +275,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                             ASPEED_SOC_AST2600_MAX_IRQ + GIC_INTERNAL,
                             "num-irq", &error_abort);
 
-    object_property_set_bool(OBJECT(&s->a7mpcore), true, "realized",
-                             &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->a7mpcore), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->a7mpcore), 0, ASPEED_A7MPCORE_ADDR);
 
     for (i = 0; i < sc->num_cpus; i++) {
@@ -311,7 +303,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                                 sc->memmap[ASPEED_SRAM], &s->sram);
 
     /* SCU */
-    object_property_set_bool(OBJECT(&s->scu), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->scu), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -319,7 +311,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_SCU]);
 
     /* RTC */
-    object_property_set_bool(OBJECT(&s->rtc), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->rtc), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -331,7 +323,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     /* Timer */
     object_property_set_link(OBJECT(&s->timerctrl),
                              OBJECT(&s->scu), "scu", &error_abort);
-    object_property_set_bool(OBJECT(&s->timerctrl), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -356,7 +348,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    object_property_set_bool(OBJECT(&s->i2c), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->i2c), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -384,7 +376,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    object_property_set_bool(OBJECT(&s->fmc), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->fmc), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -404,8 +396,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
             return;
         }
         object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs", &err);
-        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized",
-                                 &local_err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &local_err);
         error_propagate(&err, local_err);
         if (err) {
             error_propagate(errp, err);
@@ -419,7 +410,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
     /* EHCI */
     for (i = 0; i < sc->ehcis_num; i++) {
-        object_property_set_bool(OBJECT(&s->ehci[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -431,7 +422,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
 
     /* SDMC - SDRAM Memory Controller */
-    object_property_set_bool(OBJECT(&s->sdmc), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -444,7 +435,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
         object_property_set_link(OBJECT(&s->wdt[i]),
                                  OBJECT(&s->scu), "scu", &error_abort);
-        object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -457,8 +448,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < sc->macs_num; i++) {
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed",
                                  &err);
-        object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "realized",
-                                 &local_err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), &local_err);
         error_propagate(&err, local_err);
         if (err) {
             error_propagate(errp, err);
@@ -471,8 +461,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
         object_property_set_link(OBJECT(&s->mii[i]), OBJECT(&s->ftgmac100[i]),
                                  "nic", &error_abort);
-        object_property_set_bool(OBJECT(&s->mii[i]), true, "realized",
-                                 &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->mii[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -483,7 +472,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
 
     /* XDMA */
-    object_property_set_bool(OBJECT(&s->xdma), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->xdma), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -494,7 +483,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_XDMA));
 
     /* GPIO */
-    object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -503,7 +492,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
                        aspeed_soc_get_irq(s, ASPEED_GPIO));
 
-    object_property_set_bool(OBJECT(&s->gpio_1_8v), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->gpio_1_8v), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -514,7 +503,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_GPIO_1_8V));
 
     /* SDHCI */
-    object_property_set_bool(OBJECT(&s->sdhci), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -525,7 +514,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_SDHCI));
 
     /* eMMC */
-    object_property_set_bool(OBJECT(&s->emmc), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->emmc), &err);
     if (err) {
         error_propagate(errp, err);
         return;
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 5806e5c9b4..c40839c1fb 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -146,7 +146,7 @@ static void aspeed_soc_init(Object *obj)
     }
 
     snprintf(typename, sizeof(typename), "aspeed.scu-%s", socname);
-    sysbus_init_child_obj(obj, "scu", &s->scu, sizeof(s->scu), typename);
+    object_initialize_child(obj, "scu", &s->scu, typename);
     qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",
                          sc->silicon_rev);
     object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu),
@@ -156,36 +156,32 @@ static void aspeed_soc_init(Object *obj)
     object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),
                               "hw-prot-key");
 
-    sysbus_init_child_obj(obj, "vic", &s->vic, sizeof(s->vic),
-                          TYPE_ASPEED_VIC);
+    object_initialize_child(obj, "vic", &s->vic, TYPE_ASPEED_VIC);
 
-    sysbus_init_child_obj(obj, "rtc", &s->rtc, sizeof(s->rtc),
-                          TYPE_ASPEED_RTC);
+    object_initialize_child(obj, "rtc", &s->rtc, TYPE_ASPEED_RTC);
 
     snprintf(typename, sizeof(typename), "aspeed.timer-%s", socname);
-    sysbus_init_child_obj(obj, "timerctrl", &s->timerctrl,
-                          sizeof(s->timerctrl), typename);
+    object_initialize_child(obj, "timerctrl", &s->timerctrl, typename);
 
     snprintf(typename, sizeof(typename), "aspeed.i2c-%s", socname);
-    sysbus_init_child_obj(obj, "i2c", &s->i2c, sizeof(s->i2c), typename);
+    object_initialize_child(obj, "i2c", &s->i2c, typename);
 
     snprintf(typename, sizeof(typename), "aspeed.fmc-%s", socname);
-    sysbus_init_child_obj(obj, "fmc", &s->fmc, sizeof(s->fmc), typename);
+    object_initialize_child(obj, "fmc", &s->fmc, typename);
     object_property_add_alias(obj, "num-cs", OBJECT(&s->fmc), "num-cs");
 
     for (i = 0; i < sc->spis_num; i++) {
         snprintf(typename, sizeof(typename), "aspeed.spi%d-%s", i + 1, socname);
-        sysbus_init_child_obj(obj, "spi[*]", &s->spi[i],
-                              sizeof(s->spi[i]), typename);
+        object_initialize_child(obj, "spi[*]", &s->spi[i], typename);
     }
 
     for (i = 0; i < sc->ehcis_num; i++) {
-        sysbus_init_child_obj(obj, "ehci[*]", &s->ehci[i],
-                              sizeof(s->ehci[i]), TYPE_PLATFORM_EHCI);
+        object_initialize_child(obj, "ehci[*]", &s->ehci[i],
+                                TYPE_PLATFORM_EHCI);
     }
 
     snprintf(typename, sizeof(typename), "aspeed.sdmc-%s", socname);
-    sysbus_init_child_obj(obj, "sdmc", &s->sdmc, sizeof(s->sdmc), typename);
+    object_initialize_child(obj, "sdmc", &s->sdmc, typename);
     object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),
                               "ram-size");
     object_property_add_alias(obj, "max-ram-size", OBJECT(&s->sdmc),
@@ -193,23 +189,20 @@ static void aspeed_soc_init(Object *obj)
 
     for (i = 0; i < sc->wdts_num; i++) {
         snprintf(typename, sizeof(typename), "aspeed.wdt-%s", socname);
-        sysbus_init_child_obj(obj, "wdt[*]", &s->wdt[i],
-                              sizeof(s->wdt[i]), typename);
+        object_initialize_child(obj, "wdt[*]", &s->wdt[i], typename);
     }
 
     for (i = 0; i < sc->macs_num; i++) {
-        sysbus_init_child_obj(obj, "ftgmac100[*]", &s->ftgmac100[i],
-                              sizeof(s->ftgmac100[i]), TYPE_FTGMAC100);
+        object_initialize_child(obj, "ftgmac100[*]", &s->ftgmac100[i],
+                                TYPE_FTGMAC100);
     }
 
-    sysbus_init_child_obj(obj, "xdma", &s->xdma, sizeof(s->xdma),
-                          TYPE_ASPEED_XDMA);
+    object_initialize_child(obj, "xdma", &s->xdma, TYPE_ASPEED_XDMA);
 
     snprintf(typename, sizeof(typename), "aspeed.gpio-%s", socname);
-    sysbus_init_child_obj(obj, "gpio", &s->gpio, sizeof(s->gpio), typename);
+    object_initialize_child(obj, "gpio", &s->gpio, typename);
 
-    sysbus_init_child_obj(obj, "sdc", &s->sdhci, sizeof(s->sdhci),
-                          TYPE_ASPEED_SDHCI);
+    object_initialize_child(obj, "sdc", &s->sdhci, TYPE_ASPEED_SDHCI);
 
     object_property_set_int(OBJECT(&s->sdhci), 2, "num-slots", &error_abort);
 
@@ -255,7 +248,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                                 sc->memmap[ASPEED_SRAM], &s->sram);
 
     /* SCU */
-    object_property_set_bool(OBJECT(&s->scu), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->scu), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -263,7 +256,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_SCU]);
 
     /* VIC */
-    object_property_set_bool(OBJECT(&s->vic), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->vic), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -275,7 +268,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                        qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
 
     /* RTC */
-    object_property_set_bool(OBJECT(&s->rtc), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->rtc), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -287,7 +280,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     /* Timer */
     object_property_set_link(OBJECT(&s->timerctrl),
                              OBJECT(&s->scu), "scu", &error_abort);
-    object_property_set_bool(OBJECT(&s->timerctrl), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -312,7 +305,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    object_property_set_bool(OBJECT(&s->i2c), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->i2c), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -333,7 +326,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    object_property_set_bool(OBJECT(&s->fmc), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->fmc), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -347,8 +340,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     /* SPI */
     for (i = 0; i < sc->spis_num; i++) {
         object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs", &err);
-        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized",
-                                 &local_err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &local_err);
         error_propagate(&err, local_err);
         if (err) {
             error_propagate(errp, err);
@@ -362,7 +354,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 
     /* EHCI */
     for (i = 0; i < sc->ehcis_num; i++) {
-        object_property_set_bool(OBJECT(&s->ehci[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -374,7 +366,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* SDMC - SDRAM Memory Controller */
-    object_property_set_bool(OBJECT(&s->sdmc), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -387,7 +379,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 
         object_property_set_link(OBJECT(&s->wdt[i]),
                                  OBJECT(&s->scu), "scu", &error_abort);
-        object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -400,8 +392,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < sc->macs_num; i++) {
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed",
                                  &err);
-        object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "realized",
-                                 &local_err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), &local_err);
         error_propagate(&err, local_err);
         if (err) {
             error_propagate(errp, err);
@@ -414,7 +405,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* XDMA */
-    object_property_set_bool(OBJECT(&s->xdma), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->xdma), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -425,7 +416,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_XDMA));
 
     /* GPIO */
-    object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -435,7 +426,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_GPIO));
 
     /* SDHCI */
-    object_property_set_bool(OBJECT(&s->sdhci), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), &err);
     if (err) {
         error_propagate(errp, err);
         return;
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 987e394ec8..1e975d7eec 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -53,37 +53,34 @@ static void bcm2835_peripherals_init(Object *obj)
                        MBOX_CHAN_COUNT << MBOX_AS_CHAN_SHIFT);
 
     /* Interrupt Controller */
-    sysbus_init_child_obj(obj, "ic", &s->ic, sizeof(s->ic), TYPE_BCM2835_IC);
+    object_initialize_child(obj, "ic", &s->ic, TYPE_BCM2835_IC);
 
     /* SYS Timer */
-    sysbus_init_child_obj(obj, "systimer", &s->systmr, sizeof(s->systmr),
-                          TYPE_BCM2835_SYSTIMER);
+    object_initialize_child(obj, "systimer", &s->systmr,
+                            TYPE_BCM2835_SYSTIMER);
 
     /* UART0 */
-    sysbus_init_child_obj(obj, "uart0", &s->uart0, sizeof(s->uart0),
-                          TYPE_PL011);
+    object_initialize_child(obj, "uart0", &s->uart0, TYPE_PL011);
 
     /* AUX / UART1 */
-    sysbus_init_child_obj(obj, "aux", &s->aux, sizeof(s->aux),
-                          TYPE_BCM2835_AUX);
+    object_initialize_child(obj, "aux", &s->aux, TYPE_BCM2835_AUX);
 
     /* Mailboxes */
-    sysbus_init_child_obj(obj, "mbox", &s->mboxes, sizeof(s->mboxes),
-                          TYPE_BCM2835_MBOX);
+    object_initialize_child(obj, "mbox", &s->mboxes, TYPE_BCM2835_MBOX);
 
     object_property_add_const_link(OBJECT(&s->mboxes), "mbox-mr",
                                    OBJECT(&s->mbox_mr));
 
     /* Framebuffer */
-    sysbus_init_child_obj(obj, "fb", &s->fb, sizeof(s->fb), TYPE_BCM2835_FB);
+    object_initialize_child(obj, "fb", &s->fb, TYPE_BCM2835_FB);
     object_property_add_alias(obj, "vcram-size", OBJECT(&s->fb), "vcram-size");
 
     object_property_add_const_link(OBJECT(&s->fb), "dma-mr",
                                    OBJECT(&s->gpu_bus_mr));
 
     /* Property channel */
-    sysbus_init_child_obj(obj, "property", &s->property, sizeof(s->property),
-                          TYPE_BCM2835_PROPERTY);
+    object_initialize_child(obj, "property", &s->property,
+                            TYPE_BCM2835_PROPERTY);
     object_property_add_alias(obj, "board-rev", OBJECT(&s->property),
                               "board-rev");
 
@@ -93,31 +90,25 @@ static void bcm2835_peripherals_init(Object *obj)
                                    OBJECT(&s->gpu_bus_mr));
 
     /* Random Number Generator */
-    sysbus_init_child_obj(obj, "rng", &s->rng, sizeof(s->rng),
-                          TYPE_BCM2835_RNG);
+    object_initialize_child(obj, "rng", &s->rng, TYPE_BCM2835_RNG);
 
     /* Extended Mass Media Controller */
-    sysbus_init_child_obj(obj, "sdhci", &s->sdhci, sizeof(s->sdhci),
-                          TYPE_SYSBUS_SDHCI);
+    object_initialize_child(obj, "sdhci", &s->sdhci, TYPE_SYSBUS_SDHCI);
 
     /* SDHOST */
-    sysbus_init_child_obj(obj, "sdhost", &s->sdhost, sizeof(s->sdhost),
-                          TYPE_BCM2835_SDHOST);
+    object_initialize_child(obj, "sdhost", &s->sdhost, TYPE_BCM2835_SDHOST);
 
     /* DMA Channels */
-    sysbus_init_child_obj(obj, "dma", &s->dma, sizeof(s->dma),
-                          TYPE_BCM2835_DMA);
+    object_initialize_child(obj, "dma", &s->dma, TYPE_BCM2835_DMA);
 
     object_property_add_const_link(OBJECT(&s->dma), "dma-mr",
                                    OBJECT(&s->gpu_bus_mr));
 
     /* Thermal */
-    sysbus_init_child_obj(obj, "thermal", &s->thermal, sizeof(s->thermal),
-                          TYPE_BCM2835_THERMAL);
+    object_initialize_child(obj, "thermal", &s->thermal, TYPE_BCM2835_THERMAL);
 
     /* GPIO */
-    sysbus_init_child_obj(obj, "gpio", &s->gpio, sizeof(s->gpio),
-                          TYPE_BCM2835_GPIO);
+    object_initialize_child(obj, "gpio", &s->gpio, TYPE_BCM2835_GPIO);
 
     object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhci",
                                    OBJECT(&s->sdhci.sdbus));
@@ -125,12 +116,10 @@ static void bcm2835_peripherals_init(Object *obj)
                                    OBJECT(&s->sdhost.sdbus));
 
     /* Mphi */
-    sysbus_init_child_obj(obj, "mphi", &s->mphi, sizeof(s->mphi),
-                          TYPE_BCM2835_MPHI);
+    object_initialize_child(obj, "mphi", &s->mphi, TYPE_BCM2835_MPHI);
 
     /* DWC2 */
-    sysbus_init_child_obj(obj, "dwc2", &s->dwc2, sizeof(s->dwc2),
-                          TYPE_DWC2_USB);
+    object_initialize_child(obj, "dwc2", &s->dwc2, TYPE_DWC2_USB);
 
     object_property_add_const_link(OBJECT(&s->dwc2), "dma-mr",
                                    OBJECT(&s->gpu_bus_mr));
@@ -172,7 +161,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     }
 
     /* Interrupt Controller */
-    object_property_set_bool(OBJECT(&s->ic), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->ic), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -183,7 +172,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     sysbus_pass_irq(SYS_BUS_DEVICE(s), SYS_BUS_DEVICE(&s->ic));
 
     /* Sys Timer */
-    object_property_set_bool(OBJECT(&s->systmr), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->systmr), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -196,7 +185,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
 
     /* UART0 */
     qdev_prop_set_chr(DEVICE(&s->uart0), "chardev", serial_hd(0));
-    object_property_set_bool(OBJECT(&s->uart0), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->uart0), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -211,7 +200,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     /* AUX / UART1 */
     qdev_prop_set_chr(DEVICE(&s->aux), "chardev", serial_hd(1));
 
-    object_property_set_bool(OBJECT(&s->aux), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->aux), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -224,7 +213,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                                INTERRUPT_AUX));
 
     /* Mailboxes */
-    object_property_set_bool(OBJECT(&s->mboxes), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->mboxes), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -250,7 +239,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    object_property_set_bool(OBJECT(&s->fb), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->fb), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -262,7 +251,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                        qdev_get_gpio_in(DEVICE(&s->mboxes), MBOX_CHAN_FB));
 
     /* Property channel */
-    object_property_set_bool(OBJECT(&s->property), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->property), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -275,7 +264,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                       qdev_get_gpio_in(DEVICE(&s->mboxes), MBOX_CHAN_PROPERTY));
 
     /* Random Number Generator */
-    object_property_set_bool(OBJECT(&s->rng), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->rng), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -304,7 +293,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    object_property_set_bool(OBJECT(&s->sdhci), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -317,7 +306,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                                INTERRUPT_ARASANSDIO));
 
     /* SDHOST */
-    object_property_set_bool(OBJECT(&s->sdhost), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->sdhost), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -330,7 +319,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                                INTERRUPT_SDIO));
 
     /* DMA Channels */
-    object_property_set_bool(OBJECT(&s->dma), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->dma), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -349,7 +338,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     }
 
     /* THERMAL */
-    object_property_set_bool(OBJECT(&s->thermal), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->thermal), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -358,7 +347,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->thermal), 0));
 
     /* GPIO */
-    object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -370,7 +359,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->gpio), "sd-bus");
 
     /* Mphi */
-    object_property_set_bool(OBJECT(&s->mphi), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->mphi), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -383,7 +372,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                                INTERRUPT_HOSTPORT));
 
     /* DWC2 */
-    object_property_set_bool(OBJECT(&s->dwc2), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->dwc2), &err);
     if (err) {
         error_propagate(errp, err);
         return;
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 82cd1d2df8..39a63f2565 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -56,11 +56,10 @@ static void bcm2836_init(Object *obj)
                                 info->cpu_type);
     }
 
-    sysbus_init_child_obj(obj, "control", &s->control, sizeof(s->control),
-                          TYPE_BCM2836_CONTROL);
+    object_initialize_child(obj, "control", &s->control, TYPE_BCM2836_CONTROL);
 
-    sysbus_init_child_obj(obj, "peripherals", &s->peripherals,
-                          sizeof(s->peripherals), TYPE_BCM2835_PERIPHERALS);
+    object_initialize_child(obj, "peripherals", &s->peripherals,
+                            TYPE_BCM2835_PERIPHERALS);
     object_property_add_alias(obj, "board-rev", OBJECT(&s->peripherals),
                               "board-rev");
     object_property_add_alias(obj, "vcram-size", OBJECT(&s->peripherals),
@@ -87,7 +86,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
 
     object_property_add_const_link(OBJECT(&s->peripherals), "ram", obj);
 
-    object_property_set_bool(OBJECT(&s->peripherals), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->peripherals), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -100,7 +99,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
                             info->peri_base, 1);
 
     /* bcm2836 interrupt controller (and mailboxes, etc.) */
-    object_property_set_bool(OBJECT(&s->control), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->control), &err);
     if (err) {
         error_propagate(errp, err);
         return;
diff --git a/hw/arm/digic.c b/hw/arm/digic.c
index 6153d5f108..13acd2cf6e 100644
--- a/hw/arm/digic.c
+++ b/hw/arm/digic.c
@@ -43,12 +43,10 @@ static void digic_init(Object *obj)
         char name[DIGIC_TIMER_NAME_MLEN];
 
         snprintf(name, DIGIC_TIMER_NAME_MLEN, "timer[%d]", i);
-        sysbus_init_child_obj(obj, name, &s->timer[i], sizeof(s->timer[i]),
-                              TYPE_DIGIC_TIMER);
+        object_initialize_child(obj, name, &s->timer[i], TYPE_DIGIC_TIMER);
     }
 
-    sysbus_init_child_obj(obj, "uart", &s->uart, sizeof(s->uart),
-                          TYPE_DIGIC_UART);
+    object_initialize_child(obj, "uart", &s->uart, TYPE_DIGIC_UART);
 }
 
 static void digic_realize(DeviceState *dev, Error **errp)
@@ -71,7 +69,7 @@ static void digic_realize(DeviceState *dev, Error **errp)
     }
 
     for (i = 0; i < DIGIC4_NB_TIMERS; i++) {
-        object_property_set_bool(OBJECT(&s->timer[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), &err);
         if (err != NULL) {
             error_propagate(errp, err);
             return;
@@ -82,7 +80,7 @@ static void digic_realize(DeviceState *dev, Error **errp)
     }
 
     qdev_prop_set_chr(DEVICE(&s->uart), "chardev", serial_hd(0));
-    object_property_set_bool(OBJECT(&s->uart), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->uart), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index d8340e3527..d2c4970074 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -40,52 +40,43 @@ static void fsl_imx25_init(Object *obj)
 
     object_initialize_child(obj, "cpu", &s->cpu, ARM_CPU_TYPE_NAME("arm926"));
 
-    sysbus_init_child_obj(obj, "avic", &s->avic, sizeof(s->avic),
-                          TYPE_IMX_AVIC);
+    object_initialize_child(obj, "avic", &s->avic, TYPE_IMX_AVIC);
 
-    sysbus_init_child_obj(obj, "ccm", &s->ccm, sizeof(s->ccm), TYPE_IMX25_CCM);
+    object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX25_CCM);
 
     for (i = 0; i < FSL_IMX25_NUM_UARTS; i++) {
-        sysbus_init_child_obj(obj, "uart[*]", &s->uart[i], sizeof(s->uart[i]),
-                              TYPE_IMX_SERIAL);
+        object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_IMX_SERIAL);
     }
 
     for (i = 0; i < FSL_IMX25_NUM_GPTS; i++) {
-        sysbus_init_child_obj(obj, "gpt[*]", &s->gpt[i], sizeof(s->gpt[i]),
-                              TYPE_IMX25_GPT);
+        object_initialize_child(obj, "gpt[*]", &s->gpt[i], TYPE_IMX25_GPT);
     }
 
     for (i = 0; i < FSL_IMX25_NUM_EPITS; i++) {
-        sysbus_init_child_obj(obj, "epit[*]", &s->epit[i], sizeof(s->epit[i]),
-                              TYPE_IMX_EPIT);
+        object_initialize_child(obj, "epit[*]", &s->epit[i], TYPE_IMX_EPIT);
     }
 
-    sysbus_init_child_obj(obj, "fec", &s->fec, sizeof(s->fec), TYPE_IMX_FEC);
+    object_initialize_child(obj, "fec", &s->fec, TYPE_IMX_FEC);
 
-    sysbus_init_child_obj(obj, "rngc", &s->rngc, sizeof(s->rngc),
-                          TYPE_IMX_RNGC);
+    object_initialize_child(obj, "rngc", &s->rngc, TYPE_IMX_RNGC);
 
     for (i = 0; i < FSL_IMX25_NUM_I2CS; i++) {
-        sysbus_init_child_obj(obj, "i2c[*]", &s->i2c[i], sizeof(s->i2c[i]),
-                              TYPE_IMX_I2C);
+        object_initialize_child(obj, "i2c[*]", &s->i2c[i], TYPE_IMX_I2C);
     }
 
     for (i = 0; i < FSL_IMX25_NUM_GPIOS; i++) {
-        sysbus_init_child_obj(obj, "gpio[*]", &s->gpio[i], sizeof(s->gpio[i]),
-                              TYPE_IMX_GPIO);
+        object_initialize_child(obj, "gpio[*]", &s->gpio[i], TYPE_IMX_GPIO);
     }
 
     for (i = 0; i < FSL_IMX25_NUM_ESDHCS; i++) {
-        sysbus_init_child_obj(obj, "sdhc[*]", &s->esdhc[i], sizeof(s->esdhc[i]),
-                              TYPE_IMX_USDHC);
+        object_initialize_child(obj, "sdhc[*]", &s->esdhc[i], TYPE_IMX_USDHC);
     }
 
     for (i = 0; i < FSL_IMX25_NUM_USBS; i++) {
-        sysbus_init_child_obj(obj, "usb[*]", &s->usb[i], sizeof(s->usb[i]),
-                              TYPE_CHIPIDEA);
+        object_initialize_child(obj, "usb[*]", &s->usb[i], TYPE_CHIPIDEA);
     }
 
-    sysbus_init_child_obj(obj, "wdt", &s->wdt, sizeof(s->wdt), TYPE_IMX2_WDT);
+    object_initialize_child(obj, "wdt", &s->wdt, TYPE_IMX2_WDT);
 }
 
 static void fsl_imx25_realize(DeviceState *dev, Error **errp)
@@ -100,7 +91,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    object_property_set_bool(OBJECT(&s->avic), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->avic), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -111,7 +102,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->avic), 1,
                        qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
 
-    object_property_set_bool(OBJECT(&s->ccm), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->ccm), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -133,7 +124,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
         qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
 
-        object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -158,7 +149,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
         s->gpt[i].ccm = IMX_CCM(&s->ccm);
 
-        object_property_set_bool(OBJECT(&s->gpt[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->gpt[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -181,7 +172,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
         s->epit[i].ccm = IMX_CCM(&s->ccm);
 
-        object_property_set_bool(OBJECT(&s->epit[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -194,7 +185,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
     qdev_set_nic_properties(DEVICE(&s->fec), &nd_table[0]);
 
-    object_property_set_bool(OBJECT(&s->fec), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->fec), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -203,7 +194,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fec), 0,
                        qdev_get_gpio_in(DEVICE(&s->avic), FSL_IMX25_FEC_IRQ));
 
-    object_property_set_bool(OBJECT(&s->rngc), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->rngc), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -223,7 +214,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
             { FSL_IMX25_I2C3_ADDR, FSL_IMX25_I2C3_IRQ }
         };
 
-        object_property_set_bool(OBJECT(&s->i2c[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -246,7 +237,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
             { FSL_IMX25_GPIO4_ADDR, FSL_IMX25_GPIO4_IRQ }
         };
 
-        object_property_set_bool(OBJECT(&s->gpio[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -272,7 +263,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
                                  &err);
         object_property_set_uint(OBJECT(&s->esdhc[i]), IMX25_ESDHC_CAPABILITIES,
                                  "capareg", &err);
-        object_property_set_bool(OBJECT(&s->esdhc[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -293,8 +284,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
             { FSL_IMX25_USB2_ADDR, FSL_IMX25_USB2_IRQ },
         };
 
-        object_property_set_bool(OBJECT(&s->usb[i]), true, "realized",
-                                 &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->usb[i]), &error_abort);
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usb[i]), 0, usb_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->usb[i]), 0,
                            qdev_get_gpio_in(DEVICE(&s->avic),
@@ -304,7 +294,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
     /* Watchdog */
     object_property_set_bool(OBJECT(&s->wdt), true, "pretimeout-support",
                              &error_abort);
-    object_property_set_bool(OBJECT(&s->wdt), true, "realized", &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->wdt), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt), 0, FSL_IMX25_WDT_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt), 0,
                                       qdev_get_gpio_in(DEVICE(&s->avic),
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 54eec89701..08236c3230 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -35,34 +35,29 @@ static void fsl_imx31_init(Object *obj)
 
     object_initialize_child(obj, "cpu", &s->cpu, ARM_CPU_TYPE_NAME("arm1136"));
 
-    sysbus_init_child_obj(obj, "avic", &s->avic, sizeof(s->avic),
-                          TYPE_IMX_AVIC);
+    object_initialize_child(obj, "avic", &s->avic, TYPE_IMX_AVIC);
 
-    sysbus_init_child_obj(obj, "ccm", &s->ccm, sizeof(s->ccm), TYPE_IMX31_CCM);
+    object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX31_CCM);
 
     for (i = 0; i < FSL_IMX31_NUM_UARTS; i++) {
-        sysbus_init_child_obj(obj, "uart[*]", &s->uart[i], sizeof(s->uart[i]),
-                              TYPE_IMX_SERIAL);
+        object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_IMX_SERIAL);
     }
 
-    sysbus_init_child_obj(obj, "gpt", &s->gpt, sizeof(s->gpt), TYPE_IMX31_GPT);
+    object_initialize_child(obj, "gpt", &s->gpt, TYPE_IMX31_GPT);
 
     for (i = 0; i < FSL_IMX31_NUM_EPITS; i++) {
-        sysbus_init_child_obj(obj, "epit[*]", &s->epit[i], sizeof(s->epit[i]),
-                              TYPE_IMX_EPIT);
+        object_initialize_child(obj, "epit[*]", &s->epit[i], TYPE_IMX_EPIT);
     }
 
     for (i = 0; i < FSL_IMX31_NUM_I2CS; i++) {
-        sysbus_init_child_obj(obj, "i2c[*]", &s->i2c[i], sizeof(s->i2c[i]),
-                              TYPE_IMX_I2C);
+        object_initialize_child(obj, "i2c[*]", &s->i2c[i], TYPE_IMX_I2C);
     }
 
     for (i = 0; i < FSL_IMX31_NUM_GPIOS; i++) {
-        sysbus_init_child_obj(obj, "gpio[*]", &s->gpio[i], sizeof(s->gpio[i]),
-                              TYPE_IMX_GPIO);
+        object_initialize_child(obj, "gpio[*]", &s->gpio[i], TYPE_IMX_GPIO);
     }
 
-    sysbus_init_child_obj(obj, "wdt", &s->wdt, sizeof(s->wdt), TYPE_IMX2_WDT);
+    object_initialize_child(obj, "wdt", &s->wdt, TYPE_IMX2_WDT);
 }
 
 static void fsl_imx31_realize(DeviceState *dev, Error **errp)
@@ -77,7 +72,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    object_property_set_bool(OBJECT(&s->avic), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->avic), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -88,7 +83,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->avic), 1,
                        qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
 
-    object_property_set_bool(OBJECT(&s->ccm), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->ccm), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -107,7 +102,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
         qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
 
-        object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -121,7 +116,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
     s->gpt.ccm = IMX_CCM(&s->ccm);
 
-    object_property_set_bool(OBJECT(&s->gpt), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->gpt), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -143,7 +138,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
         s->epit[i].ccm = IMX_CCM(&s->ccm);
 
-        object_property_set_bool(OBJECT(&s->epit[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -167,7 +162,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
         };
 
         /* Initialize the I2C */
-        object_property_set_bool(OBJECT(&s->i2c[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -193,7 +188,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
         object_property_set_bool(OBJECT(&s->gpio[i]), false, "has-edge-sel",
                                  &error_abort);
-        object_property_set_bool(OBJECT(&s->gpio[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -206,7 +201,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
     }
 
     /* Watchdog */
-    object_property_set_bool(OBJECT(&s->wdt), true, "realized", &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->wdt), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt), 0, FSL_IMX31_WDT_ADDR);
 
     /* On a real system, the first 16k is a `secure boot rom' */
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 88fbba84a4..33b1be4000 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -47,69 +47,59 @@ static void fsl_imx6_init(Object *obj)
                                 ARM_CPU_TYPE_NAME("cortex-a9"));
     }
 
-    sysbus_init_child_obj(obj, "a9mpcore", &s->a9mpcore, sizeof(s->a9mpcore),
-                          TYPE_A9MPCORE_PRIV);
+    object_initialize_child(obj, "a9mpcore", &s->a9mpcore, TYPE_A9MPCORE_PRIV);
 
-    sysbus_init_child_obj(obj, "ccm", &s->ccm, sizeof(s->ccm), TYPE_IMX6_CCM);
+    object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX6_CCM);
 
-    sysbus_init_child_obj(obj, "src", &s->src, sizeof(s->src), TYPE_IMX6_SRC);
+    object_initialize_child(obj, "src", &s->src, TYPE_IMX6_SRC);
 
     for (i = 0; i < FSL_IMX6_NUM_UARTS; i++) {
         snprintf(name, NAME_SIZE, "uart%d", i + 1);
-        sysbus_init_child_obj(obj, name, &s->uart[i], sizeof(s->uart[i]),
-                              TYPE_IMX_SERIAL);
+        object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
     }
 
-    sysbus_init_child_obj(obj, "gpt", &s->gpt, sizeof(s->gpt), TYPE_IMX6_GPT);
+    object_initialize_child(obj, "gpt", &s->gpt, TYPE_IMX6_GPT);
 
     for (i = 0; i < FSL_IMX6_NUM_EPITS; i++) {
         snprintf(name, NAME_SIZE, "epit%d", i + 1);
-        sysbus_init_child_obj(obj, name, &s->epit[i], sizeof(s->epit[i]),
-                              TYPE_IMX_EPIT);
+        object_initialize_child(obj, name, &s->epit[i], TYPE_IMX_EPIT);
     }
 
     for (i = 0; i < FSL_IMX6_NUM_I2CS; i++) {
         snprintf(name, NAME_SIZE, "i2c%d", i + 1);
-        sysbus_init_child_obj(obj, name, &s->i2c[i], sizeof(s->i2c[i]),
-                              TYPE_IMX_I2C);
+        object_initialize_child(obj, name, &s->i2c[i], TYPE_IMX_I2C);
     }
 
     for (i = 0; i < FSL_IMX6_NUM_GPIOS; i++) {
         snprintf(name, NAME_SIZE, "gpio%d", i + 1);
-        sysbus_init_child_obj(obj, name, &s->gpio[i], sizeof(s->gpio[i]),
-                              TYPE_IMX_GPIO);
+        object_initialize_child(obj, name, &s->gpio[i], TYPE_IMX_GPIO);
     }
 
     for (i = 0; i < FSL_IMX6_NUM_ESDHCS; i++) {
         snprintf(name, NAME_SIZE, "sdhc%d", i + 1);
-        sysbus_init_child_obj(obj, name, &s->esdhc[i], sizeof(s->esdhc[i]),
-                              TYPE_IMX_USDHC);
+        object_initialize_child(obj, name, &s->esdhc[i], TYPE_IMX_USDHC);
     }
 
     for (i = 0; i < FSL_IMX6_NUM_USB_PHYS; i++) {
         snprintf(name, NAME_SIZE, "usbphy%d", i);
-        sysbus_init_child_obj(obj, name, &s->usbphy[i], sizeof(s->usbphy[i]),
-                              TYPE_IMX_USBPHY);
+        object_initialize_child(obj, name, &s->usbphy[i], TYPE_IMX_USBPHY);
     }
     for (i = 0; i < FSL_IMX6_NUM_USBS; i++) {
         snprintf(name, NAME_SIZE, "usb%d", i);
-        sysbus_init_child_obj(obj, name, &s->usb[i], sizeof(s->usb[i]),
-                              TYPE_CHIPIDEA);
+        object_initialize_child(obj, name, &s->usb[i], TYPE_CHIPIDEA);
     }
 
     for (i = 0; i < FSL_IMX6_NUM_ECSPIS; i++) {
         snprintf(name, NAME_SIZE, "spi%d", i + 1);
-        sysbus_init_child_obj(obj, name, &s->spi[i], sizeof(s->spi[i]),
-                              TYPE_IMX_SPI);
+        object_initialize_child(obj, name, &s->spi[i], TYPE_IMX_SPI);
     }
     for (i = 0; i < FSL_IMX6_NUM_WDTS; i++) {
         snprintf(name, NAME_SIZE, "wdt%d", i);
-        sysbus_init_child_obj(obj, name, &s->wdt[i], sizeof(s->wdt[i]),
-                              TYPE_IMX2_WDT);
+        object_initialize_child(obj, name, &s->wdt[i], TYPE_IMX2_WDT);
     }
 
 
-    sysbus_init_child_obj(obj, "eth", &s->eth, sizeof(s->eth), TYPE_IMX_ENET);
+    object_initialize_child(obj, "eth", &s->eth, TYPE_IMX_ENET);
 }
 
 static void fsl_imx6_realize(DeviceState *dev, Error **errp)
@@ -154,7 +144,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                             FSL_IMX6_MAX_IRQ + GIC_INTERNAL, "num-irq",
                             &error_abort);
 
-    object_property_set_bool(OBJECT(&s->a9mpcore), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->a9mpcore), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -168,14 +158,14 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(DEVICE(&s->cpu[i]), ARM_CPU_FIQ));
     }
 
-    object_property_set_bool(OBJECT(&s->ccm), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->ccm), &err);
     if (err) {
         error_propagate(errp, err);
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccm), 0, FSL_IMX6_CCM_ADDR);
 
-    object_property_set_bool(OBJECT(&s->src), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->src), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -197,7 +187,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
         qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
 
-        object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -211,7 +201,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
     s->gpt.ccm = IMX_CCM(&s->ccm);
 
-    object_property_set_bool(OBJECT(&s->gpt), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->gpt), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -234,7 +224,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
         s->epit[i].ccm = IMX_CCM(&s->ccm);
 
-        object_property_set_bool(OBJECT(&s->epit[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -257,7 +247,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
             { FSL_IMX6_I2C3_ADDR, FSL_IMX6_I2C3_IRQ }
         };
 
-        object_property_set_bool(OBJECT(&s->i2c[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -317,7 +307,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                  &error_abort);
         object_property_set_bool(OBJECT(&s->gpio[i]), true, "has-upper-pin-irq",
                                  &error_abort);
-        object_property_set_bool(OBJECT(&s->gpio[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -349,7 +339,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                  &err);
         object_property_set_uint(OBJECT(&s->esdhc[i]), IMX6_ESDHC_CAPABILITIES,
                                  "capareg", &err);
-        object_property_set_bool(OBJECT(&s->esdhc[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -362,8 +352,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
     /* USB */
     for (i = 0; i < FSL_IMX6_NUM_USB_PHYS; i++) {
-        object_property_set_bool(OBJECT(&s->usbphy[i]), true, "realized",
-                                 &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->usbphy[i]), &error_abort);
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usbphy[i]), 0,
                         FSL_IMX6_USBPHY1_ADDR + i * 0x1000);
     }
@@ -375,8 +364,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
             FSL_IMX6_USB_HOST3_IRQ,
         };
 
-        object_property_set_bool(OBJECT(&s->usb[i]), true, "realized",
-                                 &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->usb[i]), &error_abort);
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usb[i]), 0,
                         FSL_IMX6_USBOH3_USB_ADDR + i * 0x200);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->usb[i]), 0,
@@ -398,7 +386,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         };
 
         /* Initialize the SPI */
-        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -411,7 +399,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
     }
 
     qdev_set_nic_properties(DEVICE(&s->eth), &nd_table[0]);
-    object_property_set_bool(OBJECT(&s->eth), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->eth), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -439,8 +427,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
         object_property_set_bool(OBJECT(&s->wdt[i]), true, "pretimeout-support",
                                  &error_abort);
-        object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized",
-                                 &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, FSL_IMX6_WDOGn_ADDR[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[i]), 0,
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 491f1b7f73..72142cc2b6 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -40,44 +40,40 @@ static void fsl_imx6ul_init(Object *obj)
     /*
      * A7MPCORE
      */
-    sysbus_init_child_obj(obj, "a7mpcore", &s->a7mpcore, sizeof(s->a7mpcore),
-                          TYPE_A15MPCORE_PRIV);
+    object_initialize_child(obj, "a7mpcore", &s->a7mpcore,
+                            TYPE_A15MPCORE_PRIV);
 
     /*
      * CCM
      */
-    sysbus_init_child_obj(obj, "ccm", &s->ccm, sizeof(s->ccm), TYPE_IMX6UL_CCM);
+    object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX6UL_CCM);
 
     /*
      * SRC
      */
-    sysbus_init_child_obj(obj, "src", &s->src, sizeof(s->src), TYPE_IMX6_SRC);
+    object_initialize_child(obj, "src", &s->src, TYPE_IMX6_SRC);
 
     /*
      * GPCv2
      */
-    sysbus_init_child_obj(obj, "gpcv2", &s->gpcv2, sizeof(s->gpcv2),
-                          TYPE_IMX_GPCV2);
+    object_initialize_child(obj, "gpcv2", &s->gpcv2, TYPE_IMX_GPCV2);
 
     /*
      * SNVS
      */
-    sysbus_init_child_obj(obj, "snvs", &s->snvs, sizeof(s->snvs),
-                          TYPE_IMX7_SNVS);
+    object_initialize_child(obj, "snvs", &s->snvs, TYPE_IMX7_SNVS);
 
     /*
      * GPR
      */
-    sysbus_init_child_obj(obj, "gpr", &s->gpr, sizeof(s->gpr),
-                          TYPE_IMX7_GPR);
+    object_initialize_child(obj, "gpr", &s->gpr, TYPE_IMX7_GPR);
 
     /*
      * GPIOs 1 to 5
      */
     for (i = 0; i < FSL_IMX6UL_NUM_GPIOS; i++) {
         snprintf(name, NAME_SIZE, "gpio%d", i);
-        sysbus_init_child_obj(obj, name, &s->gpio[i], sizeof(s->gpio[i]),
-                              TYPE_IMX_GPIO);
+        object_initialize_child(obj, name, &s->gpio[i], TYPE_IMX_GPIO);
     }
 
     /*
@@ -85,8 +81,7 @@ static void fsl_imx6ul_init(Object *obj)
      */
     for (i = 0; i < FSL_IMX6UL_NUM_GPTS; i++) {
         snprintf(name, NAME_SIZE, "gpt%d", i);
-        sysbus_init_child_obj(obj, name, &s->gpt[i], sizeof(s->gpt[i]),
-                              TYPE_IMX7_GPT);
+        object_initialize_child(obj, name, &s->gpt[i], TYPE_IMX7_GPT);
     }
 
     /*
@@ -94,8 +89,7 @@ static void fsl_imx6ul_init(Object *obj)
      */
     for (i = 0; i < FSL_IMX6UL_NUM_EPITS; i++) {
         snprintf(name, NAME_SIZE, "epit%d", i + 1);
-        sysbus_init_child_obj(obj, name, &s->epit[i], sizeof(s->epit[i]),
-                              TYPE_IMX_EPIT);
+        object_initialize_child(obj, name, &s->epit[i], TYPE_IMX_EPIT);
     }
 
     /*
@@ -103,8 +97,7 @@ static void fsl_imx6ul_init(Object *obj)
      */
     for (i = 0; i < FSL_IMX6UL_NUM_ECSPIS; i++) {
         snprintf(name, NAME_SIZE, "spi%d", i + 1);
-        sysbus_init_child_obj(obj, name, &s->spi[i], sizeof(s->spi[i]),
-                              TYPE_IMX_SPI);
+        object_initialize_child(obj, name, &s->spi[i], TYPE_IMX_SPI);
     }
 
     /*
@@ -112,8 +105,7 @@ static void fsl_imx6ul_init(Object *obj)
      */
     for (i = 0; i < FSL_IMX6UL_NUM_I2CS; i++) {
         snprintf(name, NAME_SIZE, "i2c%d", i + 1);
-        sysbus_init_child_obj(obj, name, &s->i2c[i], sizeof(s->i2c[i]),
-                              TYPE_IMX_I2C);
+        object_initialize_child(obj, name, &s->i2c[i], TYPE_IMX_I2C);
     }
 
     /*
@@ -121,8 +113,7 @@ static void fsl_imx6ul_init(Object *obj)
      */
     for (i = 0; i < FSL_IMX6UL_NUM_UARTS; i++) {
         snprintf(name, NAME_SIZE, "uart%d", i);
-        sysbus_init_child_obj(obj, name, &s->uart[i], sizeof(s->uart[i]),
-                              TYPE_IMX_SERIAL);
+        object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
     }
 
     /*
@@ -130,20 +121,17 @@ static void fsl_imx6ul_init(Object *obj)
      */
     for (i = 0; i < FSL_IMX6UL_NUM_ETHS; i++) {
         snprintf(name, NAME_SIZE, "eth%d", i);
-        sysbus_init_child_obj(obj, name, &s->eth[i], sizeof(s->eth[i]),
-                              TYPE_IMX_ENET);
+        object_initialize_child(obj, name, &s->eth[i], TYPE_IMX_ENET);
     }
 
     /* USB */
     for (i = 0; i < FSL_IMX6UL_NUM_USB_PHYS; i++) {
         snprintf(name, NAME_SIZE, "usbphy%d", i);
-        sysbus_init_child_obj(obj, name, &s->usbphy[i], sizeof(s->usbphy[i]),
-                              TYPE_IMX_USBPHY);
+        object_initialize_child(obj, name, &s->usbphy[i], TYPE_IMX_USBPHY);
     }
     for (i = 0; i < FSL_IMX6UL_NUM_USBS; i++) {
         snprintf(name, NAME_SIZE, "usb%d", i);
-        sysbus_init_child_obj(obj, name, &s->usb[i], sizeof(s->usb[i]),
-                              TYPE_CHIPIDEA);
+        object_initialize_child(obj, name, &s->usb[i], TYPE_CHIPIDEA);
     }
 
     /*
@@ -151,8 +139,7 @@ static void fsl_imx6ul_init(Object *obj)
      */
     for (i = 0; i < FSL_IMX6UL_NUM_USDHCS; i++) {
         snprintf(name, NAME_SIZE, "usdhc%d", i);
-        sysbus_init_child_obj(obj, name, &s->usdhc[i], sizeof(s->usdhc[i]),
-                              TYPE_IMX_USDHC);
+        object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
     }
 
     /*
@@ -160,8 +147,7 @@ static void fsl_imx6ul_init(Object *obj)
      */
     for (i = 0; i < FSL_IMX6UL_NUM_WDTS; i++) {
         snprintf(name, NAME_SIZE, "wdt%d", i);
-        sysbus_init_child_obj(obj, name, &s->wdt[i], sizeof(s->wdt[i]),
-                              TYPE_IMX2_WDT);
+        object_initialize_child(obj, name, &s->wdt[i], TYPE_IMX2_WDT);
     }
 }
 
@@ -192,8 +178,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     object_property_set_int(OBJECT(&s->a7mpcore),
                             FSL_IMX6UL_MAX_IRQ + GIC_INTERNAL,
                             "num-irq", &error_abort);
-    object_property_set_bool(OBJECT(&s->a7mpcore), true, "realized",
-                             &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->a7mpcore), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->a7mpcore), 0, FSL_IMX6UL_A7MPCORE_ADDR);
 
     sbd = SYS_BUS_DEVICE(&s->a7mpcore);
@@ -225,8 +210,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
         };
 
         s->gpt[i].ccm = IMX_CCM(&s->ccm);
-        object_property_set_bool(OBJECT(&s->gpt[i]), true, "realized",
-                                 &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->gpt[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpt[i]), 0,
                         FSL_IMX6UL_GPTn_ADDR[i]);
@@ -251,8 +235,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
         };
 
         s->epit[i].ccm = IMX_CCM(&s->ccm);
-        object_property_set_bool(OBJECT(&s->epit[i]), true, "realized",
-                                 &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->epit[i]), 0,
                         FSL_IMX6UL_EPITn_ADDR[i]);
@@ -290,8 +273,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
             FSL_IMX6UL_GPIO5_HIGH_IRQ,
         };
 
-        object_property_set_bool(OBJECT(&s->gpio[i]), true, "realized",
-                                 &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0,
                         FSL_IMX6UL_GPIOn_ADDR[i]);
@@ -321,20 +303,19 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     /*
      * CCM
      */
-    object_property_set_bool(OBJECT(&s->ccm), true, "realized", &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->ccm), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccm), 0, FSL_IMX6UL_CCM_ADDR);
 
     /*
      * SRC
      */
-    object_property_set_bool(OBJECT(&s->src), true, "realized", &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->src), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->src), 0, FSL_IMX6UL_SRC_ADDR);
 
     /*
      * GPCv2
      */
-    object_property_set_bool(OBJECT(&s->gpcv2), true,
-                             "realized", &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->gpcv2), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpcv2), 0, FSL_IMX6UL_GPC_ADDR);
 
     /* Initialize all ECSPI */
@@ -354,8 +335,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
         };
 
         /* Initialize the SPI */
-        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized",
-                                 &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0,
                         FSL_IMX6UL_SPIn_ADDR[i]);
@@ -383,8 +363,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
             FSL_IMX6UL_I2C4_IRQ,
         };
 
-        object_property_set_bool(OBJECT(&s->i2c[i]), true, "realized",
-                                 &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), &error_abort);
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c[i]), 0, FSL_IMX6UL_I2Cn_ADDR[i]);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[i]), 0,
@@ -420,8 +399,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
 
         qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
 
-        object_property_set_bool(OBJECT(&s->uart[i]), true, "realized",
-                                 &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0,
                         FSL_IMX6UL_UARTn_ADDR[i]);
@@ -454,8 +432,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
                                  FSL_IMX6UL_ETH_NUM_TX_RINGS,
                                  "tx-ring-num", &error_abort);
         qdev_set_nic_properties(DEVICE(&s->eth[i]), &nd_table[i]);
-        object_property_set_bool(OBJECT(&s->eth[i]), true, "realized",
-                                 &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->eth[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->eth[i]), 0,
                         FSL_IMX6UL_ENETn_ADDR[i]);
@@ -471,8 +448,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
 
     /* USB */
     for (i = 0; i < FSL_IMX6UL_NUM_USB_PHYS; i++) {
-        object_property_set_bool(OBJECT(&s->usbphy[i]), true, "realized",
-                                 &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->usbphy[i]), &error_abort);
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usbphy[i]), 0,
                         FSL_IMX6UL_USBPHY1_ADDR + i * 0x1000);
     }
@@ -482,8 +458,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
             FSL_IMX6UL_USB1_IRQ,
             FSL_IMX6UL_USB2_IRQ,
         };
-        object_property_set_bool(OBJECT(&s->usb[i]), true, "realized",
-                                 &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->usb[i]), &error_abort);
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usb[i]), 0,
                         FSL_IMX6UL_USBO2_USB_ADDR + i * 0x200);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->usb[i]), 0,
@@ -505,8 +480,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
             FSL_IMX6UL_USDHC2_IRQ,
         };
 
-        object_property_set_bool(OBJECT(&s->usdhc[i]), true, "realized",
-                                 &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->usdhc[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
                         FSL_IMX6UL_USDHCn_ADDR[i]);
@@ -519,7 +493,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     /*
      * SNVS
      */
-    object_property_set_bool(OBJECT(&s->snvs), true, "realized", &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->snvs), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->snvs), 0, FSL_IMX6UL_SNVS_HP_ADDR);
 
     /*
@@ -539,8 +513,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
 
         object_property_set_bool(OBJECT(&s->wdt[i]), true, "pretimeout-support",
                                  &error_abort);
-        object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized",
-                                 &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0,
                         FSL_IMX6UL_WDOGn_ADDR[i]);
@@ -552,8 +525,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     /*
      * GPR
      */
-    object_property_set_bool(OBJECT(&s->gpr), true, "realized",
-                             &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->gpr), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpr), 0, FSL_IMX6UL_IOMUXC_GPR_ADDR);
 
     /*
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 5cf2b7a808..aa7051307d 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -45,16 +45,15 @@ static void fsl_imx7_init(Object *obj)
     /*
      * A7MPCORE
      */
-    sysbus_init_child_obj(obj, "a7mpcore", &s->a7mpcore, sizeof(s->a7mpcore),
-                          TYPE_A15MPCORE_PRIV);
+    object_initialize_child(obj, "a7mpcore", &s->a7mpcore,
+                            TYPE_A15MPCORE_PRIV);
 
     /*
      * GPIOs 1 to 7
      */
     for (i = 0; i < FSL_IMX7_NUM_GPIOS; i++) {
         snprintf(name, NAME_SIZE, "gpio%d", i);
-        sysbus_init_child_obj(obj, name, &s->gpio[i], sizeof(s->gpio[i]),
-                          TYPE_IMX_GPIO);
+        object_initialize_child(obj, name, &s->gpio[i], TYPE_IMX_GPIO);
     }
 
     /*
@@ -62,38 +61,33 @@ static void fsl_imx7_init(Object *obj)
      */
     for (i = 0; i < FSL_IMX7_NUM_GPTS; i++) {
         snprintf(name, NAME_SIZE, "gpt%d", i);
-        sysbus_init_child_obj(obj, name, &s->gpt[i], sizeof(s->gpt[i]),
-                              TYPE_IMX7_GPT);
+        object_initialize_child(obj, name, &s->gpt[i], TYPE_IMX7_GPT);
     }
 
     /*
      * CCM
      */
-    sysbus_init_child_obj(obj, "ccm", &s->ccm, sizeof(s->ccm), TYPE_IMX7_CCM);
+    object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX7_CCM);
 
     /*
      * Analog
      */
-    sysbus_init_child_obj(obj, "analog", &s->analog, sizeof(s->analog),
-                          TYPE_IMX7_ANALOG);
+    object_initialize_child(obj, "analog", &s->analog, TYPE_IMX7_ANALOG);
 
     /*
      * GPCv2
      */
-    sysbus_init_child_obj(obj, "gpcv2", &s->gpcv2, sizeof(s->gpcv2),
-                          TYPE_IMX_GPCV2);
+    object_initialize_child(obj, "gpcv2", &s->gpcv2, TYPE_IMX_GPCV2);
 
     for (i = 0; i < FSL_IMX7_NUM_ECSPIS; i++) {
         snprintf(name, NAME_SIZE, "spi%d", i + 1);
-        sysbus_init_child_obj(obj, name, &s->spi[i], sizeof(s->spi[i]),
-                              TYPE_IMX_SPI);
+        object_initialize_child(obj, name, &s->spi[i], TYPE_IMX_SPI);
     }
 
 
     for (i = 0; i < FSL_IMX7_NUM_I2CS; i++) {
         snprintf(name, NAME_SIZE, "i2c%d", i + 1);
-        sysbus_init_child_obj(obj, name, &s->i2c[i], sizeof(s->i2c[i]),
-                              TYPE_IMX_I2C);
+        object_initialize_child(obj, name, &s->i2c[i], TYPE_IMX_I2C);
     }
 
     /*
@@ -101,8 +95,7 @@ static void fsl_imx7_init(Object *obj)
      */
     for (i = 0; i < FSL_IMX7_NUM_UARTS; i++) {
             snprintf(name, NAME_SIZE, "uart%d", i);
-            sysbus_init_child_obj(obj, name, &s->uart[i], sizeof(s->uart[i]),
-                                  TYPE_IMX_SERIAL);
+            object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
     }
 
     /*
@@ -110,8 +103,7 @@ static void fsl_imx7_init(Object *obj)
      */
     for (i = 0; i < FSL_IMX7_NUM_ETHS; i++) {
             snprintf(name, NAME_SIZE, "eth%d", i);
-            sysbus_init_child_obj(obj, name, &s->eth[i], sizeof(s->eth[i]),
-                                  TYPE_IMX_ENET);
+            object_initialize_child(obj, name, &s->eth[i], TYPE_IMX_ENET);
     }
 
     /*
@@ -119,37 +111,32 @@ static void fsl_imx7_init(Object *obj)
      */
     for (i = 0; i < FSL_IMX7_NUM_USDHCS; i++) {
             snprintf(name, NAME_SIZE, "usdhc%d", i);
-            sysbus_init_child_obj(obj, name, &s->usdhc[i], sizeof(s->usdhc[i]),
-                              TYPE_IMX_USDHC);
+            object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
     }
 
     /*
      * SNVS
      */
-    sysbus_init_child_obj(obj, "snvs", &s->snvs, sizeof(s->snvs),
-                          TYPE_IMX7_SNVS);
+    object_initialize_child(obj, "snvs", &s->snvs, TYPE_IMX7_SNVS);
 
     /*
      * Watchdog
      */
     for (i = 0; i < FSL_IMX7_NUM_WDTS; i++) {
             snprintf(name, NAME_SIZE, "wdt%d", i);
-            sysbus_init_child_obj(obj, name, &s->wdt[i], sizeof(s->wdt[i]),
-                                  TYPE_IMX2_WDT);
+            object_initialize_child(obj, name, &s->wdt[i], TYPE_IMX2_WDT);
     }
 
     /*
      * GPR
      */
-    sysbus_init_child_obj(obj, "gpr", &s->gpr, sizeof(s->gpr), TYPE_IMX7_GPR);
+    object_initialize_child(obj, "gpr", &s->gpr, TYPE_IMX7_GPR);
 
-    sysbus_init_child_obj(obj, "pcie", &s->pcie, sizeof(s->pcie),
-                          TYPE_DESIGNWARE_PCIE_HOST);
+    object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
 
     for (i = 0; i < FSL_IMX7_NUM_USBS; i++) {
         snprintf(name, NAME_SIZE, "usb%d", i);
-        sysbus_init_child_obj(obj, name, &s->usb[i], sizeof(s->usb[i]),
-                              TYPE_CHIPIDEA);
+        object_initialize_child(obj, name, &s->usb[i], TYPE_CHIPIDEA);
     }
 }
 
@@ -199,8 +186,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
                             FSL_IMX7_MAX_IRQ + GIC_INTERNAL,
                             "num-irq", &error_abort);
 
-    object_property_set_bool(OBJECT(&s->a7mpcore), true, "realized",
-                             &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->a7mpcore), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->a7mpcore), 0, FSL_IMX7_A7MPCORE_ADDR);
 
     for (i = 0; i < smp_cpus; i++) {
@@ -235,8 +221,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
         };
 
         s->gpt[i].ccm = IMX_CCM(&s->ccm);
-        object_property_set_bool(OBJECT(&s->gpt[i]), true, "realized",
-                                 &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->gpt[i]), &error_abort);
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpt[i]), 0, FSL_IMX7_GPTn_ADDR[i]);
     }
 
@@ -251,8 +236,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
             FSL_IMX7_GPIO7_ADDR,
         };
 
-        object_property_set_bool(OBJECT(&s->gpio[i]), true, "realized",
-                                 &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), &error_abort);
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0, FSL_IMX7_GPIOn_ADDR[i]);
     }
 
@@ -273,21 +257,19 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     /*
      * CCM
      */
-    object_property_set_bool(OBJECT(&s->ccm), true, "realized", &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->ccm), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccm), 0, FSL_IMX7_CCM_ADDR);
 
     /*
      * Analog
      */
-    object_property_set_bool(OBJECT(&s->analog), true, "realized",
-                             &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->analog), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->analog), 0, FSL_IMX7_ANALOG_ADDR);
 
     /*
      * GPCv2
      */
-    object_property_set_bool(OBJECT(&s->gpcv2), true,
-                             "realized", &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->gpcv2), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpcv2), 0, FSL_IMX7_GPC_ADDR);
 
     /* Initialize all ECSPI */
@@ -307,8 +289,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
         };
 
         /* Initialize the SPI */
-        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized",
-                                 &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &error_abort);
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0,
                         FSL_IMX7_SPIn_ADDR[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
@@ -331,8 +312,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
             FSL_IMX7_I2C4_IRQ,
         };
 
-        object_property_set_bool(OBJECT(&s->i2c[i]), true, "realized",
-                                 &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), &error_abort);
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c[i]), 0, FSL_IMX7_I2Cn_ADDR[i]);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[i]), 0,
@@ -367,8 +347,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
 
         qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
 
-        object_property_set_bool(OBJECT(&s->uart[i]), true, "realized",
-                                 &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, FSL_IMX7_UARTn_ADDR[i]);
 
@@ -388,8 +367,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
         object_property_set_uint(OBJECT(&s->eth[i]), FSL_IMX7_ETH_NUM_TX_RINGS,
                                  "tx-ring-num", &error_abort);
         qdev_set_nic_properties(DEVICE(&s->eth[i]), &nd_table[i]);
-        object_property_set_bool(OBJECT(&s->eth[i]), true, "realized",
-                                 &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->eth[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->eth[i]), 0, FSL_IMX7_ENETn_ADDR[i]);
 
@@ -415,8 +393,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
             FSL_IMX7_USDHC3_IRQ,
         };
 
-        object_property_set_bool(OBJECT(&s->usdhc[i]), true, "realized",
-                                 &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->usdhc[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
                         FSL_IMX7_USDHCn_ADDR[i]);
@@ -428,7 +405,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     /*
      * SNVS
      */
-    object_property_set_bool(OBJECT(&s->snvs), true, "realized", &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->snvs), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->snvs), 0, FSL_IMX7_SNVS_ADDR);
 
     /*
@@ -455,8 +432,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
 
         object_property_set_bool(OBJECT(&s->wdt[i]), true, "pretimeout-support",
                                  &error_abort);
-        object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized",
-                                 &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, FSL_IMX7_WDOGn_ADDR[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[i]), 0,
@@ -494,12 +470,10 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("ocotp", FSL_IMX7_OCOTP_ADDR,
                                 FSL_IMX7_OCOTP_SIZE);
 
-    object_property_set_bool(OBJECT(&s->gpr), true, "realized",
-                             &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->gpr), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpr), 0, FSL_IMX7_GPR_ADDR);
 
-    object_property_set_bool(OBJECT(&s->pcie), true,
-                             "realized", &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->pcie), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcie), 0, FSL_IMX7_PCIE_REG_ADDR);
 
     irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_PCI_INTA_IRQ);
@@ -531,8 +505,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
             FSL_IMX7_USB3_IRQ,
         };
 
-        object_property_set_bool(OBJECT(&s->usb[i]), true, "realized",
-                                 &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->usb[i]), &error_abort);
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usb[i]), 0,
                         FSL_IMX7_USBn_ADDR[i]);
 
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index f4579e5a08..3235c76194 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -71,22 +71,17 @@ static void m2sxxx_soc_initfn(Object *obj)
     MSF2State *s = MSF2_SOC(obj);
     int i;
 
-    sysbus_init_child_obj(obj, "armv7m", &s->armv7m, sizeof(s->armv7m),
-                          TYPE_ARMV7M);
+    object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
 
-    sysbus_init_child_obj(obj, "sysreg", &s->sysreg, sizeof(s->sysreg),
-                          TYPE_MSF2_SYSREG);
+    object_initialize_child(obj, "sysreg", &s->sysreg, TYPE_MSF2_SYSREG);
 
-    sysbus_init_child_obj(obj, "timer", &s->timer, sizeof(s->timer),
-                          TYPE_MSS_TIMER);
+    object_initialize_child(obj, "timer", &s->timer, TYPE_MSS_TIMER);
 
     for (i = 0; i < MSF2_NUM_SPIS; i++) {
-        sysbus_init_child_obj(obj, "spi[*]", &s->spi[i], sizeof(s->spi[i]),
-                          TYPE_MSS_SPI);
+        object_initialize_child(obj, "spi[*]", &s->spi[i], TYPE_MSS_SPI);
     }
 
-    sysbus_init_child_obj(obj, "emac", &s->emac, sizeof(s->emac),
-                          TYPE_MSS_EMAC);
+    object_initialize_child(obj, "emac", &s->emac, TYPE_MSS_EMAC);
     if (nd_table[0].used) {
         qemu_check_nic_model(&nd_table[0], TYPE_MSS_EMAC);
         qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
@@ -130,7 +125,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memory()),
                                      "memory", &error_abort);
-    object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
@@ -158,7 +153,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     dev = DEVICE(&s->timer);
     /* APB0 clock is the timer input clock */
     qdev_prop_set_uint32(dev, "clock-frequency", s->m3clk / s->apb0div);
-    object_property_set_bool(OBJECT(&s->timer), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->timer), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
@@ -173,7 +168,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     dev = DEVICE(&s->sysreg);
     qdev_prop_set_uint32(dev, "apb0divisor", s->apb0div);
     qdev_prop_set_uint32(dev, "apb1divisor", s->apb1div);
-    object_property_set_bool(OBJECT(&s->sysreg), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->sysreg), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
@@ -184,7 +179,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     for (i = 0; i < MSF2_NUM_SPIS; i++) {
         gchar *bus_name;
 
-        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
         if (err != NULL) {
             error_propagate(errp, err);
             return;
@@ -204,7 +199,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     dev = DEVICE(&s->emac);
     object_property_set_link(OBJECT(&s->emac), OBJECT(get_system_memory()),
                              "ahb-bus", &error_abort);
-    object_property_set_bool(OBJECT(&s->emac), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->emac), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index c278827b09..5a8961ddbb 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -71,7 +71,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->cpu), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -88,7 +88,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion(&s->container, NRF51_SRAM_BASE, &s->sram);
 
     /* UART */
-    object_property_set_bool(OBJECT(&s->uart), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->uart), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -100,7 +100,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
                        BASE_TO_IRQ(NRF51_UART_BASE)));
 
     /* RNG */
-    object_property_set_bool(OBJECT(&s->rng), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->rng), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -120,7 +120,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
-    object_property_set_bool(OBJECT(&s->nvm), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->nvm), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -136,7 +136,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion_overlap(&s->container, NRF51_FLASH_BASE, mr, 0);
 
     /* GPIO */
-    object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -155,7 +155,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
             error_propagate(errp, err);
             return;
         }
-        object_property_set_bool(OBJECT(&s->timer[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -189,27 +189,23 @@ static void nrf51_soc_init(Object *obj)
 
     memory_region_init(&s->container, obj, "nrf51-container", UINT64_MAX);
 
-    sysbus_init_child_obj(OBJECT(s), "armv6m", &s->cpu, sizeof(s->cpu),
-                          TYPE_ARMV7M);
+    object_initialize_child(OBJECT(s), "armv6m", &s->cpu, TYPE_ARMV7M);
     qdev_prop_set_string(DEVICE(&s->cpu), "cpu-type",
                          ARM_CPU_TYPE_NAME("cortex-m0"));
     qdev_prop_set_uint32(DEVICE(&s->cpu), "num-irq", 32);
 
-    sysbus_init_child_obj(obj, "uart", &s->uart, sizeof(s->uart),
-                           TYPE_NRF51_UART);
+    object_initialize_child(obj, "uart", &s->uart, TYPE_NRF51_UART);
     object_property_add_alias(obj, "serial0", OBJECT(&s->uart), "chardev");
 
-    sysbus_init_child_obj(obj, "rng", &s->rng, sizeof(s->rng),
-                           TYPE_NRF51_RNG);
+    object_initialize_child(obj, "rng", &s->rng, TYPE_NRF51_RNG);
 
-    sysbus_init_child_obj(obj, "nvm", &s->nvm, sizeof(s->nvm), TYPE_NRF51_NVM);
+    object_initialize_child(obj, "nvm", &s->nvm, TYPE_NRF51_NVM);
 
-    sysbus_init_child_obj(obj, "gpio", &s->gpio, sizeof(s->gpio),
-                          TYPE_NRF51_GPIO);
+    object_initialize_child(obj, "gpio", &s->gpio, TYPE_NRF51_GPIO);
 
     for (i = 0; i < NRF51_NUM_TIMERS; i++) {
-        sysbus_init_child_obj(obj, "timer[*]", &s->timer[i],
-                              sizeof(s->timer[i]), TYPE_NRF51_TIMER);
+        object_initialize_child(obj, "timer[*]", &s->timer[i],
+                                TYPE_NRF51_TIMER);
 
     }
 }
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index 118c342559..e2c3479702 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -51,32 +51,28 @@ static void stm32f205_soc_initfn(Object *obj)
     STM32F205State *s = STM32F205_SOC(obj);
     int i;
 
-    sysbus_init_child_obj(obj, "armv7m", &s->armv7m, sizeof(s->armv7m),
-                          TYPE_ARMV7M);
+    object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
 
-    sysbus_init_child_obj(obj, "syscfg", &s->syscfg, sizeof(s->syscfg),
-                          TYPE_STM32F2XX_SYSCFG);
+    object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_STM32F2XX_SYSCFG);
 
     for (i = 0; i < STM_NUM_USARTS; i++) {
-        sysbus_init_child_obj(obj, "usart[*]", &s->usart[i],
-                              sizeof(s->usart[i]), TYPE_STM32F2XX_USART);
+        object_initialize_child(obj, "usart[*]", &s->usart[i],
+                                TYPE_STM32F2XX_USART);
     }
 
     for (i = 0; i < STM_NUM_TIMERS; i++) {
-        sysbus_init_child_obj(obj, "timer[*]", &s->timer[i],
-                              sizeof(s->timer[i]), TYPE_STM32F2XX_TIMER);
+        object_initialize_child(obj, "timer[*]", &s->timer[i],
+                                TYPE_STM32F2XX_TIMER);
     }
 
     s->adc_irqs = OR_IRQ(object_new(TYPE_OR_IRQ));
 
     for (i = 0; i < STM_NUM_ADCS; i++) {
-        sysbus_init_child_obj(obj, "adc[*]", &s->adc[i], sizeof(s->adc[i]),
-                              TYPE_STM32F2XX_ADC);
+        object_initialize_child(obj, "adc[*]", &s->adc[i], TYPE_STM32F2XX_ADC);
     }
 
     for (i = 0; i < STM_NUM_SPIS; i++) {
-        sysbus_init_child_obj(obj, "spi[*]", &s->spi[i], sizeof(s->spi[i]),
-                              TYPE_STM32F2XX_SPI);
+        object_initialize_child(obj, "spi[*]", &s->spi[i], TYPE_STM32F2XX_SPI);
     }
 }
 
@@ -111,7 +107,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memory()),
                                      "memory", &error_abort);
-    object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
@@ -119,7 +115,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
 
     /* System configuration controller */
     dev = DEVICE(&s->syscfg);
-    object_property_set_bool(OBJECT(&s->syscfg), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->syscfg), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
@@ -132,7 +128,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     for (i = 0; i < STM_NUM_USARTS; i++) {
         dev = DEVICE(&(s->usart[i]));
         qdev_prop_set_chr(dev, "chardev", serial_hd(i));
-        object_property_set_bool(OBJECT(&s->usart[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->usart[i]), &err);
         if (err != NULL) {
             error_propagate(errp, err);
             return;
@@ -146,7 +142,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     for (i = 0; i < STM_NUM_TIMERS; i++) {
         dev = DEVICE(&(s->timer[i]));
         qdev_prop_set_uint64(dev, "clock-frequency", 1000000000);
-        object_property_set_bool(OBJECT(&s->timer[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), &err);
         if (err != NULL) {
             error_propagate(errp, err);
             return;
@@ -169,7 +165,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
 
     for (i = 0; i < STM_NUM_ADCS; i++) {
         dev = DEVICE(&(s->adc[i]));
-        object_property_set_bool(OBJECT(&s->adc[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->adc[i]), &err);
         if (err != NULL) {
             error_propagate(errp, err);
             return;
@@ -183,7 +179,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     /* SPI 1 and 2 */
     for (i = 0; i < STM_NUM_SPIS; i++) {
         dev = DEVICE(&(s->spi[i]));
-        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
         if (err != NULL) {
             error_propagate(errp, err);
             return;
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index 33a83bd1d4..9f7838a4a3 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -57,34 +57,29 @@ static void stm32f405_soc_initfn(Object *obj)
     STM32F405State *s = STM32F405_SOC(obj);
     int i;
 
-    sysbus_init_child_obj(obj, "armv7m", &s->armv7m, sizeof(s->armv7m),
-                          TYPE_ARMV7M);
+    object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
 
-    sysbus_init_child_obj(obj, "syscfg", &s->syscfg, sizeof(s->syscfg),
-                          TYPE_STM32F4XX_SYSCFG);
+    object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_STM32F4XX_SYSCFG);
 
     for (i = 0; i < STM_NUM_USARTS; i++) {
-        sysbus_init_child_obj(obj, "usart[*]", &s->usart[i],
-                              sizeof(s->usart[i]), TYPE_STM32F2XX_USART);
+        object_initialize_child(obj, "usart[*]", &s->usart[i],
+                                TYPE_STM32F2XX_USART);
     }
 
     for (i = 0; i < STM_NUM_TIMERS; i++) {
-        sysbus_init_child_obj(obj, "timer[*]", &s->timer[i],
-                              sizeof(s->timer[i]), TYPE_STM32F2XX_TIMER);
+        object_initialize_child(obj, "timer[*]", &s->timer[i],
+                                TYPE_STM32F2XX_TIMER);
     }
 
     for (i = 0; i < STM_NUM_ADCS; i++) {
-        sysbus_init_child_obj(obj, "adc[*]", &s->adc[i], sizeof(s->adc[i]),
-                              TYPE_STM32F2XX_ADC);
+        object_initialize_child(obj, "adc[*]", &s->adc[i], TYPE_STM32F2XX_ADC);
     }
 
     for (i = 0; i < STM_NUM_SPIS; i++) {
-        sysbus_init_child_obj(obj, "spi[*]", &s->spi[i], sizeof(s->spi[i]),
-                              TYPE_STM32F2XX_SPI);
+        object_initialize_child(obj, "spi[*]", &s->spi[i], TYPE_STM32F2XX_SPI);
     }
 
-    sysbus_init_child_obj(obj, "exti", &s->exti, sizeof(s->exti),
-                          TYPE_STM32F4XX_EXTI);
+    object_initialize_child(obj, "exti", &s->exti, TYPE_STM32F4XX_EXTI);
 }
 
 static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
@@ -123,7 +118,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     object_property_set_link(OBJECT(&s->armv7m), OBJECT(system_memory),
                                      "memory", &error_abort);
-    object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
@@ -131,7 +126,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
 
     /* System configuration controller */
     dev = DEVICE(&s->syscfg);
-    object_property_set_bool(OBJECT(&s->syscfg), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->syscfg), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
@@ -144,7 +139,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     for (i = 0; i < STM_NUM_USARTS; i++) {
         dev = DEVICE(&(s->usart[i]));
         qdev_prop_set_chr(dev, "chardev", serial_hd(i));
-        object_property_set_bool(OBJECT(&s->usart[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->usart[i]), &err);
         if (err != NULL) {
             error_propagate(errp, err);
             return;
@@ -158,7 +153,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     for (i = 0; i < STM_NUM_TIMERS; i++) {
         dev = DEVICE(&(s->timer[i]));
         qdev_prop_set_uint64(dev, "clock-frequency", 1000000000);
-        object_property_set_bool(OBJECT(&s->timer[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), &err);
         if (err != NULL) {
             error_propagate(errp, err);
             return;
@@ -188,7 +183,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
 
     for (i = 0; i < STM_NUM_ADCS; i++) {
         dev = DEVICE(&(s->adc[i]));
-        object_property_set_bool(OBJECT(&s->adc[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->adc[i]), &err);
         if (err != NULL) {
             error_propagate(errp, err);
             return;
@@ -202,7 +197,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     /* SPI devices */
     for (i = 0; i < STM_NUM_SPIS; i++) {
         dev = DEVICE(&(s->spi[i]));
-        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
         if (err != NULL) {
             error_propagate(errp, err);
             return;
@@ -214,7 +209,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
 
     /* EXTI device */
     dev = DEVICE(&s->exti);
-    object_property_set_bool(OBJECT(&s->exti), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->exti), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 890139d6a2..667c11ac8d 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -237,21 +237,18 @@ static void xlnx_zynqmp_init(Object *obj)
                                 ARM_CPU_TYPE_NAME("cortex-a53"));
     }
 
-    sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic),
-                          gic_class_name());
+    object_initialize_child(obj, "gic", &s->gic, gic_class_name());
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_GEMS; i++) {
-        sysbus_init_child_obj(obj, "gem[*]", &s->gem[i], sizeof(s->gem[i]),
-                              TYPE_CADENCE_GEM);
+        object_initialize_child(obj, "gem[*]", &s->gem[i], TYPE_CADENCE_GEM);
     }
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_UARTS; i++) {
-        sysbus_init_child_obj(obj, "uart[*]", &s->uart[i], sizeof(s->uart[i]),
-                              TYPE_CADENCE_UART);
+        object_initialize_child(obj, "uart[*]", &s->uart[i],
+                                TYPE_CADENCE_UART);
     }
 
-    sysbus_init_child_obj(obj, "sata", &s->sata, sizeof(s->sata),
-                          TYPE_SYSBUS_AHCI);
+    object_initialize_child(obj, "sata", &s->sata, TYPE_SYSBUS_AHCI);
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_SDHCI; i++) {
         sysbus_init_child_obj(obj, "sdhci[*]", &s->sdhci[i],
@@ -259,32 +256,25 @@ static void xlnx_zynqmp_init(Object *obj)
     }
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_SPIS; i++) {
-        sysbus_init_child_obj(obj, "spi[*]", &s->spi[i], sizeof(s->spi[i]),
-                              TYPE_XILINX_SPIPS);
+        object_initialize_child(obj, "spi[*]", &s->spi[i], TYPE_XILINX_SPIPS);
     }
 
-    sysbus_init_child_obj(obj, "qspi", &s->qspi, sizeof(s->qspi),
-                          TYPE_XLNX_ZYNQMP_QSPIPS);
+    object_initialize_child(obj, "qspi", &s->qspi, TYPE_XLNX_ZYNQMP_QSPIPS);
 
-    sysbus_init_child_obj(obj, "xxxdp", &s->dp, sizeof(s->dp), TYPE_XLNX_DP);
+    object_initialize_child(obj, "xxxdp", &s->dp, TYPE_XLNX_DP);
 
-    sysbus_init_child_obj(obj, "dp-dma", &s->dpdma, sizeof(s->dpdma),
-                          TYPE_XLNX_DPDMA);
+    object_initialize_child(obj, "dp-dma", &s->dpdma, TYPE_XLNX_DPDMA);
 
-    sysbus_init_child_obj(obj, "ipi", &s->ipi, sizeof(s->ipi),
-                          TYPE_XLNX_ZYNQMP_IPI);
+    object_initialize_child(obj, "ipi", &s->ipi, TYPE_XLNX_ZYNQMP_IPI);
 
-    sysbus_init_child_obj(obj, "rtc", &s->rtc, sizeof(s->rtc),
-                          TYPE_XLNX_ZYNQMP_RTC);
+    object_initialize_child(obj, "rtc", &s->rtc, TYPE_XLNX_ZYNQMP_RTC);
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_GDMA_CH; i++) {
-        sysbus_init_child_obj(obj, "gdma[*]", &s->gdma[i], sizeof(s->gdma[i]),
-                              TYPE_XLNX_ZDMA);
+        object_initialize_child(obj, "gdma[*]", &s->gdma[i], TYPE_XLNX_ZDMA);
     }
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_ADMA_CH; i++) {
-        sysbus_init_child_obj(obj, "adma[*]", &s->adma[i], sizeof(s->adma[i]),
-                              TYPE_XLNX_ZDMA);
+        object_initialize_child(obj, "adma[*]", &s->adma[i], TYPE_XLNX_ZDMA);
     }
 }
 
@@ -386,7 +376,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -482,7 +472,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
                                 &error_abort);
         object_property_set_int(OBJECT(&s->gem[i]), 2, "num-priority-queues",
                                 &error_abort);
-        object_property_set_bool(OBJECT(&s->gem[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->gem[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -494,7 +484,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_UARTS; i++) {
         qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
-        object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -506,7 +496,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
 
     object_property_set_int(OBJECT(&s->sata), SATA_NUM_PORTS, "num-ports",
                             &error_abort);
-    object_property_set_bool(OBJECT(&s->sata), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->sata), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -557,7 +547,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < XLNX_ZYNQMP_NUM_SPIS; i++) {
         gchar *bus_name;
 
-        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -574,7 +564,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         g_free(bus_name);
     }
 
-    object_property_set_bool(OBJECT(&s->qspi), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->qspi), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -596,7 +586,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         g_free(target_bus);
     }
 
-    object_property_set_bool(OBJECT(&s->dp), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->dp), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -604,7 +594,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->dp), 0, DP_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->dp), 0, gic_spi[DP_IRQ]);
 
-    object_property_set_bool(OBJECT(&s->dpdma), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->dpdma), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -614,7 +604,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->dpdma), 0, DPDMA_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->dpdma), 0, gic_spi[DPDMA_IRQ]);
 
-    object_property_set_bool(OBJECT(&s->ipi), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->ipi), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -622,7 +612,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ipi), 0, IPI_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->ipi), 0, gic_spi[IPI_IRQ]);
 
-    object_property_set_bool(OBJECT(&s->rtc), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->rtc), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -636,7 +626,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
             error_propagate(errp, err);
             return;
         }
-        object_property_set_bool(OBJECT(&s->gdma[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->gdma[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -648,7 +638,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     }
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_ADMA_CH; i++) {
-        object_property_set_bool(OBJECT(&s->adma[i]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->adma[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 4f659115b6..e6085f5d44 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -42,8 +42,7 @@ static void a15mp_priv_initfn(Object *obj)
     memory_region_init(&s->container, obj, "a15mp-priv-container", 0x8000);
     sysbus_init_mmio(sbd, &s->container);
 
-    sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic),
-                          gic_class_name());
+    object_initialize_child(obj, "gic", &s->gic, gic_class_name());
     qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 2);
 }
 
@@ -77,7 +76,7 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
         qdev_prop_set_bit(gicdev, "has-virtualization-extensions", has_el2);
     }
 
-    object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index b4f6a7e8a5..642363d2f4 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -32,18 +32,15 @@ static void a9mp_priv_initfn(Object *obj)
     memory_region_init(&s->container, obj, "a9mp-priv-container", 0x2000);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->container);
 
-    sysbus_init_child_obj(obj, "scu", &s->scu, sizeof(s->scu), TYPE_A9_SCU);
+    object_initialize_child(obj, "scu", &s->scu, TYPE_A9_SCU);
 
-    sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic), TYPE_ARM_GIC);
+    object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GIC);
 
-    sysbus_init_child_obj(obj, "gtimer", &s->gtimer, sizeof(s->gtimer),
-                          TYPE_A9_GTIMER);
+    object_initialize_child(obj, "gtimer", &s->gtimer, TYPE_A9_GTIMER);
 
-    sysbus_init_child_obj(obj, "mptimer", &s->mptimer, sizeof(s->mptimer),
-                          TYPE_ARM_MPTIMER);
+    object_initialize_child(obj, "mptimer", &s->mptimer, TYPE_ARM_MPTIMER);
 
-    sysbus_init_child_obj(obj, "wdt", &s->wdt, sizeof(s->wdt),
-                          TYPE_ARM_MPTIMER);
+    object_initialize_child(obj, "wdt", &s->wdt, TYPE_ARM_MPTIMER);
 }
 
 static void a9mp_priv_realize(DeviceState *dev, Error **errp)
@@ -60,7 +57,7 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
 
     scudev = DEVICE(&s->scu);
     qdev_prop_set_uint32(scudev, "num-cpu", s->num_cpu);
-    object_property_set_bool(OBJECT(&s->scu), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->scu), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
@@ -81,7 +78,7 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
         object_property_get_bool(cpuobj, "has_el3", &error_abort);
     qdev_prop_set_bit(gicdev, "has-security-extensions", has_el3);
 
-    object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
@@ -96,7 +93,7 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
 
     gtimerdev = DEVICE(&s->gtimer);
     qdev_prop_set_uint32(gtimerdev, "num-cpu", s->num_cpu);
-    object_property_set_bool(OBJECT(&s->gtimer), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->gtimer), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
@@ -105,7 +102,7 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
 
     mptimerdev = DEVICE(&s->mptimer);
     qdev_prop_set_uint32(mptimerdev, "num-cpu", s->num_cpu);
-    object_property_set_bool(OBJECT(&s->mptimer), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->mptimer), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
@@ -114,7 +111,7 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
 
     wdtdev = DEVICE(&s->wdt);
     qdev_prop_set_uint32(wdtdev, "num-cpu", s->num_cpu);
-    object_property_set_bool(OBJECT(&s->wdt), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->wdt), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
diff --git a/hw/cpu/arm11mpcore.c b/hw/cpu/arm11mpcore.c
index ab9fadb67c..a2afb992fb 100644
--- a/hw/cpu/arm11mpcore.c
+++ b/hw/cpu/arm11mpcore.c
@@ -79,7 +79,7 @@ static void mpcore_priv_realize(DeviceState *dev, Error **errp)
     Error *err = NULL;
 
     qdev_prop_set_uint32(scudev, "num-cpu", s->num_cpu);
-    object_property_set_bool(OBJECT(&s->scu), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->scu), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
@@ -91,7 +91,7 @@ static void mpcore_priv_realize(DeviceState *dev, Error **errp)
                          ARM11MPCORE_NUM_GIC_PRIORITY_BITS);
 
 
-    object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
@@ -104,14 +104,14 @@ static void mpcore_priv_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_in(dev, mpcore_priv_set_irq, s->num_irq - 32);
 
     qdev_prop_set_uint32(mptimerdev, "num-cpu", s->num_cpu);
-    object_property_set_bool(OBJECT(&s->mptimer), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->mptimer), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
     }
 
     qdev_prop_set_uint32(wdtimerdev, "num-cpu", s->num_cpu);
-    object_property_set_bool(OBJECT(&s->wdtimer), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->wdtimer), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
@@ -129,17 +129,15 @@ static void mpcore_priv_initfn(Object *obj)
                        "mpcore-priv-container", 0x2000);
     sysbus_init_mmio(sbd, &s->container);
 
-    sysbus_init_child_obj(obj, "scu", &s->scu, sizeof(s->scu), TYPE_ARM11_SCU);
+    object_initialize_child(obj, "scu", &s->scu, TYPE_ARM11_SCU);
 
-    sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic), TYPE_ARM_GIC);
+    object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GIC);
     /* Request the legacy 11MPCore GIC behaviour: */
     qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 0);
 
-    sysbus_init_child_obj(obj, "mptimer", &s->mptimer, sizeof(s->mptimer),
-                          TYPE_ARM_MPTIMER);
+    object_initialize_child(obj, "mptimer", &s->mptimer, TYPE_ARM_MPTIMER);
 
-    sysbus_init_child_obj(obj, "wdtimer", &s->wdtimer, sizeof(s->wdtimer),
-                          TYPE_ARM_MPTIMER);
+    object_initialize_child(obj, "wdtimer", &s->wdtimer, TYPE_ARM_MPTIMER);
 }
 
 static Property mpcore_priv_properties[] = {
diff --git a/hw/cpu/realview_mpcore.c b/hw/cpu/realview_mpcore.c
index cc2767c716..672d0f8a25 100644
--- a/hw/cpu/realview_mpcore.c
+++ b/hw/cpu/realview_mpcore.c
@@ -70,7 +70,7 @@ static void realview_mpcore_realize(DeviceState *dev, Error **errp)
     int i;
 
     qdev_prop_set_uint32(priv, "num-cpu", s->num_cpu);
-    object_property_set_bool(OBJECT(&s->priv), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->priv), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
@@ -104,8 +104,7 @@ static void mpcore_rirq_init(Object *obj)
     SysBusDevice *privbusdev;
     int i;
 
-    sysbus_init_child_obj(obj, "a11priv", &s->priv, sizeof(s->priv),
-                          TYPE_ARM11MPCORE_PRIV);
+    object_initialize_child(obj, "a11priv", &s->priv, TYPE_ARM11MPCORE_PRIV);
     privbusdev = SYS_BUS_DEVICE(&s->priv);
     sysbus_init_mmio(sbd, sysbus_mmio_get_region(privbusdev, 0));
 
diff --git a/hw/intc/realview_gic.c b/hw/intc/realview_gic.c
index 73fe8cd815..f11fb5259a 100644
--- a/hw/intc/realview_gic.c
+++ b/hw/intc/realview_gic.c
@@ -34,7 +34,7 @@ static void realview_gic_realize(DeviceState *dev, Error **errp)
     int numirq = 96;
 
     qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", numirq);
-    object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
@@ -62,7 +62,7 @@ static void realview_gic_init(Object *obj)
                        "realview-gic-container", 0x2000);
     sysbus_init_mmio(sbd, &s->container);
 
-    sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic), TYPE_ARM_GIC);
+    object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GIC);
     qdev_prop_set_uint32(DEVICE(&s->gic), "num-cpu", 1);
 }
 
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 30ad133ec3..e74b047380 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -63,14 +63,12 @@ static void xlnx_zynqmp_pmu_soc_init(Object *obj)
 
     object_initialize_child(obj, "pmu-cpu", &s->cpu, TYPE_MICROBLAZE_CPU);
 
-    sysbus_init_child_obj(obj, "intc", &s->intc, sizeof(s->intc),
-                          TYPE_XLNX_PMU_IO_INTC);
+    object_initialize_child(obj, "intc", &s->intc, TYPE_XLNX_PMU_IO_INTC);
 
     /* Create the IPI device */
     for (int i = 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
         char *name = g_strdup_printf("ipi%d", i);
-        sysbus_init_child_obj(obj, name, &s->ipi[i], sizeof(s->ipi[i]),
-                              TYPE_XLNX_ZYNQMP_IPI);
+        object_initialize_child(obj, name, &s->ipi[i], TYPE_XLNX_ZYNQMP_IPI);
         g_free(name);
     }
 }
@@ -110,7 +108,7 @@ static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
                              &error_abort);
     object_property_set_uint(OBJECT(&s->intc), 0xffff, "intc-positive",
                              &error_abort);
-    object_property_set_bool(OBJECT(&s->intc), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->intc), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -121,8 +119,7 @@ static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
 
     /* Connect the IPI device */
     for (int i = 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
-        object_property_set_bool(OBJECT(&s->ipi[i]), true, "realized",
-                                 &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->ipi[i]), &error_abort);
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->ipi[i]), 0, ipi_addr[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ipi[i]), 0,
                            qdev_get_gpio_in(DEVICE(&s->intc), ipi_irq[i]));
diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 3cb10c743c..47aa3b0552 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -31,6 +31,7 @@
 #include "hw/input/adb.h"
 #include "hw/misc/mos6522.h"
 #include "hw/misc/macio/cuda.h"
+#include "qapi/error.h"
 #include "qemu/timer.h"
 #include "sysemu/runstate.h"
 #include "qapi/error.h"
@@ -527,8 +528,7 @@ static void cuda_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sbd;
     struct tm tm;
 
-    object_property_set_bool(OBJECT(&s->mos6522_cuda), true, "realized",
-                             &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->mos6522_cuda), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -554,8 +554,8 @@ static void cuda_init(Object *obj)
     CUDAState *s = CUDA(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
-    sysbus_init_child_obj(obj, "mos6522-cuda", &s->mos6522_cuda,
-                          sizeof(s->mos6522_cuda), TYPE_MOS6522_CUDA);
+    object_initialize_child(obj, "mos6522-cuda", &s->mos6522_cuda,
+                            TYPE_MOS6522_CUDA);
 
     memory_region_init_io(&s->mem, obj, &mos6522_cuda_ops, s, "cuda", 0x2000);
     sysbus_init_mmio(sbd, &s->mem);
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index 0895b78b59..41b626c46c 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -38,6 +38,7 @@
 #include "hw/misc/mos6522.h"
 #include "hw/misc/macio/gpio.h"
 #include "hw/misc/macio/pmu.h"
+#include "qapi/error.h"
 #include "qemu/timer.h"
 #include "sysemu/runstate.h"
 #include "qapi/error.h"
@@ -744,8 +745,7 @@ static void pmu_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sbd;
     struct tm tm;
 
-    object_property_set_bool(OBJECT(&s->mos6522_pmu), true, "realized",
-                             &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->mos6522_pmu), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -780,8 +780,8 @@ static void pmu_init(Object *obj)
                              qdev_prop_allow_set_link_before_realize,
                              0);
 
-    sysbus_init_child_obj(obj, "mos6522-pmu", &s->mos6522_pmu,
-                          sizeof(s->mos6522_pmu), TYPE_MOS6522_PMU);
+    object_initialize_child(obj, "mos6522-pmu", &s->mos6522_pmu,
+                            TYPE_MOS6522_PMU);
 
     memory_region_init_io(&s->mem, obj, &mos6522_pmu_ops, s, "via-pmu",
                           0x2000);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 3eb40ad8f8..b64baf71ca 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1309,8 +1309,7 @@ static void pnv_chip_power9_instance_init(Object *obj)
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(obj);
     int i;
 
-    sysbus_init_child_obj(obj, "xive", &chip9->xive, sizeof(chip9->xive),
-                          TYPE_PNV_XIVE);
+    object_initialize_child(obj, "xive", &chip9->xive, TYPE_PNV_XIVE);
     object_property_add_alias(obj, "xive-fabric", OBJECT(&chip9->xive),
                               "xive-fabric");
 
@@ -1470,8 +1469,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
                             "tm-bar", &error_fatal);
     object_property_set_link(OBJECT(&chip9->xive), OBJECT(chip), "chip",
                              &error_abort);
-    object_property_set_bool(OBJECT(&chip9->xive), true, "realized",
-                             &local_err);
+    sysbus_realize(SYS_BUS_DEVICE(&chip9->xive), &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index ae4c3ebb8a..bebd3213e1 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -93,8 +93,7 @@ static void riscv_lowrisc_ibex_soc_init(Object *obj)
 {
     LowRISCIbexSoCState *s = RISCV_IBEX_SOC(obj);
 
-    sysbus_init_child_obj(obj, "cpus", &s->cpus,
-                          sizeof(s->cpus), TYPE_RISCV_HART_ARRAY);
+    object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
 }
 
 static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
@@ -108,8 +107,7 @@ static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
                             &error_abort);
     object_property_set_int(OBJECT(&s->cpus), ms->smp.cpus, "num-harts",
                             &error_abort);
-    object_property_set_bool(OBJECT(&s->cpus), true, "realized",
-                            &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_abort);
 
     /* Boot ROM */
     memory_region_init_rom(&s->rom, OBJECT(dev_soc), "riscv.lowrisc.ibex.rom",
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 77742c1a6e..a9e4482270 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -147,13 +147,11 @@ static void riscv_sifive_e_soc_init(Object *obj)
     MachineState *ms = MACHINE(qdev_get_machine());
     SiFiveESoCState *s = RISCV_E_SOC(obj);
 
-    sysbus_init_child_obj(obj, "cpus", &s->cpus,
-                          sizeof(s->cpus), TYPE_RISCV_HART_ARRAY);
+    object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
     object_property_set_int(OBJECT(&s->cpus), ms->smp.cpus, "num-harts",
                             &error_abort);
-    sysbus_init_child_obj(obj, "riscv.sifive.e.gpio0",
-                          &s->gpio, sizeof(s->gpio),
-                          TYPE_SIFIVE_GPIO);
+    object_initialize_child(obj, "riscv.sifive.e.gpio0", &s->gpio,
+                            TYPE_SIFIVE_GPIO);
 }
 
 static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
@@ -167,8 +165,7 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
 
     object_property_set_str(OBJECT(&s->cpus), ms->cpu_type, "cpu-type",
                             &error_abort);
-    object_property_set_bool(OBJECT(&s->cpus), true, "realized",
-                            &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_abort);
 
     /* Mask ROM */
     memory_region_init_rom(&s->mask_rom, OBJECT(dev), "riscv.sifive.e.mrom",
@@ -197,7 +194,7 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
 
     /* GPIO */
 
-    object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &err);
     if (err) {
         error_propagate(errp, err);
         return;
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 3e39301124..5b86520b24 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -487,9 +487,8 @@ static void sifive_u_soc_instance_init(Object *obj)
     object_initialize_child(obj, "e-cluster", &s->e_cluster, TYPE_CPU_CLUSTER);
     qdev_prop_set_uint32(DEVICE(&s->e_cluster), "cluster-id", 0);
 
-    sysbus_init_child_obj(OBJECT(&s->e_cluster), "e-cpus",
-                          &s->e_cpus, sizeof(s->e_cpus),
-                          TYPE_RISCV_HART_ARRAY);
+    object_initialize_child(OBJECT(&s->e_cluster), "e-cpus", &s->e_cpus,
+                            TYPE_RISCV_HART_ARRAY);
     qdev_prop_set_uint32(DEVICE(&s->e_cpus), "num-harts", 1);
     qdev_prop_set_uint32(DEVICE(&s->e_cpus), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(&s->e_cpus), "cpu-type", SIFIVE_E_CPU);
@@ -497,19 +496,15 @@ static void sifive_u_soc_instance_init(Object *obj)
     object_initialize_child(obj, "u-cluster", &s->u_cluster, TYPE_CPU_CLUSTER);
     qdev_prop_set_uint32(DEVICE(&s->u_cluster), "cluster-id", 1);
 
-    sysbus_init_child_obj(OBJECT(&s->u_cluster), "u-cpus",
-                          &s->u_cpus, sizeof(s->u_cpus),
-                          TYPE_RISCV_HART_ARRAY);
+    object_initialize_child(OBJECT(&s->u_cluster), "u-cpus", &s->u_cpus,
+                            TYPE_RISCV_HART_ARRAY);
     qdev_prop_set_uint32(DEVICE(&s->u_cpus), "num-harts", ms->smp.cpus - 1);
     qdev_prop_set_uint32(DEVICE(&s->u_cpus), "hartid-base", 1);
     qdev_prop_set_string(DEVICE(&s->u_cpus), "cpu-type", SIFIVE_U_CPU);
 
-    sysbus_init_child_obj(obj, "prci", &s->prci, sizeof(s->prci),
-                          TYPE_SIFIVE_U_PRCI);
-    sysbus_init_child_obj(obj, "otp", &s->otp, sizeof(s->otp),
-                          TYPE_SIFIVE_U_OTP);
-    sysbus_init_child_obj(obj, "gem", &s->gem, sizeof(s->gem),
-                          TYPE_CADENCE_GEM);
+    object_initialize_child(obj, "prci", &s->prci, TYPE_SIFIVE_U_PRCI);
+    object_initialize_child(obj, "otp", &s->otp, TYPE_SIFIVE_U_OTP);
+    object_initialize_child(obj, "gem", &s->gem, TYPE_CADENCE_GEM);
 }
 
 static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
@@ -527,10 +522,8 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     Error *err = NULL;
     NICInfo *nd = &nd_table[0];
 
-    object_property_set_bool(OBJECT(&s->e_cpus), true, "realized",
-                             &error_abort);
-    object_property_set_bool(OBJECT(&s->u_cpus), true, "realized",
-                             &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->e_cpus), &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->u_cpus), &error_abort);
     /*
      * The cluster must be realized after the RISC-V hart array container,
      * as the container's CPU object is only created on realize, and the
@@ -597,11 +590,11 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
         memmap[SIFIVE_U_CLINT].size, ms->smp.cpus,
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
 
-    object_property_set_bool(OBJECT(&s->prci), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->prci), &err);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0, memmap[SIFIVE_U_PRCI].base);
 
     qdev_prop_set_uint32(DEVICE(&s->otp), "serial", s->serial);
-    object_property_set_bool(OBJECT(&s->otp), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->otp), &err);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->otp), 0, memmap[SIFIVE_U_OTP].base);
 
     for (i = 0; i < SIFIVE_U_PLIC_NUM_SOURCES; i++) {
@@ -614,7 +607,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     }
     object_property_set_int(OBJECT(&s->gem), GEM_REVISION, "revision",
                             &error_abort);
-    object_property_set_bool(OBJECT(&s->gem), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->gem), &err);
     if (err) {
         error_propagate(errp, err);
         return;
-- 
2.26.2


