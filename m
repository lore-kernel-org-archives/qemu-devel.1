Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD5FC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:42:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCCF220658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hyAP9N6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCF220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iya7E-0001VB-RT
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 06:42:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iya6Q-0000qS-0n
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:41:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iya6O-0003nA-SM
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:41:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53870
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iya6O-0003ld-OA
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:41:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580730076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lNfJnr6GNnkh3yz5dl2KnYfdTcEhYnESVJ/wa876QzQ=;
 b=hyAP9N6jmN6LMiM1az+lRL6kTaaNrfxspKpSicVhiwCUsaPqryF21qXgJNCePDvyhJB+D+
 6tZI6Dijg574wp8fbXek/gmrSdsNgdukF0attD1L2hBVEReCH4fZzvlNceGXVKlMH6+oSU
 Ewdrg7zvnm/8OpE4pj3ZaWFNRqdjbq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-lVmDP205OtKOwQtiuUVy-Q-1; Mon, 03 Feb 2020 06:41:12 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0C7C800D41
 for <qemu-devel@nongnu.org>; Mon,  3 Feb 2020 11:41:11 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com
 [10.36.116.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 496BE8EA0A;
 Mon,  3 Feb 2020 11:41:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4F28D9D1E; Mon,  3 Feb 2020 12:41:08 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] usb-host: wait for cancel complete
Date: Mon,  3 Feb 2020 12:41:08 +0100
Message-Id: <20200203114108.23952-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: lVmDP205OtKOwQtiuUVy-Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After canceling transfers call into libvirt so it can process the
request, and wait for it to complete.  Also cancel all pending
transfers before exiting qemu.

Buglink: https://bugzilla.redhat.com//show_bug.cgi?id=3D1749745
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/host-libusb.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 259470090102..2ac7a936fb91 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -354,9 +354,7 @@ static USBHostRequest *usb_host_req_alloc(USBHostDevice=
 *s, USBPacket *p,
=20
 static void usb_host_req_free(USBHostRequest *r)
 {
-    if (r->host) {
-        QTAILQ_REMOVE(&r->host->requests, r, next);
-    }
+    QTAILQ_REMOVE(&r->host->requests, r, next);
     libusb_free_transfer(r->xfer);
     g_free(r->buffer);
     g_free(r);
@@ -468,12 +466,7 @@ static void usb_host_req_abort(USBHostRequest *r)
             usb_packet_complete(USB_DEVICE(s), r->p);
         }
         r->p =3D NULL;
-    }
=20
-    QTAILQ_REMOVE(&r->host->requests, r, next);
-    r->host =3D NULL;
-
-    if (inflight) {
         libusb_cancel_transfer(r->xfer);
     }
 }
@@ -962,6 +955,13 @@ static void usb_host_abort_xfers(USBHostDevice *s)
     QTAILQ_FOREACH_SAFE(r, &s->requests, next, rtmp) {
         usb_host_req_abort(r);
     }
+
+    while (QTAILQ_FIRST(&s->requests) !=3D NULL) {
+        struct timeval tv;
+        memset(&tv, 0, sizeof(tv));
+        tv.tv_usec =3D 2500;
+        libusb_handle_events_timeout(ctx, &tv);
+    }
 }
=20
 static int usb_host_close(USBHostDevice *s)
@@ -1011,6 +1011,7 @@ static void usb_host_exit_notifier(struct Notifier *n=
, void *data)
     USBHostDevice *s =3D container_of(n, USBHostDevice, exit);
=20
     if (s->dh) {
+        usb_host_abort_xfers(s);
         usb_host_release_interfaces(s);
         libusb_reset_device(s->dh);
         usb_host_attach_kernel(s);
--=20
2.18.1


