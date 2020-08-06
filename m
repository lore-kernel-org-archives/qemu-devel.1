Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF10C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:24:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A116722CF6
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+wfnzsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A116722CF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3e4Y-0007H2-8c
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3dXf-0005Cq-35
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:54:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35411
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3dXd-0000Mo-3O
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596711272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=4BmZ5R/B5KF+JC5CuMlI6vsCTV8fruRdJKUwCMQH7+E=;
 b=B+wfnzsCOSErMyryXzLfOc/Kqi4/G7uNdrjMOuTbkcKHOx0KgjZ7P3qJoJl7tPRfX5M9xD
 ooiXA1orsOzS8HDEhwQ9xLK4hgkgUqSGIZRBXk2pd2jJLMb1CykSDPZDsghPwhHBErKtzb
 gQ7sUeFcXm6piCxj5VxVnJfIfTnPF/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-XBrdwAbkP4CYIxmaq3YqZA-1; Thu, 06 Aug 2020 06:54:28 -0400
X-MC-Unique: XBrdwAbkP4CYIxmaq3YqZA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 419F4100AA23;
 Thu,  6 Aug 2020 10:54:27 +0000 (UTC)
Received: from thuth.com (ovpn-112-229.ams2.redhat.com [10.36.112.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A8BA65C82;
 Thu,  6 Aug 2020 10:54:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-5.2 v2 7/9] pc-bios/s390-ccw: Allow booting in case the
 first virtio-blk disk is bad
Date: Thu,  6 Aug 2020 12:53:47 +0200
Message-Id: <20200806105349.632-8-thuth@redhat.com>
In-Reply-To: <20200806105349.632-1-thuth@redhat.com>
References: <20200806105349.632-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 03:10:56
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
 Janosch Frank <frankja@linux.ibm.com>, qemu-block@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If you try to boot with two virtio-blk disks (without bootindex), and
only the second one is bootable, the s390-ccw bios currently stops at
the first disk and does not continue booting from the second one. This
is annoying - and all other major QEMU firmwares succeed to boot from
the second disk in this case, so we should do the same in the s390-ccw
bios, too.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/bootmap.c | 34 +++++++++++++++++++++++-----------
 pc-bios/s390-ccw/main.c    |  2 +-
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 97205674e5..0ef6b851f3 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -289,11 +289,18 @@ static void ipl_eckd_cdl(void)
     read_block(1, ipl2, "Cannot read IPL2 record at block 1");
 
     mbr = &ipl2->mbr;
-    IPL_assert(magic_match(mbr, ZIPL_MAGIC), "No zIPL section in IPL2 record.");
-    IPL_assert(block_size_ok(mbr->blockptr.xeckd.bptr.size),
-               "Bad block size in zIPL section of IPL2 record.");
-    IPL_assert(mbr->dev_type == DEV_TYPE_ECKD,
-               "Non-ECKD device type in zIPL section of IPL2 record.");
+    if (!magic_match(mbr, ZIPL_MAGIC)) {
+        sclp_print("No zIPL section in IPL2 record.\n");
+        return;
+    }
+    if (!block_size_ok(mbr->blockptr.xeckd.bptr.size)) {
+        sclp_print("Bad block size in zIPL section of IPL2 record.\n");
+        return;
+    }
+    if (!mbr->dev_type == DEV_TYPE_ECKD) {
+        sclp_print("Non-ECKD device type in zIPL section of IPL2 record.\n");
+        return;
+    }
 
     /* save pointer to Boot Map Table */
     bmt_block_nr = eckd_block_num(&mbr->blockptr.xeckd.bptr.chs);
@@ -303,10 +310,14 @@ static void ipl_eckd_cdl(void)
 
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
     read_block(2, vlbl, "Cannot read Volume Label at block 2");
-    IPL_assert(magic_match(vlbl->key, VOL1_MAGIC),
-               "Invalid magic of volume label block");
-    IPL_assert(magic_match(vlbl->f.key, VOL1_MAGIC),
-               "Invalid magic of volser block");
+    if (!magic_match(vlbl->key, VOL1_MAGIC)) {
+        sclp_print("Invalid magic of volume label block.\n");
+        return;
+    }
+    if (!magic_match(vlbl->f.key, VOL1_MAGIC)) {
+        sclp_print("Invalid magic of volser block.\n");
+        return;
+    }
     print_volser(vlbl->f.volser);
 
     run_eckd_boot_script(bmt_block_nr, s1b_block_nr);
@@ -398,7 +409,8 @@ static void ipl_eckd(void)
     read_block(0, mbr, "Cannot read block 0 on DASD");
 
     if (magic_match(mbr->magic, IPL1_MAGIC)) {
-        ipl_eckd_cdl(); /* no return */
+        ipl_eckd_cdl();         /* only returns in case of error */
+        return;
     }
 
     /* LDL/CMS? */
@@ -825,5 +837,5 @@ void zipl_load(void)
         panic("\n! Unknown IPL device type !\n");
     }
 
-    panic("\n* this can never happen *\n");
+    sclp_print("zIPL load failed.\n");
 }
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 9b581074a1..fc17e6ab83 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -240,7 +240,7 @@ static void ipl_boot_device(void)
         break;
     case CU_TYPE_VIRTIO:
         if (virtio_setup() == 0) {
-            zipl_load(); /* no return */
+            zipl_load();             /* Only returns in case of errors */
         }
         break;
     default:
-- 
2.18.1


