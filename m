Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CCDC388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 05:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F15222277
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 05:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F15222277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZoWI-0004St-AN
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 00:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jin.yu@intel.com>)
 id 1kZoV0-0003yF-U1; Tue, 03 Nov 2020 00:04:50 -0500
Received: from mga18.intel.com ([134.134.136.126]:37576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jin.yu@intel.com>)
 id 1kZoUy-0007rT-7g; Tue, 03 Nov 2020 00:04:50 -0500
IronPort-SDR: aSMM8rOVQwbmbat1caxOp9ccUGOR+FEaxl1sKD6aFvVFg5YSd18/GMeLszm6yF26ADebfUuTb8
 gXravsKRzKOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="156778397"
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; d="scan'208";a="156778397"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2020 21:04:38 -0800
IronPort-SDR: KlLPmVy3qCBgHLnekOOzI/lkSNQu4PAKY4GxK1lRa765E/De+avht9Ji4Zni4gMR5QMfHAzTqj
 26HFGGE0OJ9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; d="scan'208";a="528278671"
Received: from unknown (HELO storage36.sh.intel.com) ([10.67.111.10])
 by fmsmga005.fm.intel.com with ESMTP; 02 Nov 2020 21:04:36 -0800
From: Jin Yu <jin.yu@intel.com>
To: raphael.norwitz@nutanix.com, mst@redhat.com, kwolf@redhat.com,
 mreitz@redhat.com
Subject: [PATCH v2] vhost-blk: set features before setting inflight feature
Date: Tue,  3 Nov 2020 20:36:17 +0800
Message-Id: <20201103123617.28256-1-jin.yu@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200910134851.7817-1-jin.yu@intel.com>
References: <20200910134851.7817-1-jin.yu@intel.com>
Received-SPF: pass client-ip=134.134.136.126; envelope-from=jin.yu@intel.com;
 helo=mga18.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:04:39
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jin Yu <jin.yu@intel.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Virtqueue has split and packed, so before setting inflight,
you need to inform the back-end virtqueue format.

Signed-off-by: Jin Yu <jin.yu@intel.com>
Acked-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
v2:
* Fixed the segfault.
---
 hw/block/vhost-user-blk.c |  6 ++++++
 hw/virtio/vhost.c         | 20 ++++++++++++++++++++
 include/hw/virtio/vhost.h |  1 +
 3 files changed, 27 insertions(+)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 39aec42dae..db079a89c0 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -131,6 +131,12 @@ static int vhost_user_blk_start(VirtIODevice *vdev)
 
     s->dev.acked_features = vdev->guest_features;
 
+    ret = vhost_dev_prepare_inflight(&s->dev, vdev);
+    if (ret < 0) {
+        error_report("Error set inflight format: %d", -ret);
+        goto err_guest_notifiers;
+    }
+
     if (!s->inflight->addr) {
         ret = vhost_dev_get_inflight(&s->dev, s->queue_size, s->inflight);
         if (ret < 0) {
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 1a1384e7a6..6ffbfbfb9e 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1616,6 +1616,26 @@ int vhost_dev_load_inflight(struct vhost_inflight *inflight, QEMUFile *f)
     return 0;
 }
 
+int vhost_dev_prepare_inflight(struct vhost_dev *hdev, VirtIODevice *vdev)
+{
+    int r;
+
+    if (hdev->vhost_ops->vhost_get_inflight_fd == NULL ||
+        hdev->vhost_ops->vhost_set_inflight_fd == NULL) {
+        return 0;
+    }
+
+    hdev->vdev = vdev;
+
+    r = vhost_dev_set_features(hdev, hdev->log_enabled);
+    if (r < 0) {
+        VHOST_OPS_DEBUG("vhost_dev_prepare_inflight failed");
+        return r;
+    }
+
+    return 0;
+}
+
 int vhost_dev_set_inflight(struct vhost_dev *dev,
                            struct vhost_inflight *inflight)
 {
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 767a95ec0b..d25f0947f7 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -140,6 +140,7 @@ void vhost_dev_reset_inflight(struct vhost_inflight *inflight);
 void vhost_dev_free_inflight(struct vhost_inflight *inflight);
 void vhost_dev_save_inflight(struct vhost_inflight *inflight, QEMUFile *f);
 int vhost_dev_load_inflight(struct vhost_inflight *inflight, QEMUFile *f);
+int vhost_dev_prepare_inflight(struct vhost_dev *hdev, VirtIODevice *vdev);
 int vhost_dev_set_inflight(struct vhost_dev *dev,
                            struct vhost_inflight *inflight);
 int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size,
-- 
2.17.2


