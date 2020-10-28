Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07139C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 16:55:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EE9C247F6
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 16:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCLg7y2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE9C247F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXojO-0006Ce-7Q
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 12:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kXoWb-0007rp-8o
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:42:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kXoWZ-0001ON-5n
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603903330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eM9Hf18B4cRtDBbesFezqRr2/+j8xGWddIy3FrW8/lE=;
 b=LCLg7y2eE4TpfgCjpGxyKUxw+Boti5CPD79eq3PxiDLoijTheJo7ObTgz//uCnlLEmmPeG
 o3Vy+o0I355qayLC/mFTM8H5ZsWYMMhBwkCk95u6K2V9rQOHYc/224P7wAX6A55yTvNHg5
 rBZX27LadNCNdJLGATvNKWjIqN0TlQM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-eqnOHg35OYaguGJZ2aiq8g-1; Wed, 28 Oct 2020 12:42:08 -0400
X-MC-Unique: eqnOHg35OYaguGJZ2aiq8g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B6EA805EE3;
 Wed, 28 Oct 2020 16:42:07 +0000 (UTC)
Received: from gimli.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B7021C4;
 Wed, 28 Oct 2020 16:42:03 +0000 (UTC)
Subject: [PULL v2 17/32] qapi: Add VFIO devices migration stats in Migration
 stats
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 28 Oct 2020 10:42:03 -0600
Message-ID: <160390332322.12234.17907829937899714531.stgit@gimli.home>
In-Reply-To: <160390309510.12234.8858324597971641979.stgit@gimli.home>
References: <160390309510.12234.8858324597971641979.stgit@gimli.home>
User-Agent: StGit/0.21-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kirti Wankhede <kwankhede@nvidia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kirti Wankhede <kwankhede@nvidia.com>

Added amount of bytes transferred to the VM at destination by all VFIO
devices

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/common.c              |   19 +++++++++++++++++++
 hw/vfio/migration.c           |    9 +++++++++
 include/hw/vfio/vfio-common.h |    3 +++
 migration/migration.c         |   17 +++++++++++++++++
 monitor/hmp-cmds.c            |    6 ++++++
 qapi/migration.json           |   17 +++++++++++++++++
 6 files changed, 71 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index da842aeab621..b4e74d469095 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -292,6 +292,25 @@ const MemoryRegionOps vfio_region_ops = {
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
 static bool vfio_devices_all_stopped_and_saving(VFIOContainer *container)
 {
     VFIOGroup *group;
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index a248effb3786..3ce285ea395d 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -45,6 +45,8 @@
 #define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
 #define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
 
+static int64_t bytes_transferred;
+
 static inline int vfio_mig_access(VFIODevice *vbasedev, void *val, int count,
                                   off_t off, bool iswrite)
 {
@@ -255,6 +257,7 @@ static int vfio_save_buffer(QEMUFile *f, VFIODevice *vbasedev, uint64_t *size)
         *size = data_size;
     }
 
+    bytes_transferred += data_size;
     return ret;
 }
 
@@ -785,6 +788,7 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
     case MIGRATION_STATUS_CANCELLING:
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_FAILED:
+        bytes_transferred = 0;
         ret = vfio_migration_set_state(vbasedev,
                       ~(VFIO_DEVICE_STATE_SAVING | VFIO_DEVICE_STATE_RESUMING),
                       VFIO_DEVICE_STATE_RUNNING);
@@ -866,6 +870,11 @@ err:
 
 /* ---------------------------------------------------------------------- */
 
+int64_t vfio_mig_bytes_transferred(void)
+{
+    return bytes_transferred;
+}
+
 int vfio_migration_probe(VFIODevice *vbasedev, Error **errp)
 {
     VFIOContainer *container = vbasedev->group->container;
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b1c1b18fd228..24e299d97425 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -203,6 +203,9 @@ extern const MemoryRegionOps vfio_region_ops;
 typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
 extern VFIOGroupList vfio_group_list;
 
+bool vfio_mig_active(void);
+int64_t vfio_mig_bytes_transferred(void);
+
 #ifdef CONFIG_LINUX
 int vfio_get_region_info(VFIODevice *vbasedev, int index,
                          struct vfio_region_info **info);
diff --git a/migration/migration.c b/migration/migration.c
index 9bb4fee5acec..3263aa55a9da 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -57,6 +57,10 @@
 #include "qemu/queue.h"
 #include "multifd.h"
 
+#ifdef CONFIG_VFIO
+#include "hw/vfio/vfio-common.h"
+#endif
+
 #define MAX_THROTTLE  (128 << 20)      /* Migration transfer speed throttling */
 
 /* Amount of time to allocate to each "chunk" of bandwidth-throttled
@@ -1037,6 +1041,17 @@ static void populate_disk_info(MigrationInfo *info)
     }
 }
 
+static void populate_vfio_info(MigrationInfo *info)
+{
+#ifdef CONFIG_VFIO
+    if (vfio_mig_active()) {
+        info->has_vfio = true;
+        info->vfio = g_malloc0(sizeof(*info->vfio));
+        info->vfio->transferred = vfio_mig_bytes_transferred();
+    }
+#endif
+}
+
 static void fill_source_migration_info(MigrationInfo *info)
 {
     MigrationState *s = migrate_get_current();
@@ -1061,6 +1076,7 @@ static void fill_source_migration_info(MigrationInfo *info)
         populate_time_info(info, s);
         populate_ram_info(info, s);
         populate_disk_info(info);
+        populate_vfio_info(info);
         break;
     case MIGRATION_STATUS_COLO:
         info->has_status = true;
@@ -1069,6 +1085,7 @@ static void fill_source_migration_info(MigrationInfo *info)
     case MIGRATION_STATUS_COMPLETED:
         populate_time_info(info, s);
         populate_ram_info(info, s);
+        populate_vfio_info(info);
         break;
     case MIGRATION_STATUS_FAILED:
         info->has_status = true;
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 9789f4277f50..56e9bad33d94 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -357,6 +357,12 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
         }
         monitor_printf(mon, "]\n");
     }
+
+    if (info->has_vfio) {
+        monitor_printf(mon, "vfio device transferred: %" PRIu64 " kbytes\n",
+                       info->vfio->transferred >> 10);
+    }
+
     qapi_free_MigrationInfo(info);
 }
 
diff --git a/qapi/migration.json b/qapi/migration.json
index a5da513c9e05..3c7582052725 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -147,6 +147,18 @@
             'active', 'postcopy-active', 'postcopy-paused',
             'postcopy-recover', 'completed', 'failed', 'colo',
             'pre-switchover', 'device', 'wait-unplug' ] }
+##
+# @VfioStats:
+#
+# Detailed VFIO devices migration statistics
+#
+# @transferred: amount of bytes transferred to the target VM by VFIO devices
+#
+# Since: 5.2
+#
+##
+{ 'struct': 'VfioStats',
+  'data': {'transferred': 'int' } }
 
 ##
 # @MigrationInfo:
@@ -208,11 +220,16 @@
 #
 # @socket-address: Only used for tcp, to know what the real port is (Since 4.0)
 #
+# @vfio: @VfioStats containing detailed VFIO devices migration statistics,
+#        only returned if VFIO device is present, migration is supported by all
+#        VFIO devices and status is 'active' or 'completed' (since 5.2)
+#
 # Since: 0.14.0
 ##
 { 'struct': 'MigrationInfo',
   'data': {'*status': 'MigrationStatus', '*ram': 'MigrationStats',
            '*disk': 'MigrationStats',
+           '*vfio': 'VfioStats',
            '*xbzrle-cache': 'XBZRLECacheStats',
            '*total-time': 'int',
            '*expected-downtime': 'int',


