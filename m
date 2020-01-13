Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EB2C33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 13:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 455502081E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 13:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oa4XdfJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455502081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqzRw-0005WX-5J
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 08:08:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iqzQm-0004Tt-OB
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:06:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iqzQl-0006XS-Fn
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:06:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48085
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iqzQl-0006XC-C8
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578920814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wmzn7Z+CVL3WVdeqryNBNn3lSDikLikHYNpxey9mHwY=;
 b=Oa4XdfJPXf3jKw7sTOAXam6eBqVX7jTWsy6Tfs0o7uU24Duh2tZgU4LM25vipVed8SaRy2
 0sbmkkdQ4rFhLDAvPvocM3Rg9/cJCpopfLEFD4WB4aL1kwH2DCwIe6v/sHDPi/PWYpR/M5
 vR5C7yS/dMMpH5IIwmxnZiHJtvFtAEE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-4B5RGZExO6WrIH7bn1hePw-1; Mon, 13 Jan 2020 08:06:51 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34AECDB8B;
 Mon, 13 Jan 2020 13:06:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-106.ams2.redhat.com
 [10.36.116.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 117CB88867;
 Mon, 13 Jan 2020 13:06:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4358C31E49; Mon, 13 Jan 2020 14:06:46 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/5] usb-host: remove 'remote wakeup' flag from configuration
 descriptor
Date: Mon, 13 Jan 2020 14:06:42 +0100
Message-Id: <20200113130646.30099-2-kraxel@redhat.com>
In-Reply-To: <20200113130646.30099-1-kraxel@redhat.com>
References: <20200113130646.30099-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 4B5RGZExO6WrIH7bn1hePw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Set 'usb-host.suppress-remote-wake' property to 'off' to keep
'remote wake' as is or to 'on' to remove 'remote wake' on
4.2 or earlier.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Message-id: 20200108091044.18055-2-yuri.benditovich@daynix.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/core/machine.c    |  1 +
 hw/usb/host-libusb.c | 20 ++++++++++++++++++++
 hw/usb/trace-events  |  1 +
 3 files changed, 22 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 4f30fb56463c..c5d32f56db93 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -32,6 +32,7 @@ GlobalProperty hw_compat_4_2[] =3D {
     { "virtio-blk-device", "seg-max-adjust", "off"},
     { "virtio-scsi-device", "seg_max_adjust", "off"},
     { "vhost-blk-device", "seg_max_adjust", "off"},
+    { "usb-host", "suppress-remote-wake", "off" },
 };
 const size_t hw_compat_4_2_len =3D G_N_ELEMENTS(hw_compat_4_2);
=20
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index fcf48c019333..00e0e3636978 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -88,6 +88,7 @@ struct USBHostDevice {
     bool                             needs_autoscan;
     bool                             allow_one_guest_reset;
     bool                             allow_all_guest_resets;
+    bool                             suppress_remote_wake;
=20
     /* state */
     QTAILQ_ENTRY(USBHostDevice)      next;
@@ -386,6 +387,8 @@ static void LIBUSB_CALL usb_host_req_complete_ctrl(stru=
ct libusb_transfer *xfer)
     r->p->status =3D status_map[xfer->status];
     r->p->actual_length =3D xfer->actual_length;
     if (r->in && xfer->actual_length) {
+        USBDevice *udev =3D USB_DEVICE(s);
+        struct libusb_config_descriptor *conf =3D (void *)r->cbuf;
         memcpy(r->cbuf, r->buffer + 8, xfer->actual_length);
=20
         /* Fix up USB-3 ep0 maxpacket size to allow superspeed connected d=
evices
@@ -394,6 +397,21 @@ static void LIBUSB_CALL usb_host_req_complete_ctrl(str=
uct libusb_transfer *xfer)
             r->cbuf[7] =3D=3D 9) {
             r->cbuf[7] =3D 64;
         }
+        /*
+         *If this is GET_DESCRIPTOR request for configuration descriptor,
+         * remove 'remote wakeup' flag from it to prevent idle power down
+         * in Windows guest
+         */
+        if (s->suppress_remote_wake &&
+            udev->setup_buf[0] =3D=3D USB_DIR_IN &&
+            udev->setup_buf[1] =3D=3D USB_REQ_GET_DESCRIPTOR &&
+            udev->setup_buf[3] =3D=3D USB_DT_CONFIG && udev->setup_buf[2] =
=3D=3D 0 &&
+            xfer->actual_length >
+                offsetof(struct libusb_config_descriptor, bmAttributes) &&
+            (conf->bmAttributes & USB_CFG_ATT_WAKEUP)) {
+                trace_usb_host_remote_wakeup_removed(s->bus_num, s->addr);
+                conf->bmAttributes &=3D ~USB_CFG_ATT_WAKEUP;
+        }
     }
     trace_usb_host_req_complete(s->bus_num, s->addr, r->p,
                                 r->p->status, r->p->actual_length);
@@ -1596,6 +1614,8 @@ static Property usb_host_dev_properties[] =3D {
                        LIBUSB_LOG_LEVEL_WARNING),
     DEFINE_PROP_BIT("pipeline",    USBHostDevice, options,
                     USB_HOST_OPT_PIPELINE, true),
+    DEFINE_PROP_BOOL("suppress-remote-wake", USBHostDevice,
+                     suppress_remote_wake, true),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index 2d3713351c38..1c24d82c09c0 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -266,3 +266,4 @@ usb_host_parse_config(int bus, int addr, int value, int=
 active) "dev %d:%d, valu
 usb_host_parse_interface(int bus, int addr, int num, int alt, int active) =
"dev %d:%d, num %d, alt %d, active %d"
 usb_host_parse_endpoint(int bus, int addr, int ep, const char *dir, const =
char *type, int active) "dev %d:%d, ep %d, %s, %s, active %d"
 usb_host_parse_error(int bus, int addr, const char *errmsg) "dev %d:%d, ms=
g %s"
+usb_host_remote_wakeup_removed(int bus, int addr) "dev %d:%d"
--=20
2.18.1


