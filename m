Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8A4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:02:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F04F522D02
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RR39U2Jh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04F522D02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3e11-0007HV-3s
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3dXc-00055n-6T
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:54:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53900
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3dXa-0000MU-9M
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596711268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=bAZhh42ol/yyjGGnHpznrtYUmEZhMmtP36AnH46cN78=;
 b=RR39U2JhGTKLLm+UDViW8bWtHo9TJh8rMrBYcFKHkfkPazZchoUVanbkAkcBdyYvrFOLsC
 EIka2O/UQPLuGRhvXdVQddpR9/Bco7hGrdaT3zcE8Ulfc9zyD/s/1482ivSp90yuCbKx/D
 OBMMfuRXupmm9NFClJEcmX/b0fqJwZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-ucGPa8TJOeqYo6WVJHAY5Q-1; Thu, 06 Aug 2020 06:54:24 -0400
X-MC-Unique: ucGPa8TJOeqYo6WVJHAY5Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35CFF8017FB;
 Thu,  6 Aug 2020 10:54:23 +0000 (UTC)
Received: from thuth.com (ovpn-112-229.ams2.redhat.com [10.36.112.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BE165F202;
 Thu,  6 Aug 2020 10:54:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-5.2 v2 6/9] pc-bios/s390-ccw: Scan through all devices if
 no boot device specified
Date: Thu,  6 Aug 2020 12:53:46 +0200
Message-Id: <20200806105349.632-7-thuth@redhat.com>
In-Reply-To: <20200806105349.632-1-thuth@redhat.com>
References: <20200806105349.632-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:07:42
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, qemu-block@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>,
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
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
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
2.18.1


