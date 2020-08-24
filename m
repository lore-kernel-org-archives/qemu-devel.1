Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4772DC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 11:02:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15DA8206B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 11:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqwQV+qJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15DA8206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAAEw-0004i0-9o
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 07:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kAADs-0003PS-4b
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 07:01:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33259
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kAADq-00066P-9I
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 07:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598266865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WPdeBPoYa65DsJS4l7Ye8OnfTnGlcUHhwyXvmFVnVgA=;
 b=IqwQV+qJ4Qr+ax5pF58boGdcsnEupbvTYguO4S+Pt73Zy/MONSeK441u4vFmlkcMyD7RSm
 2DdalkWihqulXDQ5wlZOwSOk3ghZZ8H59aLPLeAP8KT1j/hCWDM0qNQ/obVXs/zPj71yuP
 T/8B6HguiF/mvQRiN0SHaWbsR6L7a1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-oCDHBdQkMEObk_nK1yx33A-1; Mon, 24 Aug 2020 07:01:03 -0400
X-MC-Unique: oCDHBdQkMEObk_nK1yx33A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8593981F015
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 11:01:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com
 [10.36.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7EDC7F463;
 Mon, 24 Aug 2020 11:00:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C182D17538; Mon, 24 Aug 2020 13:00:57 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] usb-host: workaround libusb bug
Date: Mon, 24 Aug 2020 13:00:57 +0200
Message-Id: <20200824110057.32089-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 06:40:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

libusb_get_device_speed() does not work for
libusb_wrap_sys_device() devices in v1.0.23.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1871090
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/host-libusb.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index c474551d8456..77f1eaa5fe9e 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -39,6 +39,11 @@
 #endif
 #include <libusb.h>
 
+#ifdef CONFIG_LINUX
+#include <sys/ioctl.h>
+#include <linux/usbdevice_fs.h>
+#endif
+
 #include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "monitor/monitor.h"
@@ -885,6 +890,7 @@ static void usb_host_ep_update(USBHostDevice *s)
 static int usb_host_open(USBHostDevice *s, libusb_device *dev, int hostfd)
 {
     USBDevice *udev = USB_DEVICE(s);
+    int libusb_speed;
     int bus_num = 0;
     int addr = 0;
     int rc;
@@ -935,7 +941,36 @@ static int usb_host_open(USBHostDevice *s, libusb_device *dev, int hostfd)
     usb_ep_init(udev);
     usb_host_ep_update(s);
 
-    udev->speed     = speed_map[libusb_get_device_speed(dev)];
+    libusb_speed = libusb_get_device_speed(dev);
+#ifdef CONFIG_LINUX
+    if (hostfd && libusb_speed == 0) {
+        /*
+         * Workaround libusb bug: libusb_get_device_speed() does not
+         * work for libusb_wrap_sys_device() devices in v1.0.23.
+         *
+         * Speeds are defined in linux/usb/ch9.h, file not included
+         * due to name conflicts.
+         */
+        int rc = ioctl(hostfd, USBDEVFS_GET_SPEED, NULL);
+        switch(rc) {
+        case 1: /* low */
+            libusb_speed = LIBUSB_SPEED_LOW;
+            break;
+        case 2: /* full */
+            libusb_speed = LIBUSB_SPEED_FULL;
+            break;
+        case 3: /* high */
+        case 4: /* wireless */
+            libusb_speed = LIBUSB_SPEED_HIGH;
+            break;
+        case 5: /* super */
+        case 6: /* super plus */
+            libusb_speed = LIBUSB_SPEED_SUPER;
+            break;
+        }
+    }
+#endif
+    udev->speed = speed_map[libusb_speed];
     usb_host_speed_compat(s);
 
     if (s->ddesc.iProduct) {
-- 
2.27.0


