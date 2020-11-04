Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EA0C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 12:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB9D208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 12:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1WKYtkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB9D208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaHkY-0004QQ-0U
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 07:18:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaHfU-0007Zl-21
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 07:13:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaHfR-0007pQ-Sp
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 07:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604492013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=646hBwDT3ly74j+7kRJ85Jb/eYj/a88qAi8iM6HKKUM=;
 b=S1WKYtkOxwycJyxtQ4nJAL/YvvC3rNKtpXwAL+lUdRu/R2AyrLpINkR7WaeSISyUqG4C1h
 cl7Tu31dCP5U/0M3rQpG54t7bpWrZqR5y462JAVZGRDIFVN26srGOmTLnNmVRs4Gir1OHW
 iDGvB4fhyTg+Q80d52PDOt64cvfBpvk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-4YShpDS5MKGyQ7Ebodd7xw-1; Wed, 04 Nov 2020 07:13:28 -0500
X-MC-Unique: 4YShpDS5MKGyQ7Ebodd7xw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92C7B804749;
 Wed,  4 Nov 2020 12:13:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2843676649;
 Wed,  4 Nov 2020 12:13:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 770539C87; Wed,  4 Nov 2020 13:13:21 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/8] dev-serial: replace DeviceOutVendor/DeviceInVendor with
 equivalent macros from usb.h
Date: Wed,  4 Nov 2020 13:13:18 +0100
Message-Id: <20201104121321.7772-6-kraxel@redhat.com>
In-Reply-To: <20201104121321.7772-1-kraxel@redhat.com>
References: <20201104121321.7772-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

The DeviceOutVendor and DeviceInVendor macros can be replaced with their
equivalent VendorDeviceOutRequest and VendorDeviceRequest macros from usb.h.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20201027150456.24606-6-mark.cave-ayland@ilande.co.uk
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-serial.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index badf8785db46..92c35615eb13 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -37,11 +37,6 @@
 #define FTDI_SET_LATENCY       9
 #define FTDI_GET_LATENCY       10
 
-#define DeviceOutVendor \
-           ((USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE) << 8)
-#define DeviceInVendor \
-           ((USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE) << 8)
-
 /* RESET */
 
 #define FTDI_RESET_SIO 0
@@ -253,7 +248,7 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
         break;
 
     /* Class specific requests.  */
-    case DeviceOutVendor | FTDI_RESET:
+    case VendorDeviceOutRequest | FTDI_RESET:
         switch (value) {
         case FTDI_RESET_SIO:
             usb_serial_reset(s);
@@ -268,7 +263,7 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
             break;
         }
         break;
-    case DeviceOutVendor | FTDI_SET_MDM_CTRL:
+    case VendorDeviceOutRequest | FTDI_SET_MDM_CTRL:
     {
         static int flags;
         qemu_chr_fe_ioctl(&s->cs, CHR_IOCTL_SERIAL_GET_TIOCM, &flags);
@@ -289,10 +284,10 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
         qemu_chr_fe_ioctl(&s->cs, CHR_IOCTL_SERIAL_SET_TIOCM, &flags);
         break;
     }
-    case DeviceOutVendor | FTDI_SET_FLOW_CTRL:
+    case VendorDeviceOutRequest | FTDI_SET_FLOW_CTRL:
         /* TODO: ioctl */
         break;
-    case DeviceOutVendor | FTDI_SET_BAUD: {
+    case VendorDeviceOutRequest | FTDI_SET_BAUD: {
         static const int subdivisors8[8] = { 0, 4, 2, 1, 3, 5, 6, 7 };
         int subdivisor8 = subdivisors8[((value & 0xc000) >> 14)
                                      | ((index & 1) << 2)];
@@ -311,7 +306,7 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
         qemu_chr_fe_ioctl(&s->cs, CHR_IOCTL_SERIAL_SET_PARAMS, &s->params);
         break;
     }
-    case DeviceOutVendor | FTDI_SET_DATA:
+    case VendorDeviceOutRequest | FTDI_SET_DATA:
         switch (value & FTDI_PARITY) {
         case 0:
             s->params.parity = 'N';
@@ -346,23 +341,23 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
         qemu_chr_fe_ioctl(&s->cs, CHR_IOCTL_SERIAL_SET_PARAMS, &s->params);
         /* TODO: TX ON/OFF */
         break;
-    case DeviceInVendor | FTDI_GET_MDM_ST:
+    case VendorDeviceRequest | FTDI_GET_MDM_ST:
         data[0] = usb_get_modem_lines(s) | 1;
         data[1] = FTDI_THRE | FTDI_TEMT;
         p->actual_length = 2;
         break;
-    case DeviceOutVendor | FTDI_SET_EVENT_CHR:
+    case VendorDeviceOutRequest | FTDI_SET_EVENT_CHR:
         /* TODO: handle it */
         s->event_chr = value;
         break;
-    case DeviceOutVendor | FTDI_SET_ERROR_CHR:
+    case VendorDeviceOutRequest | FTDI_SET_ERROR_CHR:
         /* TODO: handle it */
         s->error_chr = value;
         break;
-    case DeviceOutVendor | FTDI_SET_LATENCY:
+    case VendorDeviceOutRequest | FTDI_SET_LATENCY:
         s->latency = value;
         break;
-    case DeviceInVendor | FTDI_GET_LATENCY:
+    case VendorDeviceRequest | FTDI_GET_LATENCY:
         data[0] = s->latency;
         p->actual_length = 1;
         break;
-- 
2.27.0


