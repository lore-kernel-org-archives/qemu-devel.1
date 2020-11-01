Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EC6C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A384B221FC
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGk6CTi6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A384B221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZKXk-00030d-NZ
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 16:05:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kZKSp-0005KW-6e
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 16:00:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kZKSn-0005KO-0i
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 16:00:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604264432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0gSdunvtx46sOHmGt7Hjz8gkVAq9XRbaN76iOh8NM7I=;
 b=KGk6CTi6FKXGdqQIofd926OXDgkgJhpuhEoVKkj5UW1ITxbRK56DlmQZcMhKTvTUBVB2CD
 T0H+Np++1VtpCkpNcsTwjUv54sbHdIB3XtjceANLn770B+x1TKbw0UKxXNhuW9LTwBdHN3
 xZREYLtGJ9lAftmVjgCav03aRM/M6sI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-dx611nLBMWGrUE_pspG2yw-1; Sun, 01 Nov 2020 16:00:26 -0500
X-MC-Unique: dx611nLBMWGrUE_pspG2yw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA15C57037;
 Sun,  1 Nov 2020 21:00:24 +0000 (UTC)
Received: from gimli.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72D371A885;
 Sun,  1 Nov 2020 21:00:24 +0000 (UTC)
Subject: [PULL v3 09/32] vfio: Add load state functions to SaveVMHandlers
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Sun, 01 Nov 2020 14:00:24 -0700
Message-ID: <160426442407.24886.11266488719431591917.stgit@gimli.home>
In-Reply-To: <160426371498.24886.12193840637250368669.stgit@gimli.home>
References: <160426371498.24886.12193840637250368669.stgit@gimli.home>
User-Agent: StGit/0.21-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/01 15:46:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Yan Zhao <yan.y.zhao@intel.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Neo Jia <cjia@nvidia.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kirti Wankhede <kwankhede@nvidia.com>

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
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/migration.c  |  195 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events |    4 +
 2 files changed, 199 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 5e0c9e8e61ec..1af0fce874d4 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -257,6 +257,77 @@ static int vfio_save_buffer(QEMUFile *f, VFIODevice *vbasedev, uint64_t *size)
     return ret;
 }
 
+static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
+                            uint64_t data_size)
+{
+    VFIORegion *region = &vbasedev->migration->region;
+    uint64_t data_offset = 0, size, report_size;
+    int ret;
+
+    do {
+        ret = vfio_mig_read(vbasedev, &data_offset, sizeof(data_offset),
+                      region->fd_offset + VFIO_MIG_STRUCT_OFFSET(data_offset));
+        if (ret < 0) {
+            return ret;
+        }
+
+        if (data_offset + data_size > region->size) {
+            /*
+             * If data_size is greater than the data section of migration region
+             * then iterate the write buffer operation. This case can occur if
+             * size of migration region at destination is smaller than size of
+             * migration region at source.
+             */
+            report_size = size = region->size - data_offset;
+            data_size -= size;
+        } else {
+            report_size = size = data_size;
+            data_size = 0;
+        }
+
+        trace_vfio_load_state_device_data(vbasedev->name, data_offset, size);
+
+        while (size) {
+            void *buf;
+            uint64_t sec_size;
+            bool buf_alloc = false;
+
+            buf = get_data_section_size(region, data_offset, size, &sec_size);
+
+            if (!buf) {
+                buf = g_try_malloc(sec_size);
+                if (!buf) {
+                    error_report("%s: Error allocating buffer ", __func__);
+                    return -ENOMEM;
+                }
+                buf_alloc = true;
+            }
+
+            qemu_get_buffer(f, buf, sec_size);
+
+            if (buf_alloc) {
+                ret = vfio_mig_write(vbasedev, buf, sec_size,
+                        region->fd_offset + data_offset);
+                g_free(buf);
+
+                if (ret < 0) {
+                    return ret;
+                }
+            }
+            size -= sec_size;
+            data_offset += sec_size;
+        }
+
+        ret = vfio_mig_write(vbasedev, &report_size, sizeof(report_size),
+                        region->fd_offset + VFIO_MIG_STRUCT_OFFSET(data_size));
+        if (ret < 0) {
+            return ret;
+        }
+    } while (data_size);
+
+    return 0;
+}
+
 static int vfio_update_pending(VFIODevice *vbasedev)
 {
     VFIOMigration *migration = vbasedev->migration;
@@ -293,6 +364,33 @@ static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
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
 static void vfio_migration_cleanup(VFIODevice *vbasedev)
 {
     VFIOMigration *migration = vbasedev->migration;
@@ -483,12 +581,109 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
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
+            error_report("%s: Falling back to slow path", vbasedev->name);
+        }
+    }
+
+    ret = vfio_migration_set_state(vbasedev, ~VFIO_DEVICE_STATE_MASK,
+                                   VFIO_DEVICE_STATE_RESUMING);
+    if (ret) {
+        error_report("%s: Failed to set state RESUMING", vbasedev->name);
+        if (migration->region.mmaps) {
+            vfio_region_unmap(&migration->region);
+        }
+    }
+    return ret;
+}
+
+static int vfio_load_cleanup(void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+
+    vfio_migration_cleanup(vbasedev);
+    trace_vfio_load_cleanup(vbasedev->name);
+    return 0;
+}
+
+static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
+{
+    VFIODevice *vbasedev = opaque;
+    int ret = 0;
+    uint64_t data;
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
+            uint64_t data_size = qemu_get_be64(f);
+
+            if (data_size) {
+                ret = vfio_load_buffer(f, vbasedev, data_size);
+                if (ret < 0) {
+                    return ret;
+                }
+            }
+            break;
+        }
+        default:
+            error_report("%s: Unknown tag 0x%"PRIx64, vbasedev->name, data);
+            return -EINVAL;
+        }
+
+        data = qemu_get_be64(f);
+        ret = qemu_file_get_error(f);
+        if (ret) {
+            return ret;
+        }
+    }
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
index 9f5712dab1ea..a75b5208818c 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -159,3 +159,7 @@ vfio_save_device_config_state(const char *name) " (%s)"
 vfio_save_pending(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t compatible) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" compatible 0x%"PRIx64
 vfio_save_iterate(const char *name, int data_size) " (%s) data_size %d"
 vfio_save_complete_precopy(const char *name) " (%s)"
+vfio_load_device_config_state(const char *name) " (%s)"
+vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
+vfio_load_state_device_data(const char *name, uint64_t data_offset, uint64_t data_size) " (%s) Offset 0x%"PRIx64" size 0x%"PRIx64
+vfio_load_cleanup(const char *name) " (%s)"


