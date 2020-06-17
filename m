Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAFDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:49:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C682208B3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUM0Bgya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C682208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlVcx-000793-Lm
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 06:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jlVbu-0005ak-Jq
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:48:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47342
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jlVbs-0002gJ-NV
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592390879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=xhmwee+Y4JGFaQc53CHJpDOrdxOLP9hAvf81Ykk3JtY=;
 b=GUM0BgyaGLzbR9On4r32xdN8bF/5YgCu1UKFsiGSorFdIlIhsRDONDtq4lJOrOXmCIKtZk
 g6YKI52hkpOteQItyecOIhUzgOH2JNgZN42GkBPmVvacOQZBhW3LiJUkdgPrKPzDL2dO7j
 HbAgJZxT69ILmhXcIGLOyqEIl817djA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-OCVD7lTfPMSM0GF6AVysVA-1; Wed, 17 Jun 2020 06:47:55 -0400
X-MC-Unique: OCVD7lTfPMSM0GF6AVysVA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3A8D80F5E9
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 10:47:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF6D97CACF;
 Wed, 17 Jun 2020 10:47:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 875A71750C; Wed, 17 Jun 2020 12:47:50 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/2] usb: add hostdevice property to usb-host
Date: Wed, 17 Jun 2020 12:47:49 +0200
Message-Id: <20200617104750.29511-2-kraxel@redhat.com>
In-Reply-To: <20200617104750.29511-1-kraxel@redhat.com>
References: <20200617104750.29511-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

The new property allows to specify usb host device name.  Uses standard
qemu_open(), so both file system path (/dev/bus/usb/$bus/$dev on linux)
and file descriptor passing can be used.

Requires libusb 1.0.23 or newer.  The hostdevice property is only
present in case qemu is compiled against a new enough library version,
so the presence of the property can be used for feature detection.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20200605125952.13113-1-kraxel@redhat.com>
---
 hw/usb/host-libusb.c | 75 +++++++++++++++++++++++++++++++++++---------
 hw/usb/trace-events  |  1 +
 2 files changed, 62 insertions(+), 14 deletions(-)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index e28441379d99..e88db544bc9e 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -80,6 +80,7 @@ struct USBHostDevice {
 
     /* properties */
     struct USBAutoFilter             match;
+    char                             *hostdevice;
     int32_t                          bootindex;
     uint32_t                         iso_urb_count;
     uint32_t                         iso_urb_frames;
@@ -97,6 +98,7 @@ struct USBHostDevice {
     int                              addr;
     char                             port[16];
 
+    int                              hostfd;
     libusb_device                    *dev;
     libusb_device_handle             *dh;
     struct libusb_device_descriptor  ddesc;
@@ -880,26 +882,45 @@ static void usb_host_ep_update(USBHostDevice *s)
     libusb_free_config_descriptor(conf);
 }
 
-static int usb_host_open(USBHostDevice *s, libusb_device *dev)
+static int usb_host_open(USBHostDevice *s, libusb_device *dev, int hostfd)
 {
     USBDevice *udev = USB_DEVICE(s);
-    int bus_num = libusb_get_bus_number(dev);
-    int addr    = libusb_get_device_address(dev);
+    int bus_num = 0;
+    int addr = 0;
     int rc;
     Error *local_err = NULL;
 
     if (s->bh_postld_pending) {
         return -1;
     }
-
-    trace_usb_host_open_started(bus_num, addr);
-
     if (s->dh != NULL) {
         goto fail;
     }
-    rc = libusb_open(dev, &s->dh);
-    if (rc != 0) {
-        goto fail;
+
+    if (dev) {
+        bus_num = libusb_get_bus_number(dev);
+        addr = libusb_get_device_address(dev);
+        trace_usb_host_open_started(bus_num, addr);
+
+        rc = libusb_open(dev, &s->dh);
+        if (rc != 0) {
+            goto fail;
+        }
+    } else {
+#if LIBUSB_API_VERSION >= 0x01000107
+        trace_usb_host_open_hostfd(hostfd);
+
+        rc = libusb_wrap_sys_device(ctx, hostfd, &s->dh);
+        if (rc != 0) {
+            goto fail;
+        }
+        s->hostfd  = hostfd;
+        dev = libusb_get_device(s->dh);
+        bus_num = libusb_get_bus_number(dev);
+        addr = libusb_get_device_address(dev);
+#else
+        g_assert_not_reached();
+#endif
     }
 
     s->dev     = dev;
@@ -988,6 +1009,11 @@ static int usb_host_close(USBHostDevice *s)
     s->dh = NULL;
     s->dev = NULL;
 
+    if (s->hostfd != -1) {
+        close(s->hostfd);
+        s->hostfd = -1;
+    }
+
     usb_host_auto_check(NULL);
     return 0;
 }
@@ -1025,9 +1051,6 @@ static libusb_device *usb_host_find_ref(int bus, int addr)
     libusb_device *ret = NULL;
     int i, n;
 
-    if (usb_host_init() != 0) {
-        return NULL;
-    }
     n = libusb_get_device_list(ctx, &devs);
     for (i = 0; i < n; i++) {
         if (libusb_get_bus_number(devs[i]) == bus &&
@@ -1046,6 +1069,10 @@ static void usb_host_realize(USBDevice *udev, Error **errp)
     libusb_device *ldev;
     int rc;
 
+    if (usb_host_init() != 0) {
+        error_setg(errp, "failed to init libusb");
+        return;
+    }
     if (s->match.vendor_id > 0xffff) {
         error_setg(errp, "vendorid out of range");
         return;
@@ -1064,7 +1091,24 @@ static void usb_host_realize(USBDevice *udev, Error **errp)
     udev->auto_attach = 0;
     QTAILQ_INIT(&s->requests);
     QTAILQ_INIT(&s->isorings);
+    s->hostfd = -1;
 
+#if LIBUSB_API_VERSION >= 0x01000107
+    if (s->hostdevice) {
+        int fd;
+        s->needs_autoscan = false;
+        fd = qemu_open(s->hostdevice, O_RDWR);
+        if (fd < 0) {
+            error_setg_errno(errp, errno, "failed to open %s", s->hostdevice);
+            return;
+        }
+        rc = usb_host_open(s, NULL, fd);
+        if (rc < 0) {
+            error_setg(errp, "failed to open host usb device %s", s->hostdevice);
+            return;
+        }
+    } else
+#endif
     if (s->match.addr && s->match.bus_num &&
         !s->match.vendor_id &&
         !s->match.product_id &&
@@ -1077,7 +1121,7 @@ static void usb_host_realize(USBDevice *udev, Error **errp)
                        s->match.bus_num, s->match.addr);
             return;
         }
-        rc = usb_host_open(s, ldev);
+        rc = usb_host_open(s, ldev, 0);
         libusb_unref_device(ldev);
         if (rc < 0) {
             error_setg(errp, "failed to open host usb device %d:%d",
@@ -1605,6 +1649,9 @@ static Property usb_host_dev_properties[] = {
     DEFINE_PROP_STRING("hostport", USBHostDevice, match.port),
     DEFINE_PROP_UINT32("vendorid",  USBHostDevice, match.vendor_id,  0),
     DEFINE_PROP_UINT32("productid", USBHostDevice, match.product_id, 0),
+#if LIBUSB_API_VERSION >= 0x01000107
+    DEFINE_PROP_STRING("hostdevice", USBHostDevice, hostdevice),
+#endif
     DEFINE_PROP_UINT32("isobufs",  USBHostDevice, iso_urb_count,    4),
     DEFINE_PROP_UINT32("isobsize", USBHostDevice, iso_urb_frames,   32),
     DEFINE_PROP_BOOL("guest-reset", USBHostDevice,
@@ -1723,7 +1770,7 @@ static void usb_host_auto_check(void *unused)
                 if (s->dh != NULL) {
                     continue;
                 }
-                if (usb_host_open(s, devs[i]) < 0) {
+                if (usb_host_open(s, devs[i], 0) < 0) {
                     s->errcount++;
                     continue;
                 }
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index 5817ce4421f5..e9cdeeed1472 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -291,6 +291,7 @@ usb_mtp_file_monitor_event(int dev, const char *path, const char *s) "dev %d, pa
 
 # host-libusb.c
 usb_host_open_started(int bus, int addr) "dev %d:%d"
+usb_host_open_hostfd(int hostfd) "hostfd %d"
 usb_host_open_success(int bus, int addr) "dev %d:%d"
 usb_host_open_failure(int bus, int addr) "dev %d:%d"
 usb_host_close(int bus, int addr) "dev %d:%d"
-- 
2.18.4


