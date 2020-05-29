Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B047C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:14:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 265E420707
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yvf9g4aA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 265E420707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jefmS-0003Sh-BG
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 10:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKb-0003Hu-5q
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:45:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56287
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKN-00079S-LP
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590759938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P6ei+aO6naCGPkC88fAgnApcwVhA1I29cDgQ5A2CG1U=;
 b=Yvf9g4aAUMMRWJdbSGBm1VV9sIz64YNX060GZeHcJMlnEyyB91+ZQajDVNB8jPFMkRJ6e4
 83Jk0y+3IstOSZi11VzxPg+RGG5pdzce9MwpcjbdJaycAiiWmxZXeKGBDFO4XiPRboJY76
 kvGBOqYsRZWBe/FzIelE/Y0WZ5XG4bU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-lCds9nHpN5KiawtEELu-zQ-1; Fri, 29 May 2020 09:45:35 -0400
X-MC-Unique: lCds9nHpN5KiawtEELu-zQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AC62107ACF8
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 13:45:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7ADF72B6F7;
 Fri, 29 May 2020 13:45:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3F0C01135221; Fri, 29 May 2020 15:45:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 29/58] usb: Eliminate usb_try_create_simple()
Date: Fri, 29 May 2020 15:44:54 +0200
Message-Id: <20200529134523.8477-30-armbru@redhat.com>
In-Reply-To: <20200529134523.8477-1-armbru@redhat.com>
References: <20200529134523.8477-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

usb_try_create_simple() is qdev_try_new() and qdev_realize_and_unref()
with more verbose error messages.  Of its two users, one ignores
errors, and the other asserts they are impossible.

Make them use qdev_try_new() and qdev_realize_and_unref() directly,
and eliminate usb_try_create_simple

Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/bus.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 5c4d31614e..a81aee2051 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -318,35 +318,22 @@ USBDevice *usb_new(const char *name)
     return USB_DEVICE(qdev_new(name));
 }
 
+static USBDevice *usb_try_new(const char *name)
+{
+    return USB_DEVICE(qdev_try_new(name));
+}
+
 bool usb_realize_and_unref(USBDevice *dev, USBBus *bus, Error **errp)
 {
     return qdev_realize_and_unref(&dev->qdev, &bus->qbus, errp);
 }
 
-static USBDevice *usb_try_create_simple(USBBus *bus, const char *name,
-                                        Error **errp)
-{
-    Error *err = NULL;
-    DeviceState *dev;
-
-    dev = qdev_try_new(name);
-    if (!dev) {
-        error_setg(errp, "Failed to create USB device '%s'", name);
-        return NULL;
-    }
-    qdev_realize_and_unref(dev, &bus->qbus, &err);
-    if (err) {
-        error_propagate_prepend(errp, err,
-                                "Failed to initialize USB device '%s': ",
-                                name);
-        return NULL;
-    }
-    return USB_DEVICE(dev);
-}
-
 USBDevice *usb_create_simple(USBBus *bus, const char *name)
 {
-    return usb_try_create_simple(bus, name, &error_abort);
+    USBDevice *dev = usb_new(name);
+
+    usb_realize_and_unref(dev, bus, &error_abort);
+    return dev;
 }
 
 static void usb_fill_port(USBPort *port, void *opaque, int index,
@@ -426,6 +413,7 @@ void usb_claim_port(USBDevice *dev, Error **errp)
 {
     USBBus *bus = usb_bus_from_device(dev);
     USBPort *port;
+    USBDevice *hub;
 
     assert(dev->port == NULL);
 
@@ -443,7 +431,10 @@ void usb_claim_port(USBDevice *dev, Error **errp)
     } else {
         if (bus->nfree == 1 && strcmp(object_get_typename(OBJECT(dev)), "usb-hub") != 0) {
             /* Create a new hub and chain it on */
-            usb_try_create_simple(bus, "usb-hub", NULL);
+            hub = usb_try_new("usb-hub");
+            if (hub) {
+                usb_realize_and_unref(hub, bus, NULL);
+            }
         }
         if (bus->nfree == 0) {
             error_setg(errp, "tried to attach usb device %s to a bus "
-- 
2.21.3


