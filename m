Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79690C388F9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F326C223B0
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F326C223B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWy6V-0003xq-1t
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 04:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kWxxz-0003Nc-CT
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 04:35:00 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:47004
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kWxxw-00065t-LC
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 04:34:59 -0400
Received: from host86-148-103-79.range86-148.btcentralplus.com
 ([86.148.103.79] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kWxy1-00082O-NC; Mon, 26 Oct 2020 08:35:04 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	kraxel@redhat.com,
	samuel.thibault@ens-lyon.org
Date: Mon, 26 Oct 2020 08:34:01 +0000
Message-Id: <20201026083401.13231-10-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201026083401.13231-1-mark.cave-ayland@ilande.co.uk>
References: <20201026083401.13231-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.148.103.79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 9/9] dev-serial: store flow control and xon/xoff characters
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Note that whilst the device does not do anything with these values, they are
logged with trace events and stored to allow future implementation.

The default flow control is set to none at reset as documented in the Linux
ftdi_sio.h header file.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/usb/dev-serial.c | 38 +++++++++++++++++++++++++++++++++++---
 hw/usb/trace-events |  2 ++
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index fa734bcf54..3dbc56d77a 100644
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
index 0d0a3e5f2a..725b7077ad 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -331,3 +331,5 @@ usb_serial_unsupported_data_bits(int bus, int addr, int value) "dev %d:%d unsupp
 usb_serial_bad_token(int bus, int addr) "dev %d:%d bad token"
 usb_serial_set_baud(int bus, int addr, int baud) "dev %d:%d baud rate %d"
 usb_serial_set_data(int bus, int addr, int parity, int data, int stop) "dev %d:%d parity %c, data bits %d, stop bits %d"
+usb_serial_set_flow_control(int bus, int addr, int index) "dev %d:%d flow control %d"
+usb_serial_set_xonxoff(int bus, int addr, uint8_t xon, uint8_t xoff) "dev %d:%d xon 0x%x xoff 0x%x"
-- 
2.20.1


