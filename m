Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942D9C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:45:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 630C02084A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5KtH9wEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630C02084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48686 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hctpM-0007NV-Qz
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 11:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55502)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hctBu-0006z5-1T
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:05:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hctBs-0005m6-In
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:05:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60314)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hctBo-0005hd-BA; Mon, 17 Jun 2019 11:04:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HF3q3r194628;
 Mon, 17 Jun 2019 15:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=rAPFvo3TNh5U/Xbn1sV4X1q87mCQdqTAha1Iln3MVZE=;
 b=5KtH9wECidH54QUP7zq6X3ZtnKRr4LaD4b1XVCeJMMFZn9yXywLqrwZiN0SCfIJa4Cy8
 hEZJq/lctZ/AVmI8o+oCWKfQYKWJMPfRkBjD5V4IescXc14E5xd/fKPlAwqlcR4DfPH1
 fbHP3dwGQrBDt0MIgiACxsr3Q5LaZJZWZN6dINmy3GpHuqevaa2L7km0kYNXU5rL1+kq
 4Ew90px/hAC5uQ3CpVMIbjM6oulHeZKlJfUboe/CqpA8qsC8RsqOyZui988gOuXEypGN
 eeVAq5hcSBB8z8bYxHbg3ewYDCtQG3eBOFr9+nN1KX86I3uOzF9iOm5pC19dxjgh8cRM 6w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2t4r3tf5x6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 15:04:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HF3RSM191625;
 Mon, 17 Jun 2019 15:04:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2t5cpdgape-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 15:04:53 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5HF4qT9017448;
 Mon, 17 Jun 2019 15:04:52 GMT
Received: from nexus.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 08:04:52 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, seabios@seabios.org, kraxel@redhat.com,
 kevin@koconnor.net
Date: Mon, 17 Jun 2019 18:04:17 +0300
Message-Id: <20190617150419.4953-4-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20190617150419.4953-1-shmuel.eiderman@oracle.com>
References: <20190617150419.4953-1-shmuel.eiderman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170136
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [SeaBIOS] [PATCH v2 3/5] geometry: Add
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
 src/boot.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/util.h |  6 ++++++
 2 files changed, 69 insertions(+)

diff --git a/src/boot.c b/src/boot.c
index 78d2c530..8162cb74 100644
--- a/src/boot.c
+++ b/src/boot.c
@@ -149,6 +149,69 @@ loadBiosGeometry(void)
     }
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


