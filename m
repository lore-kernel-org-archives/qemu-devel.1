Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B2EC48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:41:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B192147A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RUE81+su"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B192147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg7Eg-0002AD-0N
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 08:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55952)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hg7CJ-0000M2-1M
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hg7CH-0006cK-VO
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:38:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52306)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hg7CD-0006TV-Qr; Wed, 26 Jun 2019 08:38:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QCYAXj187602;
 Wed, 26 Jun 2019 12:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=unrVc136npZDb5NaLZdO2sOpKQ7GyimxsHu2DkvWsbA=;
 b=RUE81+suKmwwjtIMKzcp24b6VzI1XH1QDTDrHWbXLU2z16MYpJwkc1fGoUN+GB2luf1h
 RzB9ZqtzlyyPFIU24J9Vd8sEFrtdjsEKAS4IjoBpugR6cvH2WSG0Hl6uG8Q9CECrZhlD
 bFS/3NqdDwmkIKZG4PNtYzZzfBakpcIPziBr6aD/zk6UEeivbRFM4swsiO2rK9Dbd2sq
 2DcMkaPcORgABL6Y681KgUaNZh+LIjDyupxZ7l6XzqCCmKxMGDdU26t9IWVU0tnt1V3c
 ccjUqHDc+pxt1v5tXtAvY7UQvoXtiaGVPfcLzLyqBrFEzlunbM/e8RKp7lF2cVUb1bG7 mw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2t9brta44x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2019 12:38:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QCbS3s021700;
 Wed, 26 Jun 2019 12:38:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2tat7ct4wp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2019 12:38:39 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5QCccf3002703;
 Wed, 26 Jun 2019 12:38:38 GMT
Received: from nexus.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 26 Jun 2019 05:38:38 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, seabios@seabios.org, kraxel@redhat.com,
 kevin@koconnor.net
Date: Wed, 26 Jun 2019 15:38:14 +0300
Message-Id: <20190626123816.8907-4-shmuel.eiderman@oracle.com>
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
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [SeaBIOS] [PATCH v4 3/5] boot: Build ata and scsi
 paths in function
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

Introduce build_scsi_path() and build_ata_path().
We will reuse these functions in the next commit.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 src/boot.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/src/boot.c b/src/boot.c
index 70f639f4..52e1c8e6 100644
--- a/src/boot.c
+++ b/src/boot.c
@@ -71,6 +71,30 @@ build_pci_path(char *buf, int max, const char *devname, struct pci_device *pci)
     return p;
 }
 
+static char *
+build_scsi_path(char *buf, int max,
+                struct pci_device *pci, int target, int lun)
+{
+    // Build the string path of a scsi drive - for example:
+    // /pci@i0cf8/scsi@5/channel@0/disk@1,0
+    char *p;
+    p = build_pci_path(buf, max, "*", pci);
+    p += snprintf(p, buf+max-p, "/*@0/*@%x,%x", target, lun);
+    return p;
+}
+
+static char *
+build_ata_path(char *buf, int max,
+               struct pci_device *pci, int chanid, int slave)
+{
+    // Build the string path of an ata drive - for example:
+    // /pci@i0cf8/ide@1,1/drive@1/disk@0
+    char *p;
+    p = build_pci_path(buf, max, "*", pci);
+    p += snprintf(p, buf+max-p, "/drive@%x/disk@%x", chanid, slave);
+    return p;
+}
+
 
 /****************************************************************
  * Boot device logical geometry
@@ -221,10 +245,8 @@ int bootprio_find_scsi_device(struct pci_device *pci, int target, int lun)
     if (!pci)
         // support only pci machine for now
         return -1;
-    // Find scsi drive - for example: /pci@i0cf8/scsi@5/channel@0/disk@1,0
-    char desc[256], *p;
-    p = build_pci_path(desc, sizeof(desc), "*", pci);
-    snprintf(p, desc+sizeof(desc)-p, "/*@0/*@%x,%x", target, lun);
+    char desc[256];
+    build_scsi_path(desc, sizeof(desc), pci, target, lun);
     return find_prio(desc);
 }
 
@@ -237,10 +259,8 @@ int bootprio_find_ata_device(struct pci_device *pci, int chanid, int slave)
     if (!pci)
         // support only pci machine for now
         return -1;
-    // Find ata drive - for example: /pci@i0cf8/ide@1,1/drive@1/disk@0
-    char desc[256], *p;
-    p = build_pci_path(desc, sizeof(desc), "*", pci);
-    snprintf(p, desc+sizeof(desc)-p, "/drive@%x/disk@%x", chanid, slave);
+    char desc[256];
+    build_ata_path(desc, sizeof(desc), pci, chanid, slave);
     return find_prio(desc);
 }
 
-- 
2.13.3


