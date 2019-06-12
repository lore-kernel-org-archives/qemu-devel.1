Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FC6C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 12:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A21208C2
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 12:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r8Q4MrAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A21208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59754 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb28b-0004BB-CQ
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 08:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47013)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hb24l-0001ig-Bj
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:10:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hb1w4-00056F-Fh
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:01:03 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40604)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hb1vm-0004S4-4N; Wed, 12 Jun 2019 08:00:44 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CBsGRX115391;
 Wed, 12 Jun 2019 12:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=hQZ3WEyRXWZ6Vma864cBiiSbs9o8TGD6e7LS+aGjIko=;
 b=r8Q4MrAcugxiQvrIk0ls6MilOzcArq0I5RmrvQKufDOWZZoutu0klW3cYtDTRzoFFas0
 YwuTvB/YqkWWCXfcgbogFoiH3Gv8h3PaxaybCGaQYzeDbrPj7rmUfbsTYSsFkfQO2d7k
 CEMepVr+jAnjNU9hV0NKumhVg0PWTV6654zR2hraEPmdhzIEVuHv5j2vKZAhMrtFLpSS
 h5dxLrs/X8D8wBd7lmWjHp4/kt7qhYiMbycDy8hr8Fq4yeWjITWO0P+2RfrYTIjIH5I5
 IIzQyThjtDzqHZ7+ymrGkWNqIXNgQFdBTdCY2UNMatbawmABmF6PTw4fAc9bUrdxtAqj 3Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2130.oracle.com with ESMTP id 2t02heu1h6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jun 2019 12:00:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CBwo6v075256;
 Wed, 12 Jun 2019 12:00:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2t1jphytx4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jun 2019 12:00:20 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5CC0JYj020843;
 Wed, 12 Jun 2019 12:00:19 GMT
Received: from nexus.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 12 Jun 2019 05:00:18 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, seabios@seabios.org, kraxel@redhat.com,
 kevin@koconnor.net
Date: Wed, 12 Jun 2019 14:59:38 +0300
Message-Id: <20190612115939.23825-8-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20190612115939.23825-1-shmuel.eiderman@oracle.com>
References: <20190612115939.23825-1-shmuel.eiderman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906120083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906120083
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.79
Subject: [Qemu-devel] [QEMU] [PATCH v2 7/8] bootdevice: FW_CFG interface for
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
The fw_cfg entry is "bootdevices" and it serializes a struct.
At the moment the struct holds the values of logical CHS values but it
can be expanded easily due to the extendable ABI implemented.

(In the future, we can pass the bootindex through "bootdevices" instead
"bootorder" - unifying all bootdevice information in one fw_cfg value)

The PV interface through fw_cfg could have also been implemented using
device specific keys, e.g.: "/etc/bootdevice/%s/logical_geometry" where
%s is the device name QEMU produces - but this implementation would
require much more code refactoring, both in QEMU and SeaBIOS, so the
current implementation was chosen.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 bootdevice.c            | 42 ++++++++++++++++++++++++++++++++++++++++++
 hw/nvram/fw_cfg.c       | 14 +++++++++++---
 include/sysemu/sysemu.h |  1 +
 3 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/bootdevice.c b/bootdevice.c
index 2b12fb85a4..84c2a83f25 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -405,3 +405,45 @@ void del_boot_device_lchs(DeviceState *dev, const char *suffix)
         }
     }
 }
+
+typedef struct QEMU_PACKED BootDeviceEntrySerialized {
+    /* Do not change field order - add new fields below */
+    uint32_t lcyls;
+    uint32_t lheads;
+    uint32_t lsecs;
+} BootDeviceEntrySerialized;
+
+/* Serialized as: struct size (4) + (device name\0 + device struct) x devices */
+char *get_boot_devices_info(size_t *size)
+{
+    FWLCHSEntry *i;
+    BootDeviceEntrySerialized s;
+    size_t total = 0;
+    char *list = NULL;
+
+    list = g_malloc0(sizeof(uint32_t));
+    *((uint32_t *)list) = (uint32_t)sizeof(s);
+    total = sizeof(uint32_t);
+
+    QTAILQ_FOREACH(i, &fw_lchs, link) {
+        char *bootpath;
+        size_t len;
+
+        bootpath = get_boot_device_path(i->dev, false, i->suffix);
+        s.lcyls = i->lcyls;
+        s.lheads = i->lheads;
+        s.lsecs = i->lsecs;
+
+        len = strlen(bootpath) + 1;
+        list = g_realloc(list, total + len + sizeof(s));
+        memcpy(&list[total], bootpath, len);
+        memcpy(&list[total + len], &s, sizeof(s));
+        total += len + sizeof(s);
+
+        g_free(bootpath);
+    }
+
+    *size = total;
+
+    return list;
+}
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 9f7b7789bc..008b21542f 100644
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
+        buf = get_boot_devices_info(&len);
+        ptr = fw_cfg_modify_file(s, "bootdevices", (uint8_t *)buf, len);
+        g_free(ptr);
+    }
 }
 
 static void fw_cfg_machine_ready(struct Notifier *n, void *data)
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 173dfbb539..f0552006f4 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -174,6 +174,7 @@ void validate_bootdevices(const char *devices, Error **errp);
 void add_boot_device_lchs(DeviceState *dev, const char *suffix,
                           uint32_t lcyls, uint32_t lheads, uint32_t lsecs);
 void del_boot_device_lchs(DeviceState *dev, const char *suffix);
+char *get_boot_devices_info(size_t *size);
 
 /* handler to set the boot_device order for a specific type of MachineClass */
 typedef void QEMUBootSetHandler(void *opaque, const char *boot_order,
-- 
2.13.3


