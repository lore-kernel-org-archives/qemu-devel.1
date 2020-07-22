Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD02C433E5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 04:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 855F7208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 04:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvwTI+WZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855F7208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy6aH-0004mA-Ou
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 00:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jy6Yf-0002zr-F7
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 00:40:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24667
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jy6Yc-0002mp-Ik
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 00:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595392841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=5uq+UYEuC6nkUqQ+a/hfRkqBNYdVuBxxPe0O7MvBGpg=;
 b=WvwTI+WZh2c5bCGRABNjZ2UpcOTXzUAX28qfPxmNnd8hFwh3RhzmAwf4CaRAy5xsrZlDr6
 8DcXyN+84Dl0FUWwKqnUvcmaR526Qrc2GIzMEp1IZuQLTdsMYZ4D7x2QKqbE91D+wkWB5e
 ZBlLHg70rhtVElZwB75x2eLVyNalXzA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-KI7fv8rTMiqNpyg6DOuTdw-1; Wed, 22 Jul 2020 00:40:39 -0400
X-MC-Unique: KI7fv8rTMiqNpyg6DOuTdw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E32E618C63C0;
 Wed, 22 Jul 2020 04:40:38 +0000 (UTC)
Received: from thuth.com (ovpn-112-92.ams2.redhat.com [10.36.112.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7461C7268C;
 Wed, 22 Jul 2020 04:40:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Michael Roth <mdroth@linux.vnet.ibm.com>
Subject: [PATCH v2 4/4] qga/commands-posix: Support fsinfo for non-PCI virtio
 devices, too
Date: Wed, 22 Jul 2020 06:40:28 +0200
Message-Id: <20200722044028.4059-5-thuth@redhat.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

QEMU on s390x uses virtio via channel I/O instead of PCI by default.
Add a function to detect and provide information for virtio-scsi and
virtio-block devices here, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qga/commands-posix.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index e8467ac567..744c2b5a5d 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -996,6 +996,39 @@ cleanup:
     return ret;
 }
 
+/*
+ * Store disk device info for non-PCI virtio devices (for example s390x
+ * channel I/O devices). Returns true if information has been stored, or
+ * false for failure.
+ */
+static bool build_guest_fsinfo_for_nonpci_virtio(char const *syspath,
+                                                 GuestDiskAddress *disk,
+                                                 Error **errp)
+{
+    unsigned int tgt[3];
+    char *p;
+
+    if (!strstr(syspath, "/virtio") || !strstr(syspath, "/block")) {
+        g_debug("Unsupported virtio device '%s'", syspath);
+        return false;
+    }
+
+    p = strstr(syspath, "/target");
+    if (p && sscanf(p + 7, "%*u:%*u:%*u/%*u:%u:%u:%u",
+                    &tgt[0], &tgt[1], &tgt[2]) == 3) {
+        /* virtio-scsi: target*:0:<target>:<unit> */
+        disk->bus_type = GUEST_DISK_BUS_TYPE_SCSI;
+        disk->bus = tgt[0];
+        disk->target = tgt[1];
+        disk->unit = tgt[2];
+    } else {
+        /* virtio-blk: 1 disk per 1 device */
+        disk->bus_type = GUEST_DISK_BUS_TYPE_VIRTIO;
+    }
+
+    return true;
+}
+
 /* Store disk device info specified by @sysfs into @fs */
 static void build_guest_fsinfo_for_real_device(char const *syspath,
                                                GuestFilesystemInfo *fs,
@@ -1046,7 +1079,14 @@ static void build_guest_fsinfo_for_real_device(char const *syspath,
     udev_device_unref(udevice);
 #endif
 
-    has_hwinf = build_guest_fsinfo_for_pci_dev(syspath, disk, errp);
+    if (strstr(syspath, "/devices/pci")) {
+        has_hwinf = build_guest_fsinfo_for_pci_dev(syspath, disk, errp);
+    } else if (strstr(syspath, "/virtio")) {
+        has_hwinf = build_guest_fsinfo_for_nonpci_virtio(syspath, disk, errp);
+    } else {
+        g_debug("Unsupported device type for '%s'", syspath);
+        has_hwinf = false;
+    }
 
     if (has_hwinf || disk->has_dev || disk->has_serial) {
         list->next = fs->disk;
-- 
2.18.1


