Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06740C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D90A208C4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EVwK40y6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D90A208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48822 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcu4w-0003ai-BS
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 12:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55503)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hctBu-0006z6-0o
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:05:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hctBs-0005lW-Fr
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:05:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hctBl-0005eC-0p; Mon, 17 Jun 2019 11:04:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HF45Fn111760;
 Mon, 17 Jun 2019 15:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=yc3jLPPS6khxTDdaK2Cccm/Exx2cYQyZMLHqmbcxjTU=;
 b=EVwK40y65rF9wZWMzxz16GkADI6AuiwxGr7j24spDF/kKmzMxGxDemkEPRMILVnMYKv7
 kZ1A8a+DRugvrowVdAdvxlJrbndL5o9jOJB7HsG4XfjeUEidW5v2xyDxjHBhaAOq2w3F
 uNnntMkhJzQaHz36tj9f2hh0S5bVZQ9qCO5LxptueS0L186o+q//NCqDsFScnSinlzCY
 H2w4lC59scP81dQzyQ0dWp+3RwB2dLPPE9vyM08ESoFU+3yHIsCom4dDm7/nrgsG3AOh
 WLqOb15ifR9bqewfaJM0cr4cFsP7cAD0acJm25qrZGjTp61ymoGdlDBIj8VKnnUmO4t2 vg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2t4rmny3h8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 15:04:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HF3Xso121917;
 Mon, 17 Jun 2019 15:04:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2t5h5t6aqt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 15:04:48 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5HF4kQi022266;
 Mon, 17 Jun 2019 15:04:46 GMT
Received: from nexus.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 08:04:46 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, seabios@seabios.org, kraxel@redhat.com,
 kevin@koconnor.net
Date: Mon, 17 Jun 2019 18:04:15 +0300
Message-Id: <20190617150419.4953-2-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20190617150419.4953-1-shmuel.eiderman@oracle.com>
References: <20190617150419.4953-1-shmuel.eiderman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170136
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [SeaBIOS] [PATCH v2 1/5] geometry: Read LCHS from
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
    * device path (sz string)
    * device lchs
    ...
    * device path (sz string)
    * device lchs

Device path is a null terminated string in the "Open Firmware" device
path format, the same path as used in bootorder.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 src/boot.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/src/boot.c b/src/boot.c
index 5acf94fe..b4382041 100644
--- a/src/boot.c
+++ b/src/boot.c
@@ -24,6 +24,84 @@
 
 
 /****************************************************************
+ * Boot device logical geometry
+ ****************************************************************/
+
+typedef struct BootDeviceLCHSSerialized {
+    u32 lcyls;
+    u32 lheads;
+    u32 lsecs;
+} PACKED BootDeviceLCHSSerialized;
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
+static void
+loadBiosGeometry(void)
+{
+    BiosGeometryCount = 0;
+    int fsize;
+    char *f = romfile_loadfile("bios-geometry", &fsize);
+    if (!f)
+        return;
+
+    u32 struct_size = sizeof(BootDeviceLCHSSerialized);
+
+    int i;
+    int str_found = 0;
+
+    for (i = 0; i < fsize; i++) {
+        if (f[i] != '\0')
+            str_found = 1;
+        else if (f[i] == '\0' && str_found) {
+            str_found = 0;
+            i++;
+            if (i + struct_size > fsize)
+                break;
+            i += struct_size - 1;
+            BiosGeometryCount++;
+        } else
+            break;
+    }
+
+    BiosGeometry = malloc_tmphigh(BiosGeometryCount * sizeof(BootDeviceLCHS));
+    if (!BiosGeometry) {
+        warn_noalloc();
+        free(f);
+        BiosGeometryCount = 0;
+        return;
+    }
+
+    dprintf(1, "bios geometry:\n");
+
+    BootDeviceLCHSSerialized *blk;
+    BootDeviceLCHS *d;
+
+    for (i = 0; i < BiosGeometryCount; i++) {
+        d = &BiosGeometry[i];
+        d->name = f;
+        f += strlen(f) + 1;
+
+        blk = (BootDeviceLCHSSerialized *)f;
+        d->lcyls = blk->lcyls;
+        d->lheads = blk->lheads;
+        d->lsecs = blk->lsecs;
+        f += struct_size;
+
+        dprintf(1, "%s: (%u, %u, %u)\n",
+                d->name, d->lcyls, d->lheads, d->lsecs);
+    }
+}
+
+
+/****************************************************************
  * Boot priority ordering
  ****************************************************************/
 
@@ -288,6 +366,7 @@ boot_init(void)
     BootRetryTime = romfile_loadint("etc/boot-fail-wait", 60*1000);
 
     loadBootOrder();
+    loadBiosGeometry();
 }
 
 
-- 
2.13.3


