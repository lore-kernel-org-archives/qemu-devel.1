Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5248C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:30:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B162C21019
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B162C21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48022 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVs6P-0001UO-0I
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 02:30:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hVs4m-0000aK-EH
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hVs4l-0004eR-EW
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:28:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hVs4k-0004dg-S5
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:28:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DD9963082B5A;
	Wed, 29 May 2019 06:28:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-59.ams2.redhat.com
	[10.36.116.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B8D4064028;
	Wed, 29 May 2019 06:28:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 18A8417512; Wed, 29 May 2019 08:28:33 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 08:28:26 +0200
Message-Id: <20190529062832.26483-4-kraxel@redhat.com>
In-Reply-To: <20190529062832.26483-1-kraxel@redhat.com>
References: <20190529062832.26483-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Wed, 29 May 2019 06:28:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/9] usb-host: avoid libusb_set_configuration
 calls
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Seems some devices become confused when we call
libusb_set_configuration().  So before calling the function check
whenever the device has multiple configurations in the first place, and
in case it hasn't (which is the case for the majority of devices) simply
skip the call as it will have no effect anyway.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20190522094702.17619-4-kraxel@redhat.com
---
 hw/usb/host-libusb.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 4e9a45a5d26f..4f765d7f9a2f 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1225,19 +1225,21 @@ static void usb_host_set_address(USBHostDevice *s, int addr)
 
 static void usb_host_set_config(USBHostDevice *s, int config, USBPacket *p)
 {
-    int rc;
+    int rc = 0;
 
     trace_usb_host_set_config(s->bus_num, s->addr, config);
 
     usb_host_release_interfaces(s);
-    rc = libusb_set_configuration(s->dh, config);
-    if (rc != 0) {
-        usb_host_libusb_error("libusb_set_configuration", rc);
-        p->status = USB_RET_STALL;
-        if (rc == LIBUSB_ERROR_NO_DEVICE) {
-            usb_host_nodev(s);
+    if (s->ddesc.bNumConfigurations != 1) {
+        rc = libusb_set_configuration(s->dh, config);
+        if (rc != 0) {
+            usb_host_libusb_error("libusb_set_configuration", rc);
+            p->status = USB_RET_STALL;
+            if (rc == LIBUSB_ERROR_NO_DEVICE) {
+                usb_host_nodev(s);
+            }
+            return;
         }
-        return;
     }
     p->status = usb_host_claim_interfaces(s, config);
     if (p->status != USB_RET_SUCCESS) {
-- 
2.18.1


