Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1229AC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:27:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D188824677
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPA7yIcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D188824677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBaE8-0000iq-2D
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 04:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jBaBO-00052J-V1
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jBaBN-0002V7-Te
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:24:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54739
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jBaBN-0002Tl-PN
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583828649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U6HPKAeSkHD4ZWtar2rKi2M8k92l3FoWWhgkRdAHs9I=;
 b=JPA7yIcj/0AMAUxChUwqx7JuJn0fNvFsYAXTpZjQ7d1HJLYO2wx96ORihHPaDHyQo1Udll
 MwG068YCV8Mi9RgbHOdxIqvYe123akJruTu1JVmfp550tOgZz8cUJRyPEjs8VzI/+9wTlU
 ErFvo1px00yP68djMD5nzcqZwMgyyoc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274--duWB2tmNNCJfzyMQhzFsA-1; Tue, 10 Mar 2020 04:24:07 -0400
X-MC-Unique: -duWB2tmNNCJfzyMQhzFsA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00A7218C8C02;
 Tue, 10 Mar 2020 08:24:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-117.ams2.redhat.com
 [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC967388;
 Tue, 10 Mar 2020 08:24:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 16C199D6B; Tue, 10 Mar 2020 09:24:02 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/2] usb-serial: wakeup device on input
Date: Tue, 10 Mar 2020 09:24:01 +0100
Message-Id: <20200310082402.22839-2-kraxel@redhat.com>
In-Reply-To: <20200310082402.22839-1-kraxel@redhat.com>
References: <20200310082402.22839-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 Gerd Hoffmann <kraxel@redhat.com>, Jason Andryuk <jandryuk@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jason Andryuk <jandryuk@gmail.com>

Currently usb-serial devices are unable to send data into guests with
the xhci controller.  Data is copied into the usb-serial's buffer, but
it is not sent into the guest.  Data coming out of the guest works
properly.  usb-serial devices work properly with ehci.

Have usb-serial call usb_wakeup() when receiving data from the chardev.
This seems to notify the xhci controller and fix inbound data flow.

Also add USB_CFG_ATT_WAKEUP to the device's bmAttributes.  This matches
a real FTDI serial adapter's bmAttributes.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
Message-id: 20200306140917.26726-1-jandryuk@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-serial.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 98465990ef6b..daac75b7aec2 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -98,6 +98,7 @@ do { printf("usb-serial: " fmt , ## __VA_ARGS__); } while=
 (0)
=20
 typedef struct {
     USBDevice dev;
+    USBEndpoint *intr;
     uint8_t recv_buf[RECV_BUF];
     uint16_t recv_ptr;
     uint16_t recv_used;
@@ -153,7 +154,7 @@ static const USBDescDevice desc_device =3D {
         {
             .bNumInterfaces        =3D 1,
             .bConfigurationValue   =3D 1,
-            .bmAttributes          =3D USB_CFG_ATT_ONE,
+            .bmAttributes          =3D USB_CFG_ATT_ONE | USB_CFG_ATT_WAKEU=
P,
             .bMaxPower             =3D 50,
             .nif =3D 1,
             .ifs =3D &desc_iface0,
@@ -459,6 +460,8 @@ static void usb_serial_read(void *opaque, const uint8_t=
 *buf, int size)
         memcpy(s->recv_buf + start, buf, size);
     }
     s->recv_used +=3D size;
+
+    usb_wakeup(s->intr, 0);
 }
=20
 static void usb_serial_event(void *opaque, QEMUChrEvent event)
@@ -513,6 +516,7 @@ static void usb_serial_realize(USBDevice *dev, Error **=
errp)
     if (qemu_chr_fe_backend_open(&s->cs) && !dev->attached) {
         usb_device_attach(dev, &error_abort);
     }
+    s->intr =3D usb_ep_get(dev, USB_TOKEN_IN, 1);
 }
=20
 static USBDevice *usb_braille_init(USBBus *bus, const char *unused)
--=20
2.18.2


