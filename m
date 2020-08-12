Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4312FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 09:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0640F2076B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 09:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=lse.epita.fr header.i=@lse.epita.fr header.b="K65okR0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0640F2076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lse.epita.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5nIr-0004JE-5e
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 05:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=nna4=bw=lse.epita.fr=cesar.belley@cri.epita.fr>)
 id 1k5nHk-0002fH-6W
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 05:43:04 -0400
Received: from gate-2.cri.epita.net ([163.5.55.20]:40958
 helo=mail-2.srv.cri.epita.fr)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=nna4=bw=lse.epita.fr=cesar.belley@cri.epita.fr>)
 id 1k5nHi-0006m0-Cn
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 05:43:03 -0400
Received: from MattGorko-Laptop.localdomain (unknown [78.194.154.81])
 (Authenticated sender: cesar.belley)
 by mail-2.srv.cri.epita.fr (Postfix) with ESMTPSA id 1C0F841650;
 Wed, 12 Aug 2020 11:42:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lse.epita.fr; s=cri;
 t=1597225371; bh=Ow7xcEFoIVZtKJHJ+ktqJJGcAh/fPblGHYCgJTwkcXc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=K65okR0dK0nJdLRbL0BfgKynviQlyA3rLQLOHOI3ptuCraxQ9uZKs8mmkg4AmTDlb
 HzRaBKJL3bg/Yb+60sq2WKKOrBWWGixzQgJSGuJCAMxAeimTOAjhBaw5Rn8JC7fIrB
 EvwCWS08l1b+/o7XZ/JbWaTq8Hfo3rjkCwXD8x88=
From: =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/13] hw/usb: Add U2F device autoscan to passthru mode
Date: Wed, 12 Aug 2020 11:41:35 +0200
Message-Id: <20200812094135.20550-14-cesar.belley@lse.epita.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812094135.20550-1-cesar.belley@lse.epita.fr>
References: <20200812094135.20550-1-cesar.belley@lse.epita.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=163.5.55.20;
 envelope-from=srs0=nna4=bw=lse.epita.fr=cesar.belley@cri.epita.fr;
 helo=mail-2.srv.cri.epita.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 05:42:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>,
 kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds an autoscan to let u2f-passthru choose the first U2F
device it finds.

The autoscan is performed using libudev with an enumeration of all the
hidraw devices present on the host.

The first device which happens to be a U2F device is taken to do the
pass-through.

Signed-off-by: César Belley <cesar.belley@lse.epita.fr>
---
 docs/u2f.txt          |   9 ++++
 hw/usb/Makefile.objs  |   1 +
 hw/usb/u2f-passthru.c | 113 +++++++++++++++++++++++++++++++++++++-----
 3 files changed, 110 insertions(+), 13 deletions(-)

diff --git a/docs/u2f.txt b/docs/u2f.txt
index f60052882e..8f44994818 100644
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
 
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 9e7e1f33a5..7c0ee92ca4 100644
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
diff --git a/hw/usb/u2f-passthru.c b/hw/usb/u2f-passthru.c
index f8771966c7..1311530ee5 100644
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
-
-    fd = qemu_open(key->hidraw, O_RDWR);
-    if (fd < 0) {
-        error_setg(errp, "%s: Failed to open %s", TYPE_U2F_PASSTHRU,
-                   key->hidraw);
-        return;
-    }
+#endif
+    } else {
+        fd = qemu_open(key->hidraw, O_RDWR);
+        if (fd < 0) {
+            error_setg(errp, "%s: Failed to open %s", TYPE_U2F_PASSTHRU,
+                       key->hidraw);
+            return;
+        }
 
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
-- 
2.28.0


