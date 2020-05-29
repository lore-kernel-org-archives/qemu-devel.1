Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71869C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:06:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB9420707
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xjr3f0fN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB9420707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jefej-0005NZ-8V
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 10:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKa-0003FH-6t
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:45:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60077
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKM-00076x-Hw
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590759936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q29xO1jESqWkt5yqmDVisH92OIYlLGNNRhreuk/uWaw=;
 b=Xjr3f0fN+phEUQply3ZjEVUmrrzY8J0REJG4e8Af7AeDSU02jJnAggI5quvKuE2YKuCNf1
 Z0Y6NBr+h0jMIJrBNdizMBDRwIiVgSUQulGtbuETfghv6MnncsOX3Urvdt5LnKlU6IyD5K
 F64zmZv3VP6PpFJLt+F2ISm0oJPWyhQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-3Vy-ULCjPiKgk_hD7aGRPw-1; Fri, 29 May 2020 09:45:35 -0400
X-MC-Unique: 3Vy-ULCjPiKgk_hD7aGRPw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DEE8835B46
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 13:45:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A48EC768DF
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 13:45:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 94A3E1135248; Fri, 29 May 2020 15:45:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 49/58] sysbus: Convert qdev_set_parent_bus() use with
 Coccinelle, part 3
Date: Fri, 29 May 2020 15:45:14 +0200
Message-Id: <20200529134523.8477-50-armbru@redhat.com>
In-Reply-To: <20200529134523.8477-1-armbru@redhat.com>
References: <20200529134523.8477-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 23:43:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These are init/realize pairs produced by the previous commit's
Coccinelle script where the argument test doesn't quite match.  They
need even more careful review.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/arm/armsse.c          | 33 +++++++++++++--------------------
 hw/arm/armv7m.c          |  6 +++---
 hw/arm/microbit.c        | 12 ++++++------
 hw/arm/xlnx-versal.c     |  6 +++---
 hw/arm/xlnx-zynqmp.c     |  6 +++---
 hw/cpu/realview_mpcore.c |  5 ++---
 hw/display/sm501.c       |  4 ++--
 hw/intc/armv7m_nvic.c    |  7 +++----
 8 files changed, 35 insertions(+), 44 deletions(-)

diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index a00764759f..38c99913cf 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -257,9 +257,8 @@ static void armsse_init(Object *obj)
         g_free(name);
 
         name = g_strdup_printf("armv7m%d", i);
-        sysbus_init_child_obj(OBJECT(&s->cluster[i]), name,
-                              &s->armv7m[i], sizeof(s->armv7m[i]),
-                              TYPE_ARMV7M);
+        object_initialize_child(OBJECT(&s->cluster[i]), name, &s->armv7m[i],
+                                TYPE_ARMV7M);
         qdev_prop_set_string(DEVICE(&s->armv7m[i]), "cpu-type",
                              ARM_CPU_TYPE_NAME("cortex-m33"));
         g_free(name);
@@ -309,31 +308,26 @@ static void armsse_init(Object *obj)
     object_initialize_child(obj, "armsse-sysinfo", &s->sysinfo,
                             TYPE_IOTKIT_SYSINFO);
     if (info->has_mhus) {
-        sysbus_init_child_obj(obj, "mhu0", &s->mhu[0], sizeof(s->mhu[0]),
-                              TYPE_ARMSSE_MHU);
-        sysbus_init_child_obj(obj, "mhu1", &s->mhu[1], sizeof(s->mhu[1]),
-                              TYPE_ARMSSE_MHU);
+        object_initialize_child(obj, "mhu0", &s->mhu[0], TYPE_ARMSSE_MHU);
+        object_initialize_child(obj, "mhu1", &s->mhu[1], TYPE_ARMSSE_MHU);
     }
     if (info->has_ppus) {
         for (i = 0; i < info->num_cpus; i++) {
             char *name = g_strdup_printf("CPU%dCORE_PPU", i);
             int ppuidx = CPU0CORE_PPU + i;
 
-            sysbus_init_child_obj(obj, name, &s->ppu[ppuidx],
-                                  sizeof(s->ppu[ppuidx]),
-                                  TYPE_UNIMPLEMENTED_DEVICE);
+            object_initialize_child(obj, name, &s->ppu[ppuidx],
+                                    TYPE_UNIMPLEMENTED_DEVICE);
             g_free(name);
         }
-        sysbus_init_child_obj(obj, "DBG_PPU", &s->ppu[DBG_PPU],
-                              sizeof(s->ppu[DBG_PPU]),
-                              TYPE_UNIMPLEMENTED_DEVICE);
+        object_initialize_child(obj, "DBG_PPU", &s->ppu[DBG_PPU],
+                                TYPE_UNIMPLEMENTED_DEVICE);
         for (i = 0; i < info->sram_banks; i++) {
             char *name = g_strdup_printf("RAM%d_PPU", i);
             int ppuidx = RAM0_PPU + i;
 
-            sysbus_init_child_obj(obj, name, &s->ppu[ppuidx],
-                                  sizeof(s->ppu[ppuidx]),
-                                  TYPE_UNIMPLEMENTED_DEVICE);
+            object_initialize_child(obj, name, &s->ppu[ppuidx],
+                                    TYPE_UNIMPLEMENTED_DEVICE);
             g_free(name);
         }
     }
@@ -429,7 +423,7 @@ static void map_ppu(ARMSSE *s, int ppuidx, const char *name, hwaddr addr)
 
     qdev_prop_set_string(dev, "name", name);
     qdev_prop_set_uint64(dev, "size", 0x1000);
-    qdev_init_nofail(dev);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ppu[ppuidx]), 0, addr);
 }
 
@@ -580,7 +574,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             error_propagate(errp, err);
             return;
         }
-        object_property_set_bool(cpuobj, true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(cpuobj), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -816,8 +810,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             int cpunum;
             SysBusDevice *mhu_sbd = SYS_BUS_DEVICE(&s->mhu[i]);
 
-            object_property_set_bool(OBJECT(&s->mhu[i]), true,
-                                     "realized", &err);
+            sysbus_realize(SYS_BUS_DEVICE(&s->mhu[i]), &err);
             if (err) {
                 error_propagate(errp, err);
                 return;
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 6fd672e7d9..5cdd0b9b51 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -141,8 +141,8 @@ static void armv7m_instance_init(Object *obj)
                               OBJECT(&s->nvic), "num-irq");
 
     for (i = 0; i < ARRAY_SIZE(s->bitband); i++) {
-        sysbus_init_child_obj(obj, "bitband[*]", &s->bitband[i],
-                              sizeof(s->bitband[i]), TYPE_BITBAND);
+        object_initialize_child(obj, "bitband[*]", &s->bitband[i],
+                                TYPE_BITBAND);
     }
 }
 
@@ -257,7 +257,7 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
             }
             object_property_set_link(obj, OBJECT(s->board_memory),
                                      "source-memory", &error_abort);
-            object_property_set_bool(obj, true, "realized", &err);
+            sysbus_realize(SYS_BUS_DEVICE(obj), &err);
             if (err != NULL) {
                 error_propagate(errp, err);
                 return;
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index 72fab429c4..d20ebd3aad 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -39,21 +39,21 @@ static void microbit_init(MachineState *machine)
     Object *soc = OBJECT(&s->nrf51);
     Object *i2c = OBJECT(&s->i2c);
 
-    sysbus_init_child_obj(OBJECT(machine), "nrf51", &s->nrf51, sizeof(s->nrf51),
-                          TYPE_NRF51_SOC);
+    object_initialize_child(OBJECT(machine), "nrf51", &s->nrf51,
+                            TYPE_NRF51_SOC);
     qdev_prop_set_chr(DEVICE(&s->nrf51), "serial0", serial_hd(0));
     object_property_set_link(soc, OBJECT(system_memory), "memory",
                              &error_fatal);
-    object_property_set_bool(soc, true, "realized", &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(soc), &error_fatal);
 
     /*
      * Overlap the TWI stub device into the SoC.  This is a microbit-specific
      * hack until we implement the nRF51 TWI controller properly and the
      * magnetometer/accelerometer devices.
      */
-    sysbus_init_child_obj(OBJECT(machine), "microbit.twi", &s->i2c,
-                          sizeof(s->i2c), TYPE_MICROBIT_I2C);
-    object_property_set_bool(i2c, true, "realized", &error_fatal);
+    object_initialize_child(OBJECT(machine), "microbit.twi", &s->i2c,
+                            TYPE_MICROBIT_I2C);
+    sysbus_realize(SYS_BUS_DEVICE(i2c), &error_fatal);
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(i2c), 0);
     memory_region_add_subregion_overlap(&s->nrf51.container, NRF51_TWI_BASE,
                                         mr, -1);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index a27c315a6b..20f0121ab0 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -238,10 +238,10 @@ static void versal_create_rtc(Versal *s, qemu_irq *pic)
     SysBusDevice *sbd;
     MemoryRegion *mr;
 
-    sysbus_init_child_obj(OBJECT(s), "rtc", &s->pmc.rtc, sizeof(s->pmc.rtc),
-                          TYPE_XLNX_ZYNQMP_RTC);
+    object_initialize_child(OBJECT(s), "rtc", &s->pmc.rtc,
+                            TYPE_XLNX_ZYNQMP_RTC);
     sbd = SYS_BUS_DEVICE(&s->pmc.rtc);
-    qdev_init_nofail(DEVICE(sbd));
+    sysbus_realize(SYS_BUS_DEVICE(sbd), &error_fatal);
 
     mr = sysbus_mmio_get_region(sbd, 0);
     memory_region_add_subregion(&s->mr_ps, MM_PMC_RTC, mr);
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 667c11ac8d..446b75a7aa 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -251,8 +251,8 @@ static void xlnx_zynqmp_init(Object *obj)
     object_initialize_child(obj, "sata", &s->sata, TYPE_SYSBUS_AHCI);
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_SDHCI; i++) {
-        sysbus_init_child_obj(obj, "sdhci[*]", &s->sdhci[i],
-                              sizeof(s->sdhci[i]), TYPE_SYSBUS_SDHCI);
+        object_initialize_child(obj, "sdhci[*]", &s->sdhci[i],
+                                TYPE_SYSBUS_SDHCI);
     }
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_SPIS; i++) {
@@ -530,7 +530,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
             error_propagate(errp, err);
             return;
         }
-        object_property_set_bool(sdhci, true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(sdhci), &err);
         if (err) {
             error_propagate(errp, err);
             return;
diff --git a/hw/cpu/realview_mpcore.c b/hw/cpu/realview_mpcore.c
index 672d0f8a25..d2e426fa45 100644
--- a/hw/cpu/realview_mpcore.c
+++ b/hw/cpu/realview_mpcore.c
@@ -81,7 +81,7 @@ static void realview_mpcore_realize(DeviceState *dev, Error **errp)
     }
     /* ??? IRQ routing is hardcoded to "normal" mode.  */
     for (n = 0; n < 4; n++) {
-        object_property_set_bool(OBJECT(&s->gic[n]), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->gic[n]), &err);
         if (err != NULL) {
             error_propagate(errp, err);
             return;
@@ -109,8 +109,7 @@ static void mpcore_rirq_init(Object *obj)
     sysbus_init_mmio(sbd, sysbus_mmio_get_region(privbusdev, 0));
 
     for (i = 0; i < 4; i++) {
-        sysbus_init_child_obj(obj, "gic[*]", &s->gic[i], sizeof(s->gic[i]),
-                              TYPE_REALVIEW_GIC);
+        object_initialize_child(obj, "gic[*]", &s->gic[i], TYPE_REALVIEW_GIC);
     }
 }
 
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 1dadfca5c0..bea14c9b67 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1960,7 +1960,7 @@ static void sm501_realize_sysbus(DeviceState *dev, Error **errp)
     sysbus_pass_irq(sbd, SYS_BUS_DEVICE(usb_dev));
 
     /* bridge to serial emulation module */
-    qdev_init_nofail(DEVICE(&s->serial));
+    sysbus_realize(SYS_BUS_DEVICE(&s->serial), &error_fatal);
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->serial), 0);
     memory_region_add_subregion(&s->state.mmio_region, SM501_UART0, mr);
     /* TODO : chain irq to IRL */
@@ -2006,7 +2006,7 @@ static void sm501_sysbus_init(Object *o)
     SM501SysBusState *sm501 = SYSBUS_SM501(o);
     SerialMM *smm = &sm501->serial;
 
-    sysbus_init_child_obj(o, "serial", smm, sizeof(*smm), TYPE_SERIAL_MM);
+    object_initialize_child(o, "serial", smm, TYPE_SERIAL_MM);
     qdev_set_legacy_instance_id(DEVICE(smm), SM501_UART0, 2);
     qdev_prop_set_uint8(DEVICE(smm), "regshift", 2);
     qdev_prop_set_uint8(DEVICE(smm), "endianness", DEVICE_LITTLE_ENDIAN);
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index f035079168..af9f4c5a85 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2640,8 +2640,7 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
 
     s->num_prio_bits = arm_feature(&s->cpu->env, ARM_FEATURE_V7) ? 8 : 2;
 
-    object_property_set_bool(OBJECT(&s->systick[M_REG_NS]), true,
-                             "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->systick[M_REG_NS]), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
@@ -2735,8 +2734,8 @@ static void armv7m_nvic_instance_init(Object *obj)
     NVICState *nvic = NVIC(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
-    sysbus_init_child_obj(obj, "systick-reg-ns", &nvic->systick[M_REG_NS],
-                          sizeof(nvic->systick[M_REG_NS]), TYPE_SYSTICK);
+    object_initialize_child(obj, "systick-reg-ns", &nvic->systick[M_REG_NS],
+                            TYPE_SYSTICK);
     /* We can't initialize the secure systick here, as we don't know
      * yet if we need it.
      */
-- 
2.21.3


