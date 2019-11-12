Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87FAC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9388C214E0
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="L+40RUJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9388C214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUaPW-00066u-OI
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 12:57:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1iUaA6-0003u9-J0
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:41:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1iUaA5-0006RW-57
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:41:06 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16244)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1iUaA4-0006Qq-QF
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:41:05 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5dcaed6c0000>; Tue, 12 Nov 2019 09:35:40 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 12 Nov 2019 09:35:40 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 12 Nov 2019 09:35:40 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Nov
 2019 17:35:40 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Nov
 2019 17:35:39 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 12 Nov 2019 17:35:34 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v9 QEMU 12/15] vfio: Add load state functions to SaveVMHandlers
Date: Tue, 12 Nov 2019 22:35:21 +0530
Message-ID: <1573578324-8389-13-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1573578324-8389-1-git-send-email-kwankhede@nvidia.com>
References: <1573578324-8389-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1573580140; bh=NOPvMXmjZR0VwAvP/dpPas3TZvz+OT58CvPgdqxxC3w=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=L+40RUJZ/moNua5gwX/lQzrbALTOYZlF3Q2XTPCHfC5gaIuwlWkjeVAgUAq2ItvGS
 V5i6KQbUm672QXcGxPMrpdzi80n7TfSXL1OS2xM6iBjsx5YlDMr3GSL7Pd1RMZgqAS
 zSncXqkChsM9I+8XGK9S3duB5BHyWsKeJ+Y1LZL2hd3F/WaJiTOqNqrcn9Cj/nn6QU
 cULjaQ2WKWdCWsv9kWgHKlKEPw2Pg3q6/kA92G2+qORRm0zIwmxSzE4/5LeBwBZbfJ
 q3BO/e91KNJsjNgMGcJjxHEzD27KCydymYU5QPexi+CPNGPzGxPo9wIoGuF8GHx5JX
 qaaUrAS35W9Og==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.64
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yan.y.zhao@intel.com, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, Kirti Wankhede <kwankhede@nvidia.com>,
 eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com,
 changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sequence  during _RESUMING device state:
While data for this device is available, repeat below steps:
a. read data_offset from where user application should write data.
b. write data of data_size to migration region from data_offset.
c. write data_size which indicates vendor driver that data is written in
   staging buffer.

For user, data is opaque. User should write data in the same order as
received.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/migration.c  | 170 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events |   3 +
 2 files changed, 173 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index f890e864e174..16e12586fe8b 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -251,6 +251,33 @@ static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
     return qemu_file_get_error(f);
 }
 
+static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    uint64_t data;
+
+    if (vbasedev->ops && vbasedev->ops->vfio_load_config) {
+        int ret;
+
+        ret = vbasedev->ops->vfio_load_config(vbasedev, f);
+        if (ret) {
+            error_report("%s: Failed to load device config space",
+                         vbasedev->name);
+            return ret;
+        }
+    }
+
+    data = qemu_get_be64(f);
+    if (data != VFIO_MIG_FLAG_END_OF_STATE) {
+        error_report("%s: Failed loading device config space, "
+                     "end flag incorrect 0x%"PRIx64, vbasedev->name, data);
+        return -EINVAL;
+    }
+
+    trace_vfio_load_device_config_state(vbasedev->name);
+    return qemu_file_get_error(f);
+}
+
 /* ---------------------------------------------------------------------- */
 
 static int vfio_save_setup(QEMUFile *f, void *opaque)
@@ -410,12 +437,155 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
     return ret;
 }
 
+static int vfio_load_setup(QEMUFile *f, void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    int ret = 0;
+
+    if (migration->region.mmaps) {
+        ret = vfio_region_mmap(&migration->region);
+        if (ret) {
+            error_report("%s: Failed to mmap VFIO migration region %d: %s",
+                         vbasedev->name, migration->region.nr,
+                         strerror(-ret));
+            return ret;
+        }
+    }
+
+    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING, 0);
+    if (ret) {
+        error_report("%s: Failed to set state RESUMING", vbasedev->name);
+    }
+    return ret;
+}
+
+static int vfio_load_cleanup(void *opaque)
+{
+    vfio_save_cleanup(opaque);
+    return 0;
+}
+
+static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    int ret = 0;
+    uint64_t data, data_size;
+
+    data = qemu_get_be64(f);
+    while (data != VFIO_MIG_FLAG_END_OF_STATE) {
+
+        trace_vfio_load_state(vbasedev->name, data);
+
+        switch (data) {
+        case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
+        {
+            ret = vfio_load_device_config_state(f, opaque);
+            if (ret) {
+                return ret;
+            }
+            break;
+        }
+        case VFIO_MIG_FLAG_DEV_SETUP_STATE:
+        {
+            data = qemu_get_be64(f);
+            if (data == VFIO_MIG_FLAG_END_OF_STATE) {
+                return ret;
+            } else {
+                error_report("%s: SETUP STATE: EOS not found 0x%"PRIx64,
+                             vbasedev->name, data);
+                return -EINVAL;
+            }
+            break;
+        }
+        case VFIO_MIG_FLAG_DEV_DATA_STATE:
+        {
+            VFIORegion *region = &migration->region;
+            void *buf = NULL;
+            bool buffer_mmaped = false;
+            uint64_t data_offset = 0;
+
+            data_size = qemu_get_be64(f);
+            if (data_size == 0) {
+                break;
+            }
+
+            ret = pread(vbasedev->fd, &data_offset, sizeof(data_offset),
+                        region->fd_offset +
+                        offsetof(struct vfio_device_migration_info,
+                        data_offset));
+            if (ret != sizeof(data_offset)) {
+                error_report("%s:Failed to get migration buffer data offset %d",
+                             vbasedev->name, ret);
+                return -EINVAL;
+            }
+
+            if (region->mmaps) {
+                buf = find_data_region(region, data_offset, data_size);
+            }
+
+            buffer_mmaped = (buf != NULL) ? true : false;
+
+            if (!buffer_mmaped) {
+                buf = g_try_malloc0(data_size);
+                if (!buf) {
+                    error_report("%s: Error allocating buffer ", __func__);
+                    return -ENOMEM;
+                }
+            }
+
+            qemu_get_buffer(f, buf, data_size);
+
+            if (!buffer_mmaped) {
+                ret = pwrite(vbasedev->fd, buf, data_size,
+                             region->fd_offset + data_offset);
+                g_free(buf);
+
+                if (ret != data_size) {
+                    error_report("%s: Failed to set migration buffer %d",
+                                 vbasedev->name, ret);
+                    return -EINVAL;
+                }
+            }
+
+            ret = pwrite(vbasedev->fd, &data_size, sizeof(data_size),
+                         region->fd_offset +
+                       offsetof(struct vfio_device_migration_info, data_size));
+            if (ret != sizeof(data_size)) {
+                error_report("%s: Failed to set migration buffer data size %d",
+                             vbasedev->name, ret);
+                if (!buffer_mmaped) {
+                    g_free(buf);
+                }
+                return -EINVAL;
+            }
+
+            trace_vfio_load_state_device_data(vbasedev->name, data_offset,
+                                              data_size);
+            break;
+        }
+        }
+
+        ret = qemu_file_get_error(f);
+        if (ret) {
+            return ret;
+        }
+        data = qemu_get_be64(f);
+    }
+
+    return ret;
+}
+
 static SaveVMHandlers savevm_vfio_handlers = {
     .save_setup = vfio_save_setup,
     .save_cleanup = vfio_save_cleanup,
     .save_live_pending = vfio_save_pending,
     .save_live_iterate = vfio_save_iterate,
     .save_live_complete_precopy = vfio_save_complete_precopy,
+    .load_setup = vfio_load_setup,
+    .load_cleanup = vfio_load_cleanup,
+    .load_state = vfio_load_state,
 };
 
 /* ---------------------------------------------------------------------- */
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index bdf40ba368c7..ac065b559f4e 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -157,3 +157,6 @@ vfio_save_device_config_state(char *name) " (%s)"
 vfio_save_pending(char *name, uint64_t precopy, uint64_t postcopy, uint64_t compatible) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" compatible 0x%"PRIx64
 vfio_save_iterate(char *name, int data_size) " (%s) data_size %d"
 vfio_save_complete_precopy(char *name) " (%s)"
+vfio_load_device_config_state(char *name) " (%s)"
+vfio_load_state(char *name, uint64_t data) " (%s) data 0x%"PRIx64
+vfio_load_state_device_data(char *name, uint64_t data_offset, uint64_t data_size) " (%s) Offset 0x%"PRIx64" size 0x%"PRIx64
-- 
2.7.0


