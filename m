Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843ABC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:19:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D0720707
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbGZ/TdW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D0720707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jefrA-0000up-51
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 10:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKi-0003dY-LY
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:46:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47292
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKN-00077l-1s
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590759937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S683DGIxmcprh+5rpmmy1Vn+6BgDH/psOZr9r7XTLGo=;
 b=MbGZ/TdWa/GSmUV3psfWV7ZJYGKRw2hpTp3yZBveXSmunbh05NsQ8BK1rLkT8Tv7yNvjm4
 /ND+OyY+VeqSzIVxhid3r2toIHqiVgDngepnndjfaaPhB/+IaJwPceEPpddVeWk2OSFVG6
 q/ITWRirHsfIULvMulsJlnpUDYnnVgE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-CNfewjULN66uo58b0inoXQ-1; Fri, 29 May 2020 09:45:35 -0400
X-MC-Unique: CNfewjULN66uo58b0inoXQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DC04107ACF7;
 Fri, 29 May 2020 13:45:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F3F426298C;
 Fri, 29 May 2020 13:45:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7DFAF1135240; Fri, 29 May 2020 15:45:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 45/58] sysbus: Convert to sysbus_realize() etc. with
 Coccinelle
Date: Fri, 29 May 2020 15:45:10 +0200
Message-Id: <20200529134523.8477-46-armbru@redhat.com>
In-Reply-To: <20200529134523.8477-1-armbru@redhat.com>
References: <20200529134523.8477-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 03:05:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert from qdev_realize(), qdev_realize_and_unref() with null @bus
argument to sysbus_realize(), sysbus_realize_and_unref().

Coccinelle script:

    @@
    expression dev, errp;
    @@
    -    qdev_realize(DEVICE(dev), NULL, errp);
    +    sysbus_realize(SYS_BUS_DEVICE(dev), errp);

    @@
    expression sysbus_dev, dev, errp;
    @@
    +    sysbus_dev = SYS_BUS_DEVICE(dev);
    -    qdev_realize_and_unref(dev, NULL, errp);
    +    sysbus_realize_and_unref(sysbus_dev, errp);
    -    sysbus_dev = SYS_BUS_DEVICE(dev);

    @@
    expression sysbus_dev, dev, errp;
    expression expr;
    @@
         sysbus_dev = SYS_BUS_DEVICE(dev);
         ... when != dev = expr;
    -    qdev_realize_and_unref(dev, NULL, errp);
    +    sysbus_realize_and_unref(sysbus_dev, errp);

    @@
    expression dev, errp;
    @@
    -    qdev_realize_and_unref(DEVICE(dev), NULL, errp);
    +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp);

    @@
    expression dev, errp;
    @@
    -    qdev_realize_and_unref(dev, NULL, errp);
    +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp);

Whitespace changes minimized manually.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/lm32/lm32.h                           |  6 ++---
 hw/lm32/milkymist-hw.h                   | 18 ++++++-------
 include/hw/char/cadence_uart.h           |  2 +-
 include/hw/char/cmsdk-apb-uart.h         |  2 +-
 include/hw/char/pl011.h                  |  4 +--
 include/hw/char/xilinx_uartlite.h        |  2 +-
 include/hw/cris/etraxfs.h                |  2 +-
 include/hw/misc/unimp.h                  |  2 +-
 include/hw/timer/cmsdk-apb-timer.h       |  2 +-
 hw/alpha/typhoon.c                       |  2 +-
 hw/arm/exynos4210.c                      | 18 ++++++-------
 hw/arm/exynos4_boards.c                  |  2 +-
 hw/arm/highbank.c                        | 12 ++++-----
 hw/arm/integratorcp.c                    |  2 +-
 hw/arm/mps2-tz.c                         |  2 +-
 hw/arm/msf2-som.c                        |  2 +-
 hw/arm/musicpal.c                        |  4 +--
 hw/arm/netduino2.c                       |  2 +-
 hw/arm/netduinoplus2.c                   |  2 +-
 hw/arm/nseries.c                         |  4 +--
 hw/arm/omap1.c                           |  8 +++---
 hw/arm/omap2.c                           |  8 +++---
 hw/arm/pxa2xx.c                          |  4 +--
 hw/arm/pxa2xx_gpio.c                     |  2 +-
 hw/arm/pxa2xx_pic.c                      |  2 +-
 hw/arm/realview.c                        | 10 ++++----
 hw/arm/sbsa-ref.c                        | 12 ++++-----
 hw/arm/spitz.c                           |  2 +-
 hw/arm/stellaris.c                       |  6 ++---
 hw/arm/strongarm.c                       |  4 +--
 hw/arm/versatilepb.c                     |  8 +++---
 hw/arm/vexpress.c                        |  8 +++---
 hw/arm/virt.c                            | 18 ++++++-------
 hw/arm/xilinx_zynq.c                     | 16 ++++++------
 hw/arm/xlnx-versal-virt.c                |  2 +-
 hw/arm/xlnx-versal.c                     |  2 +-
 hw/block/fdc.c                           |  4 +--
 hw/block/pflash_cfi01.c                  |  2 +-
 hw/block/pflash_cfi02.c                  |  2 +-
 hw/char/exynos4210_uart.c                |  2 +-
 hw/char/mcf_uart.c                       |  2 +-
 hw/char/serial.c                         |  2 +-
 hw/core/empty_slot.c                     |  2 +-
 hw/core/sysbus.c                         |  2 +-
 hw/cris/axis_dev88.c                     |  2 +-
 hw/display/milkymist-tmu2.c              |  2 +-
 hw/display/sm501.c                       |  2 +-
 hw/dma/pxa2xx_dma.c                      |  4 +--
 hw/dma/rc4030.c                          |  2 +-
 hw/dma/sparc32_dma.c                     |  8 +++---
 hw/hppa/dino.c                           |  2 +-
 hw/hppa/lasi.c                           |  2 +-
 hw/hppa/machine.c                        |  2 +-
 hw/i386/pc.c                             |  2 +-
 hw/i386/pc_q35.c                         |  2 +-
 hw/i386/pc_sysfw.c                       |  2 +-
 hw/i386/x86.c                            |  2 +-
 hw/intc/exynos4210_gic.c                 |  2 +-
 hw/intc/s390_flic.c                      |  2 +-
 hw/isa/isa-bus.c                         |  2 +-
 hw/m68k/mcf5208.c                        |  2 +-
 hw/m68k/mcf_intc.c                       |  2 +-
 hw/m68k/next-cube.c                      |  6 ++---
 hw/m68k/q800.c                           | 12 ++++-----
 hw/microblaze/petalogix_ml605_mmu.c      | 10 ++++----
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  6 ++---
 hw/mips/boston.c                         |  4 +--
 hw/mips/gt64xxx_pci.c                    |  2 +-
 hw/mips/jazz.c                           |  8 +++---
 hw/mips/malta.c                          |  2 +-
 hw/mips/mipssim.c                        |  4 +--
 hw/net/etraxfs_eth.c                     |  2 +-
 hw/net/fsl_etsec/etsec.c                 |  2 +-
 hw/net/lan9118.c                         |  2 +-
 hw/net/lasi_i82596.c                     |  2 +-
 hw/net/smc91c111.c                       |  2 +-
 hw/nios2/10m50_devboard.c                |  6 ++---
 hw/nvram/fw_cfg.c                        |  4 +--
 hw/openrisc/openrisc_sim.c               |  4 +--
 hw/pci-bridge/pci_expander_bridge.c      |  2 +-
 hw/pci-host/bonito.c                     |  2 +-
 hw/pci-host/i440fx.c                     |  2 +-
 hw/pcmcia/pxa2xx.c                       |  2 +-
 hw/ppc/e500.c                            | 16 ++++++------
 hw/ppc/mac_newworld.c                    | 16 ++++++------
 hw/ppc/mac_oldworld.c                    |  6 ++---
 hw/ppc/pnv.c                             |  8 +++---
 hw/ppc/ppc440_uc.c                       |  4 +--
 hw/ppc/prep.c                            |  4 +--
 hw/ppc/sam460ex.c                        |  2 +-
 hw/ppc/spapr.c                           |  2 +-
 hw/ppc/spapr_irq.c                       |  2 +-
 hw/ppc/spapr_vio.c                       |  2 +-
 hw/ppc/virtex_ml507.c                    |  4 +--
 hw/riscv/sifive_clint.c                  |  2 +-
 hw/riscv/sifive_e_prci.c                 |  2 +-
 hw/riscv/sifive_plic.c                   |  2 +-
 hw/riscv/sifive_test.c                   |  2 +-
 hw/riscv/virt.c                          |  4 +--
 hw/rtc/m48t59.c                          |  2 +-
 hw/rtc/sun4v-rtc.c                       |  2 +-
 hw/s390x/ap-bridge.c                     |  2 +-
 hw/s390x/css-bridge.c                    |  2 +-
 hw/s390x/s390-virtio-ccw.c               |  2 +-
 hw/s390x/sclp.c                          |  2 +-
 hw/sd/pxa2xx_mmci.c                      |  2 +-
 hw/sh4/r2d.c                             |  6 ++---
 hw/sparc/leon3.c                         | 10 ++++----
 hw/sparc/sun4m.c                         | 32 ++++++++++++------------
 hw/sparc64/sun4u.c                       | 12 ++++-----
 hw/xen/xen-bus.c                         |  2 +-
 hw/xen/xen-legacy-backend.c              |  2 +-
 hw/xtensa/virt.c                         |  2 +-
 hw/xtensa/xtfpga.c                       |  4 +--
 114 files changed, 257 insertions(+), 257 deletions(-)

diff --git a/hw/lm32/lm32.h b/hw/lm32/lm32.h
index 326238d859..7b4f6255b9 100644
--- a/hw/lm32/lm32.h
+++ b/hw/lm32/lm32.h
@@ -11,8 +11,8 @@ static inline DeviceState *lm32_pic_init(qemu_irq cpu_irq)
     SysBusDevice *d;
 
     dev = qdev_new("lm32-pic");
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     d = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(d, &error_fatal);
     sysbus_connect_irq(d, 0, cpu_irq);
 
     return dev;
@@ -24,7 +24,7 @@ static inline DeviceState *lm32_juart_init(Chardev *chr)
 
     dev = qdev_new(TYPE_LM32_JUART);
     qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     return dev;
 }
@@ -39,7 +39,7 @@ static inline DeviceState *lm32_uart_create(hwaddr addr,
     dev = qdev_new("lm32-uart");
     s = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_mmio_map(s, 0, addr);
     sysbus_connect_irq(s, 0, irq);
     return dev;
diff --git a/hw/lm32/milkymist-hw.h b/hw/lm32/milkymist-hw.h
index d5f15a30a1..05e2c2a5a7 100644
--- a/hw/lm32/milkymist-hw.h
+++ b/hw/lm32/milkymist-hw.h
@@ -13,7 +13,7 @@ static inline DeviceState *milkymist_uart_create(hwaddr base,
 
     dev = qdev_new("milkymist-uart");
     qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
 
@@ -25,7 +25,7 @@ static inline DeviceState *milkymist_hpdmc_create(hwaddr base)
     DeviceState *dev;
 
     dev = qdev_new("milkymist-hpdmc");
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
 
     return dev;
@@ -36,7 +36,7 @@ static inline DeviceState *milkymist_memcard_create(hwaddr base)
     DeviceState *dev;
 
     dev = qdev_new("milkymist-memcard");
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
 
     return dev;
@@ -50,7 +50,7 @@ static inline DeviceState *milkymist_vgafb_create(hwaddr base,
     dev = qdev_new("milkymist-vgafb");
     qdev_prop_set_uint32(dev, "fb_offset", fb_offset);
     qdev_prop_set_uint32(dev, "fb_mask", fb_mask);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
 
     return dev;
@@ -68,7 +68,7 @@ static inline DeviceState *milkymist_sysctl_create(hwaddr base,
     qdev_prop_set_uint32(dev, "systemid", system_id);
     qdev_prop_set_uint32(dev, "capabilities", capabilities);
     qdev_prop_set_uint32(dev, "gpio_strappings", gpio_strappings);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, gpio_irq);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1, timer0_irq);
@@ -83,7 +83,7 @@ static inline DeviceState *milkymist_pfpu_create(hwaddr base,
     DeviceState *dev;
 
     dev = qdev_new("milkymist-pfpu");
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
     return dev;
@@ -96,7 +96,7 @@ static inline DeviceState *milkymist_ac97_create(hwaddr base,
     DeviceState *dev;
 
     dev = qdev_new("milkymist-ac97");
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, crrequest_irq);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1, crreply_irq);
@@ -114,7 +114,7 @@ static inline DeviceState *milkymist_minimac2_create(hwaddr base,
     qemu_check_nic_model(&nd_table[0], "minimac2");
     dev = qdev_new("milkymist-minimac2");
     qdev_set_nic_properties(dev, &nd_table[0]);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, buffers_base);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, rx_irq);
@@ -132,7 +132,7 @@ static inline DeviceState *milkymist_softusb_create(hwaddr base,
     dev = qdev_new("milkymist-softusb");
     qdev_prop_set_uint32(dev, "pmem_size", pmem_size);
     qdev_prop_set_uint32(dev, "dmem_size", dmem_size);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, pmem_base);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, dmem_base);
diff --git a/include/hw/char/cadence_uart.h b/include/hw/char/cadence_uart.h
index af80b6083b..ed7b58d31d 100644
--- a/include/hw/char/cadence_uart.h
+++ b/include/hw/char/cadence_uart.h
@@ -63,7 +63,7 @@ static inline DeviceState *cadence_uart_create(hwaddr addr,
     dev = qdev_new(TYPE_CADENCE_UART);
     s = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_mmio_map(s, 0, addr);
     sysbus_connect_irq(s, 0, irq);
 
diff --git a/include/hw/char/cmsdk-apb-uart.h b/include/hw/char/cmsdk-apb-uart.h
index a51471ff74..bc9069f9fd 100644
--- a/include/hw/char/cmsdk-apb-uart.h
+++ b/include/hw/char/cmsdk-apb-uart.h
@@ -66,7 +66,7 @@ static inline DeviceState *cmsdk_apb_uart_create(hwaddr addr,
     s = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", chr);
     qdev_prop_set_uint32(dev, "pclk-frq", pclk_frq);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_mmio_map(s, 0, addr);
     sysbus_connect_irq(s, 0, txint);
     sysbus_connect_irq(s, 1, rxint);
diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
index 18e701b65d..bed758350f 100644
--- a/include/hw/char/pl011.h
+++ b/include/hw/char/pl011.h
@@ -61,7 +61,7 @@ static inline DeviceState *pl011_create(hwaddr addr,
     dev = qdev_new("pl011");
     s = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_mmio_map(s, 0, addr);
     sysbus_connect_irq(s, 0, irq);
 
@@ -78,7 +78,7 @@ static inline DeviceState *pl011_luminary_create(hwaddr addr,
     dev = qdev_new("pl011_luminary");
     s = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_mmio_map(s, 0, addr);
     sysbus_connect_irq(s, 0, irq);
 
diff --git a/include/hw/char/xilinx_uartlite.h b/include/hw/char/xilinx_uartlite.h
index 007b84575f..bb32d0fcb3 100644
--- a/include/hw/char/xilinx_uartlite.h
+++ b/include/hw/char/xilinx_uartlite.h
@@ -28,7 +28,7 @@ static inline DeviceState *xilinx_uartlite_create(hwaddr addr,
     dev = qdev_new("xlnx.xps-uartlite");
     s = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_mmio_map(s, 0, addr);
     sysbus_connect_irq(s, 0, irq);
 
diff --git a/include/hw/cris/etraxfs.h b/include/hw/cris/etraxfs.h
index 19b903facf..9e99380e0c 100644
--- a/include/hw/cris/etraxfs.h
+++ b/include/hw/cris/etraxfs.h
@@ -44,7 +44,7 @@ static inline DeviceState *etraxfs_ser_create(hwaddr addr,
     dev = qdev_new("etraxfs,serial");
     s = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_mmio_map(s, 0, addr);
     sysbus_connect_irq(s, 0, irq);
     return dev;
diff --git a/include/hw/misc/unimp.h b/include/hw/misc/unimp.h
index e71ec17e13..4c1d13c9bf 100644
--- a/include/hw/misc/unimp.h
+++ b/include/hw/misc/unimp.h
@@ -45,7 +45,7 @@ static inline void create_unimplemented_device(const char *name,
 
     qdev_prop_set_string(dev, "name", name);
     qdev_prop_set_uint64(dev, "size", size);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(dev), 0, base, -1000);
 }
diff --git a/include/hw/timer/cmsdk-apb-timer.h b/include/hw/timer/cmsdk-apb-timer.h
index eee175eaa4..f24bda6a46 100644
--- a/include/hw/timer/cmsdk-apb-timer.h
+++ b/include/hw/timer/cmsdk-apb-timer.h
@@ -51,7 +51,7 @@ static inline DeviceState *cmsdk_apb_timer_create(hwaddr addr,
     dev = qdev_new(TYPE_CMSDK_APB_TIMER);
     s = SYS_BUS_DEVICE(dev);
     qdev_prop_set_uint32(dev, "pclk-frq", pclk_frq);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_mmio_map(s, 0, addr);
     sysbus_connect_irq(s, 0, timerint);
     return dev;
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 480d866c77..29d44dfb06 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -889,7 +889,7 @@ PCIBus *typhoon_init(MemoryRegion *ram, ISABus **isa_bus, qemu_irq *p_rtc_irq,
                               &s->pchip.reg_mem, &s->pchip.reg_io,
                               0, 64, TYPE_PCI_BUS);
     phb->bus = b;
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* Host memory as seen from the PCI side, via the IOMMU.  */
     memory_region_init_iommu(&s->pchip.iommu, sizeof(s->pchip.iommu),
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 86cbd63857..2afeb73776 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -184,8 +184,8 @@ static DeviceState *pl330_create(uint32_t base, qemu_or_irq *orgate,
     qdev_prop_set_uint8(dev, "rd_q_dep", 8);
     qdev_prop_set_uint8(dev, "data_width", width);
     qdev_prop_set_uint16(dev, "data_buffer_dep", width);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, base);
 
     object_property_set_int(OBJECT(orgate), nevents + 1, "num-lines",
@@ -234,7 +234,7 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
     for (i = 0; i < EXYNOS4210_NCPUS; i++) {
         dev = qdev_new("exynos4210.irq_gate");
         qdev_prop_set_uint32(dev, "n_in", EXYNOS4210_IRQ_GATE_NINPUTS);
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         /* Get IRQ Gate input in gate_irq */
         for (n = 0; n < EXYNOS4210_IRQ_GATE_NINPUTS; n++) {
             gate_irq[i][n] = qdev_get_gpio_in(dev, n);
@@ -249,8 +249,8 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
     /* Private memory region and Internal GIC */
     dev = qdev_new(TYPE_A9MPCORE_PRIV);
     qdev_prop_set_uint32(dev, "num-cpu", EXYNOS4210_NCPUS);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, EXYNOS4210_SMP_PRIVATE_BASE_ADDR);
     for (n = 0; n < EXYNOS4210_NCPUS; n++) {
         sysbus_connect_irq(busdev, n, gate_irq[n][0]);
@@ -265,8 +265,8 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
     /* External GIC */
     dev = qdev_new("exynos4210.gic");
     qdev_prop_set_uint32(dev, "num-cpu", EXYNOS4210_NCPUS);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
     /* Map CPU interface */
     sysbus_mmio_map(busdev, 0, EXYNOS4210_EXT_GIC_CPU_BASE_ADDR);
     /* Map Distributer interface */
@@ -280,8 +280,8 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
 
     /* Internal Interrupt Combiner */
     dev = qdev_new("exynos4210.combiner");
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
     for (n = 0; n < EXYNOS4210_MAX_INT_COMBINER_OUT_IRQ; n++) {
         sysbus_connect_irq(busdev, n, s->irqs.int_gic_irq[n]);
     }
@@ -291,8 +291,8 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
     /* External Interrupt Combiner */
     dev = qdev_new("exynos4210.combiner");
     qdev_prop_set_uint32(dev, "external", 1);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
     for (n = 0; n < EXYNOS4210_MAX_INT_COMBINER_OUT_IRQ; n++) {
         sysbus_connect_irq(busdev, n, s->irqs.ext_gic_irq[n]);
     }
@@ -354,8 +354,8 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
 
     /* Multi Core Timer */
     dev = qdev_new("exynos4210.mct");
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
     for (n = 0; n < 4; n++) {
         /* Connect global timer interrupts to Combiner gpio_in */
         sysbus_connect_irq(busdev, n,
@@ -380,8 +380,8 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
         }
 
         dev = qdev_new("exynos4210.i2c");
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
         busdev = SYS_BUS_DEVICE(dev);
+        sysbus_realize_and_unref(busdev, &error_fatal);
         sysbus_connect_irq(busdev, 0, i2c_irq);
         sysbus_mmio_map(busdev, 0, addr);
         s->i2c_if[n] = (I2CBus *)qdev_get_child_bus(dev, "i2c");
@@ -425,9 +425,9 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
          */
         dev = qdev_new(TYPE_S3C_SDHCI);
         qdev_prop_set_uint64(dev, "capareg", EXYNOS4210_SDHCI_CAPABILITIES);
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
 
         busdev = SYS_BUS_DEVICE(dev);
+        sysbus_realize_and_unref(busdev, &error_fatal);
         sysbus_mmio_map(busdev, 0, EXYNOS4210_SDHCI_ADDR(n));
         sysbus_connect_irq(busdev, 0, s->irq_table[exynos4210_get_irq(29, n)]);
 
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index d4fe9c6128..326122abff 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -84,8 +84,8 @@ static void lan9215_init(uint32_t base, qemu_irq irq)
         dev = qdev_new(TYPE_LAN9118);
         qdev_set_nic_properties(dev, &nd_table[0]);
         qdev_prop_set_uint32(dev, "mode_16bit", 1);
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
         s = SYS_BUS_DEVICE(dev);
+        sysbus_realize_and_unref(s, &error_fatal);
         sysbus_mmio_map(s, 0, base);
         sysbus_connect_irq(s, 0, irq);
     }
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 1bed540011..7f279d7f93 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -312,8 +312,8 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
     switch (machine_id) {
     case CALXEDA_HIGHBANK:
         dev = qdev_new("l2x0");
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
         busdev = SYS_BUS_DEVICE(dev);
+        sysbus_realize_and_unref(busdev, &error_fatal);
         sysbus_mmio_map(busdev, 0, 0xfff12000);
 
         dev = qdev_new(TYPE_A9MPCORE_PRIV);
@@ -324,8 +324,8 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
     }
     qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
     qdev_prop_set_uint32(dev, "num-irq", NIRQ_GIC);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
     for (n = 0; n < smp_cpus; n++) {
         sysbus_connect_irq(busdev, n, cpu_irq[n]);
@@ -341,15 +341,15 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
     dev = qdev_new("sp804");
     qdev_prop_set_uint32(dev, "freq0", 150000000);
     qdev_prop_set_uint32(dev, "freq1", 150000000);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0xfff34000);
     sysbus_connect_irq(busdev, 0, pic[18]);
     pl011_create(0xfff36000, pic[20], serial_hd(0));
 
     dev = qdev_new(TYPE_HIGHBANK_REGISTERS);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0xfff3c000);
 
     sysbus_create_simple("pl061", 0xfff30000, pic[14]);
@@ -365,7 +365,7 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
         qemu_check_nic_model(&nd_table[0], "xgmac");
         dev = qdev_new("xgmac");
         qdev_set_nic_properties(dev, &nd_table[0]);
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xfff50000);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[77]);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1, pic[78]);
@@ -374,7 +374,7 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
         qemu_check_nic_model(&nd_table[1], "xgmac");
         dev = qdev_new("xgmac");
         qdev_set_nic_properties(dev, &nd_table[1]);
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xfff51000);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[80]);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1, pic[81]);
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 45698307f1..a55d2c31e3 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -622,7 +622,7 @@ static void integratorcp_init(MachineState *machine)
 
     dev = qdev_new(TYPE_INTEGRATOR_CM);
     qdev_prop_set_uint32(dev, "memsz", ram_size >> 20);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map((SysBusDevice *)dev, 0, 0x10000000);
 
     dev = sysbus_create_varargs(TYPE_INTEGRATOR_PIC, 0x14000000,
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 90f4449b9d..4c49512e0b 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -247,9 +247,9 @@ static MemoryRegion *make_eth_dev(MPS2TZMachineState *mms, void *opaque,
     qemu_check_nic_model(nd, "lan9118");
     mms->lan9118 = qdev_new(TYPE_LAN9118);
     qdev_set_nic_properties(mms->lan9118, nd);
-    qdev_realize_and_unref(mms->lan9118, NULL, &error_fatal);
 
     s = SYS_BUS_DEVICE(mms->lan9118);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_connect_irq(s, 0, get_sse_irq_in(mms, 16));
     return sysbus_mmio_get_region(s, 0);
 }
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index ca9cbe1acb..355966c073 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -77,7 +77,7 @@ static void emcraft_sf2_s2s010_init(MachineState *machine)
     qdev_prop_set_uint32(dev, "apb0div", 2);
     qdev_prop_set_uint32(dev, "apb1div", 2);
 
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     soc = MSF2_SOC(dev);
 
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index d03351e5fa..394a3345bd 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1653,7 +1653,7 @@ static void musicpal_init(MachineState *machine)
     qemu_check_nic_model(&nd_table[0], "mv88w8618");
     dev = qdev_new(TYPE_MV88W8618_ETH);
     qdev_set_nic_properties(dev, &nd_table[0]);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, MP_ETH_BASE);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[MP_ETH_IRQ]);
 
@@ -1692,7 +1692,7 @@ static void musicpal_init(MachineState *machine)
     s = SYS_BUS_DEVICE(dev);
     object_property_set_link(OBJECT(dev), OBJECT(wm8750_dev),
                              "wm8750", NULL);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_mmio_map(s, 0, MP_AUDIO_BASE);
     sysbus_connect_irq(s, 0, pic[MP_AUDIO_IRQ]);
 
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index 6bd8e4e197..79e19392b5 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -36,7 +36,7 @@ static void netduino2_init(MachineState *machine)
 
     dev = qdev_new(TYPE_STM32F205_SOC);
     qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m3"));
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
                        FLASH_SIZE);
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index 8d4b3d7c43..958d21dd9f 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -36,7 +36,7 @@ static void netduinoplus2_init(MachineState *machine)
 
     dev = qdev_new(TYPE_STM32F405_SOC);
     qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     armv7m_load_kernel(ARM_CPU(first_cpu),
                        machine->kernel_filename,
diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 856fa565a4..02678dda2d 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -185,7 +185,7 @@ static void n8x0_nand_setup(struct n800_s *s)
         qdev_prop_set_drive(s->nand, "drive", blk_by_legacy_dinfo(dinfo),
                             &error_fatal);
     }
-    qdev_realize_and_unref(s->nand, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s->nand), &error_fatal);
     sysbus_connect_irq(SYS_BUS_DEVICE(s->nand), 0,
                        qdev_get_gpio_in(s->mpu->gpio, N8X0_ONENAND_GPIO));
     omap_gpmc_attach(s->mpu->gpmc, N8X0_ONENAND_CS,
@@ -804,7 +804,7 @@ static void n8x0_usb_setup(struct n800_s *s)
     SysBusDevice *dev;
     s->usb = qdev_new("tusb6010");
     dev = SYS_BUS_DEVICE(s->usb);
-    qdev_realize_and_unref(s->usb, NULL, &error_fatal);
+    sysbus_realize_and_unref(dev, &error_fatal);
     sysbus_connect_irq(dev, 0,
                        qdev_get_gpio_in(s->mpu->gpio, N8X0_TUSB_INT_GPIO));
     /* Using the NOR interface */
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index c11d6da9d5..6ba0df6b6d 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -3890,8 +3890,8 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
     s->ih[0] = qdev_new("omap-intc");
     qdev_prop_set_uint32(s->ih[0], "size", 0x100);
     omap_intc_set_iclk(OMAP_INTC(s->ih[0]), omap_findclk(s, "arminth_ck"));
-    qdev_realize_and_unref(s->ih[0], NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(s->ih[0]);
+    sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_connect_irq(busdev, 0,
                        qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_IRQ));
     sysbus_connect_irq(busdev, 1,
@@ -3900,8 +3900,8 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
     s->ih[1] = qdev_new("omap-intc");
     qdev_prop_set_uint32(s->ih[1], "size", 0x800);
     omap_intc_set_iclk(OMAP_INTC(s->ih[1]), omap_findclk(s, "arminth_ck"));
-    qdev_realize_and_unref(s->ih[1], NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(s->ih[1]);
+    sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_connect_irq(busdev, 0,
                        qdev_get_gpio_in(s->ih[0], OMAP_INT_15XX_IH2_IRQ));
     /* The second interrupt controller's FIQ output is not wired up */
@@ -4013,7 +4013,7 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
     s->gpio = qdev_new("omap-gpio");
     qdev_prop_set_int32(s->gpio, "mpu_model", s->mpu_model);
     omap_gpio_set_clk(OMAP1_GPIO(s->gpio), omap_findclk(s, "arm_gpio_ck"));
-    qdev_realize_and_unref(s->gpio, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s->gpio), &error_fatal);
     sysbus_connect_irq(SYS_BUS_DEVICE(s->gpio), 0,
                        qdev_get_gpio_in(s->ih[0], OMAP_INT_GPIO_BANK1));
     sysbus_mmio_map(SYS_BUS_DEVICE(s->gpio), 0, 0xfffce000);
@@ -4031,8 +4031,8 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
     s->i2c[0] = qdev_new("omap_i2c");
     qdev_prop_set_uint8(s->i2c[0], "revision", 0x11);
     omap_i2c_set_fclk(OMAP_I2C(s->i2c[0]), omap_findclk(s, "mpuper_ck"));
-    qdev_realize_and_unref(s->i2c[0], NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(s->i2c[0]);
+    sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(s->ih[1], OMAP_INT_I2C));
     sysbus_connect_irq(busdev, 1, s->drq[OMAP_DMA_I2C_TX]);
     sysbus_connect_irq(busdev, 2, s->drq[OMAP_DMA_I2C_RX]);
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index b45ed5c9ec..16d388fc79 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -2310,8 +2310,8 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sdram,
     qdev_prop_set_uint8(s->ih[0], "revision", 0x21);
     omap_intc_set_fclk(OMAP_INTC(s->ih[0]), omap_findclk(s, "mpu_intc_fclk"));
     omap_intc_set_iclk(OMAP_INTC(s->ih[0]), omap_findclk(s, "mpu_intc_iclk"));
-    qdev_realize_and_unref(s->ih[0], NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(s->ih[0]);
+    sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_connect_irq(busdev, 0,
                        qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_IRQ));
     sysbus_connect_irq(busdev, 1,
@@ -2427,8 +2427,8 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sdram,
     qdev_prop_set_uint8(s->i2c[0], "revision", 0x34);
     omap_i2c_set_iclk(OMAP_I2C(s->i2c[0]), omap_findclk(s, "i2c1.iclk"));
     omap_i2c_set_fclk(OMAP_I2C(s->i2c[0]), omap_findclk(s, "i2c1.fclk"));
-    qdev_realize_and_unref(s->i2c[0], NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(s->i2c[0]);
+    sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_connect_irq(busdev, 0,
                        qdev_get_gpio_in(s->ih[0], OMAP_INT_24XX_I2C1_IRQ));
     sysbus_connect_irq(busdev, 1, s->drq[OMAP24XX_DMA_I2C1_TX]);
@@ -2439,8 +2439,8 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sdram,
     qdev_prop_set_uint8(s->i2c[1], "revision", 0x34);
     omap_i2c_set_iclk(OMAP_I2C(s->i2c[1]), omap_findclk(s, "i2c2.iclk"));
     omap_i2c_set_fclk(OMAP_I2C(s->i2c[1]), omap_findclk(s, "i2c2.fclk"));
-    qdev_realize_and_unref(s->i2c[1], NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(s->i2c[1]);
+    sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_connect_irq(busdev, 0,
                        qdev_get_gpio_in(s->ih[0], OMAP_INT_24XX_I2C2_IRQ));
     sysbus_connect_irq(busdev, 1, s->drq[OMAP24XX_DMA_I2C2_TX]);
@@ -2458,8 +2458,8 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sdram,
         omap2_gpio_set_fclk(OMAP2_GPIO(s->gpio), 4,
                             omap_findclk(s, "gpio5_dbclk"));
     }
-    qdev_realize_and_unref(s->gpio, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(s->gpio);
+    sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_connect_irq(busdev, 0,
                        qdev_get_gpio_in(s->ih[0], OMAP_INT_24XX_GPIO_BANK1));
     sysbus_connect_irq(busdev, 3,
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 8d8b06d920..beaedaae10 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -1489,9 +1489,9 @@ PXA2xxI2CState *pxa2xx_i2c_init(hwaddr base,
     dev = qdev_new(TYPE_PXA2XX_I2C);
     qdev_prop_set_uint32(dev, "size", region_size + 1);
     qdev_prop_set_uint32(dev, "offset", base & region_size);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     i2c_dev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(i2c_dev, &error_fatal);
     sysbus_mmio_map(i2c_dev, 0, base & ~region_size);
     sysbus_connect_irq(i2c_dev, 0, irq);
 
@@ -2043,8 +2043,8 @@ static PXA2xxFIrState *pxa2xx_fir_init(MemoryRegion *sysmem,
 
     dev = qdev_new(TYPE_PXA2XX_FIR);
     qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sbd = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(sbd, &error_fatal);
     sysbus_mmio_map(sbd, 0, base);
     sysbus_connect_irq(sbd, 0, irq);
     sysbus_connect_irq(sbd, 1, rx_dma);
diff --git a/hw/arm/pxa2xx_gpio.c b/hw/arm/pxa2xx_gpio.c
index 27199af43c..d6d0d0b08e 100644
--- a/hw/arm/pxa2xx_gpio.c
+++ b/hw/arm/pxa2xx_gpio.c
@@ -273,7 +273,7 @@ DeviceState *pxa2xx_gpio_init(hwaddr base,
     dev = qdev_new(TYPE_PXA2XX_GPIO);
     qdev_prop_set_int32(dev, "lines", lines);
     qdev_prop_set_int32(dev, "ncpu", cs->cpu_index);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
diff --git a/hw/arm/pxa2xx_pic.c b/hw/arm/pxa2xx_pic.c
index 4c451cf540..105c5e63f2 100644
--- a/hw/arm/pxa2xx_pic.c
+++ b/hw/arm/pxa2xx_pic.c
@@ -280,7 +280,7 @@ DeviceState *pxa2xx_pic_init(hwaddr base, ARMCPU *cpu)
     s->is_fiq[0] = 0;
     s->is_fiq[1] = 0;
 
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     qdev_init_gpio_in(dev, pxa2xx_pic_set_irq, PXA2XX_PIC_SRCS);
 
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 128146448c..aee7989037 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -164,14 +164,14 @@ static void realview_init(MachineState *machine,
     sysctl = qdev_new("realview_sysctl");
     qdev_prop_set_uint32(sysctl, "sys_id", sys_id);
     qdev_prop_set_uint32(sysctl, "proc_id", proc_id);
-    qdev_realize_and_unref(sysctl, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(sysctl), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(sysctl), 0, 0x10000000);
 
     if (is_mpcore) {
         dev = qdev_new(is_pb ? TYPE_A9MPCORE_PRIV : "realview_mpcore");
         qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
         busdev = SYS_BUS_DEVICE(dev);
+        sysbus_realize_and_unref(busdev, &error_fatal);
         sysbus_mmio_map(busdev, 0, periphbase);
         for (n = 0; n < smp_cpus; n++) {
             sysbus_connect_irq(busdev, n, cpu_irq[n]);
@@ -190,7 +190,7 @@ static void realview_init(MachineState *machine,
 
     pl041 = qdev_new("pl041");
     qdev_prop_set_uint32(pl041, "nc_fifo_depth", 512);
-    qdev_realize_and_unref(pl041, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(pl041), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(pl041), 0, 0x10004000);
     sysbus_connect_irq(SYS_BUS_DEVICE(pl041), 0, pic[19]);
 
@@ -206,8 +206,8 @@ static void realview_init(MachineState *machine,
     dev = qdev_new("pl081");
     object_property_set_link(OBJECT(dev), OBJECT(sysmem), "downstream",
                              &error_fatal);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0x10030000);
     sysbus_connect_irq(busdev, 0, pic[24]);
 
@@ -241,7 +241,7 @@ static void realview_init(MachineState *machine,
     if (!is_pb) {
         dev = qdev_new("realview_pci");
         busdev = SYS_BUS_DEVICE(dev);
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
+        sysbus_realize_and_unref(busdev, &error_fatal);
         sysbus_mmio_map(busdev, 0, 0x10019000); /* PCI controller registers */
         sysbus_mmio_map(busdev, 1, 0x60000000); /* PCI self-config */
         sysbus_mmio_map(busdev, 2, 0x61000000); /* PCI config */
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index fe24567333..3fd3536796 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -243,7 +243,7 @@ static void sbsa_flash_map1(PFlashCFI01 *flash,
     assert(QEMU_IS_ALIGNED(size, SBSA_FLASH_SECTOR_SIZE));
     assert(size / SBSA_FLASH_SECTOR_SIZE <= UINT32_MAX);
     qdev_prop_set_uint32(dev, "num-blocks", size / SBSA_FLASH_SECTOR_SIZE);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     memory_region_add_subregion(sysmem, base,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
@@ -356,8 +356,8 @@ static void create_gic(SBSAMachineState *sms)
     qdev_prop_set_uint32(sms->gic, "len-redist-region-count", 1);
     qdev_prop_set_uint32(sms->gic, "redist-region-count[0]", redist0_count);
 
-    qdev_realize_and_unref(sms->gic, NULL, &error_fatal);
     gicbusdev = SYS_BUS_DEVICE(sms->gic);
+    sysbus_realize_and_unref(gicbusdev, &error_fatal);
     sysbus_mmio_map(gicbusdev, 0, sbsa_ref_memmap[SBSA_GIC_DIST].base);
     sysbus_mmio_map(gicbusdev, 1, sbsa_ref_memmap[SBSA_GIC_REDIST].base);
 
@@ -413,7 +413,7 @@ static void create_uart(const SBSAMachineState *sms, int uart,
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
 
     qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     memory_region_add_subregion(mem, base,
                                 sysbus_mmio_get_region(s, 0));
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(sms->gic, irq));
@@ -466,7 +466,7 @@ static void create_ahci(const SBSAMachineState *sms)
 
     dev = qdev_new("sysbus-ahci");
     qdev_prop_set_uint32(dev, "num-ports", NUM_SATA_PORTS);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(sms->gic, irq));
 
@@ -501,7 +501,7 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
 
     object_property_set_link(OBJECT(dev), OBJECT(bus), "primary-bus",
                              &error_abort);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < NUM_SMMU_IRQS; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
@@ -526,7 +526,7 @@ static void create_pcie(SBSAMachineState *sms)
     int i;
 
     dev = qdev_new(TYPE_GPEX_HOST);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* Map ECAM space */
     ecam_alias = g_new0(MemoryRegion, 1);
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index edae6bf8be..fc18212e68 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -163,7 +163,7 @@ static void sl_flash_register(PXA2xxState *cpu, int size)
     else if (size == FLASH_1024M)
         qdev_prop_set_uint8(dev, "chip_id", 0xf1);
 
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, FLASH_BASE);
 }
 
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index f824cbd498..97ef566c12 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1315,7 +1315,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     object_property_set_link(OBJECT(nvic), OBJECT(get_system_memory()),
                                      "memory", &error_abort);
     /* This will exit with an error if the user passed us a bad cpu_type */
-    qdev_realize_and_unref(nvic, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(nvic), &error_fatal);
 
     qdev_connect_gpio_out_named(nvic, "SYSRESETREQ", 0,
                                 qemu_allocate_irq(&do_sys_reset, NULL, 0));
@@ -1353,7 +1353,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
         uint32_t mainclk = NANOSECONDS_PER_SECOND / system_clock_scale;
         qdev_prop_set_uint32(dev, "wdogclk-frq", mainclk);
 
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev),
                         0,
                         0x40000000u);
@@ -1427,7 +1427,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
 
         enet = qdev_new("stellaris_enet");
         qdev_set_nic_properties(enet, &nd_table[0]);
-        qdev_realize_and_unref(enet, NULL, &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(enet), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(enet), 0, 0x40048000);
         sysbus_connect_irq(SYS_BUS_DEVICE(enet), 0, qdev_get_gpio_in(nvic, 42));
     }
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 108ed8d147..2639b9ae55 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -646,7 +646,7 @@ static DeviceState *strongarm_gpio_init(hwaddr base,
     int i;
 
     dev = qdev_new(TYPE_STRONGARM_GPIO);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < 12; i++)
@@ -1629,7 +1629,7 @@ StrongARMState *sa1110_init(const char *cpu_type)
     for (i = 0; sa_serial[i].io_base; i++) {
         DeviceState *dev = qdev_new(TYPE_STRONGARM_UART);
         qdev_prop_set_chr(dev, "chardev", serial_hd(i));
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0,
                 sa_serial[i].io_base);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 154fa72f33..29e3bc6bd0 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -226,7 +226,7 @@ static void versatile_init(MachineState *machine, int board_id)
     sysctl = qdev_new("realview_sysctl");
     qdev_prop_set_uint32(sysctl, "sys_id", 0x41007004);
     qdev_prop_set_uint32(sysctl, "proc_id", 0x02000000);
-    qdev_realize_and_unref(sysctl, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(sysctl), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(sysctl), 0, 0x10000000);
 
     dev = sysbus_create_varargs("pl190", 0x10140000,
@@ -247,7 +247,7 @@ static void versatile_init(MachineState *machine, int board_id)
 
     dev = qdev_new("versatile_pci");
     busdev = SYS_BUS_DEVICE(dev);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0x10001000); /* PCI controller regs */
     sysbus_mmio_map(busdev, 1, 0x41000000); /* PCI self-config */
     sysbus_mmio_map(busdev, 2, 0x42000000); /* PCI config */
@@ -289,8 +289,8 @@ static void versatile_init(MachineState *machine, int board_id)
     dev = qdev_new("pl080");
     object_property_set_link(OBJECT(dev), OBJECT(sysmem), "downstream",
                              &error_fatal);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0x10130000);
     sysbus_connect_irq(busdev, 0, pic[17]);
 
@@ -321,7 +321,7 @@ static void versatile_init(MachineState *machine, int board_id)
     /* Add PL041 AACI Interface to the LM4549 codec */
     pl041 = qdev_new("pl041");
     qdev_prop_set_uint32(pl041, "nc_fifo_depth", 512);
-    qdev_realize_and_unref(pl041, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(pl041), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(pl041), 0, 0x10004000);
     sysbus_connect_irq(SYS_BUS_DEVICE(pl041), 0, sic[24]);
 
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index ef29e9f5ae..bebb0ed5a4 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -238,8 +238,8 @@ static void init_cpus(MachineState *ms, const char *cpu_type,
      */
     dev = qdev_new(privdev);
     qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, periphbase);
 
     /* Interrupts [42:0] are from the motherboard;
@@ -532,7 +532,7 @@ static PFlashCFI01 *ve_pflash_cfi01_register(hwaddr base, const char *name,
     qdev_prop_set_uint16(dev, "id2", 0x00);
     qdev_prop_set_uint16(dev, "id3", 0x00);
     qdev_prop_set_string(dev, "name", name);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     return PFLASH_CFI01(dev);
@@ -610,7 +610,7 @@ static void vexpress_common_init(MachineState *machine)
         qdev_prop_set_uint32(sysctl, propname, daughterboard->clocks[i]);
         g_free(propname);
     }
-    qdev_realize_and_unref(sysctl, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(sysctl), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(sysctl), 0, map[VE_SYSREGS]);
 
     /* VE_SP810: not modelled */
@@ -618,7 +618,7 @@ static void vexpress_common_init(MachineState *machine)
 
     pl041 = qdev_new("pl041");
     qdev_prop_set_uint32(pl041, "nc_fifo_depth", 512);
-    qdev_realize_and_unref(pl041, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(pl041), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(pl041), 0, map[VE_PL041]);
     sysbus_connect_irq(SYS_BUS_DEVICE(pl041), 0, pic[11]);
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ca151435ae..c3e80bcbce 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -579,7 +579,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, vms->memmap[VIRT_PCDIMM_ACPI].base);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(vms->gic, irq));
 
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     return dev;
 }
@@ -598,7 +598,7 @@ static void create_its(VirtMachineState *vms)
 
     object_property_set_link(OBJECT(dev), OBJECT(vms->gic), "parent-gicv3",
                              &error_abort);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_GIC_ITS].base);
 
     fdt_add_its_gic_node(vms);
@@ -614,7 +614,7 @@ static void create_v2m(VirtMachineState *vms)
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_GIC_V2M].base);
     qdev_prop_set_uint32(dev, "base-spi", irq);
     qdev_prop_set_uint32(dev, "num-spi", NUM_GICV2M_SPIS);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     for (i = 0; i < NUM_GICV2M_SPIS; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
@@ -671,8 +671,8 @@ static void create_gic(VirtMachineState *vms)
                               vms->virt);
         }
     }
-    qdev_realize_and_unref(vms->gic, NULL, &error_fatal);
     gicbusdev = SYS_BUS_DEVICE(vms->gic);
+    sysbus_realize_and_unref(gicbusdev, &error_fatal);
     sysbus_mmio_map(gicbusdev, 0, vms->memmap[VIRT_GIC_DIST].base);
     if (type == 3) {
         sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_REDIST].base);
@@ -758,7 +758,7 @@ static void create_uart(const VirtMachineState *vms, int uart,
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
 
     qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     memory_region_add_subregion(mem, base,
                                 sysbus_mmio_get_region(s, 0));
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
@@ -980,7 +980,7 @@ static void virt_flash_map1(PFlashCFI01 *flash,
     assert(QEMU_IS_ALIGNED(size, VIRT_FLASH_SECTOR_SIZE));
     assert(size / VIRT_FLASH_SECTOR_SIZE <= UINT32_MAX);
     qdev_prop_set_uint32(dev, "num-blocks", size / VIRT_FLASH_SECTOR_SIZE);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     memory_region_add_subregion(sysmem, base,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
@@ -1177,7 +1177,7 @@ static void create_smmu(const VirtMachineState *vms,
 
     object_property_set_link(OBJECT(dev), OBJECT(bus), "primary-bus",
                              &error_abort);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < NUM_SMMU_IRQS; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
@@ -1254,7 +1254,7 @@ static void create_pcie(VirtMachineState *vms)
     PCIHostState *pci;
 
     dev = qdev_new(TYPE_GPEX_HOST);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     ecam_id = VIRT_ECAM_ID(vms->highmem_ecam);
     base_ecam = vms->memmap[ecam_id].base;
@@ -1376,7 +1376,7 @@ static void create_platform_bus(VirtMachineState *vms)
     dev->id = TYPE_PLATFORM_BUS_DEVICE;
     qdev_prop_set_uint32(dev, "num_irqs", PLATFORM_BUS_NUM_IRQS);
     qdev_prop_set_uint32(dev, "mmio_size", vms->memmap[VIRT_PLATFORM_BUS].size);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     vms->platform_bus_dev = dev;
 
     s = SYS_BUS_DEVICE(dev);
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 0e0f0976c4..69d62ee24b 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -119,8 +119,8 @@ static void gem_init(NICInfo *nd, uint32_t base, qemu_irq irq)
         qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
         qdev_set_nic_properties(dev, nd);
     }
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_mmio_map(s, 0, base);
     sysbus_connect_irq(s, 0, irq);
 }
@@ -140,8 +140,8 @@ static inline void zynq_init_spi_flashes(uint32_t base_addr, qemu_irq irq,
     qdev_prop_set_uint8(dev, "num-txrx-bytes", is_qspi ? 4 : 1);
     qdev_prop_set_uint8(dev, "num-ss-bits", num_ss);
     qdev_prop_set_uint8(dev, "num-busses", num_busses);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, base_addr);
     if (is_qspi) {
         sysbus_mmio_map(busdev, 1, 0xFC000000);
@@ -223,7 +223,7 @@ static void zynq_init(MachineState *machine)
 
     /* Create slcr, keep a pointer to connect clocks */
     slcr = qdev_new("xilinx,zynq_slcr");
-    qdev_realize_and_unref(slcr, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(slcr), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);
 
     /* Create the main clock source, and feed slcr with it */
@@ -236,8 +236,8 @@ static void zynq_init(MachineState *machine)
 
     dev = qdev_new(TYPE_A9MPCORE_PRIV);
     qdev_prop_set_uint32(dev, "num-cpu", 1);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
     sysbus_connect_irq(busdev, 0,
                        qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_IRQ));
@@ -283,7 +283,7 @@ static void zynq_init(MachineState *machine)
         dev = qdev_new(TYPE_SYSBUS_SDHCI);
         qdev_prop_set_uint8(dev, "sd-spec-version", 2);
         qdev_prop_set_uint64(dev, "capareg", ZYNQ_SDHCI_CAPABILITIES);
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, hci_addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[hci_irq - IRQ_OFFSET]);
 
@@ -296,7 +296,7 @@ static void zynq_init(MachineState *machine)
     }
 
     dev = qdev_new(TYPE_ZYNQ_XADC);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xF8007100);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[39-IRQ_OFFSET]);
 
@@ -312,8 +312,8 @@ static void zynq_init(MachineState *machine)
     qdev_prop_set_uint8(dev, "rd_q_dep",  16);
     qdev_prop_set_uint16(dev, "data_buffer_dep",  256);
 
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0xF8003000);
     sysbus_connect_irq(busdev, 0, pic[45-IRQ_OFFSET]); /* abort irq line */
     for (n = 0; n < ARRAY_SIZE(dma_irqs); ++n) { /* event irqs */
@@ -321,8 +321,8 @@ static void zynq_init(MachineState *machine)
     }
 
     dev = qdev_new("xlnx.ps7-dev-cfg");
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_connect_irq(busdev, 0, pic[40 - IRQ_OFFSET]);
     sysbus_mmio_map(busdev, 0, 0xF8007000);
 
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index fb37b235fe..3d8431dbcf 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -434,7 +434,7 @@ static void create_virtio_regions(VersalVirt *s)
         pic_irq = qdev_get_gpio_in(DEVICE(&s->soc.fpd.apu.gic), irq);
         dev = qdev_new("virtio-mmio");
         object_property_add_child(OBJECT(&s->soc), name, OBJECT(dev));
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic_irq);
         mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
         memory_region_add_subregion(&s->soc.mr_ps, base, mr);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 12e4469cf4..38d6b91d15 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -309,7 +309,7 @@ static void versal_unimp_area(Versal *s, const char *name,
     qdev_prop_set_string(dev, "name", name);
     qdev_prop_set_uint64(dev, "size", size);
     object_property_add_child(OBJECT(s), name, OBJECT(dev));
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     mr_dev = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
     memory_region_add_subregion(mr, base, mr_dev);
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index a3250f6fdb..8528b9a3c7 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2583,8 +2583,8 @@ void fdctrl_init_sysbus(qemu_irq irq, int dma_chann,
         qdev_prop_set_drive(dev, "driveB", blk_by_legacy_dinfo(fds[1]),
                             &error_fatal);
     }
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sbd = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(sbd, &error_fatal);
     sysbus_connect_irq(sbd, 0, irq);
     sysbus_mmio_map(sbd, 0, mmio_base);
 }
@@ -2600,7 +2600,7 @@ void sun4m_fdctrl_init(qemu_irq irq, hwaddr io_base,
         qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(fds[0]),
                             &error_fatal);
     }
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sys = SYSBUS_FDC(dev);
     sysbus_connect_irq(SYS_BUS_DEVICE(sys), 0, irq);
     sysbus_mmio_map(SYS_BUS_DEVICE(sys), 0, io_base);
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index d2a647d2b8..9f0c1d61ca 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -974,7 +974,7 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
     qdev_prop_set_uint16(dev, "id2", id2);
     qdev_prop_set_uint16(dev, "id3", id3);
     qdev_prop_set_string(dev, "name", name);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     return PFLASH_CFI01(dev);
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index ed9e9eef0c..6eb66e7bb0 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -1016,7 +1016,7 @@ PFlashCFI02 *pflash_cfi02_register(hwaddr base,
     qdev_prop_set_uint16(dev, "unlock-addr0", unlock_addr0);
     qdev_prop_set_uint16(dev, "unlock-addr1", unlock_addr1);
     qdev_prop_set_string(dev, "name", name);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     return PFLASH_CFI02(dev);
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index b86bd7b2e6..9c8ab3a77d 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -661,7 +661,7 @@ DeviceState *exynos4210_uart_create(hwaddr addr,
     qdev_prop_set_uint32(dev, "tx-size", fifo_size);
 
     bus = SYS_BUS_DEVICE(dev);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(bus, &error_fatal);
     if (addr != (hwaddr)-1) {
         sysbus_mmio_map(bus, 0, addr);
     }
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index 2ac0a195f3..8d1b7f2bca 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -348,7 +348,7 @@ void *mcf_uart_init(qemu_irq irq, Chardev *chrdrv)
     if (chrdrv) {
         qdev_prop_set_chr(dev, "chardev", chrdrv);
     }
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
 
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 57c299e993..4582d488d0 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1134,7 +1134,7 @@ SerialMM *serial_mm_init(MemoryRegion *address_space,
     qdev_prop_set_chr(DEVICE(smm), "chardev", chr);
     qdev_set_legacy_instance_id(DEVICE(smm), base, 2);
     qdev_prop_set_uint8(DEVICE(smm), "endianness", end);
-    qdev_realize_and_unref(DEVICE(smm), NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(smm), &error_fatal);
 
     sysbus_connect_irq(SYS_BUS_DEVICE(smm), 0, irq);
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(smm), 0);
diff --git a/hw/core/empty_slot.c b/hw/core/empty_slot.c
index 725e5fd998..d0bdd01b9d 100644
--- a/hw/core/empty_slot.c
+++ b/hw/core/empty_slot.c
@@ -66,7 +66,7 @@ void empty_slot_init(hwaddr addr, uint64_t slot_size)
         e = EMPTY_SLOT(dev);
         e->size = slot_size;
 
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
+        sysbus_realize_and_unref(s, &error_fatal);
 
         sysbus_mmio_map(s, 0, addr);
     }
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 68b837ac85..1220298e8f 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -232,7 +232,7 @@ DeviceState *sysbus_create_varargs(const char *name,
 
     dev = qdev_new(name);
     s = SYS_BUS_DEVICE(dev);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(s, &error_fatal);
     if (addr != (hwaddr)-1) {
         sysbus_mmio_map(s, 0, addr);
     }
diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
index 5db667d518..dab7423c73 100644
--- a/hw/cris/axis_dev88.c
+++ b/hw/cris/axis_dev88.c
@@ -290,8 +290,8 @@ void axisdev88_init(MachineState *machine)
 
 
     dev = qdev_new("etraxfs,pic");
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_mmio_map(s, 0, 0x3001c000);
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(DEVICE(cpu), CRIS_CPU_IRQ));
     sysbus_connect_irq(s, 1, qdev_get_gpio_in(DEVICE(cpu), CRIS_CPU_NMI));
diff --git a/hw/display/milkymist-tmu2.c b/hw/display/milkymist-tmu2.c
index e54fd85777..c34ef1a1bf 100644
--- a/hw/display/milkymist-tmu2.c
+++ b/hw/display/milkymist-tmu2.c
@@ -544,7 +544,7 @@ DeviceState *milkymist_tmu2_create(hwaddr base, qemu_irq irq)
     XCloseDisplay(d);
 
     dev = qdev_new(TYPE_MILKYMIST_TMU2);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
 
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 6d1e314a0a..1dadfca5c0 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1954,7 +1954,7 @@ static void sm501_realize_sysbus(DeviceState *dev, Error **errp)
     usb_dev = qdev_new("sysbus-ohci");
     qdev_prop_set_uint32(usb_dev, "num-ports", 2);
     qdev_prop_set_uint64(usb_dev, "dma-offset", s->base);
-    qdev_realize_and_unref(usb_dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(usb_dev), &error_fatal);
     memory_region_add_subregion(&s->state.mmio_region, SM501_USB_HOST,
                        sysbus_mmio_get_region(SYS_BUS_DEVICE(usb_dev), 0));
     sysbus_pass_irq(sbd, SYS_BUS_DEVICE(usb_dev));
diff --git a/hw/dma/pxa2xx_dma.c b/hw/dma/pxa2xx_dma.c
index 6b761af701..78b2849bcb 100644
--- a/hw/dma/pxa2xx_dma.c
+++ b/hw/dma/pxa2xx_dma.c
@@ -497,7 +497,7 @@ DeviceState *pxa27x_dma_init(hwaddr base, qemu_irq irq)
 
     dev = qdev_new("pxa2xx-dma");
     qdev_prop_set_int32(dev, "channels", PXA27X_DMA_NUM_CHANNELS);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
@@ -511,7 +511,7 @@ DeviceState *pxa255_dma_init(hwaddr base, qemu_irq irq)
 
     dev = qdev_new("pxa2xx-dma");
     qdev_prop_set_int32(dev, "channels", PXA27X_DMA_NUM_CHANNELS);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index 21c9706bf3..7eddc9a776 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -746,7 +746,7 @@ DeviceState *rc4030_init(rc4030_dma **dmas, IOMMUMemoryRegion **dma_mr)
     DeviceState *dev;
 
     dev = qdev_new(TYPE_RC4030);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     *dmas = rc4030_allocate_dmas(dev, 4);
     *dma_mr = &RC4030(dev)->dma_mr;
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 77cf41e591..f02aca6f40 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -310,7 +310,7 @@ static void sparc32_espdma_device_realize(DeviceState *dev, Error **errp)
     esp->dma_opaque = SPARC32_DMA_DEVICE(dev);
     sysbus->it_shift = 2;
     esp->dma_enabled = 1;
-    qdev_realize_and_unref(d, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(d), &error_fatal);
 }
 
 static void sparc32_espdma_device_class_init(ObjectClass *klass, void *data)
@@ -347,7 +347,7 @@ static void sparc32_ledma_device_realize(DeviceState *dev, Error **errp)
     object_property_add_child(OBJECT(dev), "lance", OBJECT(d));
     qdev_set_nic_properties(d, nd);
     object_property_set_link(OBJECT(d), OBJECT(dev), "dma", errp);
-    qdev_realize_and_unref(d, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(d), &error_fatal);
 }
 
 static void sparc32_ledma_device_class_init(ObjectClass *klass, void *data)
@@ -381,7 +381,7 @@ static void sparc32_dma_realize(DeviceState *dev, Error **errp)
     espdma = qdev_new(TYPE_SPARC32_ESPDMA_DEVICE);
     object_property_set_link(OBJECT(espdma), iommu, "iommu", errp);
     object_property_add_child(OBJECT(s), "espdma", OBJECT(espdma));
-    qdev_realize_and_unref(espdma, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(espdma), &error_fatal);
 
     esp = DEVICE(object_resolve_path_component(OBJECT(espdma), "esp"));
     sbd = SYS_BUS_DEVICE(esp);
@@ -396,7 +396,7 @@ static void sparc32_dma_realize(DeviceState *dev, Error **errp)
     ledma = qdev_new(TYPE_SPARC32_LEDMA_DEVICE);
     object_property_set_link(OBJECT(ledma), iommu, "iommu", errp);
     object_property_add_child(OBJECT(s), "ledma", OBJECT(ledma));
-    qdev_realize_and_unref(ledma, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(ledma), &error_fatal);
 
     lance = DEVICE(object_resolve_path_component(OBJECT(ledma), "lance"));
     sbd = SYS_BUS_DEVICE(lance);
diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index 50ba26737b..533b39f8d2 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -548,7 +548,7 @@ PCIBus *dino_init(MemoryRegion *addr_space,
                               &s->pci_mem, get_system_io(),
                               PCI_DEVFN(0, 0), 32, TYPE_PCI_BUS);
     s->parent_obj.bus = b;
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* Set up windows into PCI bus memory.  */
     for (i = 1; i < 31; i++) {
diff --git a/hw/hppa/lasi.c b/hw/hppa/lasi.c
index 4539022c5b..19974034f3 100644
--- a/hw/hppa/lasi.c
+++ b/hw/hppa/lasi.c
@@ -309,7 +309,7 @@ DeviceState *lasi_init(MemoryRegion *address_space)
                           s, "lasi", 0x100000);
     memory_region_add_subregion(address_space, LASI_HPA, &s->this_mem);
 
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* LAN */
     if (enable_lasi_lan()) {
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index d828b4fb94..49155537cd 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -125,8 +125,8 @@ static void machine_hppa_init(MachineState *machine)
     /* Graphics setup. */
     if (machine->enable_graphics && vga_interface_type != VGA_NONE) {
         dev = qdev_new("artist");
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
         s = SYS_BUS_DEVICE(dev);
+        sysbus_realize_and_unref(s, &error_fatal);
         sysbus_mmio_map(s, 0, LASI_GFX_HPA);
         sysbus_mmio_map(s, 1, ARTIST_FB_ADDR);
     }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 280560f790..0cffb67c2f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1215,7 +1215,7 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
             if (!compat) {
                 qdev_prop_set_uint32(hpet, HPET_INTCAP, hpet_irqs);
             }
-            qdev_realize_and_unref(hpet, NULL, &error_fatal);
+            sysbus_realize_and_unref(SYS_BUS_DEVICE(hpet), &error_fatal);
             sysbus_mmio_map(SYS_BUS_DEVICE(hpet), 0, HPET_BASE);
 
             for (i = 0; i < GSI_NUM_PINS; i++) {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index af68ea1b69..b5775fc18d 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -228,7 +228,7 @@ static void pc_q35_init(MachineState *machine)
     object_property_set_int(OBJECT(q35_host), x86ms->above_4g_mem_size,
                             PCI_HOST_ABOVE_4G_MEM_SIZE, NULL);
     /* pci */
-    qdev_realize_and_unref(DEVICE(q35_host), NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(q35_host), &error_fatal);
     phb = PCI_HOST_BRIDGE(q35_host);
     host_bus = phb->bus;
     /* create ISA bus */
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 2e414d1934..ec2a3b3e7e 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -187,7 +187,7 @@ static void pc_system_flash_map(PCMachineState *pcms,
         total_size += size;
         qdev_prop_set_uint32(DEVICE(system_flash), "num-blocks",
                              size / FLASH_SECTOR_SIZE);
-        qdev_realize_and_unref(DEVICE(system_flash), NULL, &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(system_flash), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(system_flash), 0,
                         0x100000000ULL - total_size);
 
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 85ab52b316..9b6ebd92b5 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -351,8 +351,8 @@ void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name)
     }
     object_property_add_child(object_resolve_path(parent_name, NULL),
                               "ioapic", OBJECT(dev));
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     d = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(d, &error_fatal);
     sysbus_mmio_map(d, 0, IO_APIC_DEFAULT_ADDRESS);
 
     for (i = 0; i < IOAPIC_NUM_PINS; i++) {
diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
index a261ab2401..0aa3b843a9 100644
--- a/hw/intc/exynos4210_gic.c
+++ b/hw/intc/exynos4210_gic.c
@@ -300,8 +300,8 @@ static void exynos4210_gic_realize(DeviceState *dev, Error **errp)
     s->gic = qdev_new("arm_gic");
     qdev_prop_set_uint32(s->gic, "num-cpu", s->num_cpu);
     qdev_prop_set_uint32(s->gic, "num-irq", EXYNOS4210_GIC_NIRQ);
-    qdev_realize_and_unref(s->gic, NULL, &error_fatal);
     gicbusdev = SYS_BUS_DEVICE(s->gic);
+    sysbus_realize_and_unref(gicbusdev, &error_fatal);
 
     /* Pass through outbound IRQ lines from the GIC */
     sysbus_pass_irq(sbd, gicbusdev);
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index b2a247dd15..aacdb1bbc2 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -71,7 +71,7 @@ void s390_flic_init(void)
         object_property_add_child(qdev_get_machine(), TYPE_QEMU_S390_FLIC,
                                   OBJECT(dev));
     }
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 }
 
 static int qemu_s390_register_io_adapter(S390FLICState *fs, uint32_t id,
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 630985604d..58fde178f9 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -62,7 +62,7 @@ ISABus *isa_bus_new(DeviceState *dev, MemoryRegion* address_space,
     }
     if (!dev) {
         dev = qdev_new("isabus-bridge");
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     }
 
     isabus = ISA_BUS(qbus_create(TYPE_ISA_BUS, dev, NULL));
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 53020033cb..db732bc468 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -212,9 +212,9 @@ static void mcf_fec_init(MemoryRegion *sysmem, NICInfo *nd, hwaddr base,
     qemu_check_nic_model(nd, TYPE_MCF_FEC_NET);
     dev = qdev_new(TYPE_MCF_FEC_NET);
     qdev_set_nic_properties(dev, nd);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
     for (i = 0; i < FEC_NUM_IRQ; i++) {
         sysbus_connect_irq(s, i, irqs[i]);
     }
diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index c575021577..44418e9197 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -202,7 +202,7 @@ qemu_irq *mcf_intc_init(MemoryRegion *sysmem,
     mcf_intc_state *s;
 
     dev = qdev_new(TYPE_MCF_INTC);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     s = MCF_INTC(dev);
     s->cpu = cpu;
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index e1e16bf9af..d3f25cd6d7 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -848,9 +848,9 @@ static void next_escc_init(M68kCPU *cpu)
     qdev_prop_set_chr(dev, "chrA", serial_hd(0));
     qdev_prop_set_uint32(dev, "chnBtype", escc_serial);
     qdev_prop_set_uint32(dev, "chnAtype", escc_serial);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_connect_irq(s, 0, ser_irq[0]);
     sysbus_connect_irq(s, 1,  ser_irq[1]);
     sysbus_mmio_map(s, 0, 0x2118000);
@@ -896,7 +896,7 @@ static void next_cube_init(MachineState *machine)
 
     /* Framebuffer */
     dev = qdev_new(TYPE_NEXTFB);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x0B000000);
 
     /* MMIO */
@@ -919,7 +919,7 @@ static void next_cube_init(MachineState *machine)
 
     /* KBD */
     dev = qdev_new(TYPE_NEXTKBD);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x0200e000);
 
     /* Load ROM here */
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 15b7eb719a..503ec54f5d 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -224,8 +224,8 @@ static void q800_init(MachineState *machine)
         qdev_prop_set_drive(via_dev, "drive", blk_by_legacy_dinfo(dinfo),
                             &error_abort);
     }
-    qdev_realize_and_unref(via_dev, NULL, &error_fatal);
     sysbus = SYS_BUS_DEVICE(via_dev);
+    sysbus_realize_and_unref(sysbus, &error_fatal);
     sysbus_mmio_map(sysbus, 0, VIA_BASE);
     qdev_connect_gpio_out_named(DEVICE(sysbus), "irq", 0, pic[0]);
     qdev_connect_gpio_out_named(DEVICE(sysbus), "irq", 1, pic[1]);
@@ -265,8 +265,8 @@ static void q800_init(MachineState *machine)
     qdev_prop_set_bit(dev, "big_endian", true);
     object_property_set_link(OBJECT(dev), OBJECT(get_system_memory()),
                              "dma_mr", &error_abort);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(sysbus, &error_fatal);
     sysbus_mmio_map(sysbus, 0, SONIC_BASE);
     sysbus_mmio_map(sysbus, 1, SONIC_PROM_BASE);
     sysbus_connect_irq(sysbus, 0, pic[2]);
@@ -282,8 +282,8 @@ static void q800_init(MachineState *machine)
     qdev_prop_set_chr(dev, "chrB", serial_hd(1));
     qdev_prop_set_uint32(dev, "chnBtype", 0);
     qdev_prop_set_uint32(dev, "chnAtype", 0);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(sysbus, &error_fatal);
     sysbus_connect_irq(sysbus, 0, pic[3]);
     sysbus_connect_irq(sysbus, 1, pic[3]);
     sysbus_mmio_map(sysbus, 0, SCC_BASE);
@@ -298,9 +298,9 @@ static void q800_init(MachineState *machine)
     esp->dma_opaque = NULL;
     sysbus_esp->it_shift = 4;
     esp->dma_enabled = 1;
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     sysbus = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(sysbus, &error_fatal);
     sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in_named(via_dev,
                                                          "via2-irq",
                                                          VIA2_IRQ_SCSI_BIT));
@@ -315,13 +315,13 @@ static void q800_init(MachineState *machine)
     /* SWIM floppy controller */
 
     dev = qdev_new(TYPE_SWIM);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, SWIM_BASE);
 
     /* NuBus */
 
     dev = qdev_new(TYPE_MAC_NUBUS_BRIDGE);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, NUBUS_SUPER_SLOT_BASE);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, NUBUS_SLOT_BASE);
 
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index d4bfa233c9..4d80a691bc 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -112,7 +112,7 @@ petalogix_ml605_init(MachineState *machine)
 
     dev = qdev_new("xlnx.xps-intc");
     qdev_prop_set_uint32(dev, "kind-of-intr", 1 << TIMER_IRQ);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, INTC_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
                        qdev_get_gpio_in(DEVICE(cpu), MB_CPU_IRQ));
@@ -128,7 +128,7 @@ petalogix_ml605_init(MachineState *machine)
     dev = qdev_new("xlnx.xps-timer");
     qdev_prop_set_uint32(dev, "one-timer-only", 0);
     qdev_prop_set_uint32(dev, "clock-frequency", 100 * 1000000);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, TIMER_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
 
@@ -152,7 +152,7 @@ petalogix_ml605_init(MachineState *machine)
                              "axistream-connected", &error_abort);
     object_property_set_link(OBJECT(eth0), cs,
                              "axistream-control-connected", &error_abort);
-    qdev_realize_and_unref(eth0, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(eth0), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(eth0), 0, AXIENET_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(eth0), 0, irq[AXIENET_IRQ]);
 
@@ -165,7 +165,7 @@ petalogix_ml605_init(MachineState *machine)
                              "axistream-connected", &error_abort);
     object_property_set_link(OBJECT(dma), cs,
                              "axistream-control-connected", &error_abort);
-    qdev_realize_and_unref(dma, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, AXIDMA_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dma), 0, irq[AXIDMA_IRQ0]);
     sysbus_connect_irq(SYS_BUS_DEVICE(dma), 1, irq[AXIDMA_IRQ1]);
@@ -175,8 +175,8 @@ petalogix_ml605_init(MachineState *machine)
 
         dev = qdev_new("xlnx.xps-spi");
         qdev_prop_set_uint8(dev, "num-ss-bits", NUM_SPI_FLASHES);
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
         busdev = SYS_BUS_DEVICE(dev);
+        sysbus_realize_and_unref(busdev, &error_fatal);
         sysbus_mmio_map(busdev, 0, SPI_BASEADDR);
         sysbus_connect_irq(busdev, 0, irq[SPI_IRQ]);
 
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index aecee2f5f3..793006a822 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -92,7 +92,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
     dev = qdev_new("xlnx.xps-intc");
     qdev_prop_set_uint32(dev, "kind-of-intr",
                          1 << ETHLITE_IRQ | 1 << UARTLITE_IRQ);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, INTC_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
                        qdev_get_gpio_in(DEVICE(cpu), MB_CPU_IRQ));
@@ -107,7 +107,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
     dev = qdev_new("xlnx.xps-timer");
     qdev_prop_set_uint32(dev, "one-timer-only", 0);
     qdev_prop_set_uint32(dev, "clock-frequency", 62 * 1000000);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, TIMER_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
 
@@ -116,7 +116,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
     qdev_set_nic_properties(dev, &nd_table[0]);
     qdev_prop_set_uint32(dev, "tx-ping-pong", 0);
     qdev_prop_set_uint32(dev, "rx-ping-pong", 0);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ETHLITE_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[ETHLITE_IRQ]);
 
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index d90f3a463b..03008b5581 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -409,7 +409,7 @@ xilinx_pcie_init(MemoryRegion *sys_mem, uint32_t bus_nr,
     qdev_prop_set_uint64(dev, "mmio_size", mmio_size);
     qdev_prop_set_bit(dev, "link_up", link_up);
 
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     cfg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
     memory_region_add_subregion_overlap(sys_mem, cfg_base, cfg, 0);
@@ -442,7 +442,7 @@ static void boston_mach_init(MachineState *machine)
     }
 
     dev = qdev_new(TYPE_MIPS_BOSTON);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     s = BOSTON(dev);
     s->mach = machine;
diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index 37750b8037..756ac9ae12 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -1213,7 +1213,7 @@ PCIBus *gt64120_register(qemu_irq *pic)
                                      &d->pci0_mem,
                                      get_system_io(),
                                      PCI_DEVFN(18, 0), 4, TYPE_PCI_BUS);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     memory_region_init_io(&d->ISD_mem, OBJECT(dev), &isd_mem_ops, d,
                           "isd-mem", 0x1000);
 
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index fb975bd1c7..c3b0da60cc 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -256,8 +256,8 @@ static void mips_jazz_init(MachineState *machine,
     switch (jazz_model) {
     case JAZZ_MAGNUM:
         dev = qdev_new("sysbus-g364");
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
         sysbus = SYS_BUS_DEVICE(dev);
+        sysbus_realize_and_unref(sysbus, &error_fatal);
         sysbus_mmio_map(sysbus, 0, 0x60080000);
         sysbus_mmio_map(sysbus, 1, 0x40000000);
         sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(rc4030, 3));
@@ -292,8 +292,8 @@ static void mips_jazz_init(MachineState *machine,
             qdev_prop_set_uint8(dev, "it_shift", 2);
             object_property_set_link(OBJECT(dev), OBJECT(rc4030_dma_mr),
                                      "dma_mr", &error_abort);
-            qdev_realize_and_unref(dev, NULL, &error_fatal);
             sysbus = SYS_BUS_DEVICE(dev);
+            sysbus_realize_and_unref(sysbus, &error_fatal);
             sysbus_mmio_map(sysbus, 0, 0x80001000);
             sysbus_mmio_map(sysbus, 1, 0x8000b000);
             sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(rc4030, 4));
@@ -317,9 +317,9 @@ static void mips_jazz_init(MachineState *machine,
     sysbus_esp->it_shift = 0;
     /* XXX for now until rc4030 has been changed to use DMA enable signal */
     esp->dma_enabled = 1;
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     sysbus = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(sysbus, &error_fatal);
     sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(rc4030, 5));
     sysbus_mmio_map(sysbus, 0, 0x80002000);
 
@@ -363,8 +363,8 @@ static void mips_jazz_init(MachineState *machine,
 
     /* NVRAM */
     dev = qdev_new("ds1225y");
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sysbus = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(sysbus, &error_fatal);
     sysbus_mmio_map(sysbus, 0, 0x80009000);
 
     /* LED indicator */
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index be0b4d3195..5115adfa22 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1243,7 +1243,7 @@ void mips_malta_init(MachineState *machine)
      */
     empty_slot_init(0, 0x20000000);
 
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* create CPU */
     mips_create_cpu(machine, s, &cbus_irq, &i8259_irq);
diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index 72b1e846af..1b3b762203 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -131,9 +131,9 @@ static void mipsnet_init(int base, qemu_irq irq, NICInfo *nd)
 
     dev = qdev_new("mipsnet");
     qdev_set_nic_properties(dev, nd);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_connect_irq(s, 0, irq);
     memory_region_add_subregion(get_system_io(),
                                 base,
@@ -220,7 +220,7 @@ mips_mipssim_init(MachineState *machine)
 
         qdev_prop_set_chr(dev, "chardev", serial_hd(0));
         qdev_set_legacy_instance_id(dev, 0x3f8, 2);
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
         sysbus_add_io(SYS_BUS_DEVICE(dev), 0x3f8,
                       sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
diff --git a/hw/net/etraxfs_eth.c b/hw/net/etraxfs_eth.c
index 7e98cbda87..3408ceacb5 100644
--- a/hw/net/etraxfs_eth.c
+++ b/hw/net/etraxfs_eth.c
@@ -668,7 +668,7 @@ etraxfs_eth_init(NICInfo *nd, hwaddr base, int phyaddr,
      */
     ETRAX_FS_ETH(dev)->dma_out = dma_out;
     ETRAX_FS_ETH(dev)->dma_in = dma_in;
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
 
     return dev;
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index d0e9ff57ca..7035cf4eb9 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -455,7 +455,7 @@ DeviceState *etsec_create(hwaddr         base,
 
     dev = qdev_new("eTSEC");
     qdev_set_nic_properties(dev, nd);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, tx_irq);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1, rx_irq);
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 81c32c8107..8e2a432179 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -1397,8 +1397,8 @@ void lan9118_init(NICInfo *nd, uint32_t base, qemu_irq irq)
     qemu_check_nic_model(nd, "lan9118");
     dev = qdev_new(TYPE_LAN9118);
     qdev_set_nic_properties(dev, nd);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_mmio_map(s, 0, base);
     sysbus_connect_irq(s, 0, irq);
 }
diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
index 1870507727..820b63f350 100644
--- a/hw/net/lasi_i82596.c
+++ b/hw/net/lasi_i82596.c
@@ -131,7 +131,7 @@ SysBusI82596State *lasi_82596_init(MemoryRegion *addr_space,
     s = SYSBUS_I82596(dev);
     s->state.irq = lan_irq;
     qdev_set_nic_properties(dev, &nd_table[0]);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     s->state.conf.macaddr = HP_MAC; /* set HP MAC prefix */
 
     /* LASI 82596 ports in main memory. */
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 9b616fe62a..a347b6a4d5 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -824,8 +824,8 @@ void smc91c111_init(NICInfo *nd, uint32_t base, qemu_irq irq)
     qemu_check_nic_model(nd, "smc91c111");
     dev = qdev_new(TYPE_SMC91C111);
     qdev_set_nic_properties(dev, nd);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_mmio_map(s, 0, base);
     sysbus_connect_irq(s, 0, irq);
 }
diff --git a/hw/nios2/10m50_devboard.c b/hw/nios2/10m50_devboard.c
index 3d304d724a..5c13b74306 100644
--- a/hw/nios2/10m50_devboard.c
+++ b/hw/nios2/10m50_devboard.c
@@ -82,7 +82,7 @@ static void nios2_10m50_ghrd_init(MachineState *machine)
     /* Register: Internal Interrupt Controller (IIC) */
     dev = qdev_new("altera,iic");
     object_property_add_const_link(OBJECT(dev), "cpu", OBJECT(cpu));
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, cpu_irq[0]);
     for (i = 0; i < 32; i++) {
         irq[i] = qdev_get_gpio_in(dev, i);
@@ -95,14 +95,14 @@ static void nios2_10m50_ghrd_init(MachineState *machine)
     /* Register: Timer sys_clk_timer  */
     dev = qdev_new("ALTR.timer");
     qdev_prop_set_uint32(dev, "clock-frequency", 75 * 1000000);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xf8001440);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[0]);
 
     /* Register: Timer sys_clk_timer_1  */
     dev = qdev_new("ALTR.timer");
     qdev_prop_set_uint32(dev, "clock-frequency", 75 * 1000000);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xe0000880);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[5]);
 
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index fbcaf66002..0408a31f8e 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1106,9 +1106,9 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
 
     object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
                               OBJECT(dev));
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     sbd = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(sbd, &error_fatal);
     ios = FW_CFG_IO(dev);
     sysbus_add_io(sbd, iobase, &ios->comb_iomem);
 
@@ -1146,9 +1146,9 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
 
     object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
                               OBJECT(dev));
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     sbd = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(sbd, &error_fatal);
     sysbus_mmio_map(sbd, 0, ctl_addr);
     sysbus_mmio_map(sbd, 1, data_addr);
 
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 5c55c12b1d..29c107a7ca 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -61,9 +61,9 @@ static void openrisc_sim_net_init(hwaddr base, hwaddr descriptors,
 
     dev = qdev_new("open_eth");
     qdev_set_nic_properties(dev, nd);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
     for (i = 0; i < num_cpus; i++) {
         sysbus_connect_irq(s, 0, cpu_irqs[i][irq_pin]);
     }
@@ -80,9 +80,9 @@ static void openrisc_sim_ompic_init(hwaddr base, int num_cpus,
 
     dev = qdev_new("or1k-ompic");
     qdev_prop_set_uint32(dev, "num-cpus", num_cpus);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
     for (i = 0; i < num_cpus; i++) {
         sysbus_connect_irq(s, i, cpu_irqs[i][irq_pin]);
     }
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 3a395ab2f0..22f9fc223b 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -255,7 +255,7 @@ static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error **errp)
         goto err_register_bus;
     }
 
-    qdev_realize_and_unref(ds, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(ds), &error_fatal);
     if (bds) {
         qdev_realize_and_unref(bds, &bus->qbus, &error_fatal);
     }
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 7bb032f005..1405b3fc70 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -748,7 +748,7 @@ PCIBus *bonito_init(qemu_irq *pic)
     phb = PCI_HOST_BRIDGE(dev);
     pcihost = BONITO_PCI_HOST_BRIDGE(dev);
     pcihost->pic = pic;
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     d = pci_new(PCI_DEVFN(0, 0), TYPE_PCI_BONITO);
     s = PCI_BONITO(d);
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 873d334637..d47f03406a 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -276,7 +276,7 @@ PCIBus *i440fx_init(const char *host_type, const char *pci_type,
                          address_space_io, 0, TYPE_PCI_BUS);
     s->bus = b;
     object_property_add_child(qdev_get_machine(), "i440fx", OBJECT(dev));
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     d = pci_create_simple(b, 0, pci_type);
     *pi440fx_state = I440FX_PCI_DEVICE(d);
diff --git a/hw/pcmcia/pxa2xx.c b/hw/pcmcia/pxa2xx.c
index 90f540209d..5f4bf22a90 100644
--- a/hw/pcmcia/pxa2xx.c
+++ b/hw/pcmcia/pxa2xx.c
@@ -152,7 +152,7 @@ PXA2xxPCMCIAState *pxa2xx_pcmcia_init(MemoryRegion *sysmem,
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     s = PXA2XX_PCMCIA(dev);
 
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     return s;
 }
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 06f4a38266..51bf95b303 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -748,8 +748,8 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE500MachineState *pms,
     qdev_prop_set_uint32(dev, "model", pmc->mpic_version);
     qdev_prop_set_uint32(dev, "nb_cpus", smp_cpus);
 
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
 
     k = 0;
     for (i = 0; i < smp_cpus; i++) {
@@ -771,7 +771,7 @@ static DeviceState *ppce500_init_mpic_kvm(const PPCE500MachineClass *pmc,
     dev = qdev_new(TYPE_KVM_OPENPIC);
     qdev_prop_set_uint32(dev, "model", pmc->mpic_version);
 
-    qdev_realize_and_unref(dev, NULL, &err);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &err);
     if (err) {
         error_propagate(errp, err);
         object_unparent(OBJECT(dev));
@@ -916,7 +916,7 @@ void ppce500_init(MachineState *machine)
     dev = qdev_new("e500-ccsr");
     object_property_add_child(qdev_get_machine(), "e500-ccsr",
                               OBJECT(dev));
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     ccsr = CCSR(dev);
     ccsr_addr_space = &ccsr->ccsr_space;
     memory_region_add_subregion(address_space_mem, pmc->ccsrbar_base,
@@ -939,7 +939,7 @@ void ppce500_init(MachineState *machine)
         /* I2C */
     dev = qdev_new("mpc-i2c");
     s = SYS_BUS_DEVICE(dev);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, MPC8544_I2C_IRQ));
     memory_region_add_subregion(ccsr_addr_space, MPC8544_I2C_REGS_OFFSET,
                                 sysbus_mmio_get_region(s, 0));
@@ -949,8 +949,8 @@ void ppce500_init(MachineState *machine)
 
     /* General Utility device */
     dev = qdev_new("mpc8544-guts");
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
     memory_region_add_subregion(ccsr_addr_space, MPC8544_UTIL_OFFSET,
                                 sysbus_mmio_get_region(s, 0));
 
@@ -959,8 +959,8 @@ void ppce500_init(MachineState *machine)
     object_property_add_child(qdev_get_machine(), "pci-host", OBJECT(dev));
     qdev_prop_set_uint32(dev, "first_slot", pmc->pci_first_slot);
     qdev_prop_set_uint32(dev, "first_pin_irq", pci_irq_nrs[0]);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
     for (i = 0; i < PCI_NUM_PINS; i++) {
         sysbus_connect_irq(s, i, qdev_get_gpio_in(mpicdev, pci_irq_nrs[i]));
     }
@@ -987,7 +987,7 @@ void ppce500_init(MachineState *machine)
 
         dev = qdev_new("mpc8xxx_gpio");
         s = SYS_BUS_DEVICE(dev);
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
+        sysbus_realize_and_unref(s, &error_fatal);
         sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, MPC8XXX_GPIO_IRQ));
         memory_region_add_subregion(ccsr_addr_space, MPC8XXX_GPIO_OFFSET,
                                     sysbus_mmio_get_region(s, 0));
@@ -1003,7 +1003,7 @@ void ppce500_init(MachineState *machine)
         dev->id = TYPE_PLATFORM_BUS_DEVICE;
         qdev_prop_set_uint32(dev, "num_irqs", pmc->platform_bus_num_irqs);
         qdev_prop_set_uint32(dev, "mmio_size", pmc->platform_bus_size);
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         pms->pbus_dev = PLATFORM_BUS_DEVICE(dev);
 
         s = SYS_BUS_DEVICE(pms->pbus_dev);
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index baa17cdce7..5f3a028e6a 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -243,8 +243,8 @@ static void ppc_core99_init(MachineState *machine)
 
     /* UniN init */
     dev = qdev_new(TYPE_UNI_NORTH);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
     memory_region_add_subregion(get_system_memory(), 0xf8000000,
                                 sysbus_mmio_get_region(s, 0));
 
@@ -290,8 +290,8 @@ static void ppc_core99_init(MachineState *machine)
 
     pic_dev = qdev_new(TYPE_OPENPIC);
     qdev_prop_set_uint32(pic_dev, "model", OPENPIC_MODEL_KEYLARGO);
-    qdev_realize_and_unref(pic_dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(pic_dev);
+    sysbus_realize_and_unref(s, &error_fatal);
     k = 0;
     for (i = 0; i < smp_cpus; i++) {
         for (j = 0; j < OPENPIC_OUTPUT_NB; j++) {
@@ -306,7 +306,7 @@ static void ppc_core99_init(MachineState *machine)
         dev = qdev_new(TYPE_U3_AGP_HOST_BRIDGE);
         object_property_set_link(OBJECT(dev), OBJECT(pic_dev), "pic",
                                  &error_abort);
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         uninorth_pci = U3_AGP_HOST_BRIDGE(dev);
         s = SYS_BUS_DEVICE(dev);
         /* PCI hole */
@@ -325,8 +325,8 @@ static void ppc_core99_init(MachineState *machine)
         dev = qdev_new(TYPE_UNI_NORTH_AGP_HOST_BRIDGE);
         object_property_set_link(OBJECT(dev), OBJECT(pic_dev), "pic",
                                  &error_abort);
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
         s = SYS_BUS_DEVICE(dev);
+        sysbus_realize_and_unref(s, &error_fatal);
         sysbus_mmio_map(s, 0, 0xf0800000);
         sysbus_mmio_map(s, 1, 0xf0c00000);
 
@@ -334,8 +334,8 @@ static void ppc_core99_init(MachineState *machine)
         dev = qdev_new(TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE);
         object_property_set_link(OBJECT(dev), OBJECT(pic_dev), "pic",
                                  &error_abort);
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
         s = SYS_BUS_DEVICE(dev);
+        sysbus_realize_and_unref(s, &error_fatal);
         sysbus_mmio_map(s, 0, 0xf4800000);
         sysbus_mmio_map(s, 1, 0xf4c00000);
 
@@ -344,7 +344,7 @@ static void ppc_core99_init(MachineState *machine)
         qdev_prop_set_uint32(dev, "ofw-addr", 0xf2000000);
         object_property_set_link(OBJECT(dev), OBJECT(pic_dev), "pic",
                                  &error_abort);
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         uninorth_pci = UNI_NORTH_PCI_HOST_BRIDGE(dev);
         s = SYS_BUS_DEVICE(dev);
         /* PCI hole */
@@ -444,7 +444,7 @@ static void ppc_core99_init(MachineState *machine)
     dev = qdev_new(TYPE_MACIO_NVRAM);
     qdev_prop_set_uint32(dev, "size", 0x2000);
     qdev_prop_set_uint32(dev, "it_shift", 1);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, nvram_addr);
     nvr = MACIO_NVRAM(dev);
     pmac_format_nvram_partition(nvr, 0x2000);
@@ -456,8 +456,8 @@ static void ppc_core99_init(MachineState *machine)
     qdev_prop_set_bit(dev, "dma_enabled", false);
     object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
                               OBJECT(fw_cfg));
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_mmio_map(s, 0, CFG_ADDR);
     sysbus_mmio_map(s, 1, CFG_ADDR + 2);
 
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 903483079e..f8c204ead7 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -223,7 +223,7 @@ static void ppc_heathrow_init(MachineState *machine)
 
     /* XXX: we register only 1 output pin for heathrow PIC */
     pic_dev = qdev_new(TYPE_HEATHROW);
-    qdev_realize_and_unref(pic_dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(pic_dev), &error_fatal);
 
     /* Connect the heathrow PIC outputs to the 6xx bus */
     for (i = 0; i < smp_cpus; i++) {
@@ -256,8 +256,8 @@ static void ppc_heathrow_init(MachineState *machine)
     qdev_prop_set_uint32(dev, "ofw-addr", 0x80000000);
     object_property_set_link(OBJECT(dev), OBJECT(pic_dev), "pic",
                              &error_abort);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_mmio_map(s, 0, GRACKLE_BASE);
     sysbus_mmio_map(s, 1, GRACKLE_BASE + 0x200000);
     /* PCI hole */
@@ -315,8 +315,8 @@ static void ppc_heathrow_init(MachineState *machine)
     qdev_prop_set_bit(dev, "dma_enabled", false);
     object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
                               OBJECT(fw_cfg));
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_mmio_map(s, 0, CFG_ADDR);
     sysbus_mmio_map(s, 1, CFG_ADDR + 2);
 
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 8cf097ae7c..3eb40ad8f8 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -733,7 +733,7 @@ static void pnv_init(MachineState *machine)
         qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(pnor),
                             &error_abort);
     }
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     pnv->pnor = PNV_PNOR(dev);
 
     /* load skiboot firmware  */
@@ -849,7 +849,7 @@ static void pnv_init(MachineState *machine)
             object_property_set_link(chip, OBJECT(pnv), "xive-fabric",
                                      &error_abort);
         }
-        qdev_realize_and_unref(DEVICE(chip), NULL, &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(chip), &error_fatal);
     }
     g_free(chip_typename);
 
@@ -1205,7 +1205,7 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
         object_property_set_int(OBJECT(phb), i, "index", &error_fatal);
         object_property_set_int(OBJECT(phb), chip->chip_id, "chip-id",
                                 &error_fatal);
-        qdev_realize(DEVICE(phb), NULL, &local_err);
+        sysbus_realize(SYS_BUS_DEVICE(phb), &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
@@ -1410,7 +1410,7 @@ static void pnv_chip_power9_phb_realize(PnvChip *chip, Error **errp)
             object_property_set_int(obj, PNV_PHB4_DEVICE_ID, "device-id",
                                     &error_fatal);
             object_property_set_link(obj, OBJECT(stack), "stack", &error_abort);
-            qdev_realize(DEVICE(obj), NULL, &local_err);
+            sysbus_realize(SYS_BUS_DEVICE(obj), &local_err);
             if (local_err) {
                 error_propagate(errp, local_err);
                 return;
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index c1cf8d0f46..38fc392438 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -1369,11 +1369,11 @@ void ppc460ex_pcie_init(CPUPPCState *env)
 
     dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
     qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE0_BASE);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     ppc460ex_pcie_register_dcrs(PPC460EX_PCIE_HOST(dev), env);
 
     dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
     qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE1_BASE);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     ppc460ex_pcie_register_dcrs(PPC460EX_PCIE_HOST(dev), env);
 }
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 73a40b2cbe..4a0cb434a6 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -278,7 +278,7 @@ static void ibm_40p_init(MachineState *machine)
     qdev_prop_set_uint32(dev, "elf-machine", PPC_ELF_MACHINE);
     pcihost = SYS_BUS_DEVICE(dev);
     object_property_add_child(qdev_get_machine(), "raven", OBJECT(dev));
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(pcihost, &error_fatal);
     pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
     if (!pci_bus) {
         error_report("could not create PCI host controller");
@@ -351,8 +351,8 @@ static void ibm_40p_init(MachineState *machine)
     qdev_prop_set_bit(dev, "dma_enabled", false);
     object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
                               OBJECT(fw_cfg));
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_mmio_map(s, 0, CFG_ADDR);
     sysbus_mmio_map(s, 1, CFG_ADDR + 2);
 
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 503bd21728..1a106a68de 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -373,8 +373,8 @@ static void sam460ex_init(MachineState *machine)
     dev = qdev_new("sysbus-ohci");
     qdev_prop_set_string(dev, "masterbus", "usb-bus.0");
     qdev_prop_set_uint32(dev, "num-ports", 6);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sbdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(sbdev, &error_fatal);
     sysbus_mmio_map(sbdev, 0, 0x4bffd0000);
     sysbus_connect_irq(sbdev, 0, uic[2][30]);
     usb_create_simple(usb_bus_find(-1), "usb-kbd");
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 7ef24ea2a1..c381bb6fb5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2642,7 +2642,7 @@ static PCIHostState *spapr_create_default_phb(void)
 
     dev = qdev_new(TYPE_SPAPR_PCI_HOST_BRIDGE);
     qdev_prop_set_uint32(dev, "index", 0);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     return PCI_HOST_BRIDGE(dev);
 }
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index f2ade64e7d..79b0e40b66 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -334,7 +334,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
         qdev_prop_set_uint32(dev, "nr-ends", nr_servers << 3);
         object_property_set_link(OBJECT(dev), OBJECT(spapr), "xive-fabric",
                                  &error_abort);
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
         spapr->xive = SPAPR_XIVE(dev);
 
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 61558db1bf..4318ed9638 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -577,7 +577,7 @@ SpaprVioBus *spapr_vio_bus_init(void)
 
     /* Create bridge device */
     dev = qdev_new(TYPE_SPAPR_VIO_BRIDGE);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* Create bus on bridge device */
     qbus = qbus_create(TYPE_SPAPR_VIO_BUS, dev, "spapr-vio");
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index f28a69c0f9..78c4901be1 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -231,7 +231,7 @@ static void virtex_init(MachineState *machine)
     cpu_irq = (qemu_irq *) &env->irq_inputs[PPC40x_INPUT_INT];
     dev = qdev_new("xlnx.xps-intc");
     qdev_prop_set_uint32(dev, "kind-of-intr", 0);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, INTC_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, cpu_irq[0]);
     for (i = 0; i < 32; i++) {
@@ -245,7 +245,7 @@ static void virtex_init(MachineState *machine)
     dev = qdev_new("xlnx.xps-timer");
     qdev_prop_set_uint32(dev, "one-timer-only", 0);
     qdev_prop_set_uint32(dev, "clock-frequency", 62 * 1000000);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, TIMER_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
 
diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
index 729fce0a58..b11ffa0edc 100644
--- a/hw/riscv/sifive_clint.c
+++ b/hw/riscv/sifive_clint.c
@@ -252,7 +252,7 @@ DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
     qdev_prop_set_uint32(dev, "timecmp-base", timecmp_base);
     qdev_prop_set_uint32(dev, "time-base", time_base);
     qdev_prop_set_uint32(dev, "aperture-size", size);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
     return dev;
 }
diff --git a/hw/riscv/sifive_e_prci.c b/hw/riscv/sifive_e_prci.c
index 423af22ecc..17dfa74715 100644
--- a/hw/riscv/sifive_e_prci.c
+++ b/hw/riscv/sifive_e_prci.c
@@ -119,7 +119,7 @@ type_init(sifive_e_prci_register_types)
 DeviceState *sifive_e_prci_create(hwaddr addr)
 {
     DeviceState *dev = qdev_new(TYPE_SIFIVE_E_PRCI);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
     return dev;
 }
diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index 203fec8e48..4f216c5585 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -508,7 +508,7 @@ DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
     qdev_prop_set_uint32(dev, "context-base", context_base);
     qdev_prop_set_uint32(dev, "context-stride", context_stride);
     qdev_prop_set_uint32(dev, "aperture-size", aperture_size);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
     return dev;
 }
diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
index 596757f714..0c78fb2c93 100644
--- a/hw/riscv/sifive_test.c
+++ b/hw/riscv/sifive_test.c
@@ -94,7 +94,7 @@ type_init(sifive_test_register_types)
 DeviceState *sifive_test_create(hwaddr addr)
 {
     DeviceState *dev = qdev_new(TYPE_SIFIVE_TEST);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
     return dev;
 }
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 1ce88b7031..802da232df 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -114,7 +114,7 @@ static void virt_flash_map1(PFlashCFI01 *flash,
     assert(QEMU_IS_ALIGNED(size, VIRT_FLASH_SECTOR_SIZE));
     assert(size / VIRT_FLASH_SECTOR_SIZE <= UINT32_MAX);
     qdev_prop_set_uint32(dev, "num-blocks", size / VIRT_FLASH_SECTOR_SIZE);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     memory_region_add_subregion(sysmem, base,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
@@ -445,7 +445,7 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
 
     dev = qdev_new(TYPE_GPEX_HOST);
 
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     ecam_alias = g_new0(MemoryRegion, 1);
     ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index f6acf416ff..b428a06045 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -582,8 +582,8 @@ Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
 
         dev = qdev_new(m48txx_sysbus_info[i].bus_name);
         qdev_prop_set_int32(dev, "base-year", base_year);
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
         s = SYS_BUS_DEVICE(dev);
+        sysbus_realize_and_unref(s, &error_fatal);
         sysbus_connect_irq(s, 0, IRQ);
         if (io_base != 0) {
             memory_region_add_subregion(get_system_io(), io_base,
diff --git a/hw/rtc/sun4v-rtc.c b/hw/rtc/sun4v-rtc.c
index ed1c10832f..52caea8654 100644
--- a/hw/rtc/sun4v-rtc.c
+++ b/hw/rtc/sun4v-rtc.c
@@ -59,7 +59,7 @@ void sun4v_rtc_init(hwaddr addr)
     dev = qdev_new(TYPE_SUN4V_RTC);
     s = SYS_BUS_DEVICE(dev);
 
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(s, &error_fatal);
 
     sysbus_mmio_map(s, 0, addr);
 }
diff --git a/hw/s390x/ap-bridge.c b/hw/s390x/ap-bridge.c
index 974c97f454..c4e3188ad6 100644
--- a/hw/s390x/ap-bridge.c
+++ b/hw/s390x/ap-bridge.c
@@ -52,7 +52,7 @@ void s390_init_ap(void)
     dev = qdev_new(TYPE_AP_BRIDGE);
     object_property_add_child(qdev_get_machine(), TYPE_AP_BRIDGE,
                               OBJECT(dev));
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* Create bus on bridge device */
     bus = qbus_create(TYPE_AP_BUS, dev, TYPE_AP_BUS);
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index a0dd2da0b8..e37a54d3f2 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -104,7 +104,7 @@ VirtualCssBus *virtual_css_bus_init(void)
     dev = qdev_new(TYPE_VIRTUAL_CSS_BRIDGE);
     object_property_add_child(qdev_get_machine(), TYPE_VIRTUAL_CSS_BRIDGE,
                               OBJECT(dev));
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* Create bus on bridge device */
     bus = qbus_create(TYPE_VIRTUAL_CSS_BUS, dev, "virtual-css");
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 65e9d9a9cd..3429d9f82a 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -272,7 +272,7 @@ static void ccw_init(MachineState *machine)
     dev = qdev_new(TYPE_S390_PCI_HOST_BRIDGE);
     object_property_add_child(qdev_get_machine(), TYPE_S390_PCI_HOST_BRIDGE,
                               OBJECT(dev));
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* register hypercalls */
     virtio_ccw_register_hcalls();
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 40e27a8cb4..b66afb35c8 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -338,7 +338,7 @@ static void sclp_realize(DeviceState *dev, Error **errp)
      * as we can't find a fitting bus via the qom tree, we have to add the
      * event facility to the sysbus, so e.g. a sclp console can be created.
      */
-    qdev_realize(DEVICE(sclp->event_facility), NULL, &err);
+    sysbus_realize(SYS_BUS_DEVICE(sclp->event_facility), &err);
     if (err) {
         goto out;
     }
diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 89784407b9..623be70b26 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -492,7 +492,7 @@ PXA2xxMMCIState *pxa2xx_mmci_init(MemoryRegion *sysmem,
     sysbus_connect_irq(sbd, 0, irq);
     qdev_connect_gpio_out_named(dev, "rx-dma", 0, rx_dma);
     qdev_connect_gpio_out_named(dev, "tx-dma", 0, tx_dma);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(sbd, &error_fatal);
 
     /* Create and plug in the sd card */
     carddev = qdev_new(TYPE_SD_CARD);
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index d9592280bc..443820901d 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -259,7 +259,7 @@ static void r2d_init(MachineState *machine)
 
     dev = qdev_new("sh_pci");
     busdev = SYS_BUS_DEVICE(dev);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(busdev, &error_fatal);
     pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci"));
     sysbus_mmio_map(busdev, 0, P4ADDR(0x1e200000));
     sysbus_mmio_map(busdev, 1, A7ADDR(0x1e200000));
@@ -273,7 +273,7 @@ static void r2d_init(MachineState *machine)
     qdev_prop_set_uint32(dev, "vram-size", SM501_VRAM_SIZE);
     qdev_prop_set_uint32(dev, "base", 0x10000000);
     qdev_prop_set_chr(dev, "chardev", serial_hd(2));
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0x10000000);
     sysbus_mmio_map(busdev, 1, 0x13e00000);
     sysbus_connect_irq(busdev, 0, irq[SM501]);
@@ -284,7 +284,7 @@ static void r2d_init(MachineState *machine)
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_connect_irq(busdev, 0, irq[CF_IDE]);
     qdev_prop_set_uint32(dev, "shift", 1);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0x14001000);
     sysbus_mmio_map(busdev, 1, 0x1400080c);
     mmio_ide_init_drives(dev, dinfo, NULL);
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index b1d8f25dcc..82fcf9c4cc 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -214,14 +214,14 @@ static void leon3_generic_hw_init(MachineState *machine)
     qemu_register_reset(main_cpu_reset, reset_info);
 
     ahb_pnp = GRLIB_AHB_PNP(qdev_new(TYPE_GRLIB_AHB_PNP));
-    qdev_realize_and_unref(DEVICE(ahb_pnp), NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(ahb_pnp), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(ahb_pnp), 0, LEON3_AHB_PNP_OFFSET);
     grlib_ahb_pnp_add_entry(ahb_pnp, 0, 0, GRLIB_VENDOR_GAISLER,
                             GRLIB_LEON3_DEV, GRLIB_AHB_MASTER,
                             GRLIB_CPU_AREA);
 
     apb_pnp = GRLIB_APB_PNP(qdev_new(TYPE_GRLIB_APB_PNP));
-    qdev_realize_and_unref(DEVICE(apb_pnp), NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(apb_pnp), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(apb_pnp), 0, LEON3_APB_PNP_OFFSET);
     grlib_ahb_pnp_add_entry(ahb_pnp, LEON3_APB_PNP_OFFSET, 0xFFF,
                             GRLIB_VENDOR_GAISLER, GRLIB_APBMST_DEV,
@@ -233,7 +233,7 @@ static void leon3_generic_hw_init(MachineState *machine)
                                         env, "pil", 1);
     qdev_connect_gpio_out_named(dev, "grlib-irq", 0,
                                 qdev_get_gpio_in_named(DEVICE(cpu), "pil", 0));
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_IRQMP_OFFSET);
     env->irq_manager = dev;
     env->qemu_irq_ack = leon3_irq_manager;
@@ -326,7 +326,7 @@ static void leon3_generic_hw_init(MachineState *machine)
     qdev_prop_set_uint32(dev, "nr-timers", LEON3_TIMER_COUNT);
     qdev_prop_set_uint32(dev, "frequency", CPU_CLK);
     qdev_prop_set_uint32(dev, "irq-line", LEON3_TIMER_IRQ);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_TIMER_OFFSET);
     for (i = 0; i < LEON3_TIMER_COUNT; i++) {
@@ -342,7 +342,7 @@ static void leon3_generic_hw_init(MachineState *machine)
     if (serial_hd(0)) {
         dev = qdev_new(TYPE_GRLIB_APB_UART);
         qdev_prop_set_chr(dev, "chrdev", serial_hd(0));
-        qdev_realize_and_unref(dev, NULL, &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_UART_OFFSET);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, cpu_irqs[LEON3_UART_IRQ]);
         grlib_apb_pnp_add_entry(apb_pnp, LEON3_UART_OFFSET, 0xFFF,
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 61356946e9..df3c200d17 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -317,8 +317,8 @@ static void *iommu_init(hwaddr addr, uint32_t version, qemu_irq irq)
 
     dev = qdev_new(TYPE_SUN4M_IOMMU);
     qdev_prop_set_uint32(dev, "version", version);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_connect_irq(s, 0, irq);
     sysbus_mmio_map(s, 0, addr);
 
@@ -336,7 +336,7 @@ static void *sparc32_dma_init(hwaddr dma_base,
     SysBusPCNetState *lance;
 
     dma = qdev_new(TYPE_SPARC32_DMA);
-    qdev_realize_and_unref(dma, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, dma_base);
 
     espdma = SPARC32_ESPDMA_DEVICE(object_resolve_path_component(
@@ -367,9 +367,9 @@ static DeviceState *slavio_intctl_init(hwaddr addr,
     unsigned int i, j;
 
     dev = qdev_new("slavio_intctl");
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
 
     for (i = 0; i < MAX_CPUS; i++) {
         for (j = 0; j < MAX_PILS; j++) {
@@ -396,8 +396,8 @@ static void slavio_timer_init_all(hwaddr addr, qemu_irq master_irq,
 
     dev = qdev_new("slavio_timer");
     qdev_prop_set_uint32(dev, "num_cpus", num_cpus);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_connect_irq(s, 0, master_irq);
     sysbus_mmio_map(s, 0, addr + SYS_TIMER_OFFSET);
 
@@ -433,8 +433,8 @@ static void slavio_misc_init(hwaddr base,
     SysBusDevice *s;
 
     dev = qdev_new("slavio_misc");
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
     if (base) {
         /* 8 bit registers */
         /* Slavio control */
@@ -471,8 +471,8 @@ static void ecc_init(hwaddr base, qemu_irq irq, uint32_t version)
 
     dev = qdev_new("eccmemctl");
     qdev_prop_set_uint32(dev, "version", version);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_connect_irq(s, 0, irq);
     sysbus_mmio_map(s, 0, base);
     if (version == 0) { // SS-600MP only
@@ -486,8 +486,8 @@ static void apc_init(hwaddr power_base, qemu_irq cpu_halt)
     SysBusDevice *s;
 
     dev = qdev_new("apc");
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
     /* Power management (APC) XXX: not a Slavio device */
     sysbus_mmio_map(s, 0, power_base);
     sysbus_connect_irq(s, 0, cpu_halt);
@@ -504,8 +504,8 @@ static void tcx_init(hwaddr addr, qemu_irq irq, int vram_size, int width,
     qdev_prop_set_uint16(dev, "width", width);
     qdev_prop_set_uint16(dev, "height", height);
     qdev_prop_set_uint16(dev, "depth", depth);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
 
     /* 10/ROM : FCode ROM */
     sysbus_mmio_map(s, 0, addr);
@@ -556,8 +556,8 @@ static void cg3_init(hwaddr addr, qemu_irq irq, int vram_size, int width,
     qdev_prop_set_uint16(dev, "width", width);
     qdev_prop_set_uint16(dev, "height", height);
     qdev_prop_set_uint16(dev, "depth", depth);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
 
     /* FCode ROM */
     sysbus_mmio_map(s, 0, addr);
@@ -581,8 +581,8 @@ static void idreg_init(hwaddr addr)
     SysBusDevice *s;
 
     dev = qdev_new(TYPE_MACIO_ID_REGISTER);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
 
     sysbus_mmio_map(s, 0, addr);
     address_space_write_rom(&address_space_memory, addr,
@@ -647,8 +647,8 @@ static void afx_init(hwaddr addr)
     SysBusDevice *s;
 
     dev = qdev_new(TYPE_TCX_AFX);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
 
     sysbus_mmio_map(s, 0, addr);
 }
@@ -708,8 +708,8 @@ static void prom_init(hwaddr addr, const char *bios_name)
     int ret;
 
     dev = qdev_new(TYPE_OPENPROM);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
 
     sysbus_mmio_map(s, 0, addr);
 
@@ -878,7 +878,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     /* Create and map RAM frontend */
     dev = qdev_new("memory");
     object_property_set_link(OBJECT(dev), ram_memdev, "memdev", &error_fatal);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0);
 
     /* models without ECC don't trap when missing ram is accessed */
@@ -985,8 +985,8 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     qdev_prop_set_chr(dev, "chrA", NULL);
     qdev_prop_set_uint32(dev, "chnBtype", escc_mouse);
     qdev_prop_set_uint32(dev, "chnAtype", escc_kbd);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_connect_irq(s, 0, slavio_irq[14]);
     sysbus_connect_irq(s, 1, slavio_irq[14]);
     sysbus_mmio_map(s, 0, hwdef->ms_kb_base);
@@ -999,9 +999,9 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     qdev_prop_set_chr(dev, "chrA", serial_hd(0));
     qdev_prop_set_uint32(dev, "chnBtype", escc_serial);
     qdev_prop_set_uint32(dev, "chnAtype", escc_serial);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_connect_irq(s, 0, slavio_irq[15]);
     sysbus_connect_irq(s, 1,  slavio_irq[15]);
     sysbus_mmio_map(s, 0, hwdef->serial_base);
@@ -1061,8 +1061,8 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     qdev_prop_set_bit(dev, "dma_enabled", false);
     object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
                               OBJECT(fw_cfg));
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_mmio_map(s, 0, CFG_ADDR);
     sysbus_mmio_map(s, 1, CFG_ADDR + 2);
 
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index e791fb514a..11440e7457 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -354,8 +354,8 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
 
     /* Power */
     dev = qdev_new(TYPE_SUN4U_POWER);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     sbd = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(sbd, &error_fatal);
     memory_region_add_subregion(pci_address_space_io(pci_dev), 0x7240,
                                 sysbus_mmio_get_region(sbd, 0));
 
@@ -429,8 +429,8 @@ static void prom_init(hwaddr addr, const char *bios_name)
     int ret;
 
     dev = qdev_new(TYPE_OPENPROM);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
 
     sysbus_mmio_map(s, 0, addr);
 
@@ -527,7 +527,7 @@ static void ram_init(hwaddr addr, ram_addr_t RAM_size)
 
     d = SUN4U_RAM(dev);
     d->size = RAM_size;
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(s, &error_fatal);
 
     sysbus_mmio_map(s, 0, addr);
 }
@@ -575,7 +575,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
 
     /* IOMMU */
     iommu = qdev_new(TYPE_SUN4U_IOMMU);
-    qdev_realize_and_unref(iommu, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu), &error_fatal);
 
     /* set up devices */
     ram_init(0, machine->ram_size);
@@ -588,7 +588,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     qdev_prop_set_uint64(DEVICE(sabre), "mem-base", PBM_MEM_BASE);
     object_property_set_link(OBJECT(sabre), OBJECT(iommu), "iommu",
                              &error_abort);
-    qdev_realize_and_unref(DEVICE(sabre), NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(sabre), &error_fatal);
 
     /* Wire up PCI interrupts to CPU */
     for (i = 0; i < IVEC_MAX; i++) {
@@ -698,7 +698,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     dev = qdev_new(TYPE_FW_CFG_IO);
     qdev_prop_set_bit(dev, "dma_enabled", false);
     object_property_add_child(OBJECT(ebus), TYPE_FW_CFG, OBJECT(dev));
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     memory_region_add_subregion(pci_address_space_io(ebus), BIOS_CFG_IOPORT,
                                 &FW_CFG_IO(dev)->comb_iomem);
 
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 532f73661b..4b00320f1c 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -1390,6 +1390,6 @@ void xen_bus_init(void)
     DeviceState *dev = qdev_new(TYPE_XEN_BRIDGE);
     BusState *bus = qbus_create(TYPE_XEN_BUS, dev, NULL);
 
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     qbus_set_bus_hotplug_handler(bus, &error_abort);
 }
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index ef7c832e2e..2335ee2e65 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -703,7 +703,7 @@ int xen_be_init(void)
     }
 
     xen_sysdev = qdev_new(TYPE_XENSYSDEV);
-    qdev_realize_and_unref(xen_sysdev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(xen_sysdev), &error_fatal);
     xen_sysbus = qbus_create(TYPE_XENSYSBUS, xen_sysdev, "xen-sysbus");
     qbus_set_bus_hotplug_handler(xen_sysbus, &error_abort);
 
diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
index 4dbc1a1614..e47e1de676 100644
--- a/hw/xtensa/virt.c
+++ b/hw/xtensa/virt.c
@@ -63,7 +63,7 @@ static void create_pcie(CPUXtensaState *env, int irq_base, hwaddr addr_base)
     int i;
 
     dev = qdev_new(TYPE_GPEX_HOST);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* Map only the first size_ecam bytes of ECAM space. */
     ecam_alias = g_new0(MemoryRegion, 1);
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index eab5c8062e..5d0834c1d9 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -150,9 +150,9 @@ static void xtfpga_net_init(MemoryRegion *address_space,
 
     dev = qdev_new("open_eth");
     qdev_set_nic_properties(dev, nd);
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
     sysbus_connect_irq(s, 0, irq);
     memory_region_add_subregion(address_space, base,
             sysbus_mmio_get_region(s, 0));
@@ -181,8 +181,8 @@ static PFlashCFI01 *xtfpga_flash_init(MemoryRegion *address_space,
     qdev_prop_set_uint8(dev, "width", 2);
     qdev_prop_set_bit(dev, "big-endian", be);
     qdev_prop_set_string(dev, "name", "xtfpga.io.flash");
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
     memory_region_add_subregion(address_space, board->flash->base,
                                 sysbus_mmio_get_region(s, 0));
     return PFLASH_CFI01(dev);
-- 
2.21.3


