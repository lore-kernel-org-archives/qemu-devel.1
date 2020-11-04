Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DD4C388F7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 12:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728C8208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 12:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0POv7zL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728C8208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaHj6-0002p9-DJ
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 07:17:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaHfa-0007m8-D6
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 07:13:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20247)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaHfY-0007qZ-Dz
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 07:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604492019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W/26RM5hlf5NGwN7ijzuGblgAmBmtVQ0RyzNJoompVY=;
 b=i0POv7zLWkxFSMocdBJc6rYA8s4j6Thy4X3FhifpGF4hnG72CwGd6luVpHF1gAeTxDyosU
 V8I+kc75qZfPQwD7230XYPTpRQkdUm3Bp6DqJ57BUlVFuvO66WAFXf41EyRm8I2pNLfgHB
 j0L1C7uaoRWQyjz3ptUeLgg4mGdpRAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-T75FN1AiNQKomESNumAHxw-1; Wed, 04 Nov 2020 07:13:37 -0500
X-MC-Unique: T75FN1AiNQKomESNumAHxw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40668804746;
 Wed,  4 Nov 2020 12:13:36 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 421B7508E1;
 Wed,  4 Nov 2020 12:13:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 97F209CAE; Wed,  4 Nov 2020 13:13:21 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 8/8] dev-serial: store flow control and xon/xoff characters
Date: Wed,  4 Nov 2020 13:13:21 +0100
Message-Id: <20201104121321.7772-9-kraxel@redhat.com>
In-Reply-To: <20201104121321.7772-1-kraxel@redhat.com>
References: <20201104121321.7772-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
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
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Note that whilst the device does not do anything with these values, they are
logged with trace events and stored to allow future implementation.

The default flow control is set to none at reset as documented in the Linux
ftdi_sio.h header file.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Message-id: 20201027150456.24606-9-mark.cave-ayland@ilande.co.uk
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-serial.c | 38 +++++++++++++++++++++++++++++++++++---
 hw/usb/trace-events |  2 ++
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index e42ce362956b..19e1933f0496 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -52,6 +52,7 @@
 
 /* SET_FLOW_CTRL */
 
+#define FTDI_NO_HS         0
 #define FTDI_RTS_CTS_HS    1
 #define FTDI_DTR_DSR_HS    2
 #define FTDI_XON_XOFF_HS   4
@@ -98,6 +99,9 @@ struct USBSerialState {
     uint8_t error_chr;
     uint8_t event_trigger;
     bool always_plugged;
+    uint8_t flow_control;
+    uint8_t xon;
+    uint8_t xoff;
     QEMUSerialSetParams params;
     int latency;        /* ms */
     CharBackend cs;
@@ -181,14 +185,36 @@ static const USBDesc desc_braille = {
     .str  = desc_strings,
 };
 
+static void usb_serial_set_flow_control(USBSerialState *s,
+                                        uint8_t flow_control)
+{
+    USBDevice *dev = USB_DEVICE(s);
+    USBBus *bus = usb_bus_from_device(dev);
+
+    /* TODO: ioctl */
+    s->flow_control = flow_control;
+    trace_usb_serial_set_flow_control(bus->busnr, dev->addr, flow_control);
+}
+
+static void usb_serial_set_xonxoff(USBSerialState *s, int xonxoff)
+{
+    USBDevice *dev = USB_DEVICE(s);
+    USBBus *bus = usb_bus_from_device(dev);
+
+    s->xon = xonxoff & 0xff;
+    s->xoff = (xonxoff >> 8) & 0xff;
+
+    trace_usb_serial_set_xonxoff(bus->busnr, dev->addr, s->xon, s->xoff);
+}
+
 static void usb_serial_reset(USBSerialState *s)
 {
-    /* TODO: Set flow control to none */
     s->event_chr = 0x0d;
     s->event_trigger = 0;
     s->recv_ptr = 0;
     s->recv_used = 0;
     /* TODO: purge in char driver */
+    usb_serial_set_flow_control(s, FTDI_NO_HS);
 }
 
 static void usb_serial_handle_reset(USBDevice *dev)
@@ -285,9 +311,15 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
         qemu_chr_fe_ioctl(&s->cs, CHR_IOCTL_SERIAL_SET_TIOCM, &flags);
         break;
     }
-    case VendorDeviceOutRequest | FTDI_SET_FLOW_CTRL:
-        /* TODO: ioctl */
+    case VendorDeviceOutRequest | FTDI_SET_FLOW_CTRL: {
+        uint8_t flow_control = index >> 8;
+
+        usb_serial_set_flow_control(s, flow_control);
+        if (flow_control & FTDI_XON_XOFF_HS) {
+            usb_serial_set_xonxoff(s, value);
+        }
         break;
+    }
     case VendorDeviceOutRequest | FTDI_SET_BAUD: {
         static const int subdivisors8[8] = { 0, 4, 2, 1, 3, 5, 6, 7 };
         int subdivisor8 = subdivisors8[((value & 0xc000) >> 14)
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index 109da521cf4d..a3292d46248f 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -331,3 +331,5 @@ usb_serial_unsupported_data_bits(int bus, int addr, int value) "dev %d:%u unsupp
 usb_serial_bad_token(int bus, int addr) "dev %d:%u bad token"
 usb_serial_set_baud(int bus, int addr, int baud) "dev %d:%u baud rate %d"
 usb_serial_set_data(int bus, int addr, int parity, int data, int stop) "dev %d:%u parity %c, data bits %d, stop bits %d"
+usb_serial_set_flow_control(int bus, int addr, int index) "dev %d:%u flow control %d"
+usb_serial_set_xonxoff(int bus, int addr, uint8_t xon, uint8_t xoff) "dev %d:%u xon 0x%x xoff 0x%x"
-- 
2.27.0


