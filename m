Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A03C18E7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:25:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F4832075B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F4832075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39114 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTNVG-0001X2-Le
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 05:25:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hTNTi-0000dO-FC
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hTNTh-0001KT-9y
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:24:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hTNTh-0001J2-2V
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:24:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF33E81E0B
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 09:23:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0AD431001E81;
	Wed, 22 May 2019 09:23:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 22D5CA206; Wed, 22 May 2019 11:23:51 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 11:23:49 +0200
Message-Id: <20190522092351.17920-4-kraxel@redhat.com>
In-Reply-To: <20190522092351.17920-1-kraxel@redhat.com>
References: <20190522092351.17920-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Wed, 22 May 2019 09:23:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/5] usb-hub: add helpers to update port state
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

Add usb_hub_port_set() and usb_hub_port_clear() helpers which care about
updating the change bits (port->wPortChange) properly, so we don't need
to have that logic sprinkled all over the place ;)

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-hub.c | 84 ++++++++++++++++++++++++++----------------------
 1 file changed, 45 insertions(+), 39 deletions(-)

diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index d25ac1817995..4940280264b4 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -159,18 +159,46 @@ static const uint8_t qemu_hub_hub_descriptor[] =
         /* DeviceRemovable and PortPwrCtrlMask patched in later */
 };
 
+static bool usb_hub_port_change(USBHubPort *port, uint16_t status)
+{
+    bool notify = false;
+
+    if (status & 0x1f) {
+        port->wPortChange |= status;
+        notify = true;
+    }
+    return notify;
+}
+
+static bool usb_hub_port_set(USBHubPort *port, uint16_t status)
+{
+    if (port->wPortStatus & status) {
+        return false;
+    }
+    port->wPortStatus |= status;
+    return usb_hub_port_change(port, status);
+}
+
+static bool usb_hub_port_clear(USBHubPort *port, uint16_t status)
+{
+    if (!(port->wPortStatus & status)) {
+        return false;
+    }
+    port->wPortStatus &= ~status;
+    return usb_hub_port_change(port, status);
+}
+
 static void usb_hub_attach(USBPort *port1)
 {
     USBHubState *s = port1->opaque;
     USBHubPort *port = &s->ports[port1->index];
 
     trace_usb_hub_attach(s->dev.addr, port1->index + 1);
-    port->wPortStatus |= PORT_STAT_CONNECTION;
-    port->wPortChange |= PORT_STAT_C_CONNECTION;
+    usb_hub_port_set(port, PORT_STAT_CONNECTION);
     if (port->port.dev->speed == USB_SPEED_LOW) {
-        port->wPortStatus |= PORT_STAT_LOW_SPEED;
+        usb_hub_port_set(port, PORT_STAT_LOW_SPEED);
     } else {
-        port->wPortStatus &= ~PORT_STAT_LOW_SPEED;
+        usb_hub_port_clear(port, PORT_STAT_LOW_SPEED);
     }
     usb_wakeup(s->intr, 0);
 }
@@ -186,16 +214,9 @@ static void usb_hub_detach(USBPort *port1)
     /* Let upstream know the device on this port is gone */
     s->dev.port->ops->child_detach(s->dev.port, port1->dev);
 
-    port->wPortStatus &= ~PORT_STAT_CONNECTION;
-    port->wPortChange |= PORT_STAT_C_CONNECTION;
-    if (port->wPortStatus & PORT_STAT_ENABLE) {
-        port->wPortStatus &= ~PORT_STAT_ENABLE;
-        port->wPortChange |= PORT_STAT_C_ENABLE;
-    }
-    if (port->wPortStatus & PORT_STAT_SUSPEND) {
-        port->wPortStatus &= ~PORT_STAT_SUSPEND;
-        port->wPortChange |= PORT_STAT_C_SUSPEND;
-    }
+    usb_hub_port_clear(port, PORT_STAT_CONNECTION);
+    usb_hub_port_clear(port, PORT_STAT_ENABLE);
+    usb_hub_port_clear(port, PORT_STAT_SUSPEND);
     usb_wakeup(s->intr, 0);
 }
 
@@ -212,9 +233,7 @@ static void usb_hub_wakeup(USBPort *port1)
     USBHubState *s = port1->opaque;
     USBHubPort *port = &s->ports[port1->index];
 
-    if (port->wPortStatus & PORT_STAT_SUSPEND) {
-        port->wPortStatus &= ~PORT_STAT_SUSPEND;
-        port->wPortChange |= PORT_STAT_C_SUSPEND;
+    if (usb_hub_port_clear(port, PORT_STAT_SUSPEND)) {
         usb_wakeup(s->intr, 0);
     }
 }
@@ -265,13 +284,13 @@ static void usb_hub_handle_reset(USBDevice *dev)
     trace_usb_hub_reset(s->dev.addr);
     for (i = 0; i < s->num_ports; i++) {
         port = s->ports + i;
-        port->wPortStatus = PORT_STAT_POWER;
+        port->wPortStatus = 0;
         port->wPortChange = 0;
+        usb_hub_port_set(port, PORT_STAT_POWER);
         if (port->port.dev && port->port.dev->attached) {
-            port->wPortStatus |= PORT_STAT_CONNECTION;
-            port->wPortChange |= PORT_STAT_C_CONNECTION;
+            usb_hub_port_set(port, PORT_STAT_CONNECTION);
             if (port->port.dev->speed == USB_SPEED_LOW) {
-                port->wPortStatus |= PORT_STAT_LOW_SPEED;
+                usb_hub_port_set(port, PORT_STAT_LOW_SPEED);
             }
         }
     }
@@ -372,13 +391,13 @@ static void usb_hub_handle_control(USBDevice *dev, USBPacket *p,
                 port->wPortStatus |= PORT_STAT_SUSPEND;
                 break;
             case PORT_RESET:
+                usb_hub_port_set(port, PORT_STAT_RESET);
+                usb_hub_port_clear(port, PORT_STAT_RESET);
                 if (dev && dev->attached) {
                     usb_device_reset(dev);
-                    port->wPortChange |= PORT_STAT_C_RESET;
-                    /* set enable bit */
-                    port->wPortStatus |= PORT_STAT_ENABLE;
-                    usb_wakeup(s->intr, 0);
+                    usb_hub_port_set(port, PORT_STAT_ENABLE);
                 }
+                usb_wakeup(s->intr, 0);
                 break;
             case PORT_POWER:
                 break;
@@ -407,20 +426,7 @@ static void usb_hub_handle_control(USBDevice *dev, USBPacket *p,
                 port->wPortChange &= ~PORT_STAT_C_ENABLE;
                 break;
             case PORT_SUSPEND:
-                if (port->wPortStatus & PORT_STAT_SUSPEND) {
-                    port->wPortStatus &= ~PORT_STAT_SUSPEND;
-
-                    /*
-                     * USB Spec rev2.0 11.24.2.7.2.3 C_PORT_SUSPEND
-                     * "This bit is set on the following transitions:
-                     *  - On transition from the Resuming state to the
-                     *    SendEOP [sic] state"
-                     *
-                     * Note that this includes both remote wake-up and
-                     * explicit ClearPortFeature(PORT_SUSPEND).
-                     */
-                    port->wPortChange |= PORT_STAT_C_SUSPEND;
-                }
+                usb_hub_port_clear(port, PORT_STAT_SUSPEND);
                 break;
             case PORT_C_SUSPEND:
                 port->wPortChange &= ~PORT_STAT_C_SUSPEND;
-- 
2.18.1


