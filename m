Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3A3C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 12:19:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB4F20866
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 12:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="chspXC2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB4F20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59794 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb2Dc-0000TG-J0
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 08:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46888)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hb24l-0001X9-BJ
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:10:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hb1w4-000567-EP
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:01:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43560)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hb1vo-0004Ij-Ut; Wed, 12 Jun 2019 08:00:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CBsId1105911;
 Wed, 12 Jun 2019 12:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=7xrUoYOu+9ElvUB5L88vzyRFGdPo+spBEQlM3TkzjbI=;
 b=chspXC2Auwz4DvqpWreK4EQYgvh3GAYgBCHa1Qb3LJbkSNv3gmfPRkKSXbJNWnsOEOsP
 SbEnQ5MA9S8OLQ8p6Mvm6Dj7xUT1nTtIpT2k1OH++kYFMN5CHWrmx6YKsM2kqVovJhAR
 l/qSXlIABBvBD/6caEhx4YplzM9lZwGE153BNJT5HC5A+JbpY1NWIt706IZJ9kWJTEfU
 MEAzetMHW2meTvbSGyBXphTgtuD+3NdMFdLIMknrRdVDyed5Z/p1tY+LgNOcuRV1qd/7
 CNsMPGdDnP10jdOKx63qRt1SbQZorsPYHN4x1HSgXLFF1QziUH8aqKV2zfyHIC8+KSED wQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2t05nqttp2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jun 2019 12:00:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CC0Ck4003117;
 Wed, 12 Jun 2019 12:00:13 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2t0p9ru1vt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jun 2019 12:00:13 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5CC09r9015790;
 Wed, 12 Jun 2019 12:00:10 GMT
Received: from nexus.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 12 Jun 2019 05:00:09 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, seabios@seabios.org, kraxel@redhat.com,
 kevin@koconnor.net
Date: Wed, 12 Jun 2019 14:59:35 +0300
Message-Id: <20190612115939.23825-5-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20190612115939.23825-1-shmuel.eiderman@oracle.com>
References: <20190612115939.23825-1-shmuel.eiderman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=969
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906120083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906120083
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [QEMU] [PATCH v2 4/8] scsi: Propagate unrealize()
 callback to scsi-hd
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

We will need to add LCHS removal logic to scsi-hd's unrealize() in the
next commit.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 hw/scsi/scsi-bus.c     | 15 +++++++++++++++
 include/hw/scsi/scsi.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index c480553083..f6fe497a1a 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -55,6 +55,14 @@ static void scsi_device_realize(SCSIDevice *s, Error **errp)
     }
 }
 
+static void scsi_device_unrealize(SCSIDevice *s, Error **errp)
+{
+    SCSIDeviceClass *sc = SCSI_DEVICE_GET_CLASS(s);
+    if (sc->unrealize) {
+        sc->unrealize(s, errp);
+    }
+}
+
 int scsi_bus_parse_cdb(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf,
                        void *hba_private)
 {
@@ -213,11 +221,18 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
 static void scsi_qdev_unrealize(DeviceState *qdev, Error **errp)
 {
     SCSIDevice *dev = SCSI_DEVICE(qdev);
+    Error *local_err = NULL;
 
     if (dev->vmsentry) {
         qemu_del_vm_change_state_handler(dev->vmsentry);
     }
 
+    scsi_device_unrealize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     scsi_device_purge_requests(dev, SENSE_CODE(NO_SENSE));
     blockdev_mark_auto_del(dev->conf.blk);
 }
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 426566a5c6..8cf71f910d 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -59,6 +59,7 @@ struct SCSIRequest {
 typedef struct SCSIDeviceClass {
     DeviceClass parent_class;
     void (*realize)(SCSIDevice *dev, Error **errp);
+    void (*unrealize)(SCSIDevice *dev, Error **errp);
     int (*parse_cdb)(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf,
                      void *hba_private);
     SCSIRequest *(*alloc_req)(SCSIDevice *s, uint32_t tag, uint32_t lun,
-- 
2.13.3


