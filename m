Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA98C33C9E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:12:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E75A2070E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="wt6nzUBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E75A2070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip7Nx-0003r0-2b
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 04:12:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1ip7Me-0002aT-5C
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:10:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1ip7Mc-0004PG-QY
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:10:56 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54158)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1ip7Mc-0004O8-K4
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:10:54 -0500
Received: by mail-wm1-x342.google.com with SMTP id m24so1617882wmc.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 01:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FfQ6ZU1kHSKwI7VaafvEzLdyLb8c87IhxHy4wK5k72w=;
 b=wt6nzUBrBTYyYtFArc5RVuE0WBeuu4ExOp42eXZSR0/r89An7y075bjsLfczTNLwQo
 Bmd9PK+PX9DNJqLsnpF/TdQoMnN8nFTltWcJ7rGdXqzbY/t8ThfL5TYWNrhM5mtovEGu
 F53DrutXXTPirwzQVf0HzY6Ep/2ywTGY/T2q8JH0TNduV9nw1c/tBHqL5e9bvBeoRPxH
 46m0rvE8OFbzeFAlciFKDxz5mmnoRQz/dxhG5LrJx2NJx80BdV05sQu+25Z51cOruVrK
 NiB/4tM6it3uo9kELh2TwskHYnjkeTbCvDfNbY3mcemMEwU/jQ5gLn/MR8Jz+DaqyQQB
 rVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FfQ6ZU1kHSKwI7VaafvEzLdyLb8c87IhxHy4wK5k72w=;
 b=a9so5sAhk7uphRUbY5BKPCYJQx+DZvja3tJDtEVC78s+wOzsDrJSuCPTQgDa8K5GL1
 SDH47E4SI34T0JC+3MeNC1atP176XHdtqrou9VgMT1Osem3vxXQ5AjwmR3ZYIfru6Gu2
 p8T1Hr9MCYjWiEsaIdPwf9L1WafL9sIAj9LQ8gtfdhutLy20xuIPAnzgg13Lh38E2OIS
 zOQgKGLSfUsWEOPK1qiCjJQ2uq0zXnCPJ5WXYs/XUYuo5YdWE2cIGu3/p9xkjlbgaTnJ
 tp9vWrQ2diEJMY6meJWav6bMonNUgSYYRvMEpTl0y6hq8d80dVG2STH7uYbRVX9JjaUA
 L3lQ==
X-Gm-Message-State: APjAAAXHf8vk0a0soewIyun2g8aMkZuZLYfShI5SOLJ9YAAoudE016jl
 9NtZzAYlB43r+IJGv5e/m7luNSerRUQ=
X-Google-Smtp-Source: APXvYqxFdf+QYjIDJ0a5eteifRwgm/DUBDvEq4voVkrdxLyukPmuC1k5wnGcn4rUT1+/Tpx5Boe1Mg==
X-Received: by 2002:a7b:ce98:: with SMTP id q24mr2386722wmj.41.1578474653640; 
 Wed, 08 Jan 2020 01:10:53 -0800 (PST)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net.
 [79.177.42.131])
 by smtp.gmail.com with ESMTPSA id q3sm2892676wmc.47.2020.01.08.01.10.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 08 Jan 2020 01:10:53 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, kraxel@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] usb-host: remove 'remote wakeup' flag from
 configuration descriptor
Date: Wed,  8 Jan 2020 11:10:43 +0200
Message-Id: <20200108091044.18055-2-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108091044.18055-1-yuri.benditovich@daynix.com>
References: <20200108091044.18055-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: yan@daynix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the redirected device has this capability, Windows guest may
place the device into D2 and expect it to wake when the device
becomes active, but this will never happen. For example, when
internal Bluetooth adapter is redirected, keyboards and mice
connected to it do not work. Current commit removes this
capability (starting from machine 5.0)
Set 'usb-host.suppress-remote-wake' property to 'off' to keep
'remote wake' as is or to 'on' to remove 'remote wake' on
4.2 or earlier.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 hw/core/machine.c    |  1 +
 hw/usb/host-libusb.c | 20 ++++++++++++++++++++
 hw/usb/trace-events  |  1 +
 3 files changed, 22 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 4f30fb5646..c5d32f56db 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -32,6 +32,7 @@ GlobalProperty hw_compat_4_2[] = {
     { "virtio-blk-device", "seg-max-adjust", "off"},
     { "virtio-scsi-device", "seg_max_adjust", "off"},
     { "vhost-blk-device", "seg_max_adjust", "off"},
+    { "usb-host", "suppress-remote-wake", "off" },
 };
 const size_t hw_compat_4_2_len = G_N_ELEMENTS(hw_compat_4_2);
 
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index fcf48c0193..00e0e36369 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -88,6 +88,7 @@ struct USBHostDevice {
     bool                             needs_autoscan;
     bool                             allow_one_guest_reset;
     bool                             allow_all_guest_resets;
+    bool                             suppress_remote_wake;
 
     /* state */
     QTAILQ_ENTRY(USBHostDevice)      next;
@@ -386,6 +387,8 @@ static void LIBUSB_CALL usb_host_req_complete_ctrl(struct libusb_transfer *xfer)
     r->p->status = status_map[xfer->status];
     r->p->actual_length = xfer->actual_length;
     if (r->in && xfer->actual_length) {
+        USBDevice *udev = USB_DEVICE(s);
+        struct libusb_config_descriptor *conf = (void *)r->cbuf;
         memcpy(r->cbuf, r->buffer + 8, xfer->actual_length);
 
         /* Fix up USB-3 ep0 maxpacket size to allow superspeed connected devices
@@ -394,6 +397,21 @@ static void LIBUSB_CALL usb_host_req_complete_ctrl(struct libusb_transfer *xfer)
             r->cbuf[7] == 9) {
             r->cbuf[7] = 64;
         }
+        /*
+         *If this is GET_DESCRIPTOR request for configuration descriptor,
+         * remove 'remote wakeup' flag from it to prevent idle power down
+         * in Windows guest
+         */
+        if (s->suppress_remote_wake &&
+            udev->setup_buf[0] == USB_DIR_IN &&
+            udev->setup_buf[1] == USB_REQ_GET_DESCRIPTOR &&
+            udev->setup_buf[3] == USB_DT_CONFIG && udev->setup_buf[2] == 0 &&
+            xfer->actual_length >
+                offsetof(struct libusb_config_descriptor, bmAttributes) &&
+            (conf->bmAttributes & USB_CFG_ATT_WAKEUP)) {
+                trace_usb_host_remote_wakeup_removed(s->bus_num, s->addr);
+                conf->bmAttributes &= ~USB_CFG_ATT_WAKEUP;
+        }
     }
     trace_usb_host_req_complete(s->bus_num, s->addr, r->p,
                                 r->p->status, r->p->actual_length);
@@ -1596,6 +1614,8 @@ static Property usb_host_dev_properties[] = {
                        LIBUSB_LOG_LEVEL_WARNING),
     DEFINE_PROP_BIT("pipeline",    USBHostDevice, options,
                     USB_HOST_OPT_PIPELINE, true),
+    DEFINE_PROP_BOOL("suppress-remote-wake", USBHostDevice,
+                     suppress_remote_wake, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index 2d3713351c..1c24d82c09 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -266,3 +266,4 @@ usb_host_parse_config(int bus, int addr, int value, int active) "dev %d:%d, valu
 usb_host_parse_interface(int bus, int addr, int num, int alt, int active) "dev %d:%d, num %d, alt %d, active %d"
 usb_host_parse_endpoint(int bus, int addr, int ep, const char *dir, const char *type, int active) "dev %d:%d, ep %d, %s, %s, active %d"
 usb_host_parse_error(int bus, int addr, const char *errmsg) "dev %d:%d, msg %s"
+usb_host_remote_wakeup_removed(int bus, int addr) "dev %d:%d"
-- 
2.17.1


