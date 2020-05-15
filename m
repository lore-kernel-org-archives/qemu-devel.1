Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC284C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:21:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908E120728
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KVxEW+8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908E120728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZTis-000311-K1
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 02:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZTSY-0003Dk-KH
 for qemu-devel@nongnu.org; Fri, 15 May 2020 02:04:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55498
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZTSW-0004VT-3m
 for qemu-devel@nongnu.org; Fri, 15 May 2020 02:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589522675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iYQa1ZQ4K6uLTJeF+w5jHrqxbHrlY6bVmCSn12844WY=;
 b=KVxEW+8YIGz8HZFyyLbHmsqbi0w/qG+8sksKAt0Dkaa760VfOz21kMv90MO0K56N5w99PP
 gRBIpbp5XBktk7yW3KWiW6u0am77fUvlhNhkKrgTCiFjKCJKxd841QbdpSAvlhNmVudpqK
 N3Pe63093jr+nBRQatMTaw5TEsPBlzE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-Ilw_li9IPcSAd2WclRvZ1g-1; Fri, 15 May 2020 02:04:31 -0400
X-MC-Unique: Ilw_li9IPcSAd2WclRvZ1g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE3CDBFCB;
 Fri, 15 May 2020 06:04:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 702516FDD1;
 Fri, 15 May 2020 06:04:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7775611358D2; Fri, 15 May 2020 08:04:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/21] hw: Remove unnecessary DEVICE() cast
Date: Fri, 15 May 2020 08:04:24 +0200
Message-Id: <20200515060424.18993-22-armbru@redhat.com>
In-Reply-To: <20200515060424.18993-1-armbru@redhat.com>
References: <20200515060424.18993-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
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
Cc: Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, pbonzini@redhat.com,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The DEVICE() macro is defined as:

  #define DEVICE(obj) OBJECT_CHECK(DeviceState, (obj), TYPE_DEVICE)

which expands to:

  ((DeviceState *)object_dynamic_cast_assert((Object *)(obj), (name),
                                             __FILE__, __LINE__,
                                             __func__))

This assertion can only fail when @obj points to something other
than its stated type, i.e. when we're in undefined behavior country.

Remove the unnecessary DEVICE() casts when we already know the
pointer is of DeviceState type.

Patch created mechanically using spatch with this script:

  @@
  typedef DeviceState;
  DeviceState *s;
  @@
  -   DEVICE(s)
  +   s

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Paul Durrant <paul@xen.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Acked-by: John Snow <jsnow@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200512070020.22782-4-f4bug@amsat.org>
---
 hw/display/artist.c         | 2 +-
 hw/display/cg3.c            | 2 +-
 hw/display/sm501.c          | 2 +-
 hw/display/tcx.c            | 4 ++--
 hw/display/vga-isa.c        | 2 +-
 hw/i2c/imx_i2c.c            | 2 +-
 hw/i2c/mpc_i2c.c            | 2 +-
 hw/ide/piix.c               | 2 +-
 hw/misc/macio/pmu.c         | 2 +-
 hw/net/ftgmac100.c          | 3 +--
 hw/net/imx_fec.c            | 2 +-
 hw/nubus/nubus-device.c     | 2 +-
 hw/pci-host/bonito.c        | 2 +-
 hw/ppc/spapr.c              | 2 +-
 hw/sh4/sh_pci.c             | 2 +-
 hw/xen/xen-legacy-backend.c | 2 +-
 16 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 753dbb9a77..7e2a4556bd 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -1353,7 +1353,7 @@ static void artist_realizefn(DeviceState *dev, Error **errp)
     s->cursor_height = 32;
     s->cursor_width = 32;
 
-    s->con = graphic_console_init(DEVICE(dev), 0, &artist_ops, s);
+    s->con = graphic_console_init(dev, 0, &artist_ops, s);
     qemu_console_resize(s->con, s->width, s->height);
 }
 
diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index a1ede10394..f7f1c199ce 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -321,7 +321,7 @@ static void cg3_realizefn(DeviceState *dev, Error **errp)
 
     sysbus_init_irq(sbd, &s->irq);
 
-    s->con = graphic_console_init(DEVICE(dev), 0, &cg3_ops, s);
+    s->con = graphic_console_init(dev, 0, &cg3_ops, s);
     qemu_console_resize(s->con, s->width, s->height);
 }
 
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 296cd56c4a..acc692531a 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1839,7 +1839,7 @@ static void sm501_init(SM501State *s, DeviceState *dev,
                                 &s->twoD_engine_region);
 
     /* create qemu graphic console */
-    s->con = graphic_console_init(DEVICE(dev), 0, &sm501_ops, s);
+    s->con = graphic_console_init(dev, 0, &sm501_ops, s);
 }
 
 static const VMStateDescription vmstate_sm501_state = {
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 76de16e8ea..1fb45b1aab 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -868,9 +868,9 @@ static void tcx_realizefn(DeviceState *dev, Error **errp)
     sysbus_init_irq(sbd, &s->irq);
 
     if (s->depth == 8) {
-        s->con = graphic_console_init(DEVICE(dev), 0, &tcx_ops, s);
+        s->con = graphic_console_init(dev, 0, &tcx_ops, s);
     } else {
-        s->con = graphic_console_init(DEVICE(dev), 0, &tcx24_ops, s);
+        s->con = graphic_console_init(dev, 0, &tcx24_ops, s);
     }
     s->thcmisc = 0;
 
diff --git a/hw/display/vga-isa.c b/hw/display/vga-isa.c
index 0633ed382c..3aaeeeca1e 100644
--- a/hw/display/vga-isa.c
+++ b/hw/display/vga-isa.c
@@ -74,7 +74,7 @@ static void vga_isa_realizefn(DeviceState *dev, Error **errp)
                                         0x000a0000,
                                         vga_io_memory, 1);
     memory_region_set_coalescing(vga_io_memory);
-    s->con = graphic_console_init(DEVICE(dev), 0, s->hw_ops, s);
+    s->con = graphic_console_init(dev, 0, s->hw_ops, s);
 
     memory_region_add_subregion(isa_address_space(isadev),
                                 VBE_DISPI_LFB_PHYSICAL_ADDRESS,
diff --git a/hw/i2c/imx_i2c.c b/hw/i2c/imx_i2c.c
index 30b9aea247..2e02e1c4fa 100644
--- a/hw/i2c/imx_i2c.c
+++ b/hw/i2c/imx_i2c.c
@@ -305,7 +305,7 @@ static void imx_i2c_realize(DeviceState *dev, Error **errp)
                           IMX_I2C_MEM_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
     sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
-    s->bus = i2c_init_bus(DEVICE(dev), NULL);
+    s->bus = i2c_init_bus(dev, NULL);
 }
 
 static void imx_i2c_class_init(ObjectClass *klass, void *data)
diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
index 0aa1be3ce7..9a724f3a3e 100644
--- a/hw/i2c/mpc_i2c.c
+++ b/hw/i2c/mpc_i2c.c
@@ -332,7 +332,7 @@ static void mpc_i2c_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&i2c->iomem, OBJECT(i2c), &i2c_ops, i2c,
                           "mpc-i2c", 0x14);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &i2c->iomem);
-    i2c->bus = i2c_init_bus(DEVICE(dev), "i2c");
+    i2c->bus = i2c_init_bus(dev, "i2c");
 }
 
 static void mpc_i2c_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index 3b2de4c312..b402a93636 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -193,7 +193,7 @@ int pci_piix3_xen_ide_unplug(DeviceState *dev, bool aux)
             blk_unref(blk);
         }
     }
-    qdev_reset_all(DEVICE(dev));
+    qdev_reset_all(dev);
     return 0;
 }
 
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index 5fa792846c..9a9cd427e1 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -758,7 +758,7 @@ static void pmu_realize(DeviceState *dev, Error **errp)
 
     if (s->has_adb) {
         qbus_create_inplace(&s->adb_bus, sizeof(s->adb_bus), TYPE_ADB_BUS,
-                            DEVICE(dev), "adb.0");
+                            dev, "adb.0");
         s->adb_poll_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, pmu_adb_poll, s);
         s->adb_poll_mask = 0xffff;
         s->autopoll_rate_ms = 20;
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 041ed21017..25ebee7ec2 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -1035,8 +1035,7 @@ static void ftgmac100_realize(DeviceState *dev, Error **errp)
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
 
     s->nic = qemu_new_nic(&net_ftgmac100_info, &s->conf,
-                          object_get_typename(OBJECT(dev)), DEVICE(dev)->id,
-                          s);
+                          object_get_typename(OBJECT(dev)), dev->id, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
 }
 
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index a35c33683e..7adcc9df65 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -1323,7 +1323,7 @@ static void imx_eth_realize(DeviceState *dev, Error **errp)
 
     s->nic = qemu_new_nic(&imx_eth_net_info, &s->conf,
                           object_get_typename(OBJECT(dev)),
-                          DEVICE(dev)->id, s);
+                          dev->id, s);
 
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
 }
diff --git a/hw/nubus/nubus-device.c b/hw/nubus/nubus-device.c
index 01ccad9e8e..ffe78a8823 100644
--- a/hw/nubus/nubus-device.c
+++ b/hw/nubus/nubus-device.c
@@ -156,7 +156,7 @@ void nubus_register_rom(NubusDevice *dev, const uint8_t *rom, uint32_t size,
 
 static void nubus_device_realize(DeviceState *dev, Error **errp)
 {
-    NubusBus *nubus = NUBUS_BUS(qdev_get_parent_bus(DEVICE(dev)));
+    NubusBus *nubus = NUBUS_BUS(qdev_get_parent_bus(dev));
     NubusDevice *nd = NUBUS_DEVICE(dev);
     char *name;
     hwaddr slot_offset;
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index cc6545c8a8..f212796044 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -606,7 +606,7 @@ static void bonito_pcihost_realize(DeviceState *dev, Error **errp)
     BonitoState *bs = BONITO_PCI_HOST_BRIDGE(dev);
 
     memory_region_init(&bs->pci_mem, OBJECT(dev), "pci.mem", BONITO_PCILO_SIZE);
-    phb->bus = pci_register_root_bus(DEVICE(dev), "pci",
+    phb->bus = pci_register_root_bus(dev, "pci",
                                      pci_bonito_set_irq, pci_bonito_map_irq,
                                      dev, &bs->pci_mem, get_system_io(),
                                      0x28, 32, TYPE_PCI_BUS);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c0bf8c8d4f..9b358fcc60 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4013,7 +4013,7 @@ static void spapr_phb_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     /* hotplug hooks should check it's enabled before getting this far */
     assert(drc);
 
-    spapr_drc_attach(drc, DEVICE(dev), &local_err);
+    spapr_drc_attach(drc, dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/sh4/sh_pci.c b/hw/sh4/sh_pci.c
index 08f2fc1dde..0a3e86f949 100644
--- a/hw/sh4/sh_pci.c
+++ b/hw/sh4/sh_pci.c
@@ -129,7 +129,7 @@ static void sh_pci_device_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < 4; i++) {
         sysbus_init_irq(sbd, &s->irq[i]);
     }
-    phb->bus = pci_register_root_bus(DEVICE(dev), "pci",
+    phb->bus = pci_register_root_bus(dev, "pci",
                                      sh_pci_set_irq, sh_pci_map_irq,
                                      s->irq,
                                      get_system_memory(),
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 4a373b2373..f9d013811a 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -705,7 +705,7 @@ int xen_be_init(void)
 
     xen_sysdev = qdev_create(NULL, TYPE_XENSYSDEV);
     qdev_init_nofail(xen_sysdev);
-    xen_sysbus = qbus_create(TYPE_XENSYSBUS, DEVICE(xen_sysdev), "xen-sysbus");
+    xen_sysbus = qbus_create(TYPE_XENSYSBUS, xen_sysdev, "xen-sysbus");
     qbus_set_bus_hotplug_handler(xen_sysbus, &error_abort);
 
     return 0;
-- 
2.21.1


