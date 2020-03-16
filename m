Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BE9C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:47:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F4E0205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KlkNHDPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4E0205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxZc-0004M2-Fa
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHg-0003kf-DC
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHf-00052y-5O
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:47907)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxHe-00051S-Vz
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WOnGfxVvr/2gh78JhcyB0MNCc4EfkJRvrQjMy1iHHM8=;
 b=KlkNHDPIdWgGEZLq6U4/Wbq1LFiErRvmpPzq3oMh1nByPqh6obwTAa+eD1YoAqhQ7o8vDi
 NFlF7z6jjh03mSDeEd02towGm0DrJRY+qo+ntTP34nknXodB9iac2ME3J+d9qRfUApnAMi
 s9Syhcr/5KFWKyGV+WVpYxjcCx4I5mw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-tWaDFzbXPm-Uw49b0F9TkQ-1; Mon, 16 Mar 2020 17:28:24 -0400
X-MC-Unique: tWaDFzbXPm-Uw49b0F9TkQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71B28100726B
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:28:23 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C00519C4F;
 Mon, 16 Mar 2020 21:28:21 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/61] hw/usb/quirks: Use smaller types to reduce .rodata by
 10KiB
Date: Mon, 16 Mar 2020 22:26:54 +0100
Message-Id: <1584394048-44994-28-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

The USB descriptor sizes are specified as 16-bit for idVendor /
idProduct, and 8-bit for bInterfaceClass / bInterfaceSubClass /
bInterfaceProtocol. Doing so we reduce the usbredir_raw_serial_ids[]
and usbredir_ftdi_serial_ids[] arrays from 16KiB to 6KiB (size
reported on x86_64 host, building with --extra-cflags=3D-Os).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/usb/quirks.c |  4 ++--
 hw/usb/quirks.h | 22 +++++++++++++---------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/hw/usb/quirks.c b/hw/usb/quirks.c
index 38a9c56..23ea7a2 100644
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
diff --git a/hw/usb/quirks.h b/hw/usb/quirks.h
index 89480be..50ef2f9 100644
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
--=20
1.8.3.1



