Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A901C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:38:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27030206EC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KseSJ2vv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27030206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igohy-0004NW-CE
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:38:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1igoUV-0002S3-Cz
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:24:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1igoUT-0002z5-Kt
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:24:43 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55338
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1igoUT-0002xt-H2
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576495481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc; bh=YKCRP/dVpgNfKies76bZ+f07WU5ynnc4Xn7IKRKaXlQ=;
 b=KseSJ2vvlHsyWRWVZfM9RzOfd/c1pemQsBSaZq6SiJHPcwRbBn1tpKowxB3c0fEjFttLCl
 OCfcjsd1yCnM6sOrm2FTHT0YfjDEoklzkSVmrtR60I4xSZIgPL1DNRQajVbpXYIuU6j7jS
 igl8sAyE3PgN94JzT9msaqFXzM03FMQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-VTqgiDmTM0uQp9jbsDB1lg-1; Mon, 16 Dec 2019 06:24:39 -0500
X-MC-Unique: VTqgiDmTM0uQp9jbsDB1lg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAD211800D7B;
 Mon, 16 Dec 2019 11:24:37 +0000 (UTC)
Received: from thuth.com (ovpn-117-164.ams2.redhat.com [10.36.117.164])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8CF619C5B;
 Mon, 16 Dec 2019 11:24:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org,
 Stefan Haberland <sth@linux.ibm.com>
Subject: [RFC QEMU PATCH] pc-bios/s390-ccw: Add zipl-like "BOOT_IMAGE=x" to
 the kernel parameters
Date: Mon, 16 Dec 2019 12:24:32 +0100
Message-Id: <20191216112432.13412-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: linux-s390@vger.kernel.org, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>, psundara@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ZIPL adds a "BOOT_IMAGE=x" to the kernel parameters to indicate which
kernel entry has been chosen during the boot process. Apparently some
Linux tools like "dracut" use this setting, so we should provide this
kernel parameter with the s390-ccw bios, too.

However, it's a little bit tricky to get additional parameters from the
s390-ccw bios into the kernel command line: Since we are running the
ZIPL stage 3 boot loader first (which then finally jumps into the Linux
kernel), we have to adapt to the parameter conventions of ZIPL and put
the argument into ZIPLs "COMMAND_LINE_EXTRA" area. Unfortunately, the
location of this area changed in the course of time (it has been moved
between ZIPL v2.9 and v2.10), so we need to detect the right version of
ZIPL here, too. The only reasonable way that I could figure out was the
start address of the ZIPL stage 3 bootloader which has been changed in
almost the same timeframe - just a little bit earlier, between v2.8 and
v2.9, so if a user is using exactly ZIPL v2.9, they won't see the new
BOOT_IMAGE parameter (but at least the new code in s390-ccw should also
not hurt in this case - the area where we write the parameter to is just
the lowest part of the stack area of ZIPL, which should be unused).

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1782026
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: I've marked the patch as RFC since I'm not quite sure whether
 this is really the right way to address this issue: It's unfortunate
 that we have to mess with different location in ZIPL which might also
 change again in the future. As suggested by Christian on IRC last week,
 maybe it would make more sense to change ZIPL to add this parameter
 already when zipl is installed (i.e. by the Linux userspace "zipl" pro-
 gram), instead of adding it during boot time? Also, the BOOT_IMAGE para-
 meter on s390x is quite different from the BOOT_IMAGE paramter that is
 used on x86 - while s390x only uses one single number here, the x86
 variant (added by grub2, I guess) uses the boot device + full filename
 of the kernel on the boot partition. Should we maybe make the s390x
 variant more conform to x86? If so, I think this really has to be fixed
 in zipl userspace tool, and not in the s390-ccw bios (and zipl stage3
 bootloader).

 pc-bios/s390-ccw/bootmap.c  | 56 +++++++++++++++++++++++++++++++++++--
 pc-bios/s390-ccw/jump2ipl.c |  2 +-
 pc-bios/s390-ccw/s390-ccw.h |  2 ++
 3 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index d13b7cbd15..bc7fa597b4 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -49,6 +49,56 @@ static inline bool is_iso_vd_valid(IsoVolDesc *vd)
            vd->type <= VOL_DESC_TYPE_PARTITION;
 }
 
+/**
+ * The ZIPL boot loader adds a BOOT_IMAGE=x to the kernel parameters
+ * (where x is the number of the selected boot entry). Since some
+ * programs might rely on this parameter, we mimic this behavior here.
+ */
+static void add_boot_image_param(uint64_t start_addr, int index)
+{
+    /* "BOOT_IMAGE=00" in EBCDIC */
+    char bootimg_str[15] = {
+        0xc2, 0xd6, 0xd6, 0xe3, 0x6d, 0xc9, 0xd4, 0xc1, 0xc7, 0xc5, 0x7e,
+        0xf0, 0xf0, 0
+    };
+
+    /* Only do it for Linux images */
+    if (memcmp((char *)LINUX_MAGIC_ADDR, "S390EP", 6) != 0) {
+        return;
+    }
+
+    if (index < 10) {
+        bootimg_str[11] = 0xf0 + index;  /* 0xf0 is '0' in EBCDIC */
+        bootimg_str[12] = 0;
+    } else if (index < 100) {
+        bootimg_str[11] = 0xf0 + index / 10;
+        bootimg_str[12] = 0xf0 + index % 10;
+    } else {
+        /* This should never happen since index should be < MAX_BOOT_ENTRIES */
+        panic("BOOT_IMAGE index too big");
+    }
+
+    /*
+     * Now write the parameter to the COMMAND_LINE_EXTRA area of the zipl
+     * stage3 boot loader that we are going to run. Unfortunately, the
+     * location of this area changed in the course of time, but we can
+     * use the stage3 start address to determine which area we have to
+     * use (unless it is zipl v2.9 - the start address already has changed
+     * there but the area has not been moved yet ... so for this version
+     * we are writing the parameters into the unused stack area instead
+     * and thus the BOOT_PARAM won't show up there)
+     */
+    if ((start_addr & 0x7fffffff) == 0xa050) {
+        *(uint64_t *)0xa020 = true;
+        memcpy((char *)0xa000 - 0x400, bootimg_str, sizeof(bootimg_str));
+    } else if ((start_addr & 0x7fffffff) == 0xa000) {
+        *(uint64_t *)0x9020 = true;
+        memcpy((char *)0xe000, bootimg_str, sizeof(bootimg_str));
+    } else {
+        sclp_print("\nWarning: Unsupported ZIPL stage 3 start address.\n");
+    }
+}
+
 /***********************************************************************
  * IPL an ECKD DASD (CDL or LDL/CMS format)
  */
@@ -480,7 +530,7 @@ static void zipl_load_segment(ComponentEntry *entry)
 }
 
 /* Run a zipl program */
-static void zipl_run(ScsiBlockPtr *pte)
+static void zipl_run(ScsiBlockPtr *pte, int loadparm)
 {
     ComponentHeader *header;
     ComponentEntry *entry;
@@ -515,6 +565,8 @@ static void zipl_run(ScsiBlockPtr *pte)
 
     IPL_assert(entry->component_type == ZIPL_COMP_ENTRY_EXEC, "No EXEC entry");
 
+    add_boot_image_param(entry->load_address, loadparm);
+
     /* should not return */
     jump_to_IPL_code(entry->load_address);
 }
@@ -565,7 +617,7 @@ static void ipl_scsi(void)
     IPL_assert(loadparm < MAX_BOOT_ENTRIES, "loadparm value greater than"
                " maximum number of boot entries allowed");
 
-    zipl_run(&prog_table->entry[loadparm].scsi); /* no return */
+    zipl_run(&prog_table->entry[loadparm].scsi, loadparm); /* no return */
 }
 
 /***********************************************************************
diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
index 266f1502b9..36090631f9 100644
--- a/pc-bios/s390-ccw/jump2ipl.c
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -77,7 +77,7 @@ void jump_to_low_kernel(void)
      * kernel start address (when jumping to the PSW-at-zero address instead,
      * the kernel startup code fails when we booted from a network device).
      */
-    if (!memcmp((char *)0x10008, "S390EP", 6)) {
+    if (!memcmp((char *)LINUX_MAGIC_ADDR, "S390EP", 6)) {
         jump_to_IPL_code(KERN_IMAGE_START);
     }
 
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 11bce7d73c..3e23c3c400 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -46,6 +46,8 @@ typedef unsigned long long __u64;
 
 #define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
 
+#define LINUX_MAGIC_ADDR  0x010008UL
+
 #include "cio.h"
 #include "iplb.h"
 
-- 
2.18.1


