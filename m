Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBD5C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 06:15:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A1E206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 06:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A1E206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGFrn-0008DA-5w
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 02:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jin.yu@intel.com>) id 1kGFrD-0007lX-0K
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 02:14:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:1173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jin.yu@intel.com>) id 1kGFr9-0004bF-Tm
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 02:14:54 -0400
IronPort-SDR: BlgkQLSe2wEwYAkB4vsoJAx4Tj2o4jijndEvAYRv+3Nb/yyRXPmpEvJLbuZ7aI8hLLw66r2uCy
 JSKKUfXfXpKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="220034573"
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; d="scan'208";a="220034573"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2020 23:14:45 -0700
IronPort-SDR: BTC/yktDs7aoQ/3SEde8007XchjckOVetglJhnMLk2oS5rGrt2HV+t/044qWt+NHc2Yy2FxsHy
 /vGpBxncqu9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; d="scan'208";a="505724534"
Received: from storage36.sh.intel.com ([10.67.111.10])
 by fmsmga005.fm.intel.com with ESMTP; 09 Sep 2020 23:14:43 -0700
From: Jin Yu <jin.yu@intel.com>
To: mst@redhat.com, raphael.norwitz@nutanix.com, kwolf@redhat.com,
 mreitz@redhat.com
Subject: [PATCH] vhost-blk: set features before setting inflight feature
Date: Thu, 10 Sep 2020 21:48:51 +0800
Message-Id: <20200910134851.7817-1-jin.yu@intel.com>
X-Mailer: git-send-email 2.17.2
Received-SPF: pass client-ip=134.134.136.31; envelope-from=jin.yu@intel.com;
 helo=mga06.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 02:14:45
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
Cc: Jin Yu <jin.yu@intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Virtqueue has split and packed, so before setting inflight,
you need to inform the back-end virtqueue format.

Signed-off-by: Jin Yu <jin.yu@intel.com>
---
 hw/block/vhost-user-blk.c |  6 ++++++
 hw/virtio/vhost.c         | 18 ++++++++++++++++++
 include/hw/virtio/vhost.h |  1 +
 3 files changed, 25 insertions(+)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 39aec42dae..9e0e9ebec0 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -131,6 +131,12 @@ static int vhost_user_blk_start(VirtIODevice *vdev)
 
     s->dev.acked_features = vdev->guest_features;
 
+    ret = vhost_dev_prepare_inflight(&s->dev);
+    if (ret < 0) {
+        error_report("Error set inflight format: %d", -ret);
+        goto err_guest_notifiers;
+    }
+
     if (!s->inflight->addr) {
         ret = vhost_dev_get_inflight(&s->dev, s->queue_size, s->inflight);
         if (ret < 0) {
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 1a1384e7a6..4027c11886 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1616,6 +1616,24 @@ int vhost_dev_load_inflight(struct vhost_inflight *inflight, QEMUFile *f)
     return 0;
 }
 
+int vhost_dev_prepare_inflight(struct vhost_dev *hdev)
+{
+    int r;
+ 
+    if (hdev->vhost_ops->vhost_get_inflight_fd == NULL ||
+        hdev->vhost_ops->vhost_set_inflight_fd == NULL) {
+        return 0;
+    }
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
index 767a95ec0b..4e2fc75528 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -140,6 +140,7 @@ void vhost_dev_reset_inflight(struct vhost_inflight *inflight);
 void vhost_dev_free_inflight(struct vhost_inflight *inflight);
 void vhost_dev_save_inflight(struct vhost_inflight *inflight, QEMUFile *f);
 int vhost_dev_load_inflight(struct vhost_inflight *inflight, QEMUFile *f);
+int vhost_dev_prepare_inflight(struct vhost_dev *hdev);
 int vhost_dev_set_inflight(struct vhost_dev *dev,
                            struct vhost_inflight *inflight);
 int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size,
-- 
2.17.2


