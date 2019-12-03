Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12072C432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 20:11:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF73320409
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 20:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="b1XvUhqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF73320409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icEVv-0004o1-Q7
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 15:11:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1icDWN-0008DB-5h
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 14:07:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1icDWH-00050v-1l
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 14:07:37 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39092)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1icDWG-0004r3-LX
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 14:07:32 -0500
Received: by mail-wm1-x343.google.com with SMTP id s14so4834086wmh.4
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 11:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4IEYfz9t+Zw7YNj6ThlO0KBz4N6TfDMprFZHPoQ5uBc=;
 b=b1XvUhqY5P1h84B5HP3HngILr1Iyo+jVtfua1NfjpeHD96vGni8JYS4Y1nLY+AiduB
 3kZQqM4OzBvDzPdSTaQmtVJog/Y85xYcY8cvUsiGvKVMfGvcv3JjBCtTdBql1ozXxh5Z
 /GAiGb0JfSEq8Z9Ea7lXs0NEPcL3dRhPoTrraMagyfnSqB3o8MZK4nm+Yii+e5G3/G+S
 Cmsq6ASBd2SDCx/XUUu/VHPziSvrpdQwODGt+SdqL4sHtbP9ha85Mg2Uc7Xvaee6H0cU
 yRfsQ+evtGR6mX4cc5ypVJRnzEmQsXM99jEALNct4DbOW/qDMHO6GZhG4v6GpNQ3usIQ
 ccGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4IEYfz9t+Zw7YNj6ThlO0KBz4N6TfDMprFZHPoQ5uBc=;
 b=uoLztg9K0jRHlY26UNx6PdVi9VmsXRNqYrB2CXmxWsNK/cARmYEZ4tq82Wb9S5MhnM
 0FcQq/IKNHEuQgxXSTPd31wMtACmjO6uNdymctHl5uFF7hgNSasbvFM/DbIPdZ8IKNWD
 sqU9m1RHLAesJYq35qNyUoP7ibZmbCH8jXziCxmKt73PYKkmCmcu04UEwFJGEyimsSV2
 Us6H9IvysIF+ikav6hp+rYa3+vU3hyu4ieNHjI0RaGSejm49gbNwxYhRx9pG7Y3AW6hZ
 z7FTjAg0uynCCmYgMwleoUyckbxeSdA6XgwBW/vWbd9Gc2XzbwVciRLpeb1xscQMtOp9
 1t0g==
X-Gm-Message-State: APjAAAXqWiSnpP2FLZbXH3s0Eharw1V5073ASYnatdVjK36XIqjNjyOR
 a37DcQJzzsc5l9G6lA7CVNFvsg==
X-Google-Smtp-Source: APXvYqzEvT1Btuzy8FZzAodgtEn3lWRtVa+1iS9kg5Unopv1qfEBado6iguijFxGtxfAmkwL0XfOyQ==
X-Received: by 2002:a7b:cc97:: with SMTP id p23mr37630553wma.89.1575400050218; 
 Tue, 03 Dec 2019 11:07:30 -0800 (PST)
Received: from f2.redhat.com (bzq-79-182-78-197.red.bezeqint.net.
 [79.182.78.197])
 by smtp.gmail.com with ESMTPSA id t12sm4828810wrs.96.2019.12.03.11.07.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 03 Dec 2019 11:07:27 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, kraxel@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] usb-redir: remove 'remote wakeup' flag from
 configuration descriptor
Date: Tue,  3 Dec 2019 21:07:16 +0200
Message-Id: <20191203190716.18917-3-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203190716.18917-1-yuri.benditovich@daynix.com>
References: <20191203190716.18917-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Set 'usb-redir.suppress-remote-wake' property to 'off' to keep
'remote wake' as is or to 'on' to remove 'remote wake' on
4.1 or earlier.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 hw/core/machine.c |  1 +
 hw/usb/redirect.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 8c0eaad091..44408ff87c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -30,6 +30,7 @@
 GlobalProperty hw_compat_4_1[] = {
     { "virtio-pci", "x-pcie-flr-init", "off" },
     { "usb-host", "suppress-remote-wake", "off" },
+    { "usb-redir", "suppress-remote-wake", "off" },
 };
 const size_t hw_compat_4_1_len = G_N_ELEMENTS(hw_compat_4_1);
 
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


