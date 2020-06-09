Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98A9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6075320774
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HcUlRgGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6075320774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihpq-0005OC-LM
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihIE-0004a9-Rw
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:40:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24248
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihHw-0003Di-Ik
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591720783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YfOfXNRfGyws46FTBRu/c0lWpekujPfqzbxJPzKExJI=;
 b=HcUlRgGV10qr5Z9eZUKHwdTIodSNQ9OZUnrfhbsiVSa0cxzpx+gYaPpqcVHl2RFkhB1iwm
 H3PWsiljGBg5+1EIIQaX9TVztzbPSGm7MQNCIuD9OWBk5svrGEVNRtDTe/b67cj7TZyeRw
 evBGNXaPDlfRkBICiC2uppIuJXxcNa4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-VeTtP6fnPBGUiKkNiJHQVg-1; Tue, 09 Jun 2020 12:39:38 -0400
X-MC-Unique: VeTtP6fnPBGUiKkNiJHQVg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCBC887308E
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2020 16:39:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9936219D61;
 Tue,  9 Jun 2020 16:39:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6EAE911384A2; Tue,  9 Jun 2020 18:39:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/39] qdev: Convert uses of qdev_create() with Coccinelle
Date: Tue,  9 Jun 2020 18:39:02 +0200
Message-Id: <20200609163932.1566209-10-armbru@redhat.com>
In-Reply-To: <20200609163932.1566209-1-armbru@redhat.com>
References: <20200609163932.1566209-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the transformation explained in the commit before previous.
Takes care of just one pattern that needs conversion.  More to come in
this series.

Coccinelle script:

    @ depends on !(file in "hw/arm/highbank.c")@
    expression bus, type_name, dev, expr;
    @@
    -    dev = qdev_create(bus, type_name);
    +    dev = qdev_new(type_name);
         ... when != dev = expr
    -    qdev_init_nofail(dev);
    +    qdev_realize_and_unref(dev, bus, &error_fatal);

    @@
    expression bus, type_name, dev, expr;
    identifier DOWN;
    @@
    -    dev = DOWN(qdev_create(bus, type_name));
    +    dev = DOWN(qdev_new(type_name));
         ... when != dev = expr
    -    qdev_init_nofail(DEVICE(dev));
    +    qdev_realize_and_unref(DEVICE(dev), bus, &error_fatal);

    @@
    expression bus, type_name, expr;
    identifier dev;
    @@
    -    DeviceState *dev = qdev_create(bus, type_name);
    +    DeviceState *dev = qdev_new(type_name);
         ... when != dev = expr
    -    qdev_init_nofail(dev);
    +    qdev_realize_and_unref(dev, bus, &error_fatal);

    @@
    expression bus, type_name, dev, expr, errp;
    symbol true;
    @@
    -    dev = qdev_create(bus, type_name);
    +    dev = qdev_new(type_name);
         ... when != dev = expr
    -    object_property_set_bool(OBJECT(dev), true, "realized", errp);
    +    qdev_realize_and_unref(dev, bus, errp);

    @@
    expression bus, type_name, expr, errp;
    identifier dev;
    symbol true;
    @@
    -    DeviceState *dev = qdev_create(bus, type_name);
    +    DeviceState *dev = qdev_new(type_name);
         ... when != dev = expr
    -    object_property_set_bool(OBJECT(dev), true, "realized", errp);
    +    qdev_realize_and_unref(dev, bus, errp);

The first rule exempts hw/arm/highbank.c, because it matches along two
control flow paths there, with different @type_name.  Covered by the
next commit's manual conversions.

Missing #include "qapi/error.h" added manually.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/lm32/lm32.h                           | 13 ++---
 hw/lm32/milkymist-hw.h                   | 37 +++++++-------
 include/hw/char/cadence_uart.h           |  5 +-
 include/hw/char/cmsdk-apb-uart.h         |  4 +-
 include/hw/char/pl011.h                  |  9 ++--
 include/hw/char/xilinx_uartlite.h        |  4 +-
 include/hw/cris/etraxfs.h                |  4 +-
 include/hw/misc/unimp.h                  |  5 +-
 include/hw/timer/cmsdk-apb-timer.h       |  4 +-
 hw/alpha/typhoon.c                       |  4 +-
 hw/arm/aspeed.c                          |  7 +--
 hw/arm/cubieboard.c                      |  4 +-
 hw/arm/exynos4210.c                      | 41 +++++++--------
 hw/arm/exynos4_boards.c                  |  4 +-
 hw/arm/imx25_pdk.c                       |  5 +-
 hw/arm/integratorcp.c                    |  4 +-
 hw/arm/mcimx6ul-evk.c                    |  5 +-
 hw/arm/mcimx7d-sabre.c                   |  5 +-
 hw/arm/mps2-tz.c                         |  4 +-
 hw/arm/msf2-som.c                        |  4 +-
 hw/arm/musicpal.c                        |  8 +--
 hw/arm/netduino2.c                       |  4 +-
 hw/arm/netduinoplus2.c                   |  4 +-
 hw/arm/nseries.c                         |  8 +--
 hw/arm/omap1.c                           | 16 +++---
 hw/arm/omap2.c                           | 16 +++---
 hw/arm/orangepi.c                        |  4 +-
 hw/arm/pxa2xx.c                          |  8 +--
 hw/arm/pxa2xx_gpio.c                     |  5 +-
 hw/arm/pxa2xx_pic.c                      |  5 +-
 hw/arm/raspi.c                           |  4 +-
 hw/arm/realview.c                        | 20 ++++----
 hw/arm/sbsa-ref.c                        | 20 ++++----
 hw/arm/spitz.c                           |  4 +-
 hw/arm/stellaris.c                       | 12 ++---
 hw/arm/strongarm.c                       |  9 ++--
 hw/arm/versatilepb.c                     | 16 +++---
 hw/arm/vexpress.c                        | 16 +++---
 hw/arm/virt.c                            | 32 ++++++------
 hw/arm/xilinx_zynq.c                     | 38 +++++++-------
 hw/arm/xlnx-versal-virt.c                |  9 ++--
 hw/arm/xlnx-versal.c                     |  4 +-
 hw/arm/xlnx-zcu102.c                     |  5 +-
 hw/audio/intel-hda.c                     |  4 +-
 hw/block/fdc.c                           | 12 ++---
 hw/block/pflash_cfi01.c                  |  4 +-
 hw/block/pflash_cfi02.c                  |  4 +-
 hw/char/exynos4210_uart.c                |  5 +-
 hw/char/mcf_uart.c                       |  5 +-
 hw/char/spapr_vty.c                      |  4 +-
 hw/core/empty_slot.c                     |  5 +-
 hw/core/sysbus.c                         |  4 +-
 hw/cris/axis_dev88.c                     |  4 +-
 hw/display/milkymist-tmu2.c              |  4 +-
 hw/display/sm501.c                       |  4 +-
 hw/dma/pxa2xx_dma.c                      |  8 +--
 hw/dma/rc4030.c                          |  5 +-
 hw/dma/sparc32_dma.c                     | 16 +++---
 hw/hppa/dino.c                           |  4 +-
 hw/hppa/lasi.c                           |  4 +-
 hw/hppa/machine.c                        |  4 +-
 hw/i2c/core.c                            |  5 +-
 hw/i2c/smbus_eeprom.c                    |  4 +-
 hw/i386/pc_q35.c                         |  4 +-
 hw/i386/x86.c                            |  6 +--
 hw/ide/qdev.c                            |  4 +-
 hw/intc/exynos4210_gic.c                 |  5 +-
 hw/intc/s390_flic.c                      |  6 +--
 hw/isa/isa-bus.c                         |  4 +-
 hw/m68k/mcf5208.c                        |  4 +-
 hw/m68k/mcf_intc.c                       |  5 +-
 hw/m68k/next-cube.c                      | 12 ++---
 hw/m68k/q800.c                           | 36 ++++++-------
 hw/microblaze/petalogix_ml605_mmu.c      | 20 ++++----
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 12 ++---
 hw/mips/boston.c                         |  8 +--
 hw/mips/gt64xxx_pci.c                    |  5 +-
 hw/mips/jazz.c                           | 16 +++---
 hw/mips/malta.c                          |  4 +-
 hw/mips/mipssim.c                        |  8 +--
 hw/net/etraxfs_eth.c                     |  4 +-
 hw/net/fsl_etsec/etsec.c                 |  5 +-
 hw/net/lan9118.c                         |  5 +-
 hw/net/lasi_i82596.c                     |  5 +-
 hw/net/smc91c111.c                       |  5 +-
 hw/net/spapr_llan.c                      |  4 +-
 hw/nios2/10m50_devboard.c                | 12 ++---
 hw/nvram/fw_cfg.c                        |  8 +--
 hw/openrisc/openrisc_sim.c               |  8 +--
 hw/pci-bridge/pci_expander_bridge.c      |  4 +-
 hw/pci-host/bonito.c                     |  5 +-
 hw/pci-host/i440fx.c                     |  4 +-
 hw/pcmcia/pxa2xx.c                       |  5 +-
 hw/ppc/e500.c                            | 32 ++++++------
 hw/ppc/mac_newworld.c                    | 40 +++++++--------
 hw/ppc/mac_oldworld.c                    | 20 ++++----
 hw/ppc/pnv.c                             |  4 +-
 hw/ppc/ppc440_uc.c                       |  8 +--
 hw/ppc/prep.c                            |  9 ++--
 hw/ppc/sam460ex.c                        |  4 +-
 hw/ppc/spapr.c                           |  8 +--
 hw/ppc/spapr_irq.c                       |  4 +-
 hw/ppc/spapr_vio.c                       |  4 +-
 hw/ppc/virtex_ml507.c                    |  9 ++--
 hw/riscv/sifive_clint.c                  |  5 +-
 hw/riscv/sifive_e_prci.c                 |  5 +-
 hw/riscv/sifive_plic.c                   |  5 +-
 hw/riscv/sifive_test.c                   |  5 +-
 hw/riscv/virt.c                          |  4 +-
 hw/rtc/m48t59.c                          |  5 +-
 hw/rtc/sun4v-rtc.c                       |  5 +-
 hw/s390x/ap-bridge.c                     |  4 +-
 hw/s390x/css-bridge.c                    |  4 +-
 hw/s390x/s390-virtio-ccw.c               | 12 ++---
 hw/scsi/scsi-bus.c                       |  4 +-
 hw/scsi/spapr_vscsi.c                    |  4 +-
 hw/sd/milkymist-memcard.c                |  4 +-
 hw/sd/pxa2xx_mmci.c                      |  8 +--
 hw/sd/ssi-sd.c                           |  4 +-
 hw/sh4/r2d.c                             | 12 ++---
 hw/sparc/leon3.c                         | 12 ++---
 hw/sparc/sun4m.c                         | 64 ++++++++++++------------
 hw/sparc64/sun4u.c                       | 24 ++++-----
 hw/xen/xen-bus.c                         |  4 +-
 hw/xen/xen-legacy-backend.c              |  4 +-
 hw/xtensa/virt.c                         |  4 +-
 hw/xtensa/xtfpga.c                       |  8 +--
 127 files changed, 581 insertions(+), 552 deletions(-)

diff --git a/hw/lm32/lm32.h b/hw/lm32/lm32.h
index 98de07acf2..326238d859 100644
--- a/hw/lm32/lm32.h
+++ b/hw/lm32/lm32.h
@@ -3,14 +3,15 @@
 
 #include "hw/char/lm32_juart.h"
 #include "hw/qdev-properties.h"
+#include "qapi/error.h"
 
 static inline DeviceState *lm32_pic_init(qemu_irq cpu_irq)
 {
     DeviceState *dev;
     SysBusDevice *d;
 
-    dev = qdev_create(NULL, "lm32-pic");
-    qdev_init_nofail(dev);
+    dev = qdev_new("lm32-pic");
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     d = SYS_BUS_DEVICE(dev);
     sysbus_connect_irq(d, 0, cpu_irq);
 
@@ -21,9 +22,9 @@ static inline DeviceState *lm32_juart_init(Chardev *chr)
 {
     DeviceState *dev;
 
-    dev = qdev_create(NULL, TYPE_LM32_JUART);
+    dev = qdev_new(TYPE_LM32_JUART);
     qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     return dev;
 }
@@ -35,10 +36,10 @@ static inline DeviceState *lm32_uart_create(hwaddr addr,
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_create(NULL, "lm32-uart");
+    dev = qdev_new("lm32-uart");
     s = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(s, 0, addr);
     sysbus_connect_irq(s, 0, irq);
     return dev;
diff --git a/hw/lm32/milkymist-hw.h b/hw/lm32/milkymist-hw.h
index 5f63024355..d5f15a30a1 100644
--- a/hw/lm32/milkymist-hw.h
+++ b/hw/lm32/milkymist-hw.h
@@ -3,6 +3,7 @@
 
 #include "hw/qdev-core.h"
 #include "net/net.h"
+#include "qapi/error.h"
 
 static inline DeviceState *milkymist_uart_create(hwaddr base,
                                                  qemu_irq irq,
@@ -10,9 +11,9 @@ static inline DeviceState *milkymist_uart_create(hwaddr base,
 {
     DeviceState *dev;
 
-    dev = qdev_create(NULL, "milkymist-uart");
+    dev = qdev_new("milkymist-uart");
     qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
 
@@ -23,8 +24,8 @@ static inline DeviceState *milkymist_hpdmc_create(hwaddr base)
 {
     DeviceState *dev;
 
-    dev = qdev_create(NULL, "milkymist-hpdmc");
-    qdev_init_nofail(dev);
+    dev = qdev_new("milkymist-hpdmc");
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
 
     return dev;
@@ -34,8 +35,8 @@ static inline DeviceState *milkymist_memcard_create(hwaddr base)
 {
     DeviceState *dev;
 
-    dev = qdev_create(NULL, "milkymist-memcard");
-    qdev_init_nofail(dev);
+    dev = qdev_new("milkymist-memcard");
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
 
     return dev;
@@ -46,10 +47,10 @@ static inline DeviceState *milkymist_vgafb_create(hwaddr base,
 {
     DeviceState *dev;
 
-    dev = qdev_create(NULL, "milkymist-vgafb");
+    dev = qdev_new("milkymist-vgafb");
     qdev_prop_set_uint32(dev, "fb_offset", fb_offset);
     qdev_prop_set_uint32(dev, "fb_mask", fb_mask);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
 
     return dev;
@@ -62,12 +63,12 @@ static inline DeviceState *milkymist_sysctl_create(hwaddr base,
 {
     DeviceState *dev;
 
-    dev = qdev_create(NULL, "milkymist-sysctl");
+    dev = qdev_new("milkymist-sysctl");
     qdev_prop_set_uint32(dev, "frequency", freq_hz);
     qdev_prop_set_uint32(dev, "systemid", system_id);
     qdev_prop_set_uint32(dev, "capabilities", capabilities);
     qdev_prop_set_uint32(dev, "gpio_strappings", gpio_strappings);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, gpio_irq);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1, timer0_irq);
@@ -81,8 +82,8 @@ static inline DeviceState *milkymist_pfpu_create(hwaddr base,
 {
     DeviceState *dev;
 
-    dev = qdev_create(NULL, "milkymist-pfpu");
-    qdev_init_nofail(dev);
+    dev = qdev_new("milkymist-pfpu");
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
     return dev;
@@ -94,8 +95,8 @@ static inline DeviceState *milkymist_ac97_create(hwaddr base,
 {
     DeviceState *dev;
 
-    dev = qdev_create(NULL, "milkymist-ac97");
-    qdev_init_nofail(dev);
+    dev = qdev_new("milkymist-ac97");
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, crrequest_irq);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1, crreply_irq);
@@ -111,9 +112,9 @@ static inline DeviceState *milkymist_minimac2_create(hwaddr base,
     DeviceState *dev;
 
     qemu_check_nic_model(&nd_table[0], "minimac2");
-    dev = qdev_create(NULL, "milkymist-minimac2");
+    dev = qdev_new("milkymist-minimac2");
     qdev_set_nic_properties(dev, &nd_table[0]);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, buffers_base);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, rx_irq);
@@ -128,10 +129,10 @@ static inline DeviceState *milkymist_softusb_create(hwaddr base,
 {
     DeviceState *dev;
 
-    dev = qdev_create(NULL, "milkymist-softusb");
+    dev = qdev_new("milkymist-softusb");
     qdev_prop_set_uint32(dev, "pmem_size", pmem_size);
     qdev_prop_set_uint32(dev, "dmem_size", dmem_size);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, pmem_base);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, dmem_base);
diff --git a/include/hw/char/cadence_uart.h b/include/hw/char/cadence_uart.h
index 2a179a572f..af80b6083b 100644
--- a/include/hw/char/cadence_uart.h
+++ b/include/hw/char/cadence_uart.h
@@ -22,6 +22,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
+#include "qapi/error.h"
 #include "qemu/timer.h"
 
 #define CADENCE_UART_RX_FIFO_SIZE           16
@@ -59,10 +60,10 @@ static inline DeviceState *cadence_uart_create(hwaddr addr,
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_create(NULL, TYPE_CADENCE_UART);
+    dev = qdev_new(TYPE_CADENCE_UART);
     s = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(s, 0, addr);
     sysbus_connect_irq(s, 0, irq);
 
diff --git a/include/hw/char/cmsdk-apb-uart.h b/include/hw/char/cmsdk-apb-uart.h
index 3c1b53db4e..a51471ff74 100644
--- a/include/hw/char/cmsdk-apb-uart.h
+++ b/include/hw/char/cmsdk-apb-uart.h
@@ -62,11 +62,11 @@ static inline DeviceState *cmsdk_apb_uart_create(hwaddr addr,
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_create(NULL, TYPE_CMSDK_APB_UART);
+    dev = qdev_new(TYPE_CMSDK_APB_UART);
     s = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", chr);
     qdev_prop_set_uint32(dev, "pclk-frq", pclk_frq);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(s, 0, addr);
     sysbus_connect_irq(s, 0, txint);
     sysbus_connect_irq(s, 1, rxint);
diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
index 14187165c6..18e701b65d 100644
--- a/include/hw/char/pl011.h
+++ b/include/hw/char/pl011.h
@@ -18,6 +18,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
+#include "qapi/error.h"
 
 #define TYPE_PL011 "pl011"
 #define PL011(obj) OBJECT_CHECK(PL011State, (obj), TYPE_PL011)
@@ -57,10 +58,10 @@ static inline DeviceState *pl011_create(hwaddr addr,
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_create(NULL, "pl011");
+    dev = qdev_new("pl011");
     s = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(s, 0, addr);
     sysbus_connect_irq(s, 0, irq);
 
@@ -74,10 +75,10 @@ static inline DeviceState *pl011_luminary_create(hwaddr addr,
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_create(NULL, "pl011_luminary");
+    dev = qdev_new("pl011_luminary");
     s = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(s, 0, addr);
     sysbus_connect_irq(s, 0, irq);
 
diff --git a/include/hw/char/xilinx_uartlite.h b/include/hw/char/xilinx_uartlite.h
index 194e2feafe..007b84575f 100644
--- a/include/hw/char/xilinx_uartlite.h
+++ b/include/hw/char/xilinx_uartlite.h
@@ -25,10 +25,10 @@ static inline DeviceState *xilinx_uartlite_create(hwaddr addr,
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_create(NULL, "xlnx.xps-uartlite");
+    dev = qdev_new("xlnx.xps-uartlite");
     s = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(s, 0, addr);
     sysbus_connect_irq(s, 0, irq);
 
diff --git a/include/hw/cris/etraxfs.h b/include/hw/cris/etraxfs.h
index 403e7f95e6..19b903facf 100644
--- a/include/hw/cris/etraxfs.h
+++ b/include/hw/cris/etraxfs.h
@@ -41,10 +41,10 @@ static inline DeviceState *etraxfs_ser_create(hwaddr addr,
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_create(NULL, "etraxfs,serial");
+    dev = qdev_new("etraxfs,serial");
     s = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(s, 0, addr);
     sysbus_connect_irq(s, 0, irq);
     return dev;
diff --git a/include/hw/misc/unimp.h b/include/hw/misc/unimp.h
index 44d87be903..e71ec17e13 100644
--- a/include/hw/misc/unimp.h
+++ b/include/hw/misc/unimp.h
@@ -10,6 +10,7 @@
 
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
+#include "qapi/error.h"
 
 #define TYPE_UNIMPLEMENTED_DEVICE "unimplemented-device"
 
@@ -40,11 +41,11 @@ static inline void create_unimplemented_device(const char *name,
                                                hwaddr base,
                                                hwaddr size)
 {
-    DeviceState *dev = qdev_create(NULL, TYPE_UNIMPLEMENTED_DEVICE);
+    DeviceState *dev = qdev_new(TYPE_UNIMPLEMENTED_DEVICE);
 
     qdev_prop_set_string(dev, "name", name);
     qdev_prop_set_uint64(dev, "size", size);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(dev), 0, base, -1000);
 }
diff --git a/include/hw/timer/cmsdk-apb-timer.h b/include/hw/timer/cmsdk-apb-timer.h
index e93caccc3c..eee175eaa4 100644
--- a/include/hw/timer/cmsdk-apb-timer.h
+++ b/include/hw/timer/cmsdk-apb-timer.h
@@ -48,10 +48,10 @@ static inline DeviceState *cmsdk_apb_timer_create(hwaddr addr,
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_create(NULL, TYPE_CMSDK_APB_TIMER);
+    dev = qdev_new(TYPE_CMSDK_APB_TIMER);
     s = SYS_BUS_DEVICE(dev);
     qdev_prop_set_uint32(dev, "pclk-frq", pclk_frq);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(s, 0, addr);
     sysbus_connect_irq(s, 0, timerint);
     return dev;
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 1795e2f29d..480d866c77 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -826,7 +826,7 @@ PCIBus *typhoon_init(MemoryRegion *ram, ISABus **isa_bus, qemu_irq *p_rtc_irq,
     PCIBus *b;
     int i;
 
-    dev = qdev_create(NULL, TYPE_TYPHOON_PCI_HOST_BRIDGE);
+    dev = qdev_new(TYPE_TYPHOON_PCI_HOST_BRIDGE);
 
     s = TYPHOON_PCI_HOST_BRIDGE(dev);
     phb = PCI_HOST_BRIDGE(dev);
@@ -889,7 +889,7 @@ PCIBus *typhoon_init(MemoryRegion *ram, ISABus **isa_bus, qemu_irq *p_rtc_irq,
                               &s->pchip.reg_mem, &s->pchip.reg_io,
                               0, 64, TYPE_PCI_BUS);
     phb->bus = b;
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     /* Host memory as seen from the PCI side, via the IOMMU.  */
     memory_region_init_iommu(&s->pchip.iommu, sizeof(s->pchip.iommu),
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index f8f3ef89d3..63a7105e8b 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -241,13 +241,14 @@ static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo)
 {
         DeviceState *card;
 
-        card = qdev_create(qdev_get_child_bus(DEVICE(sdhci), "sd-bus"),
-                           TYPE_SD_CARD);
+        card = qdev_new(TYPE_SD_CARD);
         if (dinfo) {
             qdev_prop_set_drive(card, "drive", blk_by_legacy_dinfo(dinfo),
                                 &error_fatal);
         }
-        object_property_set_bool(OBJECT(card), true, "realized", &error_fatal);
+        qdev_realize_and_unref(card,
+                               qdev_get_child_bus(DEVICE(sdhci), "sd-bus"),
+                               &error_fatal);
 }
 
 static void aspeed_machine_init(MachineState *machine)
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index cd1b6d3e19..4bc4f08caf 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -92,9 +92,9 @@ static void cubieboard_init(MachineState *machine)
     bus = qdev_get_child_bus(DEVICE(a10), "sd-bus");
 
     /* Plug in SD card */
-    carddev = qdev_create(bus, TYPE_SD_CARD);
+    carddev = qdev_new(TYPE_SD_CARD);
     qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
-    object_property_set_bool(OBJECT(carddev), true, "realized", &error_fatal);
+    qdev_realize_and_unref(carddev, bus, &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), AW_A10_SDRAM_BASE,
                                 machine->ram);
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 1f7253ef6f..9ff1a11f80 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -173,7 +173,7 @@ static DeviceState *pl330_create(uint32_t base, qemu_or_irq *orgate,
     DeviceState *dev;
     int i;
 
-    dev = qdev_create(NULL, "pl330");
+    dev = qdev_new("pl330");
     qdev_prop_set_uint8(dev, "num_events", nevents);
     qdev_prop_set_uint8(dev, "num_chnls",  8);
     qdev_prop_set_uint8(dev, "num_periph_req",  nreq);
@@ -184,7 +184,7 @@ static DeviceState *pl330_create(uint32_t base, qemu_or_irq *orgate,
     qdev_prop_set_uint8(dev, "rd_q_dep", 8);
     qdev_prop_set_uint8(dev, "data_width", width);
     qdev_prop_set_uint16(dev, "data_buffer_dep", width);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(busdev, 0, base);
 
@@ -232,9 +232,9 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
 
     /* IRQ Gate */
     for (i = 0; i < EXYNOS4210_NCPUS; i++) {
-        dev = qdev_create(NULL, "exynos4210.irq_gate");
+        dev = qdev_new("exynos4210.irq_gate");
         qdev_prop_set_uint32(dev, "n_in", EXYNOS4210_IRQ_GATE_NINPUTS);
-        qdev_init_nofail(dev);
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
         /* Get IRQ Gate input in gate_irq */
         for (n = 0; n < EXYNOS4210_IRQ_GATE_NINPUTS; n++) {
             gate_irq[i][n] = qdev_get_gpio_in(dev, n);
@@ -247,9 +247,9 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
     }
 
     /* Private memory region and Internal GIC */
-    dev = qdev_create(NULL, TYPE_A9MPCORE_PRIV);
+    dev = qdev_new(TYPE_A9MPCORE_PRIV);
     qdev_prop_set_uint32(dev, "num-cpu", EXYNOS4210_NCPUS);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(busdev, 0, EXYNOS4210_SMP_PRIVATE_BASE_ADDR);
     for (n = 0; n < EXYNOS4210_NCPUS; n++) {
@@ -263,9 +263,9 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
     sysbus_create_simple("l2x0", EXYNOS4210_L2X0_BASE_ADDR, NULL);
 
     /* External GIC */
-    dev = qdev_create(NULL, "exynos4210.gic");
+    dev = qdev_new("exynos4210.gic");
     qdev_prop_set_uint32(dev, "num-cpu", EXYNOS4210_NCPUS);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
     /* Map CPU interface */
     sysbus_mmio_map(busdev, 0, EXYNOS4210_EXT_GIC_CPU_BASE_ADDR);
@@ -279,8 +279,8 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
     }
 
     /* Internal Interrupt Combiner */
-    dev = qdev_create(NULL, "exynos4210.combiner");
-    qdev_init_nofail(dev);
+    dev = qdev_new("exynos4210.combiner");
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
     for (n = 0; n < EXYNOS4210_MAX_INT_COMBINER_OUT_IRQ; n++) {
         sysbus_connect_irq(busdev, n, s->irqs.int_gic_irq[n]);
@@ -289,9 +289,9 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
     sysbus_mmio_map(busdev, 0, EXYNOS4210_INT_COMBINER_BASE_ADDR);
 
     /* External Interrupt Combiner */
-    dev = qdev_create(NULL, "exynos4210.combiner");
+    dev = qdev_new("exynos4210.combiner");
     qdev_prop_set_uint32(dev, "external", 1);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
     for (n = 0; n < EXYNOS4210_MAX_INT_COMBINER_OUT_IRQ; n++) {
         sysbus_connect_irq(busdev, n, s->irqs.ext_gic_irq[n]);
@@ -353,8 +353,8 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
                           NULL);
 
     /* Multi Core Timer */
-    dev = qdev_create(NULL, "exynos4210.mct");
-    qdev_init_nofail(dev);
+    dev = qdev_new("exynos4210.mct");
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
     for (n = 0; n < 4; n++) {
         /* Connect global timer interrupts to Combiner gpio_in */
@@ -379,8 +379,8 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
             i2c_irq = s->irq_table[exynos4210_get_irq(EXYNOS4210_HDMI_INTG, 1)];
         }
 
-        dev = qdev_create(NULL, "exynos4210.i2c");
-        qdev_init_nofail(dev);
+        dev = qdev_new("exynos4210.i2c");
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_connect_irq(busdev, 0, i2c_irq);
         sysbus_mmio_map(busdev, 0, addr);
@@ -423,9 +423,9 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
          * public datasheet which is very similar (implementing
          * MMC Specification Version 4.0 being the only difference noted)
          */
-        dev = qdev_create(NULL, TYPE_S3C_SDHCI);
+        dev = qdev_new(TYPE_S3C_SDHCI);
         qdev_prop_set_uint64(dev, "capareg", EXYNOS4210_SDHCI_CAPABILITIES);
-        qdev_init_nofail(dev);
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
 
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(busdev, 0, EXYNOS4210_SDHCI_ADDR(n));
@@ -433,9 +433,10 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
 
         di = drive_get(IF_SD, 0, n);
         blk = di ? blk_by_legacy_dinfo(di) : NULL;
-        carddev = qdev_create(qdev_get_child_bus(dev, "sd-bus"), TYPE_SD_CARD);
+        carddev = qdev_new(TYPE_SD_CARD);
         qdev_prop_set_drive(carddev, "drive", blk, &error_abort);
-        qdev_init_nofail(carddev);
+        qdev_realize_and_unref(carddev, qdev_get_child_bus(dev, "sd-bus"),
+                               &error_fatal);
     }
 
     /*** Display controller (FIMD) ***/
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 09da52876d..d4fe9c6128 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -81,10 +81,10 @@ static void lan9215_init(uint32_t base, qemu_irq irq)
     /* This should be a 9215 but the 9118 is close enough */
     if (nd_table[0].used) {
         qemu_check_nic_model(&nd_table[0], "lan9118");
-        dev = qdev_create(NULL, TYPE_LAN9118);
+        dev = qdev_new(TYPE_LAN9118);
         qdev_set_nic_properties(dev, &nd_table[0]);
         qdev_prop_set_uint32(dev, "mode_16bit", 1);
-        qdev_init_nofail(dev);
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
         s = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(s, 0, base);
         sysbus_connect_irq(s, 0, irq);
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index b3ca82bafa..75076f2ea4 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -130,10 +130,9 @@ static void imx25_pdk_init(MachineState *machine)
         di = drive_get_next(IF_SD);
         blk = di ? blk_by_legacy_dinfo(di) : NULL;
         bus = qdev_get_child_bus(DEVICE(&s->soc.esdhc[i]), "sd-bus");
-        carddev = qdev_create(bus, TYPE_SD_CARD);
+        carddev = qdev_new(TYPE_SD_CARD);
         qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
-        object_property_set_bool(OBJECT(carddev), true,
-                                 "realized", &error_fatal);
+        qdev_realize_and_unref(carddev, bus, &error_fatal);
     }
 
     /*
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 5fb54e5aa7..45698307f1 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -620,9 +620,9 @@ static void integratorcp_init(MachineState *machine)
                              0, ram_size);
     memory_region_add_subregion(address_space_mem, 0x80000000, ram_alias);
 
-    dev = qdev_create(NULL, TYPE_INTEGRATOR_CM);
+    dev = qdev_new(TYPE_INTEGRATOR_CM);
     qdev_prop_set_uint32(dev, "memsz", ram_size >> 20);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map((SysBusDevice *)dev, 0, 0x10000000);
 
     dev = sysbus_create_varargs(TYPE_INTEGRATOR_PIC, 0x14000000,
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 5b5f23a6d4..769fe6d802 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -54,10 +54,9 @@ static void mcimx6ul_evk_init(MachineState *machine)
         di = drive_get_next(IF_SD);
         blk = di ? blk_by_legacy_dinfo(di) : NULL;
         bus = qdev_get_child_bus(DEVICE(&s->usdhc[i]), "sd-bus");
-        carddev = qdev_create(bus, TYPE_SD_CARD);
+        carddev = qdev_new(TYPE_SD_CARD);
         qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
-        object_property_set_bool(OBJECT(carddev), true,
-                                 "realized", &error_fatal);
+        qdev_realize_and_unref(carddev, bus, &error_fatal);
     }
 
     if (!qtest_enabled()) {
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 3851cd9e3e..645ad5470f 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -56,10 +56,9 @@ static void mcimx7d_sabre_init(MachineState *machine)
         di = drive_get_next(IF_SD);
         blk = di ? blk_by_legacy_dinfo(di) : NULL;
         bus = qdev_get_child_bus(DEVICE(&s->usdhc[i]), "sd-bus");
-        carddev = qdev_create(bus, TYPE_SD_CARD);
+        carddev = qdev_new(TYPE_SD_CARD);
         qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
-        object_property_set_bool(OBJECT(carddev), true,
-                                 "realized", &error_fatal);
+        qdev_realize_and_unref(carddev, bus, &error_fatal);
     }
 
     if (!qtest_enabled()) {
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 2c43041564..07d11e439f 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -246,9 +246,9 @@ static MemoryRegion *make_eth_dev(MPS2TZMachineState *mms, void *opaque,
      * except that it doesn't support the checksum-offload feature.
      */
     qemu_check_nic_model(nd, "lan9118");
-    mms->lan9118 = qdev_create(NULL, TYPE_LAN9118);
+    mms->lan9118 = qdev_new(TYPE_LAN9118);
     qdev_set_nic_properties(mms->lan9118, nd);
-    qdev_init_nofail(mms->lan9118);
+    qdev_realize_and_unref(mms->lan9118, NULL, &error_fatal);
 
     s = SYS_BUS_DEVICE(mms->lan9118);
     sysbus_connect_irq(s, 0, get_sse_irq_in(mms, 16));
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index dbd35b6def..e398703742 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -61,7 +61,7 @@ static void emcraft_sf2_s2s010_init(MachineState *machine)
                            &error_fatal);
     memory_region_add_subregion(sysmem, DDR_BASE_ADDRESS, ddr);
 
-    dev = qdev_create(NULL, TYPE_MSF2_SOC);
+    dev = qdev_new(TYPE_MSF2_SOC);
     qdev_prop_set_string(dev, "part-name", "M2S010");
     qdev_prop_set_string(dev, "cpu-type", mc->default_cpu_type);
 
@@ -77,7 +77,7 @@ static void emcraft_sf2_s2s010_init(MachineState *machine)
     qdev_prop_set_uint32(dev, "apb0div", 2);
     qdev_prop_set_uint32(dev, "apb1div", 2);
 
-    object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     soc = MSF2_SOC(dev);
 
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 92f33ed87e..d03351e5fa 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1651,9 +1651,9 @@ static void musicpal_init(MachineState *machine)
     sysbus_create_simple(TYPE_MV88W8618_FLASHCFG, MP_FLASHCFG_BASE, NULL);
 
     qemu_check_nic_model(&nd_table[0], "mv88w8618");
-    dev = qdev_create(NULL, TYPE_MV88W8618_ETH);
+    dev = qdev_new(TYPE_MV88W8618_ETH);
     qdev_set_nic_properties(dev, &nd_table[0]);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, MP_ETH_BASE);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[MP_ETH_IRQ]);
 
@@ -1688,11 +1688,11 @@ static void musicpal_init(MachineState *machine)
     }
 
     wm8750_dev = i2c_create_slave(i2c, TYPE_WM8750, MP_WM_ADDR);
-    dev = qdev_create(NULL, TYPE_MV88W8618_AUDIO);
+    dev = qdev_new(TYPE_MV88W8618_AUDIO);
     s = SYS_BUS_DEVICE(dev);
     object_property_set_link(OBJECT(dev), OBJECT(wm8750_dev),
                              "wm8750", NULL);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(s, 0, MP_AUDIO_BASE);
     sysbus_connect_irq(s, 0, pic[MP_AUDIO_IRQ]);
 
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index e770d9cac8..6bd8e4e197 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -34,9 +34,9 @@ static void netduino2_init(MachineState *machine)
 {
     DeviceState *dev;
 
-    dev = qdev_create(NULL, TYPE_STM32F205_SOC);
+    dev = qdev_new(TYPE_STM32F205_SOC);
     qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m3"));
-    object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
                        FLASH_SIZE);
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index e5e247edbe..8d4b3d7c43 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -34,9 +34,9 @@ static void netduinoplus2_init(MachineState *machine)
 {
     DeviceState *dev;
 
-    dev = qdev_create(NULL, TYPE_STM32F405_SOC);
+    dev = qdev_new(TYPE_STM32F405_SOC);
     qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
-    object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     armv7m_load_kernel(ARM_CPU(first_cpu),
                        machine->kernel_filename,
diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index eae800b5c1..856fa565a4 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -174,7 +174,7 @@ static void n8x0_nand_setup(struct n800_s *s)
     char *otp_region;
     DriveInfo *dinfo;
 
-    s->nand = qdev_create(NULL, "onenand");
+    s->nand = qdev_new("onenand");
     qdev_prop_set_uint16(s->nand, "manufacturer_id", NAND_MFR_SAMSUNG);
     /* Either 0x40 or 0x48 are OK for the device ID */
     qdev_prop_set_uint16(s->nand, "device_id", 0x48);
@@ -185,7 +185,7 @@ static void n8x0_nand_setup(struct n800_s *s)
         qdev_prop_set_drive(s->nand, "drive", blk_by_legacy_dinfo(dinfo),
                             &error_fatal);
     }
-    qdev_init_nofail(s->nand);
+    qdev_realize_and_unref(s->nand, NULL, &error_fatal);
     sysbus_connect_irq(SYS_BUS_DEVICE(s->nand), 0,
                        qdev_get_gpio_in(s->mpu->gpio, N8X0_ONENAND_GPIO));
     omap_gpmc_attach(s->mpu->gpmc, N8X0_ONENAND_CS,
@@ -802,9 +802,9 @@ static void n8x0_uart_setup(struct n800_s *s)
 static void n8x0_usb_setup(struct n800_s *s)
 {
     SysBusDevice *dev;
-    s->usb = qdev_create(NULL, "tusb6010");
+    s->usb = qdev_new("tusb6010");
     dev = SYS_BUS_DEVICE(s->usb);
-    qdev_init_nofail(s->usb);
+    qdev_realize_and_unref(s->usb, NULL, &error_fatal);
     sysbus_connect_irq(dev, 0,
                        qdev_get_gpio_in(s->mpu->gpio, N8X0_TUSB_INT_GPIO));
     /* Using the NOR interface */
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 761cc17ea9..c11d6da9d5 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -3887,20 +3887,20 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
 
     omap_clkm_init(system_memory, 0xfffece00, 0xe1008000, s);
 
-    s->ih[0] = qdev_create(NULL, "omap-intc");
+    s->ih[0] = qdev_new("omap-intc");
     qdev_prop_set_uint32(s->ih[0], "size", 0x100);
     omap_intc_set_iclk(OMAP_INTC(s->ih[0]), omap_findclk(s, "arminth_ck"));
-    qdev_init_nofail(s->ih[0]);
+    qdev_realize_and_unref(s->ih[0], NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(s->ih[0]);
     sysbus_connect_irq(busdev, 0,
                        qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_IRQ));
     sysbus_connect_irq(busdev, 1,
                        qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_FIQ));
     sysbus_mmio_map(busdev, 0, 0xfffecb00);
-    s->ih[1] = qdev_create(NULL, "omap-intc");
+    s->ih[1] = qdev_new("omap-intc");
     qdev_prop_set_uint32(s->ih[1], "size", 0x800);
     omap_intc_set_iclk(OMAP_INTC(s->ih[1]), omap_findclk(s, "arminth_ck"));
-    qdev_init_nofail(s->ih[1]);
+    qdev_realize_and_unref(s->ih[1], NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(s->ih[1]);
     sysbus_connect_irq(busdev, 0,
                        qdev_get_gpio_in(s->ih[0], OMAP_INT_15XX_IH2_IRQ));
@@ -4010,10 +4010,10 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
                                qdev_get_gpio_in(s->ih[1], OMAP_INT_MPUIO),
                                s->wakeup, omap_findclk(s, "clk32-kHz"));
 
-    s->gpio = qdev_create(NULL, "omap-gpio");
+    s->gpio = qdev_new("omap-gpio");
     qdev_prop_set_int32(s->gpio, "mpu_model", s->mpu_model);
     omap_gpio_set_clk(OMAP1_GPIO(s->gpio), omap_findclk(s, "arm_gpio_ck"));
-    qdev_init_nofail(s->gpio);
+    qdev_realize_and_unref(s->gpio, NULL, &error_fatal);
     sysbus_connect_irq(SYS_BUS_DEVICE(s->gpio), 0,
                        qdev_get_gpio_in(s->ih[0], OMAP_INT_GPIO_BANK1));
     sysbus_mmio_map(SYS_BUS_DEVICE(s->gpio), 0, 0xfffce000);
@@ -4028,10 +4028,10 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
     s->pwt = omap_pwt_init(system_memory, 0xfffb6000,
                            omap_findclk(s, "armxor_ck"));
 
-    s->i2c[0] = qdev_create(NULL, "omap_i2c");
+    s->i2c[0] = qdev_new("omap_i2c");
     qdev_prop_set_uint8(s->i2c[0], "revision", 0x11);
     omap_i2c_set_fclk(OMAP_I2C(s->i2c[0]), omap_findclk(s, "mpuper_ck"));
-    qdev_init_nofail(s->i2c[0]);
+    qdev_realize_and_unref(s->i2c[0], NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(s->i2c[0]);
     sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(s->ih[1], OMAP_INT_I2C));
     sysbus_connect_irq(busdev, 1, s->drq[OMAP_DMA_I2C_TX]);
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index e1c11de5ce..b45ed5c9ec 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -2306,11 +2306,11 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sdram,
     s->l4 = omap_l4_init(sysmem, OMAP2_L4_BASE, 54);
 
     /* Actually mapped at any 2K boundary in the ARM11 private-peripheral if */
-    s->ih[0] = qdev_create(NULL, "omap2-intc");
+    s->ih[0] = qdev_new("omap2-intc");
     qdev_prop_set_uint8(s->ih[0], "revision", 0x21);
     omap_intc_set_fclk(OMAP_INTC(s->ih[0]), omap_findclk(s, "mpu_intc_fclk"));
     omap_intc_set_iclk(OMAP_INTC(s->ih[0]), omap_findclk(s, "mpu_intc_iclk"));
-    qdev_init_nofail(s->ih[0]);
+    qdev_realize_and_unref(s->ih[0], NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(s->ih[0]);
     sysbus_connect_irq(busdev, 0,
                        qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_IRQ));
@@ -2423,11 +2423,11 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sdram,
                     omap_findclk(s, "clk32-kHz"),
                     omap_findclk(s, "core_l4_iclk"));
 
-    s->i2c[0] = qdev_create(NULL, "omap_i2c");
+    s->i2c[0] = qdev_new("omap_i2c");
     qdev_prop_set_uint8(s->i2c[0], "revision", 0x34);
     omap_i2c_set_iclk(OMAP_I2C(s->i2c[0]), omap_findclk(s, "i2c1.iclk"));
     omap_i2c_set_fclk(OMAP_I2C(s->i2c[0]), omap_findclk(s, "i2c1.fclk"));
-    qdev_init_nofail(s->i2c[0]);
+    qdev_realize_and_unref(s->i2c[0], NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(s->i2c[0]);
     sysbus_connect_irq(busdev, 0,
                        qdev_get_gpio_in(s->ih[0], OMAP_INT_24XX_I2C1_IRQ));
@@ -2435,11 +2435,11 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sdram,
     sysbus_connect_irq(busdev, 2, s->drq[OMAP24XX_DMA_I2C1_RX]);
     sysbus_mmio_map(busdev, 0, omap_l4_region_base(omap_l4tao(s->l4, 5), 0));
 
-    s->i2c[1] = qdev_create(NULL, "omap_i2c");
+    s->i2c[1] = qdev_new("omap_i2c");
     qdev_prop_set_uint8(s->i2c[1], "revision", 0x34);
     omap_i2c_set_iclk(OMAP_I2C(s->i2c[1]), omap_findclk(s, "i2c2.iclk"));
     omap_i2c_set_fclk(OMAP_I2C(s->i2c[1]), omap_findclk(s, "i2c2.fclk"));
-    qdev_init_nofail(s->i2c[1]);
+    qdev_realize_and_unref(s->i2c[1], NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(s->i2c[1]);
     sysbus_connect_irq(busdev, 0,
                        qdev_get_gpio_in(s->ih[0], OMAP_INT_24XX_I2C2_IRQ));
@@ -2447,7 +2447,7 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sdram,
     sysbus_connect_irq(busdev, 2, s->drq[OMAP24XX_DMA_I2C2_RX]);
     sysbus_mmio_map(busdev, 0, omap_l4_region_base(omap_l4tao(s->l4, 6), 0));
 
-    s->gpio = qdev_create(NULL, "omap2-gpio");
+    s->gpio = qdev_new("omap2-gpio");
     qdev_prop_set_int32(s->gpio, "mpu_model", s->mpu_model);
     omap2_gpio_set_iclk(OMAP2_GPIO(s->gpio), omap_findclk(s, "gpio_iclk"));
     omap2_gpio_set_fclk(OMAP2_GPIO(s->gpio), 0, omap_findclk(s, "gpio1_dbclk"));
@@ -2458,7 +2458,7 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sdram,
         omap2_gpio_set_fclk(OMAP2_GPIO(s->gpio), 4,
                             omap_findclk(s, "gpio5_dbclk"));
     }
-    qdev_init_nofail(s->gpio);
+    qdev_realize_and_unref(s->gpio, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(s->gpio);
     sysbus_connect_irq(busdev, 0,
                        qdev_get_gpio_in(s->ih[0], OMAP_INT_24XX_GPIO_BANK1));
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index b291715f27..44a333a6eb 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -94,9 +94,9 @@ static void orangepi_init(MachineState *machine)
     bus = qdev_get_child_bus(DEVICE(h3), "sd-bus");
 
     /* Plug in SD card */
-    carddev = qdev_create(bus, TYPE_SD_CARD);
+    carddev = qdev_new(TYPE_SD_CARD);
     qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
-    object_property_set_bool(OBJECT(carddev), true, "realized", &error_fatal);
+    qdev_realize_and_unref(carddev, bus, &error_fatal);
 
     /* SDRAM */
     memory_region_add_subregion(get_system_memory(), h3->memmap[AW_H3_SDRAM],
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index e649f8930c..e21ba1af3e 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -1510,10 +1510,10 @@ PXA2xxI2CState *pxa2xx_i2c_init(hwaddr base,
     PXA2xxI2CState *s;
     I2CBus *i2cbus;
 
-    dev = qdev_create(NULL, TYPE_PXA2XX_I2C);
+    dev = qdev_new(TYPE_PXA2XX_I2C);
     qdev_prop_set_uint32(dev, "size", region_size + 1);
     qdev_prop_set_uint32(dev, "offset", base & region_size);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     i2c_dev = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(i2c_dev, 0, base & ~region_size);
@@ -2073,9 +2073,9 @@ static PXA2xxFIrState *pxa2xx_fir_init(MemoryRegion *sysmem,
     DeviceState *dev;
     SysBusDevice *sbd;
 
-    dev = qdev_create(NULL, TYPE_PXA2XX_FIR);
+    dev = qdev_new(TYPE_PXA2XX_FIR);
     qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sbd = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(sbd, 0, base);
     sysbus_connect_irq(sbd, 0, irq);
diff --git a/hw/arm/pxa2xx_gpio.c b/hw/arm/pxa2xx_gpio.c
index a01db54a51..27199af43c 100644
--- a/hw/arm/pxa2xx_gpio.c
+++ b/hw/arm/pxa2xx_gpio.c
@@ -14,6 +14,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/arm/pxa.h"
+#include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 
@@ -269,10 +270,10 @@ DeviceState *pxa2xx_gpio_init(hwaddr base,
     CPUState *cs = CPU(cpu);
     DeviceState *dev;
 
-    dev = qdev_create(NULL, TYPE_PXA2XX_GPIO);
+    dev = qdev_new(TYPE_PXA2XX_GPIO);
     qdev_prop_set_int32(dev, "lines", lines);
     qdev_prop_set_int32(dev, "ncpu", cs->cpu_index);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
diff --git a/hw/arm/pxa2xx_pic.c b/hw/arm/pxa2xx_pic.c
index 203d4d28af..4c451cf540 100644
--- a/hw/arm/pxa2xx_pic.c
+++ b/hw/arm/pxa2xx_pic.c
@@ -9,6 +9,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/module.h"
 #include "cpu.h"
 #include "hw/arm/pxa.h"
@@ -267,7 +268,7 @@ static int pxa2xx_pic_post_load(void *opaque, int version_id)
 
 DeviceState *pxa2xx_pic_init(hwaddr base, ARMCPU *cpu)
 {
-    DeviceState *dev = qdev_create(NULL, TYPE_PXA2XX_PIC);
+    DeviceState *dev = qdev_new(TYPE_PXA2XX_PIC);
     PXA2xxPICState *s = PXA2XX_PIC(dev);
 
     s->cpu = cpu;
@@ -279,7 +280,7 @@ DeviceState *pxa2xx_pic_init(hwaddr base, ARMCPU *cpu)
     s->is_fiq[0] = 0;
     s->is_fiq[1] = 0;
 
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     qdev_init_gpio_in(dev, pxa2xx_pic_set_irq, PXA2XX_PIC_SRCS);
 
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index a2efe0b94d..a8e26a70bb 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -297,9 +297,9 @@ static void raspi_machine_init(MachineState *machine)
         error_report("No SD bus found in SOC object");
         exit(1);
     }
-    carddev = qdev_create(bus, TYPE_SD_CARD);
+    carddev = qdev_new(TYPE_SD_CARD);
     qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
-    object_property_set_bool(OBJECT(carddev), true, "realized", &error_fatal);
+    qdev_realize_and_unref(carddev, bus, &error_fatal);
 
     vcram_size = object_property_get_uint(OBJECT(&s->soc), "vcram-size",
                                           &error_abort);
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 8fcdf75a2b..128146448c 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -161,16 +161,16 @@ static void realview_init(MachineState *machine,
     }
 
     sys_id = is_pb ? 0x01780500 : 0xc1400400;
-    sysctl = qdev_create(NULL, "realview_sysctl");
+    sysctl = qdev_new("realview_sysctl");
     qdev_prop_set_uint32(sysctl, "sys_id", sys_id);
     qdev_prop_set_uint32(sysctl, "proc_id", proc_id);
-    qdev_init_nofail(sysctl);
+    qdev_realize_and_unref(sysctl, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(sysctl), 0, 0x10000000);
 
     if (is_mpcore) {
-        dev = qdev_create(NULL, is_pb ? TYPE_A9MPCORE_PRIV : "realview_mpcore");
+        dev = qdev_new(is_pb ? TYPE_A9MPCORE_PRIV : "realview_mpcore");
         qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
-        qdev_init_nofail(dev);
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(busdev, 0, periphbase);
         for (n = 0; n < smp_cpus; n++) {
@@ -188,9 +188,9 @@ static void realview_init(MachineState *machine,
         pic[n] = qdev_get_gpio_in(dev, n);
     }
 
-    pl041 = qdev_create(NULL, "pl041");
+    pl041 = qdev_new("pl041");
     qdev_prop_set_uint32(pl041, "nc_fifo_depth", 512);
-    qdev_init_nofail(pl041);
+    qdev_realize_and_unref(pl041, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(pl041), 0, 0x10004000);
     sysbus_connect_irq(SYS_BUS_DEVICE(pl041), 0, pic[19]);
 
@@ -203,10 +203,10 @@ static void realview_init(MachineState *machine,
     pl011_create(0x1000c000, pic[15], serial_hd(3));
 
     /* DMA controller is optional, apparently.  */
-    dev = qdev_create(NULL, "pl081");
+    dev = qdev_new("pl081");
     object_property_set_link(OBJECT(dev), OBJECT(sysmem), "downstream",
                              &error_fatal);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(busdev, 0, 0x10030000);
     sysbus_connect_irq(busdev, 0, pic[24]);
@@ -239,9 +239,9 @@ static void realview_init(MachineState *machine,
     sysbus_create_simple("pl031", 0x10017000, pic[10]);
 
     if (!is_pb) {
-        dev = qdev_create(NULL, "realview_pci");
+        dev = qdev_new("realview_pci");
         busdev = SYS_BUS_DEVICE(dev);
-        qdev_init_nofail(dev);
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
         sysbus_mmio_map(busdev, 0, 0x10019000); /* PCI controller registers */
         sysbus_mmio_map(busdev, 1, 0x60000000); /* PCI self-config */
         sysbus_mmio_map(busdev, 2, 0x61000000); /* PCI config */
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 6a0221a681..d68c5d87af 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -339,7 +339,7 @@ static void create_gic(SBSAMachineState *sms)
 
     gictype = gicv3_class_name();
 
-    sms->gic = qdev_create(NULL, gictype);
+    sms->gic = qdev_new(gictype);
     qdev_prop_set_uint32(sms->gic, "revision", 3);
     qdev_prop_set_uint32(sms->gic, "num-cpu", smp_cpus);
     /*
@@ -356,7 +356,7 @@ static void create_gic(SBSAMachineState *sms)
     qdev_prop_set_uint32(sms->gic, "len-redist-region-count", 1);
     qdev_prop_set_uint32(sms->gic, "redist-region-count[0]", redist0_count);
 
-    qdev_init_nofail(sms->gic);
+    qdev_realize_and_unref(sms->gic, NULL, &error_fatal);
     gicbusdev = SYS_BUS_DEVICE(sms->gic);
     sysbus_mmio_map(gicbusdev, 0, sbsa_ref_memmap[SBSA_GIC_DIST].base);
     sysbus_mmio_map(gicbusdev, 1, sbsa_ref_memmap[SBSA_GIC_REDIST].base);
@@ -409,11 +409,11 @@ static void create_uart(const SBSAMachineState *sms, int uart,
 {
     hwaddr base = sbsa_ref_memmap[uart].base;
     int irq = sbsa_ref_irqmap[uart];
-    DeviceState *dev = qdev_create(NULL, TYPE_PL011);
+    DeviceState *dev = qdev_new(TYPE_PL011);
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
 
     qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     memory_region_add_subregion(mem, base,
                                 sysbus_mmio_get_region(s, 0));
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(sms->gic, irq));
@@ -464,9 +464,9 @@ static void create_ahci(const SBSAMachineState *sms)
     AHCIState *ahci;
     int i;
 
-    dev = qdev_create(NULL, "sysbus-ahci");
+    dev = qdev_new("sysbus-ahci");
     qdev_prop_set_uint32(dev, "num-ports", NUM_SATA_PORTS);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(sms->gic, irq));
 
@@ -497,11 +497,11 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
     DeviceState *dev;
     int i;
 
-    dev = qdev_create(NULL, "arm-smmuv3");
+    dev = qdev_new("arm-smmuv3");
 
     object_property_set_link(OBJECT(dev), OBJECT(bus), "primary-bus",
                              &error_abort);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < NUM_SMMU_IRQS; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
@@ -525,8 +525,8 @@ static void create_pcie(SBSAMachineState *sms)
     PCIHostState *pci;
     int i;
 
-    dev = qdev_create(NULL, TYPE_GPEX_HOST);
-    qdev_init_nofail(dev);
+    dev = qdev_new(TYPE_GPEX_HOST);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     /* Map ECAM space */
     ecam_alias = g_new0(MemoryRegion, 1);
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index c28d9b5ed7..edae6bf8be 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -155,7 +155,7 @@ static void sl_flash_register(PXA2xxState *cpu, int size)
 {
     DeviceState *dev;
 
-    dev = qdev_create(NULL, TYPE_SL_NAND);
+    dev = qdev_new(TYPE_SL_NAND);
 
     qdev_prop_set_uint8(dev, "manf_id", NAND_MFR_SAMSUNG);
     if (size == FLASH_128M)
@@ -163,7 +163,7 @@ static void sl_flash_register(PXA2xxState *cpu, int size)
     else if (size == FLASH_1024M)
         qdev_prop_set_uint8(dev, "chip_id", 0xf1);
 
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, FLASH_BASE);
 }
 
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index d136ba1a92..f824cbd498 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1308,14 +1308,14 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
                            &error_fatal);
     memory_region_add_subregion(system_memory, 0x20000000, sram);
 
-    nvic = qdev_create(NULL, TYPE_ARMV7M);
+    nvic = qdev_new(TYPE_ARMV7M);
     qdev_prop_set_uint32(nvic, "num-irq", NUM_IRQ_LINES);
     qdev_prop_set_string(nvic, "cpu-type", ms->cpu_type);
     qdev_prop_set_bit(nvic, "enable-bitband", true);
     object_property_set_link(OBJECT(nvic), OBJECT(get_system_memory()),
                                      "memory", &error_abort);
     /* This will exit with an error if the user passed us a bad cpu_type */
-    qdev_init_nofail(nvic);
+    qdev_realize_and_unref(nvic, NULL, &error_fatal);
 
     qdev_connect_gpio_out_named(nvic, "SYSRESETREQ", 0,
                                 qemu_allocate_irq(&do_sys_reset, NULL, 0));
@@ -1347,13 +1347,13 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
 
 
     if (board->dc1 & (1 << 3)) { /* watchdog present */
-        dev = qdev_create(NULL, TYPE_LUMINARY_WATCHDOG);
+        dev = qdev_new(TYPE_LUMINARY_WATCHDOG);
 
         /* system_clock_scale is valid now */
         uint32_t mainclk = NANOSECONDS_PER_SECOND / system_clock_scale;
         qdev_prop_set_uint32(dev, "wdogclk-frq", mainclk);
 
-        qdev_init_nofail(dev);
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev),
                         0,
                         0x40000000u);
@@ -1425,9 +1425,9 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
 
         qemu_check_nic_model(&nd_table[0], "stellaris");
 
-        enet = qdev_create(NULL, "stellaris_enet");
+        enet = qdev_new("stellaris_enet");
         qdev_set_nic_properties(enet, &nd_table[0]);
-        qdev_init_nofail(enet);
+        qdev_realize_and_unref(enet, NULL, &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(enet), 0, 0x40048000);
         sysbus_connect_irq(SYS_BUS_DEVICE(enet), 0, qdev_get_gpio_in(nvic, 42));
     }
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 3010d765bb..108ed8d147 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -42,6 +42,7 @@
 #include "chardev/char-serial.h"
 #include "sysemu/sysemu.h"
 #include "hw/ssi/ssi.h"
+#include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 
@@ -644,8 +645,8 @@ static DeviceState *strongarm_gpio_init(hwaddr base,
     DeviceState *dev;
     int i;
 
-    dev = qdev_create(NULL, TYPE_STRONGARM_GPIO);
-    qdev_init_nofail(dev);
+    dev = qdev_new(TYPE_STRONGARM_GPIO);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < 12; i++)
@@ -1626,9 +1627,9 @@ StrongARMState *sa1110_init(const char *cpu_type)
     s->ppc = sysbus_create_varargs(TYPE_STRONGARM_PPC, 0x90060000, NULL);
 
     for (i = 0; sa_serial[i].io_base; i++) {
-        DeviceState *dev = qdev_create(NULL, TYPE_STRONGARM_UART);
+        DeviceState *dev = qdev_new(TYPE_STRONGARM_UART);
         qdev_prop_set_chr(dev, "chardev", serial_hd(i));
-        qdev_init_nofail(dev);
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0,
                 sa_serial[i].io_base);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index f3c4a50b19..154fa72f33 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -223,10 +223,10 @@ static void versatile_init(MachineState *machine, int board_id)
     /* SDRAM at address zero.  */
     memory_region_add_subregion(sysmem, 0, machine->ram);
 
-    sysctl = qdev_create(NULL, "realview_sysctl");
+    sysctl = qdev_new("realview_sysctl");
     qdev_prop_set_uint32(sysctl, "sys_id", 0x41007004);
     qdev_prop_set_uint32(sysctl, "proc_id", 0x02000000);
-    qdev_init_nofail(sysctl);
+    qdev_realize_and_unref(sysctl, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(sysctl), 0, 0x10000000);
 
     dev = sysbus_create_varargs("pl190", 0x10140000,
@@ -245,9 +245,9 @@ static void versatile_init(MachineState *machine, int board_id)
     sysbus_create_simple("pl050_keyboard", 0x10006000, sic[3]);
     sysbus_create_simple("pl050_mouse", 0x10007000, sic[4]);
 
-    dev = qdev_create(NULL, "versatile_pci");
+    dev = qdev_new("versatile_pci");
     busdev = SYS_BUS_DEVICE(dev);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0x10001000); /* PCI controller regs */
     sysbus_mmio_map(busdev, 1, 0x41000000); /* PCI self-config */
     sysbus_mmio_map(busdev, 2, 0x42000000); /* PCI config */
@@ -286,10 +286,10 @@ static void versatile_init(MachineState *machine, int board_id)
     pl011_create(0x101f3000, pic[14], serial_hd(2));
     pl011_create(0x10009000, sic[6], serial_hd(3));
 
-    dev = qdev_create(NULL, "pl080");
+    dev = qdev_new("pl080");
     object_property_set_link(OBJECT(dev), OBJECT(sysmem), "downstream",
                              &error_fatal);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(busdev, 0, 0x10130000);
     sysbus_connect_irq(busdev, 0, pic[17]);
@@ -319,9 +319,9 @@ static void versatile_init(MachineState *machine, int board_id)
     i2c_create_slave(i2c, "ds1338", 0x68);
 
     /* Add PL041 AACI Interface to the LM4549 codec */
-    pl041 = qdev_create(NULL, "pl041");
+    pl041 = qdev_new("pl041");
     qdev_prop_set_uint32(pl041, "nc_fifo_depth", 512);
-    qdev_init_nofail(pl041);
+    qdev_realize_and_unref(pl041, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(pl041), 0, 0x10004000);
     sysbus_connect_irq(SYS_BUS_DEVICE(pl041), 0, sic[24]);
 
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 69ee4988f9..ef29e9f5ae 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -236,9 +236,9 @@ static void init_cpus(MachineState *ms, const char *cpu_type,
      * this must happen after the CPUs are created because a15mpcore_priv
      * wires itself up to the CPU's generic_timer gpio out lines.
      */
-    dev = qdev_create(NULL, privdev);
+    dev = qdev_new(privdev);
     qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(busdev, 0, periphbase);
 
@@ -514,7 +514,7 @@ static void vexpress_modify_dtb(const struct arm_boot_info *info, void *fdt)
 static PFlashCFI01 *ve_pflash_cfi01_register(hwaddr base, const char *name,
                                              DriveInfo *di)
 {
-    DeviceState *dev = qdev_create(NULL, TYPE_PFLASH_CFI01);
+    DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
 
     if (di) {
         qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(di),
@@ -532,7 +532,7 @@ static PFlashCFI01 *ve_pflash_cfi01_register(hwaddr base, const char *name,
     qdev_prop_set_uint16(dev, "id2", 0x00);
     qdev_prop_set_uint16(dev, "id3", 0x00);
     qdev_prop_set_string(dev, "name", name);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     return PFLASH_CFI01(dev);
@@ -593,7 +593,7 @@ static void vexpress_common_init(MachineState *machine)
 
     sys_id = 0x1190f500;
 
-    sysctl = qdev_create(NULL, "realview_sysctl");
+    sysctl = qdev_new("realview_sysctl");
     qdev_prop_set_uint32(sysctl, "sys_id", sys_id);
     qdev_prop_set_uint32(sysctl, "proc_id", daughterboard->proc_id);
     qdev_prop_set_uint32(sysctl, "len-db-voltage",
@@ -610,15 +610,15 @@ static void vexpress_common_init(MachineState *machine)
         qdev_prop_set_uint32(sysctl, propname, daughterboard->clocks[i]);
         g_free(propname);
     }
-    qdev_init_nofail(sysctl);
+    qdev_realize_and_unref(sysctl, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(sysctl), 0, map[VE_SYSREGS]);
 
     /* VE_SP810: not modelled */
     /* VE_SERIALPCI: not modelled */
 
-    pl041 = qdev_create(NULL, "pl041");
+    pl041 = qdev_new("pl041");
     qdev_prop_set_uint32(pl041, "nc_fifo_depth", 512);
-    qdev_init_nofail(pl041);
+    qdev_realize_and_unref(pl041, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(pl041), 0, map[VE_PL041]);
     sysbus_connect_irq(SYS_BUS_DEVICE(pl041), 0, pic[11]);
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 37462a6f78..154cd24731 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -572,14 +572,14 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
         event |= ACPI_GED_NVDIMM_HOTPLUG_EVT;
     }
 
-    dev = qdev_create(NULL, TYPE_ACPI_GED);
+    dev = qdev_new(TYPE_ACPI_GED);
     qdev_prop_set_uint32(dev, "ged-event", event);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_ACPI_GED].base);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, vms->memmap[VIRT_PCDIMM_ACPI].base);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(vms->gic, irq));
 
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     return dev;
 }
@@ -594,11 +594,11 @@ static void create_its(VirtMachineState *vms)
         return;
     }
 
-    dev = qdev_create(NULL, itsclass);
+    dev = qdev_new(itsclass);
 
     object_property_set_link(OBJECT(dev), OBJECT(vms->gic), "parent-gicv3",
                              &error_abort);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_GIC_ITS].base);
 
     fdt_add_its_gic_node(vms);
@@ -610,11 +610,11 @@ static void create_v2m(VirtMachineState *vms)
     int irq = vms->irqmap[VIRT_GIC_V2M];
     DeviceState *dev;
 
-    dev = qdev_create(NULL, "arm-gicv2m");
+    dev = qdev_new("arm-gicv2m");
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_GIC_V2M].base);
     qdev_prop_set_uint32(dev, "base-spi", irq);
     qdev_prop_set_uint32(dev, "num-spi", NUM_GICV2M_SPIS);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     for (i = 0; i < NUM_GICV2M_SPIS; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
@@ -636,7 +636,7 @@ static void create_gic(VirtMachineState *vms)
 
     gictype = (type == 3) ? gicv3_class_name() : gic_class_name();
 
-    vms->gic = qdev_create(NULL, gictype);
+    vms->gic = qdev_new(gictype);
     qdev_prop_set_uint32(vms->gic, "revision", type);
     qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
     /* Note that the num-irq property counts both internal and external
@@ -671,7 +671,7 @@ static void create_gic(VirtMachineState *vms)
                               vms->virt);
         }
     }
-    qdev_init_nofail(vms->gic);
+    qdev_realize_and_unref(vms->gic, NULL, &error_fatal);
     gicbusdev = SYS_BUS_DEVICE(vms->gic);
     sysbus_mmio_map(gicbusdev, 0, vms->memmap[VIRT_GIC_DIST].base);
     if (type == 3) {
@@ -754,11 +754,11 @@ static void create_uart(const VirtMachineState *vms, int uart,
     int irq = vms->irqmap[uart];
     const char compat[] = "arm,pl011\0arm,primecell";
     const char clocknames[] = "uartclk\0apb_pclk";
-    DeviceState *dev = qdev_create(NULL, TYPE_PL011);
+    DeviceState *dev = qdev_new(TYPE_PL011);
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
 
     qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     memory_region_add_subregion(mem, base,
                                 sysbus_mmio_get_region(s, 0));
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
@@ -1173,11 +1173,11 @@ static void create_smmu(const VirtMachineState *vms,
         return;
     }
 
-    dev = qdev_create(NULL, "arm-smmuv3");
+    dev = qdev_new("arm-smmuv3");
 
     object_property_set_link(OBJECT(dev), OBJECT(bus), "primary-bus",
                              &error_abort);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < NUM_SMMU_IRQS; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
@@ -1253,8 +1253,8 @@ static void create_pcie(VirtMachineState *vms)
     int i, ecam_id;
     PCIHostState *pci;
 
-    dev = qdev_create(NULL, TYPE_GPEX_HOST);
-    qdev_init_nofail(dev);
+    dev = qdev_new(TYPE_GPEX_HOST);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     ecam_id = VIRT_ECAM_ID(vms->highmem_ecam);
     base_ecam = vms->memmap[ecam_id].base;
@@ -1372,11 +1372,11 @@ static void create_platform_bus(VirtMachineState *vms)
     int i;
     MemoryRegion *sysmem = get_system_memory();
 
-    dev = qdev_create(NULL, TYPE_PLATFORM_BUS_DEVICE);
+    dev = qdev_new(TYPE_PLATFORM_BUS_DEVICE);
     dev->id = TYPE_PLATFORM_BUS_DEVICE;
     qdev_prop_set_uint32(dev, "num_irqs", PLATFORM_BUS_NUM_IRQS);
     qdev_prop_set_uint32(dev, "mmio_size", vms->memmap[VIRT_PLATFORM_BUS].size);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     vms->platform_bus_dev = dev;
 
     s = SYS_BUS_DEVICE(dev);
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index cb933efb49..5fbd2b2e31 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -114,12 +114,12 @@ static void gem_init(NICInfo *nd, uint32_t base, qemu_irq irq)
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_create(NULL, TYPE_CADENCE_GEM);
+    dev = qdev_new(TYPE_CADENCE_GEM);
     if (nd->used) {
         qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
         qdev_set_nic_properties(dev, nd);
     }
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(s, 0, base);
     sysbus_connect_irq(s, 0, irq);
@@ -136,11 +136,11 @@ static inline void zynq_init_spi_flashes(uint32_t base_addr, qemu_irq irq,
     int num_busses =  is_qspi ? NUM_QSPI_BUSSES : 1;
     int num_ss = is_qspi ? NUM_QSPI_FLASHES : NUM_SPI_FLASHES;
 
-    dev = qdev_create(NULL, is_qspi ? "xlnx.ps7-qspi" : "xlnx.ps7-spi");
+    dev = qdev_new(is_qspi ? "xlnx.ps7-qspi" : "xlnx.ps7-spi");
     qdev_prop_set_uint8(dev, "num-txrx-bytes", is_qspi ? 4 : 1);
     qdev_prop_set_uint8(dev, "num-ss-bits", num_ss);
     qdev_prop_set_uint8(dev, "num-busses", num_busses);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(busdev, 0, base_addr);
     if (is_qspi) {
@@ -222,8 +222,8 @@ static void zynq_init(MachineState *machine)
                           0);
 
     /* Create slcr, keep a pointer to connect clocks */
-    slcr = qdev_create(NULL, "xilinx,zynq_slcr");
-    qdev_init_nofail(slcr);
+    slcr = qdev_new("xilinx,zynq_slcr");
+    qdev_realize_and_unref(slcr, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);
 
     /* Create the main clock source, and feed slcr with it */
@@ -234,9 +234,9 @@ static void zynq_init(MachineState *machine)
     clock_set_hz(zynq_machine->ps_clk, PS_CLK_FREQUENCY);
     qdev_connect_clock_in(slcr, "ps_clk", zynq_machine->ps_clk);
 
-    dev = qdev_create(NULL, TYPE_A9MPCORE_PRIV);
+    dev = qdev_new(TYPE_A9MPCORE_PRIV);
     qdev_prop_set_uint32(dev, "num-cpu", 1);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
     sysbus_connect_irq(busdev, 0,
@@ -280,27 +280,27 @@ static void zynq_init(MachineState *machine)
          * - SDIO Specification Version 2.0
          * - MMC Specification Version 3.31
          */
-        dev = qdev_create(NULL, TYPE_SYSBUS_SDHCI);
+        dev = qdev_new(TYPE_SYSBUS_SDHCI);
         qdev_prop_set_uint8(dev, "sd-spec-version", 2);
         qdev_prop_set_uint64(dev, "capareg", ZYNQ_SDHCI_CAPABILITIES);
-        qdev_init_nofail(dev);
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, hci_addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[hci_irq - IRQ_OFFSET]);
 
         di = drive_get_next(IF_SD);
         blk = di ? blk_by_legacy_dinfo(di) : NULL;
-        carddev = qdev_create(qdev_get_child_bus(dev, "sd-bus"), TYPE_SD_CARD);
+        carddev = qdev_new(TYPE_SD_CARD);
         qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
-        object_property_set_bool(OBJECT(carddev), true, "realized",
-                                 &error_fatal);
+        qdev_realize_and_unref(carddev, qdev_get_child_bus(dev, "sd-bus"),
+                               &error_fatal);
     }
 
-    dev = qdev_create(NULL, TYPE_ZYNQ_XADC);
-    qdev_init_nofail(dev);
+    dev = qdev_new(TYPE_ZYNQ_XADC);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xF8007100);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[39-IRQ_OFFSET]);
 
-    dev = qdev_create(NULL, "pl330");
+    dev = qdev_new("pl330");
     qdev_prop_set_uint8(dev, "num_chnls",  8);
     qdev_prop_set_uint8(dev, "num_periph_req",  4);
     qdev_prop_set_uint8(dev, "num_events",  16);
@@ -312,7 +312,7 @@ static void zynq_init(MachineState *machine)
     qdev_prop_set_uint8(dev, "rd_q_dep",  16);
     qdev_prop_set_uint16(dev, "data_buffer_dep",  256);
 
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(busdev, 0, 0xF8003000);
     sysbus_connect_irq(busdev, 0, pic[45-IRQ_OFFSET]); /* abort irq line */
@@ -320,8 +320,8 @@ static void zynq_init(MachineState *machine)
         sysbus_connect_irq(busdev, n + 1, pic[dma_irqs[n] - IRQ_OFFSET]);
     }
 
-    dev = qdev_create(NULL, "xlnx.ps7-dev-cfg");
-    qdev_init_nofail(dev);
+    dev = qdev_new("xlnx.ps7-dev-cfg");
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_connect_irq(busdev, 0, pic[40 - IRQ_OFFSET]);
     sysbus_mmio_map(busdev, 0, 0xF8007000);
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 43a71e2eea..fb37b235fe 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -432,9 +432,9 @@ static void create_virtio_regions(VersalVirt *s)
         qemu_irq pic_irq;
 
         pic_irq = qdev_get_gpio_in(DEVICE(&s->soc.fpd.apu.gic), irq);
-        dev = qdev_create(NULL, "virtio-mmio");
+        dev = qdev_new("virtio-mmio");
         object_property_add_child(OBJECT(&s->soc), name, OBJECT(dev));
-        qdev_init_nofail(dev);
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic_irq);
         mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
         memory_region_add_subregion(&s->soc.mr_ps, base, mr);
@@ -463,10 +463,11 @@ static void sd_plugin_card(SDHCIState *sd, DriveInfo *di)
     BlockBackend *blk = di ? blk_by_legacy_dinfo(di) : NULL;
     DeviceState *card;
 
-    card = qdev_create(qdev_get_child_bus(DEVICE(sd), "sd-bus"), TYPE_SD_CARD);
+    card = qdev_new(TYPE_SD_CARD);
     object_property_add_child(OBJECT(sd), "card[*]", OBJECT(card));
     qdev_prop_set_drive(card, "drive", blk, &error_fatal);
-    object_property_set_bool(OBJECT(card), true, "realized", &error_fatal);
+    qdev_realize_and_unref(card, qdev_get_child_bus(DEVICE(sd), "sd-bus"),
+                           &error_fatal);
 }
 
 static void versal_virt_init(MachineState *machine)
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 809a31390f..c3d47bb9e9 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -304,13 +304,13 @@ static void versal_unimp_area(Versal *s, const char *name,
                                 MemoryRegion *mr,
                                 hwaddr base, hwaddr size)
 {
-    DeviceState *dev = qdev_create(NULL, TYPE_UNIMPLEMENTED_DEVICE);
+    DeviceState *dev = qdev_new(TYPE_UNIMPLEMENTED_DEVICE);
     MemoryRegion *mr_dev;
 
     qdev_prop_set_string(dev, "name", name);
     qdev_prop_set_uint64(dev, "size", size);
     object_property_add_child(OBJECT(s), name, OBJECT(dev));
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     mr_dev = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
     memory_region_add_subregion(mr, base, mr_dev);
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index b01e575b58..4229b2d936 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -143,10 +143,9 @@ static void xlnx_zcu102_init(MachineState *machine)
             error_report("No SD bus found for SD card %d", i);
             exit(1);
         }
-        carddev = qdev_create(bus, TYPE_SD_CARD);
+        carddev = qdev_new(TYPE_SD_CARD);
         qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
-        object_property_set_bool(OBJECT(carddev), true, "realized",
-                                 &error_fatal);
+        qdev_realize_and_unref(carddev, bus, &error_fatal);
     }
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_SPIS; i++) {
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 4696ae0d9a..f673b8317a 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -1309,8 +1309,8 @@ static int intel_hda_and_codec_init(PCIBus *bus)
 
     controller = DEVICE(pci_create_simple(bus, -1, "intel-hda"));
     hdabus = QLIST_FIRST(&controller->child_bus);
-    codec = qdev_create(hdabus, "hda-duplex");
-    qdev_init_nofail(codec);
+    codec = qdev_new("hda-duplex");
+    qdev_realize_and_unref(codec, hdabus, &error_fatal);
     return 0;
 }
 
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index c5fb9d6ece..1feb398875 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2516,7 +2516,7 @@ static void fdctrl_connect_drives(FDCtrl *fdctrl, DeviceState *fdc_dev,
             continue;
         }
 
-        dev = qdev_create(&fdctrl->bus.bus, "floppy");
+        dev = qdev_new("floppy");
         qdev_prop_set_uint32(dev, "unit", i);
         qdev_prop_set_enum(dev, "drive-type", fdctrl->qdev_for_drives[i].type);
 
@@ -2531,7 +2531,7 @@ static void fdctrl_connect_drives(FDCtrl *fdctrl, DeviceState *fdc_dev,
             return;
         }
 
-        object_property_set_bool(OBJECT(dev), true, "realized", &local_err);
+        qdev_realize_and_unref(dev, &fdctrl->bus.bus, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
@@ -2571,7 +2571,7 @@ void fdctrl_init_sysbus(qemu_irq irq, int dma_chann,
     SysBusDevice *sbd;
     FDCtrlSysBus *sys;
 
-    dev = qdev_create(NULL, "sysbus-fdc");
+    dev = qdev_new("sysbus-fdc");
     sys = SYSBUS_FDC(dev);
     fdctrl = &sys->state;
     fdctrl->dma_chann = dma_chann; /* FIXME */
@@ -2583,7 +2583,7 @@ void fdctrl_init_sysbus(qemu_irq irq, int dma_chann,
         qdev_prop_set_drive(dev, "driveB", blk_by_legacy_dinfo(fds[1]),
                             &error_fatal);
     }
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sbd = SYS_BUS_DEVICE(dev);
     sysbus_connect_irq(sbd, 0, irq);
     sysbus_mmio_map(sbd, 0, mmio_base);
@@ -2595,12 +2595,12 @@ void sun4m_fdctrl_init(qemu_irq irq, hwaddr io_base,
     DeviceState *dev;
     FDCtrlSysBus *sys;
 
-    dev = qdev_create(NULL, "SUNW,fdtwo");
+    dev = qdev_new("SUNW,fdtwo");
     if (fds[0]) {
         qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(fds[0]),
                             &error_fatal);
     }
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sys = SYSBUS_FDC(dev);
     sysbus_connect_irq(SYS_BUS_DEVICE(sys), 0, irq);
     sysbus_mmio_map(SYS_BUS_DEVICE(sys), 0, io_base);
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 11922c0f96..d2a647d2b8 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -959,7 +959,7 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
                                    uint16_t id2, uint16_t id3,
                                    int be)
 {
-    DeviceState *dev = qdev_create(NULL, TYPE_PFLASH_CFI01);
+    DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
 
     if (blk) {
         qdev_prop_set_drive(dev, "drive", blk, &error_abort);
@@ -974,7 +974,7 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
     qdev_prop_set_uint16(dev, "id2", id2);
     qdev_prop_set_uint16(dev, "id3", id3);
     qdev_prop_set_string(dev, "name", name);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     return PFLASH_CFI01(dev);
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index ac7e34ecbf..ed9e9eef0c 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -998,7 +998,7 @@ PFlashCFI02 *pflash_cfi02_register(hwaddr base,
                                    uint16_t unlock_addr1,
                                    int be)
 {
-    DeviceState *dev = qdev_create(NULL, TYPE_PFLASH_CFI02);
+    DeviceState *dev = qdev_new(TYPE_PFLASH_CFI02);
 
     if (blk) {
         qdev_prop_set_drive(dev, "drive", blk, &error_abort);
@@ -1016,7 +1016,7 @@ PFlashCFI02 *pflash_cfi02_register(hwaddr base,
     qdev_prop_set_uint16(dev, "unlock-addr0", unlock_addr0);
     qdev_prop_set_uint16(dev, "unlock-addr1", unlock_addr1);
     qdev_prop_set_string(dev, "name", name);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     return PFLASH_CFI02(dev);
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 96d5180e3e..b86bd7b2e6 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
@@ -652,7 +653,7 @@ DeviceState *exynos4210_uart_create(hwaddr addr,
     DeviceState  *dev;
     SysBusDevice *bus;
 
-    dev = qdev_create(NULL, TYPE_EXYNOS4210_UART);
+    dev = qdev_new(TYPE_EXYNOS4210_UART);
 
     qdev_prop_set_chr(dev, "chardev", chr);
     qdev_prop_set_uint32(dev, "channel", channel);
@@ -660,7 +661,7 @@ DeviceState *exynos4210_uart_create(hwaddr addr,
     qdev_prop_set_uint32(dev, "tx-size", fifo_size);
 
     bus = SYS_BUS_DEVICE(dev);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     if (addr != (hwaddr)-1) {
         sysbus_mmio_map(bus, 0, addr);
     }
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index 97e4bbc31a..2ac0a195f3 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -10,6 +10,7 @@
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
+#include "qapi/error.h"
 #include "hw/m68k/mcf.h"
 #include "hw/qdev-properties.h"
 #include "chardev/char-fe.h"
@@ -343,11 +344,11 @@ void *mcf_uart_init(qemu_irq irq, Chardev *chrdrv)
 {
     DeviceState  *dev;
 
-    dev = qdev_create(NULL, TYPE_MCF_UART);
+    dev = qdev_new(TYPE_MCF_UART);
     if (chrdrv) {
         qdev_prop_set_chr(dev, "chardev", chrdrv);
     }
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
 
diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index ecb94f5673..464a52342a 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -158,9 +158,9 @@ void spapr_vty_create(SpaprVioBus *bus, Chardev *chardev)
 {
     DeviceState *dev;
 
-    dev = qdev_create(&bus->bus, "spapr-vty");
+    dev = qdev_new("spapr-vty");
     qdev_prop_set_chr(dev, "chardev", chardev);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, &bus->bus, &error_fatal);
 }
 
 static Property spapr_vty_properties[] = {
diff --git a/hw/core/empty_slot.c b/hw/core/empty_slot.c
index 3ba450e1ca..725e5fd998 100644
--- a/hw/core/empty_slot.c
+++ b/hw/core/empty_slot.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/empty_slot.h"
 
@@ -60,12 +61,12 @@ void empty_slot_init(hwaddr addr, uint64_t slot_size)
         SysBusDevice *s;
         EmptySlot *e;
 
-        dev = qdev_create(NULL, TYPE_EMPTY_SLOT);
+        dev = qdev_new(TYPE_EMPTY_SLOT);
         s = SYS_BUS_DEVICE(dev);
         e = EMPTY_SLOT(dev);
         e->size = slot_size;
 
-        qdev_init_nofail(dev);
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
 
         sysbus_mmio_map(s, 0, addr);
     }
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 08b0311c5f..b5db0d179f 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -230,9 +230,9 @@ DeviceState *sysbus_create_varargs(const char *name,
     qemu_irq irq;
     int n;
 
-    dev = qdev_create(NULL, name);
+    dev = qdev_new(name);
     s = SYS_BUS_DEVICE(dev);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     if (addr != (hwaddr)-1) {
         sysbus_mmio_map(s, 0, addr);
     }
diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
index 75e5c993b5..5db667d518 100644
--- a/hw/cris/axis_dev88.c
+++ b/hw/cris/axis_dev88.c
@@ -289,8 +289,8 @@ void axisdev88_init(MachineState *machine)
                                 &gpio_state.iomem);
 
 
-    dev = qdev_create(NULL, "etraxfs,pic");
-    qdev_init_nofail(dev);
+    dev = qdev_new("etraxfs,pic");
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(s, 0, 0x3001c000);
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(DEVICE(cpu), CRIS_CPU_IRQ));
diff --git a/hw/display/milkymist-tmu2.c b/hw/display/milkymist-tmu2.c
index 513c0d5bab..e54fd85777 100644
--- a/hw/display/milkymist-tmu2.c
+++ b/hw/display/milkymist-tmu2.c
@@ -543,8 +543,8 @@ DeviceState *milkymist_tmu2_create(hwaddr base, qemu_irq irq)
     XFree(configs);
     XCloseDisplay(d);
 
-    dev = qdev_create(NULL, TYPE_MILKYMIST_TMU2);
-    qdev_init_nofail(dev);
+    dev = qdev_new(TYPE_MILKYMIST_TMU2);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
 
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index fa23a78164..7ff14fd474 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1969,10 +1969,10 @@ static void sm501_realize_sysbus(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->state.mmio_region);
 
     /* bridge to usb host emulation module */
-    usb_dev = qdev_create(NULL, "sysbus-ohci");
+    usb_dev = qdev_new("sysbus-ohci");
     qdev_prop_set_uint32(usb_dev, "num-ports", 2);
     qdev_prop_set_uint64(usb_dev, "dma-offset", s->base);
-    qdev_init_nofail(usb_dev);
+    qdev_realize_and_unref(usb_dev, NULL, &error_fatal);
     memory_region_add_subregion(&s->state.mmio_region, SM501_USB_HOST,
                        sysbus_mmio_get_region(SYS_BUS_DEVICE(usb_dev), 0));
     sysbus_pass_irq(sbd, SYS_BUS_DEVICE(usb_dev));
diff --git a/hw/dma/pxa2xx_dma.c b/hw/dma/pxa2xx_dma.c
index 8a2eeb32bc..6b761af701 100644
--- a/hw/dma/pxa2xx_dma.c
+++ b/hw/dma/pxa2xx_dma.c
@@ -495,9 +495,9 @@ DeviceState *pxa27x_dma_init(hwaddr base, qemu_irq irq)
 {
     DeviceState *dev;
 
-    dev = qdev_create(NULL, "pxa2xx-dma");
+    dev = qdev_new("pxa2xx-dma");
     qdev_prop_set_int32(dev, "channels", PXA27X_DMA_NUM_CHANNELS);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
@@ -509,9 +509,9 @@ DeviceState *pxa255_dma_init(hwaddr base, qemu_irq irq)
 {
     DeviceState *dev;
 
-    dev = qdev_create(NULL, "pxa2xx-dma");
+    dev = qdev_new("pxa2xx-dma");
     qdev_prop_set_int32(dev, "channels", PXA27X_DMA_NUM_CHANNELS);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index eefbabd758..21c9706bf3 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -28,6 +28,7 @@
 #include "hw/mips/mips.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
+#include "qapi/error.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
@@ -744,8 +745,8 @@ DeviceState *rc4030_init(rc4030_dma **dmas, IOMMUMemoryRegion **dma_mr)
 {
     DeviceState *dev;
 
-    dev = qdev_create(NULL, TYPE_RC4030);
-    qdev_init_nofail(dev);
+    dev = qdev_new(TYPE_RC4030);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     *dmas = rc4030_allocate_dmas(dev, 4);
     *dma_mr = &RC4030(dev)->dma_mr;
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 84b9c5dc77..77cf41e591 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -301,7 +301,7 @@ static void sparc32_espdma_device_realize(DeviceState *dev, Error **errp)
     SysBusESPState *sysbus;
     ESPState *esp;
 
-    d = qdev_create(NULL, TYPE_ESP);
+    d = qdev_new(TYPE_ESP);
     object_property_add_child(OBJECT(dev), "esp", OBJECT(d));
     sysbus = ESP_STATE(d);
     esp = &sysbus->esp;
@@ -310,7 +310,7 @@ static void sparc32_espdma_device_realize(DeviceState *dev, Error **errp)
     esp->dma_opaque = SPARC32_DMA_DEVICE(dev);
     sysbus->it_shift = 2;
     esp->dma_enabled = 1;
-    qdev_init_nofail(d);
+    qdev_realize_and_unref(d, NULL, &error_fatal);
 }
 
 static void sparc32_espdma_device_class_init(ObjectClass *klass, void *data)
@@ -343,11 +343,11 @@ static void sparc32_ledma_device_realize(DeviceState *dev, Error **errp)
 
     qemu_check_nic_model(nd, TYPE_LANCE);
 
-    d = qdev_create(NULL, TYPE_LANCE);
+    d = qdev_new(TYPE_LANCE);
     object_property_add_child(OBJECT(dev), "lance", OBJECT(d));
     qdev_set_nic_properties(d, nd);
     object_property_set_link(OBJECT(d), OBJECT(dev), "dma", errp);
-    qdev_init_nofail(d);
+    qdev_realize_and_unref(d, NULL, &error_fatal);
 }
 
 static void sparc32_ledma_device_class_init(ObjectClass *klass, void *data)
@@ -378,10 +378,10 @@ static void sparc32_dma_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    espdma = qdev_create(NULL, TYPE_SPARC32_ESPDMA_DEVICE);
+    espdma = qdev_new(TYPE_SPARC32_ESPDMA_DEVICE);
     object_property_set_link(OBJECT(espdma), iommu, "iommu", errp);
     object_property_add_child(OBJECT(s), "espdma", OBJECT(espdma));
-    qdev_init_nofail(espdma);
+    qdev_realize_and_unref(espdma, NULL, &error_fatal);
 
     esp = DEVICE(object_resolve_path_component(OBJECT(espdma), "esp"));
     sbd = SYS_BUS_DEVICE(esp);
@@ -393,10 +393,10 @@ static void sparc32_dma_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->dmamem, 0x0,
                                 sysbus_mmio_get_region(sbd, 0));
 
-    ledma = qdev_create(NULL, TYPE_SPARC32_LEDMA_DEVICE);
+    ledma = qdev_new(TYPE_SPARC32_LEDMA_DEVICE);
     object_property_set_link(OBJECT(ledma), iommu, "iommu", errp);
     object_property_add_child(OBJECT(s), "ledma", OBJECT(ledma));
-    qdev_init_nofail(ledma);
+    qdev_realize_and_unref(ledma, NULL, &error_fatal);
 
     lance = DEVICE(object_resolve_path_component(OBJECT(ledma), "lance"));
     sbd = SYS_BUS_DEVICE(lance);
diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index 2b1b38c58a..50ba26737b 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -521,7 +521,7 @@ PCIBus *dino_init(MemoryRegion *addr_space,
     PCIBus *b;
     int i;
 
-    dev = qdev_create(NULL, TYPE_DINO_PCI_HOST_BRIDGE);
+    dev = qdev_new(TYPE_DINO_PCI_HOST_BRIDGE);
     s = DINO_PCI_HOST_BRIDGE(dev);
     s->iar0 = s->iar1 = CPU_HPA + 3;
     s->toc_addr = 0xFFFA0030; /* IO_COMMAND of CPU */
@@ -548,7 +548,7 @@ PCIBus *dino_init(MemoryRegion *addr_space,
                               &s->pci_mem, get_system_io(),
                               PCI_DEVFN(0, 0), 32, TYPE_PCI_BUS);
     s->parent_obj.bus = b;
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     /* Set up windows into PCI bus memory.  */
     for (i = 1; i < 31; i++) {
diff --git a/hw/hppa/lasi.c b/hw/hppa/lasi.c
index d8d03f95c0..4539022c5b 100644
--- a/hw/hppa/lasi.c
+++ b/hw/hppa/lasi.c
@@ -300,7 +300,7 @@ DeviceState *lasi_init(MemoryRegion *address_space)
     DeviceState *dev;
     LasiState *s;
 
-    dev = qdev_create(NULL, TYPE_LASI_CHIP);
+    dev = qdev_new(TYPE_LASI_CHIP);
     s = LASI_CHIP(dev);
     s->iar = CPU_HPA + 3;
 
@@ -309,7 +309,7 @@ DeviceState *lasi_init(MemoryRegion *address_space)
                           s, "lasi", 0x100000);
     memory_region_add_subregion(address_space, LASI_HPA, &s->this_mem);
 
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     /* LAN */
     if (enable_lasi_lan()) {
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 00dd9f58d6..d828b4fb94 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -124,8 +124,8 @@ static void machine_hppa_init(MachineState *machine)
 
     /* Graphics setup. */
     if (machine->enable_graphics && vga_interface_type != VGA_NONE) {
-        dev = qdev_create(NULL, "artist");
-        qdev_init_nofail(dev);
+        dev = qdev_new("artist");
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
         s = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(s, 0, LASI_GFX_HPA);
         sysbus_mmio_map(s, 1, ARTIST_FB_ADDR);
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index d413a192ed..1aac457a2a 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -11,6 +11,7 @@
 #include "hw/i2c/i2c.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
+#include "qapi/error.h"
 #include "qemu/module.h"
 #include "trace.h"
 
@@ -270,9 +271,9 @@ DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
 {
     DeviceState *dev;
 
-    dev = qdev_create(&bus->qbus, name);
+    dev = qdev_new(name);
     qdev_prop_set_uint8(dev, "address", addr);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, &bus->qbus, &error_fatal);
     return dev;
 }
 
diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index e199fc8678..b7def9eeb8 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -169,11 +169,11 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf)
 {
     DeviceState *dev;
 
-    dev = qdev_create((BusState *) smbus, TYPE_SMBUS_EEPROM);
+    dev = qdev_new(TYPE_SMBUS_EEPROM);
     qdev_prop_set_uint8(dev, "address", address);
     /* FIXME: use an array of byte or block backend property? */
     SMBUS_EEPROM(dev)->init_data = eeprom_buf;
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, (BusState *)smbus, &error_fatal);
 }
 
 void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 4ba8ac8774..a2e7faccbc 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -212,7 +212,7 @@ static void pc_q35_init(MachineState *machine)
     }
 
     /* create pci host bus */
-    q35_host = Q35_HOST_DEVICE(qdev_create(NULL, TYPE_Q35_HOST_DEVICE));
+    q35_host = Q35_HOST_DEVICE(qdev_new(TYPE_Q35_HOST_DEVICE));
 
     object_property_add_child(qdev_get_machine(), "q35", OBJECT(q35_host));
     object_property_set_link(OBJECT(q35_host), OBJECT(ram_memory),
@@ -228,7 +228,7 @@ static void pc_q35_init(MachineState *machine)
     object_property_set_int(OBJECT(q35_host), x86ms->above_4g_mem_size,
                             PCI_HOST_ABOVE_4G_MEM_SIZE, NULL);
     /* pci */
-    qdev_init_nofail(DEVICE(q35_host));
+    qdev_realize_and_unref(DEVICE(q35_host), NULL, &error_fatal);
     phb = PCI_HOST_BRIDGE(q35_host);
     host_bus = phb->bus;
     /* create ISA bus */
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 7a3bc7ab66..85ab52b316 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -345,13 +345,13 @@ void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name)
 
     assert(parent_name);
     if (kvm_ioapic_in_kernel()) {
-        dev = qdev_create(NULL, TYPE_KVM_IOAPIC);
+        dev = qdev_new(TYPE_KVM_IOAPIC);
     } else {
-        dev = qdev_create(NULL, TYPE_IOAPIC);
+        dev = qdev_new(TYPE_IOAPIC);
     }
     object_property_add_child(object_resolve_path(parent_name, NULL),
                               "ioapic", OBJECT(dev));
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     d = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(d, 0, IO_APIC_DEFAULT_ADDRESS);
 
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 06b11583f5..caa88526f5 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -127,11 +127,11 @@ IDEDevice *ide_create_drive(IDEBus *bus, int unit, DriveInfo *drive)
 {
     DeviceState *dev;
 
-    dev = qdev_create(&bus->qbus, drive->media_cd ? "ide-cd" : "ide-hd");
+    dev = qdev_new(drive->media_cd ? "ide-cd" : "ide-hd");
     qdev_prop_set_uint32(dev, "unit", unit);
     qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(drive),
                         &error_fatal);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, &bus->qbus, &error_fatal);
     return DO_UPCAST(IDEDevice, qdev, dev);
 }
 
diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
index 82c8f4192c..a261ab2401 100644
--- a/hw/intc/exynos4210_gic.c
+++ b/hw/intc/exynos4210_gic.c
@@ -23,6 +23,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
+#include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
@@ -296,10 +297,10 @@ static void exynos4210_gic_realize(DeviceState *dev, Error **errp)
     uint32_t n = s->num_cpu;
     uint32_t i;
 
-    s->gic = qdev_create(NULL, "arm_gic");
+    s->gic = qdev_new("arm_gic");
     qdev_prop_set_uint32(s->gic, "num-cpu", s->num_cpu);
     qdev_prop_set_uint32(s->gic, "num-irq", EXYNOS4210_GIC_NIRQ);
-    qdev_init_nofail(s->gic);
+    qdev_realize_and_unref(s->gic, NULL, &error_fatal);
     gicbusdev = SYS_BUS_DEVICE(s->gic);
 
     /* Pass through outbound IRQ lines from the GIC */
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index baca4d8a2d..b2a247dd15 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -63,15 +63,15 @@ void s390_flic_init(void)
     DeviceState *dev;
 
     if (kvm_enabled()) {
-        dev = qdev_create(NULL, TYPE_KVM_S390_FLIC);
+        dev = qdev_new(TYPE_KVM_S390_FLIC);
         object_property_add_child(qdev_get_machine(), TYPE_KVM_S390_FLIC,
                                   OBJECT(dev));
     } else {
-        dev = qdev_create(NULL, TYPE_QEMU_S390_FLIC);
+        dev = qdev_new(TYPE_QEMU_S390_FLIC);
         object_property_add_child(qdev_get_machine(), TYPE_QEMU_S390_FLIC,
                                   OBJECT(dev));
     }
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 }
 
 static int qemu_s390_register_io_adapter(S390FLICState *fs, uint32_t id,
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 1f2189f4d5..1c9d7e19ab 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -61,8 +61,8 @@ ISABus *isa_bus_new(DeviceState *dev, MemoryRegion* address_space,
         return NULL;
     }
     if (!dev) {
-        dev = qdev_create(NULL, "isabus-bridge");
-        qdev_init_nofail(dev);
+        dev = qdev_new("isabus-bridge");
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
     }
 
     isabus = ISA_BUS(qbus_create(TYPE_ISA_BUS, dev, NULL));
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 2ab9701ad6..666561d716 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -214,9 +214,9 @@ static void mcf_fec_init(MemoryRegion *sysmem, NICInfo *nd, hwaddr base,
     int i;
 
     qemu_check_nic_model(nd, TYPE_MCF_FEC_NET);
-    dev = qdev_create(NULL, TYPE_MCF_FEC_NET);
+    dev = qdev_new(TYPE_MCF_FEC_NET);
     qdev_set_nic_properties(dev, nd);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     s = SYS_BUS_DEVICE(dev);
     for (i = 0; i < FEC_NUM_IRQ; i++) {
diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index bc20742d9a..75d6e24719 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -7,6 +7,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
 #include "cpu.h"
@@ -204,8 +205,8 @@ qemu_irq *mcf_intc_init(MemoryRegion *sysmem,
     DeviceState  *dev;
     mcf_intc_state *s;
 
-    dev = qdev_create(NULL, TYPE_MCF_INTC);
-    qdev_init_nofail(dev);
+    dev = qdev_new(TYPE_MCF_INTC);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     s = MCF_INTC(dev);
     s->cpu = cpu;
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 14b99ed25d..e1e16bf9af 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -839,7 +839,7 @@ static void next_escc_init(M68kCPU *cpu)
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_create(NULL, TYPE_ESCC);
+    dev = qdev_new(TYPE_ESCC);
     qdev_prop_set_uint32(dev, "disabled", 0);
     qdev_prop_set_uint32(dev, "frequency", 9600 * 384);
     qdev_prop_set_uint32(dev, "it_shift", 0);
@@ -848,7 +848,7 @@ static void next_escc_init(M68kCPU *cpu)
     qdev_prop_set_chr(dev, "chrA", serial_hd(0));
     qdev_prop_set_uint32(dev, "chnBtype", escc_serial);
     qdev_prop_set_uint32(dev, "chnAtype", escc_serial);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     s = SYS_BUS_DEVICE(dev);
     sysbus_connect_irq(s, 0, ser_irq[0]);
@@ -895,8 +895,8 @@ static void next_cube_init(MachineState *machine)
     memory_region_add_subregion(sysmem, 0x04000000, machine->ram);
 
     /* Framebuffer */
-    dev = qdev_create(NULL, TYPE_NEXTFB);
-    qdev_init_nofail(dev);
+    dev = qdev_new(TYPE_NEXTFB);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x0B000000);
 
     /* MMIO */
@@ -918,8 +918,8 @@ static void next_cube_init(MachineState *machine)
     memory_region_add_subregion(sysmem, 0x02100000, scrmem);
 
     /* KBD */
-    dev = qdev_create(NULL, TYPE_NEXTKBD);
-    qdev_init_nofail(dev);
+    dev = qdev_new(TYPE_NEXTKBD);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x0200e000);
 
     /* Load ROM here */
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 81749e7ec6..15b7eb719a 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -218,13 +218,13 @@ static void q800_init(MachineState *machine)
 
     /* VIA */
 
-    via_dev = qdev_create(NULL, TYPE_MAC_VIA);
+    via_dev = qdev_new(TYPE_MAC_VIA);
     dinfo = drive_get(IF_MTD, 0, 0);
     if (dinfo) {
         qdev_prop_set_drive(via_dev, "drive", blk_by_legacy_dinfo(dinfo),
                             &error_abort);
     }
-    qdev_init_nofail(via_dev);
+    qdev_realize_and_unref(via_dev, NULL, &error_fatal);
     sysbus = SYS_BUS_DEVICE(via_dev);
     sysbus_mmio_map(sysbus, 0, VIA_BASE);
     qdev_connect_gpio_out_named(DEVICE(sysbus), "irq", 0, pic[0]);
@@ -232,10 +232,10 @@ static void q800_init(MachineState *machine)
 
 
     adb_bus = qdev_get_child_bus(via_dev, "adb.0");
-    dev = qdev_create(adb_bus, TYPE_ADB_KEYBOARD);
-    qdev_init_nofail(dev);
-    dev = qdev_create(adb_bus, TYPE_ADB_MOUSE);
-    qdev_init_nofail(dev);
+    dev = qdev_new(TYPE_ADB_KEYBOARD);
+    qdev_realize_and_unref(dev, adb_bus, &error_fatal);
+    dev = qdev_new(TYPE_ADB_MOUSE);
+    qdev_realize_and_unref(dev, adb_bus, &error_fatal);
 
     /* MACSONIC */
 
@@ -259,13 +259,13 @@ static void q800_init(MachineState *machine)
     nd_table[0].macaddr.a[1] = 0x00;
     nd_table[0].macaddr.a[2] = 0x07;
 
-    dev = qdev_create(NULL, "dp8393x");
+    dev = qdev_new("dp8393x");
     qdev_set_nic_properties(dev, &nd_table[0]);
     qdev_prop_set_uint8(dev, "it_shift", 2);
     qdev_prop_set_bit(dev, "big_endian", true);
     object_property_set_link(OBJECT(dev), OBJECT(get_system_memory()),
                              "dma_mr", &error_abort);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(sysbus, 0, SONIC_BASE);
     sysbus_mmio_map(sysbus, 1, SONIC_PROM_BASE);
@@ -273,7 +273,7 @@ static void q800_init(MachineState *machine)
 
     /* SCC */
 
-    dev = qdev_create(NULL, TYPE_ESCC);
+    dev = qdev_new(TYPE_ESCC);
     qdev_prop_set_uint32(dev, "disabled", 0);
     qdev_prop_set_uint32(dev, "frequency", MAC_CLOCK);
     qdev_prop_set_uint32(dev, "it_shift", 1);
@@ -282,7 +282,7 @@ static void q800_init(MachineState *machine)
     qdev_prop_set_chr(dev, "chrB", serial_hd(1));
     qdev_prop_set_uint32(dev, "chnBtype", 0);
     qdev_prop_set_uint32(dev, "chnAtype", 0);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus = SYS_BUS_DEVICE(dev);
     sysbus_connect_irq(sysbus, 0, pic[3]);
     sysbus_connect_irq(sysbus, 1, pic[3]);
@@ -290,7 +290,7 @@ static void q800_init(MachineState *machine)
 
     /* SCSI */
 
-    dev = qdev_create(NULL, TYPE_ESP);
+    dev = qdev_new(TYPE_ESP);
     sysbus_esp = ESP_STATE(dev);
     esp = &sysbus_esp->esp;
     esp->dma_memory_read = NULL;
@@ -298,7 +298,7 @@ static void q800_init(MachineState *machine)
     esp->dma_opaque = NULL;
     sysbus_esp->it_shift = 4;
     esp->dma_enabled = 1;
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     sysbus = SYS_BUS_DEVICE(dev);
     sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in_named(via_dev,
@@ -314,14 +314,14 @@ static void q800_init(MachineState *machine)
 
     /* SWIM floppy controller */
 
-    dev = qdev_create(NULL, TYPE_SWIM);
-    qdev_init_nofail(dev);
+    dev = qdev_new(TYPE_SWIM);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, SWIM_BASE);
 
     /* NuBus */
 
-    dev = qdev_create(NULL, TYPE_MAC_NUBUS_BRIDGE);
-    qdev_init_nofail(dev);
+    dev = qdev_new(TYPE_MAC_NUBUS_BRIDGE);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, NUBUS_SUPER_SLOT_BASE);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, NUBUS_SLOT_BASE);
 
@@ -329,11 +329,11 @@ static void q800_init(MachineState *machine)
 
     /* framebuffer in nubus slot #9 */
 
-    dev = qdev_create(BUS(nubus), TYPE_NUBUS_MACFB);
+    dev = qdev_new(TYPE_NUBUS_MACFB);
     qdev_prop_set_uint32(dev, "width", graphic_width);
     qdev_prop_set_uint32(dev, "height", graphic_height);
     qdev_prop_set_uint8(dev, "depth", graphic_depth);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, BUS(nubus), &error_fatal);
 
     cs = CPU(cpu);
     if (linux_boot) {
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 05a5614a04..2e7a3fa119 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -110,9 +110,9 @@ petalogix_ml605_init(MachineState *machine)
                           64 * KiB, 2, 0x89, 0x18, 0x0000, 0x0, 0);
 
 
-    dev = qdev_create(NULL, "xlnx.xps-intc");
+    dev = qdev_new("xlnx.xps-intc");
     qdev_prop_set_uint32(dev, "kind-of-intr", 1 << TIMER_IRQ);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, INTC_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
                        qdev_get_gpio_in(DEVICE(cpu), MB_CPU_IRQ));
@@ -125,17 +125,17 @@ petalogix_ml605_init(MachineState *machine)
                    DEVICE_LITTLE_ENDIAN);
 
     /* 2 timers at irq 2 @ 100 Mhz.  */
-    dev = qdev_create(NULL, "xlnx.xps-timer");
+    dev = qdev_new("xlnx.xps-timer");
     qdev_prop_set_uint32(dev, "one-timer-only", 0);
     qdev_prop_set_uint32(dev, "clock-frequency", 100 * 1000000);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, TIMER_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
 
     /* axi ethernet and dma initialization. */
     qemu_check_nic_model(&nd_table[0], "xlnx.axi-ethernet");
-    eth0 = qdev_create(NULL, "xlnx.axi-ethernet");
-    dma = qdev_create(NULL, "xlnx.axi-dma");
+    eth0 = qdev_new("xlnx.axi-ethernet");
+    dma = qdev_new("xlnx.axi-dma");
 
     /* FIXME: attach to the sysbus instead */
     object_property_add_child(qdev_get_machine(), "xilinx-eth", OBJECT(eth0));
@@ -152,7 +152,7 @@ petalogix_ml605_init(MachineState *machine)
                              "axistream-connected", &error_abort);
     object_property_set_link(OBJECT(eth0), cs,
                              "axistream-control-connected", &error_abort);
-    qdev_init_nofail(eth0);
+    qdev_realize_and_unref(eth0, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(eth0), 0, AXIENET_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(eth0), 0, irq[AXIENET_IRQ]);
 
@@ -165,7 +165,7 @@ petalogix_ml605_init(MachineState *machine)
                              "axistream-connected", &error_abort);
     object_property_set_link(OBJECT(dma), cs,
                              "axistream-control-connected", &error_abort);
-    qdev_init_nofail(dma);
+    qdev_realize_and_unref(dma, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, AXIDMA_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dma), 0, irq[AXIDMA_IRQ0]);
     sysbus_connect_irq(SYS_BUS_DEVICE(dma), 1, irq[AXIDMA_IRQ1]);
@@ -173,9 +173,9 @@ petalogix_ml605_init(MachineState *machine)
     {
         SSIBus *spi;
 
-        dev = qdev_create(NULL, "xlnx.xps-spi");
+        dev = qdev_new("xlnx.xps-spi");
         qdev_prop_set_uint8(dev, "num-ss-bits", NUM_SPI_FLASHES);
-        qdev_init_nofail(dev);
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(busdev, 0, SPI_BASEADDR);
         sysbus_connect_irq(busdev, 0, irq[SPI_IRQ]);
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 0bb6cdea8d..aecee2f5f3 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -89,10 +89,10 @@ petalogix_s3adsp1800_init(MachineState *machine)
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                           64 * KiB, 1, 0x89, 0x18, 0x0000, 0x0, 1);
 
-    dev = qdev_create(NULL, "xlnx.xps-intc");
+    dev = qdev_new("xlnx.xps-intc");
     qdev_prop_set_uint32(dev, "kind-of-intr",
                          1 << ETHLITE_IRQ | 1 << UARTLITE_IRQ);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, INTC_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
                        qdev_get_gpio_in(DEVICE(cpu), MB_CPU_IRQ));
@@ -104,19 +104,19 @@ petalogix_s3adsp1800_init(MachineState *machine)
                            serial_hd(0));
 
     /* 2 timers at irq 2 @ 62 Mhz.  */
-    dev = qdev_create(NULL, "xlnx.xps-timer");
+    dev = qdev_new("xlnx.xps-timer");
     qdev_prop_set_uint32(dev, "one-timer-only", 0);
     qdev_prop_set_uint32(dev, "clock-frequency", 62 * 1000000);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, TIMER_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
 
     qemu_check_nic_model(&nd_table[0], "xlnx.xps-ethernetlite");
-    dev = qdev_create(NULL, "xlnx.xps-ethernetlite");
+    dev = qdev_new("xlnx.xps-ethernetlite");
     qdev_set_nic_properties(dev, &nd_table[0]);
     qdev_prop_set_uint32(dev, "tx-ping-pong", 0);
     qdev_prop_set_uint32(dev, "rx-ping-pong", 0);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ETHLITE_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[ETHLITE_IRQ]);
 
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index a896056be1..a34ccdf616 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -400,7 +400,7 @@ xilinx_pcie_init(MemoryRegion *sys_mem, uint32_t bus_nr,
     DeviceState *dev;
     MemoryRegion *cfg, *mmio;
 
-    dev = qdev_create(NULL, TYPE_XILINX_PCIE_HOST);
+    dev = qdev_new(TYPE_XILINX_PCIE_HOST);
 
     qdev_prop_set_uint32(dev, "bus_nr", bus_nr);
     qdev_prop_set_uint64(dev, "cfg_base", cfg_base);
@@ -409,7 +409,7 @@ xilinx_pcie_init(MemoryRegion *sys_mem, uint32_t bus_nr,
     qdev_prop_set_uint64(dev, "mmio_size", mmio_size);
     qdev_prop_set_bit(dev, "link_up", link_up);
 
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     cfg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
     memory_region_add_subregion_overlap(sys_mem, cfg_base, cfg, 0);
@@ -441,8 +441,8 @@ static void boston_mach_init(MachineState *machine)
         exit(1);
     }
 
-    dev = qdev_create(NULL, TYPE_MIPS_BOSTON);
-    qdev_init_nofail(dev);
+    dev = qdev_new(TYPE_MIPS_BOSTON);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     s = BOSTON(dev);
     s->mach = machine;
diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index b2ea13f09d..37750b8037 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/units.h"
 #include "qemu/log.h"
 #include "hw/mips/mips.h"
@@ -1201,7 +1202,7 @@ PCIBus *gt64120_register(qemu_irq *pic)
     PCIHostState *phb;
     DeviceState *dev;
 
-    dev = qdev_create(NULL, TYPE_GT64120_PCI_HOST_BRIDGE);
+    dev = qdev_new(TYPE_GT64120_PCI_HOST_BRIDGE);
     d = GT64120_PCI_HOST_BRIDGE(dev);
     phb = PCI_HOST_BRIDGE(dev);
     memory_region_init(&d->pci0_mem, OBJECT(dev), "pci0-mem", 4 * GiB);
@@ -1212,7 +1213,7 @@ PCIBus *gt64120_register(qemu_irq *pic)
                                      &d->pci0_mem,
                                      get_system_io(),
                                      PCI_DEVFN(18, 0), 4, TYPE_PCI_BUS);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     memory_region_init_io(&d->ISD_mem, OBJECT(dev), &isd_mem_ops, d,
                           "isd-mem", 0x1000);
 
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index afea52b41b..fb975bd1c7 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -255,8 +255,8 @@ static void mips_jazz_init(MachineState *machine,
     /* Video card */
     switch (jazz_model) {
     case JAZZ_MAGNUM:
-        dev = qdev_create(NULL, "sysbus-g364");
-        qdev_init_nofail(dev);
+        dev = qdev_new("sysbus-g364");
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
         sysbus = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(sysbus, 0, 0x60080000);
         sysbus_mmio_map(sysbus, 1, 0x40000000);
@@ -287,12 +287,12 @@ static void mips_jazz_init(MachineState *machine,
         if (strcmp(nd->model, "dp83932") == 0) {
             qemu_check_nic_model(nd, "dp83932");
 
-            dev = qdev_create(NULL, "dp8393x");
+            dev = qdev_new("dp8393x");
             qdev_set_nic_properties(dev, nd);
             qdev_prop_set_uint8(dev, "it_shift", 2);
             object_property_set_link(OBJECT(dev), OBJECT(rc4030_dma_mr),
                                      "dma_mr", &error_abort);
-            qdev_init_nofail(dev);
+            qdev_realize_and_unref(dev, NULL, &error_fatal);
             sysbus = SYS_BUS_DEVICE(dev);
             sysbus_mmio_map(sysbus, 0, 0x80001000);
             sysbus_mmio_map(sysbus, 1, 0x8000b000);
@@ -308,7 +308,7 @@ static void mips_jazz_init(MachineState *machine,
     }
 
     /* SCSI adapter */
-    dev = qdev_create(NULL, TYPE_ESP);
+    dev = qdev_new(TYPE_ESP);
     sysbus_esp = ESP_STATE(dev);
     esp = &sysbus_esp->esp;
     esp->dma_memory_read = rc4030_dma_read;
@@ -317,7 +317,7 @@ static void mips_jazz_init(MachineState *machine,
     sysbus_esp->it_shift = 0;
     /* XXX for now until rc4030 has been changed to use DMA enable signal */
     esp->dma_enabled = 1;
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     sysbus = SYS_BUS_DEVICE(dev);
     sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(rc4030, 5));
@@ -362,8 +362,8 @@ static void mips_jazz_init(MachineState *machine,
     /* FIXME: missing Jazz sound at 0x8000c000, rc4030[2] */
 
     /* NVRAM */
-    dev = qdev_create(NULL, "ds1225y");
-    qdev_init_nofail(dev);
+    dev = qdev_new("ds1225y");
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(sysbus, 0, 0x80009000);
 
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 636c95d1fe..d03e1c3e49 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1233,7 +1233,7 @@ void mips_malta_init(MachineState *machine)
     int fl_idx = 0;
     int be;
 
-    DeviceState *dev = qdev_create(NULL, TYPE_MIPS_MALTA);
+    DeviceState *dev = qdev_new(TYPE_MIPS_MALTA);
     MaltaState *s = MIPS_MALTA(dev);
 
     /*
@@ -1243,7 +1243,7 @@ void mips_malta_init(MachineState *machine)
      */
     empty_slot_init(0, 0x20000000);
 
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     /* create CPU */
     mips_create_cpu(machine, s, &cbus_irq, &i8259_irq);
diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index d220318939..72b1e846af 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -129,9 +129,9 @@ static void mipsnet_init(int base, qemu_irq irq, NICInfo *nd)
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_create(NULL, "mipsnet");
+    dev = qdev_new("mipsnet");
     qdev_set_nic_properties(dev, nd);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     s = SYS_BUS_DEVICE(dev);
     sysbus_connect_irq(s, 0, irq);
@@ -216,11 +216,11 @@ mips_mipssim_init(MachineState *machine)
      * MIPS CPU INT2, which is interrupt 4.
      */
     if (serial_hd(0)) {
-        DeviceState *dev = qdev_create(NULL, TYPE_SERIAL_IO);
+        DeviceState *dev = qdev_new(TYPE_SERIAL_IO);
 
         qdev_prop_set_chr(dev, "chardev", serial_hd(0));
         qdev_set_legacy_instance_id(dev, 0x3f8, 2);
-        qdev_init_nofail(dev);
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
         sysbus_add_io(SYS_BUS_DEVICE(dev), 0x3f8,
                       sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
diff --git a/hw/net/etraxfs_eth.c b/hw/net/etraxfs_eth.c
index 27fd069b96..7e98cbda87 100644
--- a/hw/net/etraxfs_eth.c
+++ b/hw/net/etraxfs_eth.c
@@ -654,7 +654,7 @@ etraxfs_eth_init(NICInfo *nd, hwaddr base, int phyaddr,
     DeviceState *dev;
     qemu_check_nic_model(nd, "fseth");
 
-    dev = qdev_create(NULL, "etraxfs-eth");
+    dev = qdev_new("etraxfs-eth");
     qdev_set_nic_properties(dev, nd);
     qdev_prop_set_uint32(dev, "phyaddr", phyaddr);
 
@@ -668,7 +668,7 @@ etraxfs_eth_init(NICInfo *nd, hwaddr base, int phyaddr,
      */
     ETRAX_FS_ETH(dev)->dma_out = dma_out;
     ETRAX_FS_ETH(dev)->dma_in = dma_in;
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
 
     return dev;
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index 475f3c887a..d0e9ff57ca 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -33,6 +33,7 @@
 #include "hw/qdev-properties.h"
 #include "etsec.h"
 #include "registers.h"
+#include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 
@@ -452,9 +453,9 @@ DeviceState *etsec_create(hwaddr         base,
 {
     DeviceState *dev;
 
-    dev = qdev_create(NULL, "eTSEC");
+    dev = qdev_new("eTSEC");
     qdev_set_nic_properties(dev, nd);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, tx_irq);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1, rx_irq);
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index da7e0bb0e8..81c32c8107 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -20,6 +20,7 @@
 #include "hw/net/lan9118.h"
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
+#include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 /* For crc32 */
@@ -1394,9 +1395,9 @@ void lan9118_init(NICInfo *nd, uint32_t base, qemu_irq irq)
     SysBusDevice *s;
 
     qemu_check_nic_model(nd, "lan9118");
-    dev = qdev_create(NULL, TYPE_LAN9118);
+    dev = qdev_new(TYPE_LAN9118);
     qdev_set_nic_properties(dev, nd);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(s, 0, base);
     sysbus_connect_irq(s, 0, irq);
diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
index 5e0fd69763..1870507727 100644
--- a/hw/net/lasi_i82596.c
+++ b/hw/net/lasi_i82596.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/timer.h"
 #include "hw/sysbus.h"
 #include "net/eth.h"
@@ -126,11 +127,11 @@ SysBusI82596State *lasi_82596_init(MemoryRegion *addr_space,
         .a = { 0x08, 0x00, 0x09, 0xef, 0x34, 0xf6 } };
 
     qemu_check_nic_model(&nd_table[0], TYPE_LASI_82596);
-    dev = qdev_create(NULL, TYPE_LASI_82596);
+    dev = qdev_new(TYPE_LASI_82596);
     s = SYSBUS_I82596(dev);
     s->state.irq = lan_irq;
     qdev_set_nic_properties(dev, &nd_table[0]);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s->state.conf.macaddr = HP_MAC; /* set HP MAC prefix */
 
     /* LASI 82596 ports in main memory. */
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index b3240b9335..9b616fe62a 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -14,6 +14,7 @@
 #include "hw/irq.h"
 #include "hw/net/smc91c111.h"
 #include "hw/qdev-properties.h"
+#include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 /* For crc32 */
@@ -821,9 +822,9 @@ void smc91c111_init(NICInfo *nd, uint32_t base, qemu_irq irq)
     SysBusDevice *s;
 
     qemu_check_nic_model(nd, "smc91c111");
-    dev = qdev_create(NULL, TYPE_SMC91C111);
+    dev = qdev_new(TYPE_SMC91C111);
     qdev_set_nic_properties(dev, nd);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(s, 0, base);
     sysbus_connect_irq(s, 0, irq);
diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index 968a1ce78e..4cd02dda01 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -372,11 +372,11 @@ void spapr_vlan_create(SpaprVioBus *bus, NICInfo *nd)
 {
     DeviceState *dev;
 
-    dev = qdev_create(&bus->bus, "spapr-vlan");
+    dev = qdev_new("spapr-vlan");
 
     qdev_set_nic_properties(dev, nd);
 
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, &bus->bus, &error_fatal);
 }
 
 static int spapr_vlan_devnode(SpaprVioDevice *dev, void *fdt, int node_off)
diff --git a/hw/nios2/10m50_devboard.c b/hw/nios2/10m50_devboard.c
index 4c60a27fb7..3d304d724a 100644
--- a/hw/nios2/10m50_devboard.c
+++ b/hw/nios2/10m50_devboard.c
@@ -80,9 +80,9 @@ static void nios2_10m50_ghrd_init(MachineState *machine)
     cpu_irq = nios2_cpu_pic_init(cpu);
 
     /* Register: Internal Interrupt Controller (IIC) */
-    dev = qdev_create(NULL, "altera,iic");
+    dev = qdev_new("altera,iic");
     object_property_add_const_link(OBJECT(dev), "cpu", OBJECT(cpu));
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, cpu_irq[0]);
     for (i = 0; i < 32; i++) {
         irq[i] = qdev_get_gpio_in(dev, i);
@@ -93,16 +93,16 @@ static void nios2_10m50_ghrd_init(MachineState *machine)
                    serial_hd(0), DEVICE_NATIVE_ENDIAN);
 
     /* Register: Timer sys_clk_timer  */
-    dev = qdev_create(NULL, "ALTR.timer");
+    dev = qdev_new("ALTR.timer");
     qdev_prop_set_uint32(dev, "clock-frequency", 75 * 1000000);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xf8001440);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[0]);
 
     /* Register: Timer sys_clk_timer_1  */
-    dev = qdev_create(NULL, "ALTR.timer");
+    dev = qdev_new("ALTR.timer");
     qdev_prop_set_uint32(dev, "clock-frequency", 75 * 1000000);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xe0000880);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[5]);
 
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 8dd50c2c72..fbcaf66002 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1099,14 +1099,14 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
     FWCfgState *s;
     bool dma_requested = dma_iobase && dma_as;
 
-    dev = qdev_create(NULL, TYPE_FW_CFG_IO);
+    dev = qdev_new(TYPE_FW_CFG_IO);
     if (!dma_requested) {
         qdev_prop_set_bit(dev, "dma_enabled", false);
     }
 
     object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
                               OBJECT(dev));
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     sbd = SYS_BUS_DEVICE(dev);
     ios = FW_CFG_IO(dev);
@@ -1138,7 +1138,7 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
     FWCfgState *s;
     bool dma_requested = dma_addr && dma_as;
 
-    dev = qdev_create(NULL, TYPE_FW_CFG_MEM);
+    dev = qdev_new(TYPE_FW_CFG_MEM);
     qdev_prop_set_uint32(dev, "data_width", data_width);
     if (!dma_requested) {
         qdev_prop_set_bit(dev, "dma_enabled", false);
@@ -1146,7 +1146,7 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
 
     object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
                               OBJECT(dev));
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     sbd = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(sbd, 0, ctl_addr);
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 02f5259e5e..ba1a11442f 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -59,9 +59,9 @@ static void openrisc_sim_net_init(hwaddr base, hwaddr descriptors,
     SysBusDevice *s;
     int i;
 
-    dev = qdev_create(NULL, "open_eth");
+    dev = qdev_new("open_eth");
     qdev_set_nic_properties(dev, nd);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     s = SYS_BUS_DEVICE(dev);
     for (i = 0; i < num_cpus; i++) {
@@ -78,9 +78,9 @@ static void openrisc_sim_ompic_init(hwaddr base, int num_cpus,
     SysBusDevice *s;
     int i;
 
-    dev = qdev_create(NULL, "or1k-ompic");
+    dev = qdev_new("or1k-ompic");
     qdev_prop_set_uint32(dev, "num-cpus", num_cpus);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     s = SYS_BUS_DEVICE(dev);
     for (i = 0; i < num_cpus; i++) {
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 47aaaf8fd1..5da0d21061 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -231,7 +231,7 @@ static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error **errp)
         dev_name = dev->qdev.id;
     }
 
-    ds = qdev_create(NULL, TYPE_PXB_HOST);
+    ds = qdev_new(TYPE_PXB_HOST);
     if (pcie) {
         bus = pci_root_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PXB_PCIE_BUS);
     } else {
@@ -255,7 +255,7 @@ static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error **errp)
         goto err_register_bus;
     }
 
-    qdev_init_nofail(ds);
+    qdev_realize_and_unref(ds, NULL, &error_fatal);
     if (bds) {
         qdev_init_nofail(bds);
     }
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index f9697dcc43..546ac84cf4 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -40,6 +40,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/pci/pci.h"
 #include "hw/irq.h"
@@ -743,11 +744,11 @@ PCIBus *bonito_init(qemu_irq *pic)
     PCIBonitoState *s;
     PCIDevice *d;
 
-    dev = qdev_create(NULL, TYPE_BONITO_PCI_HOST_BRIDGE);
+    dev = qdev_new(TYPE_BONITO_PCI_HOST_BRIDGE);
     phb = PCI_HOST_BRIDGE(dev);
     pcihost = BONITO_PCI_HOST_BRIDGE(dev);
     pcihost->pic = pic;
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     d = pci_create(phb->bus, PCI_DEVFN(0, 0), TYPE_PCI_BONITO);
     s = PCI_BONITO(d);
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 0adbd77553..873d334637 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -270,13 +270,13 @@ PCIBus *i440fx_init(const char *host_type, const char *pci_type,
     unsigned i;
     I440FXState *i440fx;
 
-    dev = qdev_create(NULL, host_type);
+    dev = qdev_new(host_type);
     s = PCI_HOST_BRIDGE(dev);
     b = pci_root_bus_new(dev, NULL, pci_address_space,
                          address_space_io, 0, TYPE_PCI_BUS);
     s->bus = b;
     object_property_add_child(qdev_get_machine(), "i440fx", OBJECT(dev));
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     d = pci_create_simple(b, 0, pci_type);
     *pi440fx_state = I440FX_PCI_DEVICE(d);
diff --git a/hw/pcmcia/pxa2xx.c b/hw/pcmcia/pxa2xx.c
index 8667244df4..90f540209d 100644
--- a/hw/pcmcia/pxa2xx.c
+++ b/hw/pcmcia/pxa2xx.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/pcmcia.h"
 #include "hw/arm/pxa.h"
@@ -147,11 +148,11 @@ PXA2xxPCMCIAState *pxa2xx_pcmcia_init(MemoryRegion *sysmem,
     DeviceState *dev;
     PXA2xxPCMCIAState *s;
 
-    dev = qdev_create(NULL, TYPE_PXA2XX_PCMCIA);
+    dev = qdev_new(TYPE_PXA2XX_PCMCIA);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     s = PXA2XX_PCMCIA(dev);
 
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     return s;
 }
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 2a0b66a152..06f4a38266 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -743,12 +743,12 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE500MachineState *pms,
     unsigned int smp_cpus = machine->smp.cpus;
     const PPCE500MachineClass *pmc = PPCE500_MACHINE_GET_CLASS(pms);
 
-    dev = qdev_create(NULL, TYPE_OPENPIC);
+    dev = qdev_new(TYPE_OPENPIC);
     object_property_add_child(OBJECT(machine), "pic", OBJECT(dev));
     qdev_prop_set_uint32(dev, "model", pmc->mpic_version);
     qdev_prop_set_uint32(dev, "nb_cpus", smp_cpus);
 
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
 
     k = 0;
@@ -768,10 +768,10 @@ static DeviceState *ppce500_init_mpic_kvm(const PPCE500MachineClass *pmc,
     DeviceState *dev;
     CPUState *cs;
 
-    dev = qdev_create(NULL, TYPE_KVM_OPENPIC);
+    dev = qdev_new(TYPE_KVM_OPENPIC);
     qdev_prop_set_uint32(dev, "model", pmc->mpic_version);
 
-    object_property_set_bool(OBJECT(dev), true, "realized", &err);
+    qdev_realize_and_unref(dev, NULL, &err);
     if (err) {
         error_propagate(errp, err);
         object_unparent(OBJECT(dev));
@@ -913,10 +913,10 @@ void ppce500_init(MachineState *machine)
     /* Register Memory */
     memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
-    dev = qdev_create(NULL, "e500-ccsr");
+    dev = qdev_new("e500-ccsr");
     object_property_add_child(qdev_get_machine(), "e500-ccsr",
                               OBJECT(dev));
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     ccsr = CCSR(dev);
     ccsr_addr_space = &ccsr->ccsr_space;
     memory_region_add_subregion(address_space_mem, pmc->ccsrbar_base,
@@ -937,9 +937,9 @@ void ppce500_init(MachineState *machine)
                        serial_hd(1), DEVICE_BIG_ENDIAN);
     }
         /* I2C */
-    dev = qdev_create(NULL, "mpc-i2c");
+    dev = qdev_new("mpc-i2c");
     s = SYS_BUS_DEVICE(dev);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, MPC8544_I2C_IRQ));
     memory_region_add_subregion(ccsr_addr_space, MPC8544_I2C_REGS_OFFSET,
                                 sysbus_mmio_get_region(s, 0));
@@ -948,18 +948,18 @@ void ppce500_init(MachineState *machine)
 
 
     /* General Utility device */
-    dev = qdev_create(NULL, "mpc8544-guts");
-    qdev_init_nofail(dev);
+    dev = qdev_new("mpc8544-guts");
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
     memory_region_add_subregion(ccsr_addr_space, MPC8544_UTIL_OFFSET,
                                 sysbus_mmio_get_region(s, 0));
 
     /* PCI */
-    dev = qdev_create(NULL, "e500-pcihost");
+    dev = qdev_new("e500-pcihost");
     object_property_add_child(qdev_get_machine(), "pci-host", OBJECT(dev));
     qdev_prop_set_uint32(dev, "first_slot", pmc->pci_first_slot);
     qdev_prop_set_uint32(dev, "first_pin_irq", pci_irq_nrs[0]);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
     for (i = 0; i < PCI_NUM_PINS; i++) {
         sysbus_connect_irq(s, i, qdev_get_gpio_in(mpicdev, pci_irq_nrs[i]));
@@ -985,9 +985,9 @@ void ppce500_init(MachineState *machine)
     if (pmc->has_mpc8xxx_gpio) {
         qemu_irq poweroff_irq;
 
-        dev = qdev_create(NULL, "mpc8xxx_gpio");
+        dev = qdev_new("mpc8xxx_gpio");
         s = SYS_BUS_DEVICE(dev);
-        qdev_init_nofail(dev);
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
         sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, MPC8XXX_GPIO_IRQ));
         memory_region_add_subregion(ccsr_addr_space, MPC8XXX_GPIO_OFFSET,
                                     sysbus_mmio_get_region(s, 0));
@@ -999,11 +999,11 @@ void ppce500_init(MachineState *machine)
 
     /* Platform Bus Device */
     if (pmc->has_platform_bus) {
-        dev = qdev_create(NULL, TYPE_PLATFORM_BUS_DEVICE);
+        dev = qdev_new(TYPE_PLATFORM_BUS_DEVICE);
         dev->id = TYPE_PLATFORM_BUS_DEVICE;
         qdev_prop_set_uint32(dev, "num_irqs", pmc->platform_bus_num_irqs);
         qdev_prop_set_uint32(dev, "mmio_size", pmc->platform_bus_size);
-        qdev_init_nofail(dev);
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
         pms->pbus_dev = PLATFORM_BUS_DEVICE(dev);
 
         s = SYS_BUS_DEVICE(pms->pbus_dev);
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 3507f26f6e..69281d7834 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -242,8 +242,8 @@ static void ppc_core99_init(MachineState *machine)
     }
 
     /* UniN init */
-    dev = qdev_create(NULL, TYPE_UNI_NORTH);
-    qdev_init_nofail(dev);
+    dev = qdev_new(TYPE_UNI_NORTH);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
     memory_region_add_subregion(get_system_memory(), 0xf8000000,
                                 sysbus_mmio_get_region(s, 0));
@@ -288,9 +288,9 @@ static void ppc_core99_init(MachineState *machine)
         }
     }
 
-    pic_dev = qdev_create(NULL, TYPE_OPENPIC);
+    pic_dev = qdev_new(TYPE_OPENPIC);
     qdev_prop_set_uint32(pic_dev, "model", OPENPIC_MODEL_KEYLARGO);
-    qdev_init_nofail(pic_dev);
+    qdev_realize_and_unref(pic_dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(pic_dev);
     k = 0;
     for (i = 0; i < smp_cpus; i++) {
@@ -303,10 +303,10 @@ static void ppc_core99_init(MachineState *machine)
     if (PPC_INPUT(env) == PPC_FLAGS_INPUT_970) {
         /* 970 gets a U3 bus */
         /* Uninorth AGP bus */
-        dev = qdev_create(NULL, TYPE_U3_AGP_HOST_BRIDGE);
+        dev = qdev_new(TYPE_U3_AGP_HOST_BRIDGE);
         object_property_set_link(OBJECT(dev), OBJECT(pic_dev), "pic",
                                  &error_abort);
-        qdev_init_nofail(dev);
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
         uninorth_pci = U3_AGP_HOST_BRIDGE(dev);
         s = SYS_BUS_DEVICE(dev);
         /* PCI hole */
@@ -322,29 +322,29 @@ static void ppc_core99_init(MachineState *machine)
     } else {
         /* Use values found on a real PowerMac */
         /* Uninorth AGP bus */
-        dev = qdev_create(NULL, TYPE_UNI_NORTH_AGP_HOST_BRIDGE);
+        dev = qdev_new(TYPE_UNI_NORTH_AGP_HOST_BRIDGE);
         object_property_set_link(OBJECT(dev), OBJECT(pic_dev), "pic",
                                  &error_abort);
-        qdev_init_nofail(dev);
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
         s = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(s, 0, 0xf0800000);
         sysbus_mmio_map(s, 1, 0xf0c00000);
 
         /* Uninorth internal bus */
-        dev = qdev_create(NULL, TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE);
+        dev = qdev_new(TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE);
         object_property_set_link(OBJECT(dev), OBJECT(pic_dev), "pic",
                                  &error_abort);
-        qdev_init_nofail(dev);
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
         s = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(s, 0, 0xf4800000);
         sysbus_mmio_map(s, 1, 0xf4c00000);
 
         /* Uninorth main bus */
-        dev = qdev_create(NULL, TYPE_UNI_NORTH_PCI_HOST_BRIDGE);
+        dev = qdev_new(TYPE_UNI_NORTH_PCI_HOST_BRIDGE);
         qdev_prop_set_uint32(dev, "ofw-addr", 0xf2000000);
         object_property_set_link(OBJECT(dev), OBJECT(pic_dev), "pic",
                                  &error_abort);
-        qdev_init_nofail(dev);
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
         uninorth_pci = UNI_NORTH_PCI_HOST_BRIDGE(dev);
         s = SYS_BUS_DEVICE(dev);
         /* PCI hole */
@@ -403,13 +403,13 @@ static void ppc_core99_init(MachineState *machine)
         }
 
         adb_bus = qdev_get_child_bus(dev, "adb.0");
-        dev = qdev_create(adb_bus, TYPE_ADB_KEYBOARD);
+        dev = qdev_new(TYPE_ADB_KEYBOARD);
         qdev_prop_set_bit(dev, "disable-direct-reg3-writes", true);
-        qdev_init_nofail(dev);
+        qdev_realize_and_unref(dev, adb_bus, &error_fatal);
 
-        dev = qdev_create(adb_bus, TYPE_ADB_MOUSE);
+        dev = qdev_new(TYPE_ADB_MOUSE);
         qdev_prop_set_bit(dev, "disable-direct-reg3-writes", true);
-        qdev_init_nofail(dev);
+        qdev_realize_and_unref(dev, adb_bus, &error_fatal);
     }
 
     if (machine->usb) {
@@ -441,22 +441,22 @@ static void ppc_core99_init(MachineState *machine)
            move the NVRAM out of ROM again for KVM */
         nvram_addr = 0xFFE00000;
     }
-    dev = qdev_create(NULL, TYPE_MACIO_NVRAM);
+    dev = qdev_new(TYPE_MACIO_NVRAM);
     qdev_prop_set_uint32(dev, "size", 0x2000);
     qdev_prop_set_uint32(dev, "it_shift", 1);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, nvram_addr);
     nvr = MACIO_NVRAM(dev);
     pmac_format_nvram_partition(nvr, 0x2000);
     /* No PCI init: the BIOS will do it */
 
-    dev = qdev_create(NULL, TYPE_FW_CFG_MEM);
+    dev = qdev_new(TYPE_FW_CFG_MEM);
     fw_cfg = FW_CFG(dev);
     qdev_prop_set_uint32(dev, "data_width", 1);
     qdev_prop_set_bit(dev, "dma_enabled", false);
     object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
                               OBJECT(fw_cfg));
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(s, 0, CFG_ADDR);
     sysbus_mmio_map(s, 1, CFG_ADDR + 2);
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 0b4c1c6373..cfc2eae1d9 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -222,8 +222,8 @@ static void ppc_heathrow_init(MachineState *machine)
     }
 
     /* XXX: we register only 1 output pin for heathrow PIC */
-    pic_dev = qdev_create(NULL, TYPE_HEATHROW);
-    qdev_init_nofail(pic_dev);
+    pic_dev = qdev_new(TYPE_HEATHROW);
+    qdev_realize_and_unref(pic_dev, NULL, &error_fatal);
 
     /* Connect the heathrow PIC outputs to the 6xx bus */
     for (i = 0; i < smp_cpus; i++) {
@@ -252,11 +252,11 @@ static void ppc_heathrow_init(MachineState *machine)
     }
 
     /* Grackle PCI host bridge */
-    dev = qdev_create(NULL, TYPE_GRACKLE_PCI_HOST_BRIDGE);
+    dev = qdev_new(TYPE_GRACKLE_PCI_HOST_BRIDGE);
     qdev_prop_set_uint32(dev, "ofw-addr", 0x80000000);
     object_property_set_link(OBJECT(dev), OBJECT(pic_dev), "pic",
                              &error_abort);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(s, 0, GRACKLE_BASE);
     sysbus_mmio_map(s, 1, GRACKLE_BASE + 0x200000);
@@ -295,10 +295,10 @@ static void ppc_heathrow_init(MachineState *machine)
 
     dev = DEVICE(object_resolve_path_component(OBJECT(macio), "cuda"));
     adb_bus = qdev_get_child_bus(dev, "adb.0");
-    dev = qdev_create(adb_bus, TYPE_ADB_KEYBOARD);
-    qdev_init_nofail(dev);
-    dev = qdev_create(adb_bus, TYPE_ADB_MOUSE);
-    qdev_init_nofail(dev);
+    dev = qdev_new(TYPE_ADB_KEYBOARD);
+    qdev_realize_and_unref(dev, adb_bus, &error_fatal);
+    dev = qdev_new(TYPE_ADB_MOUSE);
+    qdev_realize_and_unref(dev, adb_bus, &error_fatal);
 
     if (machine_usb(machine)) {
         pci_create_simple(pci_bus, -1, "pci-ohci");
@@ -309,13 +309,13 @@ static void ppc_heathrow_init(MachineState *machine)
 
     /* No PCI init: the BIOS will do it */
 
-    dev = qdev_create(NULL, TYPE_FW_CFG_MEM);
+    dev = qdev_new(TYPE_FW_CFG_MEM);
     fw_cfg = FW_CFG(dev);
     qdev_prop_set_uint32(dev, "data_width", 1);
     qdev_prop_set_bit(dev, "dma_enabled", false);
     object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
                               OBJECT(fw_cfg));
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(s, 0, CFG_ADDR);
     sysbus_mmio_map(s, 1, CFG_ADDR + 2);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 9d1a11adb7..e3b6f0b884 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -729,12 +729,12 @@ static void pnv_init(MachineState *machine)
     /*
      * Create our simple PNOR device
      */
-    dev = qdev_create(NULL, TYPE_PNV_PNOR);
+    dev = qdev_new(TYPE_PNV_PNOR);
     if (pnor) {
         qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(pnor),
                             &error_abort);
     }
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     pnv->pnor = PNV_PNOR(dev);
 
     /* load skiboot firmware  */
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index dc318c7aa7..c1cf8d0f46 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -1367,13 +1367,13 @@ void ppc460ex_pcie_init(CPUPPCState *env)
 {
     DeviceState *dev;
 
-    dev = qdev_create(NULL, TYPE_PPC460EX_PCIE_HOST);
+    dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
     qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE0_BASE);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     ppc460ex_pcie_register_dcrs(PPC460EX_PCIE_HOST(dev), env);
 
-    dev = qdev_create(NULL, TYPE_PPC460EX_PCIE_HOST);
+    dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
     qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE1_BASE);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     ppc460ex_pcie_register_dcrs(PPC460EX_PCIE_HOST(dev), env);
 }
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 9266453dd9..c7af0e16c3 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -35,6 +35,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/ppc/ppc.h"
 #include "hw/boards.h"
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "hw/irq.h"
@@ -268,7 +269,7 @@ static void ibm_40p_init(MachineState *machine)
     qemu_register_reset(ppc_prep_reset, cpu);
 
     /* PCI host */
-    dev = qdev_create(NULL, "raven-pcihost");
+    dev = qdev_new("raven-pcihost");
     if (!bios_name) {
         bios_name = "openbios-ppc";
     }
@@ -276,7 +277,7 @@ static void ibm_40p_init(MachineState *machine)
     qdev_prop_set_uint32(dev, "elf-machine", PPC_ELF_MACHINE);
     pcihost = SYS_BUS_DEVICE(dev);
     object_property_add_child(qdev_get_machine(), "raven", OBJECT(dev));
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
     if (!pci_bus) {
         error_report("could not create PCI host controller");
@@ -338,13 +339,13 @@ static void ibm_40p_init(MachineState *machine)
     }
 
     /* Prepare firmware configuration for OpenBIOS */
-    dev = qdev_create(NULL, TYPE_FW_CFG_MEM);
+    dev = qdev_new(TYPE_FW_CFG_MEM);
     fw_cfg = FW_CFG(dev);
     qdev_prop_set_uint32(dev, "data_width", 1);
     qdev_prop_set_bit(dev, "dma_enabled", false);
     object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
                               OBJECT(fw_cfg));
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(s, 0, CFG_ADDR);
     sysbus_mmio_map(s, 1, CFG_ADDR + 2);
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 42a8c9fb7f..503bd21728 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -370,10 +370,10 @@ static void sam460ex_init(MachineState *machine)
 
     /* USB */
     sysbus_create_simple(TYPE_PPC4xx_EHCI, 0x4bffd0400, uic[2][29]);
-    dev = qdev_create(NULL, "sysbus-ohci");
+    dev = qdev_new("sysbus-ohci");
     qdev_prop_set_string(dev, "masterbus", "usb-bus.0");
     qdev_prop_set_uint32(dev, "num-ports", 6);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sbdev = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(sbdev, 0, 0x4bffd0000);
     sysbus_connect_irq(sbdev, 0, uic[2][30]);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6a315c0dc8..1228aeb4b0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1712,7 +1712,7 @@ static void spapr_machine_reset(MachineState *machine)
 
 static void spapr_create_nvram(SpaprMachineState *spapr)
 {
-    DeviceState *dev = qdev_create(&spapr->vio_bus->bus, "spapr-nvram");
+    DeviceState *dev = qdev_new("spapr-nvram");
     DriveInfo *dinfo = drive_get(IF_PFLASH, 0, 0);
 
     if (dinfo) {
@@ -1720,7 +1720,7 @@ static void spapr_create_nvram(SpaprMachineState *spapr)
                             &error_fatal);
     }
 
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, &spapr->vio_bus->bus, &error_fatal);
 
     spapr->nvram = (struct SpaprNvram *)dev;
 }
@@ -2640,9 +2640,9 @@ static PCIHostState *spapr_create_default_phb(void)
 {
     DeviceState *dev;
 
-    dev = qdev_create(NULL, TYPE_SPAPR_PCI_HOST_BRIDGE);
+    dev = qdev_new(TYPE_SPAPR_PCI_HOST_BRIDGE);
     qdev_prop_set_uint32(dev, "index", 0);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     return PCI_HOST_BRIDGE(dev);
 }
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 0c594aa72e..f2ade64e7d 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -325,7 +325,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
         DeviceState *dev;
         int i;
 
-        dev = qdev_create(NULL, TYPE_SPAPR_XIVE);
+        dev = qdev_new(TYPE_SPAPR_XIVE);
         qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + SPAPR_XIRQ_BASE);
         /*
          * 8 XIVE END structures per CPU. One for each available
@@ -334,7 +334,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
         qdev_prop_set_uint32(dev, "nr-ends", nr_servers << 3);
         object_property_set_link(OBJECT(dev), OBJECT(spapr), "xive-fabric",
                                  &error_abort);
-        qdev_init_nofail(dev);
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
 
         spapr->xive = SPAPR_XIVE(dev);
 
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 0b085eabe4..61558db1bf 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -576,8 +576,8 @@ SpaprVioBus *spapr_vio_bus_init(void)
     DeviceState *dev;
 
     /* Create bridge device */
-    dev = qdev_create(NULL, TYPE_SPAPR_VIO_BRIDGE);
-    qdev_init_nofail(dev);
+    dev = qdev_new(TYPE_SPAPR_VIO_BRIDGE);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     /* Create bus on bridge device */
     qbus = qbus_create(TYPE_SPAPR_VIO_BUS, dev, "spapr-vio");
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 0dacfcd236..f28a69c0f9 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -36,6 +36,7 @@
 #include "sysemu/device_tree.h"
 #include "hw/loader.h"
 #include "elf.h"
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/option.h"
@@ -228,9 +229,9 @@ static void virtex_init(MachineState *machine)
                           64 * KiB, 1, 0x89, 0x18, 0x0000, 0x0, 1);
 
     cpu_irq = (qemu_irq *) &env->irq_inputs[PPC40x_INPUT_INT];
-    dev = qdev_create(NULL, "xlnx.xps-intc");
+    dev = qdev_new("xlnx.xps-intc");
     qdev_prop_set_uint32(dev, "kind-of-intr", 0);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, INTC_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, cpu_irq[0]);
     for (i = 0; i < 32; i++) {
@@ -241,10 +242,10 @@ static void virtex_init(MachineState *machine)
                    115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
     /* 2 timers at irq 2 @ 62 Mhz.  */
-    dev = qdev_create(NULL, "xlnx.xps-timer");
+    dev = qdev_new("xlnx.xps-timer");
     qdev_prop_set_uint32(dev, "one-timer-only", 0);
     qdev_prop_set_uint32(dev, "clock-frequency", 62 * 1000000);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, TIMER_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
 
diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
index e933d35092..729fce0a58 100644
--- a/hw/riscv/sifive_clint.c
+++ b/hw/riscv/sifive_clint.c
@@ -20,6 +20,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/sysbus.h"
@@ -245,13 +246,13 @@ DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
         env->timecmp = 0;
     }
 
-    DeviceState *dev = qdev_create(NULL, TYPE_SIFIVE_CLINT);
+    DeviceState *dev = qdev_new(TYPE_SIFIVE_CLINT);
     qdev_prop_set_uint32(dev, "num-harts", num_harts);
     qdev_prop_set_uint32(dev, "sip-base", sip_base);
     qdev_prop_set_uint32(dev, "timecmp-base", timecmp_base);
     qdev_prop_set_uint32(dev, "time-base", time_base);
     qdev_prop_set_uint32(dev, "aperture-size", size);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
     return dev;
 }
diff --git a/hw/riscv/sifive_e_prci.c b/hw/riscv/sifive_e_prci.c
index a1c0d44f18..423af22ecc 100644
--- a/hw/riscv/sifive_e_prci.c
+++ b/hw/riscv/sifive_e_prci.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/hw.h"
@@ -117,8 +118,8 @@ type_init(sifive_e_prci_register_types)
  */
 DeviceState *sifive_e_prci_create(hwaddr addr)
 {
-    DeviceState *dev = qdev_create(NULL, TYPE_SIFIVE_E_PRCI);
-    qdev_init_nofail(dev);
+    DeviceState *dev = qdev_new(TYPE_SIFIVE_E_PRCI);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
     return dev;
 }
diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index c1e04cbb98..203fec8e48 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
@@ -494,7 +495,7 @@ DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
     uint32_t context_base, uint32_t context_stride,
     uint32_t aperture_size)
 {
-    DeviceState *dev = qdev_create(NULL, TYPE_SIFIVE_PLIC);
+    DeviceState *dev = qdev_new(TYPE_SIFIVE_PLIC);
     assert(enable_stride == (enable_stride & -enable_stride));
     assert(context_stride == (context_stride & -context_stride));
     qdev_prop_set_string(dev, "hart-config", hart_config);
@@ -507,7 +508,7 @@ DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
     qdev_prop_set_uint32(dev, "context-base", context_base);
     qdev_prop_set_uint32(dev, "context-stride", context_stride);
     qdev_prop_set_uint32(dev, "aperture-size", aperture_size);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
     return dev;
 }
diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
index 339195c6ff..596757f714 100644
--- a/hw/riscv/sifive_test.c
+++ b/hw/riscv/sifive_test.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "sysemu/runstate.h"
@@ -92,8 +93,8 @@ type_init(sifive_test_register_types)
  */
 DeviceState *sifive_test_create(hwaddr addr)
 {
-    DeviceState *dev = qdev_create(NULL, TYPE_SIFIVE_TEST);
-    qdev_init_nofail(dev);
+    DeviceState *dev = qdev_new(TYPE_SIFIVE_TEST);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
     return dev;
 }
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d569b38d1b..fa88e9118c 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -443,9 +443,9 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
     qemu_irq irq;
     int i;
 
-    dev = qdev_create(NULL, TYPE_GPEX_HOST);
+    dev = qdev_new(TYPE_GPEX_HOST);
 
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     ecam_alias = g_new0(MemoryRegion, 1);
     ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index 47d48054fd..f6acf416ff 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -33,6 +33,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
 #include "exec/address-spaces.h"
+#include "qapi/error.h"
 #include "qemu/bcd.h"
 #include "qemu/module.h"
 #include "trace.h"
@@ -579,9 +580,9 @@ Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
             continue;
         }
 
-        dev = qdev_create(NULL, m48txx_sysbus_info[i].bus_name);
+        dev = qdev_new(m48txx_sysbus_info[i].bus_name);
         qdev_prop_set_int32(dev, "base-year", base_year);
-        qdev_init_nofail(dev);
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
         s = SYS_BUS_DEVICE(dev);
         sysbus_connect_irq(s, 0, IRQ);
         if (io_base != 0) {
diff --git a/hw/rtc/sun4v-rtc.c b/hw/rtc/sun4v-rtc.c
index ada01b5774..ed1c10832f 100644
--- a/hw/rtc/sun4v-rtc.c
+++ b/hw/rtc/sun4v-rtc.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/rtc/sun4v-rtc.h"
@@ -55,10 +56,10 @@ void sun4v_rtc_init(hwaddr addr)
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_create(NULL, TYPE_SUN4V_RTC);
+    dev = qdev_new(TYPE_SUN4V_RTC);
     s = SYS_BUS_DEVICE(dev);
 
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     sysbus_mmio_map(s, 0, addr);
 }
diff --git a/hw/s390x/ap-bridge.c b/hw/s390x/ap-bridge.c
index d0dbd0f1b6..974c97f454 100644
--- a/hw/s390x/ap-bridge.c
+++ b/hw/s390x/ap-bridge.c
@@ -49,10 +49,10 @@ void s390_init_ap(void)
     }
 
     /* Create bridge device */
-    dev = qdev_create(NULL, TYPE_AP_BRIDGE);
+    dev = qdev_new(TYPE_AP_BRIDGE);
     object_property_add_child(qdev_get_machine(), TYPE_AP_BRIDGE,
                               OBJECT(dev));
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     /* Create bus on bridge device */
     bus = qbus_create(TYPE_AP_BUS, dev, TYPE_AP_BUS);
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index 813bfc768a..a0dd2da0b8 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -101,10 +101,10 @@ VirtualCssBus *virtual_css_bus_init(void)
     DeviceState *dev;
 
     /* Create bridge device */
-    dev = qdev_create(NULL, TYPE_VIRTUAL_CSS_BRIDGE);
+    dev = qdev_new(TYPE_VIRTUAL_CSS_BRIDGE);
     object_property_add_child(qdev_get_machine(), TYPE_VIRTUAL_CSS_BRIDGE,
                               OBJECT(dev));
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     /* Create bus on bridge device */
     bus = qbus_create(TYPE_VIRTUAL_CSS_BUS, dev, "virtual-css");
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 60b16fef77..fb68c5a437 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -227,9 +227,9 @@ static void s390_create_virtio_net(BusState *bus, const char *name)
 
         qemu_check_nic_model(nd, "virtio");
 
-        dev = qdev_create(bus, name);
+        dev = qdev_new(name);
         qdev_set_nic_properties(dev, nd);
-        qdev_init_nofail(dev);
+        qdev_realize_and_unref(dev, bus, &error_fatal);
     }
 }
 
@@ -237,9 +237,9 @@ static void s390_create_sclpconsole(const char *type, Chardev *chardev)
 {
     DeviceState *dev;
 
-    dev = qdev_create(sclp_get_event_facility_bus(), type);
+    dev = qdev_new(type);
     qdev_prop_set_chr(dev, "chardev", chardev);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, sclp_get_event_facility_bus(), &error_fatal);
 }
 
 static void ccw_init(MachineState *machine)
@@ -269,10 +269,10 @@ static void ccw_init(MachineState *machine)
                       machine->initrd_filename, "s390-ccw.img",
                       "s390-netboot.img", true);
 
-    dev = qdev_create(NULL, TYPE_S390_PCI_HOST_BRIDGE);
+    dev = qdev_new(TYPE_S390_PCI_HOST_BRIDGE);
     object_property_add_child(qdev_get_machine(), TYPE_S390_PCI_HOST_BRIDGE,
                               OBJECT(dev));
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     /* register hypercalls */
     virtio_ccw_register_hcalls();
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 2836f807a0..1a7320c0af 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -261,7 +261,7 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
             driver = "scsi-hd";
         }
     }
-    dev = qdev_create(&bus->qbus, driver);
+    dev = qdev_new(driver);
     name = g_strdup_printf("legacy[%d]", unit);
     object_property_add_child(OBJECT(bus), name, OBJECT(dev));
     g_free(name);
@@ -293,7 +293,7 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
     qdev_prop_set_enum(dev, "rerror", rerror);
     qdev_prop_set_enum(dev, "werror", werror);
 
-    object_property_set_bool(OBJECT(dev), true, "realized", &err);
+    qdev_realize_and_unref(dev, &bus->qbus, &err);
     if (err != NULL) {
         error_propagate(errp, err);
         object_unparent(OBJECT(dev));
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 923488beb2..d17dc03c73 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -1225,9 +1225,9 @@ void spapr_vscsi_create(SpaprVioBus *bus)
 {
     DeviceState *dev;
 
-    dev = qdev_create(&bus->bus, "spapr-vscsi");
+    dev = qdev_new("spapr-vscsi");
 
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, &bus->bus, &error_fatal);
     scsi_bus_legacy_handle_cmdline(&VIO_SPAPR_VSCSI_DEVICE(dev)->bus);
 }
 
diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 926e1af475..4cfdf7b64c 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -278,9 +278,9 @@ static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
     /* FIXME use a qdev drive property instead of drive_get_next() */
     dinfo = drive_get_next(IF_SD);
     blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
-    carddev = qdev_create(BUS(&s->sdbus), TYPE_SD_CARD);
+    carddev = qdev_new(TYPE_SD_CARD);
     qdev_prop_set_drive(carddev, "drive", blk, &err);
-    object_property_set_bool(OBJECT(carddev), true, "realized", &err);
+    qdev_realize_and_unref(carddev, BUS(&s->sdbus), &err);
     if (err) {
         error_setg(errp, "failed to init SD card: %s", error_get_pretty(err));
         return;
diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index c32df1b8f9..89784407b9 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -485,23 +485,23 @@ PXA2xxMMCIState *pxa2xx_mmci_init(MemoryRegion *sysmem,
     PXA2xxMMCIState *s;
     Error *err = NULL;
 
-    dev = qdev_create(NULL, TYPE_PXA2XX_MMCI);
+    dev = qdev_new(TYPE_PXA2XX_MMCI);
     s = PXA2XX_MMCI(dev);
     sbd = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(sbd, 0, base);
     sysbus_connect_irq(sbd, 0, irq);
     qdev_connect_gpio_out_named(dev, "rx-dma", 0, rx_dma);
     qdev_connect_gpio_out_named(dev, "tx-dma", 0, tx_dma);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     /* Create and plug in the sd card */
-    carddev = qdev_create(qdev_get_child_bus(dev, "sd-bus"), TYPE_SD_CARD);
+    carddev = qdev_new(TYPE_SD_CARD);
     qdev_prop_set_drive(carddev, "drive", blk, &err);
     if (err) {
         error_reportf_err(err, "failed to init SD card: ");
         return NULL;
     }
-    object_property_set_bool(OBJECT(carddev), true, "realized", &err);
+    qdev_realize_and_unref(carddev, qdev_get_child_bus(dev, "sd-bus"), &err);
     if (err) {
         error_reportf_err(err, "failed to init SD card: ");
         return NULL;
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 829797b597..f98a6f3ae1 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -252,7 +252,7 @@ static void ssi_sd_realize(SSISlave *d, Error **errp)
     /* Create and plug in the sd card */
     /* FIXME use a qdev drive property instead of drive_get_next() */
     dinfo = drive_get_next(IF_SD);
-    carddev = qdev_create(BUS(&s->sdbus), TYPE_SD_CARD);
+    carddev = qdev_new(TYPE_SD_CARD);
     if (dinfo) {
         qdev_prop_set_drive(carddev, "drive", blk_by_legacy_dinfo(dinfo), &err);
         if (err) {
@@ -265,7 +265,7 @@ static void ssi_sd_realize(SSISlave *d, Error **errp)
         goto fail;
     }
 
-    object_property_set_bool(OBJECT(carddev), true, "realized", &err);
+    qdev_realize_and_unref(carddev, BUS(&s->sdbus), &err);
     if (err) {
         goto fail;
     }
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 72bb5285cc..d9592280bc 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -257,9 +257,9 @@ static void r2d_init(MachineState *machine)
     s = sh7750_init(cpu, address_space_mem);
     irq = r2d_fpga_init(address_space_mem, 0x04000000, sh7750_irl(s));
 
-    dev = qdev_create(NULL, "sh_pci");
+    dev = qdev_new("sh_pci");
     busdev = SYS_BUS_DEVICE(dev);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci"));
     sysbus_mmio_map(busdev, 0, P4ADDR(0x1e200000));
     sysbus_mmio_map(busdev, 1, A7ADDR(0x1e200000));
@@ -268,23 +268,23 @@ static void r2d_init(MachineState *machine)
     sysbus_connect_irq(busdev, 2, irq[PCI_INTC]);
     sysbus_connect_irq(busdev, 3, irq[PCI_INTD]);
 
-    dev = qdev_create(NULL, "sysbus-sm501");
+    dev = qdev_new("sysbus-sm501");
     busdev = SYS_BUS_DEVICE(dev);
     qdev_prop_set_uint32(dev, "vram-size", SM501_VRAM_SIZE);
     qdev_prop_set_uint32(dev, "base", 0x10000000);
     qdev_prop_set_chr(dev, "chardev", serial_hd(2));
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0x10000000);
     sysbus_mmio_map(busdev, 1, 0x13e00000);
     sysbus_connect_irq(busdev, 0, irq[SM501]);
 
     /* onboard CF (True IDE mode, Master only). */
     dinfo = drive_get(IF_IDE, 0, 0);
-    dev = qdev_create(NULL, "mmio-ide");
+    dev = qdev_new("mmio-ide");
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_connect_irq(busdev, 0, irq[CF_IDE]);
     qdev_prop_set_uint32(dev, "shift", 1);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0x14001000);
     sysbus_mmio_map(busdev, 1, 0x1400080c);
     mmio_ide_init_drives(dev, dinfo, NULL);
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 3facb8c2ae..52c0229574 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -228,12 +228,12 @@ static void leon3_generic_hw_init(MachineState *machine)
                             GRLIB_AHB_SLAVE, GRLIB_AHBMEM_AREA);
 
     /* Allocate IRQ manager */
-    dev = qdev_create(NULL, TYPE_GRLIB_IRQMP);
+    dev = qdev_new(TYPE_GRLIB_IRQMP);
     qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_set_pil_in,
                                         env, "pil", 1);
     qdev_connect_gpio_out_named(dev, "grlib-irq", 0,
                                 qdev_get_gpio_in_named(DEVICE(cpu), "pil", 0));
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_IRQMP_OFFSET);
     env->irq_manager = dev;
     env->qemu_irq_ack = leon3_irq_manager;
@@ -322,11 +322,11 @@ static void leon3_generic_hw_init(MachineState *machine)
     }
 
     /* Allocate timers */
-    dev = qdev_create(NULL, TYPE_GRLIB_GPTIMER);
+    dev = qdev_new(TYPE_GRLIB_GPTIMER);
     qdev_prop_set_uint32(dev, "nr-timers", LEON3_TIMER_COUNT);
     qdev_prop_set_uint32(dev, "frequency", CPU_CLK);
     qdev_prop_set_uint32(dev, "irq-line", LEON3_TIMER_IRQ);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_TIMER_OFFSET);
     for (i = 0; i < LEON3_TIMER_COUNT; i++) {
@@ -340,9 +340,9 @@ static void leon3_generic_hw_init(MachineState *machine)
 
     /* Allocate uart */
     if (serial_hd(0)) {
-        dev = qdev_create(NULL, TYPE_GRLIB_APB_UART);
+        dev = qdev_new(TYPE_GRLIB_APB_UART);
         qdev_prop_set_chr(dev, "chrdev", serial_hd(0));
-        qdev_init_nofail(dev);
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_UART_OFFSET);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, cpu_irqs[LEON3_UART_IRQ]);
         grlib_apb_pnp_add_entry(apb_pnp, LEON3_UART_OFFSET, 0xFFF,
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 8dda3f7292..61356946e9 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -315,9 +315,9 @@ static void *iommu_init(hwaddr addr, uint32_t version, qemu_irq irq)
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_create(NULL, TYPE_SUN4M_IOMMU);
+    dev = qdev_new(TYPE_SUN4M_IOMMU);
     qdev_prop_set_uint32(dev, "version", version);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
     sysbus_connect_irq(s, 0, irq);
     sysbus_mmio_map(s, 0, addr);
@@ -335,8 +335,8 @@ static void *sparc32_dma_init(hwaddr dma_base,
     SysBusESPState *esp;
     SysBusPCNetState *lance;
 
-    dma = qdev_create(NULL, TYPE_SPARC32_DMA);
-    qdev_init_nofail(dma);
+    dma = qdev_new(TYPE_SPARC32_DMA);
+    qdev_realize_and_unref(dma, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, dma_base);
 
     espdma = SPARC32_ESPDMA_DEVICE(object_resolve_path_component(
@@ -366,8 +366,8 @@ static DeviceState *slavio_intctl_init(hwaddr addr,
     SysBusDevice *s;
     unsigned int i, j;
 
-    dev = qdev_create(NULL, "slavio_intctl");
-    qdev_init_nofail(dev);
+    dev = qdev_new("slavio_intctl");
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     s = SYS_BUS_DEVICE(dev);
 
@@ -394,9 +394,9 @@ static void slavio_timer_init_all(hwaddr addr, qemu_irq master_irq,
     SysBusDevice *s;
     unsigned int i;
 
-    dev = qdev_create(NULL, "slavio_timer");
+    dev = qdev_new("slavio_timer");
     qdev_prop_set_uint32(dev, "num_cpus", num_cpus);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
     sysbus_connect_irq(s, 0, master_irq);
     sysbus_mmio_map(s, 0, addr + SYS_TIMER_OFFSET);
@@ -432,8 +432,8 @@ static void slavio_misc_init(hwaddr base,
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_create(NULL, "slavio_misc");
-    qdev_init_nofail(dev);
+    dev = qdev_new("slavio_misc");
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
     if (base) {
         /* 8 bit registers */
@@ -469,9 +469,9 @@ static void ecc_init(hwaddr base, qemu_irq irq, uint32_t version)
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_create(NULL, "eccmemctl");
+    dev = qdev_new("eccmemctl");
     qdev_prop_set_uint32(dev, "version", version);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
     sysbus_connect_irq(s, 0, irq);
     sysbus_mmio_map(s, 0, base);
@@ -485,8 +485,8 @@ static void apc_init(hwaddr power_base, qemu_irq cpu_halt)
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_create(NULL, "apc");
-    qdev_init_nofail(dev);
+    dev = qdev_new("apc");
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
     /* Power management (APC) XXX: not a Slavio device */
     sysbus_mmio_map(s, 0, power_base);
@@ -499,12 +499,12 @@ static void tcx_init(hwaddr addr, qemu_irq irq, int vram_size, int width,
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_create(NULL, "SUNW,tcx");
+    dev = qdev_new("SUNW,tcx");
     qdev_prop_set_uint32(dev, "vram_size", vram_size);
     qdev_prop_set_uint16(dev, "width", width);
     qdev_prop_set_uint16(dev, "height", height);
     qdev_prop_set_uint16(dev, "depth", depth);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
 
     /* 10/ROM : FCode ROM */
@@ -551,12 +551,12 @@ static void cg3_init(hwaddr addr, qemu_irq irq, int vram_size, int width,
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_create(NULL, "cgthree");
+    dev = qdev_new("cgthree");
     qdev_prop_set_uint32(dev, "vram-size", vram_size);
     qdev_prop_set_uint16(dev, "width", width);
     qdev_prop_set_uint16(dev, "height", height);
     qdev_prop_set_uint16(dev, "depth", depth);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
 
     /* FCode ROM */
@@ -580,8 +580,8 @@ static void idreg_init(hwaddr addr)
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_create(NULL, TYPE_MACIO_ID_REGISTER);
-    qdev_init_nofail(dev);
+    dev = qdev_new(TYPE_MACIO_ID_REGISTER);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
 
     sysbus_mmio_map(s, 0, addr);
@@ -646,8 +646,8 @@ static void afx_init(hwaddr addr)
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_create(NULL, TYPE_TCX_AFX);
-    qdev_init_nofail(dev);
+    dev = qdev_new(TYPE_TCX_AFX);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
 
     sysbus_mmio_map(s, 0, addr);
@@ -707,8 +707,8 @@ static void prom_init(hwaddr addr, const char *bios_name)
     char *filename;
     int ret;
 
-    dev = qdev_create(NULL, TYPE_OPENPROM);
-    qdev_init_nofail(dev);
+    dev = qdev_new(TYPE_OPENPROM);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
 
     sysbus_mmio_map(s, 0, addr);
@@ -876,9 +876,9 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
         cpu_irqs[i] = qemu_allocate_irqs(dummy_cpu_set_irq, NULL, MAX_PILS);
 
     /* Create and map RAM frontend */
-    dev = qdev_create(NULL, "memory");
+    dev = qdev_new("memory");
     object_property_set_link(OBJECT(dev), ram_memdev, "memdev", &error_fatal);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0);
 
     /* models without ECC don't trap when missing ram is accessed */
@@ -977,7 +977,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
 
     /* Slavio TTYA (base+4, Linux ttyS0) is the first QEMU serial device
        Slavio TTYB (base+0, Linux ttyS1) is the second QEMU serial device */
-    dev = qdev_create(NULL, TYPE_ESCC);
+    dev = qdev_new(TYPE_ESCC);
     qdev_prop_set_uint32(dev, "disabled", !machine->enable_graphics);
     qdev_prop_set_uint32(dev, "frequency", ESCC_CLOCK);
     qdev_prop_set_uint32(dev, "it_shift", 1);
@@ -985,13 +985,13 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     qdev_prop_set_chr(dev, "chrA", NULL);
     qdev_prop_set_uint32(dev, "chnBtype", escc_mouse);
     qdev_prop_set_uint32(dev, "chnAtype", escc_kbd);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
     sysbus_connect_irq(s, 0, slavio_irq[14]);
     sysbus_connect_irq(s, 1, slavio_irq[14]);
     sysbus_mmio_map(s, 0, hwdef->ms_kb_base);
 
-    dev = qdev_create(NULL, TYPE_ESCC);
+    dev = qdev_new(TYPE_ESCC);
     qdev_prop_set_uint32(dev, "disabled", 0);
     qdev_prop_set_uint32(dev, "frequency", ESCC_CLOCK);
     qdev_prop_set_uint32(dev, "it_shift", 1);
@@ -999,7 +999,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     qdev_prop_set_chr(dev, "chrA", serial_hd(0));
     qdev_prop_set_uint32(dev, "chnBtype", escc_serial);
     qdev_prop_set_uint32(dev, "chnAtype", escc_serial);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     s = SYS_BUS_DEVICE(dev);
     sysbus_connect_irq(s, 0, slavio_irq[15]);
@@ -1055,13 +1055,13 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
         ecc_init(hwdef->ecc_base, slavio_irq[28],
                  hwdef->ecc_version);
 
-    dev = qdev_create(NULL, TYPE_FW_CFG_MEM);
+    dev = qdev_new(TYPE_FW_CFG_MEM);
     fw_cfg = FW_CFG(dev);
     qdev_prop_set_uint32(dev, "data_width", 1);
     qdev_prop_set_bit(dev, "dma_enabled", false);
     object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
                               OBJECT(fw_cfg));
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(s, 0, CFG_ADDR);
     sysbus_mmio_map(s, 1, CFG_ADDR + 2);
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 3a757ec42e..ade9c22825 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -351,8 +351,8 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
     qdev_init_nofail(dev);
 
     /* Power */
-    dev = qdev_create(NULL, TYPE_SUN4U_POWER);
-    qdev_init_nofail(dev);
+    dev = qdev_new(TYPE_SUN4U_POWER);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sbd = SYS_BUS_DEVICE(dev);
     memory_region_add_subregion(pci_address_space_io(pci_dev), 0x7240,
                                 sysbus_mmio_get_region(sbd, 0));
@@ -426,8 +426,8 @@ static void prom_init(hwaddr addr, const char *bios_name)
     char *filename;
     int ret;
 
-    dev = qdev_create(NULL, TYPE_OPENPROM);
-    qdev_init_nofail(dev);
+    dev = qdev_new(TYPE_OPENPROM);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
 
     sysbus_mmio_map(s, 0, addr);
@@ -520,12 +520,12 @@ static void ram_init(hwaddr addr, ram_addr_t RAM_size)
     RamDevice *d;
 
     /* allocate RAM */
-    dev = qdev_create(NULL, TYPE_SUN4U_MEMORY);
+    dev = qdev_new(TYPE_SUN4U_MEMORY);
     s = SYS_BUS_DEVICE(dev);
 
     d = SUN4U_RAM(dev);
     d->size = RAM_size;
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     sysbus_mmio_map(s, 0, addr);
 }
@@ -572,8 +572,8 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     cpu = sparc64_cpu_devinit(machine->cpu_type, hwdef->prom_addr);
 
     /* IOMMU */
-    iommu = qdev_create(NULL, TYPE_SUN4U_IOMMU);
-    qdev_init_nofail(iommu);
+    iommu = qdev_new(TYPE_SUN4U_IOMMU);
+    qdev_realize_and_unref(iommu, NULL, &error_fatal);
 
     /* set up devices */
     ram_init(0, machine->ram_size);
@@ -581,12 +581,12 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     prom_init(hwdef->prom_addr, bios_name);
 
     /* Init sabre (PCI host bridge) */
-    sabre = SABRE_DEVICE(qdev_create(NULL, TYPE_SABRE));
+    sabre = SABRE_DEVICE(qdev_new(TYPE_SABRE));
     qdev_prop_set_uint64(DEVICE(sabre), "special-base", PBM_SPECIAL_BASE);
     qdev_prop_set_uint64(DEVICE(sabre), "mem-base", PBM_MEM_BASE);
     object_property_set_link(OBJECT(sabre), OBJECT(iommu), "iommu",
                              &error_abort);
-    qdev_init_nofail(DEVICE(sabre));
+    qdev_realize_and_unref(DEVICE(sabre), NULL, &error_fatal);
 
     /* Wire up PCI interrupts to CPU */
     for (i = 0; i < IVEC_MAX; i++) {
@@ -689,10 +689,10 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
                            graphic_width, graphic_height, graphic_depth,
                            (uint8_t *)&macaddr);
 
-    dev = qdev_create(NULL, TYPE_FW_CFG_IO);
+    dev = qdev_new(TYPE_FW_CFG_IO);
     qdev_prop_set_bit(dev, "dma_enabled", false);
     object_property_add_child(OBJECT(ebus), TYPE_FW_CFG, OBJECT(dev));
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     memory_region_add_subregion(pci_address_space_io(ebus), BIOS_CFG_IOPORT,
                                 &FW_CFG_IO(dev)->comb_iomem);
 
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 32dd4461be..532f73661b 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -1387,9 +1387,9 @@ type_init(xen_register_types)
 
 void xen_bus_init(void)
 {
-    DeviceState *dev = qdev_create(NULL, TYPE_XEN_BRIDGE);
+    DeviceState *dev = qdev_new(TYPE_XEN_BRIDGE);
     BusState *bus = qbus_create(TYPE_XEN_BUS, dev, NULL);
 
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     qbus_set_bus_hotplug_handler(bus, &error_abort);
 }
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index f9d013811a..1c25373852 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -703,8 +703,8 @@ int xen_be_init(void)
         xengnttab_close(gnttabdev);
     }
 
-    xen_sysdev = qdev_create(NULL, TYPE_XENSYSDEV);
-    qdev_init_nofail(xen_sysdev);
+    xen_sysdev = qdev_new(TYPE_XENSYSDEV);
+    qdev_realize_and_unref(xen_sysdev, NULL, &error_fatal);
     xen_sysbus = qbus_create(TYPE_XENSYSBUS, xen_sysdev, "xen-sysbus");
     qbus_set_bus_hotplug_handler(xen_sysbus, &error_abort);
 
diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
index b22dcf938a..4dbc1a1614 100644
--- a/hw/xtensa/virt.c
+++ b/hw/xtensa/virt.c
@@ -62,8 +62,8 @@ static void create_pcie(CPUXtensaState *env, int irq_base, hwaddr addr_base)
     qemu_irq *extints;
     int i;
 
-    dev = qdev_create(NULL, TYPE_GPEX_HOST);
-    qdev_init_nofail(dev);
+    dev = qdev_new(TYPE_GPEX_HOST);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     /* Map only the first size_ecam bytes of ECAM space. */
     ecam_alias = g_new0(MemoryRegion, 1);
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 60ccc74f5f..eab5c8062e 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -148,9 +148,9 @@ static void xtfpga_net_init(MemoryRegion *address_space,
     SysBusDevice *s;
     MemoryRegion *ram;
 
-    dev = qdev_create(NULL, "open_eth");
+    dev = qdev_new("open_eth");
     qdev_set_nic_properties(dev, nd);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     s = SYS_BUS_DEVICE(dev);
     sysbus_connect_irq(s, 0, irq);
@@ -171,7 +171,7 @@ static PFlashCFI01 *xtfpga_flash_init(MemoryRegion *address_space,
                                       DriveInfo *dinfo, int be)
 {
     SysBusDevice *s;
-    DeviceState *dev = qdev_create(NULL, TYPE_PFLASH_CFI01);
+    DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
 
     qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo),
                         &error_abort);
@@ -181,7 +181,7 @@ static PFlashCFI01 *xtfpga_flash_init(MemoryRegion *address_space,
     qdev_prop_set_uint8(dev, "width", 2);
     qdev_prop_set_bit(dev, "big-endian", be);
     qdev_prop_set_string(dev, "name", "xtfpga.io.flash");
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
     memory_region_add_subregion(address_space, board->flash->base,
                                 sysbus_mmio_get_region(s, 0));
-- 
2.26.2


