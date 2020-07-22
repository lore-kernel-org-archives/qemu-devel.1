Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B521FC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 04:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83894208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 04:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="anAJrYwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83894208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy6bY-0006pl-SJ
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 00:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jy6Yc-0002sh-Lz
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 00:40:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25262
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jy6Ya-0002mH-OI
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 00:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595392840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=MvhamPpwgReB9Sphit1s83rRsQO6ok80fcqjytucDf4=;
 b=anAJrYwkUVNUAkeVfU0uSaA3yoDp32CJPaF7qt7SesGvSmrniUgnV++52mxYqugtuMroBS
 UvlREHVTYB9NHTsfln4fKjD7hoyT40mMj4XYH51w8q76LBPNKFtWC76x7FGAREmXF+I8Wy
 7IhIsuZgg96O/XQgCTqTmRj+/e7tzPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-gawb5SmyNG6xbnbpueioKA-1; Wed, 22 Jul 2020 00:40:38 -0400
X-MC-Unique: gawb5SmyNG6xbnbpueioKA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16B4B100A8E7;
 Wed, 22 Jul 2020 04:40:37 +0000 (UTC)
Received: from thuth.com (ovpn-112-92.ams2.redhat.com [10.36.112.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A82E7268C;
 Wed, 22 Jul 2020 04:40:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Michael Roth <mdroth@linux.vnet.ibm.com>
Subject: [PATCH v2 3/4] qga/commands-posix: Move the udev code from the pci to
 the generic function
Date: Wed, 22 Jul 2020 06:40:27 +0200
Message-Id: <20200722044028.4059-4-thuth@redhat.com>
In-Reply-To: <20200722044028.4059-1-thuth@redhat.com>
References: <20200722044028.4059-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:34:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-s390x@nongnu.org,
 =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The libudev-related code is independent from the other pci-related code
and can be re-used for non-pci devices (like ccw devices on s390x). Thus
move this part to the generic function.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1755075
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qga/commands-posix.c | 62 +++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 1a42ec8171..e8467ac567 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -874,10 +874,6 @@ static bool build_guest_fsinfo_for_pci_dev(char const *syspath,
     GuestPCIAddress *pciaddr = disk->pci_controller;
     bool has_ata = false, has_host = false, has_tgt = false;
     char *p, *q, *driver = NULL;
-#ifdef CONFIG_LIBUDEV
-    struct udev *udev = NULL;
-    struct udev_device *udevice = NULL;
-#endif
     bool ret = false;
 
     p = strstr(syspath, "/devices/pci");
@@ -936,26 +932,6 @@ static bool build_guest_fsinfo_for_pci_dev(char const *syspath,
     pciaddr->slot = pci[2];
     pciaddr->function = pci[3];
 
-#ifdef CONFIG_LIBUDEV
-    udev = udev_new();
-    udevice = udev_device_new_from_syspath(udev, syspath);
-    if (udev == NULL || udevice == NULL) {
-        g_debug("failed to query udev");
-    } else {
-        const char *devnode, *serial;
-        devnode = udev_device_get_devnode(udevice);
-        if (devnode != NULL) {
-            disk->dev = g_strdup(devnode);
-            disk->has_dev = true;
-        }
-        serial = udev_device_get_property_value(udevice, "ID_SERIAL");
-        if (serial != NULL && *serial != 0) {
-            disk->serial = g_strdup(serial);
-            disk->has_serial = true;
-        }
-    }
-#endif
-
     if (strcmp(driver, "ata_piix") == 0) {
         /* a host per ide bus, target*:0:<unit>:0 */
         if (!has_host || !has_tgt) {
@@ -1017,10 +993,6 @@ static bool build_guest_fsinfo_for_pci_dev(char const *syspath,
 
 cleanup:
     g_free(driver);
-#ifdef CONFIG_LIBUDEV
-    udev_unref(udev);
-    udev_device_unref(udevice);
-#endif
     return ret;
 }
 
@@ -1033,18 +1005,50 @@ static void build_guest_fsinfo_for_real_device(char const *syspath,
     GuestPCIAddress *pciaddr;
     GuestDiskAddressList *list = NULL;
     bool has_hwinf;
+#ifdef CONFIG_LIBUDEV
+    struct udev *udev = NULL;
+    struct udev_device *udevice = NULL;
+#endif
 
     pciaddr = g_new0(GuestPCIAddress, 1);
+    pciaddr->domain = -1;                       /* -1 means field is invalid */
+    pciaddr->bus = -1;
+    pciaddr->slot = -1;
+    pciaddr->function = -1;
 
     disk = g_new0(GuestDiskAddress, 1);
     disk->pci_controller = pciaddr;
+    disk->bus_type = GUEST_DISK_BUS_TYPE_UNKNOWN;
 
     list = g_new0(GuestDiskAddressList, 1);
     list->value = disk;
 
+#ifdef CONFIG_LIBUDEV
+    udev = udev_new();
+    udevice = udev_device_new_from_syspath(udev, syspath);
+    if (udev == NULL || udevice == NULL) {
+        g_debug("failed to query udev");
+    } else {
+        const char *devnode, *serial;
+        devnode = udev_device_get_devnode(udevice);
+        if (devnode != NULL) {
+            disk->dev = g_strdup(devnode);
+            disk->has_dev = true;
+        }
+        serial = udev_device_get_property_value(udevice, "ID_SERIAL");
+        if (serial != NULL && *serial != 0) {
+            disk->serial = g_strdup(serial);
+            disk->has_serial = true;
+        }
+    }
+
+    udev_unref(udev);
+    udev_device_unref(udevice);
+#endif
+
     has_hwinf = build_guest_fsinfo_for_pci_dev(syspath, disk, errp);
 
-    if (has_hwinf) {
+    if (has_hwinf || disk->has_dev || disk->has_serial) {
         list->next = fs->disk;
         fs->disk = list;
     } else {
-- 
2.18.1


