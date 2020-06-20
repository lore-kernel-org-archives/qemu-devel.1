Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC75C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 20:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED6BC2469D
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 20:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OYY5EZDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6BC2469D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmkZH-0001xB-8X
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 16:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jmkWn-0005GZ-OY
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 16:55:53 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18983)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jmkWj-0000NR-Py
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 16:55:52 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5eee777b0000>; Sat, 20 Jun 2020 13:54:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Sat, 20 Jun 2020 13:55:48 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Sat, 20 Jun 2020 13:55:48 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 20 Jun
 2020 20:55:41 +0000
Received: from kwankhede-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via
 Frontend Transport; Sat, 20 Jun 2020 20:55:33 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH QEMU v25 08/17] vfio: Add save state functions to
 SaveVMHandlers
Date: Sun, 21 Jun 2020 01:51:17 +0530
Message-ID: <1592684486-18511-9-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
References: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1592686459; bh=q+YYjjeKkPAopPp0GYvi6uzwXT7+5KdXfMPmxQ3tjpw=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=OYY5EZDEOCylAN3UHPrXNQ2PCf3NagxztyH3G6iBKbNQ3xT3yzAIJr3y86UUaH418
 0EFPb1kb+WJD3oF7XHV/RPINoFqfmxcVMPfoo+ykTksQHfWuBmA5bkfMPL7agq+kqn
 +7Yl2NgyAitOoZkSLUngU3NPX3V7AEtLf8ZpTBt07RgJFGuLcUJHP0eNVnO19CpL8y
 6ed2fb+NY8HpulbtCOzkC+irvM6p4kVqXeKJ2Sz5w697vP2+3SbJNyLc2dJ+LBXJkM
 giJxNnNJCvzqTirefK75BG7MHAmW+E2WOvxHRLoOfarNbj16XoVeFejSJkMvY5GmDd
 7uNsNkucIbaeg==
Received-SPF: pass client-ip=216.228.121.143;
 envelope-from=kwankhede@nvidia.com; helo=hqnvemgate24.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/20 16:54:43
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -80
X-Spam_score: -8.1
X-Spam_bar: --------
X-Spam_report: (-8.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Added .save_live_pending, .save_live_iterate and .save_live_complete_precopy
functions. These functions handles pre-copy and stop-and-copy phase.

In _SAVING|_RUNNING device state or pre-copy phase:
- read pending_bytes. If pending_bytes > 0, go through below steps.
- read data_offset - indicates kernel driver to write data to staging
  buffer.
- read data_size - amount of data in bytes written by vendor driver in
  migration region.
- read data_size bytes of data from data_offset in the migration region.
- Write data packet to file stream as below:
{VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data,
VFIO_MIG_FLAG_END_OF_STATE }

In _SAVING device state or stop-and-copy phase
a. read config space of device and save to migration file stream. This
   doesn't need to be from vendor driver. Any other special config state
   from driver can be saved as data in following iteration.
b. read pending_bytes. If pending_bytes > 0, go through below steps.
c. read data_offset - indicates kernel driver to write data to staging
   buffer.
d. read data_size - amount of data in bytes written by vendor driver in
   migration region.
e. read data_size bytes of data from data_offset in the migration region.
f. Write data packet as below:
   {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data}
g. iterate through steps b to f while (pending_bytes > 0)
h. Write {VFIO_MIG_FLAG_END_OF_STATE}

When data region is mapped, its user's responsibility to read data from
data_offset of data_size before moving to next steps.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/migration.c           | 283 ++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events          |   6 +
 include/hw/vfio/vfio-common.h |   1 +
 3 files changed, 290 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 133bb5b1b3b2..ef1150c1ff02 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -140,6 +140,168 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
     return 0;
 }
 
+static void *get_data_section_size(VFIORegion *region, uint64_t data_offset,
+                                   uint64_t data_size, uint64_t *size)
+{
+    void *ptr = NULL;
+    int i;
+
+    if (!region->mmaps) {
+        *size = data_size;
+        return ptr;
+    }
+
+    /* check if data_offset in within sparse mmap areas */
+    for (i = 0; i < region->nr_mmaps; i++) {
+        VFIOMmap *map = region->mmaps + i;
+
+        if ((data_offset >= map->offset) &&
+            (data_offset < map->offset + map->size)) {
+            ptr = map->mmap + data_offset - map->offset;
+
+            if (data_offset + data_size <= map->offset + map->size) {
+                *size = data_size;
+            } else {
+                *size = map->offset + map->size - data_offset;
+            }
+            break;
+        }
+    }
+
+    if (!ptr) {
+        uint64_t limit = 0;
+
+        /*
+         * data_offset is not within sparse mmap areas, find size of non-mapped
+         * area. Check through all list since region->mmaps list is not sorted.
+         */
+        for (i = 0; i < region->nr_mmaps; i++) {
+            VFIOMmap *map = region->mmaps + i;
+
+            if ((data_offset < map->offset) &&
+                (!limit || limit > map->offset)) {
+                limit = map->offset;
+            }
+        }
+
+        *size = limit ? limit - data_offset : data_size;
+    }
+    return ptr;
+}
+
+static int vfio_save_buffer(QEMUFile *f, VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    VFIORegion *region = &migration->region;
+    uint64_t data_offset = 0, data_size = 0, size;
+    int ret;
+
+    ret = pread(vbasedev->fd, &data_offset, sizeof(data_offset),
+                region->fd_offset + offsetof(struct vfio_device_migration_info,
+                                             data_offset));
+    if (ret != sizeof(data_offset)) {
+        error_report("%s: Failed to get migration buffer data offset %d",
+                     vbasedev->name, ret);
+        return -EINVAL;
+    }
+
+    ret = pread(vbasedev->fd, &data_size, sizeof(data_size),
+                region->fd_offset + offsetof(struct vfio_device_migration_info,
+                                             data_size));
+    if (ret != sizeof(data_size)) {
+        error_report("%s: Failed to get migration buffer data size %d",
+                     vbasedev->name, ret);
+        return -EINVAL;
+    }
+
+    trace_vfio_save_buffer(vbasedev->name, data_offset, data_size,
+                           migration->pending_bytes);
+
+    qemu_put_be64(f, data_size);
+    size = data_size;
+
+    while (size) {
+        void *buf = NULL;
+        bool buffer_mmaped;
+        uint64_t sec_size;
+
+        buf = get_data_section_size(region, data_offset, size, &sec_size);
+
+        buffer_mmaped = (buf != NULL);
+
+        if (!buffer_mmaped) {
+            buf = g_try_malloc(sec_size);
+            if (!buf) {
+                error_report("%s: Error allocating buffer ", __func__);
+                return -ENOMEM;
+            }
+
+            ret = pread(vbasedev->fd, buf, sec_size,
+                        region->fd_offset + data_offset);
+            if (ret != sec_size) {
+                error_report("%s: Failed to get migration data %d",
+                             vbasedev->name, ret);
+                g_free(buf);
+                return -EINVAL;
+            }
+        }
+
+        qemu_put_buffer(f, buf, sec_size);
+
+        if (!buffer_mmaped) {
+            g_free(buf);
+        }
+        size -= sec_size;
+        data_offset += sec_size;
+    }
+
+    ret = qemu_file_get_error(f);
+    if (ret) {
+        return ret;
+    }
+
+    return data_size;
+}
+
+static int vfio_update_pending(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    VFIORegion *region = &migration->region;
+    uint64_t pending_bytes = 0;
+    int ret;
+
+    ret = pread(vbasedev->fd, &pending_bytes, sizeof(pending_bytes),
+                region->fd_offset + offsetof(struct vfio_device_migration_info,
+                                             pending_bytes));
+    if ((ret < 0) || (ret != sizeof(pending_bytes))) {
+        error_report("%s: Failed to get pending bytes %d",
+                     vbasedev->name, ret);
+        migration->pending_bytes = 0;
+        return (ret < 0) ? ret : -EINVAL;
+    }
+
+    migration->pending_bytes = pending_bytes;
+    trace_vfio_update_pending(vbasedev->name, pending_bytes);
+    return 0;
+}
+
+static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_STATE);
+
+    if (vbasedev->ops && vbasedev->ops->vfio_save_config) {
+        vbasedev->ops->vfio_save_config(vbasedev, f);
+    }
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
+
+    trace_vfio_save_device_config_state(vbasedev->name);
+
+    return qemu_file_get_error(f);
+}
+
 /* ---------------------------------------------------------------------- */
 
 static int vfio_save_setup(QEMUFile *f, void *opaque)
@@ -192,9 +354,130 @@ static void vfio_save_cleanup(void *opaque)
     trace_vfio_save_cleanup(vbasedev->name);
 }
 
+static void vfio_save_pending(QEMUFile *f, void *opaque,
+                              uint64_t threshold_size,
+                              uint64_t *res_precopy_only,
+                              uint64_t *res_compatible,
+                              uint64_t *res_postcopy_only)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    int ret;
+
+    ret = vfio_update_pending(vbasedev);
+    if (ret) {
+        return;
+    }
+
+    *res_precopy_only += migration->pending_bytes;
+
+    trace_vfio_save_pending(vbasedev->name, *res_precopy_only,
+                            *res_postcopy_only, *res_compatible);
+}
+
+static int vfio_save_iterate(QEMUFile *f, void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    int ret, data_size;
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
+
+    if (migration->pending_bytes == 0) {
+        ret = vfio_update_pending(vbasedev);
+        if (ret) {
+            return ret;
+        }
+
+        if (migration->pending_bytes == 0) {
+            /* indicates data finished, goto complete phase */
+            return 1;
+        }
+    }
+
+    data_size = vfio_save_buffer(f, vbasedev);
+
+    if (data_size < 0) {
+        error_report("%s: vfio_save_buffer failed %s", vbasedev->name,
+                     strerror(errno));
+        return data_size;
+    }
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
+
+    ret = qemu_file_get_error(f);
+    if (ret) {
+        return ret;
+    }
+
+    trace_vfio_save_iterate(vbasedev->name, data_size);
+
+    return 0;
+}
+
+static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    int ret;
+
+    ret = vfio_migration_set_state(vbasedev, ~VFIO_DEVICE_STATE_RUNNING,
+                                   VFIO_DEVICE_STATE_SAVING);
+    if (ret) {
+        error_report("%s: Failed to set state STOP and SAVING",
+                     vbasedev->name);
+        return ret;
+    }
+
+    ret = vfio_save_device_config_state(f, opaque);
+    if (ret) {
+        return ret;
+    }
+
+    ret = vfio_update_pending(vbasedev);
+    if (ret) {
+        return ret;
+    }
+
+    while (migration->pending_bytes > 0) {
+        qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
+        ret = vfio_save_buffer(f, vbasedev);
+        if (ret < 0) {
+            error_report("%s: Failed to save buffer", vbasedev->name);
+            return ret;
+        } else if (ret == 0) {
+            break;
+        }
+
+        ret = vfio_update_pending(vbasedev);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
+
+    ret = qemu_file_get_error(f);
+    if (ret) {
+        return ret;
+    }
+
+    ret = vfio_migration_set_state(vbasedev, ~VFIO_DEVICE_STATE_SAVING, 0);
+    if (ret) {
+        error_report("%s: Failed to set state STOPPED", vbasedev->name);
+        return ret;
+    }
+
+    trace_vfio_save_complete_precopy(vbasedev->name);
+    return ret;
+}
+
 static SaveVMHandlers savevm_vfio_handlers = {
     .save_setup = vfio_save_setup,
     .save_cleanup = vfio_save_cleanup,
+    .save_live_pending = vfio_save_pending,
+    .save_live_iterate = vfio_save_iterate,
+    .save_live_complete_precopy = vfio_save_complete_precopy,
 };
 
 /* ---------------------------------------------------------------------- */
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 86c18def016e..9a1c5e17d97f 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -151,3 +151,9 @@ vfio_vmstate_change(const char *name, int running, const char *reason, uint32_t
 vfio_migration_state_notifier(const char *name, const char *state) " (%s) state %s"
 vfio_save_setup(const char *name) " (%s)"
 vfio_save_cleanup(const char *name) " (%s)"
+vfio_save_buffer(const char *name, uint64_t data_offset, uint64_t data_size, uint64_t pending) " (%s) Offset 0x%"PRIx64" size 0x%"PRIx64" pending 0x%"PRIx64
+vfio_update_pending(const char *name, uint64_t pending) " (%s) pending 0x%"PRIx64
+vfio_save_device_config_state(const char *name) " (%s)"
+vfio_save_pending(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t compatible) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" compatible 0x%"PRIx64
+vfio_save_iterate(const char *name, int data_size) " (%s) data_size %d"
+vfio_save_complete_precopy(const char *name) " (%s)"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 28f55f66d019..c78033e4149d 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -60,6 +60,7 @@ typedef struct VFIORegion {
 
 typedef struct VFIOMigration {
     VFIORegion region;
+    uint64_t pending_bytes;
 } VFIOMigration;
 
 typedef struct VFIOAddressSpace {
-- 
2.7.0


