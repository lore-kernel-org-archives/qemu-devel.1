Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52949C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 05:51:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11FD220738
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 05:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MH2OFybw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FD220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8H03-0006qE-8F
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 01:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k8GwN-0007bp-Dv
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 01:47:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35043
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k8GwH-0006hj-LJ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 01:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597816014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Lzhmj//O7v2F3kl+IvlYRmsUEF5FVjCObAdqNJls28=;
 b=MH2OFybw5KwptDE/3rkacIsS7TbJ807wT6qz5KTlYjhz/pfyUTD3DMlD8mrAJOBMhP2WBi
 gV3Q/WebTskWKTesGotBrvXhFAqNfSZTuqX5lFgv7fi85GH11KLzh7eSYMLpZHFisFJ4wv
 59yu/E0MA/MZbEtt2vWiunPEV729zNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-aljN4Q4ROFCdHHsQfrdjlg-1; Wed, 19 Aug 2020 01:46:52 -0400
X-MC-Unique: aljN4Q4ROFCdHHsQfrdjlg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15258801AF3;
 Wed, 19 Aug 2020 05:46:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com
 [10.36.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 325381014183;
 Wed, 19 Aug 2020 05:46:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F2F4931E47; Wed, 19 Aug 2020 07:46:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/17] hw/usb: Add U2F device autoscan to passthru mode
Date: Wed, 19 Aug 2020 07:46:44 +0200
Message-Id: <20200819054644.30610-18-kraxel@redhat.com>
In-Reply-To: <20200819054644.30610-1-kraxel@redhat.com>
References: <20200819054644.30610-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:06:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: César Belley <cesar.belley@lse.epita.fr>

This patch adds an autoscan to let u2f-passthru choose the first U2F
device it finds.

The autoscan is performed using libudev with an enumeration of all the
hidraw devices present on the host.

The first device which happens to be a U2F device is taken to do the
pass-through.

Signed-off-by: César Belley <cesar.belley@lse.epita.fr>
Message-id: 20200812094135.20550-14-cesar.belley@lse.epita.fr
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 docs/u2f.txt          |   9 ++++
 hw/usb/u2f-passthru.c | 113 +++++++++++++++++++++++++++++++++++++-----
 hw/usb/Makefile.objs  |   1 +
 3 files changed, 110 insertions(+), 13 deletions(-)

diff --git a/docs/u2f.txt b/docs/u2f.txt
index f60052882ec3..8f44994818a2 100644
--- a/docs/u2f.txt
+++ b/docs/u2f.txt
@@ -42,6 +42,10 @@ on libu2f-emu: configuring and building:
 
     ./configure --enable-u2f && make
 
+The pass-through mode is built by default on Linux. To take advantage
+of the autoscan option it provides, make sure you have a working libudev
+installed on the host.
+
 
 3. Using u2f-emulated
 
@@ -90,6 +94,11 @@ On the host specify the u2f-passthru device with a suitable hidraw:
 
     qemu -usb -device u2f-passthru,hidraw=/dev/hidraw0
 
+Alternately, the u2f-passthru device can autoscan to take the first
+U2F device it finds on the host (this requires a working libudev):
+
+    qemu -usb -device u2f-passthru
+
 
 5. Libu2f-emu
 
diff --git a/hw/usb/u2f-passthru.c b/hw/usb/u2f-passthru.c
index f8771966c747..1311530ee5ba 100644
--- a/hw/usb/u2f-passthru.c
+++ b/hw/usb/u2f-passthru.c
@@ -378,6 +378,84 @@ static bool u2f_passthru_is_u2f_device(int fd)
                   sizeof(u2f_hid_report_desc_header)) == 0;
 }
 
+#ifdef CONFIG_LIBUDEV
+static int u2f_passthru_open_from_device(struct udev_device *device)
+{
+    const char *devnode = udev_device_get_devnode(device);
+
+    int fd = qemu_open(devnode, O_RDWR);
+    if (fd < 0) {
+        return -1;
+    } else if (!u2f_passthru_is_u2f_device(fd)) {
+        qemu_close(fd);
+        return -1;
+    }
+    return fd;
+}
+
+static int u2f_passthru_open_from_enumerate(struct udev *udev,
+                                            struct udev_enumerate *enumerate)
+{
+    struct udev_list_entry *devices, *entry;
+    int ret, fd;
+
+    ret = udev_enumerate_scan_devices(enumerate);
+    if (ret < 0) {
+        return -1;
+    }
+
+    devices = udev_enumerate_get_list_entry(enumerate);
+    udev_list_entry_foreach(entry, devices) {
+        struct udev_device *device;
+        const char *syspath = udev_list_entry_get_name(entry);
+
+        if (syspath == NULL) {
+            continue;
+        }
+
+        device = udev_device_new_from_syspath(udev, syspath);
+        if (device == NULL) {
+            continue;
+        }
+
+        fd = u2f_passthru_open_from_device(device);
+        udev_device_unref(device);
+        if (fd >= 0) {
+            return fd;
+        }
+    }
+    return -1;
+}
+
+static int u2f_passthru_open_from_scan(void)
+{
+    struct udev *udev;
+    struct udev_enumerate *enumerate;
+    int ret, fd = -1;
+
+    udev = udev_new();
+    if (udev == NULL) {
+        return -1;
+    }
+
+    enumerate = udev_enumerate_new(udev);
+    if (enumerate == NULL) {
+        udev_unref(udev);
+        return -1;
+    }
+
+    ret = udev_enumerate_add_match_subsystem(enumerate, "hidraw");
+    if (ret >= 0) {
+        fd = u2f_passthru_open_from_enumerate(udev, enumerate);
+    }
+
+    udev_enumerate_unref(enumerate);
+    udev_unref(udev);
+
+    return fd;
+}
+#endif
+
 static void u2f_passthru_unrealize(U2FKeyState *base)
 {
     U2FPassthruState *key = PASSTHRU_U2F_KEY(base);
@@ -392,22 +470,31 @@ static void u2f_passthru_realize(U2FKeyState *base, Error **errp)
     int fd;
 
     if (key->hidraw == NULL) {
+#ifdef CONFIG_LIBUDEV
+        fd = u2f_passthru_open_from_scan();
+        if (fd < 0) {
+            error_setg(errp, "%s: Failed to find a U2F USB device",
+                       TYPE_U2F_PASSTHRU);
+            return;
+        }
+#else
         error_setg(errp, "%s: Missing hidraw", TYPE_U2F_PASSTHRU);
         return;
-    }
+#endif
+    } else {
+        fd = qemu_open(key->hidraw, O_RDWR);
+        if (fd < 0) {
+            error_setg(errp, "%s: Failed to open %s", TYPE_U2F_PASSTHRU,
+                       key->hidraw);
+            return;
+        }
 
-    fd = qemu_open(key->hidraw, O_RDWR);
-    if (fd < 0) {
-        error_setg(errp, "%s: Failed to open %s", TYPE_U2F_PASSTHRU,
-                   key->hidraw);
-        return;
-    }
-
-    if (!u2f_passthru_is_u2f_device(fd)) {
-        qemu_close(fd);
-        error_setg(errp, "%s: Passed hidraw does not represent "
-                   "a U2F HID device", TYPE_U2F_PASSTHRU);
-        return;
+        if (!u2f_passthru_is_u2f_device(fd)) {
+            qemu_close(fd);
+            error_setg(errp, "%s: Passed hidraw does not represent "
+                       "a U2F HID device", TYPE_U2F_PASSTHRU);
+            return;
+        }
     }
     key->hidraw_fd = fd;
     u2f_passthru_reset(key);
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 9e7e1f33a51e..7c0ee92ca47a 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -41,6 +41,7 @@ ifeq ($(CONFIG_USB_U2F),y)
 common-obj-y                          += u2f.o
 common-obj-$(CONFIG_LINUX)            += u2f-passthru.o
 common-obj-$(CONFIG_U2F)              += u2f-emulated.o
+u2f-passthru.o-libs = $(LIBUDEV_LIBS)
 u2f-emulated.o-cflags = $(U2F_CFLAGS)
 u2f-emulated.o-libs = $(U2F_LIBS)
 endif
-- 
2.18.4


