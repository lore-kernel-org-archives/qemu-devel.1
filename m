Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993BBC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6911F20705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="uPvEhTNV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6911F20705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip7Nz-0003uH-6R
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 04:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1ip7Mg-0002bv-8v
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:11:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1ip7Md-0004QP-Ty
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:10:57 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40500)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1ip7Md-0004Ph-O6
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:10:55 -0500
Received: by mail-wm1-x344.google.com with SMTP id t14so1620838wmi.5
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 01:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=oleLHXvsiH5kmJRmH4yj69sUgKLCLz1ATCZG6rLhml8=;
 b=uPvEhTNVhjiWZZo9jyzEevVEDzgTrr7TFaD3a5bQ3ql/sTjrPmqE/OoAfwjZCwzxL3
 EypB6cu8s/4R8Siot7du+u3J3DvsSk7fKDid6YIagrG5LVQsBPhF9nGnKgO9UbbAyovc
 tmHo58ecp/W9gJ1SIGGCl4YflsebLIPoqCDtuflz+ffGbXnfuLHkByrQHQQr/ZjPblR6
 LhpFT2T5/zzuMkhRYKYk0083yQdJpBTZBdlPT35ssxFWg7yZp6Yv1li3W18G0Jhs4rtR
 PjZIQrZLB9oXY9cjc5AqOsZRln5HeMyHBX6uGeulET3gDyCNVVITg9mBq5t4FvrhlN1A
 Rfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=oleLHXvsiH5kmJRmH4yj69sUgKLCLz1ATCZG6rLhml8=;
 b=FHo+WWKMKL7mxm+Dj5xwdCuZ3J769Omw//JClhbPoZfswPWHMpQnkln/C6t2B1uuf9
 oKwu+9ieelh7hnz39wLzP2tSkxL3q3t3ymLrFMpmor9s5+APtost1MyG7dDM9k1thtRm
 TtvWBWxNK2MdNOWuKnW10795qMcoJZ69aDx6nagZ/CVyfEkhi8MUFlWhlpNnMJno24BA
 UtFon0trKaXFex16Xr9NA4pI3oMSyX/dTceLJOfpeJMTL4+vo0bLioXN8Rg2kRT6AnBi
 8vnz+A67zXTohweIVRghqRFpD6jAtzHd/z+ISqRwxZsleyHKNLBZPXbfvgZwWb2c4FMI
 /vAw==
X-Gm-Message-State: APjAAAVq+KapDRhlAmAhSqGXSnoHTkCJNZIrkWpzaHHdzdvPZSUSO8cy
 HwauxnWdsLEFpEominmsoG0qOg==
X-Google-Smtp-Source: APXvYqxxyPWZesJhQ/bLsYNtXblEAU2yspabipZx/hKEEAA6xkDy9k/xmkNFnJ325lB6Xw170lFajw==
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr2480758wmc.168.1578474654781; 
 Wed, 08 Jan 2020 01:10:54 -0800 (PST)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net.
 [79.177.42.131])
 by smtp.gmail.com with ESMTPSA id q3sm2892676wmc.47.2020.01.08.01.10.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 08 Jan 2020 01:10:54 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, kraxel@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] usb-redir: remove 'remote wakeup' flag from
 configuration descriptor
Date: Wed,  8 Jan 2020 11:10:44 +0200
Message-Id: <20200108091044.18055-3-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108091044.18055-1-yuri.benditovich@daynix.com>
References: <20200108091044.18055-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Set 'usb-redir.suppress-remote-wake' property to 'off' to keep
'remote wake' as is or to 'on' to remove 'remote wake' on
4.2 or earlier.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 hw/core/machine.c |  1 +
 hw/usb/redirect.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index c5d32f56db..3e288bfceb 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -33,6 +33,7 @@ GlobalProperty hw_compat_4_2[] = {
     { "virtio-scsi-device", "seg_max_adjust", "off"},
     { "vhost-blk-device", "seg_max_adjust", "off"},
     { "usb-host", "suppress-remote-wake", "off" },
+    { "usb-redir", "suppress-remote-wake", "off" },
 };
 const size_t hw_compat_4_2_len = G_N_ELEMENTS(hw_compat_4_2);
 
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index e0f5ca6f81..b5c1558687 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -113,6 +113,7 @@ struct USBRedirDevice {
     /* Properties */
     CharBackend cs;
     bool enable_streams;
+    bool suppress_remote_wake;
     uint8_t debug;
     int32_t bootindex;
     char *filter_str;
@@ -1989,6 +1990,23 @@ static void usbredir_control_packet(void *priv, uint64_t id,
             memcpy(dev->dev.data_buf, data, data_len);
         }
         p->actual_length = len;
+        /*
+         * If this is GET_DESCRIPTOR request for configuration descriptor,
+         * remove 'remote wakeup' flag from it to prevent idle power down
+         * in Windows guest
+         */
+        if (dev->suppress_remote_wake &&
+            control_packet->requesttype == USB_DIR_IN &&
+            control_packet->request == USB_REQ_GET_DESCRIPTOR &&
+            control_packet->value == (USB_DT_CONFIG << 8) &&
+            control_packet->index == 0 &&
+            /* bmAttributes field of config descriptor */
+            len > 7 && (dev->dev.data_buf[7] & USB_CFG_ATT_WAKEUP)) {
+                DPRINTF("Removed remote wake %04X:%04X\n",
+                    dev->device_info.vendor_id,
+                    dev->device_info.product_id);
+                dev->dev.data_buf[7] &= ~USB_CFG_ATT_WAKEUP;
+            }
         usb_generic_async_ctrl_complete(&dev->dev, p);
     }
     free(data);
@@ -2530,6 +2548,8 @@ static Property usbredir_properties[] = {
     DEFINE_PROP_UINT8("debug", USBRedirDevice, debug, usbredirparser_warning),
     DEFINE_PROP_STRING("filter", USBRedirDevice, filter_str),
     DEFINE_PROP_BOOL("streams", USBRedirDevice, enable_streams, true),
+    DEFINE_PROP_BOOL("suppress-remote-wake", USBRedirDevice,
+                     suppress_remote_wake, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.17.1


