Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F20AC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:49:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBC8A20848
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4bFPt15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC8A20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9pwD-0004Pb-3a
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 07:49:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9pt7-0007NN-Kv
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:46:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9pt6-0001bi-Dk
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:46:05 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38156
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9pt6-0001b6-9H
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:46:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583412363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BfL2wrp1xmfb4e/iaQpRjnEbNuM8Iy0Ua18MeCip/nA=;
 b=Z4bFPt15GH4RT06GeGeyeyZwS16pPZMLQG0Zkq5EDkaJPVUdji6oIr3q7BEA6hz8BtNn+y
 rw50v75zc/zOATP5Oa1u7orIYFFCbb1Imh/KLIo1WAundc4duwssRIDz094J3LXWbk1e8c
 uJLOpT3JIqCmcklBGRvGJr4fCx57Obc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-H9dQGy4OPBGMq5WN70j7lg-1; Thu, 05 Mar 2020 07:46:02 -0500
X-MC-Unique: H9dQGy4OPBGMq5WN70j7lg-1
Received: by mail-wr1-f69.google.com with SMTP id p11so2255787wrn.10
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 04:46:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cOfgZg45p005Cf8aNVaFJuLhPI+JdhyWRao0wzg6LoM=;
 b=kFoFRPYahhvk91z/Bz46XBTIDPHJ97T0ms3Q1CcdvftdlndharpeCq0y1XflRSpTMw
 Xe2NqAHxSp+UAQI5qQI1RhytsAb2U/+QyrkR1xKWRVzgJcNdtbaCAMB4ru/8S241IgdC
 K4CL7D8HYnoZk2TGc42ttUbr3R2/O4NnjUE3MsuHFS50fjf7W/9S5nZ2d+JxfaCAQiEO
 y0M30dHr1ir68HmjH68pjZxATP5uyLK679mRZ9CGEGF6+ycOqym6v/kY+VDRWRGCk3vy
 O1WKw7rlIWj+4TzTcWa/V1MwyYIYMs69P2tQ0HZOGOMgn8cC6Lz7eTWtfx3eskqPomOL
 MEDA==
X-Gm-Message-State: ANhLgQ0yBSyhYcsWZXphUVAHXEcQ0WfAl60PkUyxtWNWXdsr+lgEYOLr
 zQzCOTs6NiR/OevF6Vyt5EmakV2aPQajq+kAXaFy5qLNVWk+eT5oYDwdywt+NFFUEP0tU+nKp35
 AnCAhuv1MyIJjkoY=
X-Received: by 2002:a7b:ce99:: with SMTP id q25mr9353857wmj.34.1583412360850; 
 Thu, 05 Mar 2020 04:46:00 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtYQ3Fcji41liGZ4F/ZeQyFAYO+TfPXs7EPSdszQCv1mrO1EYqxHjHgHw9ceMByt1uuFupuDw==
X-Received: by 2002:a7b:ce99:: with SMTP id q25mr9353820wmj.34.1583412360562; 
 Thu, 05 Mar 2020 04:46:00 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id z12sm17054451wrs.43.2020.03.05.04.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 04:46:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 6/9] hw/usb/quirks: Use smaller types to reduce .rodata by
 10KiB
Date: Thu,  5 Mar 2020 13:45:22 +0100
Message-Id: <20200305124525.14555-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200305124525.14555-1-philmd@redhat.com>
References: <20200305124525.14555-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The USB descriptor sizes are specified as 16-bit for idVendor /
idProduct, and 8-bit for bInterfaceClass / bInterfaceSubClass /
bInterfaceProtocol. Doing so we reduce the usbredir_raw_serial_ids[]
and usbredir_ftdi_serial_ids[] arrays from 16KiB to 6KiB (size
reported on x86_64 host, building with --extra-cflags=3D-Os).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Add bitfield values and use unsigned types (Gerd)
---
 hw/usb/quirks.h | 22 +++++++++++++---------
 hw/usb/quirks.c |  4 ++--
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/hw/usb/quirks.h b/hw/usb/quirks.h
index 89480befd7..50ef2f9c2e 100644
--- a/hw/usb/quirks.h
+++ b/hw/usb/quirks.h
@@ -21,19 +21,23 @@
 #include "quirks-pl2303-ids.h"
=20
 struct usb_device_id {
-    int vendor_id;
-    int product_id;
-    int interface_class;
-    int interface_subclass;
-    int interface_protocol;
+    uint16_t vendor_id;
+    uint16_t product_id;
+    uint8_t interface_class;
+    uint8_t interface_subclass;
+    uint8_t interface_protocol;
+    uint8_t interface_protocol_used:1,
+            terminating_entry:1,
+            reserved:6;
 };
=20
 #define USB_DEVICE(vendor, product) \
-    .vendor_id =3D vendor, .product_id =3D product, .interface_class =3D -=
1,
+    .vendor_id =3D vendor, .product_id =3D product, .interface_protocol_us=
ed =3D 0,
=20
 #define USB_DEVICE_AND_INTERFACE_INFO(vend, prod, iclass, isubclass, iprot=
o) \
     .vendor_id =3D vend, .product_id =3D prod, .interface_class =3D iclass=
, \
-    .interface_subclass =3D isubclass, .interface_protocol =3D iproto
+    .interface_subclass =3D isubclass, .interface_protocol =3D iproto, \
+    .interface_protocol_used =3D 1
=20
 static const struct usb_device_id usbredir_raw_serial_ids[] =3D {
     /*
@@ -206,7 +210,7 @@ static const struct usb_device_id usbredir_raw_serial_i=
ds[] =3D {
     { USB_DEVICE(ADLINK_VENDOR_ID, ADLINK_ND6530_PRODUCT_ID) },
     { USB_DEVICE(SMART_VENDOR_ID, SMART_PRODUCT_ID) },
=20
-    { USB_DEVICE(-1, -1) } /* Terminating Entry */
+    { .terminating_entry =3D 1 } /* Terminating Entry */
 };
=20
 static const struct usb_device_id usbredir_ftdi_serial_ids[] =3D {
@@ -906,7 +910,7 @@ static const struct usb_device_id usbredir_ftdi_serial_=
ids[] =3D {
     { USB_DEVICE(FTDI_VID, FTDI_DISTORTEC_JTAG_LOCK_PICK_PID) },
     { USB_DEVICE(FTDI_VID, FTDI_LUMEL_PD12_PID) },
=20
-    { USB_DEVICE(-1, -1) } /* Terminating Entry */
+    { .terminating_entry =3D 1 } /* Terminating Entry */
 };
=20
 #undef USB_DEVICE
diff --git a/hw/usb/quirks.c b/hw/usb/quirks.c
index 38a9c5634a..23ea7a23ea 100644
--- a/hw/usb/quirks.c
+++ b/hw/usb/quirks.c
@@ -22,10 +22,10 @@ static bool usb_id_match(const struct usb_device_id *id=
s,
                          uint8_t interface_protocol) {
     int i;
=20
-    for (i =3D 0; ids[i].vendor_id !=3D -1; i++) {
+    for (i =3D 0; ids[i].terminating_entry =3D=3D 0; i++) {
         if (ids[i].vendor_id  =3D=3D vendor_id &&
             ids[i].product_id =3D=3D product_id &&
-            (ids[i].interface_class =3D=3D -1 ||
+            (ids[i].interface_protocol_used =3D=3D 0 ||
              (ids[i].interface_class =3D=3D interface_class &&
               ids[i].interface_subclass =3D=3D interface_subclass &&
               ids[i].interface_protocol =3D=3D interface_protocol))) {
--=20
2.21.1


