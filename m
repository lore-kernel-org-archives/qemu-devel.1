Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBEAC48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:45:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91D062133F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KBmC0MtM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D062133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg7IX-0007HC-GO
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 08:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56090)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hg7Cf-0000Rk-7x
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:39:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hg7Cd-0007HU-U6
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:39:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41744)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hg7CO-0006lZ-DK; Wed, 26 Jun 2019 08:38:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QCY7pi193508;
 Wed, 26 Jun 2019 12:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=PG6+5eBzxS2ZYCiKxYtu/H0lFyJx2xVRNgzQO9/BhSw=;
 b=KBmC0MtM3ixSd1efL6S3f3iZPorgsoh+ullMr2TozhkO8l30XkfBK6jNkWZX/0LronS/
 sZEbAXCtEp+vNom/emX0sUYkO9RT6ijR5dWLMz9sq4pqjYBNuO0qDL8K5ttqaGVSKpmL
 xLS/Tq/Qv/9QJX6KfBE4/jFNdKs05+pAhtp3g+g8xZUrk4d/GRVhOfgVYFZXdC49MY1p
 36ZtKd46pCzE+vO3qhLPO3E3vgrWjmDhhkIYot9i5WkQAtQKM/W4tRWgrNsm/2lWF+LM
 9JMexenkN+u6A5+xmfYYUYwmtT/VOnAfeQM4tCUmZN5qmOzqDA6zU0i2GYWzc3Lk29y7 Uw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2t9cyqj0hc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2019 12:38:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QCclgN164723;
 Wed, 26 Jun 2019 12:38:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2t9p6urjx8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2019 12:38:47 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5QCcgLx024043;
 Wed, 26 Jun 2019 12:38:42 GMT
Received: from nexus.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 26 Jun 2019 05:38:41 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, seabios@seabios.org, kraxel@redhat.com,
 kevin@koconnor.net
Date: Wed, 26 Jun 2019 15:38:15 +0300
Message-Id: <20190626123816.8907-5-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20190626123816.8907-1-shmuel.eiderman@oracle.com>
References: <20190626123816.8907-1-shmuel.eiderman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260150
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [SeaBIOS] [PATCH v4 4/5] geometry: Add
 boot_lchs_find_*() utility functions
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
Cc: liran.alon@oracle.com, shmuel.eiderman@oracle.com, karl.heubaum@oracle.com,
 arbel.moshe@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adding the following utility functions:

    * boot_lchs_find_pci_device
    * boot_lchs_find_scsi_device
    * boot_lchs_find_ata_device

These will be used to apply LCHS values received through fw_cfg.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 src/Kconfig |  7 +++++++
 src/boot.c  | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/util.h  |  6 ++++++
 3 files changed, 82 insertions(+)

diff --git a/src/Kconfig b/src/Kconfig
index 55a87cb7..6606ce4d 100644
--- a/src/Kconfig
+++ b/src/Kconfig
@@ -72,6 +72,13 @@ endchoice
         help
             Support controlling of the boot order via the fw_cfg/CBFS
             "bootorder" file.
+    config HOST_BIOS_GEOMETRY
+        depends on BOOT
+        bool "Boot device bios geometry override"
+        default y
+        help
+            Support overriding bios (logical) geometry of boot devices via the
+            fw_cfg/CBFS "bios-geometry" file.
 
     config COREBOOT_FLASH
         depends on COREBOOT
diff --git a/src/boot.c b/src/boot.c
index 52e1c8e6..ea18194d 100644
--- a/src/boot.c
+++ b/src/boot.c
@@ -129,6 +129,8 @@ parse_u32(char *cur, u32 *n)
 static void
 loadBiosGeometry(void)
 {
+    if (!CONFIG_HOST_BIOS_GEOMETRY)
+        return;
     char *f = romfile_loadfile("bios-geometry", NULL);
     if (!f)
         return;
@@ -168,6 +170,73 @@ loadBiosGeometry(void)
     } while (f);
 }
 
+// Search the bios-geometry list for the given glob pattern.
+static BootDeviceLCHS *
+boot_lchs_find(const char *glob)
+{
+    dprintf(1, "Searching bios-geometry for: %s\n", glob);
+    int i;
+    for (i = 0; i < BiosGeometryCount; i++)
+        if (glob_prefix(glob, BiosGeometry[i].name))
+            return &BiosGeometry[i];
+    return NULL;
+}
+
+int boot_lchs_find_pci_device(struct pci_device *pci, struct chs_s *chs)
+{
+    if (!CONFIG_HOST_BIOS_GEOMETRY)
+        return -1;
+    char desc[256];
+    build_pci_path(desc, sizeof(desc), "*", pci);
+    BootDeviceLCHS *b = boot_lchs_find(desc);
+    if (!b)
+        return -1;
+    chs->cylinder = (u16)b->lcyls;
+    chs->head = (u16)b->lheads;
+    chs->sector = (u16)b->lsecs;
+    return 0;
+}
+
+int boot_lchs_find_scsi_device(struct pci_device *pci, int target, int lun,
+                               struct chs_s *chs)
+{
+    if (!CONFIG_HOST_BIOS_GEOMETRY)
+        return -1;
+    if (!pci)
+        // support only pci machine for now
+        return -1;
+    // Find scsi drive - for example: /pci@i0cf8/scsi@5/channel@0/disk@1,0
+    char desc[256];
+    build_scsi_path(desc, sizeof(desc), pci, target, lun);
+    BootDeviceLCHS *b = boot_lchs_find(desc);
+    if (!b)
+        return -1;
+    chs->cylinder = (u16)b->lcyls;
+    chs->head = (u16)b->lheads;
+    chs->sector = (u16)b->lsecs;
+    return 0;
+}
+
+int boot_lchs_find_ata_device(struct pci_device *pci, int chanid, int slave,
+                              struct chs_s *chs)
+{
+    if (!CONFIG_HOST_BIOS_GEOMETRY)
+        return -1;
+    if (!pci)
+        // support only pci machine for now
+        return -1;
+    // Find ata drive - for example: /pci@i0cf8/ide@1,1/drive@1/disk@0
+    char desc[256];
+    build_ata_path(desc, sizeof(desc), pci, chanid, slave);
+    BootDeviceLCHS *b = boot_lchs_find(desc);
+    if (!b)
+        return -1;
+    chs->cylinder = (u16)b->lcyls;
+    chs->head = (u16)b->lheads;
+    chs->sector = (u16)b->lsecs;
+    return 0;
+}
+
 
 /****************************************************************
  * Boot priority ordering
diff --git a/src/util.h b/src/util.h
index e2afc80c..b173fa88 100644
--- a/src/util.h
+++ b/src/util.h
@@ -38,6 +38,12 @@ struct usbdevice_s;
 int bootprio_find_usb(struct usbdevice_s *usbdev, int lun);
 int get_keystroke_full(int msec);
 int get_keystroke(int msec);
+struct chs_s;
+int boot_lchs_find_pci_device(struct pci_device *pci, struct chs_s *chs);
+int boot_lchs_find_scsi_device(struct pci_device *pci, int target, int lun,
+                               struct chs_s *chs);
+int boot_lchs_find_ata_device(struct pci_device *pci, int chanid, int slave,
+                              struct chs_s *chs);
 
 // bootsplash.c
 void enable_vga_console(void);
-- 
2.13.3


