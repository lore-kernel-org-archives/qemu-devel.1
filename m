Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5061C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 18:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926A220786
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 18:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EC7o9P2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926A220786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0UXb-0004Zl-Qe
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 14:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k0UUb-0008K3-Gs
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 14:38:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46926
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k0UUY-0005U4-AW
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 14:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595961501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=QtQk+14B6MDHKRJIdVfVT1eCD7Su5ogPrM8ZDLbPp7Q=;
 b=EC7o9P2OpfMvStdRMkzwQQ3LdCK1tla6jgjKdxuu5mItEamyF99HwRXZ2yo3ydoI0uSmc4
 1bEcBKkKQ9J6uSARNSyu1K6sjOrp615bQemDNF2mmHhHtyY52k6wQEITyfN9XnwYDQNf4f
 YsQOEiO80xGrLhv/KFFwW6+D6kDYrXc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-qCA8Z-MsO8udX1zSIxEVGQ-1; Tue, 28 Jul 2020 14:38:19 -0400
X-MC-Unique: qCA8Z-MsO8udX1zSIxEVGQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B14B79EC0;
 Tue, 28 Jul 2020 18:38:18 +0000 (UTC)
Received: from thuth.com (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9865460BF4;
 Tue, 28 Jul 2020 18:38:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-5.2 5/6] pc-bios/s390-ccw: Scan through all boot devices
 if none has been specified
Date: Tue, 28 Jul 2020 20:37:33 +0200
Message-Id: <20200728183734.7838-6-thuth@redhat.com>
In-Reply-To: <20200728183734.7838-1-thuth@redhat.com>
References: <20200728183734.7838-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:28:27
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Collin Walling <walling@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If no boot device has been specified (via "bootindex=..."), the s390-ccw
bios scans through all devices to find a bootable device. But so far, it
stops at the very first block device (including virtio-scsi controllers
without attached devices) that it finds, no matter whether it is bootable
or not. That leads to some weird situatation where it is e.g. possible
to boot via:

 qemu-system-s390x -hda /path/to/disk.qcow2

but not if there is e.g. a virtio-scsi controller specified before:

 qemu-system-s390x -device virtio-scsi -hda /path/to/disk.qcow2

While using "bootindex=..." is clearly the preferred way of booting
on s390x, we still can make the life for the users at least a little
bit easier if we look at all available devices to find a bootable one.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1846975
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/main.c | 46 +++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 3cd01cd80f..0af872f9e3 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -182,20 +182,8 @@ static void boot_setup(void)
 static void find_boot_device(void)
 {
     VDev *vdev = virtio_get_device();
-    int ssid;
     bool found;
 
-    if (!have_iplb) {
-        for (ssid = 0; ssid < 0x3; ssid++) {
-            blk_schid.ssid = ssid;
-            found = find_subch(-1);
-            if (found) {
-                return;
-            }
-        }
-        panic("Could not find a suitable boot device (none specified)\n");
-    }
-
     switch (iplb.pbt) {
     case S390_IPL_TYPE_CCW:
         debug_print_int("device no. ", iplb.ccw.devno);
@@ -260,14 +248,42 @@ static void ipl_boot_device(void)
     }
 }
 
+/*
+ * No boot device has been specified, so we have to scan through the
+ * channels to find one.
+ */
+static void probe_boot_device(void)
+{
+    int ssid, sch_no, ret;
+
+    for (ssid = 0; ssid < 0x3; ssid++) {
+        blk_schid.ssid = ssid;
+        for (sch_no = 0; sch_no < 0x10000; sch_no++) {
+            ret = check_sch_no(-1, sch_no);
+            if (ret < 0) {
+                break;
+            }
+            if (ret == true) {
+                ipl_boot_device();      /* Only returns if unsuccessful */
+            }
+        }
+    }
+
+    sclp_print("Could not find a suitable boot device (none specified)\n");
+}
+
 int main(void)
 {
     sclp_setup();
     css_setup();
     boot_setup();
-    find_boot_device();
-    enable_subchannel(blk_schid);
-    ipl_boot_device();
+    if (have_iplb) {
+        find_boot_device();
+        enable_subchannel(blk_schid);
+        ipl_boot_device();
+    } else {
+        probe_boot_device();
+    }
 
     panic("Failed to load OS from hard disk\n");
     return 0; /* make compiler happy */
-- 
2.18.1


