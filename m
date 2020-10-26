Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E720DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:36:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75881223B0
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75881223B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWxzR-00059a-Bk
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 04:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kWxxm-0003KE-Rx
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 04:34:50 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:46980
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kWxxj-00061K-Sh
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 04:34:46 -0400
Received: from host86-148-103-79.range86-148.btcentralplus.com
 ([86.148.103.79] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kWxxo-00082O-Ps; Mon, 26 Oct 2020 08:34:52 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	kraxel@redhat.com,
	samuel.thibault@ens-lyon.org
Date: Mon, 26 Oct 2020 08:33:58 +0000
Message-Id: <20201026083401.13231-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201026083401.13231-1-mark.cave-ayland@ilande.co.uk>
References: <20201026083401.13231-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.148.103.79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 6/9] dev-serial: add always-plugged property to ensure USB
 device is always attached
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

Some operating systems will generate a new device ID when a USB device is unplugged
and then replugged into the USB. If this is done whilst switching between multiple
applications over a virtual serial port, the change of device ID requires going
back into the OS/application to locate the new device accordingly.

Add a new always-plugged property that if specified will ensure that the device
always remains attached to the USB regardless of the state of the backend
chardev.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/usb/dev-serial.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 92c35615eb..919e25e1d9 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -97,6 +97,7 @@ struct USBSerialState {
     uint8_t event_chr;
     uint8_t error_chr;
     uint8_t event_trigger;
+    bool always_plugged;
     QEMUSerialSetParams params;
     int latency;        /* ms */
     CharBackend cs;
@@ -516,12 +517,12 @@ static void usb_serial_event(void *opaque, QEMUChrEvent event)
         s->event_trigger |= FTDI_BI;
         break;
     case CHR_EVENT_OPENED:
-        if (!s->dev.attached) {
+        if (!s->always_plugged && !s->dev.attached) {
             usb_device_attach(&s->dev, &error_abort);
         }
         break;
     case CHR_EVENT_CLOSED:
-        if (s->dev.attached) {
+        if (!s->always_plugged && s->dev.attached) {
             usb_device_detach(&s->dev);
         }
         break;
@@ -556,7 +557,8 @@ static void usb_serial_realize(USBDevice *dev, Error **errp)
                              usb_serial_event, NULL, s, NULL, true);
     usb_serial_handle_reset(dev);
 
-    if (qemu_chr_fe_backend_open(&s->cs) && !dev->attached) {
+    if (s->always_plugged || (qemu_chr_fe_backend_open(&s->cs) &&
+                              !dev->attached)) {
         usb_device_attach(dev, &error_abort);
     }
     s->intr = usb_ep_get(dev, USB_TOKEN_IN, 1);
@@ -584,6 +586,7 @@ static const VMStateDescription vmstate_usb_serial = {
 
 static Property serial_properties[] = {
     DEFINE_PROP_CHR("chardev", USBSerialState, cs),
+    DEFINE_PROP_BOOL("always-plugged", USBSerialState, always_plugged, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.20.1


