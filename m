Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFD5C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 07:10:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2261F21841
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 07:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2261F21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50199 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU4Lc-00038t-9J
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 03:10:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hU4EY-0005PS-Tx
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hU4EX-0006Hq-0U
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:03:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hU4EV-0006GE-2F
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:03:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14D73308793A
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 07:03:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-101.ams2.redhat.com
	[10.36.116.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 85F9817D5D;
	Fri, 24 May 2019 07:03:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id DBE311753B; Fri, 24 May 2019 09:03:10 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 09:03:09 +0200
Message-Id: <20190524070310.4952-5-kraxel@redhat.com>
In-Reply-To: <20190524070310.4952-1-kraxel@redhat.com>
References: <20190524070310.4952-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Fri, 24 May 2019 07:03:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 4/5] usb-hub: add usb_hub_port_update()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Helper function to update port status bits which depends on the
connected device.  We need the same logic for device attach and
port reset, so factor it out.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-hub.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index 1cc92a5f9abe..29f4d6723e26 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -188,18 +188,28 @@ static bool usb_hub_port_clear(USBHubPort *port, uint16_t status)
     return usb_hub_port_change(port, status);
 }
 
+static bool usb_hub_port_update(USBHubPort *port)
+{
+    bool notify = false;
+
+    if (port->port.dev && port->port.dev->attached) {
+        notify = usb_hub_port_set(port, PORT_STAT_CONNECTION);
+        if (port->port.dev->speed == USB_SPEED_LOW) {
+            usb_hub_port_set(port, PORT_STAT_LOW_SPEED);
+        } else {
+            usb_hub_port_clear(port, PORT_STAT_LOW_SPEED);
+        }
+    }
+    return notify;
+}
+
 static void usb_hub_attach(USBPort *port1)
 {
     USBHubState *s = port1->opaque;
     USBHubPort *port = &s->ports[port1->index];
 
     trace_usb_hub_attach(s->dev.addr, port1->index + 1);
-    usb_hub_port_set(port, PORT_STAT_CONNECTION);
-    if (port->port.dev->speed == USB_SPEED_LOW) {
-        usb_hub_port_set(port, PORT_STAT_LOW_SPEED);
-    } else {
-        usb_hub_port_clear(port, PORT_STAT_LOW_SPEED);
-    }
+    usb_hub_port_update(port);
     usb_wakeup(s->intr, 0);
 }
 
@@ -287,12 +297,7 @@ static void usb_hub_handle_reset(USBDevice *dev)
         port->wPortStatus = 0;
         port->wPortChange = 0;
         usb_hub_port_set(port, PORT_STAT_POWER);
-        if (port->port.dev && port->port.dev->attached) {
-            usb_hub_port_set(port, PORT_STAT_CONNECTION);
-            if (port->port.dev->speed == USB_SPEED_LOW) {
-                usb_hub_port_set(port, PORT_STAT_LOW_SPEED);
-            }
-        }
+        usb_hub_port_update(port);
     }
 }
 
-- 
2.18.1


