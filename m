Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B926C433E4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 04:42:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2314A208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 04:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JB2P9KdU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2314A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy6aE-0004f4-6k
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 00:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jy6Yb-0002qW-G0
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 00:40:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50249
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jy6YY-0002lx-U2
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 00:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595392837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=1Yr2eWjUvnZxwwMdpp68vf/1MyEQFAKvoUYB5EwVOS0=;
 b=JB2P9KdUya6L3ndGYG+e5Dy1Ld2rBAGALQY+aRtgrQPwLnV7kTsNtCYyZzlshO88YDKuSJ
 m0EW0WkMdrti0kZ229k5cL+2495w/Zq2/mkSgtPLhb5X0zQsW+lVBIhumQnNJwBWnFy8xA
 fwV/wi/2uqLu86UjeRI/y3AsWiXfLU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-mFvaOCNdO8q_syamjqc2dA-1; Wed, 22 Jul 2020 00:40:36 -0400
X-MC-Unique: mFvaOCNdO8q_syamjqc2dA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B0488005B0;
 Wed, 22 Jul 2020 04:40:35 +0000 (UTC)
Received: from thuth.com (ovpn-112-92.ams2.redhat.com [10.36.112.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C0D9D7268C;
 Wed, 22 Jul 2020 04:40:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Michael Roth <mdroth@linux.vnet.ibm.com>
Subject: [PATCH v2 2/4] qga/commands-posix: Rework
 build_guest_fsinfo_for_real_device() function
Date: Wed, 22 Jul 2020 06:40:26 +0200
Message-Id: <20200722044028.4059-3-thuth@redhat.com>
In-Reply-To: <20200722044028.4059-1-thuth@redhat.com>
References: <20200722044028.4059-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:27:14
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
Cc: qemu-s390x@nongnu.org,
 =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to support non-PCI devices soon. For this we need to split
the generic GuestDiskAddress and GuestDiskAddressList memory allocation
and list chaining into a separate function first.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qga/commands-posix.c | 65 ++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 1a62a3a70d..1a42ec8171 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -861,28 +861,30 @@ static int build_hosts(char const *syspath, char const *host, bool ata,
     return i;
 }
 
-/* Store disk device info specified by @sysfs into @fs */
-static void build_guest_fsinfo_for_real_device(char const *syspath,
-                                               GuestFilesystemInfo *fs,
-                                               Error **errp)
+/*
+ * Store disk device info for devices on the PCI bus.
+ * Returns true if information has been stored, or false for failure.
+ */
+static bool build_guest_fsinfo_for_pci_dev(char const *syspath,
+                                           GuestDiskAddress *disk,
+                                           Error **errp)
 {
     unsigned int pci[4], host, hosts[8], tgt[3];
     int i, nhosts = 0, pcilen;
-    GuestDiskAddress *disk;
-    GuestPCIAddress *pciaddr;
-    GuestDiskAddressList *list = NULL;
+    GuestPCIAddress *pciaddr = disk->pci_controller;
     bool has_ata = false, has_host = false, has_tgt = false;
     char *p, *q, *driver = NULL;
 #ifdef CONFIG_LIBUDEV
     struct udev *udev = NULL;
     struct udev_device *udevice = NULL;
 #endif
+    bool ret = false;
 
     p = strstr(syspath, "/devices/pci");
     if (!p || sscanf(p + 12, "%*x:%*x/%x:%x:%x.%x%n",
                      pci, pci + 1, pci + 2, pci + 3, &pcilen) < 4) {
         g_debug("only pci device is supported: sysfs path '%s'", syspath);
-        return;
+        return false;
     }
 
     p += 12 + pcilen;
@@ -903,7 +905,7 @@ static void build_guest_fsinfo_for_real_device(char const *syspath,
         }
 
         g_debug("unsupported driver or sysfs path '%s'", syspath);
-        return;
+        return false;
     }
 
     p = strstr(syspath, "/target");
@@ -929,18 +931,11 @@ static void build_guest_fsinfo_for_real_device(char const *syspath,
         }
     }
 
-    pciaddr = g_malloc0(sizeof(*pciaddr));
     pciaddr->domain = pci[0];
     pciaddr->bus = pci[1];
     pciaddr->slot = pci[2];
     pciaddr->function = pci[3];
 
-    disk = g_malloc0(sizeof(*disk));
-    disk->pci_controller = pciaddr;
-
-    list = g_malloc0(sizeof(*list));
-    list->value = disk;
-
 #ifdef CONFIG_LIBUDEV
     udev = udev_new();
     udevice = udev_device_new_from_syspath(udev, syspath);
@@ -1018,21 +1013,43 @@ static void build_guest_fsinfo_for_real_device(char const *syspath,
         goto cleanup;
     }
 
-    list->next = fs->disk;
-    fs->disk = list;
-    goto out;
+    ret = true;
 
 cleanup:
-    if (list) {
-        qapi_free_GuestDiskAddressList(list);
-    }
-out:
     g_free(driver);
 #ifdef CONFIG_LIBUDEV
     udev_unref(udev);
     udev_device_unref(udevice);
 #endif
-    return;
+    return ret;
+}
+
+/* Store disk device info specified by @sysfs into @fs */
+static void build_guest_fsinfo_for_real_device(char const *syspath,
+                                               GuestFilesystemInfo *fs,
+                                               Error **errp)
+{
+    GuestDiskAddress *disk;
+    GuestPCIAddress *pciaddr;
+    GuestDiskAddressList *list = NULL;
+    bool has_hwinf;
+
+    pciaddr = g_new0(GuestPCIAddress, 1);
+
+    disk = g_new0(GuestDiskAddress, 1);
+    disk->pci_controller = pciaddr;
+
+    list = g_new0(GuestDiskAddressList, 1);
+    list->value = disk;
+
+    has_hwinf = build_guest_fsinfo_for_pci_dev(syspath, disk, errp);
+
+    if (has_hwinf) {
+        list->next = fs->disk;
+        fs->disk = list;
+    } else {
+        qapi_free_GuestDiskAddressList(list);
+    }
 }
 
 static void build_guest_fsinfo_for_device(char const *devpath,
-- 
2.18.1


