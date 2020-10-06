Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA2AC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 18:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FCC020789
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 18:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0ktQrIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FCC020789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPrpV-0008SN-Pi
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 14:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kPrkr-000371-0z
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 14:32:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kPrke-0006QR-Qd
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 14:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602009112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=oXmN++jhEaNJnngbfUargtNjzn1XA9jM2TKvsuKwQJg=;
 b=A0ktQrIlQvUxVmTX+DgR9Gk9bLzjvuZOwmXy8LZELRWSMd1QS/Tm8e8U9t+Vl9m/UI37Ps
 8oNrG/LIEXVSZe91PBp5+mEl8pTHqIt7cGrTn2DgLX0HJiOtGlMblsIzNm0qx8YukKOTTE
 7ppngBT4B//B4O7YBV5qQwfxYsGAnPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-ShqeSJNKP-WNZn3EGFzxvA-1; Tue, 06 Oct 2020 14:31:48 -0400
X-MC-Unique: ShqeSJNKP-WNZn3EGFzxvA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43C1210BBEC4;
 Tue,  6 Oct 2020 18:31:46 +0000 (UTC)
Received: from thuth.com (ovpn-113-60.ams2.redhat.com [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 24A7A6EF46;
 Tue,  6 Oct 2020 18:31:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 06/16] pc-bios/s390-ccw: Scan through all devices if no boot
 device specified
Date: Tue,  6 Oct 2020 20:31:12 +0200
Message-Id: <20201006183122.155609-7-thuth@redhat.com>
In-Reply-To: <20201006183122.155609-1-thuth@redhat.com>
References: <20201006183122.155609-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Marc Hartmayer <mhartmay@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>
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
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200806105349.632-7-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/main.c | 46 +++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 7bdd12ab2e..9b581074a1 100644
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
@@ -261,14 +249,42 @@ static void ipl_boot_device(void)
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
+            ret = is_dev_possibly_bootable(-1, sch_no);
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
2.18.2


