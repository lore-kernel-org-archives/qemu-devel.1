Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2647C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:36:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B745206EB
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLTNlqwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B745206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCfIU-0004zw-Jm
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 04:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kCfFb-0008EW-Uc
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:33:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36722
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kCfFZ-0006ad-4G
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598862792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sJ/vUDTa8rToYl7gXD645Fj7KHedX4qEsoI1hsq6SB8=;
 b=JLTNlqwg2w1Xw0k9yCBo+08ajQxakfOkPtwKp6MdBQjU4aVBjWTo7Nne5If+9oW4wY1KMl
 y2NSnYa+G8CUEDKaiyM1dGmXXposwMzsliB4nTH3MRP0HhpehGEc53Uu32E+KzGnRPQMtj
 5hiah9m8b+ER/zW2GxDOyVtiaKlzdGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-RX_4cIgxOcaLDqsV-Y9H9A-1; Mon, 31 Aug 2020 04:33:10 -0400
X-MC-Unique: RX_4cIgxOcaLDqsV-Y9H9A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30457100746D;
 Mon, 31 Aug 2020 08:33:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB274614F9;
 Mon, 31 Aug 2020 08:33:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8F0C031FC6; Mon, 31 Aug 2020 10:33:02 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/18] hw/usb: Add U2F device autoscan to passthru mode
Date: Mon, 31 Aug 2020 10:32:59 +0200
Message-Id: <20200831083301.6357-17-kraxel@redhat.com>
In-Reply-To: <20200831083301.6357-1-kraxel@redhat.com>
References: <20200831083301.6357-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 02:13:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
passtru.

Signed-off-by: César Belley <cesar.belley@lse.epita.fr>
Message-id: 20200826114209.28821-13-cesar.belley@lse.epita.fr
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 docs/u2f.txt          |   9 ++++
 hw/usb/u2f-passthru.c | 113 +++++++++++++++++++++++++++++++++++++-----
 hw/usb/meson.build    |   2 +-
 3 files changed, 110 insertions(+), 14 deletions(-)

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
index 74d4ae6e9294..e9c8aa459586 100644
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
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index a25109b88c91..b7c7ff23bfbd 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -52,7 +52,7 @@ endif
 
 # U2F
 softmmu_ss.add(when: 'CONFIG_USB_U2F', if_true: files('u2f.c'))
-softmmu_ss.add(when: ['CONFIG_LINUX', 'CONFIG_USB_U2F'], if_true: files('u2f-passthru.c'))
+softmmu_ss.add(when: ['CONFIG_LINUX', 'CONFIG_USB_U2F'], if_true: [libudev, files('u2f-passthru.c')])
 if u2f.found()
   softmmu_ss.add(when: 'CONFIG_USB_U2F', if_true: [u2f, files('u2f-emulated.c')])
 endif
-- 
2.27.0


