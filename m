Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CB5C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 21:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA47E20768
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 21:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0qSN3CP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA47E20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkwD3-00018K-0T
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 17:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkvuZ-0003Mv-V7
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:40:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24667
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkvuR-0000d1-M3
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592253646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=whzQ2rQ8aItYupC++NkCQJEs7r2LWHqlF6HGaI4+cUY=;
 b=R0qSN3CPt0fZGkOf71Mu4Dkc2S+kISfdzaKbb7vqhc2Qh6FHDnnti6vxPvXknCFKfHN2Ie
 pbLG49M+UJpBHjYT0ZCdIRZZ2P+3vP04vr54E6YIvXZgKqIgbIKUE7KuwZyywimAb7WdHp
 hgT4v3mn1sphtDbKfS73e0xpwbxDgpc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-xbrXDsKdMKiBy9ZnqwHW0A-1; Mon, 15 Jun 2020 16:40:44 -0400
X-MC-Unique: xbrXDsKdMKiBy9ZnqwHW0A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35C56100CCC2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 20:40:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 20E4F5C1D6;
 Mon, 15 Jun 2020 20:40:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DC8521132DDF; Mon, 15 Jun 2020 22:40:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 53/84] usb: Convert uses of usb_create()
Date: Mon, 15 Jun 2020 22:39:37 +0200
Message-Id: <20200615204008.3069956-54-armbru@redhat.com>
In-Reply-To: <20200615204008.3069956-1-armbru@redhat.com>
References: <20200615204008.3069956-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 16:40:20
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace

    dev = usb_create(bus, type_name);
    ...
    object_property_set_bool(OBJECT(dev), true, "realized", &err);

by

    dev = isa_new(type_name);
    ...
    usb_realize_and_unref(dev, bus, &err);

Recent commit "qdev: New qdev_new(), qdev_realize(), etc." explains
why.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20200610053247.1583243-28-armbru@redhat.com>
---
 include/hw/usb.h    |  3 +--
 hw/usb/bus.c        | 11 +++++------
 hw/usb/dev-serial.c |  4 ++--
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/hw/usb.h b/include/hw/usb.h
index 1cc0ba0fed..dce16c792b 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -502,8 +502,7 @@ void usb_bus_new(USBBus *bus, size_t bus_size,
 void usb_bus_release(USBBus *bus);
 USBBus *usb_bus_find(int busnr);
 void usb_legacy_register(const char *typename, const char *usbdevice_name,
-                         USBDevice *(*usbdevice_init)(USBBus *bus,
-                                                      const char *params));
+                         USBDevice *(*usbdevice_init)(const char *params));
 USBDevice *usb_new(const char *name);
 bool usb_realize_and_unref(USBDevice *dev, USBBus *bus, Error **errp);
 USBDevice *usb_create(USBBus *bus, const char *name);
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 6b0d9f9e4d..da85b8b005 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -296,14 +296,13 @@ typedef struct LegacyUSBFactory
 {
     const char *name;
     const char *usbdevice_name;
-    USBDevice *(*usbdevice_init)(USBBus *bus, const char *params);
+    USBDevice *(*usbdevice_init)(const char *params);
 } LegacyUSBFactory;
 
 static GSList *legacy_usb_factory;
 
 void usb_legacy_register(const char *typename, const char *usbdevice_name,
-                         USBDevice *(*usbdevice_init)(USBBus *bus,
-                                                      const char *params))
+                         USBDevice *(*usbdevice_init)(const char *params))
 {
     if (usbdevice_name) {
         LegacyUSBFactory *f = g_malloc0(sizeof(*f));
@@ -710,19 +709,19 @@ USBDevice *usbdevice_create(const char *cmdline)
     }
 
     if (f->usbdevice_init) {
-        dev = f->usbdevice_init(bus, params);
+        dev = f->usbdevice_init(params);
     } else {
         if (*params) {
             error_report("usbdevice %s accepts no params", driver);
             return NULL;
         }
-        dev = usb_create(bus, f->name);
+        dev = usb_new(f->name);
     }
     if (!dev) {
         error_report("Failed to create USB device '%s'", f->name);
         return NULL;
     }
-    object_property_set_bool(OBJECT(dev), true, "realized", &err);
+    usb_realize_and_unref(dev, bus, &err);
     if (err) {
         error_reportf_err(err, "Failed to initialize USB device '%s': ",
                           f->name);
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index d2c03681b7..7e50e3ba47 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -542,7 +542,7 @@ static void usb_serial_realize(USBDevice *dev, Error **errp)
     s->intr = usb_ep_get(dev, USB_TOKEN_IN, 1);
 }
 
-static USBDevice *usb_braille_init(USBBus *bus, const char *unused)
+static USBDevice *usb_braille_init(const char *unused)
 {
     USBDevice *dev;
     Chardev *cdrv;
@@ -551,7 +551,7 @@ static USBDevice *usb_braille_init(USBBus *bus, const char *unused)
     if (!cdrv)
         return NULL;
 
-    dev = usb_create(bus, "usb-braille");
+    dev = usb_new("usb-braille");
     qdev_prop_set_chr(&dev->qdev, "chardev", cdrv);
     return dev;
 }
-- 
2.26.2


