Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A5BC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F6A22133F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="piHR5uJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6A22133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg7Gu-0005w3-C7
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 08:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55920)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hg7CG-0000IL-Hb
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hg7CE-0006Wd-Va
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:38:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40978)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hg7C9-0006K0-7E; Wed, 26 Jun 2019 08:38:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QCY6sD104975;
 Wed, 26 Jun 2019 12:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=XYssG+J/294GjGfqMpD5KUXLrc6cguktTtRRpAjXxbY=;
 b=piHR5uJZmBldCwFMO6F55QQ6QnFtCBjeyGBAhMOMlejSm3U4GQd0NBxKgalxDFbWUNrV
 3AnkysuQIcFwX3GxtsRthAaB5CO4iPdn+LdvDUpKss8eD/9H9cIlX4gx5bAtth83oP5V
 Xa+7HPyEgLr8qAPgG/Q4AqV0GdrRT47LInHEMpkuVVYCAUq6gqHp1NGh8bOavSZmiFa+
 zZd5v1NmzMzbIh1NKRHhHryUW8vJy++r2KOiaY+Ogv2enbLorIik+4LLLYGr5qE+aZ67
 MDNnOpG8SkGlncvDvumTAhaM7OI684mFg85y3fs7NUvybtB+WneKvDlP5bL2j598lmAO YQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2t9c9pt2c3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2019 12:38:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QCbRwx021575;
 Wed, 26 Jun 2019 12:38:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2tat7ct4vj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2019 12:38:33 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5QCcWAP000685;
 Wed, 26 Jun 2019 12:38:32 GMT
Received: from nexus.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 26 Jun 2019 05:38:32 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, seabios@seabios.org, kraxel@redhat.com,
 kevin@koconnor.net
Date: Wed, 26 Jun 2019 15:38:12 +0300
Message-Id: <20190626123816.8907-2-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20190626123816.8907-1-shmuel.eiderman@oracle.com>
References: <20190626123816.8907-1-shmuel.eiderman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260150
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [SeaBIOS] [PATCH v4 1/5] geometry: Read LCHS from
 fw_cfg
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

Read bios geometry for boot devices from fw_cfg.

By receiving LCHS values directly from QEMU through fw_cfg we will be
able to support logical geometries which can not be inferred by SeaBIOS
itself.
(For instance: A 8GB virtio-blk hard drive which was originally created
as an IDE and must report LCHS of */32/63 for its operating system to
function will always break under SeaBIOS since a LARGE/LBA translation
will be used, causing the number of reported logical heads to be > 32.)

The only LCHS paravirtual interface available at the moment is for IDE
disks (rtc_read() in get_translation()) and it's limited to a maximum
of 4 disks (this code existed in SeaBIOS's translation function before
SCSI and VirtIO were even introduced).
This is why we create a new interface which allows passing LCHS
information per hdd.

Boot device information is serialized in the following way:
    * device_path lcyls lheads lsecs\n
    ...
    * device_path lcyls lheads lsecs\0

Device path is a null terminated string in the "Open Firmware" device
path format, the same path as used in bootorder.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 src/boot.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/src/boot.c b/src/boot.c
index 5acf94fe..a2cb167c 100644
--- a/src/boot.c
+++ b/src/boot.c
@@ -24,6 +24,79 @@
 
 
 /****************************************************************
+ * Boot device logical geometry
+ ****************************************************************/
+
+typedef struct BootDeviceLCHS {
+    char *name;
+    u32 lcyls;
+    u32 lheads;
+    u32 lsecs;
+} BootDeviceLCHS;
+
+static BootDeviceLCHS *BiosGeometry VARVERIFY32INIT;
+static int BiosGeometryCount;
+
+static char *
+parse_u32(char *cur, u32 *n)
+{
+    u32 m = 0;
+    if (cur) {
+        while ('0' <= *cur && *cur <= '9') {
+            m = 10 * m + (*cur - '0');
+            cur++;
+        }
+        if (*cur != '\0')
+            cur++;
+    }
+    *n = m;
+    return cur;
+}
+
+static void
+loadBiosGeometry(void)
+{
+    char *f = romfile_loadfile("bios-geometry", NULL);
+    if (!f)
+        return;
+
+    int i = 0;
+    BiosGeometryCount = 1;
+    while (f[i]) {
+        if (f[i] == '\n')
+            BiosGeometryCount++;
+        i++;
+    }
+    BiosGeometry = malloc_tmphigh(BiosGeometryCount * sizeof(BootDeviceLCHS));
+    if (!BiosGeometry) {
+        warn_noalloc();
+        free(f);
+        BiosGeometryCount = 0;
+        return;
+    }
+
+    dprintf(1, "bios geometry:\n");
+    i = 0;
+    do {
+        BootDeviceLCHS *d = &BiosGeometry[i];
+        d->name = f;
+        f = strchr(f, '\n');
+        if (f)
+            *(f++) = '\0';
+        char *chs_values = strchr(d->name, ' ');
+        if (chs_values)
+            *(chs_values++) = '\0';
+        chs_values = parse_u32(chs_values, &d->lcyls);
+        chs_values = parse_u32(chs_values, &d->lheads);
+        chs_values = parse_u32(chs_values, &d->lsecs);
+        dprintf(1, "%s: (%u, %u, %u)\n",
+                d->name, d->lcyls, d->lheads, d->lsecs);
+        i++;
+    } while (f);
+}
+
+
+/****************************************************************
  * Boot priority ordering
  ****************************************************************/
 
@@ -288,6 +361,7 @@ boot_init(void)
     BootRetryTime = romfile_loadint("etc/boot-fail-wait", 60*1000);
 
     loadBootOrder();
+    loadBiosGeometry();
 }
 
 
-- 
2.13.3


