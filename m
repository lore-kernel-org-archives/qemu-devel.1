Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EDCC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 12:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A0420705
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 12:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="grv1X8Mx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A0420705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibkxl-0007AA-DS
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 07:38:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1ibkua-0003mG-IV
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1ibkuZ-0004gl-7p
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:34:44 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35084)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1ibkuY-0004dX-Sz
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:34:43 -0500
Received: by mail-wr1-x442.google.com with SMTP id g17so11991245wro.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 04:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=TjZliZhEsVF0vv2Qzf2ABh+Szj2+Cht1CR4qLXA8WKs=;
 b=grv1X8MxVimO/Q+FdZ0YDA+bnXbd2HE1haSmWTq70yIUhTiHkKoQJPMf8wzP7PLhO2
 u3n6Y87x374NmY967CeXgXyFusBZfq8lSUS6GRvKKwcF2fKo8JAJ5O16mxvaF5O+bYLa
 WFt1F2yei46k5N3qx+1e6mMGSLCmedTgtMAzcWC7zqMHZMZ/Fd2Wirkt9kucb72Y/ou2
 S4uXbh1gcJEr1kfEkOlU0inAcK+ieelSO0irGrRUgZKRJZnjGkdU38cegtEV0U+QTznz
 6B7NDEwVpKy3HNulL8p4XiXZFVarlFwhRmERU2rs6kGsBxYmF/0Q/p8JKKS5eDUuBhVp
 DR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=TjZliZhEsVF0vv2Qzf2ABh+Szj2+Cht1CR4qLXA8WKs=;
 b=Lr7yAhzvL36eJ3YNfPCzjzJudvahVQY8Liuh8hX+mNnunpZLcFrouX8hJ0aUm+JpKn
 uhhoMxe0QpTqqXPJ0DREa/FgnJz+8sT7ses85pMyX9cwfuh7pib2DuqzVrDOx0svQYpu
 PWO4jf4zEkRCG7qDBB9JIpTU/n5aw909JcDbjBNbDLd6HykMg3Y3MZqDIKVPWB3rpOMU
 hGKa/yiEw9nttRzYOrU+gdbvzHA3vdTNoIHdSpQYthNYw4UpsuiXPy6WaGQ315lyt73a
 wOmYSv4h+WrGX7DQVsoMR62U74v2+fRQLDVgupPPq27ogXzlZ/+awA6iUkqrgCCAobnO
 2OeQ==
X-Gm-Message-State: APjAAAWg3G5cEb4X34KJqbuzuBwf31+DKf5g1vHupdahClSjmMqK7m2K
 vjOXAdm8XPaipVWdNQXdCLNIUA==
X-Google-Smtp-Source: APXvYqxtIcgrBiDKLeASvf8gn0lOXPTTmaDcm7OTaoZzAxinWkAmEe+ADlHRDANovxJgHzTiYp0XOQ==
X-Received: by 2002:a5d:6652:: with SMTP id f18mr28426278wrw.246.1575290080160; 
 Mon, 02 Dec 2019 04:34:40 -0800 (PST)
Received: from f2.redhat.com (bzq-79-182-78-197.red.bezeqint.net.
 [79.182.78.197])
 by smtp.gmail.com with ESMTPSA id k8sm17134658wrl.3.2019.12.02.04.34.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 02 Dec 2019 04:34:39 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, kraxel@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 1/2] usb-host: remove 'remote wakeup' flag from configuration
 descriptor
Date: Mon,  2 Dec 2019 14:34:29 +0200
Message-Id: <20191202123430.7125-2-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191202123430.7125-1-yuri.benditovich@daynix.com>
References: <20191202123430.7125-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
 hw/usb/host-libusb.c | 18 ++++++++++++++++++
 hw/usb/trace-events  |  1 +
 3 files changed, 20 insertions(+)

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
index fcf48c0193..77c2720ec6 100644
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
@@ -394,6 +397,20 @@ static void LIBUSB_CALL usb_host_req_complete_ctrl(struct libusb_transfer *xfer)
             r->cbuf[7] == 9) {
             r->cbuf[7] = 64;
         }
+        /* If this is GET_DESCRIPTOR request for configuration descriptor,
+         * remove 'remote wakeup' flag from it to prevent idle power down
+         * in Windows guest */
+        if (s->suppress_remote_wake &&
+            udev->setup_buf[0] == USB_DIR_IN &&
+            udev->setup_buf[1] == USB_REQ_GET_DESCRIPTOR &&
+            udev->setup_buf[3] == USB_DT_CONFIG && udev->setup_buf[2] == 0 &&
+            xfer->actual_length > offsetof(struct libusb_config_descriptor, bmAttributes) &&
+            (conf->bmAttributes & USB_CFG_ATT_WAKEUP)) {
+                struct libusb_device_descriptor desc;
+                libusb_get_device_descriptor(s->dev, &desc);
+                trace_usb_host_remote_wakeup_removed(desc.idVendor, desc.idProduct);
+                conf->bmAttributes &= ~USB_CFG_ATT_WAKEUP;
+        }
     }
     trace_usb_host_req_complete(s->bus_num, s->addr, r->p,
                                 r->p->status, r->p->actual_length);
@@ -1596,6 +1613,7 @@ static Property usb_host_dev_properties[] = {
                        LIBUSB_LOG_LEVEL_WARNING),
     DEFINE_PROP_BIT("pipeline",    USBHostDevice, options,
                     USB_HOST_OPT_PIPELINE, true),
+    DEFINE_PROP_BOOL("suppress-remote-wake", USBHostDevice, suppress_remote_wake, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index 2d3713351c..6f87b5262a 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -266,3 +266,4 @@ usb_host_parse_config(int bus, int addr, int value, int active) "dev %d:%d, valu
 usb_host_parse_interface(int bus, int addr, int num, int alt, int active) "dev %d:%d, num %d, alt %d, active %d"
 usb_host_parse_endpoint(int bus, int addr, int ep, const char *dir, const char *type, int active) "dev %d:%d, ep %d, %s, %s, active %d"
 usb_host_parse_error(int bus, int addr, const char *errmsg) "dev %d:%d, msg %s"
+usb_host_remote_wakeup_removed(uint16_t vid, uint16_t pid) "dev %04x:%04x"
-- 
2.17.1


