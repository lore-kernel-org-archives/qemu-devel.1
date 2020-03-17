Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD19C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0576820663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fd16xF7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0576820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE8uO-0001FF-79
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 05:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jE8sJ-0005oh-LY
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jE8sI-0004qL-EC
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:51:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:44089)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jE8sI-0004oR-A6
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584438659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bTpbC0hF4n0wMioutkMBf7peWozKB0jLJMnAudSFGwY=;
 b=Fd16xF7Wz3FveBQs/puHGTEmIxizFRhFbZEncqTb4G9emXI1ZOwWsT9UBJnwJqUiupF4Wx
 aZjUh8OwjqTIJ6hzJsykpvrdBmWC4qjl40lSMfgiOzWN10l64adh7XjHjBKgKAczxbatN1
 SS7KbdPlzAjV1sInvEMXSDQlnYcvByM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-7wGnlxRFO6KDj6MIwrJcfQ-1; Tue, 17 Mar 2020 05:50:55 -0400
X-MC-Unique: 7wGnlxRFO6KDj6MIwrJcfQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DF951005514;
 Tue, 17 Mar 2020 09:50:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D1D68F343;
 Tue, 17 Mar 2020 09:50:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 013139D21; Tue, 17 Mar 2020 10:50:50 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/4] usb-serial: Move USB_TOKEN_IN into a helper function
Date: Tue, 17 Mar 2020 10:50:46 +0100
Message-Id: <20200317095049.28486-2-kraxel@redhat.com>
In-Reply-To: <20200317095049.28486-1-kraxel@redhat.com>
References: <20200317095049.28486-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

We'll be adding a loop, so move the code into a helper function.  breaks
are replaced with returns.  While making this change, add braces to
single line if statements to comply with coding style and keep
checkpatch happy.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
Message-id: 20200316174610.115820-2-jandryuk@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-serial.c | 80 ++++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 34 deletions(-)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index daac75b7aec2..d807ce577110 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -358,13 +358,56 @@ static void usb_serial_handle_control(USBDevice *dev,=
 USBPacket *p,
     }
 }
=20
+static void usb_serial_token_in(USBSerialState *s, USBPacket *p)
+{
+    int first_len, len;
+    uint8_t header[2];
+
+    first_len =3D RECV_BUF - s->recv_ptr;
+    len =3D p->iov.size;
+    if (len <=3D 2) {
+        p->status =3D USB_RET_NAK;
+        return;
+    }
+    header[0] =3D usb_get_modem_lines(s) | 1;
+    /* We do not have the uart details */
+    /* handle serial break */
+    if (s->event_trigger && s->event_trigger & FTDI_BI) {
+        s->event_trigger &=3D ~FTDI_BI;
+        header[1] =3D FTDI_BI;
+        usb_packet_copy(p, header, 2);
+        return;
+    } else {
+        header[1] =3D 0;
+    }
+    len -=3D 2;
+    if (len > s->recv_used) {
+        len =3D s->recv_used;
+    }
+    if (!len) {
+        p->status =3D USB_RET_NAK;
+        return;
+    }
+    if (first_len > len) {
+        first_len =3D len;
+    }
+    usb_packet_copy(p, header, 2);
+    usb_packet_copy(p, s->recv_buf + s->recv_ptr, first_len);
+    if (len > first_len) {
+        usb_packet_copy(p, s->recv_buf, len - first_len);
+    }
+    s->recv_used -=3D len;
+    s->recv_ptr =3D (s->recv_ptr + len) % RECV_BUF;
+
+    return;
+}
+
 static void usb_serial_handle_data(USBDevice *dev, USBPacket *p)
 {
     USBSerialState *s =3D (USBSerialState *)dev;
     uint8_t devep =3D p->ep->nr;
     struct iovec *iov;
-    uint8_t header[2];
-    int i, first_len, len;
+    int i;
=20
     switch (p->pid) {
     case USB_TOKEN_OUT:
@@ -382,38 +425,7 @@ static void usb_serial_handle_data(USBDevice *dev, USB=
Packet *p)
     case USB_TOKEN_IN:
         if (devep !=3D 1)
             goto fail;
-        first_len =3D RECV_BUF - s->recv_ptr;
-        len =3D p->iov.size;
-        if (len <=3D 2) {
-            p->status =3D USB_RET_NAK;
-            break;
-        }
-        header[0] =3D usb_get_modem_lines(s) | 1;
-        /* We do not have the uart details */
-        /* handle serial break */
-        if (s->event_trigger && s->event_trigger & FTDI_BI) {
-            s->event_trigger &=3D ~FTDI_BI;
-            header[1] =3D FTDI_BI;
-            usb_packet_copy(p, header, 2);
-            break;
-        } else {
-            header[1] =3D 0;
-        }
-        len -=3D 2;
-        if (len > s->recv_used)
-            len =3D s->recv_used;
-        if (!len) {
-            p->status =3D USB_RET_NAK;
-            break;
-        }
-        if (first_len > len)
-            first_len =3D len;
-        usb_packet_copy(p, header, 2);
-        usb_packet_copy(p, s->recv_buf + s->recv_ptr, first_len);
-        if (len > first_len)
-            usb_packet_copy(p, s->recv_buf, len - first_len);
-        s->recv_used -=3D len;
-        s->recv_ptr =3D (s->recv_ptr + len) % RECV_BUF;
+        usb_serial_token_in(s, p);
         break;
=20
     default:
--=20
2.18.2


