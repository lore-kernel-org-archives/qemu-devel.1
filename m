Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AB0C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:51:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47C6F20738
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2rdV1vj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C6F20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo8c3-0006Sb-Ej
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 12:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo8VI-0003Eq-Fw
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:44:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23335
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo8V8-00054v-CX
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593017033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w/27EivrxeFCKmDDGG6O4G2FkcIiWVFGynxfyd1sTS4=;
 b=Z2rdV1vjxVll4bcViaiwcXhJ4szvi32qC74FLh+I04y+Z8q04u1nBefrARCrUIdAEODNv3
 Goip1tV3sKd+g2qv0w17YhAjgzCYbyW7z6t06nIzO5YOmYVNdouzuo6Um8GVSnCT9bkoCr
 VFFNV+OdgLVlBZFWcD9oNXzil9o7dZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-u44wU5flPTOBWqMxJ2g2MA-1; Wed, 24 Jun 2020 12:43:48 -0400
X-MC-Unique: u44wU5flPTOBWqMxJ2g2MA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71FC7107ACCA;
 Wed, 24 Jun 2020 16:43:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E5CD5C578;
 Wed, 24 Jun 2020 16:43:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E0F011138470; Wed, 24 Jun 2020 18:43:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/46] qdev: Smooth error checking of qdev_realize() & friends
Date: Wed, 24 Jun 2020 18:43:01 +0200
Message-Id: <20200624164344.3778251-4-armbru@redhat.com>
In-Reply-To: <20200624164344.3778251-1-armbru@redhat.com>
References: <20200624164344.3778251-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert

    foo(..., &err);
    if (err) {
        ...
    }

to

    if (!foo(..., &err)) {
        ...
    }

for qdev_realize(), qdev_realize_and_unref(), qbus_realize() and their
wrappers isa_realize_and_unref(), pci_realize_and_unref(),
sysbus_realize(), sysbus_realize_and_unref(), usb_realize_and_unref().
Coccinelle script:

    @@
    identifier fun = {isa_realize_and_unref, pci_realize_and_unref, qbus_realize, qdev_realize, qdev_realize_and_unref, sysbus_realize, sysbus_realize_and_unref, usb_realize_and_unref};
    expression list args, args2;
    typedef Error;
    Error *err;
    identifier errp;
    @@
    -      fun(args, &err, args2);
    -      if (err) {
    +      if (!fun(args, errp, args2)) {
	       ... when != err
    -	   error_propagate(errp, err);
	       ...
	   }

    @@
    identifier fun = {isa_realize_and_unref, pci_realize_and_unref, qbus_realize, qdev_realize, qdev_realize_and_unref, sysbus_realize, sysbus_realize_and_unref, usb_realize_and_unref};
    expression list args, args2;
    typedef Error;
    Error *err;
    @@
    -      fun(args, &err, args2);
    -      if (err) {
    +      if (!fun(args, &err, args2)) {
	       ...
	   }

Fails to convert hw/arm/armsse.c, because Coccinelle gets confused by
ARMSSE being used both as typedef and function-like macro there.
Convert manually.

Eliminate error_propagate() that are now unnecessary.  Delete @err
that are now unused.  Clean up whitespace.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/arm/allwinner-a10.c          |  21 ++-----
 hw/arm/armsse.c                 | 104 ++++++++------------------------
 hw/arm/armv7m.c                 |  12 +---
 hw/arm/aspeed_ast2600.c         |  68 ++++++---------------
 hw/arm/aspeed_soc.c             |  60 +++++-------------
 hw/arm/bcm2835_peripherals.c    |  60 +++++-------------
 hw/arm/bcm2836.c                |  12 +---
 hw/arm/cubieboard.c             |   3 +-
 hw/arm/digic.c                  |  12 +---
 hw/arm/digic_boards.c           |   3 +-
 hw/arm/fsl-imx25.c              |  44 ++++----------
 hw/arm/fsl-imx31.c              |  32 +++-------
 hw/arm/fsl-imx6.c               |  48 ++++-----------
 hw/arm/msf2-soc.c               |  21 ++-----
 hw/arm/nrf51_soc.c              |  24 ++------
 hw/arm/stm32f205_soc.c          |  29 +++------
 hw/arm/stm32f405_soc.c          |  32 +++-------
 hw/arm/xlnx-zynqmp.c            |  61 +++++--------------
 hw/block/fdc.c                  |   4 +-
 hw/block/xen-block.c            |   3 +-
 hw/char/serial-pci-multi.c      |   5 +-
 hw/char/serial-pci.c            |   5 +-
 hw/char/serial.c                |  10 +--
 hw/core/cpu.c                   |   3 +-
 hw/cpu/a15mpcore.c              |   5 +-
 hw/cpu/a9mpcore.c               |  21 ++-----
 hw/cpu/arm11mpcore.c            |  17 ++----
 hw/cpu/realview_mpcore.c        |   9 +--
 hw/display/virtio-gpu-pci.c     |   6 +-
 hw/display/virtio-vga.c         |   5 +-
 hw/intc/armv7m_nvic.c           |   9 +--
 hw/intc/pnv_xive.c              |   8 +--
 hw/intc/realview_gic.c          |   5 +-
 hw/intc/spapr_xive.c            |   8 +--
 hw/intc/xics.c                  |   5 +-
 hw/intc/xive.c                  |   3 +-
 hw/isa/piix4.c                  |   5 +-
 hw/microblaze/xlnx-zynqmp-pmu.c |   9 +--
 hw/mips/cps.c                   |  17 ++----
 hw/misc/macio/cuda.c            |   5 +-
 hw/misc/macio/macio.c           |  25 ++------
 hw/misc/macio/pmu.c             |   5 +-
 hw/pci-host/pnv_phb3.c          |  13 +---
 hw/pci-host/pnv_phb4.c          |   5 +-
 hw/pci-host/pnv_phb4_pec.c      |   5 +-
 hw/ppc/e500.c                   |   5 +-
 hw/ppc/pnv.c                    |  53 ++++------------
 hw/ppc/pnv_core.c               |   4 +-
 hw/ppc/pnv_psi.c                |   9 +--
 hw/ppc/spapr_cpu_core.c         |   3 +-
 hw/ppc/spapr_irq.c              |   5 +-
 hw/riscv/opentitan.c            |   9 +--
 hw/riscv/sifive_e.c             |   6 +-
 hw/riscv/sifive_u.c             |   5 +-
 hw/s390x/event-facility.c       |  13 ++--
 hw/s390x/s390-pci-bus.c         |   3 +-
 hw/s390x/sclp.c                 |   3 +-
 hw/s390x/virtio-ccw-crypto.c    |   5 +-
 hw/s390x/virtio-ccw-rng.c       |   5 +-
 hw/scsi/scsi-bus.c              |   4 +-
 hw/sd/aspeed_sdhci.c            |   4 +-
 hw/sd/ssi-sd.c                  |   3 +-
 hw/usb/bus.c                    |   3 +-
 hw/virtio/virtio-rng-pci.c      |   5 +-
 qdev-monitor.c                  |   3 +-
 65 files changed, 248 insertions(+), 768 deletions(-)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 52e0d83760..3e45aa4141 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -72,17 +72,12 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
 {
     AwA10State *s = AW_A10(dev);
     SysBusDevice *sysbusdev;
-    Error *err = NULL;
 
-    qdev_realize(DEVICE(&s->cpu), NULL, &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->cpu), NULL, errp)) {
         return;
     }
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->intc), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->intc), errp)) {
         return;
     }
     sysbusdev = SYS_BUS_DEVICE(&s->intc);
@@ -93,9 +88,7 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
                        qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
     qdev_pass_gpios(DEVICE(&s->intc), dev, NULL);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->timer), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer), errp)) {
         return;
     }
     sysbusdev = SYS_BUS_DEVICE(&s->timer);
@@ -117,18 +110,14 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
         qemu_check_nic_model(&nd_table[0], TYPE_AW_EMAC);
         qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
     }
-    sysbus_realize(SYS_BUS_DEVICE(&s->emac), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->emac), errp)) {
         return;
     }
     sysbusdev = SYS_BUS_DEVICE(&s->emac);
     sysbus_mmio_map(sysbusdev, 0, AW_A10_EMAC_BASE);
     sysbus_connect_irq(sysbusdev, 0, qdev_get_gpio_in(dev, 55));
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->sata), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sata), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sata), 0, AW_A10_SATA_BASE);
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index e2cf43ee0b..b306d95538 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -566,9 +566,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i]),
                                  "memory", &error_abort);
         object_property_set_link(cpuobj, OBJECT(s), "idau", &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(cpuobj), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(cpuobj), errp)) {
             return;
         }
         /*
@@ -577,9 +575,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
          * CPU must exist and have been parented into the cluster before
          * the cluster is realized.
          */
-        qdev_realize(DEVICE(&s->cluster[i]), NULL, &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!qdev_realize(DEVICE(&s->cluster[i]), NULL, errp)) {
             return;
         }
 
@@ -613,9 +609,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                     error_propagate(errp, err);
                     return;
                 }
-                qdev_realize(DEVICE(splitter), NULL, &err);
-                if (err) {
-                    error_propagate(errp, err);
+                if (!qdev_realize(DEVICE(splitter), NULL, errp)) {
                     return;
                 }
                 for (cpunum = 0; cpunum < info->num_cpus; cpunum++) {
@@ -646,9 +640,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     }
 
     /* Security controller */
-    sysbus_realize(SYS_BUS_DEVICE(&s->secctl), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->secctl), errp)) {
         return;
     }
     sbd_secctl = SYS_BUS_DEVICE(&s->secctl);
@@ -669,9 +661,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    qdev_realize(DEVICE(&s->sec_resp_splitter), NULL, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->sec_resp_splitter), NULL, errp)) {
         return;
     }
     dev_splitter = DEVICE(&s->sec_resp_splitter);
@@ -693,9 +683,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         }
         object_property_set_link(OBJECT(&s->mpc[i]), OBJECT(&s->sram[i]),
                                  "downstream", &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(&s->mpc[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->mpc[i]), errp)) {
             return;
         }
         /* Map the upstream end of the MPC into the right place... */
@@ -716,9 +704,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    qdev_realize(DEVICE(&s->mpc_irq_orgate), NULL, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->mpc_irq_orgate), NULL, errp)) {
         return;
     }
     qdev_connect_gpio_out(DEVICE(&s->mpc_irq_orgate), 0,
@@ -735,9 +721,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
      * map its upstream ends to the right place in the container.
      */
     qdev_prop_set_uint32(DEVICE(&s->timer0), "pclk-frq", s->mainclk_frq);
-    sysbus_realize(SYS_BUS_DEVICE(&s->timer0), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer0), errp)) {
         return;
     }
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer0), 0,
@@ -747,9 +731,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                              &error_abort);
 
     qdev_prop_set_uint32(DEVICE(&s->timer1), "pclk-frq", s->mainclk_frq);
-    sysbus_realize(SYS_BUS_DEVICE(&s->timer1), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer1), errp)) {
         return;
     }
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer1), 0,
@@ -759,9 +741,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                              &error_abort);
 
     qdev_prop_set_uint32(DEVICE(&s->dualtimer), "pclk-frq", s->mainclk_frq);
-    sysbus_realize(SYS_BUS_DEVICE(&s->dualtimer), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->dualtimer), errp)) {
         return;
     }
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->dualtimer), 0,
@@ -785,9 +765,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             int cpunum;
             SysBusDevice *mhu_sbd = SYS_BUS_DEVICE(&s->mhu[i]);
 
-            sysbus_realize(SYS_BUS_DEVICE(&s->mhu[i]), &err);
-            if (err) {
-                error_propagate(errp, err);
+            if (!sysbus_realize(SYS_BUS_DEVICE(&s->mhu[i]), errp)) {
                 return;
             }
             port = g_strdup_printf("port[%d]", i + 3);
@@ -812,9 +790,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->apb_ppc0), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->apb_ppc0), errp)) {
         return;
     }
 
@@ -861,9 +837,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    qdev_realize(DEVICE(&s->ppc_irq_orgate), NULL, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->ppc_irq_orgate), NULL, errp)) {
         return;
     }
     qdev_connect_gpio_out(DEVICE(&s->ppc_irq_orgate), 0,
@@ -884,9 +858,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             qdev_prop_set_string(DEVICE(&s->cachectrl[i]), "name", name);
             g_free(name);
             qdev_prop_set_uint64(DEVICE(&s->cachectrl[i]), "size", 0x1000);
-            sysbus_realize(SYS_BUS_DEVICE(&s->cachectrl[i]), &err);
-            if (err) {
-                error_propagate(errp, err);
+            if (!sysbus_realize(SYS_BUS_DEVICE(&s->cachectrl[i]), errp)) {
                 return;
             }
 
@@ -902,9 +874,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             qdev_prop_set_string(DEVICE(&s->cpusecctrl[i]), "name", name);
             g_free(name);
             qdev_prop_set_uint64(DEVICE(&s->cpusecctrl[i]), "size", 0x1000);
-            sysbus_realize(SYS_BUS_DEVICE(&s->cpusecctrl[i]), &err);
-            if (err) {
-                error_propagate(errp, err);
+            if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpusecctrl[i]), errp)) {
                 return;
             }
 
@@ -917,9 +887,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             MemoryRegion *mr;
 
             qdev_prop_set_uint32(DEVICE(&s->cpuid[i]), "CPUID", i);
-            sysbus_realize(SYS_BUS_DEVICE(&s->cpuid[i]), &err);
-            if (err) {
-                error_propagate(errp, err);
+            if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpuid[i]), errp)) {
                 return;
             }
 
@@ -933,9 +901,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
      *   0x4002f000: S32K timer
      */
     qdev_prop_set_uint32(DEVICE(&s->s32ktimer), "pclk-frq", S32KCLK);
-    sysbus_realize(SYS_BUS_DEVICE(&s->s32ktimer), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->s32ktimer), errp)) {
         return;
     }
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->s32ktimer), 0,
@@ -944,9 +910,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     object_property_set_link(OBJECT(&s->apb_ppc1), OBJECT(mr), "port[0]",
                              &error_abort);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->apb_ppc1), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->apb_ppc1), errp)) {
         return;
     }
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->apb_ppc1), 0);
@@ -982,9 +946,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_realize(SYS_BUS_DEVICE(&s->sysinfo), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sysinfo), errp)) {
         return;
     }
     /* System information registers */
@@ -998,9 +960,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                             "INITSVTOR0_RST", &error_abort);
     object_property_set_int(OBJECT(&s->sysctl), s->init_svtor,
                             "INITSVTOR1_RST", &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->sysctl), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sysctl), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysctl), 0, 0x50021000);
@@ -1033,18 +993,14 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    qdev_realize(DEVICE(&s->nmi_orgate), NULL, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->nmi_orgate), NULL, errp)) {
         return;
     }
     qdev_connect_gpio_out(DEVICE(&s->nmi_orgate), 0,
                           qdev_get_gpio_in_named(DEVICE(&s->armv7m), "NMI", 0));
 
     qdev_prop_set_uint32(DEVICE(&s->s32kwatchdog), "wdogclk-frq", S32KCLK);
-    sysbus_realize(SYS_BUS_DEVICE(&s->s32kwatchdog), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->s32kwatchdog), errp)) {
         return;
     }
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->s32kwatchdog), 0,
@@ -1054,9 +1010,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     /* 0x40080000 .. 0x4008ffff : ARMSSE second Base peripheral region */
 
     qdev_prop_set_uint32(DEVICE(&s->nswatchdog), "wdogclk-frq", s->mainclk_frq);
-    sysbus_realize(SYS_BUS_DEVICE(&s->nswatchdog), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->nswatchdog), errp)) {
         return;
     }
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->nswatchdog), 0,
@@ -1064,9 +1018,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->nswatchdog), 0, 0x40081000);
 
     qdev_prop_set_uint32(DEVICE(&s->swatchdog), "wdogclk-frq", s->mainclk_frq);
-    sysbus_realize(SYS_BUS_DEVICE(&s->swatchdog), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->swatchdog), errp)) {
         return;
     }
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->swatchdog), 0,
@@ -1081,9 +1033,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             error_propagate(errp, err);
             return;
         }
-        qdev_realize(DEVICE(splitter), NULL, &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!qdev_realize(DEVICE(splitter), NULL, errp)) {
             return;
         }
     }
@@ -1128,9 +1078,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             error_propagate(errp, err);
             return;
         }
-        qdev_realize(DEVICE(splitter), NULL, &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!qdev_realize(DEVICE(splitter), NULL, errp)) {
             return;
         }
 
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 3308211e9c..5d6bded386 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -213,16 +213,12 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
     s->cpu->env.nvic = &s->nvic;
     s->nvic.cpu = s->cpu;
 
-    qdev_realize(DEVICE(s->cpu), NULL, &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(s->cpu), NULL, errp)) {
         return;
     }
 
     /* Note that we must realize the NVIC after the CPU */
-    sysbus_realize(SYS_BUS_DEVICE(&s->nvic), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->nvic), errp)) {
         return;
     }
 
@@ -254,9 +250,7 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
             }
             object_property_set_link(obj, OBJECT(s->board_memory),
                                      "source-memory", &error_abort);
-            sysbus_realize(SYS_BUS_DEVICE(obj), &err);
-            if (err != NULL) {
-                error_propagate(errp, err);
+            if (!sysbus_realize(SYS_BUS_DEVICE(obj), errp)) {
                 return;
             }
 
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 59a7a1370b..aa02755d3f 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -259,9 +259,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
          * is needed when using -kernel
          */
 
-        qdev_realize(DEVICE(&s->cpu[i]), NULL, &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
             return;
         }
     }
@@ -301,17 +299,13 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                                 sc->memmap[ASPEED_SRAM], &s->sram);
 
     /* SCU */
-    sysbus_realize(SYS_BUS_DEVICE(&s->scu), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_SCU]);
 
     /* RTC */
-    sysbus_realize(SYS_BUS_DEVICE(&s->rtc), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, sc->memmap[ASPEED_RTC]);
@@ -321,9 +315,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     /* Timer */
     object_property_set_link(OBJECT(&s->timerctrl),
                              OBJECT(&s->scu), "scu", &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->timerctrl), 0,
@@ -343,9 +335,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     /* I2C */
     object_property_set_link(OBJECT(&s->i2c), OBJECT(s->dram_mr), "dram",
                              &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->i2c), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c), 0, sc->memmap[ASPEED_I2C]);
@@ -368,9 +358,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_realize(SYS_BUS_DEVICE(&s->fmc), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->fmc), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 0, sc->memmap[ASPEED_FMC]);
@@ -385,9 +373,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                                  "dram", &error_abort);
         object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs",
                                 &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0,
@@ -398,9 +384,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
     /* EHCI */
     for (i = 0; i < sc->ehcis_num; i++) {
-        sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci[i]), 0,
@@ -410,9 +394,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
 
     /* SDMC - SDRAM Memory Controller */
-    sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdmc), 0, sc->memmap[ASPEED_SDMC]);
@@ -423,9 +405,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
         object_property_set_link(OBJECT(&s->wdt[i]),
                                  OBJECT(&s->scu), "scu", &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0,
@@ -436,9 +416,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < sc->macs_num; i++) {
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed",
                                  &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
@@ -448,9 +426,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
         object_property_set_link(OBJECT(&s->mii[i]), OBJECT(&s->ftgmac100[i]),
                                  "nic", &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(&s->mii[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->mii[i]), errp)) {
             return;
         }
 
@@ -459,9 +435,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
 
     /* XDMA */
-    sysbus_realize(SYS_BUS_DEVICE(&s->xdma), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->xdma), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->xdma), 0,
@@ -470,18 +444,14 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_XDMA));
 
     /* GPIO */
-    sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, sc->memmap[ASPEED_GPIO]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
                        aspeed_soc_get_irq(s, ASPEED_GPIO));
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->gpio_1_8v), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio_1_8v), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio_1_8v), 0,
@@ -490,9 +460,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_GPIO_1_8V));
 
     /* SDHCI */
-    sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci), 0,
@@ -501,9 +469,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_SDHCI));
 
     /* eMMC */
-    sysbus_realize(SYS_BUS_DEVICE(&s->emmc), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->emmc), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->emmc), 0, sc->memmap[ASPEED_EMMC]);
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 311458aa76..6faffc13cc 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -230,9 +230,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 
     /* CPU */
     for (i = 0; i < sc->num_cpus; i++) {
-        qdev_realize(DEVICE(&s->cpu[i]), NULL, &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
             return;
         }
     }
@@ -248,17 +246,13 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                                 sc->memmap[ASPEED_SRAM], &s->sram);
 
     /* SCU */
-    sysbus_realize(SYS_BUS_DEVICE(&s->scu), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_SCU]);
 
     /* VIC */
-    sysbus_realize(SYS_BUS_DEVICE(&s->vic), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->vic), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->vic), 0, sc->memmap[ASPEED_VIC]);
@@ -268,9 +262,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                        qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
 
     /* RTC */
-    sysbus_realize(SYS_BUS_DEVICE(&s->rtc), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, sc->memmap[ASPEED_RTC]);
@@ -280,9 +272,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     /* Timer */
     object_property_set_link(OBJECT(&s->timerctrl),
                              OBJECT(&s->scu), "scu", &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->timerctrl), 0,
@@ -302,9 +292,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     /* I2C */
     object_property_set_link(OBJECT(&s->i2c), OBJECT(s->dram_mr), "dram",
                              &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->i2c), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c), 0, sc->memmap[ASPEED_I2C]);
@@ -320,9 +308,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_realize(SYS_BUS_DEVICE(&s->fmc), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->fmc), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 0, sc->memmap[ASPEED_FMC]);
@@ -335,9 +321,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < sc->spis_num; i++) {
         object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs",
                                 &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0,
@@ -348,9 +332,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 
     /* EHCI */
     for (i = 0; i < sc->ehcis_num; i++) {
-        sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci[i]), 0,
@@ -360,9 +342,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* SDMC - SDRAM Memory Controller */
-    sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdmc), 0, sc->memmap[ASPEED_SDMC]);
@@ -373,9 +353,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 
         object_property_set_link(OBJECT(&s->wdt[i]),
                                  OBJECT(&s->scu), "scu", &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0,
@@ -386,9 +364,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < sc->macs_num; i++) {
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed",
                                  &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
@@ -398,9 +374,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* XDMA */
-    sysbus_realize(SYS_BUS_DEVICE(&s->xdma), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->xdma), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->xdma), 0,
@@ -409,9 +383,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_XDMA));
 
     /* GPIO */
-    sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, sc->memmap[ASPEED_GPIO]);
@@ -419,9 +391,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_GPIO));
 
     /* SDHCI */
-    sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci), 0,
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 7ffdf62067..8313410ffe 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -161,9 +161,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     }
 
     /* Interrupt Controller */
-    sysbus_realize(SYS_BUS_DEVICE(&s->ic), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ic), errp)) {
         return;
     }
 
@@ -172,9 +170,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     sysbus_pass_irq(SYS_BUS_DEVICE(s), SYS_BUS_DEVICE(&s->ic));
 
     /* Sys Timer */
-    sysbus_realize(SYS_BUS_DEVICE(&s->systmr), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->systmr), errp)) {
         return;
     }
     memory_region_add_subregion(&s->peri_mr, ST_OFFSET,
@@ -185,9 +181,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
 
     /* UART0 */
     qdev_prop_set_chr(DEVICE(&s->uart0), "chardev", serial_hd(0));
-    sysbus_realize(SYS_BUS_DEVICE(&s->uart0), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart0), errp)) {
         return;
     }
 
@@ -200,9 +194,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     /* AUX / UART1 */
     qdev_prop_set_chr(DEVICE(&s->aux), "chardev", serial_hd(1));
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->aux), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->aux), errp)) {
         return;
     }
 
@@ -213,9 +205,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                                INTERRUPT_AUX));
 
     /* Mailboxes */
-    sysbus_realize(SYS_BUS_DEVICE(&s->mboxes), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mboxes), errp)) {
         return;
     }
 
@@ -239,9 +229,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->fb), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->fb), errp)) {
         return;
     }
 
@@ -251,9 +239,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                        qdev_get_gpio_in(DEVICE(&s->mboxes), MBOX_CHAN_FB));
 
     /* Property channel */
-    sysbus_realize(SYS_BUS_DEVICE(&s->property), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->property), errp)) {
         return;
     }
 
@@ -264,9 +250,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                       qdev_get_gpio_in(DEVICE(&s->mboxes), MBOX_CHAN_PROPERTY));
 
     /* Random Number Generator */
-    sysbus_realize(SYS_BUS_DEVICE(&s->rng), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rng), errp)) {
         return;
     }
 
@@ -289,9 +273,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                              &error_abort);
     object_property_set_bool(OBJECT(&s->sdhci), true, "pending-insert-quirk",
                              &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp)) {
         return;
     }
 
@@ -302,9 +284,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                                INTERRUPT_ARASANSDIO));
 
     /* SDHOST */
-    sysbus_realize(SYS_BUS_DEVICE(&s->sdhost), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhost), errp)) {
         return;
     }
 
@@ -315,9 +295,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                                INTERRUPT_SDIO));
 
     /* DMA Channels */
-    sysbus_realize(SYS_BUS_DEVICE(&s->dma), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->dma), errp)) {
         return;
     }
 
@@ -334,18 +312,14 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     }
 
     /* THERMAL */
-    sysbus_realize(SYS_BUS_DEVICE(&s->thermal), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->thermal), errp)) {
         return;
     }
     memory_region_add_subregion(&s->peri_mr, THERMAL_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->thermal), 0));
 
     /* GPIO */
-    sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
     }
 
@@ -355,9 +329,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->gpio), "sd-bus");
 
     /* Mphi */
-    sysbus_realize(SYS_BUS_DEVICE(&s->mphi), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mphi), errp)) {
         return;
     }
 
@@ -368,9 +340,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                                INTERRUPT_HOSTPORT));
 
     /* DWC2 */
-    sysbus_realize(SYS_BUS_DEVICE(&s->dwc2), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->dwc2), errp)) {
         return;
     }
 
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index ed1793f7b7..51d156f0c5 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -86,9 +86,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
 
     object_property_add_const_link(OBJECT(&s->peripherals), "ram", obj);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->peripherals), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->peripherals), errp)) {
         return;
     }
 
@@ -99,9 +97,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
                             info->peri_base, 1);
 
     /* bcm2836 interrupt controller (and mailboxes, etc.) */
-    sysbus_realize(SYS_BUS_DEVICE(&s->control), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->control), errp)) {
         return;
     }
 
@@ -133,9 +129,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
             return;
         }
 
-        qdev_realize(DEVICE(&s->cpu[n].core), NULL, &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!qdev_realize(DEVICE(&s->cpu[n].core), NULL, errp)) {
             return;
         }
 
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 5cbd115c53..c720e24ced 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -80,8 +80,7 @@ static void cubieboard_init(MachineState *machine)
         exit(1);
     }
 
-    qdev_realize(DEVICE(a10), NULL, &err);
-    if (err != NULL) {
+    if (!qdev_realize(DEVICE(a10), NULL, &err)) {
         error_reportf_err(err, "Couldn't realize Allwinner A10: ");
         exit(1);
     }
diff --git a/hw/arm/digic.c b/hw/arm/digic.c
index 13a83f7430..9fbb2258c9 100644
--- a/hw/arm/digic.c
+++ b/hw/arm/digic.c
@@ -62,16 +62,12 @@ static void digic_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    qdev_realize(DEVICE(&s->cpu), NULL, &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->cpu), NULL, errp)) {
         return;
     }
 
     for (i = 0; i < DIGIC4_NB_TIMERS; i++) {
-        sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), errp)) {
             return;
         }
 
@@ -80,9 +76,7 @@ static void digic_realize(DeviceState *dev, Error **errp)
     }
 
     qdev_prop_set_chr(DEVICE(&s->uart), "chardev", serial_hd(0));
-    sysbus_realize(SYS_BUS_DEVICE(&s->uart), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart), errp)) {
         return;
     }
 
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index b6452d918c..d5524d3e72 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -62,8 +62,7 @@ static void digic4_board_init(MachineState *machine, DigicBoard *board)
         exit(EXIT_FAILURE);
     }
 
-    qdev_realize(DEVICE(s), NULL, &err);
-    if (err != NULL) {
+    if (!qdev_realize(DEVICE(s), NULL, &err)) {
         error_reportf_err(err, "Couldn't realize DIGIC SoC: ");
         exit(1);
     }
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 7ab5c98fbe..f5418c8c12 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -85,15 +85,11 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
     uint8_t i;
     Error *err = NULL;
 
-    qdev_realize(DEVICE(&s->cpu), NULL, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->cpu), NULL, errp)) {
         return;
     }
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->avic), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->avic), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->avic), 0, FSL_IMX25_AVIC_ADDR);
@@ -102,9 +98,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->avic), 1,
                        qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->ccm), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ccm), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccm), 0, FSL_IMX25_CCM_ADDR);
@@ -124,9 +118,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
         qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
 
-        sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, serial_table[i].addr);
@@ -149,9 +141,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
         s->gpt[i].ccm = IMX_CCM(&s->ccm);
 
-        sysbus_realize(SYS_BUS_DEVICE(&s->gpt[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpt[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpt[i]), 0, gpt_table[i].addr);
@@ -172,9 +162,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
         s->epit[i].ccm = IMX_CCM(&s->ccm);
 
-        sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->epit[i]), 0, epit_table[i].addr);
@@ -185,18 +173,14 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
     qdev_set_nic_properties(DEVICE(&s->fec), &nd_table[0]);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->fec), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->fec), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->fec), 0, FSL_IMX25_FEC_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fec), 0,
                        qdev_get_gpio_in(DEVICE(&s->avic), FSL_IMX25_FEC_IRQ));
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->rngc), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rngc), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->rngc), 0, FSL_IMX25_RNGC_ADDR);
@@ -214,9 +198,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
             { FSL_IMX25_I2C3_ADDR, FSL_IMX25_I2C3_IRQ }
         };
 
-        sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c[i]), 0, i2c_table[i].addr);
@@ -237,9 +219,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
             { FSL_IMX25_GPIO4_ADDR, FSL_IMX25_GPIO4_IRQ }
         };
 
-        sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0, gpio_table[i].addr);
@@ -267,9 +247,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
         object_property_set_uint(OBJECT(&s->esdhc[i]), SDHCI_VENDOR_IMX,
                                  "vendor",
                                  &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->esdhc[i]), 0, esdhc_table[i].addr);
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 42cca529c3..8326f5ff81 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -66,15 +66,11 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
     uint16_t i;
     Error *err = NULL;
 
-    qdev_realize(DEVICE(&s->cpu), NULL, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->cpu), NULL, errp)) {
         return;
     }
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->avic), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->avic), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->avic), 0, FSL_IMX31_AVIC_ADDR);
@@ -83,9 +79,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->avic), 1,
                        qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->ccm), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ccm), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccm), 0, FSL_IMX31_CCM_ADDR);
@@ -102,9 +96,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
         qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
 
-        sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
             return;
         }
 
@@ -116,9 +108,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
     s->gpt.ccm = IMX_CCM(&s->ccm);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->gpt), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpt), errp)) {
         return;
     }
 
@@ -138,9 +128,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
         s->epit[i].ccm = IMX_CCM(&s->ccm);
 
-        sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), errp)) {
             return;
         }
 
@@ -162,9 +150,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
         };
 
         /* Initialize the I2C */
-        sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), errp)) {
             return;
         }
         /* Map I2C memory */
@@ -188,9 +174,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
         object_property_set_bool(OBJECT(&s->gpio[i]), false, "has-edge-sel",
                                  &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0, gpio_table[i].addr);
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 4ae3c3efc2..4c2da277ec 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -130,9 +130,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                      "start-powered-off", &error_abort);
         }
 
-        qdev_realize(DEVICE(&s->cpu[i]), NULL, &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
             return;
         }
     }
@@ -144,9 +142,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                             FSL_IMX6_MAX_IRQ + GIC_INTERNAL, "num-irq",
                             &error_abort);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->a9mpcore), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->a9mpcore), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->a9mpcore), 0, FSL_IMX6_A9MPCORE_ADDR);
@@ -158,16 +154,12 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(DEVICE(&s->cpu[i]), ARM_CPU_FIQ));
     }
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->ccm), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ccm), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccm), 0, FSL_IMX6_CCM_ADDR);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->src), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->src), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->src), 0, FSL_IMX6_SRC_ADDR);
@@ -187,9 +179,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
         qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
 
-        sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
             return;
         }
 
@@ -201,9 +191,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
     s->gpt.ccm = IMX_CCM(&s->ccm);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->gpt), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpt), errp)) {
         return;
     }
 
@@ -224,9 +212,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
         s->epit[i].ccm = IMX_CCM(&s->ccm);
 
-        sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), errp)) {
             return;
         }
 
@@ -247,9 +233,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
             { FSL_IMX6_I2C3_ADDR, FSL_IMX6_I2C3_IRQ }
         };
 
-        sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), errp)) {
             return;
         }
 
@@ -307,9 +291,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                  &error_abort);
         object_property_set_bool(OBJECT(&s->gpio[i]), true, "has-upper-pin-irq",
                                  &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), errp)) {
             return;
         }
 
@@ -343,9 +325,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         object_property_set_uint(OBJECT(&s->esdhc[i]), SDHCI_VENDOR_IMX,
                                  "vendor",
                                  &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->esdhc[i]), 0, esdhc_table[i].addr);
@@ -390,9 +370,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         };
 
         /* Initialize the SPI */
-        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
             return;
         }
 
@@ -403,9 +381,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
     }
 
     qdev_set_nic_properties(DEVICE(&s->eth), &nd_table[0]);
-    sysbus_realize(SYS_BUS_DEVICE(&s->eth), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->eth), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->eth), 0, FSL_IMX6_ENET_ADDR);
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 3235c76194..b6143fba92 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -93,7 +93,6 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     MSF2State *s = MSF2_SOC(dev_soc);
     DeviceState *dev, *armv7m;
     SysBusDevice *busdev;
-    Error *err = NULL;
     int i;
 
     MemoryRegion *system_memory = get_system_memory();
@@ -125,9 +124,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memory()),
                                      "memory", &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
         return;
     }
 
@@ -153,9 +150,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     dev = DEVICE(&s->timer);
     /* APB0 clock is the timer input clock */
     qdev_prop_set_uint32(dev, "clock-frequency", s->m3clk / s->apb0div);
-    sysbus_realize(SYS_BUS_DEVICE(&s->timer), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer), errp)) {
         return;
     }
     busdev = SYS_BUS_DEVICE(dev);
@@ -168,9 +163,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     dev = DEVICE(&s->sysreg);
     qdev_prop_set_uint32(dev, "apb0divisor", s->apb0div);
     qdev_prop_set_uint32(dev, "apb1divisor", s->apb1div);
-    sysbus_realize(SYS_BUS_DEVICE(&s->sysreg), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sysreg), errp)) {
         return;
     }
     busdev = SYS_BUS_DEVICE(dev);
@@ -179,9 +172,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     for (i = 0; i < MSF2_NUM_SPIS; i++) {
         gchar *bus_name;
 
-        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
             return;
         }
 
@@ -199,9 +190,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     dev = DEVICE(&s->emac);
     object_property_set_link(OBJECT(&s->emac), OBJECT(get_system_memory()),
                              "ahb-bus", &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->emac), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->emac), errp)) {
         return;
     }
     busdev = SYS_BUS_DEVICE(dev);
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 20dd8b5897..a398bdfab8 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -67,9 +67,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
 
     object_property_set_link(OBJECT(&s->cpu), OBJECT(&s->container), "memory",
                              &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->cpu), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpu), errp)) {
         return;
     }
 
@@ -84,9 +82,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion(&s->container, NRF51_SRAM_BASE, &s->sram);
 
     /* UART */
-    sysbus_realize(SYS_BUS_DEVICE(&s->uart), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart), errp)) {
         return;
     }
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart), 0);
@@ -96,9 +92,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
                        BASE_TO_IRQ(NRF51_UART_BASE)));
 
     /* RNG */
-    sysbus_realize(SYS_BUS_DEVICE(&s->rng), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rng), errp)) {
         return;
     }
 
@@ -116,9 +110,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->nvm), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->nvm), errp)) {
         return;
     }
 
@@ -132,9 +124,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion_overlap(&s->container, NRF51_FLASH_BASE, mr, 0);
 
     /* GPIO */
-    sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
     }
 
@@ -151,9 +141,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
             error_propagate(errp, err);
             return;
         }
-        sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), errp)) {
             return;
         }
 
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index 56aef686c9..5b008722e5 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -81,7 +81,6 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     STM32F205State *s = STM32F205_SOC(dev_soc);
     DeviceState *dev, *armv7m;
     SysBusDevice *busdev;
-    Error *err = NULL;
     int i;
 
     MemoryRegion *system_memory = get_system_memory();
@@ -107,17 +106,13 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memory()),
                                      "memory", &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
         return;
     }
 
     /* System configuration controller */
     dev = DEVICE(&s->syscfg);
-    sysbus_realize(SYS_BUS_DEVICE(&s->syscfg), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->syscfg), errp)) {
         return;
     }
     busdev = SYS_BUS_DEVICE(dev);
@@ -128,9 +123,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     for (i = 0; i < STM_NUM_USARTS; i++) {
         dev = DEVICE(&(s->usart[i]));
         qdev_prop_set_chr(dev, "chardev", serial_hd(i));
-        sysbus_realize(SYS_BUS_DEVICE(&s->usart[i]), &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usart[i]), errp)) {
             return;
         }
         busdev = SYS_BUS_DEVICE(dev);
@@ -142,9 +135,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     for (i = 0; i < STM_NUM_TIMERS; i++) {
         dev = DEVICE(&(s->timer[i]));
         qdev_prop_set_uint64(dev, "clock-frequency", 1000000000);
-        sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), errp)) {
             return;
         }
         busdev = SYS_BUS_DEVICE(dev);
@@ -155,9 +146,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     /* ADC 1 to 3 */
     object_property_set_int(OBJECT(s->adc_irqs), STM_NUM_ADCS,
                             "num-lines", &error_abort);
-    qdev_realize(DEVICE(s->adc_irqs), NULL, &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(s->adc_irqs), NULL, errp)) {
         return;
     }
     qdev_connect_gpio_out(DEVICE(s->adc_irqs), 0,
@@ -165,9 +154,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
 
     for (i = 0; i < STM_NUM_ADCS; i++) {
         dev = DEVICE(&(s->adc[i]));
-        sysbus_realize(SYS_BUS_DEVICE(&s->adc[i]), &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->adc[i]), errp)) {
             return;
         }
         busdev = SYS_BUS_DEVICE(dev);
@@ -179,9 +166,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     /* SPI 1 and 2 */
     for (i = 0; i < STM_NUM_SPIS; i++) {
         dev = DEVICE(&(s->spi[i]));
-        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
             return;
         }
         busdev = SYS_BUS_DEVICE(dev);
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index cf9228d8e7..48b7181665 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -118,17 +118,13 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     object_property_set_link(OBJECT(&s->armv7m), OBJECT(system_memory),
                                      "memory", &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
         return;
     }
 
     /* System configuration controller */
     dev = DEVICE(&s->syscfg);
-    sysbus_realize(SYS_BUS_DEVICE(&s->syscfg), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->syscfg), errp)) {
         return;
     }
     busdev = SYS_BUS_DEVICE(dev);
@@ -139,9 +135,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     for (i = 0; i < STM_NUM_USARTS; i++) {
         dev = DEVICE(&(s->usart[i]));
         qdev_prop_set_chr(dev, "chardev", serial_hd(i));
-        sysbus_realize(SYS_BUS_DEVICE(&s->usart[i]), &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usart[i]), errp)) {
             return;
         }
         busdev = SYS_BUS_DEVICE(dev);
@@ -153,9 +147,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     for (i = 0; i < STM_NUM_TIMERS; i++) {
         dev = DEVICE(&(s->timer[i]));
         qdev_prop_set_uint64(dev, "clock-frequency", 1000000000);
-        sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), errp)) {
             return;
         }
         busdev = SYS_BUS_DEVICE(dev);
@@ -173,9 +165,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     }
     object_property_set_int(OBJECT(&s->adc_irqs), STM_NUM_ADCS,
                             "num-lines", &error_abort);
-    qdev_realize(DEVICE(&s->adc_irqs), NULL, &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->adc_irqs), NULL, errp)) {
         return;
     }
     qdev_connect_gpio_out(DEVICE(&s->adc_irqs), 0,
@@ -183,9 +173,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
 
     for (i = 0; i < STM_NUM_ADCS; i++) {
         dev = DEVICE(&(s->adc[i]));
-        sysbus_realize(SYS_BUS_DEVICE(&s->adc[i]), &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->adc[i]), errp)) {
             return;
         }
         busdev = SYS_BUS_DEVICE(dev);
@@ -197,9 +185,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     /* SPI devices */
     for (i = 0; i < STM_NUM_SPIS; i++) {
         dev = DEVICE(&(s->spi[i]));
-        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
             return;
         }
         busdev = SYS_BUS_DEVICE(dev);
@@ -209,9 +195,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
 
     /* EXTI device */
     dev = DEVICE(&s->exti);
-    sysbus_realize(SYS_BUS_DEVICE(&s->exti), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->exti), errp)) {
         return;
     }
     busdev = SYS_BUS_DEVICE(dev);
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 1de9d4a89d..33e63a2c4e 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -176,7 +176,6 @@ static inline int arm_gic_ppi_index(int cpu_nr, int ppi_index)
 static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
                                    const char *boot_cpu, Error **errp)
 {
-    Error *err = NULL;
     int i;
     int num_rpus = MIN(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS,
                        XLNX_ZYNQMP_NUM_RPU_CPUS);
@@ -209,9 +208,7 @@ static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
 
         object_property_set_bool(OBJECT(&s->rpu_cpu[i]), true, "reset-hivecs",
                                  &error_abort);
-        qdev_realize(DEVICE(&s->rpu_cpu[i]), NULL, &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!qdev_realize(DEVICE(&s->rpu_cpu[i]), NULL, errp)) {
             return;
         }
     }
@@ -367,16 +364,12 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
                                 "reset-cbar", &error_abort);
         object_property_set_int(OBJECT(&s->apu_cpu[i]), num_apus,
                                 "core-count", &error_abort);
-        qdev_realize(DEVICE(&s->apu_cpu[i]), NULL, &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!qdev_realize(DEVICE(&s->apu_cpu[i]), NULL, errp)) {
             return;
         }
     }
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
         return;
     }
 
@@ -470,9 +463,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
                                 &error_abort);
         object_property_set_int(OBJECT(&s->gem[i]), 2, "num-priority-queues",
                                 &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(&s->gem[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gem[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem[i]), 0, gem_addr[i]);
@@ -482,9 +473,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_UARTS; i++) {
         qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
-        sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, uart_addr[i]);
@@ -494,9 +483,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
 
     object_property_set_int(OBJECT(&s->sata), SATA_NUM_PORTS, "num-ports",
                             &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->sata), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sata), errp)) {
         return;
     }
 
@@ -528,9 +515,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
             error_propagate(errp, err);
             return;
         }
-        sysbus_realize(SYS_BUS_DEVICE(sdhci), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(sdhci), errp)) {
             return;
         }
         sysbus_mmio_map(sbd, 0, sdhci_addr[i]);
@@ -545,9 +530,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < XLNX_ZYNQMP_NUM_SPIS; i++) {
         gchar *bus_name;
 
-        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
             return;
         }
 
@@ -562,9 +545,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         g_free(bus_name);
     }
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->qspi), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->qspi), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->qspi), 0, QSPI_ADDR);
@@ -584,17 +565,13 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         g_free(target_bus);
     }
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->dp), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->dp), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->dp), 0, DP_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->dp), 0, gic_spi[DP_IRQ]);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->dpdma), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->dpdma), errp)) {
         return;
     }
     object_property_set_link(OBJECT(&s->dp), OBJECT(&s->dpdma), "dpdma",
@@ -602,17 +579,13 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->dpdma), 0, DPDMA_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->dpdma), 0, gic_spi[DPDMA_IRQ]);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->ipi), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ipi), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ipi), 0, IPI_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->ipi), 0, gic_spi[IPI_IRQ]);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->rtc), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, RTC_ADDR);
@@ -624,9 +597,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
             error_propagate(errp, err);
             return;
         }
-        sysbus_realize(SYS_BUS_DEVICE(&s->gdma[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gdma[i]), errp)) {
             return;
         }
 
@@ -636,9 +607,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     }
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_ADMA_CH; i++) {
-        sysbus_realize(SYS_BUS_DEVICE(&s->adma[i]), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->adma[i]), errp)) {
             return;
         }
 
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index f4493d6afa..fe0ae2d146 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2574,9 +2574,7 @@ static void fdctrl_connect_drives(FDCtrl *fdctrl, DeviceState *fdc_dev,
             return;
         }
 
-        qdev_realize_and_unref(dev, &fdctrl->bus.bus, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (!qdev_realize_and_unref(dev, &fdctrl->bus.bus, errp)) {
             return;
         }
     }
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 1b7bc5de08..10c44dfda2 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -961,8 +961,7 @@ static void xen_block_device_create(XenBackendInstance *backend,
     blockdev->iothread = iothread;
     blockdev->drive = drive;
 
-    qdev_realize_and_unref(DEVICE(xendev), BUS(xenbus), &local_err);
-    if (local_err) {
+    if (!qdev_realize_and_unref(DEVICE(xendev), BUS(xenbus), &local_err)) {
         error_propagate_prepend(errp, local_err,
                                 "realization of device %s failed: ",
                                 type);
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 56f915e7c9..2cf3e44177 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -95,7 +95,6 @@ static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
     PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
     PCIMultiSerialState *pci = DO_UPCAST(PCIMultiSerialState, dev, dev);
     SerialState *s;
-    Error *err = NULL;
     size_t i, nports = multi_serial_get_port_count(pc);
 
     pci->dev.config[PCI_CLASS_PROG] = pci->prog_if;
@@ -106,9 +105,7 @@ static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
 
     for (i = 0; i < nports; i++) {
         s = pci->state + i;
-        qdev_realize(DEVICE(s), NULL, &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        if (!qdev_realize(DEVICE(s), NULL, errp)) {
             multi_serial_pci_exit(dev);
             return;
         }
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index 298f3adba7..cd56924a43 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -47,11 +47,8 @@ static void serial_pci_realize(PCIDevice *dev, Error **errp)
 {
     PCISerialState *pci = DO_UPCAST(PCISerialState, dev, dev);
     SerialState *s = &pci->state;
-    Error *err = NULL;
 
-    qdev_realize(DEVICE(s), NULL, &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(s), NULL, errp)) {
         return;
     }
 
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 9eebcb27e7..2386479492 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -989,11 +989,8 @@ static void serial_io_realize(DeviceState *dev, Error **errp)
 {
     SerialIO *sio = SERIAL_IO(dev);
     SerialState *s = &sio->serial;
-    Error *local_err = NULL;
 
-    qdev_realize(DEVICE(s), NULL, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(s), NULL, errp)) {
         return;
     }
 
@@ -1096,11 +1093,8 @@ static void serial_mm_realize(DeviceState *dev, Error **errp)
 {
     SerialMM *smm = SERIAL_MM(dev);
     SerialState *s = &smm->serial;
-    Error *local_err = NULL;
 
-    qdev_realize(DEVICE(s), NULL, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(s), NULL, errp)) {
         return;
     }
 
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 0f23409f1d..594441a150 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -59,8 +59,7 @@ CPUState *cpu_create(const char *typename)
 {
     Error *err = NULL;
     CPUState *cpu = CPU(object_new(typename));
-    qdev_realize(DEVICE(cpu), NULL, &err);
-    if (err != NULL) {
+    if (!qdev_realize(DEVICE(cpu), NULL, &err)) {
         error_report_err(err);
         object_unref(OBJECT(cpu));
         exit(EXIT_FAILURE);
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index e6085f5d44..c377be398d 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -53,7 +53,6 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
     DeviceState *gicdev;
     SysBusDevice *busdev;
     int i;
-    Error *err = NULL;
     bool has_el3;
     bool has_el2 = false;
     Object *cpuobj;
@@ -76,9 +75,7 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
         qdev_prop_set_bit(gicdev, "has-virtualization-extensions", has_el2);
     }
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
         return;
     }
     busdev = SYS_BUS_DEVICE(&s->gic);
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 642363d2f4..351295e518 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -50,16 +50,13 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
     DeviceState *scudev, *gicdev, *gtimerdev, *mptimerdev, *wdtdev;
     SysBusDevice *scubusdev, *gicbusdev, *gtimerbusdev, *mptimerbusdev,
                  *wdtbusdev;
-    Error *err = NULL;
     int i;
     bool has_el3;
     Object *cpuobj;
 
     scudev = DEVICE(&s->scu);
     qdev_prop_set_uint32(scudev, "num-cpu", s->num_cpu);
-    sysbus_realize(SYS_BUS_DEVICE(&s->scu), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
     }
     scubusdev = SYS_BUS_DEVICE(&s->scu);
@@ -78,9 +75,7 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
         object_property_get_bool(cpuobj, "has_el3", &error_abort);
     qdev_prop_set_bit(gicdev, "has-security-extensions", has_el3);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
         return;
     }
     gicbusdev = SYS_BUS_DEVICE(&s->gic);
@@ -93,27 +88,21 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
 
     gtimerdev = DEVICE(&s->gtimer);
     qdev_prop_set_uint32(gtimerdev, "num-cpu", s->num_cpu);
-    sysbus_realize(SYS_BUS_DEVICE(&s->gtimer), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gtimer), errp)) {
         return;
     }
     gtimerbusdev = SYS_BUS_DEVICE(&s->gtimer);
 
     mptimerdev = DEVICE(&s->mptimer);
     qdev_prop_set_uint32(mptimerdev, "num-cpu", s->num_cpu);
-    sysbus_realize(SYS_BUS_DEVICE(&s->mptimer), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mptimer), errp)) {
         return;
     }
     mptimerbusdev = SYS_BUS_DEVICE(&s->mptimer);
 
     wdtdev = DEVICE(&s->wdt);
     qdev_prop_set_uint32(wdtdev, "num-cpu", s->num_cpu);
-    sysbus_realize(SYS_BUS_DEVICE(&s->wdt), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt), errp)) {
         return;
     }
     wdtbusdev = SYS_BUS_DEVICE(&s->wdt);
diff --git a/hw/cpu/arm11mpcore.c b/hw/cpu/arm11mpcore.c
index a2afb992fb..89c4e35143 100644
--- a/hw/cpu/arm11mpcore.c
+++ b/hw/cpu/arm11mpcore.c
@@ -76,12 +76,9 @@ static void mpcore_priv_realize(DeviceState *dev, Error **errp)
     DeviceState *gicdev = DEVICE(&s->gic);
     DeviceState *mptimerdev = DEVICE(&s->mptimer);
     DeviceState *wdtimerdev = DEVICE(&s->wdtimer);
-    Error *err = NULL;
 
     qdev_prop_set_uint32(scudev, "num-cpu", s->num_cpu);
-    sysbus_realize(SYS_BUS_DEVICE(&s->scu), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
     }
 
@@ -91,9 +88,7 @@ static void mpcore_priv_realize(DeviceState *dev, Error **errp)
                          ARM11MPCORE_NUM_GIC_PRIORITY_BITS);
 
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
         return;
     }
 
@@ -104,16 +99,12 @@ static void mpcore_priv_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_in(dev, mpcore_priv_set_irq, s->num_irq - 32);
 
     qdev_prop_set_uint32(mptimerdev, "num-cpu", s->num_cpu);
-    sysbus_realize(SYS_BUS_DEVICE(&s->mptimer), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mptimer), errp)) {
         return;
     }
 
     qdev_prop_set_uint32(wdtimerdev, "num-cpu", s->num_cpu);
-    sysbus_realize(SYS_BUS_DEVICE(&s->wdtimer), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdtimer), errp)) {
         return;
     }
 
diff --git a/hw/cpu/realview_mpcore.c b/hw/cpu/realview_mpcore.c
index d2e426fa45..96f4d2517a 100644
--- a/hw/cpu/realview_mpcore.c
+++ b/hw/cpu/realview_mpcore.c
@@ -65,14 +65,11 @@ static void realview_mpcore_realize(DeviceState *dev, Error **errp)
     DeviceState *priv = DEVICE(&s->priv);
     DeviceState *gic;
     SysBusDevice *gicbusdev;
-    Error *err = NULL;
     int n;
     int i;
 
     qdev_prop_set_uint32(priv, "num-cpu", s->num_cpu);
-    sysbus_realize(SYS_BUS_DEVICE(&s->priv), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->priv), errp)) {
         return;
     }
     sysbus_pass_irq(sbd, SYS_BUS_DEVICE(&s->priv));
@@ -81,9 +78,7 @@ static void realview_mpcore_realize(DeviceState *dev, Error **errp)
     }
     /* ??? IRQ routing is hardcoded to "normal" mode.  */
     for (n = 0; n < 4; n++) {
-        sysbus_realize(SYS_BUS_DEVICE(&s->gic[n]), &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic[n]), errp)) {
             return;
         }
         gic = DEVICE(&s->gic[n]);
diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index 41b88b878d..93ba5956ed 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -31,13 +31,9 @@ static void virtio_gpu_pci_base_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     VirtIOGPUBase *g = vgpu->vgpu;
     DeviceState *vdev = DEVICE(g);
     int i;
-    Error *local_error = NULL;
 
     virtio_pci_force_virtio_1(vpci_dev);
-    qdev_realize(vdev, BUS(&vpci_dev->bus), &local_error);
-
-    if (local_error) {
-        error_propagate(errp, local_error);
+    if (!qdev_realize(vdev, BUS(&vpci_dev->bus), errp)) {
         return;
     }
 
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 67f409e106..fd550b35c8 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -93,7 +93,6 @@ static void virtio_vga_base_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     VirtIOVGABase *vvga = VIRTIO_VGA_BASE(vpci_dev);
     VirtIOGPUBase *g = vvga->vgpu;
     VGACommonState *vga = &vvga->vga;
-    Error *err = NULL;
     uint32_t offset;
     int i;
 
@@ -138,9 +137,7 @@ static void virtio_vga_base_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 
     /* init virtio bits */
     virtio_pci_force_virtio_1(vpci_dev);
-    qdev_realize(DEVICE(g), BUS(&vpci_dev->bus), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(g), BUS(&vpci_dev->bus), errp)) {
         return;
     }
 
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index af9f4c5a85..3c4b6e6d70 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2619,7 +2619,6 @@ static void nvic_systick_trigger(void *opaque, int n, int level)
 static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
 {
     NVICState *s = NVIC(dev);
-    Error *err = NULL;
     int regionlen;
 
     /* The armv7m container object will have set our CPU pointer */
@@ -2640,9 +2639,7 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
 
     s->num_prio_bits = arm_feature(&s->cpu->env, ARM_FEATURE_V7) ? 8 : 2;
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->systick[M_REG_NS]), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->systick[M_REG_NS]), errp)) {
         return;
     }
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->systick[M_REG_NS]), 0,
@@ -2657,9 +2654,7 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
         object_initialize_child(OBJECT(dev), "systick-reg-s",
                                 &s->systick[M_REG_S], TYPE_SYSTICK);
 
-        sysbus_realize(SYS_BUS_DEVICE(&s->systick[M_REG_S]), &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->systick[M_REG_S]), errp)) {
             return;
         }
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->systick[M_REG_S]), 0,
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 85ba0b4655..7d33457e81 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1833,9 +1833,7 @@ static void pnv_xive_realize(DeviceState *dev, Error **errp)
                             &error_fatal);
     object_property_set_link(OBJECT(xsrc), OBJECT(xive), "xive",
                              &error_abort);
-    qdev_realize(DEVICE(xsrc), NULL, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(xsrc), NULL, errp)) {
         return;
     }
 
@@ -1843,9 +1841,7 @@ static void pnv_xive_realize(DeviceState *dev, Error **errp)
                             &error_fatal);
     object_property_set_link(OBJECT(end_xsrc), OBJECT(xive), "xive",
                              &error_abort);
-    qdev_realize(DEVICE(end_xsrc), NULL, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(end_xsrc), NULL, errp)) {
         return;
     }
 
diff --git a/hw/intc/realview_gic.c b/hw/intc/realview_gic.c
index f11fb5259a..9b12116b2a 100644
--- a/hw/intc/realview_gic.c
+++ b/hw/intc/realview_gic.c
@@ -26,7 +26,6 @@ static void realview_gic_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     RealViewGICState *s = REALVIEW_GIC(dev);
     SysBusDevice *busdev;
-    Error *err = NULL;
     /* The GICs on the RealView boards have a fixed nonconfigurable
      * number of interrupt lines, so we don't need to expose this as
      * a qdev property.
@@ -34,9 +33,7 @@ static void realview_gic_realize(DeviceState *dev, Error **errp)
     int numirq = 96;
 
     qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", numirq);
-    sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
         return;
     }
     busdev = SYS_BUS_DEVICE(&s->gic);
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index b7fc8dde7a..4e9ee90353 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -312,9 +312,7 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
                             &error_fatal);
     object_property_set_link(OBJECT(xsrc), OBJECT(xive), "xive",
                              &error_abort);
-    qdev_realize(DEVICE(xsrc), NULL, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(xsrc), NULL, errp)) {
         return;
     }
     sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xsrc->esb_mmio);
@@ -326,9 +324,7 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
                             &error_fatal);
     object_property_set_link(OBJECT(end_xsrc), OBJECT(xive), "xive",
                              &error_abort);
-    qdev_realize(DEVICE(end_xsrc), NULL, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(end_xsrc), NULL, errp)) {
         return;
     }
     sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index d365eeca66..0d336fb033 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -376,7 +376,6 @@ static const TypeInfo icp_info = {
 
 Object *icp_create(Object *cpu, const char *type, XICSFabric *xi, Error **errp)
 {
-    Error *local_err = NULL;
     Object *obj;
 
     obj = object_new(type);
@@ -384,10 +383,8 @@ Object *icp_create(Object *cpu, const char *type, XICSFabric *xi, Error **errp)
     object_unref(obj);
     object_property_set_link(obj, OBJECT(xi), ICP_PROP_XICS, &error_abort);
     object_property_set_link(obj, cpu, ICP_PROP_CPU, &error_abort);
-    qdev_realize(DEVICE(obj), NULL, &local_err);
-    if (local_err) {
+    if (!qdev_realize(DEVICE(obj), NULL, errp)) {
         object_unparent(obj);
-        error_propagate(errp, local_err);
         obj = NULL;
     }
 
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 2c30dc53d8..8e167306e7 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -765,8 +765,7 @@ Object *xive_tctx_create(Object *cpu, XivePresenter *xptr, Error **errp)
     object_unref(obj);
     object_property_set_link(obj, cpu, "cpu", &error_abort);
     object_property_set_link(obj, OBJECT(xptr), "presenter", &error_abort);
-    qdev_realize(DEVICE(obj), NULL, &local_err);
-    if (local_err) {
+    if (!qdev_realize(DEVICE(obj), NULL, &local_err)) {
         goto error;
     }
 
diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index f634bcb2d1..ac044afa95 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -150,7 +150,6 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
     PIIX4State *s = PIIX4_PCI_DEVICE(dev);
     ISABus *isa_bus;
     qemu_irq *i8259_out_irq;
-    Error *err = NULL;
 
     isa_bus = isa_bus_new(DEVICE(dev), pci_address_space(dev),
                           pci_address_space_io(dev), errp);
@@ -183,9 +182,7 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
 
     /* RTC */
     qdev_prop_set_int32(DEVICE(&s->rtc), "base_year", 2000);
-    qdev_realize(DEVICE(&s->rtc), BUS(isa_bus), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->rtc), BUS(isa_bus), errp)) {
         return;
     }
     isa_init_irq(ISA_DEVICE(&s->rtc), &s->rtc.irq, RTC_ISA_IRQ);
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index abebc7e2ef..cd4f3427d8 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -76,7 +76,6 @@ static void xlnx_zynqmp_pmu_soc_init(Object *obj)
 static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
 {
     XlnxZynqMPPMUSoCState *s = XLNX_ZYNQMP_PMU_SOC(dev);
-    Error *err = NULL;
 
     object_property_set_uint(OBJECT(&s->cpu), XLNX_ZYNQMP_PMU_ROM_ADDR,
                              "base-vectors", &error_abort);
@@ -96,9 +95,7 @@ static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
     object_property_set_str(OBJECT(&s->cpu), "8.40.b", "version",
                             &error_abort);
     object_property_set_uint(OBJECT(&s->cpu), 0, "pvr", &error_abort);
-    qdev_realize(DEVICE(&s->cpu), NULL, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->cpu), NULL, errp)) {
         return;
     }
 
@@ -108,9 +105,7 @@ static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
                              &error_abort);
     object_property_set_uint(OBJECT(&s->intc), 0xffff, "intc-positive",
                              &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->intc), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->intc), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->intc), 0, XLNX_ZYNQMP_PMU_INTC_ADDR);
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 0d7f3cf673..b4f2306596 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -71,7 +71,6 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     CPUMIPSState *env;
     MIPSCPU *cpu;
     int i;
-    Error *err = NULL;
     target_ulong gcr_base;
     bool itu_present = false;
     bool saar_present = false;
@@ -109,9 +108,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
         if (saar_present) {
             s->itu.saar = &env->CP0_SAAR;
         }
-        sysbus_realize(SYS_BUS_DEVICE(&s->itu), &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->itu), errp)) {
             return;
         }
 
@@ -125,9 +122,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
                             &error_abort);
     object_property_set_int(OBJECT(&s->cpc), 1, "vp-start-running",
                             &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->cpc), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpc), errp)) {
         return;
     }
 
@@ -140,9 +135,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
                             &error_abort);
     object_property_set_int(OBJECT(&s->gic), 128, "num-irq",
                             &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
         return;
     }
 
@@ -163,9 +156,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
                              &error_abort);
     object_property_set_link(OBJECT(&s->gcr), OBJECT(&s->cpc.mr), "cpc",
                              &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->gcr), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gcr), errp)) {
         return;
     }
 
diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 47aa3b0552..0d29d53116 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -524,13 +524,10 @@ static void cuda_reset(DeviceState *dev)
 static void cuda_realize(DeviceState *dev, Error **errp)
 {
     CUDAState *s = CUDA(dev);
-    Error *err = NULL;
     SysBusDevice *sbd;
     struct tm tm;
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->mos6522_cuda), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mos6522_cuda), errp)) {
         return;
     }
 
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 3251c79f46..7cfe357cc4 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -98,11 +98,8 @@ static void macio_common_realize(PCIDevice *d, Error **errp)
 {
     MacIOState *s = MACIO(d);
     SysBusDevice *sysbus_dev;
-    Error *err = NULL;
 
-    qdev_realize(DEVICE(&s->dbdma), BUS(&s->macio_bus), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->dbdma), BUS(&s->macio_bus), errp)) {
         return;
     }
     sysbus_dev = SYS_BUS_DEVICE(&s->dbdma);
@@ -116,9 +113,7 @@ static void macio_common_realize(PCIDevice *d, Error **errp)
     qdev_prop_set_chr(DEVICE(&s->escc), "chrB", serial_hd(1));
     qdev_prop_set_uint32(DEVICE(&s->escc), "chnBtype", escc_serial);
     qdev_prop_set_uint32(DEVICE(&s->escc), "chnAtype", escc_serial);
-    qdev_realize(DEVICE(&s->escc), BUS(&s->macio_bus), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->escc), BUS(&s->macio_bus), errp)) {
         return;
     }
 
@@ -159,9 +154,7 @@ static void macio_oldworld_realize(PCIDevice *d, Error **errp)
 
     qdev_prop_set_uint64(DEVICE(&s->cuda), "timebase-frequency",
                          s->frequency);
-    qdev_realize(DEVICE(&s->cuda), BUS(&s->macio_bus), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->cuda), BUS(&s->macio_bus), errp)) {
         return;
     }
     sysbus_dev = SYS_BUS_DEVICE(&s->cuda);
@@ -176,9 +169,7 @@ static void macio_oldworld_realize(PCIDevice *d, Error **errp)
     sysbus_connect_irq(sysbus_dev, 1, qdev_get_gpio_in(pic_dev,
                                                        OLDWORLD_ESCCA_IRQ));
 
-    qdev_realize(DEVICE(&os->nvram), BUS(&s->macio_bus), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&os->nvram), BUS(&s->macio_bus), errp)) {
         return;
     }
     sysbus_dev = SYS_BUS_DEVICE(&os->nvram);
@@ -345,9 +336,7 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
         object_property_set_link(OBJECT(&s->pmu), OBJECT(sysbus_dev), "gpio",
                                  &error_abort);
         qdev_prop_set_bit(DEVICE(&s->pmu), "has-adb", ns->has_adb);
-        qdev_realize(DEVICE(&s->pmu), BUS(&s->macio_bus), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!qdev_realize(DEVICE(&s->pmu), BUS(&s->macio_bus), errp)) {
             return;
         }
         sysbus_dev = SYS_BUS_DEVICE(&s->pmu);
@@ -363,9 +352,7 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
         qdev_prop_set_uint64(DEVICE(&s->cuda), "timebase-frequency",
                              s->frequency);
 
-        qdev_realize(DEVICE(&s->cuda), BUS(&s->macio_bus), &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!qdev_realize(DEVICE(&s->cuda), BUS(&s->macio_bus), errp)) {
             return;
         }
         sysbus_dev = SYS_BUS_DEVICE(&s->cuda);
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index 41b626c46c..4b0983697c 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -741,13 +741,10 @@ static void pmu_reset(DeviceState *dev)
 static void pmu_realize(DeviceState *dev, Error **errp)
 {
     PMUState *s = VIA_PMU(dev);
-    Error *err = NULL;
     SysBusDevice *sbd;
     struct tm tm;
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->mos6522_pmu), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mos6522_pmu), errp)) {
         return;
     }
 
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 3ec904a55f..d85ca709d9 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -990,7 +990,6 @@ static void pnv_phb3_realize(DeviceState *dev, Error **errp)
     PnvPHB3 *phb = PNV_PHB3(dev);
     PCIHostState *pci = PCI_HOST_BRIDGE(dev);
     PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
-    Error *local_err = NULL;
     int i;
 
     if (phb->phb_id >= PNV8_CHIP_PHB3_MAX) {
@@ -1003,9 +1002,7 @@ static void pnv_phb3_realize(DeviceState *dev, Error **errp)
                                    &error_abort);
     object_property_set_int(OBJECT(&phb->lsis), PNV_PHB3_NUM_LSI, "nr-irqs",
                             &error_abort);
-    qdev_realize(DEVICE(&phb->lsis), NULL, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(&phb->lsis), NULL, errp)) {
         return;
     }
 
@@ -1022,18 +1019,14 @@ static void pnv_phb3_realize(DeviceState *dev, Error **errp)
                                    &error_abort);
     object_property_set_int(OBJECT(&phb->msis), PHB3_MAX_MSI, "nr-irqs",
                             &error_abort);
-    qdev_realize(DEVICE(&phb->msis), NULL, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(&phb->msis), NULL, errp)) {
         return;
     }
 
     /* Power Bus Common Queue */
     object_property_set_link(OBJECT(&phb->pbcq), OBJECT(phb), "phb",
                                    &error_abort);
-    qdev_realize(DEVICE(&phb->pbcq), NULL, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(&phb->pbcq), NULL, errp)) {
         return;
     }
 
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 10716d759d..7739fd5984 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1169,7 +1169,6 @@ static void pnv_phb4_realize(DeviceState *dev, Error **errp)
     PnvPHB4 *phb = PNV_PHB4(dev);
     PCIHostState *pci = PCI_HOST_BRIDGE(dev);
     XiveSource *xsrc = &phb->xsrc;
-    Error *local_err = NULL;
     int nr_irqs;
     char name[32];
 
@@ -1218,9 +1217,7 @@ static void pnv_phb4_realize(DeviceState *dev, Error **errp)
     }
     object_property_set_int(OBJECT(xsrc), nr_irqs, "nr-irqs", &error_fatal);
     object_property_set_link(OBJECT(xsrc), OBJECT(phb), "xive", &error_fatal);
-    qdev_realize(DEVICE(xsrc), NULL, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(xsrc), NULL, errp)) {
         return;
     }
 
diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
index 2d634c838e..40f993bd06 100644
--- a/hw/pci-host/pnv_phb4_pec.c
+++ b/hw/pci-host/pnv_phb4_pec.c
@@ -377,7 +377,6 @@ static void pnv_pec_instance_init(Object *obj)
 static void pnv_pec_realize(DeviceState *dev, Error **errp)
 {
     PnvPhb4PecState *pec = PNV_PHB4_PEC(dev);
-    Error *local_err = NULL;
     char name[64];
     int i;
 
@@ -390,9 +389,7 @@ static void pnv_pec_realize(DeviceState *dev, Error **errp)
 
         object_property_set_int(stk_obj, i, "stack-no", &error_abort);
         object_property_set_link(stk_obj, OBJECT(pec), "pec", &error_abort);
-        qdev_realize(DEVICE(stk_obj), NULL, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (!qdev_realize(DEVICE(stk_obj), NULL, errp)) {
             return;
         }
     }
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 51bf95b303..5448d101d9 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -764,16 +764,13 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE500MachineState *pms,
 static DeviceState *ppce500_init_mpic_kvm(const PPCE500MachineClass *pmc,
                                           IrqLines *irqs, Error **errp)
 {
-    Error *err = NULL;
     DeviceState *dev;
     CPUState *cs;
 
     dev = qdev_new(TYPE_KVM_OPENPIC);
     qdev_prop_set_uint32(dev, "model", pmc->mpic_version);
 
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp)) {
         object_unparent(OBJECT(dev));
         return NULL;
     }
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 8bd03f3b10..392aa138de 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1137,9 +1137,7 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
                             "bar", &error_fatal);
     object_property_set_link(OBJECT(&chip8->psi), OBJECT(chip8->xics),
                              ICS_PROP_XICS, &error_abort);
-    qdev_realize(DEVICE(&chip8->psi), NULL, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(&chip8->psi), NULL, errp)) {
         return;
     }
     pnv_xscom_add_subregion(chip, PNV_XSCOM_PSIHB_BASE,
@@ -1168,9 +1166,7 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
     /* Create the simplified OCC model */
     object_property_set_link(OBJECT(&chip8->occ), OBJECT(&chip8->psi), "psi",
                              &error_abort);
-    qdev_realize(DEVICE(&chip8->occ), NULL, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(&chip8->occ), NULL, errp)) {
         return;
     }
     pnv_xscom_add_subregion(chip, PNV_XSCOM_OCC_BASE, &chip8->occ.xscom_regs);
@@ -1182,9 +1178,7 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
     /* HOMER */
     object_property_set_link(OBJECT(&chip8->homer), OBJECT(chip), "chip",
                              &error_abort);
-    qdev_realize(DEVICE(&chip8->homer), NULL, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(&chip8->homer), NULL, errp)) {
         return;
     }
     /* Homer Xscom region */
@@ -1202,9 +1196,7 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
         object_property_set_int(OBJECT(phb), i, "index", &error_fatal);
         object_property_set_int(OBJECT(phb), chip->chip_id, "chip-id",
                                 &error_fatal);
-        sysbus_realize(SYS_BUS_DEVICE(phb), &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(phb), errp)) {
             return;
         }
 
@@ -1359,7 +1351,6 @@ static void pnv_chip_quad_realize(Pnv9Chip *chip9, Error **errp)
 static void pnv_chip_power9_phb_realize(PnvChip *chip, Error **errp)
 {
     Pnv9Chip *chip9 = PNV9_CHIP(chip);
-    Error *local_err = NULL;
     int i, j;
     int phb_id = 0;
 
@@ -1381,9 +1372,7 @@ static void pnv_chip_power9_phb_realize(PnvChip *chip, Error **errp)
                                  &error_fatal);
         object_property_set_link(OBJECT(pec), OBJECT(get_system_memory()),
                                  "system-memory", &error_abort);
-        qdev_realize(DEVICE(pec), NULL, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (!qdev_realize(DEVICE(pec), NULL, errp)) {
             return;
         }
 
@@ -1406,9 +1395,7 @@ static void pnv_chip_power9_phb_realize(PnvChip *chip, Error **errp)
             object_property_set_int(obj, PNV_PHB4_DEVICE_ID, "device-id",
                                     &error_fatal);
             object_property_set_link(obj, OBJECT(stack), "stack", &error_abort);
-            sysbus_realize(SYS_BUS_DEVICE(obj), &local_err);
-            if (local_err) {
-                error_propagate(errp, local_err);
+            if (!sysbus_realize(SYS_BUS_DEVICE(obj), errp)) {
                 return;
             }
 
@@ -1466,9 +1453,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
                             "tm-bar", &error_fatal);
     object_property_set_link(OBJECT(&chip9->xive), OBJECT(chip), "chip",
                              &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&chip9->xive), &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&chip9->xive), errp)) {
         return;
     }
     pnv_xscom_add_subregion(chip, PNV9_XSCOM_XIVE_BASE,
@@ -1477,9 +1462,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     /* Processor Service Interface (PSI) Host Bridge */
     object_property_set_int(OBJECT(&chip9->psi), PNV9_PSIHB_BASE(chip),
                             "bar", &error_fatal);
-    qdev_realize(DEVICE(&chip9->psi), NULL, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(&chip9->psi), NULL, errp)) {
         return;
     }
     pnv_xscom_add_subregion(chip, PNV9_XSCOM_PSIHB_BASE,
@@ -1488,9 +1471,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     /* LPC */
     object_property_set_link(OBJECT(&chip9->lpc), OBJECT(&chip9->psi), "psi",
                              &error_abort);
-    qdev_realize(DEVICE(&chip9->lpc), NULL, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(&chip9->lpc), NULL, errp)) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), PNV9_LPCM_BASE(chip),
@@ -1502,9 +1483,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     /* Create the simplified OCC model */
     object_property_set_link(OBJECT(&chip9->occ), OBJECT(&chip9->psi), "psi",
                              &error_abort);
-    qdev_realize(DEVICE(&chip9->occ), NULL, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(&chip9->occ), NULL, errp)) {
         return;
     }
     pnv_xscom_add_subregion(chip, PNV9_XSCOM_OCC_BASE, &chip9->occ.xscom_regs);
@@ -1516,9 +1495,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     /* HOMER */
     object_property_set_link(OBJECT(&chip9->homer), OBJECT(chip), "chip",
                              &error_abort);
-    qdev_realize(DEVICE(&chip9->homer), NULL, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(&chip9->homer), NULL, errp)) {
         return;
     }
     /* Homer Xscom region */
@@ -1598,9 +1575,7 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     /* Processor Service Interface (PSI) Host Bridge */
     object_property_set_int(OBJECT(&chip10->psi), PNV10_PSIHB_BASE(chip),
                             "bar", &error_fatal);
-    qdev_realize(DEVICE(&chip10->psi), NULL, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(&chip10->psi), NULL, errp)) {
         return;
     }
     pnv_xscom_add_subregion(chip, PNV10_XSCOM_PSIHB_BASE,
@@ -1609,9 +1584,7 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     /* LPC */
     object_property_set_link(OBJECT(&chip10->lpc), OBJECT(&chip10->psi), "psi",
                              &error_abort);
-    qdev_realize(DEVICE(&chip10->lpc), NULL, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(&chip10->lpc), NULL, errp)) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), PNV10_LPCM_BASE(chip),
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index c986c16db1..4724ddf96c 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -173,9 +173,7 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp)
     Error *local_err = NULL;
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(pc->chip);
 
-    qdev_realize(DEVICE(cpu), NULL, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(cpu), NULL, errp)) {
         return;
     }
 
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 75b8ae9703..08756a79cd 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -510,9 +510,7 @@ static void pnv_psi_power8_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    qdev_realize(DEVICE(ics), NULL, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(ics), NULL, errp)) {
         return;
     }
 
@@ -842,7 +840,6 @@ static void pnv_psi_power9_realize(DeviceState *dev, Error **errp)
 {
     PnvPsi *psi = PNV_PSI(dev);
     XiveSource *xsrc = &PNV9_PSI(psi)->source;
-    Error *local_err = NULL;
     int i;
 
     /* This is the only device with 4k ESB pages */
@@ -851,9 +848,7 @@ static void pnv_psi_power9_realize(DeviceState *dev, Error **errp)
     object_property_set_int(OBJECT(xsrc), PSIHB9_NUM_IRQS, "nr-irqs",
                             &error_fatal);
     object_property_set_link(OBJECT(xsrc), OBJECT(psi), "xive", &error_abort);
-    qdev_realize(DEVICE(xsrc), NULL, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(xsrc), NULL, errp)) {
         return;
     }
 
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 26ad566f42..85330d08a1 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -239,8 +239,7 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
     CPUState *cs = CPU(cpu);
     Error *local_err = NULL;
 
-    qdev_realize(DEVICE(cpu), NULL, &local_err);
-    if (local_err) {
+    if (!qdev_realize(DEVICE(cpu), NULL, &local_err)) {
         goto error;
     }
 
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 897bf98587..a61d39ad71 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -302,7 +302,6 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
     spapr_irq_msi_init(spapr);
 
     if (spapr->irq->xics) {
-        Error *local_err = NULL;
         Object *obj;
 
         obj = object_new(TYPE_ICS_SPAPR);
@@ -311,9 +310,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
         object_property_set_link(obj, OBJECT(spapr), ICS_PROP_XICS,
                                  &error_abort);
         object_property_set_int(obj, smc->nr_xirqs, "nr-irqs", &error_abort);
-        qdev_realize(DEVICE(obj), NULL, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (!qdev_realize(DEVICE(obj), NULL, errp)) {
             return;
         }
 
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 19223e4c29..d40f065a6a 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -106,7 +106,6 @@ static void lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     LowRISCIbexSoCState *s = RISCV_IBEX_SOC(dev_soc);
     MemoryRegion *sys_mem = get_system_memory();
-    Error *err = NULL;
 
     object_property_set_str(OBJECT(&s->cpus), ms->cpu_type, "cpu-type",
                             &error_abort);
@@ -127,18 +126,14 @@ static void lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
                                 &s->flash_mem);
 
     /* PLIC */
-    sysbus_realize(SYS_BUS_DEVICE(&s->plic), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->plic), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->plic), 0, memmap[IBEX_PLIC].base);
 
     /* UART */
     qdev_prop_set_chr(DEVICE(&(s->uart)), "chardev", serial_hd(0));
-    sysbus_realize(SYS_BUS_DEVICE(&s->uart), &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart), 0, memmap[IBEX_UART].base);
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 0cb66ac4e2..416adfcce0 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -185,8 +185,6 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     const struct MemmapEntry *memmap = sifive_e_memmap;
-    Error *err = NULL;
-
     SiFiveESoCState *s = RISCV_E_SOC(dev);
     MemoryRegion *sys_mem = get_system_memory();
 
@@ -221,9 +219,7 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
 
     /* GPIO */
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
     }
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index a1d2edfe13..12cd91b227 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -608,7 +608,6 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     char *plic_hart_config;
     size_t plic_hart_config_len;
     int i;
-    Error *err = NULL;
     NICInfo *nd = &nd_table[0];
 
     sysbus_realize(SYS_BUS_DEVICE(&s->e_cpus), &error_abort);
@@ -710,9 +709,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     }
     object_property_set_int(OBJECT(&s->gem), GEM_REVISION, "revision",
                             &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->gem), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gem), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem), 0, memmap[SIFIVE_U_GEM].base);
diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 164b1fd295..645b4080c5 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -442,18 +442,13 @@ static void init_event_facility(Object *obj)
 static void realize_event_facility(DeviceState *dev, Error **errp)
 {
     SCLPEventFacility *event_facility = EVENT_FACILITY(dev);
-    Error *local_err = NULL;
 
-    qdev_realize(DEVICE(&event_facility->quiesce),
-                 BUS(&event_facility->sbus), &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(&event_facility->quiesce),
+                      BUS(&event_facility->sbus), errp)) {
         return;
     }
-    qdev_realize(DEVICE(&event_facility->cpu_hotplug),
-                 BUS(&event_facility->sbus), &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(&event_facility->cpu_hotplug),
+                      BUS(&event_facility->sbus), errp)) {
         qdev_unrealize(DEVICE(&event_facility->quiesce));
         return;
     }
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 142e52a8ff..0517901024 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -829,8 +829,7 @@ static S390PCIBusDevice *s390_pci_device_new(S390pciState *s,
                                 "zPCI device could not be created: ");
         return NULL;
     }
-    qdev_realize_and_unref(dev, BUS(s->bus), &local_err);
-    if (local_err) {
+    if (!qdev_realize_and_unref(dev, BUS(s->bus), &local_err)) {
         object_unparent(OBJECT(dev));
         error_propagate_prepend(errp, local_err,
                                 "zPCI device could not be created: ");
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index d39f6d7785..03364343eb 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -338,8 +338,7 @@ static void sclp_realize(DeviceState *dev, Error **errp)
      * as we can't find a fitting bus via the qom tree, we have to add the
      * event facility to the sysbus, so e.g. a sclp console can be created.
      */
-    sysbus_realize(SYS_BUS_DEVICE(sclp->event_facility), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(sclp->event_facility), &err)) {
         goto out;
     }
 
diff --git a/hw/s390x/virtio-ccw-crypto.c b/hw/s390x/virtio-ccw-crypto.c
index ca6753bff3..438626cf37 100644
--- a/hw/s390x/virtio-ccw-crypto.c
+++ b/hw/s390x/virtio-ccw-crypto.c
@@ -19,11 +19,8 @@ static void virtio_ccw_crypto_realize(VirtioCcwDevice *ccw_dev, Error **errp)
 {
     VirtIOCryptoCcw *dev = VIRTIO_CRYPTO_CCW(ccw_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);
-    Error *err = NULL;
 
-    qdev_realize(vdev, BUS(&ccw_dev->bus), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!qdev_realize(vdev, BUS(&ccw_dev->bus), errp)) {
         return;
     }
 
diff --git a/hw/s390x/virtio-ccw-rng.c b/hw/s390x/virtio-ccw-rng.c
index 4077160f49..aefe6b1b51 100644
--- a/hw/s390x/virtio-ccw-rng.c
+++ b/hw/s390x/virtio-ccw-rng.c
@@ -20,11 +20,8 @@ static void virtio_ccw_rng_realize(VirtioCcwDevice *ccw_dev, Error **errp)
 {
     VirtIORNGCcw *dev = VIRTIO_RNG_CCW(ccw_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);
-    Error *err = NULL;
 
-    qdev_realize(vdev, BUS(&ccw_dev->bus), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!qdev_realize(vdev, BUS(&ccw_dev->bus), errp)) {
         return;
     }
 
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index b878a08080..f3d2d63de8 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -293,9 +293,7 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
     qdev_prop_set_enum(dev, "rerror", rerror);
     qdev_prop_set_enum(dev, "werror", werror);
 
-    qdev_realize_and_unref(dev, &bus->qbus, &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!qdev_realize_and_unref(dev, &bus->qbus, errp)) {
         object_unparent(OBJECT(dev));
         return NULL;
     }
diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
index 538d3bad3d..ad0bb6fdb4 100644
--- a/hw/sd/aspeed_sdhci.c
+++ b/hw/sd/aspeed_sdhci.c
@@ -145,9 +145,7 @@ static void aspeed_sdhci_realize(DeviceState *dev, Error **errp)
             return;
         }
 
-        sysbus_realize(sbd_slot, &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(sbd_slot, errp)) {
             return;
         }
 
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 25cec2ddea..0df0edb51d 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -266,8 +266,7 @@ static void ssi_sd_realize(SSISlave *d, Error **errp)
         goto fail;
     }
 
-    qdev_realize_and_unref(carddev, BUS(&s->sdbus), &err);
-    if (err) {
+    if (!qdev_realize_and_unref(carddev, BUS(&s->sdbus), &err)) {
         goto fail;
     }
 
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 957559b18d..ba27afe9f2 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -704,8 +704,7 @@ USBDevice *usbdevice_create(const char *cmdline)
         error_report("Failed to create USB device '%s'", f->name);
         return NULL;
     }
-    usb_realize_and_unref(dev, bus, &err);
-    if (err) {
+    if (!usb_realize_and_unref(dev, bus, &err)) {
         error_reportf_err(err, "Failed to initialize USB device '%s': ",
                           f->name);
         object_unparent(OBJECT(dev));
diff --git a/hw/virtio/virtio-rng-pci.c b/hw/virtio/virtio-rng-pci.c
index cf1afb47a6..b6cb0199a3 100644
--- a/hw/virtio/virtio-rng-pci.c
+++ b/hw/virtio/virtio-rng-pci.c
@@ -34,11 +34,8 @@ static void virtio_rng_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
     VirtIORngPCI *vrng = VIRTIO_RNG_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&vrng->vdev);
-    Error *err = NULL;
 
-    qdev_realize(vdev, BUS(&vpci_dev->bus), &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!qdev_realize(vdev, BUS(&vpci_dev->bus), errp)) {
         return;
     }
 
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 22da107484..13a13a811a 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -676,8 +676,7 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
     }
 
     dev->opts = opts;
-    qdev_realize(DEVICE(dev), bus, &err);
-    if (err != NULL) {
+    if (!qdev_realize(DEVICE(dev), bus, &err)) {
         dev->opts = NULL;
         goto err_del_dev;
     }
-- 
2.26.2


