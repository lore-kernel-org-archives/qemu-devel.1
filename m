Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B04C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43051206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VbcGobC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43051206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtHiK-0008Pn-Fm
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 17:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHbQ-0007tP-0t
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:27:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26012
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHbK-00022M-Ph
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594243654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f8d4+yMcm+iTqUUFGTThH4Vo4K3I2FQ4zKAyZ87b/JI=;
 b=VbcGobC+TK/axhJfv4OWFswi3Tz8xOmsqBDNAC8HOky2Fc6uROjhKluMHHfwSP4No54FJz
 08immi1222E5luRC8ifwyboCULpg5wPniPuU8tLvZfQsR/rPp7wpGuqcE4OgmSkzqn5HnP
 pL6LzrQRuXCLu82Ei2qh0XJ8EvqU6dE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-_pMzmnQhNA2jcWuyECTpGA-1; Tue, 07 Jul 2020 17:25:07 -0400
X-MC-Unique: _pMzmnQhNA2jcWuyECTpGA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CBF8461;
 Tue,  7 Jul 2020 21:25:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 447505C1D0;
 Tue,  7 Jul 2020 21:25:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C8DB711326E4; Tue,  7 Jul 2020 23:25:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/53] qdev: Use returned bool to check for qdev_realize() etc.
 failure
Date: Tue,  7 Jul 2020 23:24:14 +0200
Message-Id: <20200707212503.1495927-5-armbru@redhat.com>
In-Reply-To: <20200707212503.1495927-1-armbru@redhat.com>
References: <20200707212503.1495927-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Greg Kurz <groug@kaod.org>
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
    identifier fun = {
        isa_realize_and_unref, pci_realize_and_unref, qbus_realize,
        qdev_realize, qdev_realize_and_unref, sysbus_realize,
        sysbus_realize_and_unref, usb_realize_and_unref
    };
    expression list args, args2;
    typedef Error;
    Error *err;
    @@
    -    fun(args, &err, args2);
    -    if (err)
    +    if (!fun(args, &err, args2))
         {
             ...
         }

Chokes on hw/arm/musicpal.c's lcd_refresh() with the unhelpful error
message "no position information".  Nothing to convert there; skipped.

Fails to convert hw/arm/armsse.c, because Coccinelle gets confused by
ARMSSE being used both as typedef and function-like macro there.
Converted manually.

A few line breaks tidied up manually.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <20200707160613.848843-5-armbru@redhat.com>
---
 hw/arm/allwinner-a10.c          | 15 +++----
 hw/arm/armsse.c                 | 78 +++++++++++----------------------
 hw/arm/armv7m.c                 |  9 ++--
 hw/arm/aspeed_ast2600.c         | 51 +++++++--------------
 hw/arm/aspeed_soc.c             | 45 +++++++------------
 hw/arm/bcm2835_peripherals.c    | 45 +++++++------------
 hw/arm/bcm2836.c                |  9 ++--
 hw/arm/cubieboard.c             |  3 +-
 hw/arm/digic.c                  |  9 ++--
 hw/arm/digic_boards.c           |  3 +-
 hw/arm/fsl-imx25.c              | 33 +++++---------
 hw/arm/fsl-imx31.c              | 24 ++++------
 hw/arm/fsl-imx6.c               | 36 +++++----------
 hw/arm/msf2-soc.c               | 15 +++----
 hw/arm/nrf51_soc.c              | 18 +++-----
 hw/arm/stm32f205_soc.c          | 21 +++------
 hw/arm/stm32f405_soc.c          | 24 ++++------
 hw/arm/xlnx-zynqmp.c            | 45 +++++++------------
 hw/block/fdc.c                  |  3 +-
 hw/block/xen-block.c            |  3 +-
 hw/char/serial-pci-multi.c      |  3 +-
 hw/char/serial-pci.c            |  3 +-
 hw/char/serial.c                |  6 +--
 hw/core/cpu.c                   |  3 +-
 hw/cpu/a15mpcore.c              |  3 +-
 hw/cpu/a9mpcore.c               | 15 +++----
 hw/cpu/arm11mpcore.c            | 12 ++---
 hw/cpu/realview_mpcore.c        |  6 +--
 hw/display/virtio-gpu-pci.c     |  4 +-
 hw/display/virtio-vga.c         |  3 +-
 hw/intc/armv7m_nvic.c           |  6 +--
 hw/intc/pnv_xive.c              |  6 +--
 hw/intc/realview_gic.c          |  3 +-
 hw/intc/spapr_xive.c            |  6 +--
 hw/intc/xics.c                  |  3 +-
 hw/intc/xive.c                  |  3 +-
 hw/isa/piix4.c                  |  3 +-
 hw/microblaze/xlnx-zynqmp-pmu.c |  6 +--
 hw/mips/cps.c                   | 12 ++---
 hw/misc/macio/cuda.c            |  3 +-
 hw/misc/macio/macio.c           | 18 +++-----
 hw/misc/macio/pmu.c             |  3 +-
 hw/pci-host/pnv_phb3.c          |  9 ++--
 hw/pci-host/pnv_phb4.c          |  3 +-
 hw/pci-host/pnv_phb4_pec.c      |  3 +-
 hw/ppc/e500.c                   |  3 +-
 hw/ppc/pnv.c                    | 39 ++++++-----------
 hw/ppc/pnv_core.c               |  3 +-
 hw/ppc/pnv_psi.c                |  6 +--
 hw/ppc/spapr_cpu_core.c         |  3 +-
 hw/ppc/spapr_irq.c              |  3 +-
 hw/riscv/opentitan.c            |  6 +--
 hw/riscv/sifive_e.c             |  3 +-
 hw/riscv/sifive_u.c             |  3 +-
 hw/s390x/event-facility.c       | 10 ++---
 hw/s390x/s390-pci-bus.c         |  3 +-
 hw/s390x/sclp.c                 |  3 +-
 hw/s390x/virtio-ccw-crypto.c    |  3 +-
 hw/s390x/virtio-ccw-rng.c       |  3 +-
 hw/scsi/scsi-bus.c              |  3 +-
 hw/sd/aspeed_sdhci.c            |  3 +-
 hw/sd/ssi-sd.c                  |  3 +-
 hw/usb/bus.c                    |  3 +-
 hw/virtio/virtio-rng-pci.c      |  3 +-
 qdev-monitor.c                  |  3 +-
 65 files changed, 248 insertions(+), 495 deletions(-)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 52e0d83760..e1acffe5f6 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -74,14 +74,12 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sysbusdev;
     Error *err = NULL;
 
-    qdev_realize(DEVICE(&s->cpu), NULL, &err);
-    if (err != NULL) {
+    if (!qdev_realize(DEVICE(&s->cpu), NULL, &err)) {
         error_propagate(errp, err);
         return;
     }
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->intc), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->intc), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -93,8 +91,7 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
                        qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
     qdev_pass_gpios(DEVICE(&s->intc), dev, NULL);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->timer), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -117,8 +114,7 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
         qemu_check_nic_model(&nd_table[0], TYPE_AW_EMAC);
         qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
     }
-    sysbus_realize(SYS_BUS_DEVICE(&s->emac), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->emac), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -126,8 +122,7 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(sysbusdev, 0, AW_A10_EMAC_BASE);
     sysbus_connect_irq(sysbusdev, 0, qdev_get_gpio_in(dev, 55));
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->sata), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sata), &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 2fbd970b4f..9a48bf86c3 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -565,8 +565,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i]),
                                  "memory", &error_abort);
         object_property_set_link(cpuobj, OBJECT(s), "idau", &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(cpuobj), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(cpuobj), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -576,8 +575,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
          * CPU must exist and have been parented into the cluster before
          * the cluster is realized.
          */
-        qdev_realize(DEVICE(&s->cluster[i]), NULL, &err);
-        if (err) {
+        if (!qdev_realize(DEVICE(&s->cluster[i]), NULL, &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -612,8 +610,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                     error_propagate(errp, err);
                     return;
                 }
-                qdev_realize(DEVICE(splitter), NULL, &err);
-                if (err) {
+                if (!qdev_realize(DEVICE(splitter), NULL, &err)) {
                     error_propagate(errp, err);
                     return;
                 }
@@ -645,8 +642,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     }
 
     /* Security controller */
-    sysbus_realize(SYS_BUS_DEVICE(&s->secctl), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->secctl), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -668,8 +664,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    qdev_realize(DEVICE(&s->sec_resp_splitter), NULL, &err);
-    if (err) {
+    if (!qdev_realize(DEVICE(&s->sec_resp_splitter), NULL, &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -692,8 +687,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         }
         object_property_set_link(OBJECT(&s->mpc[i]), OBJECT(&s->sram[i]),
                                  "downstream", &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(&s->mpc[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->mpc[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -715,8 +709,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    qdev_realize(DEVICE(&s->mpc_irq_orgate), NULL, &err);
-    if (err) {
+    if (!qdev_realize(DEVICE(&s->mpc_irq_orgate), NULL, &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -734,8 +727,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
      * map its upstream ends to the right place in the container.
      */
     qdev_prop_set_uint32(DEVICE(&s->timer0), "pclk-frq", s->mainclk_frq);
-    sysbus_realize(SYS_BUS_DEVICE(&s->timer0), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer0), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -746,8 +738,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                              &error_abort);
 
     qdev_prop_set_uint32(DEVICE(&s->timer1), "pclk-frq", s->mainclk_frq);
-    sysbus_realize(SYS_BUS_DEVICE(&s->timer1), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer1), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -758,8 +749,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                              &error_abort);
 
     qdev_prop_set_uint32(DEVICE(&s->dualtimer), "pclk-frq", s->mainclk_frq);
-    sysbus_realize(SYS_BUS_DEVICE(&s->dualtimer), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->dualtimer), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -784,8 +774,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             int cpunum;
             SysBusDevice *mhu_sbd = SYS_BUS_DEVICE(&s->mhu[i]);
 
-            sysbus_realize(SYS_BUS_DEVICE(&s->mhu[i]), &err);
-            if (err) {
+            if (!sysbus_realize(SYS_BUS_DEVICE(&s->mhu[i]), &err)) {
                 error_propagate(errp, err);
                 return;
             }
@@ -811,8 +800,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->apb_ppc0), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->apb_ppc0), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -860,8 +848,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    qdev_realize(DEVICE(&s->ppc_irq_orgate), NULL, &err);
-    if (err) {
+    if (!qdev_realize(DEVICE(&s->ppc_irq_orgate), NULL, &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -883,8 +870,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             qdev_prop_set_string(DEVICE(&s->cachectrl[i]), "name", name);
             g_free(name);
             qdev_prop_set_uint64(DEVICE(&s->cachectrl[i]), "size", 0x1000);
-            sysbus_realize(SYS_BUS_DEVICE(&s->cachectrl[i]), &err);
-            if (err) {
+            if (!sysbus_realize(SYS_BUS_DEVICE(&s->cachectrl[i]), &err)) {
                 error_propagate(errp, err);
                 return;
             }
@@ -901,8 +887,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             qdev_prop_set_string(DEVICE(&s->cpusecctrl[i]), "name", name);
             g_free(name);
             qdev_prop_set_uint64(DEVICE(&s->cpusecctrl[i]), "size", 0x1000);
-            sysbus_realize(SYS_BUS_DEVICE(&s->cpusecctrl[i]), &err);
-            if (err) {
+            if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpusecctrl[i]), &err)) {
                 error_propagate(errp, err);
                 return;
             }
@@ -916,8 +901,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             MemoryRegion *mr;
 
             qdev_prop_set_uint32(DEVICE(&s->cpuid[i]), "CPUID", i);
-            sysbus_realize(SYS_BUS_DEVICE(&s->cpuid[i]), &err);
-            if (err) {
+            if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpuid[i]), &err)) {
                 error_propagate(errp, err);
                 return;
             }
@@ -932,8 +916,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
      *   0x4002f000: S32K timer
      */
     qdev_prop_set_uint32(DEVICE(&s->s32ktimer), "pclk-frq", S32KCLK);
-    sysbus_realize(SYS_BUS_DEVICE(&s->s32ktimer), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->s32ktimer), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -943,8 +926,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     object_property_set_link(OBJECT(&s->apb_ppc1), OBJECT(mr), "port[0]",
                              &error_abort);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->apb_ppc1), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->apb_ppc1), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -981,8 +963,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_realize(SYS_BUS_DEVICE(&s->sysinfo), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sysinfo), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -997,8 +978,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                             "INITSVTOR0_RST", &error_abort);
     object_property_set_int(OBJECT(&s->sysctl), s->init_svtor,
                             "INITSVTOR1_RST", &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->sysctl), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sysctl), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -1032,8 +1012,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    qdev_realize(DEVICE(&s->nmi_orgate), NULL, &err);
-    if (err) {
+    if (!qdev_realize(DEVICE(&s->nmi_orgate), NULL, &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -1041,8 +1020,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                           qdev_get_gpio_in_named(DEVICE(&s->armv7m), "NMI", 0));
 
     qdev_prop_set_uint32(DEVICE(&s->s32kwatchdog), "wdogclk-frq", S32KCLK);
-    sysbus_realize(SYS_BUS_DEVICE(&s->s32kwatchdog), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->s32kwatchdog), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -1053,8 +1031,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     /* 0x40080000 .. 0x4008ffff : ARMSSE second Base peripheral region */
 
     qdev_prop_set_uint32(DEVICE(&s->nswatchdog), "wdogclk-frq", s->mainclk_frq);
-    sysbus_realize(SYS_BUS_DEVICE(&s->nswatchdog), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->nswatchdog), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -1063,8 +1040,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->nswatchdog), 0, 0x40081000);
 
     qdev_prop_set_uint32(DEVICE(&s->swatchdog), "wdogclk-frq", s->mainclk_frq);
-    sysbus_realize(SYS_BUS_DEVICE(&s->swatchdog), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->swatchdog), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -1080,8 +1056,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             error_propagate(errp, err);
             return;
         }
-        qdev_realize(DEVICE(splitter), NULL, &err);
-        if (err) {
+        if (!qdev_realize(DEVICE(splitter), NULL, &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -1127,8 +1102,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             error_propagate(errp, err);
             return;
         }
-        qdev_realize(DEVICE(splitter), NULL, &err);
-        if (err) {
+        if (!qdev_realize(DEVICE(splitter), NULL, &err)) {
             error_propagate(errp, err);
             return;
         }
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 3308211e9c..28baf330e5 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -213,15 +213,13 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
     s->cpu->env.nvic = &s->nvic;
     s->nvic.cpu = s->cpu;
 
-    qdev_realize(DEVICE(s->cpu), NULL, &err);
-    if (err != NULL) {
+    if (!qdev_realize(DEVICE(s->cpu), NULL, &err)) {
         error_propagate(errp, err);
         return;
     }
 
     /* Note that we must realize the NVIC after the CPU */
-    sysbus_realize(SYS_BUS_DEVICE(&s->nvic), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->nvic), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -254,8 +252,7 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
             }
             object_property_set_link(obj, OBJECT(s->board_memory),
                                      "source-memory", &error_abort);
-            sysbus_realize(SYS_BUS_DEVICE(obj), &err);
-            if (err != NULL) {
+            if (!sysbus_realize(SYS_BUS_DEVICE(obj), &err)) {
                 error_propagate(errp, err);
                 return;
             }
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 59a7a1370b..b9ae4c12b4 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -259,8 +259,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
          * is needed when using -kernel
          */
 
-        qdev_realize(DEVICE(&s->cpu[i]), NULL, &err);
-        if (err) {
+        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -301,16 +300,14 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                                 sc->memmap[ASPEED_SRAM], &s->sram);
 
     /* SCU */
-    sysbus_realize(SYS_BUS_DEVICE(&s->scu), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), &err)) {
         error_propagate(errp, err);
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_SCU]);
 
     /* RTC */
-    sysbus_realize(SYS_BUS_DEVICE(&s->rtc), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -321,8 +318,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     /* Timer */
     object_property_set_link(OBJECT(&s->timerctrl),
                              OBJECT(&s->scu), "scu", &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -343,8 +339,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     /* I2C */
     object_property_set_link(OBJECT(&s->i2c), OBJECT(s->dram_mr), "dram",
                              &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->i2c), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -368,8 +363,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_realize(SYS_BUS_DEVICE(&s->fmc), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->fmc), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -385,8 +379,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                                  "dram", &error_abort);
         object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs",
                                 &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -398,8 +391,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
     /* EHCI */
     for (i = 0; i < sc->ehcis_num; i++) {
-        sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -410,8 +402,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
 
     /* SDMC - SDRAM Memory Controller */
-    sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -423,8 +414,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
         object_property_set_link(OBJECT(&s->wdt[i]),
                                  OBJECT(&s->scu), "scu", &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -436,8 +426,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < sc->macs_num; i++) {
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed",
                                  &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -448,8 +437,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
         object_property_set_link(OBJECT(&s->mii[i]), OBJECT(&s->ftgmac100[i]),
                                  "nic", &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(&s->mii[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->mii[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -459,8 +447,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
 
     /* XDMA */
-    sysbus_realize(SYS_BUS_DEVICE(&s->xdma), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->xdma), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -470,8 +457,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_XDMA));
 
     /* GPIO */
-    sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -479,8 +465,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
                        aspeed_soc_get_irq(s, ASPEED_GPIO));
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->gpio_1_8v), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio_1_8v), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -490,8 +475,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_GPIO_1_8V));
 
     /* SDHCI */
-    sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -501,8 +485,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_SDHCI));
 
     /* eMMC */
-    sysbus_realize(SYS_BUS_DEVICE(&s->emmc), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->emmc), &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 311458aa76..fa56f96f92 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -230,8 +230,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 
     /* CPU */
     for (i = 0; i < sc->num_cpus; i++) {
-        qdev_realize(DEVICE(&s->cpu[i]), NULL, &err);
-        if (err) {
+        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -248,16 +247,14 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                                 sc->memmap[ASPEED_SRAM], &s->sram);
 
     /* SCU */
-    sysbus_realize(SYS_BUS_DEVICE(&s->scu), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), &err)) {
         error_propagate(errp, err);
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_SCU]);
 
     /* VIC */
-    sysbus_realize(SYS_BUS_DEVICE(&s->vic), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->vic), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -268,8 +265,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                        qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
 
     /* RTC */
-    sysbus_realize(SYS_BUS_DEVICE(&s->rtc), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -280,8 +276,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     /* Timer */
     object_property_set_link(OBJECT(&s->timerctrl),
                              OBJECT(&s->scu), "scu", &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -302,8 +297,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     /* I2C */
     object_property_set_link(OBJECT(&s->i2c), OBJECT(s->dram_mr), "dram",
                              &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->i2c), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -320,8 +314,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_realize(SYS_BUS_DEVICE(&s->fmc), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->fmc), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -335,8 +328,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < sc->spis_num; i++) {
         object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs",
                                 &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -348,8 +340,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 
     /* EHCI */
     for (i = 0; i < sc->ehcis_num; i++) {
-        sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -360,8 +351,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* SDMC - SDRAM Memory Controller */
-    sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -373,8 +363,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 
         object_property_set_link(OBJECT(&s->wdt[i]),
                                  OBJECT(&s->scu), "scu", &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -386,8 +375,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < sc->macs_num; i++) {
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed",
                                  &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -398,8 +386,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* XDMA */
-    sysbus_realize(SYS_BUS_DEVICE(&s->xdma), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->xdma), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -409,8 +396,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_XDMA));
 
     /* GPIO */
-    sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -419,8 +405,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_GPIO));
 
     /* SDHCI */
-    sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 7ffdf62067..2df81168e4 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -161,8 +161,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     }
 
     /* Interrupt Controller */
-    sysbus_realize(SYS_BUS_DEVICE(&s->ic), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ic), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -172,8 +171,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     sysbus_pass_irq(SYS_BUS_DEVICE(s), SYS_BUS_DEVICE(&s->ic));
 
     /* Sys Timer */
-    sysbus_realize(SYS_BUS_DEVICE(&s->systmr), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->systmr), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -185,8 +183,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
 
     /* UART0 */
     qdev_prop_set_chr(DEVICE(&s->uart0), "chardev", serial_hd(0));
-    sysbus_realize(SYS_BUS_DEVICE(&s->uart0), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart0), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -200,8 +197,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     /* AUX / UART1 */
     qdev_prop_set_chr(DEVICE(&s->aux), "chardev", serial_hd(1));
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->aux), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->aux), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -213,8 +209,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                                INTERRUPT_AUX));
 
     /* Mailboxes */
-    sysbus_realize(SYS_BUS_DEVICE(&s->mboxes), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mboxes), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -239,8 +234,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->fb), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->fb), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -251,8 +245,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                        qdev_get_gpio_in(DEVICE(&s->mboxes), MBOX_CHAN_FB));
 
     /* Property channel */
-    sysbus_realize(SYS_BUS_DEVICE(&s->property), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->property), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -264,8 +257,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                       qdev_get_gpio_in(DEVICE(&s->mboxes), MBOX_CHAN_PROPERTY));
 
     /* Random Number Generator */
-    sysbus_realize(SYS_BUS_DEVICE(&s->rng), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rng), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -289,8 +281,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                              &error_abort);
     object_property_set_bool(OBJECT(&s->sdhci), true, "pending-insert-quirk",
                              &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -302,8 +293,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                                INTERRUPT_ARASANSDIO));
 
     /* SDHOST */
-    sysbus_realize(SYS_BUS_DEVICE(&s->sdhost), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhost), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -315,8 +305,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                                INTERRUPT_SDIO));
 
     /* DMA Channels */
-    sysbus_realize(SYS_BUS_DEVICE(&s->dma), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->dma), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -334,8 +323,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     }
 
     /* THERMAL */
-    sysbus_realize(SYS_BUS_DEVICE(&s->thermal), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->thermal), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -343,8 +331,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->thermal), 0));
 
     /* GPIO */
-    sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -355,8 +342,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->gpio), "sd-bus");
 
     /* Mphi */
-    sysbus_realize(SYS_BUS_DEVICE(&s->mphi), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mphi), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -368,8 +354,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                                INTERRUPT_HOSTPORT));
 
     /* DWC2 */
-    sysbus_realize(SYS_BUS_DEVICE(&s->dwc2), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->dwc2), &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index ed1793f7b7..1a7560ef30 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -86,8 +86,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
 
     object_property_add_const_link(OBJECT(&s->peripherals), "ram", obj);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->peripherals), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->peripherals), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -99,8 +98,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
                             info->peri_base, 1);
 
     /* bcm2836 interrupt controller (and mailboxes, etc.) */
-    sysbus_realize(SYS_BUS_DEVICE(&s->control), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->control), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -133,8 +131,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
             return;
         }
 
-        qdev_realize(DEVICE(&s->cpu[n].core), NULL, &err);
-        if (err) {
+        if (!qdev_realize(DEVICE(&s->cpu[n].core), NULL, &err)) {
             error_propagate(errp, err);
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
index 13a83f7430..1494c2900a 100644
--- a/hw/arm/digic.c
+++ b/hw/arm/digic.c
@@ -62,15 +62,13 @@ static void digic_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    qdev_realize(DEVICE(&s->cpu), NULL, &err);
-    if (err != NULL) {
+    if (!qdev_realize(DEVICE(&s->cpu), NULL, &err)) {
         error_propagate(errp, err);
         return;
     }
 
     for (i = 0; i < DIGIC4_NB_TIMERS; i++) {
-        sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), &err);
-        if (err != NULL) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -80,8 +78,7 @@ static void digic_realize(DeviceState *dev, Error **errp)
     }
 
     qdev_prop_set_chr(DEVICE(&s->uart), "chardev", serial_hd(0));
-    sysbus_realize(SYS_BUS_DEVICE(&s->uart), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart), &err)) {
         error_propagate(errp, err);
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
index 7ab5c98fbe..250681f045 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -85,14 +85,12 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
     uint8_t i;
     Error *err = NULL;
 
-    qdev_realize(DEVICE(&s->cpu), NULL, &err);
-    if (err) {
+    if (!qdev_realize(DEVICE(&s->cpu), NULL, &err)) {
         error_propagate(errp, err);
         return;
     }
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->avic), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->avic), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -102,8 +100,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->avic), 1,
                        qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->ccm), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ccm), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -124,8 +121,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
         qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
 
-        sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -149,8 +145,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
         s->gpt[i].ccm = IMX_CCM(&s->ccm);
 
-        sysbus_realize(SYS_BUS_DEVICE(&s->gpt[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpt[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -172,8 +167,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
         s->epit[i].ccm = IMX_CCM(&s->ccm);
 
-        sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -185,8 +179,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
     qdev_set_nic_properties(DEVICE(&s->fec), &nd_table[0]);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->fec), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->fec), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -194,8 +187,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fec), 0,
                        qdev_get_gpio_in(DEVICE(&s->avic), FSL_IMX25_FEC_IRQ));
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->rngc), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rngc), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -214,8 +206,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
             { FSL_IMX25_I2C3_ADDR, FSL_IMX25_I2C3_IRQ }
         };
 
-        sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -237,8 +228,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
             { FSL_IMX25_GPIO4_ADDR, FSL_IMX25_GPIO4_IRQ }
         };
 
-        sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -267,8 +257,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
         object_property_set_uint(OBJECT(&s->esdhc[i]), SDHCI_VENDOR_IMX,
                                  "vendor",
                                  &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 42cca529c3..4f007ea5e8 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -66,14 +66,12 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
     uint16_t i;
     Error *err = NULL;
 
-    qdev_realize(DEVICE(&s->cpu), NULL, &err);
-    if (err) {
+    if (!qdev_realize(DEVICE(&s->cpu), NULL, &err)) {
         error_propagate(errp, err);
         return;
     }
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->avic), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->avic), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -83,8 +81,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->avic), 1,
                        qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->ccm), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ccm), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -102,8 +99,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
         qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
 
-        sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -116,8 +112,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
     s->gpt.ccm = IMX_CCM(&s->ccm);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->gpt), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpt), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -138,8 +133,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
         s->epit[i].ccm = IMX_CCM(&s->ccm);
 
-        sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -162,8 +156,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
         };
 
         /* Initialize the I2C */
-        sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -188,8 +181,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
         object_property_set_bool(OBJECT(&s->gpio[i]), false, "has-edge-sel",
                                  &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 4ae3c3efc2..417ca6889c 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -130,8 +130,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                      "start-powered-off", &error_abort);
         }
 
-        qdev_realize(DEVICE(&s->cpu[i]), NULL, &err);
-        if (err) {
+        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -144,8 +143,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                             FSL_IMX6_MAX_IRQ + GIC_INTERNAL, "num-irq",
                             &error_abort);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->a9mpcore), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->a9mpcore), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -158,15 +156,13 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(DEVICE(&s->cpu[i]), ARM_CPU_FIQ));
     }
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->ccm), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ccm), &err)) {
         error_propagate(errp, err);
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccm), 0, FSL_IMX6_CCM_ADDR);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->src), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->src), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -187,8 +183,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
         qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
 
-        sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -201,8 +196,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
     s->gpt.ccm = IMX_CCM(&s->ccm);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->gpt), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpt), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -224,8 +218,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
         s->epit[i].ccm = IMX_CCM(&s->ccm);
 
-        sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -247,8 +240,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
             { FSL_IMX6_I2C3_ADDR, FSL_IMX6_I2C3_IRQ }
         };
 
-        sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -307,8 +299,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                  &error_abort);
         object_property_set_bool(OBJECT(&s->gpio[i]), true, "has-upper-pin-irq",
                                  &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -343,8 +334,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         object_property_set_uint(OBJECT(&s->esdhc[i]), SDHCI_VENDOR_IMX,
                                  "vendor",
                                  &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -390,8 +380,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         };
 
         /* Initialize the SPI */
-        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -403,8 +392,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
     }
 
     qdev_set_nic_properties(DEVICE(&s->eth), &nd_table[0]);
-    sysbus_realize(SYS_BUS_DEVICE(&s->eth), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->eth), &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 3235c76194..476112b2d9 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -125,8 +125,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memory()),
                                      "memory", &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -153,8 +152,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     dev = DEVICE(&s->timer);
     /* APB0 clock is the timer input clock */
     qdev_prop_set_uint32(dev, "clock-frequency", s->m3clk / s->apb0div);
-    sysbus_realize(SYS_BUS_DEVICE(&s->timer), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -168,8 +166,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     dev = DEVICE(&s->sysreg);
     qdev_prop_set_uint32(dev, "apb0divisor", s->apb0div);
     qdev_prop_set_uint32(dev, "apb1divisor", s->apb1div);
-    sysbus_realize(SYS_BUS_DEVICE(&s->sysreg), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sysreg), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -179,8 +176,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     for (i = 0; i < MSF2_NUM_SPIS; i++) {
         gchar *bus_name;
 
-        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
-        if (err != NULL) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -199,8 +195,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     dev = DEVICE(&s->emac);
     object_property_set_link(OBJECT(&s->emac), OBJECT(get_system_memory()),
                              "ahb-bus", &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->emac), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->emac), &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 20dd8b5897..e9c77e4c21 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -67,8 +67,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
 
     object_property_set_link(OBJECT(&s->cpu), OBJECT(&s->container), "memory",
                              &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->cpu), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpu), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -84,8 +83,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion(&s->container, NRF51_SRAM_BASE, &s->sram);
 
     /* UART */
-    sysbus_realize(SYS_BUS_DEVICE(&s->uart), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -96,8 +94,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
                        BASE_TO_IRQ(NRF51_UART_BASE)));
 
     /* RNG */
-    sysbus_realize(SYS_BUS_DEVICE(&s->rng), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rng), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -116,8 +113,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->nvm), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->nvm), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -132,8 +128,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion_overlap(&s->container, NRF51_FLASH_BASE, mr, 0);
 
     /* GPIO */
-    sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -151,8 +146,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
             error_propagate(errp, err);
             return;
         }
-        sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index 56aef686c9..46b5332470 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -107,16 +107,14 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memory()),
                                      "memory", &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), &err)) {
         error_propagate(errp, err);
         return;
     }
 
     /* System configuration controller */
     dev = DEVICE(&s->syscfg);
-    sysbus_realize(SYS_BUS_DEVICE(&s->syscfg), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->syscfg), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -128,8 +126,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     for (i = 0; i < STM_NUM_USARTS; i++) {
         dev = DEVICE(&(s->usart[i]));
         qdev_prop_set_chr(dev, "chardev", serial_hd(i));
-        sysbus_realize(SYS_BUS_DEVICE(&s->usart[i]), &err);
-        if (err != NULL) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usart[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -142,8 +139,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     for (i = 0; i < STM_NUM_TIMERS; i++) {
         dev = DEVICE(&(s->timer[i]));
         qdev_prop_set_uint64(dev, "clock-frequency", 1000000000);
-        sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), &err);
-        if (err != NULL) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -155,8 +151,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     /* ADC 1 to 3 */
     object_property_set_int(OBJECT(s->adc_irqs), STM_NUM_ADCS,
                             "num-lines", &error_abort);
-    qdev_realize(DEVICE(s->adc_irqs), NULL, &err);
-    if (err != NULL) {
+    if (!qdev_realize(DEVICE(s->adc_irqs), NULL, &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -165,8 +160,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
 
     for (i = 0; i < STM_NUM_ADCS; i++) {
         dev = DEVICE(&(s->adc[i]));
-        sysbus_realize(SYS_BUS_DEVICE(&s->adc[i]), &err);
-        if (err != NULL) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->adc[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -179,8 +173,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     /* SPI 1 and 2 */
     for (i = 0; i < STM_NUM_SPIS; i++) {
         dev = DEVICE(&(s->spi[i]));
-        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
-        if (err != NULL) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index cf9228d8e7..f1f0dc40b1 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -118,16 +118,14 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     object_property_set_link(OBJECT(&s->armv7m), OBJECT(system_memory),
                                      "memory", &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), &err)) {
         error_propagate(errp, err);
         return;
     }
 
     /* System configuration controller */
     dev = DEVICE(&s->syscfg);
-    sysbus_realize(SYS_BUS_DEVICE(&s->syscfg), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->syscfg), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -139,8 +137,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     for (i = 0; i < STM_NUM_USARTS; i++) {
         dev = DEVICE(&(s->usart[i]));
         qdev_prop_set_chr(dev, "chardev", serial_hd(i));
-        sysbus_realize(SYS_BUS_DEVICE(&s->usart[i]), &err);
-        if (err != NULL) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usart[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -153,8 +150,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     for (i = 0; i < STM_NUM_TIMERS; i++) {
         dev = DEVICE(&(s->timer[i]));
         qdev_prop_set_uint64(dev, "clock-frequency", 1000000000);
-        sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), &err);
-        if (err != NULL) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -173,8 +169,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     }
     object_property_set_int(OBJECT(&s->adc_irqs), STM_NUM_ADCS,
                             "num-lines", &error_abort);
-    qdev_realize(DEVICE(&s->adc_irqs), NULL, &err);
-    if (err != NULL) {
+    if (!qdev_realize(DEVICE(&s->adc_irqs), NULL, &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -183,8 +178,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
 
     for (i = 0; i < STM_NUM_ADCS; i++) {
         dev = DEVICE(&(s->adc[i]));
-        sysbus_realize(SYS_BUS_DEVICE(&s->adc[i]), &err);
-        if (err != NULL) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->adc[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -197,8 +191,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     /* SPI devices */
     for (i = 0; i < STM_NUM_SPIS; i++) {
         dev = DEVICE(&(s->spi[i]));
-        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
-        if (err != NULL) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -209,8 +202,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
 
     /* EXTI device */
     dev = DEVICE(&s->exti);
-    sysbus_realize(SYS_BUS_DEVICE(&s->exti), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->exti), &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 1de9d4a89d..d703158f8b 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -209,8 +209,7 @@ static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
 
         object_property_set_bool(OBJECT(&s->rpu_cpu[i]), true, "reset-hivecs",
                                  &error_abort);
-        qdev_realize(DEVICE(&s->rpu_cpu[i]), NULL, &err);
-        if (err) {
+        if (!qdev_realize(DEVICE(&s->rpu_cpu[i]), NULL, &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -367,15 +366,13 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
                                 "reset-cbar", &error_abort);
         object_property_set_int(OBJECT(&s->apu_cpu[i]), num_apus,
                                 "core-count", &error_abort);
-        qdev_realize(DEVICE(&s->apu_cpu[i]), NULL, &err);
-        if (err) {
+        if (!qdev_realize(DEVICE(&s->apu_cpu[i]), NULL, &err)) {
             error_propagate(errp, err);
             return;
         }
     }
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -470,8 +467,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
                                 &error_abort);
         object_property_set_int(OBJECT(&s->gem[i]), 2, "num-priority-queues",
                                 &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(&s->gem[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gem[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -482,8 +478,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_UARTS; i++) {
         qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
-        sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -494,8 +489,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
 
     object_property_set_int(OBJECT(&s->sata), SATA_NUM_PORTS, "num-ports",
                             &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->sata), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sata), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -528,8 +522,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
             error_propagate(errp, err);
             return;
         }
-        sysbus_realize(SYS_BUS_DEVICE(sdhci), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(sdhci), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -545,8 +538,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < XLNX_ZYNQMP_NUM_SPIS; i++) {
         gchar *bus_name;
 
-        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -562,8 +554,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         g_free(bus_name);
     }
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->qspi), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->qspi), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -584,16 +575,14 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         g_free(target_bus);
     }
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->dp), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->dp), &err)) {
         error_propagate(errp, err);
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->dp), 0, DP_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->dp), 0, gic_spi[DP_IRQ]);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->dpdma), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->dpdma), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -602,16 +591,14 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->dpdma), 0, DPDMA_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->dpdma), 0, gic_spi[DPDMA_IRQ]);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->ipi), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ipi), &err)) {
         error_propagate(errp, err);
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ipi), 0, IPI_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->ipi), 0, gic_spi[IPI_IRQ]);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->rtc), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -624,8 +611,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
             error_propagate(errp, err);
             return;
         }
-        sysbus_realize(SYS_BUS_DEVICE(&s->gdma[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gdma[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -636,8 +622,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     }
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_ADMA_CH; i++) {
-        sysbus_realize(SYS_BUS_DEVICE(&s->adma[i]), &err);
-        if (err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->adma[i]), &err)) {
             error_propagate(errp, err);
             return;
         }
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 3425d56e2a..3be8c7be5b 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2575,8 +2575,7 @@ static void fdctrl_connect_drives(FDCtrl *fdctrl, DeviceState *fdc_dev,
             return;
         }
 
-        qdev_realize_and_unref(dev, &fdctrl->bus.bus, &local_err);
-        if (local_err) {
+        if (!qdev_realize_and_unref(dev, &fdctrl->bus.bus, &local_err)) {
             error_propagate(errp, local_err);
             return;
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
index 56f915e7c9..1328967461 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -106,8 +106,7 @@ static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
 
     for (i = 0; i < nports; i++) {
         s = pci->state + i;
-        qdev_realize(DEVICE(s), NULL, &err);
-        if (err != NULL) {
+        if (!qdev_realize(DEVICE(s), NULL, &err)) {
             error_propagate(errp, err);
             multi_serial_pci_exit(dev);
             return;
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index 298f3adba7..d22617426b 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -49,8 +49,7 @@ static void serial_pci_realize(PCIDevice *dev, Error **errp)
     SerialState *s = &pci->state;
     Error *err = NULL;
 
-    qdev_realize(DEVICE(s), NULL, &err);
-    if (err != NULL) {
+    if (!qdev_realize(DEVICE(s), NULL, &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 9eebcb27e7..e69096eace 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -991,8 +991,7 @@ static void serial_io_realize(DeviceState *dev, Error **errp)
     SerialState *s = &sio->serial;
     Error *local_err = NULL;
 
-    qdev_realize(DEVICE(s), NULL, &local_err);
-    if (local_err) {
+    if (!qdev_realize(DEVICE(s), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -1098,8 +1097,7 @@ static void serial_mm_realize(DeviceState *dev, Error **errp)
     SerialState *s = &smm->serial;
     Error *local_err = NULL;
 
-    qdev_realize(DEVICE(s), NULL, &local_err);
-    if (local_err) {
+    if (!qdev_realize(DEVICE(s), NULL, &local_err)) {
         error_propagate(errp, local_err);
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
index e6085f5d44..358c6152c7 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -76,8 +76,7 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
         qdev_prop_set_bit(gicdev, "has-virtualization-extensions", has_el2);
     }
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 642363d2f4..fc35dcf179 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -57,8 +57,7 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
 
     scudev = DEVICE(&s->scu);
     qdev_prop_set_uint32(scudev, "num-cpu", s->num_cpu);
-    sysbus_realize(SYS_BUS_DEVICE(&s->scu), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -78,8 +77,7 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
         object_property_get_bool(cpuobj, "has_el3", &error_abort);
     qdev_prop_set_bit(gicdev, "has-security-extensions", has_el3);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -93,8 +91,7 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
 
     gtimerdev = DEVICE(&s->gtimer);
     qdev_prop_set_uint32(gtimerdev, "num-cpu", s->num_cpu);
-    sysbus_realize(SYS_BUS_DEVICE(&s->gtimer), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gtimer), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -102,8 +99,7 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
 
     mptimerdev = DEVICE(&s->mptimer);
     qdev_prop_set_uint32(mptimerdev, "num-cpu", s->num_cpu);
-    sysbus_realize(SYS_BUS_DEVICE(&s->mptimer), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mptimer), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -111,8 +107,7 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
 
     wdtdev = DEVICE(&s->wdt);
     qdev_prop_set_uint32(wdtdev, "num-cpu", s->num_cpu);
-    sysbus_realize(SYS_BUS_DEVICE(&s->wdt), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt), &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/cpu/arm11mpcore.c b/hw/cpu/arm11mpcore.c
index a2afb992fb..c5eef9514d 100644
--- a/hw/cpu/arm11mpcore.c
+++ b/hw/cpu/arm11mpcore.c
@@ -79,8 +79,7 @@ static void mpcore_priv_realize(DeviceState *dev, Error **errp)
     Error *err = NULL;
 
     qdev_prop_set_uint32(scudev, "num-cpu", s->num_cpu);
-    sysbus_realize(SYS_BUS_DEVICE(&s->scu), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -91,8 +90,7 @@ static void mpcore_priv_realize(DeviceState *dev, Error **errp)
                          ARM11MPCORE_NUM_GIC_PRIORITY_BITS);
 
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -104,15 +102,13 @@ static void mpcore_priv_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_in(dev, mpcore_priv_set_irq, s->num_irq - 32);
 
     qdev_prop_set_uint32(mptimerdev, "num-cpu", s->num_cpu);
-    sysbus_realize(SYS_BUS_DEVICE(&s->mptimer), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mptimer), &err)) {
         error_propagate(errp, err);
         return;
     }
 
     qdev_prop_set_uint32(wdtimerdev, "num-cpu", s->num_cpu);
-    sysbus_realize(SYS_BUS_DEVICE(&s->wdtimer), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdtimer), &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/cpu/realview_mpcore.c b/hw/cpu/realview_mpcore.c
index d2e426fa45..bf3e48b48e 100644
--- a/hw/cpu/realview_mpcore.c
+++ b/hw/cpu/realview_mpcore.c
@@ -70,8 +70,7 @@ static void realview_mpcore_realize(DeviceState *dev, Error **errp)
     int i;
 
     qdev_prop_set_uint32(priv, "num-cpu", s->num_cpu);
-    sysbus_realize(SYS_BUS_DEVICE(&s->priv), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->priv), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -81,8 +80,7 @@ static void realview_mpcore_realize(DeviceState *dev, Error **errp)
     }
     /* ??? IRQ routing is hardcoded to "normal" mode.  */
     for (n = 0; n < 4; n++) {
-        sysbus_realize(SYS_BUS_DEVICE(&s->gic[n]), &err);
-        if (err != NULL) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic[n]), &err)) {
             error_propagate(errp, err);
             return;
         }
diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index 41b88b878d..357fefa3c0 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -34,9 +34,7 @@ static void virtio_gpu_pci_base_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     Error *local_error = NULL;
 
     virtio_pci_force_virtio_1(vpci_dev);
-    qdev_realize(vdev, BUS(&vpci_dev->bus), &local_error);
-
-    if (local_error) {
+    if (!qdev_realize(vdev, BUS(&vpci_dev->bus), &local_error)) {
         error_propagate(errp, local_error);
         return;
     }
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 67f409e106..0fc00fee1f 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -138,8 +138,7 @@ static void virtio_vga_base_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 
     /* init virtio bits */
     virtio_pci_force_virtio_1(vpci_dev);
-    qdev_realize(DEVICE(g), BUS(&vpci_dev->bus), &err);
-    if (err) {
+    if (!qdev_realize(DEVICE(g), BUS(&vpci_dev->bus), &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index af9f4c5a85..80a915e922 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2640,8 +2640,7 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
 
     s->num_prio_bits = arm_feature(&s->cpu->env, ARM_FEATURE_V7) ? 8 : 2;
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->systick[M_REG_NS]), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->systick[M_REG_NS]), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -2657,8 +2656,7 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
         object_initialize_child(OBJECT(dev), "systick-reg-s",
                                 &s->systick[M_REG_S], TYPE_SYSTICK);
 
-        sysbus_realize(SYS_BUS_DEVICE(&s->systick[M_REG_S]), &err);
-        if (err != NULL) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->systick[M_REG_S]), &err)) {
             error_propagate(errp, err);
             return;
         }
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 85ba0b4655..3b2e87334d 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1833,8 +1833,7 @@ static void pnv_xive_realize(DeviceState *dev, Error **errp)
                             &error_fatal);
     object_property_set_link(OBJECT(xsrc), OBJECT(xive), "xive",
                              &error_abort);
-    qdev_realize(DEVICE(xsrc), NULL, &local_err);
-    if (local_err) {
+    if (!qdev_realize(DEVICE(xsrc), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -1843,8 +1842,7 @@ static void pnv_xive_realize(DeviceState *dev, Error **errp)
                             &error_fatal);
     object_property_set_link(OBJECT(end_xsrc), OBJECT(xive), "xive",
                              &error_abort);
-    qdev_realize(DEVICE(end_xsrc), NULL, &local_err);
-    if (local_err) {
+    if (!qdev_realize(DEVICE(end_xsrc), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
diff --git a/hw/intc/realview_gic.c b/hw/intc/realview_gic.c
index f11fb5259a..aa0010e91f 100644
--- a/hw/intc/realview_gic.c
+++ b/hw/intc/realview_gic.c
@@ -34,8 +34,7 @@ static void realview_gic_realize(DeviceState *dev, Error **errp)
     int numirq = 96;
 
     qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", numirq);
-    sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index b7fc8dde7a..615abf5462 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -312,8 +312,7 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
                             &error_fatal);
     object_property_set_link(OBJECT(xsrc), OBJECT(xive), "xive",
                              &error_abort);
-    qdev_realize(DEVICE(xsrc), NULL, &local_err);
-    if (local_err) {
+    if (!qdev_realize(DEVICE(xsrc), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -326,8 +325,7 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
                             &error_fatal);
     object_property_set_link(OBJECT(end_xsrc), OBJECT(xive), "xive",
                              &error_abort);
-    qdev_realize(DEVICE(end_xsrc), NULL, &local_err);
-    if (local_err) {
+    if (!qdev_realize(DEVICE(end_xsrc), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index d365eeca66..811b0346e1 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -384,8 +384,7 @@ Object *icp_create(Object *cpu, const char *type, XICSFabric *xi, Error **errp)
     object_unref(obj);
     object_property_set_link(obj, OBJECT(xi), ICP_PROP_XICS, &error_abort);
     object_property_set_link(obj, cpu, ICP_PROP_CPU, &error_abort);
-    qdev_realize(DEVICE(obj), NULL, &local_err);
-    if (local_err) {
+    if (!qdev_realize(DEVICE(obj), NULL, &local_err)) {
         object_unparent(obj);
         error_propagate(errp, local_err);
         obj = NULL;
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
index f634bcb2d1..09d7daabed 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -183,8 +183,7 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
 
     /* RTC */
     qdev_prop_set_int32(DEVICE(&s->rtc), "base_year", 2000);
-    qdev_realize(DEVICE(&s->rtc), BUS(isa_bus), &err);
-    if (err) {
+    if (!qdev_realize(DEVICE(&s->rtc), BUS(isa_bus), &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index abebc7e2ef..5e861f5ae2 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -96,8 +96,7 @@ static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
     object_property_set_str(OBJECT(&s->cpu), "8.40.b", "version",
                             &error_abort);
     object_property_set_uint(OBJECT(&s->cpu), 0, "pvr", &error_abort);
-    qdev_realize(DEVICE(&s->cpu), NULL, &err);
-    if (err) {
+    if (!qdev_realize(DEVICE(&s->cpu), NULL, &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -108,8 +107,7 @@ static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
                              &error_abort);
     object_property_set_uint(OBJECT(&s->intc), 0xffff, "intc-positive",
                              &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->intc), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->intc), &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 0d7f3cf673..22b932890d 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -109,8 +109,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
         if (saar_present) {
             s->itu.saar = &env->CP0_SAAR;
         }
-        sysbus_realize(SYS_BUS_DEVICE(&s->itu), &err);
-        if (err != NULL) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->itu), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -125,8 +124,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
                             &error_abort);
     object_property_set_int(OBJECT(&s->cpc), 1, "vp-start-running",
                             &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->cpc), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpc), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -140,8 +138,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
                             &error_abort);
     object_property_set_int(OBJECT(&s->gic), 128, "num-irq",
                             &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -163,8 +160,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
                              &error_abort);
     object_property_set_link(OBJECT(&s->gcr), OBJECT(&s->cpc.mr), "cpc",
                              &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->gcr), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gcr), &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 5bbc7770fa..cc7c26d67c 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -526,8 +526,7 @@ static void cuda_realize(DeviceState *dev, Error **errp)
     ADBBusState *adb_bus = &s->adb_bus;
     struct tm tm;
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->mos6522_cuda), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mos6522_cuda), &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 3251c79f46..42414797e2 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -100,8 +100,7 @@ static void macio_common_realize(PCIDevice *d, Error **errp)
     SysBusDevice *sysbus_dev;
     Error *err = NULL;
 
-    qdev_realize(DEVICE(&s->dbdma), BUS(&s->macio_bus), &err);
-    if (err) {
+    if (!qdev_realize(DEVICE(&s->dbdma), BUS(&s->macio_bus), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -116,8 +115,7 @@ static void macio_common_realize(PCIDevice *d, Error **errp)
     qdev_prop_set_chr(DEVICE(&s->escc), "chrB", serial_hd(1));
     qdev_prop_set_uint32(DEVICE(&s->escc), "chnBtype", escc_serial);
     qdev_prop_set_uint32(DEVICE(&s->escc), "chnAtype", escc_serial);
-    qdev_realize(DEVICE(&s->escc), BUS(&s->macio_bus), &err);
-    if (err) {
+    if (!qdev_realize(DEVICE(&s->escc), BUS(&s->macio_bus), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -159,8 +157,7 @@ static void macio_oldworld_realize(PCIDevice *d, Error **errp)
 
     qdev_prop_set_uint64(DEVICE(&s->cuda), "timebase-frequency",
                          s->frequency);
-    qdev_realize(DEVICE(&s->cuda), BUS(&s->macio_bus), &err);
-    if (err) {
+    if (!qdev_realize(DEVICE(&s->cuda), BUS(&s->macio_bus), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -176,8 +173,7 @@ static void macio_oldworld_realize(PCIDevice *d, Error **errp)
     sysbus_connect_irq(sysbus_dev, 1, qdev_get_gpio_in(pic_dev,
                                                        OLDWORLD_ESCCA_IRQ));
 
-    qdev_realize(DEVICE(&os->nvram), BUS(&s->macio_bus), &err);
-    if (err) {
+    if (!qdev_realize(DEVICE(&os->nvram), BUS(&s->macio_bus), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -345,8 +341,7 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
         object_property_set_link(OBJECT(&s->pmu), OBJECT(sysbus_dev), "gpio",
                                  &error_abort);
         qdev_prop_set_bit(DEVICE(&s->pmu), "has-adb", ns->has_adb);
-        qdev_realize(DEVICE(&s->pmu), BUS(&s->macio_bus), &err);
-        if (err) {
+        if (!qdev_realize(DEVICE(&s->pmu), BUS(&s->macio_bus), &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -363,8 +358,7 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
         qdev_prop_set_uint64(DEVICE(&s->cuda), "timebase-frequency",
                              s->frequency);
 
-        qdev_realize(DEVICE(&s->cuda), BUS(&s->macio_bus), &err);
-        if (err) {
+        if (!qdev_realize(DEVICE(&s->cuda), BUS(&s->macio_bus), &err)) {
             error_propagate(errp, err);
             return;
         }
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index 598d8e7517..42ba963d8c 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -740,8 +740,7 @@ static void pmu_realize(DeviceState *dev, Error **errp)
     ADBBusState *adb_bus = &s->adb_bus;
     struct tm tm;
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->mos6522_pmu), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mos6522_pmu), &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 3ec904a55f..7b547b1d78 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -1003,8 +1003,7 @@ static void pnv_phb3_realize(DeviceState *dev, Error **errp)
                                    &error_abort);
     object_property_set_int(OBJECT(&phb->lsis), PNV_PHB3_NUM_LSI, "nr-irqs",
                             &error_abort);
-    qdev_realize(DEVICE(&phb->lsis), NULL, &local_err);
-    if (local_err) {
+    if (!qdev_realize(DEVICE(&phb->lsis), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -1022,8 +1021,7 @@ static void pnv_phb3_realize(DeviceState *dev, Error **errp)
                                    &error_abort);
     object_property_set_int(OBJECT(&phb->msis), PHB3_MAX_MSI, "nr-irqs",
                             &error_abort);
-    qdev_realize(DEVICE(&phb->msis), NULL, &local_err);
-    if (local_err) {
+    if (!qdev_realize(DEVICE(&phb->msis), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -1031,8 +1029,7 @@ static void pnv_phb3_realize(DeviceState *dev, Error **errp)
     /* Power Bus Common Queue */
     object_property_set_link(OBJECT(&phb->pbcq), OBJECT(phb), "phb",
                                    &error_abort);
-    qdev_realize(DEVICE(&phb->pbcq), NULL, &local_err);
-    if (local_err) {
+    if (!qdev_realize(DEVICE(&phb->pbcq), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 10716d759d..53c2b1785b 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1218,8 +1218,7 @@ static void pnv_phb4_realize(DeviceState *dev, Error **errp)
     }
     object_property_set_int(OBJECT(xsrc), nr_irqs, "nr-irqs", &error_fatal);
     object_property_set_link(OBJECT(xsrc), OBJECT(phb), "xive", &error_fatal);
-    qdev_realize(DEVICE(xsrc), NULL, &local_err);
-    if (local_err) {
+    if (!qdev_realize(DEVICE(xsrc), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
index 2d634c838e..45a1b3719d 100644
--- a/hw/pci-host/pnv_phb4_pec.c
+++ b/hw/pci-host/pnv_phb4_pec.c
@@ -390,8 +390,7 @@ static void pnv_pec_realize(DeviceState *dev, Error **errp)
 
         object_property_set_int(stk_obj, i, "stack-no", &error_abort);
         object_property_set_link(stk_obj, OBJECT(pec), "pec", &error_abort);
-        qdev_realize(DEVICE(stk_obj), NULL, &local_err);
-        if (local_err) {
+        if (!qdev_realize(DEVICE(stk_obj), NULL, &local_err)) {
             error_propagate(errp, local_err);
             return;
         }
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 51bf95b303..97fa970e72 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -771,8 +771,7 @@ static DeviceState *ppce500_init_mpic_kvm(const PPCE500MachineClass *pmc,
     dev = qdev_new(TYPE_KVM_OPENPIC);
     qdev_prop_set_uint32(dev, "model", pmc->mpic_version);
 
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &err);
-    if (err) {
+    if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &err)) {
         error_propagate(errp, err);
         object_unparent(OBJECT(dev));
         return NULL;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 643098ad5f..f2d70c3e18 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1140,8 +1140,7 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
                             "bar", &error_fatal);
     object_property_set_link(OBJECT(&chip8->psi), OBJECT(chip8->xics),
                              ICS_PROP_XICS, &error_abort);
-    qdev_realize(DEVICE(&chip8->psi), NULL, &local_err);
-    if (local_err) {
+    if (!qdev_realize(DEVICE(&chip8->psi), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -1171,8 +1170,7 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
     /* Create the simplified OCC model */
     object_property_set_link(OBJECT(&chip8->occ), OBJECT(&chip8->psi), "psi",
                              &error_abort);
-    qdev_realize(DEVICE(&chip8->occ), NULL, &local_err);
-    if (local_err) {
+    if (!qdev_realize(DEVICE(&chip8->occ), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -1185,8 +1183,7 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
     /* HOMER */
     object_property_set_link(OBJECT(&chip8->homer), OBJECT(chip), "chip",
                              &error_abort);
-    qdev_realize(DEVICE(&chip8->homer), NULL, &local_err);
-    if (local_err) {
+    if (!qdev_realize(DEVICE(&chip8->homer), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -1205,8 +1202,7 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
         object_property_set_int(OBJECT(phb), i, "index", &error_fatal);
         object_property_set_int(OBJECT(phb), chip->chip_id, "chip-id",
                                 &error_fatal);
-        sysbus_realize(SYS_BUS_DEVICE(phb), &local_err);
-        if (local_err) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(phb), &local_err)) {
             error_propagate(errp, local_err);
             return;
         }
@@ -1384,8 +1380,7 @@ static void pnv_chip_power9_phb_realize(PnvChip *chip, Error **errp)
                                  &error_fatal);
         object_property_set_link(OBJECT(pec), OBJECT(get_system_memory()),
                                  "system-memory", &error_abort);
-        qdev_realize(DEVICE(pec), NULL, &local_err);
-        if (local_err) {
+        if (!qdev_realize(DEVICE(pec), NULL, &local_err)) {
             error_propagate(errp, local_err);
             return;
         }
@@ -1409,8 +1404,7 @@ static void pnv_chip_power9_phb_realize(PnvChip *chip, Error **errp)
             object_property_set_int(obj, PNV_PHB4_DEVICE_ID, "device-id",
                                     &error_fatal);
             object_property_set_link(obj, OBJECT(stack), "stack", &error_abort);
-            sysbus_realize(SYS_BUS_DEVICE(obj), &local_err);
-            if (local_err) {
+            if (!sysbus_realize(SYS_BUS_DEVICE(obj), &local_err)) {
                 error_propagate(errp, local_err);
                 return;
             }
@@ -1469,8 +1463,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
                             "tm-bar", &error_fatal);
     object_property_set_link(OBJECT(&chip9->xive), OBJECT(chip), "chip",
                              &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&chip9->xive), &local_err);
-    if (local_err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&chip9->xive), &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -1480,8 +1473,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     /* Processor Service Interface (PSI) Host Bridge */
     object_property_set_int(OBJECT(&chip9->psi), PNV9_PSIHB_BASE(chip),
                             "bar", &error_fatal);
-    qdev_realize(DEVICE(&chip9->psi), NULL, &local_err);
-    if (local_err) {
+    if (!qdev_realize(DEVICE(&chip9->psi), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -1491,8 +1483,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     /* LPC */
     object_property_set_link(OBJECT(&chip9->lpc), OBJECT(&chip9->psi), "psi",
                              &error_abort);
-    qdev_realize(DEVICE(&chip9->lpc), NULL, &local_err);
-    if (local_err) {
+    if (!qdev_realize(DEVICE(&chip9->lpc), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -1505,8 +1496,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     /* Create the simplified OCC model */
     object_property_set_link(OBJECT(&chip9->occ), OBJECT(&chip9->psi), "psi",
                              &error_abort);
-    qdev_realize(DEVICE(&chip9->occ), NULL, &local_err);
-    if (local_err) {
+    if (!qdev_realize(DEVICE(&chip9->occ), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -1519,8 +1509,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     /* HOMER */
     object_property_set_link(OBJECT(&chip9->homer), OBJECT(chip), "chip",
                              &error_abort);
-    qdev_realize(DEVICE(&chip9->homer), NULL, &local_err);
-    if (local_err) {
+    if (!qdev_realize(DEVICE(&chip9->homer), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -1601,8 +1590,7 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     /* Processor Service Interface (PSI) Host Bridge */
     object_property_set_int(OBJECT(&chip10->psi), PNV10_PSIHB_BASE(chip),
                             "bar", &error_fatal);
-    qdev_realize(DEVICE(&chip10->psi), NULL, &local_err);
-    if (local_err) {
+    if (!qdev_realize(DEVICE(&chip10->psi), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -1612,8 +1600,7 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     /* LPC */
     object_property_set_link(OBJECT(&chip10->lpc), OBJECT(&chip10->psi), "psi",
                              &error_abort);
-    qdev_realize(DEVICE(&chip10->lpc), NULL, &local_err);
-    if (local_err) {
+    if (!qdev_realize(DEVICE(&chip10->lpc), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index c986c16db1..d699f077ad 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -173,8 +173,7 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp)
     Error *local_err = NULL;
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(pc->chip);
 
-    qdev_realize(DEVICE(cpu), NULL, &local_err);
-    if (local_err) {
+    if (!qdev_realize(DEVICE(cpu), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 75b8ae9703..7efe6e138f 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -510,8 +510,7 @@ static void pnv_psi_power8_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    qdev_realize(DEVICE(ics), NULL, &err);
-    if (err) {
+    if (!qdev_realize(DEVICE(ics), NULL, &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -851,8 +850,7 @@ static void pnv_psi_power9_realize(DeviceState *dev, Error **errp)
     object_property_set_int(OBJECT(xsrc), PSIHB9_NUM_IRQS, "nr-irqs",
                             &error_fatal);
     object_property_set_link(OBJECT(xsrc), OBJECT(psi), "xive", &error_abort);
-    qdev_realize(DEVICE(xsrc), NULL, &local_err);
-    if (local_err) {
+    if (!qdev_realize(DEVICE(xsrc), NULL, &local_err)) {
         error_propagate(errp, local_err);
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
index 897bf98587..1d0db57fc5 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -311,8 +311,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
         object_property_set_link(obj, OBJECT(spapr), ICS_PROP_XICS,
                                  &error_abort);
         object_property_set_int(obj, smc->nr_xirqs, "nr-irqs", &error_abort);
-        qdev_realize(DEVICE(obj), NULL, &local_err);
-        if (local_err) {
+        if (!qdev_realize(DEVICE(obj), NULL, &local_err)) {
             error_propagate(errp, local_err);
             return;
         }
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 19223e4c29..5fce455d30 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -127,8 +127,7 @@ static void lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
                                 &s->flash_mem);
 
     /* PLIC */
-    sysbus_realize(SYS_BUS_DEVICE(&s->plic), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->plic), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -136,8 +135,7 @@ static void lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
 
     /* UART */
     qdev_prop_set_chr(DEVICE(&(s->uart)), "chardev", serial_hd(0));
-    sysbus_realize(SYS_BUS_DEVICE(&s->uart), &err);
-    if (err != NULL) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart), &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 0cb66ac4e2..1b2e95a977 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -221,8 +221,7 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
 
     /* GPIO */
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index a1d2edfe13..7b9e7fdc7f 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -710,8 +710,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     }
     object_property_set_int(OBJECT(&s->gem), GEM_REVISION, "revision",
                             &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->gem), &err);
-    if (err) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gem), &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 164b1fd295..cee2908ae9 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -444,15 +444,13 @@ static void realize_event_facility(DeviceState *dev, Error **errp)
     SCLPEventFacility *event_facility = EVENT_FACILITY(dev);
     Error *local_err = NULL;
 
-    qdev_realize(DEVICE(&event_facility->quiesce),
-                 BUS(&event_facility->sbus), &local_err);
-    if (local_err) {
+    if (!qdev_realize(DEVICE(&event_facility->quiesce),
+                      BUS(&event_facility->sbus), &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
-    qdev_realize(DEVICE(&event_facility->cpu_hotplug),
-                 BUS(&event_facility->sbus), &local_err);
-    if (local_err) {
+    if (!qdev_realize(DEVICE(&event_facility->cpu_hotplug),
+                      BUS(&event_facility->sbus), &local_err)) {
         error_propagate(errp, local_err);
         qdev_unrealize(DEVICE(&event_facility->quiesce));
         return;
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 736965c928..9e6b170fa8 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -831,8 +831,7 @@ static S390PCIBusDevice *s390_pci_device_new(S390pciState *s,
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
index ca6753bff3..36cfdf865c 100644
--- a/hw/s390x/virtio-ccw-crypto.c
+++ b/hw/s390x/virtio-ccw-crypto.c
@@ -21,8 +21,7 @@ static void virtio_ccw_crypto_realize(VirtioCcwDevice *ccw_dev, Error **errp)
     DeviceState *vdev = DEVICE(&dev->vdev);
     Error *err = NULL;
 
-    qdev_realize(vdev, BUS(&ccw_dev->bus), &err);
-    if (err) {
+    if (!qdev_realize(vdev, BUS(&ccw_dev->bus), &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/s390x/virtio-ccw-rng.c b/hw/s390x/virtio-ccw-rng.c
index 4077160f49..513f85ac63 100644
--- a/hw/s390x/virtio-ccw-rng.c
+++ b/hw/s390x/virtio-ccw-rng.c
@@ -22,8 +22,7 @@ static void virtio_ccw_rng_realize(VirtioCcwDevice *ccw_dev, Error **errp)
     DeviceState *vdev = DEVICE(&dev->vdev);
     Error *err = NULL;
 
-    qdev_realize(vdev, BUS(&ccw_dev->bus), &err);
-    if (err) {
+    if (!qdev_realize(vdev, BUS(&ccw_dev->bus), &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index b878a08080..365d09fb48 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -293,8 +293,7 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
     qdev_prop_set_enum(dev, "rerror", rerror);
     qdev_prop_set_enum(dev, "werror", werror);
 
-    qdev_realize_and_unref(dev, &bus->qbus, &err);
-    if (err != NULL) {
+    if (!qdev_realize_and_unref(dev, &bus->qbus, &err)) {
         error_propagate(errp, err);
         object_unparent(OBJECT(dev));
         return NULL;
diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
index 538d3bad3d..2d0d5651e3 100644
--- a/hw/sd/aspeed_sdhci.c
+++ b/hw/sd/aspeed_sdhci.c
@@ -145,8 +145,7 @@ static void aspeed_sdhci_realize(DeviceState *dev, Error **errp)
             return;
         }
 
-        sysbus_realize(sbd_slot, &err);
-        if (err) {
+        if (!sysbus_realize(sbd_slot, &err)) {
             error_propagate(errp, err);
             return;
         }
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 25cdf4c966..c57d76b1c8 100644
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
index cf1afb47a6..20ce1b113b 100644
--- a/hw/virtio/virtio-rng-pci.c
+++ b/hw/virtio/virtio-rng-pci.c
@@ -36,8 +36,7 @@ static void virtio_rng_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     DeviceState *vdev = DEVICE(&vrng->vdev);
     Error *err = NULL;
 
-    qdev_realize(vdev, BUS(&vpci_dev->bus), &err);
-    if (err) {
+    if (!qdev_realize(vdev, BUS(&vpci_dev->bus), &err)) {
         error_propagate(errp, err);
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


