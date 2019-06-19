Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C8BC31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D36B42084A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="exO7pgbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36B42084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36298 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdXDB-0005Dq-1h
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 05:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37418)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hdWv0-0005GU-0V
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:30:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hdWuw-000063-Bw
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:30:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hdWui-0007vm-Vw; Wed, 19 Jun 2019 05:29:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J9SaWp170118;
 Wed, 19 Jun 2019 09:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=noZWG3P3O0MHQDtdNioTi7jsSJK8AoXcSNJCtLLqjkQ=;
 b=exO7pgbwd3IJZSKwYBiBdbvKdQnMp7Mj4XkYsuveBEtrwDM31DJMuJavmxKs8xnhBKQu
 Ad4hSXYBEiOZkJat5rcIpV2Qvdo+IspEj8cxyUcm3DHe2QC+5ThzfRm9UMmAStKFX/+H
 eDUqYpz166mU5B6tJo6DWNaIZJ4T0qaJNGC4jIen1rrgvT27Gt+ZYsOvT2O6ZADJyd7K
 ZRbxjOU+zDC6apu+gnKrWeMSQKw/40zKw7S25oqqrSNqPfDZtvFlDQoZ3o4PgD2vWKE8
 1I72ejNH2wDIm1Oqmv16hxw80T10kbkz4Ze0Yflpe8RIuzdq/eaArJk7Mg3PBf4cSynE Iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2t7809a9sw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 09:29:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J9Tc48001167;
 Wed, 19 Jun 2019 09:29:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2t77ymytxa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 09:29:41 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5J9TePI005148;
 Wed, 19 Jun 2019 09:29:40 GMT
Received: from nexus.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 19 Jun 2019 02:29:40 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, seabios@seabios.org, kraxel@redhat.com,
 kevin@koconnor.net
Date: Wed, 19 Jun 2019 12:29:04 +0300
Message-Id: <20190619092905.24029-8-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20190619092905.24029-1-shmuel.eiderman@oracle.com>
References: <20190619092905.24029-1-shmuel.eiderman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190078
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [QEMU] [PATCH v4 7/8] bootdevice: FW_CFG interface for
 LCHS values
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

Using fw_cfg, supply logical CHS values directly from QEMU to the BIOS.

Non-standard logical geometries break under QEMU.

A virtual disk which contains an operating system which depends on
logical geometries (consistent values being reported from BIOS INT13
AH=08) will most likely break under QEMU/SeaBIOS if it has non-standard
logical geometries - for example 56 SPT (sectors per track).
No matter what QEMU will report - SeaBIOS, for large enough disks - will
use LBA translation, which will report 63 SPT instead.

In addition we cannot force SeaBIOS to rely on physical geometries at
all. A virtio-blk-pci virtual disk with 255 phyiscal heads cannot
report more than 16 physical heads when moved to an IDE controller,
since the ATA spec allows a maximum of 16 heads - this is an artifact of
virtualization.

By supplying the logical geometries directly we are able to support such
"exotic" disks.

We serialize this information in a similar way to the "bootorder"
interface.
The new fw_cfg entry is "bios-geometry".

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 bootdevice.c            | 32 ++++++++++++++++++++++++++++++++
 hw/nvram/fw_cfg.c       | 14 +++++++++++---
 include/sysemu/sysemu.h |  1 +
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/bootdevice.c b/bootdevice.c
index 2b12fb85a4..b034ad7bdc 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -405,3 +405,35 @@ void del_boot_device_lchs(DeviceState *dev, const char *suffix)
         }
     }
 }
+
+/* Serialized as: (device name\0 + lchs struct) x devices */
+char *get_boot_devices_lchs_list(size_t *size)
+{
+    FWLCHSEntry *i;
+    size_t total = 0;
+    char *list = NULL;
+
+    QTAILQ_FOREACH(i, &fw_lchs, link) {
+        char *bootpath;
+        char *chs_string;
+        size_t len;
+
+        bootpath = get_boot_device_path(i->dev, false, i->suffix);
+        chs_string = g_strdup_printf("%s %" PRIu32 " %" PRIu32 " %" PRIu32,
+                                     bootpath, i->lcyls, i->lheads, i->lsecs);
+
+        if (total) {
+            list[total - 1] = '\n';
+        }
+        len = strlen(chs_string) + 1;
+        list = g_realloc(list, total + len);
+        memcpy(&list[total], chs_string, len);
+        total += len;
+        g_free(chs_string);
+        g_free(bootpath);
+    }
+
+    *size = total;
+
+    return list;
+}
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 9f7b7789bc..c1230fe11c 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -916,13 +916,21 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
 
 static void fw_cfg_machine_reset(void *opaque)
 {
+    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+    FWCfgState *s = opaque;
     void *ptr;
     size_t len;
-    FWCfgState *s = opaque;
-    char *bootindex = get_boot_devices_list(&len);
+    char *buf;
 
-    ptr = fw_cfg_modify_file(s, "bootorder", (uint8_t *)bootindex, len);
+    buf = get_boot_devices_list(&len);
+    ptr = fw_cfg_modify_file(s, "bootorder", (uint8_t *)buf, len);
     g_free(ptr);
+
+    if (!mc->legacy_fw_cfg_order) {
+        buf = get_boot_devices_lchs_list(&len);
+        ptr = fw_cfg_modify_file(s, "bios-geometry", (uint8_t *)buf, len);
+        g_free(ptr);
+    }
 }
 
 static void fw_cfg_machine_ready(struct Notifier *n, void *data)
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 173dfbb539..1ca8799588 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -174,6 +174,7 @@ void validate_bootdevices(const char *devices, Error **errp);
 void add_boot_device_lchs(DeviceState *dev, const char *suffix,
                           uint32_t lcyls, uint32_t lheads, uint32_t lsecs);
 void del_boot_device_lchs(DeviceState *dev, const char *suffix);
+char *get_boot_devices_lchs_list(size_t *size);
 
 /* handler to set the boot_device order for a specific type of MachineClass */
 typedef void QEMUBootSetHandler(void *opaque, const char *boot_order,
-- 
2.13.3


