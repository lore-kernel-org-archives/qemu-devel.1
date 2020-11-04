Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692A7C388F7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 12:17:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3A9208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 12:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDGGb/O8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3A9208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaHj3-0002jl-N1
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 07:17:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaHfT-0007YH-4n
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 07:13:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45389)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaHfQ-0007p3-Pu
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 07:13:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604492011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/DVrCzwUT1SrSdsomyc8nOYZmYdFgFo8XtmA/jupe0c=;
 b=SDGGb/O8TwF94jl45btPUBgsg0BToq0cW+MGOt2qtrmkRzWA0rle3ZyM09BX9qDoLg7sjB
 8EgOPZhZSp3LQfmOWPiFIkQnyIMi0n/yBrIo4Cr7J/gNETpp4DhfECIbiHgdbCoYvgymrY
 WAdOzp/KnuRAbQ+PFYmmz/+dmCqoJMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-dRwHvoJuMi-X9aPLN4fj8w-1; Wed, 04 Nov 2020 07:13:27 -0500
X-MC-Unique: dRwHvoJuMi-X9aPLN4fj8w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65C691009E39;
 Wed,  4 Nov 2020 12:13:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 45C5375129;
 Wed,  4 Nov 2020 12:13:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6135A9D16; Wed,  4 Nov 2020 13:13:21 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/8] dev-serial: convert from DPRINTF to trace-events
Date: Wed,  4 Nov 2020 13:13:16 +0100
Message-Id: <20201104121321.7772-4-kraxel@redhat.com>
In-Reply-To: <20201104121321.7772-1-kraxel@redhat.com>
References: <20201104121321.7772-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20201027150456.24606-4-mark.cave-ayland@ilande.co.uk
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-serial.c | 28 ++++++++++++++--------------
 hw/usb/trace-events |  8 ++++++++
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 77ce89d38b27..abc316c7bf1f 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -20,15 +20,8 @@
 #include "chardev/char-serial.h"
 #include "chardev/char-fe.h"
 #include "qom/object.h"
+#include "trace.h"
 
-//#define DEBUG_Serial
-
-#ifdef DEBUG_Serial
-#define DPRINTF(fmt, ...) \
-do { printf("usb-serial: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#endif
 
 #define RECV_BUF (512 - (2 * 8))
 
@@ -205,8 +198,9 @@ static void usb_serial_reset(USBSerialState *s)
 static void usb_serial_handle_reset(USBDevice *dev)
 {
     USBSerialState *s = USB_SERIAL(dev);
+    USBBus *bus = usb_bus_from_device(dev);
 
-    DPRINTF("Reset\n");
+    trace_usb_serial_reset(bus->busnr, dev->addr);
 
     usb_serial_reset(s);
     /* TODO: Reset char device, send BREAK? */
@@ -244,9 +238,11 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
                                       int length, uint8_t *data)
 {
     USBSerialState *s = USB_SERIAL(dev);
+    USBBus *bus = usb_bus_from_device(dev);
     int ret;
 
-    DPRINTF("got control %x, value %x\n", request, value);
+    trace_usb_serial_handle_control(bus->busnr, dev->addr, request, value);
+
     ret = usb_desc_handle_control(dev, p, request, value, index, length, data);
     if (ret >= 0) {
         return;
@@ -326,7 +322,8 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
             s->params.parity = 'E';
             break;
         default:
-            DPRINTF("unsupported parity %d\n", value & FTDI_PARITY);
+            trace_usb_serial_unsupported_parity(bus->busnr, dev->addr,
+                                                value & FTDI_PARITY);
             goto fail;
         }
 
@@ -338,7 +335,8 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
             s->params.stop_bits = 2;
             break;
         default:
-            DPRINTF("unsupported stop bits %d\n", value & FTDI_STOP);
+            trace_usb_serial_unsupported_stopbits(bus->busnr, dev->addr,
+                                                  value & FTDI_STOP);
             goto fail;
         }
 
@@ -367,7 +365,8 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
         break;
     default:
     fail:
-        DPRINTF("got unsupported/bogus control %x, value %x\n", request, value);
+        trace_usb_serial_unsupported_control(bus->busnr, dev->addr, request,
+                                             value);
         p->status = USB_RET_STALL;
         break;
     }
@@ -431,6 +430,7 @@ static void usb_serial_token_in(USBSerialState *s, USBPacket *p)
 static void usb_serial_handle_data(USBDevice *dev, USBPacket *p)
 {
     USBSerialState *s = USB_SERIAL(dev);
+    USBBus *bus = usb_bus_from_device(dev);
     uint8_t devep = p->ep->nr;
     struct iovec *iov;
     int i;
@@ -459,7 +459,7 @@ static void usb_serial_handle_data(USBDevice *dev, USBPacket *p)
         break;
 
     default:
-        DPRINTF("Bad token\n");
+        trace_usb_serial_bad_token(bus->busnr, dev->addr);
     fail:
         p->status = USB_RET_STALL;
         break;
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index 72e4298780b7..89f1c351e339 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -320,3 +320,11 @@ usb_host_parse_interface(int bus, int addr, int num, int alt, int active) "dev %
 usb_host_parse_endpoint(int bus, int addr, int ep, const char *dir, const char *type, int active) "dev %d:%d, ep %d, %s, %s, active %d"
 usb_host_parse_error(int bus, int addr, const char *errmsg) "dev %d:%d, msg %s"
 usb_host_remote_wakeup_removed(int bus, int addr) "dev %d:%d"
+
+# dev-serial.c
+usb_serial_reset(int bus, int addr) "dev %d:%u reset"
+usb_serial_handle_control(int bus, int addr, int request, int value) "dev %d:%u got control 0x%x, value 0x%x"
+usb_serial_unsupported_parity(int bus, int addr, int value) "dev %d:%u unsupported parity %d"
+usb_serial_unsupported_stopbits(int bus, int addr, int value) "dev %d:%u unsupported stop bits %d"
+usb_serial_unsupported_control(int bus, int addr, int request, int value) "dev %d:%u got unsupported/bogus control 0x%x, value 0x%x"
+usb_serial_bad_token(int bus, int addr) "dev %d:%u bad token"
-- 
2.27.0


