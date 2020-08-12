Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF34C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 09:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67267206DA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 09:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=lse.epita.fr header.i=@lse.epita.fr header.b="kpICI+W4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67267206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lse.epita.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5nL1-0000fC-KN
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 05:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=nna4=bw=lse.epita.fr=cesar.belley@cri.epita.fr>)
 id 1k5nHU-00025E-Gi
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 05:42:48 -0400
Received: from gate-2.cri.epita.net ([163.5.55.20]:40878
 helo=mail-2.srv.cri.epita.fr)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=nna4=bw=lse.epita.fr=cesar.belley@cri.epita.fr>)
 id 1k5nHS-0006kP-DZ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 05:42:48 -0400
Received: from MattGorko-Laptop.localdomain (unknown [78.194.154.81])
 (Authenticated sender: cesar.belley)
 by mail-2.srv.cri.epita.fr (Postfix) with ESMTPSA id 272BE4150F;
 Wed, 12 Aug 2020 11:42:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lse.epita.fr; s=cri;
 t=1597225365; bh=A0aJ8L9Xd2FkKoAD25PU7kRu/ARY6f/5I8YwtIoOcWk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kpICI+W4eaNCdnpx8rZN0+RnSgjgn/FmN+eagMSPeq5uXEP3aDavNAu1zoLIOHoCC
 AgcncBbJhuaKRTkVpglLRNWbWCYIQjnwm0L7QWHVWzg1qVp7tBTA1plaAFBepDuvK6
 rwdv1db0m0pCqqMNtEeKOHHWSJxiP+FC8754oWJI=
From: =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/13] hw/usb: Add U2F key base class implementation
Date: Wed, 12 Aug 2020 11:41:26 +0200
Message-Id: <20200812094135.20550-5-cesar.belley@lse.epita.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812094135.20550-1-cesar.belley@lse.epita.fr>
References: <20200812094135.20550-1-cesar.belley@lse.epita.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=163.5.55.20;
 envelope-from=srs0=nna4=bw=lse.epita.fr=cesar.belley@cri.epita.fr;
 helo=mail-2.srv.cri.epita.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 05:42:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>,
 kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds the U2F key base class implementation. 

The U2F key base mainly takes care of the HID interfacing with guest.
On the one hand, it retrieves the guest U2FHID packets and transmits
them to the variant associated according to the mode: pass-through
or emulated.
On the other hand, it provides the public API used by its variants to
send U2FHID packets to the guest.

Signed-off-by: César Belley <cesar.belley@lse.epita.fr>
---
 hw/usb/u2f.c | 352 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 352 insertions(+)
 create mode 100644 hw/usb/u2f.c

diff --git a/hw/usb/u2f.c b/hw/usb/u2f.c
new file mode 100644
index 0000000000..bc09191f06
--- /dev/null
+++ b/hw/usb/u2f.c
@@ -0,0 +1,352 @@
+/*
+ * U2F USB device.
+ *
+ * Copyright (c) 2020 César Belley <cesar.belley@lse.epita.fr>
+ * Written by César Belley <cesar.belley@lse.epita.fr>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "hw/usb.h"
+#include "hw/usb/hid.h"
+#include "migration/vmstate.h"
+#include "desc.h"
+
+#include "u2f.h"
+
+/* U2F key Vendor / Product */
+#define U2F_KEY_VENDOR_NUM     0x46f4 /* CRC16() of "QEMU" */
+#define U2F_KEY_PRODUCT_NUM    0x0005
+
+enum {
+    STR_MANUFACTURER = 1,
+    STR_PRODUCT,
+    STR_SERIALNUMBER,
+    STR_CONFIG,
+    STR_INTERFACE
+};
+
+static const USBDescStrings desc_strings = {
+    [STR_MANUFACTURER]     = "QEMU",
+    [STR_PRODUCT]          = "U2F USB key",
+    [STR_SERIALNUMBER]     = "0",
+    [STR_CONFIG]           = "U2F key config",
+    [STR_INTERFACE]        = "U2F key interface"
+};
+
+static const USBDescIface desc_iface_u2f_key = {
+    .bInterfaceNumber              = 0,
+    .bNumEndpoints                 = 2,
+    .bInterfaceClass               = USB_CLASS_HID,
+    .bInterfaceSubClass            = 0x0,
+    .bInterfaceProtocol            = 0x0,
+    .ndesc                         = 1,
+    .descs = (USBDescOther[]) {
+        {
+            /* HID descriptor */
+            .data = (uint8_t[]) {
+                0x09,          /*  u8  bLength */
+                USB_DT_HID,    /*  u8  bDescriptorType */
+                0x10, 0x01,    /*  u16 HID_class */
+                0x00,          /*  u8  country_code */
+                0x01,          /*  u8  num_descriptors */
+                USB_DT_REPORT, /*  u8  type: Report */
+                0x22, 0,       /*  u16 len */
+            },
+        },
+    },
+    .eps = (USBDescEndpoint[]) {
+        {
+            .bEndpointAddress      = USB_DIR_IN | 0x01,
+            .bmAttributes          = USB_ENDPOINT_XFER_INT,
+            .wMaxPacketSize        = U2FHID_PACKET_SIZE,
+            .bInterval             = 0x05,
+        }, {
+            .bEndpointAddress      = USB_DIR_OUT | 0x01,
+            .bmAttributes          = USB_ENDPOINT_XFER_INT,
+            .wMaxPacketSize        = U2FHID_PACKET_SIZE,
+            .bInterval             = 0x05,
+        },
+    },
+
+};
+
+static const USBDescDevice desc_device_u2f_key = {
+    .bcdUSB                        = 0x0100,
+    .bMaxPacketSize0               = U2FHID_PACKET_SIZE,
+    .bNumConfigurations            = 1,
+    .confs = (USBDescConfig[]) {
+        {
+            .bNumInterfaces        = 1,
+            .bConfigurationValue   = 1,
+            .iConfiguration        = STR_CONFIG,
+            .bmAttributes          = USB_CFG_ATT_ONE,
+            .bMaxPower             = 15,
+            .nif = 1,
+            .ifs = &desc_iface_u2f_key,
+        },
+    },
+};
+
+static const USBDesc desc_u2f_key = {
+    .id = {
+        .idVendor          = U2F_KEY_VENDOR_NUM,
+        .idProduct         = U2F_KEY_PRODUCT_NUM,
+        .bcdDevice         = 0,
+        .iManufacturer     = STR_MANUFACTURER,
+        .iProduct          = STR_PRODUCT,
+        .iSerialNumber     = STR_SERIALNUMBER,
+    },
+    .full = &desc_device_u2f_key,
+    .str  = desc_strings,
+};
+
+static const uint8_t u2f_key_hid_report_desc[] = {
+    0x06, 0xd0, 0xf1, /* Usage Page (FIDO) */
+    0x09, 0x01,       /* Usage (FIDO) */
+    0xa1, 0x01,       /* Collection (HID Application) */
+    0x09, 0x20,       /*    Usage (FIDO data in) */
+    0x15, 0x00,       /*        Logical Minimum (0) */
+    0x26, 0xFF, 0x00, /*        Logical Maximum (0xff) */
+    0x75, 0x08,       /*        Report Size (8) */
+    0x95, 0x40,       /*        Report Count (0x40) */
+    0x81, 0x02,       /*        Input (Data, Variable, Absolute) */
+    0x09, 0x21,       /*    Usage (FIDO data out) */
+    0x15, 0x00,       /*        Logical Minimum (0) */
+    0x26, 0xFF, 0x00, /*        Logical Maximum  (0xFF) */
+    0x75, 0x08,       /*        Report Size (8) */
+    0x95, 0x40,       /*        Report Count (0x40) */
+    0x91, 0x02,       /*        Output (Data, Variable, Absolute) */
+    0xC0              /* End Collection */
+};
+
+static void u2f_key_reset(U2FKeyState *key)
+{
+    key->pending_in_start = 0;
+    key->pending_in_end = 0;
+    key->pending_in_num = 0;
+}
+
+static void u2f_key_handle_reset(USBDevice *dev)
+{
+    U2FKeyState *key = U2F_KEY(dev);
+
+    u2f_key_reset(key);
+}
+
+static void u2f_key_handle_control(USBDevice *dev, USBPacket *p,
+               int request, int value, int index, int length, uint8_t *data)
+{
+    U2FKeyState *key = U2F_KEY(dev);
+    int ret;
+
+    ret = usb_desc_handle_control(dev, p, request, value, index, length, data);
+    if (ret >= 0) {
+        return;
+    }
+
+    switch (request) {
+    case InterfaceRequest | USB_REQ_GET_DESCRIPTOR:
+        switch (value >> 8) {
+        case 0x22:
+            memcpy(data, u2f_key_hid_report_desc,
+                   sizeof(u2f_key_hid_report_desc));
+            p->actual_length = sizeof(u2f_key_hid_report_desc);
+            break;
+        default:
+            goto fail;
+        }
+        break;
+    case HID_GET_IDLE:
+        data[0] = key->idle;
+        p->actual_length = 1;
+        break;
+    case HID_SET_IDLE:
+        key->idle = (uint8_t)(value >> 8);
+        break;
+    default:
+    fail:
+        p->status = USB_RET_STALL;
+        break;
+    }
+
+}
+
+static void u2f_key_recv_from_guest(U2FKeyState *key, USBPacket *p)
+{
+    U2FKeyClass *kc = U2F_KEY_GET_CLASS(key);
+    uint8_t packet[U2FHID_PACKET_SIZE];
+
+    if (kc->recv_from_guest == NULL || p->iov.size != U2FHID_PACKET_SIZE) {
+        return;
+    }
+
+    usb_packet_copy(p, packet, p->iov.size);
+    kc->recv_from_guest(key, packet);
+}
+
+static void u2f_pending_in_add(U2FKeyState *key,
+                               const uint8_t packet[U2FHID_PACKET_SIZE])
+{
+    uint8_t index;
+
+    if (key->pending_in_num >= U2FHID_PENDING_IN_NUM) {
+        return;
+    }
+
+    index = key->pending_in_end;
+    key->pending_in_end = (index + 1) % U2FHID_PENDING_IN_NUM;
+    ++key->pending_in_num;
+
+    memcpy(key->pending_in[index], packet, U2FHID_PACKET_SIZE);
+}
+
+static uint8_t *u2f_pending_in_get(U2FKeyState *key)
+{
+    uint8_t index;
+
+    if (key->pending_in_num == 0) {
+        return NULL;
+    }
+
+    index = key->pending_in_start;
+    key->pending_in_start = (index + 1) % U2FHID_PENDING_IN_NUM;
+    --key->pending_in_num;
+
+    return key->pending_in[index];
+}
+
+static void u2f_key_handle_data(USBDevice *dev, USBPacket *p)
+{
+    U2FKeyState *key = U2F_KEY(dev);
+    uint8_t *packet_in;
+
+    /* Endpoint number check */
+    if (p->ep->nr != 1) {
+        p->status = USB_RET_STALL;
+        return;
+    }
+
+    switch (p->pid) {
+    case USB_TOKEN_OUT:
+        u2f_key_recv_from_guest(key, p);
+        break;
+    case USB_TOKEN_IN:
+        packet_in = u2f_pending_in_get(key);
+        if (packet_in == NULL) {
+            p->status = USB_RET_NAK;
+            return;
+        }
+        usb_packet_copy(p, packet_in, U2FHID_PACKET_SIZE);
+        break;
+    default:
+        p->status = USB_RET_STALL;
+        break;
+    }
+}
+
+void u2f_send_to_guest(U2FKeyState *key,
+                       const uint8_t packet[U2FHID_PACKET_SIZE])
+{
+    u2f_pending_in_add(key, packet);
+    usb_wakeup(key->ep, 0);
+}
+
+static void u2f_key_unrealize(USBDevice *dev)
+{
+    U2FKeyState *key = U2F_KEY(dev);
+    U2FKeyClass *kc = U2F_KEY_GET_CLASS(key);
+
+    if (kc->unrealize != NULL) {
+        kc->unrealize(key);
+    }
+}
+
+static void u2f_key_realize(USBDevice *dev, Error **errp)
+{
+    U2FKeyState *key = U2F_KEY(dev);
+    U2FKeyClass *kc = U2F_KEY_GET_CLASS(key);
+    Error *local_err = NULL;
+
+    usb_desc_create_serial(dev);
+    usb_desc_init(dev);
+    u2f_key_reset(key);
+
+    if (kc->realize != NULL) {
+        kc->realize(key, &local_err);
+        if (local_err != NULL) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+    key->ep = usb_ep_get(dev, USB_TOKEN_IN, 1);
+}
+
+const VMStateDescription vmstate_u2f_key = {
+    .name = "u2f-key",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_USB_DEVICE(dev, U2FKeyState),
+        VMSTATE_UINT8(idle, U2FKeyState),
+        VMSTATE_UINT8_2DARRAY(pending_in, U2FKeyState,
+            U2FHID_PENDING_IN_NUM, U2FHID_PACKET_SIZE),
+        VMSTATE_UINT8(pending_in_start, U2FKeyState),
+        VMSTATE_UINT8(pending_in_end, U2FKeyState),
+        VMSTATE_UINT8(pending_in_num, U2FKeyState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void u2f_key_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    USBDeviceClass *uc = USB_DEVICE_CLASS(klass);
+
+    uc->product_desc   = "QEMU U2F USB key";
+    uc->usb_desc       = &desc_u2f_key;
+    uc->handle_reset   = u2f_key_handle_reset;
+    uc->handle_control = u2f_key_handle_control;
+    uc->handle_data    = u2f_key_handle_data;
+    uc->handle_attach  = usb_desc_attach;
+    uc->realize        = u2f_key_realize;
+    uc->unrealize      = u2f_key_unrealize;
+    dc->desc           = "QEMU U2F key";
+    dc->vmsd           = &vmstate_u2f_key;
+}
+
+static const TypeInfo u2f_key_info = {
+    .name          = TYPE_U2F_KEY,
+    .parent        = TYPE_USB_DEVICE,
+    .instance_size = sizeof(U2FKeyState),
+    .abstract      = true,
+    .class_size    = sizeof(U2FKeyClass),
+    .class_init    = u2f_key_class_init,
+};
+
+static void u2f_key_register_types(void)
+{
+    type_register_static(&u2f_key_info);
+    usb_legacy_register(TYPE_U2F_KEY, "u2f-key", NULL);
+}
+
+type_init(u2f_key_register_types)
-- 
2.28.0


