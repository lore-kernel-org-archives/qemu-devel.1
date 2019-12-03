Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F67C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 20:28:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4FB22080A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 20:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="AqtdBSs8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4FB22080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icEm5-0001br-0E
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 15:27:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1icDWP-0008DD-6J
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 14:07:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1icDWI-000561-Sy
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 14:07:37 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43004)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1icDWI-0004n5-Lj
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 14:07:34 -0500
Received: by mail-wr1-x441.google.com with SMTP id a15so5099115wrf.9
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 11:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/PylRFnWKtD+HhPQYtsbijiWyCF1YZ11JweXKECL7sA=;
 b=AqtdBSs8QladLyDlvHgykPQmk0rlU0JCZT7rwOGzWmzUNGszjHs+/XvTIlnyze5ogZ
 kWlxq8cuR9c3ah3bm5ui2MFouYhISghjRgNTpHFzQRfLDkpMPpAkoc9V69sGzaObjAaT
 vq5sjeVjvHnrb1jbhy5Fu3voWD+FGUlET8WqrFDh+BGtZ9J4z25qHFvx/vuYNOougjXy
 L1XI2ICdhZon493NqrXD3OS4NfXiMEzIkPnkyY5vJeqicyyZv1xOyqZ8Ng5mAUApQWcJ
 up3LXk+TpolyGj+viyw+rcZvibg+w3SvPkOuWi8kl4M8vPGeHFnzWhFjwzskExvYkaBJ
 C+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/PylRFnWKtD+HhPQYtsbijiWyCF1YZ11JweXKECL7sA=;
 b=F/8d1LcWOxNCgN482F10Arox1UlgjEEiFwz8fGs4arO9J1jRYGUhUuaPgAeSmQTii+
 qm7M6AcI5eLtRFanqNwZGOp17OsH2jRD1AUnBV+I3xx0k5RTL0nFjVatuCZoh/AzGCy4
 5utmvi/T9HGOrVoUI5C0Do4dgfz1ZutS9L4cbcpzK2Nd2aKpSXNbPBg4fkMiwmsfQ/Jo
 AF6XoRicGazEYiRlhv3gd40YWxTsxxkfCBHOfaiAbc+JA2PgIBc2bcJtgv/2JzHxYD/L
 FoFfgrNrk6DWvL2KHmE/GDBVw+dXawjRLR6ez+bWnsBl3xtu31jltvKF26azLKjxa62p
 8sVw==
X-Gm-Message-State: APjAAAVnmMeOCc0z6ZWjqXTVrAYIU4ocjzBl9BuWRSv2sLpplsiY2d/U
 HecVZm/7Q38NDU/rM03fSGvzbg==
X-Google-Smtp-Source: APXvYqyo991/uohTrjDcIJ4Wd0+xjTtepF1EgIbejzVOLo25KfTsvH3eSFHrmwvofQrqt3GgW1nu0A==
X-Received: by 2002:a5d:50cf:: with SMTP id f15mr6857291wrt.381.1575400047195; 
 Tue, 03 Dec 2019 11:07:27 -0800 (PST)
Received: from f2.redhat.com (bzq-79-182-78-197.red.bezeqint.net.
 [79.182.78.197])
 by smtp.gmail.com with ESMTPSA id t12sm4828810wrs.96.2019.12.03.11.07.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 03 Dec 2019 11:07:25 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, kraxel@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] usb-host: remove 'remote wakeup' flag from
 configuration descriptor
Date: Tue,  3 Dec 2019 21:07:15 +0200
Message-Id: <20191203190716.18917-2-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203190716.18917-1-yuri.benditovich@daynix.com>
References: <20191203190716.18917-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
capability (starting from machine 4.2)
Set 'usb-host.suppress-remote-wake' property to 'off' to keep
'remote wake' as is or to 'on' to remove 'remote wake' on
4.1 or earlier.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 hw/core/machine.c    |  1 +
 hw/usb/host-libusb.c | 20 ++++++++++++++++++++
 hw/usb/trace-events  |  1 +
 3 files changed, 22 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1689ad3bf8..8c0eaad091 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -29,6 +29,7 @@
 
 GlobalProperty hw_compat_4_1[] = {
     { "virtio-pci", "x-pcie-flr-init", "off" },
+    { "usb-host", "suppress-remote-wake", "off" },
 };
 const size_t hw_compat_4_1_len = G_N_ELEMENTS(hw_compat_4_1);
 
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


