Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D98C33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 13:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40DF4214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 13:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5goVuK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DF4214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqzUf-0000zo-B7
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 08:10:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iqzQu-0004h1-Dd
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:07:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iqzQs-0006cS-Oa
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:07:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21302
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iqzQs-0006c1-KU
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578920822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bgZRu74Ev5zWTcLnXsonTOt1OV2DaaNsGh1rVetOcww=;
 b=d5goVuK88R+yhWnlfLYTr7LnYU9KdhHUiiX8UrOZtq5P4MTjxXtpMGx/zEHSWDaYMl13pS
 1dlxBM7/veHE4tmSxyP4XelvE1Xd2DlytRzL5dNbDu+zmOcsqtH/9UqrM4BUQzk7SXE3ig
 YVK4CGbZ4cV79zZ3stP7ZszkbnO7NAI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-sfgX5eDTP-utgYgRAzsSkQ-1; Mon, 13 Jan 2020 08:06:51 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13AA710CE78F;
 Mon, 13 Jan 2020 13:06:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-106.ams2.redhat.com
 [10.36.116.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 11CD660C88;
 Mon, 13 Jan 2020 13:06:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4D44E31F47; Mon, 13 Jan 2020 14:06:46 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/5] usb-redir: remove 'remote wakeup' flag from configuration
 descriptor
Date: Mon, 13 Jan 2020 14:06:43 +0100
Message-Id: <20200113130646.30099-3-kraxel@redhat.com>
In-Reply-To: <20200113130646.30099-1-kraxel@redhat.com>
References: <20200113130646.30099-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: sfgX5eDTP-utgYgRAzsSkQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yuri Benditovich <yuri.benditovich@daynix.com>

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
Message-id: 20200108091044.18055-3-yuri.benditovich@daynix.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/core/machine.c |  1 +
 hw/usb/redirect.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index c5d32f56db93..3e288bfceb7f 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -33,6 +33,7 @@ GlobalProperty hw_compat_4_2[] =3D {
     { "virtio-scsi-device", "seg_max_adjust", "off"},
     { "vhost-blk-device", "seg_max_adjust", "off"},
     { "usb-host", "suppress-remote-wake", "off" },
+    { "usb-redir", "suppress-remote-wake", "off" },
 };
 const size_t hw_compat_4_2_len =3D G_N_ELEMENTS(hw_compat_4_2);
=20
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index e0f5ca6f818b..b5c15586874a 100644
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
@@ -1989,6 +1990,23 @@ static void usbredir_control_packet(void *priv, uint=
64_t id,
             memcpy(dev->dev.data_buf, data, data_len);
         }
         p->actual_length =3D len;
+        /*
+         * If this is GET_DESCRIPTOR request for configuration descriptor,
+         * remove 'remote wakeup' flag from it to prevent idle power down
+         * in Windows guest
+         */
+        if (dev->suppress_remote_wake &&
+            control_packet->requesttype =3D=3D USB_DIR_IN &&
+            control_packet->request =3D=3D USB_REQ_GET_DESCRIPTOR &&
+            control_packet->value =3D=3D (USB_DT_CONFIG << 8) &&
+            control_packet->index =3D=3D 0 &&
+            /* bmAttributes field of config descriptor */
+            len > 7 && (dev->dev.data_buf[7] & USB_CFG_ATT_WAKEUP)) {
+                DPRINTF("Removed remote wake %04X:%04X\n",
+                    dev->device_info.vendor_id,
+                    dev->device_info.product_id);
+                dev->dev.data_buf[7] &=3D ~USB_CFG_ATT_WAKEUP;
+            }
         usb_generic_async_ctrl_complete(&dev->dev, p);
     }
     free(data);
@@ -2530,6 +2548,8 @@ static Property usbredir_properties[] =3D {
     DEFINE_PROP_UINT8("debug", USBRedirDevice, debug, usbredirparser_warni=
ng),
     DEFINE_PROP_STRING("filter", USBRedirDevice, filter_str),
     DEFINE_PROP_BOOL("streams", USBRedirDevice, enable_streams, true),
+    DEFINE_PROP_BOOL("suppress-remote-wake", USBRedirDevice,
+                     suppress_remote_wake, true),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
--=20
2.18.1


