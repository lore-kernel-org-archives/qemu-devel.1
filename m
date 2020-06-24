Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A01C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:00:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 911C22065F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORsTPLPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911C22065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo8l5-0006tM-PI
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 13:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo8Vf-0004H0-6p
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:44:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29438
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo8VD-00058m-6E
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593017037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=enTkFSOQASjvAyg+vQlaDie7X92R4sXChIaRoalejTk=;
 b=ORsTPLPWQjVuBD5x5SVWZbt6EVbXVk4EXz7Prpq3mMIBXJF89h1M2wI/JGraJKyO3FRn41
 zOhyEvZqdUEHpKiS9hP1J2xcKTREMuu5Omyuqdhb7S7NJHfNxeJaj+0QB6wfYbRRKUAqmp
 JZf9sV00V0vQoIIdBFiw02su5bgxSxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-BCPW0Bu6M6OU5onFkBdGSA-1; Wed, 24 Jun 2020 12:43:53 -0400
X-MC-Unique: BCPW0Bu6M6OU5onFkBdGSA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EEF313E6;
 Wed, 24 Jun 2020 16:43:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA8E4891E8;
 Wed, 24 Jun 2020 16:43:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5F648113848F; Wed, 24 Jun 2020 18:43:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 34/46] qom: Don't handle impossible object_property_get_link()
 failure
Date: Wed, 24 Jun 2020 18:43:32 +0200
Message-Id: <20200624164344.3778251-35-armbru@redhat.com>
In-Reply-To: <20200624164344.3778251-1-armbru@redhat.com>
References: <20200624164344.3778251-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

Don't handle object_property_get_link() failure that can't happen
unless the programmer screwed up, pass &error_abort.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/arm/bcm2835_peripherals.c |  7 +------
 hw/arm/bcm2836.c             |  7 +------
 hw/display/bcm2835_fb.c      |  8 +-------
 hw/dma/bcm2835_dma.c         |  9 +--------
 hw/gpio/bcm2835_gpio.c       | 15 ++-------------
 hw/intc/nios2_iic.c          |  8 +-------
 hw/misc/bcm2835_mbox.c       |  9 +--------
 hw/misc/bcm2835_property.c   | 17 ++---------------
 hw/usb/hcd-dwc2.c            |  9 +--------
 9 files changed, 11 insertions(+), 78 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 8313410ffe..3c40bda91e 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -134,12 +134,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     uint64_t ram_size, vcram_size;
     int n;
 
-    obj = object_property_get_link(OBJECT(dev), "ram", &err);
-    if (obj == NULL) {
-        error_setg(errp, "%s: required ram link not found: %s",
-                   __func__, error_get_pretty(err));
-        return;
-    }
+    obj = object_property_get_link(OBJECT(dev), "ram", &error_abort);
 
     ram = MEMORY_REGION(obj);
     ram_size = memory_region_size(ram);
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 51d156f0c5..35281df8c3 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -77,12 +77,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
 
     /* common peripherals from bcm2835 */
 
-    obj = object_property_get_link(OBJECT(dev), "ram", &err);
-    if (obj == NULL) {
-        error_setg(errp, "%s: required ram link not found: %s",
-                   __func__, error_get_pretty(err));
-        return;
-    }
+    obj = object_property_get_link(OBJECT(dev), "ram", &error_abort);
 
     object_property_add_const_link(OBJECT(&s->peripherals), "ram", obj);
 
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index c6263808a2..c4bfed2740 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -401,7 +401,6 @@ static void bcm2835_fb_reset(DeviceState *dev)
 static void bcm2835_fb_realize(DeviceState *dev, Error **errp)
 {
     BCM2835FBState *s = BCM2835_FB(dev);
-    Error *err = NULL;
     Object *obj;
 
     if (s->vcram_base == 0) {
@@ -409,12 +408,7 @@ static void bcm2835_fb_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    obj = object_property_get_link(OBJECT(dev), "dma-mr", &err);
-    if (obj == NULL) {
-        error_setg(errp, "%s: required dma-mr link not found: %s",
-                   __func__, error_get_pretty(err));
-        return;
-    }
+    obj = object_property_get_link(OBJECT(dev), "dma-mr", &error_abort);
 
     /* Fill in the parts of initial_config that are not set by QOM properties */
     s->initial_config.xres_virtual = s->initial_config.xres;
diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
index 4cd9dab745..eb0002a2b9 100644
--- a/hw/dma/bcm2835_dma.c
+++ b/hw/dma/bcm2835_dma.c
@@ -376,16 +376,9 @@ static void bcm2835_dma_reset(DeviceState *dev)
 static void bcm2835_dma_realize(DeviceState *dev, Error **errp)
 {
     BCM2835DMAState *s = BCM2835_DMA(dev);
-    Error *err = NULL;
     Object *obj;
 
-    obj = object_property_get_link(OBJECT(dev), "dma-mr", &err);
-    if (obj == NULL) {
-        error_setg(errp, "%s: required dma-mr link not found: %s",
-                   __func__, error_get_pretty(err));
-        return;
-    }
-
+    obj = object_property_get_link(OBJECT(dev), "dma-mr", &error_abort);
     s->dma_mr = MEMORY_REGION(obj);
     address_space_init(&s->dma_as, s->dma_mr, TYPE_BCM2835_DMA "-memory");
 
diff --git a/hw/gpio/bcm2835_gpio.c b/hw/gpio/bcm2835_gpio.c
index 91ce3d10cc..abdddbc67c 100644
--- a/hw/gpio/bcm2835_gpio.c
+++ b/hw/gpio/bcm2835_gpio.c
@@ -312,22 +312,11 @@ static void bcm2835_gpio_realize(DeviceState *dev, Error **errp)
 {
     BCM2835GpioState *s = BCM2835_GPIO(dev);
     Object *obj;
-    Error *err = NULL;
 
-    obj = object_property_get_link(OBJECT(dev), "sdbus-sdhci", &err);
-    if (obj == NULL) {
-        error_setg(errp, "%s: required sdhci link not found: %s",
-                __func__, error_get_pretty(err));
-        return;
-    }
+    obj = object_property_get_link(OBJECT(dev), "sdbus-sdhci", &error_abort);
     s->sdbus_sdhci = SD_BUS(obj);
 
-    obj = object_property_get_link(OBJECT(dev), "sdbus-sdhost", &err);
-    if (obj == NULL) {
-        error_setg(errp, "%s: required sdhost link not found: %s",
-                __func__, error_get_pretty(err));
-        return;
-    }
+    obj = object_property_get_link(OBJECT(dev), "sdbus-sdhost", &error_abort);
     s->sdbus_sdhost = SD_BUS(obj);
 }
 
diff --git a/hw/intc/nios2_iic.c b/hw/intc/nios2_iic.c
index 3a5d86c2a4..1a5df8c89a 100644
--- a/hw/intc/nios2_iic.c
+++ b/hw/intc/nios2_iic.c
@@ -66,14 +66,8 @@ static void altera_iic_init(Object *obj)
 static void altera_iic_realize(DeviceState *dev, Error **errp)
 {
     struct AlteraIIC *pv = ALTERA_IIC(dev);
-    Error *err = NULL;
 
-    pv->cpu = object_property_get_link(OBJECT(dev), "cpu", &err);
-    if (!pv->cpu) {
-        error_setg(errp, "altera,iic: CPU link not found: %s",
-                   error_get_pretty(err));
-        return;
-    }
+    pv->cpu = object_property_get_link(OBJECT(dev), "cpu", &error_abort);
 }
 
 static void altera_iic_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/bcm2835_mbox.c b/hw/misc/bcm2835_mbox.c
index 2afa06a746..9f73cbd5e4 100644
--- a/hw/misc/bcm2835_mbox.c
+++ b/hw/misc/bcm2835_mbox.c
@@ -308,15 +308,8 @@ static void bcm2835_mbox_realize(DeviceState *dev, Error **errp)
 {
     BCM2835MboxState *s = BCM2835_MBOX(dev);
     Object *obj;
-    Error *err = NULL;
-
-    obj = object_property_get_link(OBJECT(dev), "mbox-mr", &err);
-    if (obj == NULL) {
-        error_setg(errp, "%s: required mbox-mr link not found: %s",
-                   __func__, error_get_pretty(err));
-        return;
-    }
 
+    obj = object_property_get_link(OBJECT(dev), "mbox-mr", &error_abort);
     s->mbox_mr = MEMORY_REGION(obj);
     address_space_init(&s->mbox_as, s->mbox_mr, TYPE_BCM2835_MBOX "-memory");
     bcm2835_mbox_reset(dev);
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 3e228ca0ae..73941bdae9 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -392,24 +392,11 @@ static void bcm2835_property_realize(DeviceState *dev, Error **errp)
 {
     BCM2835PropertyState *s = BCM2835_PROPERTY(dev);
     Object *obj;
-    Error *err = NULL;
-
-    obj = object_property_get_link(OBJECT(dev), "fb", &err);
-    if (obj == NULL) {
-        error_setg(errp, "%s: required fb link not found: %s",
-                   __func__, error_get_pretty(err));
-        return;
-    }
 
+    obj = object_property_get_link(OBJECT(dev), "fb", &error_abort);
     s->fbdev = BCM2835_FB(obj);
 
-    obj = object_property_get_link(OBJECT(dev), "dma-mr", &err);
-    if (obj == NULL) {
-        error_setg(errp, "%s: required dma-mr link not found: %s",
-                   __func__, error_get_pretty(err));
-        return;
-    }
-
+    obj = object_property_get_link(OBJECT(dev), "dma-mr", &error_abort);
     s->dma_mr = MEMORY_REGION(obj);
     address_space_init(&s->dma_as, s->dma_mr, TYPE_BCM2835_PROPERTY "-memory");
 
diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
index 72cbd051f3..56f91f6bee 100644
--- a/hw/usb/hcd-dwc2.c
+++ b/hw/usb/hcd-dwc2.c
@@ -1274,15 +1274,8 @@ static void dwc2_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     DWC2State *s = DWC2_USB(dev);
     Object *obj;
-    Error *err = NULL;
 
-    obj = object_property_get_link(OBJECT(dev), "dma-mr", &err);
-    if (err) {
-        error_setg(errp, "dwc2: required dma-mr link not found: %s",
-                   error_get_pretty(err));
-        return;
-    }
-    assert(obj != NULL);
+    obj = object_property_get_link(OBJECT(dev), "dma-mr", &error_abort);
 
     s->dma_mr = MEMORY_REGION(obj);
     address_space_init(&s->dma_as, s->dma_mr, "dwc2");
-- 
2.26.2


