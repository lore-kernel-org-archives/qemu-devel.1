Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F94C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 477DC206BF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y7Q0L2ZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 477DC206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36108 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdWrj-0002Mi-W0
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 05:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35324)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hdWpL-0000Iv-Ht
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hdWpI-0002dw-M9
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:24:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33252)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hdWpE-0002YQ-LE; Wed, 19 Jun 2019 05:24:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J9O95d177653;
 Wed, 19 Jun 2019 09:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=wvpnkC7GQxdexKRwJnYoH+7QRuTfTDL3YzlS5ObIQe0=;
 b=Y7Q0L2ZQgOJ00oeQADy+vkiwoFMjkv3UoC7M6Fg553DSvaeOsTLaNNRf/AV0yFsyiRY/
 rN3qj3NY0Fdu1sqMZER2cpn4TxwNUt15H6MC1AbIeMh6EJUVF971U8J9ahY7jjQF091m
 fUlnNa7OUaCPtdZFIUorsj1jx3C8WidCeQhoDXO39j4xbmiKAZebKd90q9pOzBxWv4J6
 /jATz8+5QBDjmSbH4/CxaYn1qAqIcBvXqmv4xpklkq3pnbgOny6zIAzMW9ICWcByInT4
 zWI5e5WaFzfdTTzQvbOVxv3kfS8i3fu5eb0gaEPERp2pS2476vkHr3jywSU6VxpWVtus Xw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2t7809a8xk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 09:24:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J9NbXv182190;
 Wed, 19 Jun 2019 09:24:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2t77ymyrbd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 09:24:14 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5J9ODcg023988;
 Wed, 19 Jun 2019 09:24:13 GMT
Received: from nexus.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 19 Jun 2019 02:24:13 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, seabios@seabios.org, kraxel@redhat.com,
 kevin@koconnor.net
Date: Wed, 19 Jun 2019 12:23:51 +0300
Message-Id: <20190619092352.23583-4-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20190619092352.23583-1-shmuel.eiderman@oracle.com>
References: <20190619092352.23583-1-shmuel.eiderman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190077
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [SeaBIOS] [PATCH v3 3/4] geometry: Add
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
 src/Kconfig |  7 ++++++
 src/boot.c  | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/util.h  |  6 ++++++
 3 files changed, 84 insertions(+)

diff --git a/src/Kconfig b/src/Kconfig
index 55a87cb7..0b4c1c0d 100644
--- a/src/Kconfig
+++ b/src/Kconfig
@@ -72,6 +72,13 @@ endchoice
         help
             Support controlling of the boot order via the fw_cfg/CBFS
             "bootorder" file.
+    config BIOS_GEOMETRY
+        depends on BOOT
+        bool "Boot device bios geometry override"
+        default y
+        help
+            Support overriding bios (logical) geometry of boot devices via the
+            fw_cfg/CBFS "bios-geometry" file.
 
     config COREBOOT_FLASH
         depends on COREBOOT
diff --git a/src/boot.c b/src/boot.c
index 70f639f4..308d9559 100644
--- a/src/boot.c
+++ b/src/boot.c
@@ -105,6 +105,8 @@ parse_u32(char *cur, u32 *n)
 static void
 loadBiosGeometry(void)
 {
+    if (!CONFIG_BIOS_GEOMETRY)
+        return;
     char *f = romfile_loadfile("bios-geometry", NULL);
     if (!f)
         return;
@@ -144,6 +146,75 @@ loadBiosGeometry(void)
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
+    if (!CONFIG_BIOS_GEOMETRY)
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
+    if (!CONFIG_BIOS_GEOMETRY)
+        return -1;
+    if (!pci)
+        // support only pci machine for now
+        return -1;
+    // Find scsi drive - for example: /pci@i0cf8/scsi@5/channel@0/disk@1,0
+    char desc[256], *p;
+    p = build_pci_path(desc, sizeof(desc), "*", pci);
+    snprintf(p, desc+sizeof(desc)-p, "/*@0/*@%x,%x", target, lun);
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
+    if (!CONFIG_BIOS_GEOMETRY)
+        return -1;
+    if (!pci)
+        // support only pci machine for now
+        return -1;
+    // Find ata drive - for example: /pci@i0cf8/ide@1,1/drive@1/disk@0
+    char desc[256], *p;
+    p = build_pci_path(desc, sizeof(desc), "*", pci);
+    snprintf(p, desc+sizeof(desc)-p, "/drive@%x/disk@%x", chanid, slave);
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


