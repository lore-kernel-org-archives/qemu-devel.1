Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D25C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 08:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DCBF20665
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 08:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5sEpTSC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DCBF20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBZWO-0002hd-Mg
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 04:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kBZRX-0000fK-Mu
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 04:09:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27040)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kBZRS-0003RL-1A
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 04:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598602135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1xSE0n02diYqExNHwLoM1kNSqbWL0PPkSAmvh8Hm6qA=;
 b=G5sEpTSCjgJD0G4SKdfuYlD+boABpv6WjyCvVJZNs6OZI7TWg7uhm9CxqjELBt/Vf/I8e/
 rb+XSq2fZAMHoj50CpWJrvPn2zC2xC2fVPEsCq67aVI9GMnVlifOVoT52MFtfkdVTjnKFm
 lyBIdNSRHDoe7tn7lNL/Mk2GtXVMFBQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-N0VhRDSnMaWu7A3fx7C_2Q-1; Fri, 28 Aug 2020 04:08:52 -0400
X-MC-Unique: N0VhRDSnMaWu7A3fx7C_2Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3E7E10082EC;
 Fri, 28 Aug 2020 08:08:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E127819D7C;
 Fri, 28 Aug 2020 08:08:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 14BCE204AE; Fri, 28 Aug 2020 10:08:46 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/18] hw/usb: Regroup USB HID protocol values
Date: Fri, 28 Aug 2020 10:08:32 +0200
Message-Id: <20200828080845.28287-6-kraxel@redhat.com>
In-Reply-To: <20200828080845.28287-1-kraxel@redhat.com>
References: <20200828080845.28287-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 02:09:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: César Belley <cesar.belley@lse.epita.fr>

Group some HID values that are used pretty much everywhere when
dealing with HID devices.

Signed-off-by: César Belley <cesar.belley@lse.epita.fr>
Message-id: 20200812094135.20550-2-cesar.belley@lse.epita.fr
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/usb/hid.h | 17 +++++++++++++++++
 hw/usb/dev-hid.c     | 26 +++++++-------------------
 hw/usb/dev-wacom.c   | 12 +++---------
 3 files changed, 27 insertions(+), 28 deletions(-)
 create mode 100644 include/hw/usb/hid.h

diff --git a/include/hw/usb/hid.h b/include/hw/usb/hid.h
new file mode 100644
index 000000000000..1c142584ffab
--- /dev/null
+++ b/include/hw/usb/hid.h
@@ -0,0 +1,17 @@
+#ifndef HW_USB_HID_H
+#define HW_USB_HID_H
+
+/* HID interface requests */
+#define HID_GET_REPORT   0xa101
+#define HID_GET_IDLE     0xa102
+#define HID_GET_PROTOCOL 0xa103
+#define HID_SET_REPORT   0x2109
+#define HID_SET_IDLE     0x210a
+#define HID_SET_PROTOCOL 0x210b
+
+/* HID descriptor types */
+#define USB_DT_HID    0x21
+#define USB_DT_REPORT 0x22
+#define USB_DT_PHY    0x23
+
+#endif
diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index 89f63b698b8a..c73f7b2fe2c5 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -32,21 +32,9 @@
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/input/hid.h"
+#include "hw/usb/hid.h"
 #include "hw/qdev-properties.h"
 
-/* HID interface requests */
-#define GET_REPORT   0xa101
-#define GET_IDLE     0xa102
-#define GET_PROTOCOL 0xa103
-#define SET_REPORT   0x2109
-#define SET_IDLE     0x210a
-#define SET_PROTOCOL 0x210b
-
-/* HID descriptor types */
-#define USB_DT_HID    0x21
-#define USB_DT_REPORT 0x22
-#define USB_DT_PHY    0x23
-
 typedef struct USBHIDState {
     USBDevice dev;
     USBEndpoint *intr;
@@ -618,38 +606,38 @@ static void usb_hid_handle_control(USBDevice *dev, USBPacket *p,
             goto fail;
         }
         break;
-    case GET_REPORT:
+    case HID_GET_REPORT:
         if (hs->kind == HID_MOUSE || hs->kind == HID_TABLET) {
             p->actual_length = hid_pointer_poll(hs, data, length);
         } else if (hs->kind == HID_KEYBOARD) {
             p->actual_length = hid_keyboard_poll(hs, data, length);
         }
         break;
-    case SET_REPORT:
+    case HID_SET_REPORT:
         if (hs->kind == HID_KEYBOARD) {
             p->actual_length = hid_keyboard_write(hs, data, length);
         } else {
             goto fail;
         }
         break;
-    case GET_PROTOCOL:
+    case HID_GET_PROTOCOL:
         if (hs->kind != HID_KEYBOARD && hs->kind != HID_MOUSE) {
             goto fail;
         }
         data[0] = hs->protocol;
         p->actual_length = 1;
         break;
-    case SET_PROTOCOL:
+    case HID_SET_PROTOCOL:
         if (hs->kind != HID_KEYBOARD && hs->kind != HID_MOUSE) {
             goto fail;
         }
         hs->protocol = value;
         break;
-    case GET_IDLE:
+    case HID_GET_IDLE:
         data[0] = hs->idle;
         p->actual_length = 1;
         break;
-    case SET_IDLE:
+    case HID_SET_IDLE:
         hs->idle = (uint8_t) (value >> 8);
         hid_set_next_idle(hs);
         if (hs->kind == HID_MOUSE || hs->kind == HID_TABLET) {
diff --git a/hw/usb/dev-wacom.c b/hw/usb/dev-wacom.c
index 8aba44b8bc3d..76fc5a5dabf3 100644
--- a/hw/usb/dev-wacom.c
+++ b/hw/usb/dev-wacom.c
@@ -29,6 +29,7 @@
 #include "qemu/osdep.h"
 #include "ui/console.h"
 #include "hw/usb.h"
+#include "hw/usb/hid.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "desc.h"
@@ -37,13 +38,6 @@
 #define WACOM_GET_REPORT	0x2101
 #define WACOM_SET_REPORT	0x2109
 
-/* HID interface requests */
-#define HID_GET_REPORT		0xa101
-#define HID_GET_IDLE		0xa102
-#define HID_GET_PROTOCOL	0xa103
-#define HID_SET_IDLE		0x210a
-#define HID_SET_PROTOCOL	0x210b
-
 typedef struct USBWacomState {
     USBDevice dev;
     USBEndpoint *intr;
@@ -86,11 +80,11 @@ static const USBDescIface desc_iface_wacom = {
             /* HID descriptor */
             .data = (uint8_t[]) {
                 0x09,          /*  u8  bLength */
-                0x21,          /*  u8  bDescriptorType */
+                USB_DT_HID,    /*  u8  bDescriptorType */
                 0x01, 0x10,    /*  u16 HID_class */
                 0x00,          /*  u8  country_code */
                 0x01,          /*  u8  num_descriptors */
-                0x22,          /*  u8  type: Report */
+                USB_DT_REPORT, /*  u8  type: Report */
                 0x6e, 0,       /*  u16 len */
             },
         },
-- 
2.27.0


