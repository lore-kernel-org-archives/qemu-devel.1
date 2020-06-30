Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA200C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:15:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6519720675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="arLmc6o6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6519720675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqCMl-000067-Lo
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 05:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqCBX-0002mL-9p
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:04:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54169
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqCBN-0002wX-V1
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593507841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n9LivGaeRzJLdwRKYcbd/3+fqEYyCcLCXcStNN17dX8=;
 b=arLmc6o6Gy0nanH1Ni6MncMsHlBvP6rwPIc8G3qpaSro/YShctlSmujxt/n8EYherUmwUc
 hKw7tU2LgLfqDtTm//aypjfEda4CbgFq0p22HhGm6l4y+fo7bV9UftQCcz1uo//OshYj/P
 x9Z2ehu4JkIHOKgzrFlUkT7d0gJREIs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-e6HJGQu1MsiTwTQY9UVxHQ-1; Tue, 30 Jun 2020 05:03:59 -0400
X-MC-Unique: e6HJGQu1MsiTwTQY9UVxHQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2646E8015F6;
 Tue, 30 Jun 2020 09:03:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B67B610027A6;
 Tue, 30 Jun 2020 09:03:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 070D6113847C; Tue, 30 Jun 2020 11:03:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 16/26] hw/arm: Drop useless object_property_set_link()
 error handling
Date: Tue, 30 Jun 2020 11:03:41 +0200
Message-Id: <20200630090351.1247703-17-armbru@redhat.com>
In-Reply-To: <20200630090351.1247703-1-armbru@redhat.com>
References: <20200630090351.1247703-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

object_property_set_link() fails when the property doesn't exist, is
not settable, or its .check() method fails.  These are all programming
errors here, so passing it &error_abort is appropriate.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: "Cédric Le Goater" <clg@kaod.org>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Joel Stanley <joel@jms.id.au>
Cc: qemu-arm@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 hw/arm/armsse.c         | 53 ++++++++++-------------------------------
 hw/arm/armv7m.c         |  7 ++----
 hw/arm/aspeed_ast2600.c | 20 ++++------------
 hw/arm/aspeed_soc.c     | 14 ++++-------
 hw/arm/nrf51_soc.c      |  6 +----
 5 files changed, 24 insertions(+), 76 deletions(-)

diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index e8f8f60abc..c73cc6badf 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -564,16 +564,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                                                 &s->container, -1);
         }
         object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i]),
-                                 "memory", &err);
-        if (err) {
-            error_propagate(errp, err);
-            return;
-        }
-        object_property_set_link(cpuobj, OBJECT(s), "idau", &err);
-        if (err) {
-            error_propagate(errp, err);
-            return;
-        }
+                                 "memory", &error_abort);
+        object_property_set_link(cpuobj, OBJECT(s), "idau", &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(cpuobj), &err);
         if (err) {
             error_propagate(errp, err);
@@ -700,11 +692,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             return;
         }
         object_property_set_link(OBJECT(&s->mpc[i]), OBJECT(&s->sram[i]),
-                                 "downstream", &err);
-        if (err) {
-            error_propagate(errp, err);
-            return;
-        }
+                                 "downstream", &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->mpc[i]), &err);
         if (err) {
             error_propagate(errp, err);
@@ -755,11 +743,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer0), 0,
                        armsse_get_common_irq_in(s, 3));
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->timer0), 0);
-    object_property_set_link(OBJECT(&s->apb_ppc0), OBJECT(mr), "port[0]", &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
+    object_property_set_link(OBJECT(&s->apb_ppc0), OBJECT(mr), "port[0]",
+                             &error_abort);
 
     qdev_prop_set_uint32(DEVICE(&s->timer1), "pclk-frq", s->mainclk_frq);
     sysbus_realize(SYS_BUS_DEVICE(&s->timer1), &err);
@@ -770,12 +755,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer1), 0,
                        armsse_get_common_irq_in(s, 4));
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->timer1), 0);
-    object_property_set_link(OBJECT(&s->apb_ppc0), OBJECT(mr), "port[1]", &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-
+    object_property_set_link(OBJECT(&s->apb_ppc0), OBJECT(mr), "port[1]",
+                             &error_abort);
 
     qdev_prop_set_uint32(DEVICE(&s->dualtimer), "pclk-frq", s->mainclk_frq);
     sysbus_realize(SYS_BUS_DEVICE(&s->dualtimer), &err);
@@ -786,11 +767,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->dualtimer), 0,
                        armsse_get_common_irq_in(s, 5));
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->dualtimer), 0);
-    object_property_set_link(OBJECT(&s->apb_ppc0), OBJECT(mr), "port[2]", &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
+    object_property_set_link(OBJECT(&s->apb_ppc0), OBJECT(mr), "port[2]",
+                             &error_abort);
 
     if (info->has_mhus) {
         /*
@@ -815,12 +793,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             port = g_strdup_printf("port[%d]", i + 3);
             mr = sysbus_mmio_get_region(mhu_sbd, 0);
             object_property_set_link(OBJECT(&s->apb_ppc0), OBJECT(mr),
-                                     port, &err);
+                                     port, &error_abort);
             g_free(port);
-            if (err) {
-                error_propagate(errp, err);
-                return;
-            }
 
             /*
              * Each MHU has an irq line for each CPU:
@@ -967,11 +941,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->s32ktimer), 0,
                        armsse_get_common_irq_in(s, 2));
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->s32ktimer), 0);
-    object_property_set_link(OBJECT(&s->apb_ppc1), OBJECT(mr), "port[0]", &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
+    object_property_set_link(OBJECT(&s->apb_ppc1), OBJECT(mr), "port[0]",
+                             &error_abort);
 
     sysbus_realize(SYS_BUS_DEVICE(&s->apb_ppc1), &err);
     if (err) {
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index ce83586e03..3308211e9c 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -170,11 +170,8 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
     object_property_set_link(OBJECT(s->cpu), OBJECT(&s->container), "memory",
                              &error_abort);
     if (object_property_find(OBJECT(s->cpu), "idau", NULL)) {
-        object_property_set_link(OBJECT(s->cpu), s->idau, "idau", &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
-            return;
-        }
+        object_property_set_link(OBJECT(s->cpu), s->idau, "idau",
+                                 &error_abort);
     }
     if (object_property_find(OBJECT(s->cpu), "init-svtor", NULL)) {
         object_property_set_uint(OBJECT(s->cpu), s->init_svtor,
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 08b3592e36..4efac02e2b 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -341,11 +341,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
 
     /* I2C */
-    object_property_set_link(OBJECT(&s->i2c), OBJECT(s->dram_mr), "dram", &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
+    object_property_set_link(OBJECT(&s->i2c), OBJECT(s->dram_mr), "dram",
+                             &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->i2c), &err);
     if (err) {
         error_propagate(errp, err);
@@ -363,11 +360,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
 
     /* FMC, The number of CS is set at the board level */
-    object_property_set_link(OBJECT(&s->fmc), OBJECT(s->dram_mr), "dram", &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
+    object_property_set_link(OBJECT(&s->fmc), OBJECT(s->dram_mr), "dram",
+                             &error_abort);
     object_property_set_int(OBJECT(&s->fmc), sc->memmap[ASPEED_SDRAM],
                             "sdram-base", &err);
     if (err) {
@@ -388,11 +382,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     /* SPI */
     for (i = 0; i < sc->spis_num; i++) {
         object_property_set_link(OBJECT(&s->spi[i]), OBJECT(s->dram_mr),
-                                 "dram", &err);
-        if (err) {
-            error_propagate(errp, err);
-            return;
-        }
+                                 "dram", &error_abort);
         object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs", &err);
         sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
         if (err) {
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index ec21de50ce..03b91bade6 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -300,11 +300,8 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* I2C */
-    object_property_set_link(OBJECT(&s->i2c), OBJECT(s->dram_mr), "dram", &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
+    object_property_set_link(OBJECT(&s->i2c), OBJECT(s->dram_mr), "dram",
+                             &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->i2c), &err);
     if (err) {
         error_propagate(errp, err);
@@ -315,11 +312,8 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_I2C));
 
     /* FMC, The number of CS is set at the board level */
-    object_property_set_link(OBJECT(&s->fmc), OBJECT(s->dram_mr), "dram", &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
+    object_property_set_link(OBJECT(&s->fmc), OBJECT(s->dram_mr), "dram",
+                             &error_abort);
     object_property_set_int(OBJECT(&s->fmc), sc->memmap[ASPEED_SDRAM],
                             "sdram-base", &err);
     if (err) {
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 5a8961ddbb..20dd8b5897 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -66,11 +66,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
     }
 
     object_property_set_link(OBJECT(&s->cpu), OBJECT(&s->container), "memory",
-            &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
+                             &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->cpu), &err);
     if (err) {
         error_propagate(errp, err);
-- 
2.26.2


