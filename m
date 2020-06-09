Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C8DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:14:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A35E020734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="crKAAYW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35E020734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihpR-00055h-Tt
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihIH-0004dT-Bo
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:40:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47643
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihHx-0003F6-2a
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591720785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=soXhsD/2KeGI/aRQuZsVUlrlAICwJkQgVifUzeNFqLE=;
 b=crKAAYW9mWQBDIQ02H1xHr1cCwEm5hLQ9yjiBZm/vcusqbrjWJGOgXbtv0DOquv0guxAMj
 /xxwJXrzr+RbeYqBWfHbQ6aTMSPr61ZcRf9z5tx6hoN81JM8/ih33Nio/D9xcOHeSAIrWS
 gf0OEgFL5i5ckFnl4+4BZWZqxIBsgIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-mngYktvsMEeFSL9BXjs6iQ-1; Tue, 09 Jun 2020 12:39:43 -0400
X-MC-Unique: mngYktvsMEeFSL9BXjs6iQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 796FA1005512
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2020 16:39:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81C3619D82;
 Tue,  9 Jun 2020 16:39:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2C6AF1138471; Tue,  9 Jun 2020 18:39:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 27/39] usb: Convert uses of usb_create()
Date: Tue,  9 Jun 2020 18:39:20 +0200
Message-Id: <20200609163932.1566209-28-armbru@redhat.com>
In-Reply-To: <20200609163932.1566209-1-armbru@redhat.com>
References: <20200609163932.1566209-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:44:16
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
---
 include/hw/usb.h    |  3 +--
 hw/usb/bus.c        | 11 +++++------
 hw/usb/dev-serial.c |  4 ++--
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/hw/usb.h b/include/hw/usb.h
index 2d2730f161..86093d941a 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -532,8 +532,7 @@ void usb_bus_new(USBBus *bus, size_t bus_size,
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


