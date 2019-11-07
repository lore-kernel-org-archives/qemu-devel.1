Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BDBC5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 09:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5EFB2178F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 09:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="coOgxNmT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5EFB2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSdl2-0001u8-1M
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 04:07:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iSdZr-00032w-6o
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 03:55:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iSdZm-0003iZ-Co
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 03:55:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26651
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iSdZm-0003SL-8t
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 03:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573116931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lQA13BTbOt5toAh0JnArHM/J81uyZkJWL3X98JFCtJI=;
 b=coOgxNmTP73NXRqgPYBROM/uCBPnKL8meLosqBToi3asSW3DAjuNKI5/3C1UByptBa/uAa
 Wy2skhIUQEULr2EUlFNlzKgd8SbCYKpn/LHJcZVCcuonPAO9wPZVdIg3n+BF2ZiJ8CkhYd
 tV8tlflHRZgxkakw/x4gzpEOY3dKAEo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-N718ZnTlNPmojTI5QlC4Pw-1; Thu, 07 Nov 2019 03:55:30 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CBED1005500
 for <qemu-devel@nongnu.org>; Thu,  7 Nov 2019 08:55:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-69.ams2.redhat.com
 [10.36.116.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77DE9600CE;
 Thu,  7 Nov 2019 08:55:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2ED299D76; Thu,  7 Nov 2019 09:55:25 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] usb-host: add option to allow all resets.
Date: Thu,  7 Nov 2019 09:55:25 +0100
Message-Id: <20191107085525.30902-2-kraxel@redhat.com>
In-Reply-To: <20191107085525.30902-1-kraxel@redhat.com>
References: <20191107085525.30902-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: N718ZnTlNPmojTI5QlC4Pw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 65f14ab98da1 ("usb-host: skip reset for untouched devices")
filters out multiple usb device resets in a row.  While this improves
the situation for usb some devices it doesn't work for others :-(

So go add a config option to make the behavior configurable.

Buglink: https://bugs.launchpad.net/bugs/1846451
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20191015064426.19454-1-kraxel@redhat.com
---
 hw/usb/host-libusb.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 472cc26fc403..fcf48c019333 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -86,7 +86,9 @@ struct USBHostDevice {
     uint32_t                         options;
     uint32_t                         loglevel;
     bool                             needs_autoscan;
-    bool                             allow_guest_reset;
+    bool                             allow_one_guest_reset;
+    bool                             allow_all_guest_resets;
+
     /* state */
     QTAILQ_ENTRY(USBHostDevice)      next;
     int                              seen, errcount;
@@ -1462,10 +1464,10 @@ static void usb_host_handle_reset(USBDevice *udev)
     USBHostDevice *s =3D USB_HOST_DEVICE(udev);
     int rc;
=20
-    if (!s->allow_guest_reset) {
+    if (!s->allow_one_guest_reset && !s->allow_all_guest_resets) {
         return;
     }
-    if (udev->addr =3D=3D 0) {
+    if (!s->allow_all_guest_resets && udev->addr =3D=3D 0) {
         return;
     }
=20
@@ -1586,7 +1588,10 @@ static Property usb_host_dev_properties[] =3D {
     DEFINE_PROP_UINT32("productid", USBHostDevice, match.product_id, 0),
     DEFINE_PROP_UINT32("isobufs",  USBHostDevice, iso_urb_count,    4),
     DEFINE_PROP_UINT32("isobsize", USBHostDevice, iso_urb_frames,   32),
-    DEFINE_PROP_BOOL("guest-reset", USBHostDevice, allow_guest_reset, true=
),
+    DEFINE_PROP_BOOL("guest-reset", USBHostDevice,
+                     allow_one_guest_reset, true),
+    DEFINE_PROP_BOOL("guest-resets-all", USBHostDevice,
+                     allow_all_guest_resets, false),
     DEFINE_PROP_UINT32("loglevel",  USBHostDevice, loglevel,
                        LIBUSB_LOG_LEVEL_WARNING),
     DEFINE_PROP_BIT("pipeline",    USBHostDevice, options,
--=20
2.18.1


