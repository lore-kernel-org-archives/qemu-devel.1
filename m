Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50876C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 12:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA1620748
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 12:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="TpnYE5wW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA1620748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibkwj-00069x-8Z
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 07:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1ibkua-0003m4-F4
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1ibkuZ-0004gz-9x
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:34:44 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1ibkuY-0004er-U5
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:34:43 -0500
Received: by mail-wr1-x444.google.com with SMTP id z7so40572842wrl.13
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 04:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CaeYcD+6toYjz5yaN6fm3AEu5nHQdWi6KOlgGrLZDsY=;
 b=TpnYE5wWjj92bgSewhTuKaxA2m994ZMG7van9fXWF7k69zHqT4sNtacgJA1LwPesxA
 rziFP61TWpgXdkRzY73PUhBso58JwotUM7TVrgWInedABNwNrr8rLhDFLZLhE28iFbcl
 x1MQKBKT/PsBNmeBlvFxhH/oPF+PnzvSS9hCLXWGzxiUfIDhq4L7dh9JQoBPHyJYzJkS
 40R+IChG4n8OY1CylJeCqqv2zXUAQB9ci5WeoJbIGIi9M+gnrr4TxhcDhX+b6cTWV1w4
 qzD2nWWgVBgTYXVcoAFSAJISDpnwJP9KQ/ukbXnWxW9dF97AwZxWATaM5B7EvAnZHU0H
 ROKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=CaeYcD+6toYjz5yaN6fm3AEu5nHQdWi6KOlgGrLZDsY=;
 b=kzGx1Wdww0djcy0J93QbG/kWnlW1Zj7ArmQ0orFY180TQkmNeK7JxtRxTb4B746GpB
 AeaZrCSJQ0hxVzLMwl59nALjiXBL0g6Lp2DXuB/q0aqtyvZDmBaySODz3OjCjeBumSXa
 uGLmHVXmX4AdQ8tcn2reI2/dwHzRYQJK7RT6x7GxVMSK6RaNd2TWkDaTeqFLXNDTYf80
 128y9GzHD9QJMhOUHyGXRPsOULRot8b83PjPM0K4a9jGR+3M8DZxD+s8/TKJVZdwSI6I
 HLkwDgWtzHHCGFS+8jrZ4z4Iexbi1dKLoAn/dunfXLmQ9Q5uHBBG0RqsdmBvF0R+2lzp
 MORA==
X-Gm-Message-State: APjAAAXzL0X8ExRCrhkrDzEJX1iU7iEJSRB/JypUgAV6SQV+3WkoHWW5
 7KggE1qN7apJtBYgdYxZ9Pfjxw==
X-Google-Smtp-Source: APXvYqzttkUEeZfMN7aTH6e6gi7mN8eiQIYHfrKX5eTBwHeUwqAh7iVmJbX5khErxThXu38LU2lXvQ==
X-Received: by 2002:a5d:480b:: with SMTP id l11mr27362791wrq.129.1575290081354; 
 Mon, 02 Dec 2019 04:34:41 -0800 (PST)
Received: from f2.redhat.com (bzq-79-182-78-197.red.bezeqint.net.
 [79.182.78.197])
 by smtp.gmail.com with ESMTPSA id k8sm17134658wrl.3.2019.12.02.04.34.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 02 Dec 2019 04:34:40 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, kraxel@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 2/2] usb-redir: remove 'remote wakeup' flag from configuration
 descriptor
Date: Mon,  2 Dec 2019 14:34:30 +0200
Message-Id: <20191202123430.7125-3-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191202123430.7125-1-yuri.benditovich@daynix.com>
References: <20191202123430.7125-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 hw/usb/redirect.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

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
index e0f5ca6f81..7cc9c2aa00 100644
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
@@ -2530,6 +2548,7 @@ static Property usbredir_properties[] = {
     DEFINE_PROP_UINT8("debug", USBRedirDevice, debug, usbredirparser_warning),
     DEFINE_PROP_STRING("filter", USBRedirDevice, filter_str),
     DEFINE_PROP_BOOL("streams", USBRedirDevice, enable_streams, true),
+    DEFINE_PROP_BOOL("suppress-remote-wake", USBRedirDevice, suppress_remote_wake, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.17.1


