Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D7AC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:52:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B4E920663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QolOe/AW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4E920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE8tG-0007P3-Nf
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 05:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jE8sI-0005oC-Cm
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jE8sD-0004kq-Sx
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:51:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:53091)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jE8sD-0004jf-Oh
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584438657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dFH1Yj5Sjk9qto7j29PpSqX35LZhn2npn279aodx5tQ=;
 b=QolOe/AWr48yczOBOC4rvd6RaRLadx4rvu/N0AUYxiTGZIYYeIK4F1oiPm4vB+MioJCIx3
 HfeMO6cMl5pIA7NpH1EceMg1SX+EmhiclxhRoGquxx9oizKe/hlsog7NhpkEoI8vH4aTsh
 XZSYvZwFhE4sexLeqiajkjRXAHliBZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-I8zxG01nN-Wt_VARvcg4wQ-1; Tue, 17 Mar 2020 05:50:55 -0400
X-MC-Unique: I8zxG01nN-Wt_VARvcg4wQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F66D107ACCA;
 Tue, 17 Mar 2020 09:50:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6C9D60BEE;
 Tue, 17 Mar 2020 09:50:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 09D386FF; Tue, 17 Mar 2020 10:50:50 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] usb-serial: chunk data to wMaxPacketSize
Date: Tue, 17 Mar 2020 10:50:47 +0100
Message-Id: <20200317095049.28486-3-kraxel@redhat.com>
In-Reply-To: <20200317095049.28486-1-kraxel@redhat.com>
References: <20200317095049.28486-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Jason Andryuk <jandryuk@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jason Andryuk <jandryuk@gmail.com>

usb-serial has issues with xHCI controllers where data is lost in the
VM.  Inspecting the URBs in the guest, EHCI starts every 64 byte boundary
(wMaxPacketSize) with a header.  EHCI hands packets into
usb_serial_token_in() with size 64, so these cannot cross the 64 byte
boundary.  The xHCI controller has packets of 512 bytes and the usb-serial
will just write through the 64 byte boundary.  In the guest, this means
data bytes are interpreted as header, so data bytes don't make it out
the serial interface.

Re-work usb_serial_token_in to chunk data into 64 byte units - 2 byte
header and 62 bytes data.  The Linux driver reads wMaxPacketSize to find
the chunk size, so we match that.

Real hardware was observed to pass in 512 byte URBs (496 bytes data +
8 * 2 byte headers).  Since usb-serial only buffers 384 bytes of data,
usb-serial will pass in 6 64 byte blocks and 1 12 byte partial block for
462 bytes max.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
Message-id: 20200316174610.115820-3-jandryuk@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-serial.c | 47 ++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index d807ce577110..ec091b6a366c 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -360,15 +360,16 @@ static void usb_serial_handle_control(USBDevice *dev,=
 USBPacket *p,
=20
 static void usb_serial_token_in(USBSerialState *s, USBPacket *p)
 {
-    int first_len, len;
+    const int max_packet_size =3D desc_iface0.eps[0].wMaxPacketSize;
+    int packet_len;
     uint8_t header[2];
=20
-    first_len =3D RECV_BUF - s->recv_ptr;
-    len =3D p->iov.size;
-    if (len <=3D 2) {
+    packet_len =3D p->iov.size;
+    if (packet_len <=3D 2) {
         p->status =3D USB_RET_NAK;
         return;
     }
+
     header[0] =3D usb_get_modem_lines(s) | 1;
     /* We do not have the uart details */
     /* handle serial break */
@@ -380,24 +381,34 @@ static void usb_serial_token_in(USBSerialState *s, US=
BPacket *p)
     } else {
         header[1] =3D 0;
     }
-    len -=3D 2;
-    if (len > s->recv_used) {
-        len =3D s->recv_used;
-    }
-    if (!len) {
+
+    if (!s->recv_used) {
         p->status =3D USB_RET_NAK;
         return;
     }
-    if (first_len > len) {
-        first_len =3D len;
+
+    while (s->recv_used && packet_len > 2) {
+        int first_len, len;
+
+        len =3D MIN(packet_len, max_packet_size);
+        len -=3D 2;
+        if (len > s->recv_used) {
+            len =3D s->recv_used;
+        }
+
+        first_len =3D RECV_BUF - s->recv_ptr;
+        if (first_len > len) {
+            first_len =3D len;
+        }
+        usb_packet_copy(p, header, 2);
+        usb_packet_copy(p, s->recv_buf + s->recv_ptr, first_len);
+        if (len > first_len) {
+            usb_packet_copy(p, s->recv_buf, len - first_len);
+        }
+        s->recv_used -=3D len;
+        s->recv_ptr =3D (s->recv_ptr + len) % RECV_BUF;
+        packet_len -=3D len + 2;
     }
-    usb_packet_copy(p, header, 2);
-    usb_packet_copy(p, s->recv_buf + s->recv_ptr, first_len);
-    if (len > first_len) {
-        usb_packet_copy(p, s->recv_buf, len - first_len);
-    }
-    s->recv_used -=3D len;
-    s->recv_ptr =3D (s->recv_ptr + len) % RECV_BUF;
=20
     return;
 }
--=20
2.18.2


