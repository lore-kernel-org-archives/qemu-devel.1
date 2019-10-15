Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C911C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 06:46:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ECC120854
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 06:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ECC120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKGav-0001MB-3R
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 02:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iKGZR-0000Uo-Na
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 02:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iKGZO-0001Y1-UG
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 02:44:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iKGZO-0001Pm-Ou
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 02:44:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3FADBC0A1978
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 06:44:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com
 [10.36.116.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4EF45D6B0;
 Tue, 15 Oct 2019 06:44:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9007C11AAA; Tue, 15 Oct 2019 08:44:26 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] usb-host: add option to allow all resets.
Date: Tue, 15 Oct 2019 08:44:26 +0200
Message-Id: <20191015064426.19454-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 15 Oct 2019 06:44:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
     USBHostDevice *s = USB_HOST_DEVICE(udev);
     int rc;
 
-    if (!s->allow_guest_reset) {
+    if (!s->allow_one_guest_reset && !s->allow_all_guest_resets) {
         return;
     }
-    if (udev->addr == 0) {
+    if (!s->allow_all_guest_resets && udev->addr == 0) {
         return;
     }
 
@@ -1586,7 +1588,10 @@ static Property usb_host_dev_properties[] = {
     DEFINE_PROP_UINT32("productid", USBHostDevice, match.product_id, 0),
     DEFINE_PROP_UINT32("isobufs",  USBHostDevice, iso_urb_count,    4),
     DEFINE_PROP_UINT32("isobsize", USBHostDevice, iso_urb_frames,   32),
-    DEFINE_PROP_BOOL("guest-reset", USBHostDevice, allow_guest_reset, true),
+    DEFINE_PROP_BOOL("guest-reset", USBHostDevice,
+                     allow_one_guest_reset, true),
+    DEFINE_PROP_BOOL("guest-resets-all", USBHostDevice,
+                     allow_all_guest_resets, false),
     DEFINE_PROP_UINT32("loglevel",  USBHostDevice, loglevel,
                        LIBUSB_LOG_LEVEL_WARNING),
     DEFINE_PROP_BIT("pipeline",    USBHostDevice, options,
-- 
2.18.1


