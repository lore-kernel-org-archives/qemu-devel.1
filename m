Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC82C33CA3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 12:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 171882072A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 12:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171882072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iptFc-0003Hu-79
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 07:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yang.zhong@intel.com>) id 1iptEu-0002ef-Le
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 07:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yang.zhong@intel.com>) id 1iptEs-00050L-TG
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 07:18:07 -0500
Received: from mga09.intel.com ([134.134.136.24]:39729)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yang.zhong@intel.com>)
 id 1iptEs-0004hK-H7
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 07:18:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Jan 2020 04:18:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,416,1571727600"; d="scan'208";a="237450083"
Received: from he.bj.intel.com ([10.238.157.85])
 by orsmga002.jf.intel.com with ESMTP; 10 Jan 2020 04:18:01 -0800
From: Yang Zhong <yang.zhong@intel.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] vhost-user-blk: reset the device if supported
Date: Fri, 10 Jan 2020 20:22:03 +0800
Message-Id: <20200110122203.6735-1-yang.zhong@intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
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
Cc: yang.zhong@intel.com, pbonzini@redhat.com, stefanha@redhat.com,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As the vhost-user-scsi did in f04724, if the vhost-user-blk backend
supports the VHOST_USER_F_RESET_DEVICE protocol feature, then the
device can be reset when requested.

If this feature is not supported, this reset will directly return.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 hw/block/vhost-user-blk.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 63da9bb619..16ddc9b70c 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -50,6 +50,10 @@ static const int user_feature_bits[] = {
     VHOST_INVALID_FEATURE_BIT
 };
 
+enum VhostUserProtocolFeature {
+    VHOST_USER_PROTOCOL_F_RESET_DEVICE = 13,
+};
+
 static void vhost_user_blk_update_config(VirtIODevice *vdev, uint8_t *config)
 {
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
@@ -290,8 +294,23 @@ static void vhost_user_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 static void vhost_user_blk_reset(VirtIODevice *vdev)
 {
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
+    struct vhost_dev *dev = &s->dev;
 
     vhost_dev_free_inflight(s->inflight);
+
+    /*
+     * Historically, reset was not implemented so only reset devices
+     * that are expecting it.
+     */
+    if (!virtio_has_feature(dev->protocol_features,
+                            VHOST_USER_PROTOCOL_F_RESET_DEVICE)) {
+        return;
+    }
+
+    if (dev->vhost_ops->vhost_reset_device) {
+        dev->vhost_ops->vhost_reset_device(dev);
+    }
+
 }
 
 static int vhost_user_blk_connect(DeviceState *dev)
-- 
2.17.1


