Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AE6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 19:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24890206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 19:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="pvescH0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24890206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbU2g-00054l-Cd
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 15:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jbTx9-0002cV-Uz
 for qemu-devel@nongnu.org; Wed, 20 May 2020 15:00:31 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3253)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jbTx8-00056l-KJ
 for qemu-devel@nongnu.org; Wed, 20 May 2020 15:00:31 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ec57e400000>; Wed, 20 May 2020 12:00:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 20 May 2020 12:00:29 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 20 May 2020 12:00:29 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 May
 2020 19:00:28 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 20 May 2020 19:00:20 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH QEMU v23 18/18] qapi: Add VFIO devices migration stats in
 Migration stats
Date: Wed, 20 May 2020 23:54:48 +0530
Message-ID: <1589999088-31477-19-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1589999088-31477-1-git-send-email-kwankhede@nvidia.com>
References: <1589999088-31477-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1590001217; bh=QZNXLV8HeQhf5LMcewBL0DYF27IfZPW26XfMXNjFzYI=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=pvescH0wr/x2f6mgBBf2mQIYJM5yVgqaZ1EDryMZ95MPNMUG4ZxOs138Da4HVJSI7
 u05gFnz6FaLE/5WVIIKqpMtEhdsHHKEHMCE7rnaVGXlQHh9oD5rC/owPr20jIWhukB
 QufYBSdMq8era/z3vaODEHBRgbOv3iv5jcpCPjbBH7/sSPIEXXi6yFUmxigKkIdGtM
 2t/sRF7oZIVYLbNbu20QE0nM9fHXZs50FrD/Zha4EXLOidJu4ynzFKwWq5l9ubnTXw
 kIrG0ieW/yw9pMRVXsAPOMFxVePr8lydVp4W6GG9tv+0bv0KUU5cVVHNFrMSa/wdbG
 Swy0HL52INS1g==
Received-SPF: pass client-ip=216.228.121.65; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate26.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 14:41:35
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: cohuck@redhat.com, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, yi.l.liu@intel.com,
 quintela@redhat.com, ziye.yang@intel.com, armbru@redhat.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, felipe@nutanix.com,
 zhi.a.wang@intel.com, kevin.tian@intel.com, yan.y.zhao@intel.com,
 dgilbert@redhat.com, changpeng.liu@intel.com, eskultet@redhat.com,
 Ken.Xue@amd.com, jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Added amount of bytes transferred to the target VM by all VFIO devices

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
---
 hw/vfio/common.c            | 20 ++++++++++++++++++++
 hw/vfio/migration.c         | 10 +++++++++-
 include/qemu/vfio-helpers.h |  3 +++
 migration/migration.c       | 18 ++++++++++++++++++
 monitor/hmp-cmds.c          |  6 ++++++
 qapi/migration.json         | 19 ++++++++++++++++++-
 6 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 2dd9e8b24788..e1ad426a6d78 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -40,6 +40,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "migration/migration.h"
+#include "qemu/vfio-helpers.h"
 
 VFIOGroupList vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
@@ -293,6 +294,25 @@ const MemoryRegionOps vfio_region_ops = {
  * Device state interfaces
  */
 
+bool vfio_mig_active(void)
+{
+    VFIOGroup *group;
+    VFIODevice *vbasedev;
+
+    if (QLIST_EMPTY(&vfio_group_list)) {
+        return false;
+    }
+
+    QLIST_FOREACH(group, &vfio_group_list, next) {
+        QLIST_FOREACH(vbasedev, &group->device_list, next) {
+            if (vbasedev->migration_blocker) {
+                return false;
+            }
+        }
+    }
+    return true;
+}
+
 static bool vfio_devices_are_stopped_and_saving(void)
 {
     VFIOGroup *group;
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 7729c90782bd..2eef38fe5c65 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -26,7 +26,7 @@
 #include "exec/ram_addr.h"
 #include "pci.h"
 #include "trace.h"
-
+#include "qemu/vfio-helpers.h"
 /*
  * Flags used as delimiter:
  * 0xffffffff => MSB 32-bit all 1s
@@ -38,6 +38,8 @@
 #define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
 #define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
 
+static int64_t bytes_transferred;
+
 static void vfio_migration_region_exit(VFIODevice *vbasedev)
 {
     VFIOMigration *migration = vbasedev->migration;
@@ -229,6 +231,7 @@ static int vfio_save_buffer(QEMUFile *f, VFIODevice *vbasedev)
         return ret;
     }
 
+    bytes_transferred += data_size;
     return data_size;
 }
 
@@ -744,6 +747,11 @@ static int vfio_migration_init(VFIODevice *vbasedev,
 
 /* ---------------------------------------------------------------------- */
 
+int64_t vfio_mig_bytes_transferred(void)
+{
+    return bytes_transferred;
+}
+
 int vfio_migration_probe(VFIODevice *vbasedev, Error **errp)
 {
     struct vfio_region_info *info;
diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
index 1f057c2b9e40..26a7df0767b1 100644
--- a/include/qemu/vfio-helpers.h
+++ b/include/qemu/vfio-helpers.h
@@ -29,4 +29,7 @@ void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
 int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
                            int irq_type, Error **errp);
 
+bool vfio_mig_active(void);
+int64_t vfio_mig_bytes_transferred(void);
+
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 0bb042a0f78b..bcdc880e9a76 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -54,6 +54,7 @@
 #include "net/announce.h"
 #include "qemu/queue.h"
 #include "multifd.h"
+#include "qemu/vfio-helpers.h"
 
 #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttling */
 
@@ -970,6 +971,17 @@ static void populate_disk_info(MigrationInfo *info)
     }
 }
 
+#ifdef CONFIG_LINUX
+static void populate_vfio_info(MigrationInfo *info)
+{
+    if (vfio_mig_active()) {
+        info->has_vfio = true;
+        info->vfio = g_malloc0(sizeof(*info->vfio));
+        info->vfio->bytes = vfio_mig_bytes_transferred();
+    }
+}
+#endif
+
 static void fill_source_migration_info(MigrationInfo *info)
 {
     MigrationState *s = migrate_get_current();
@@ -995,6 +1007,9 @@ static void fill_source_migration_info(MigrationInfo *info)
         populate_time_info(info, s);
         populate_ram_info(info, s);
         populate_disk_info(info);
+#ifdef CONFIG_LINUX
+        populate_vfio_info(info);
+#endif
         break;
     case MIGRATION_STATUS_COLO:
         info->has_status = true;
@@ -1003,6 +1018,9 @@ static void fill_source_migration_info(MigrationInfo *info)
     case MIGRATION_STATUS_COMPLETED:
         populate_time_info(info, s);
         populate_ram_info(info, s);
+#ifdef CONFIG_LINUX
+        populate_vfio_info(info);
+#endif
         break;
     case MIGRATION_STATUS_FAILED:
         info->has_status = true;
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 9c61e769ca9a..396c195263c2 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -355,6 +355,12 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
         }
         monitor_printf(mon, "]\n");
     }
+
+    if (info->has_vfio) {
+        monitor_printf(mon, "vfio device bytes: %" PRIu64 " kbytes\n",
+                       info->vfio->bytes >> 10);
+    }
+
     qapi_free_MigrationInfo(info);
 }
 
diff --git a/qapi/migration.json b/qapi/migration.json
index d5000558c6c9..acbc42a1efe8 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -146,6 +146,18 @@
             'active', 'postcopy-active', 'postcopy-paused',
             'postcopy-recover', 'completed', 'failed', 'colo',
             'pre-switchover', 'device', 'wait-unplug' ] }
+##
+# @VfioStats:
+#
+# Detailed VFIO devices migration statistics
+#
+# @bytes: amount of bytes transferred to the target VM by VFIO devices
+#
+# Since: 5.1
+#
+##
+{ 'struct': 'VfioStats',
+  'data': {'bytes': 'int' } }
 
 ##
 # @MigrationInfo:
@@ -207,6 +219,10 @@
 #
 # @socket-address: Only used for tcp, to know what the real port is (Since 4.0)
 #
+# @vfio: @VfioStats containing detailed VFIO devices migration statistics,
+#        only returned if VFIO device is present, migration is supported by all
+#         VFIO devices and status is 'active' or 'completed' (since 5.1)
+#
 # Since: 0.14.0
 ##
 { 'struct': 'MigrationInfo',
@@ -222,7 +238,8 @@
            '*postcopy-blocktime' : 'uint32',
            '*postcopy-vcpu-blocktime': ['uint32'],
            '*compression': 'CompressionStats',
-           '*socket-address': ['SocketAddress'] } }
+           '*socket-address': ['SocketAddress'],
+           '*vfio': 'VfioStats' } }
 
 ##
 # @query-migrate:
-- 
2.7.0


