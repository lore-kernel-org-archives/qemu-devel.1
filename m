Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24060C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 08:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF6462087D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 08:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="AfMvv2UI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6462087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA837-0003FX-5c
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 04:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kA81s-0001d9-A8; Mon, 24 Aug 2020 04:40:36 -0400
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:59814)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kA81q-0004wW-AM; Mon, 24 Aug 2020 04:40:36 -0400
Received: from myt5-23f0be3aa648.qloud-c.yandex.net
 (myt5-23f0be3aa648.qloud-c.yandex.net
 [IPv6:2a02:6b8:c12:3e29:0:640:23f0:be3a])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id C37C62E1519;
 Mon, 24 Aug 2020 11:40:29 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net
 (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
 by myt5-23f0be3aa648.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 kSk3TBPONr-eRv0sEa9; Mon, 24 Aug 2020 11:40:29 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1598258429; bh=w4HAjC+uPauCS+4y5UQZrU0FI/SIeVh9OnDJmAmUQsg=;
 h=In-Reply-To:In-Reply-To:Message-Id:References:References:Date:
 Subject:To:From:Cc;
 b=AfMvv2UIbL1exh2njrwFZe+7L001iUcnpa1gJS1ZeMGjLYXH7YoYK6wFSrUiLtVh4
 x7wC4S6ioz22UKuv3p7y0A7mjR3/LLawxmJcPRMcyD8VnSNYNgrQSc1Z2zbn+YOF1r
 OXdFMHHTxc83QIJcM/xjnHLJkK8uZ0/YAu+RsqgQ=
Authentication-Results: myt5-23f0be3aa648.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:6622::1:7])
 by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 B7dErHoRhW-eQl4jURv; Mon, 24 Aug 2020 11:40:27 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Dima Stepanov <dimastep@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/7] vhost: check queue state in the vhost_dev_set_log
 routine
Date: Mon, 24 Aug 2020 11:39:27 +0300
Message-Id: <a2eca26b79e1fcc30128a266bfa416237366c533.1598257838.git.dimastep@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1598257838.git.dimastep@yandex-team.ru>
References: <cover.1598257838.git.dimastep@yandex-team.ru>
In-Reply-To: <cover.1598257838.git.dimastep@yandex-team.ru>
References: <cover.1598257838.git.dimastep@yandex-team.ru>
Received-SPF: pass client-ip=2a02:6b8:0:1a2d::193;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1o.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, lvivier@redhat.com, thuth@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, fengli@smartx.com,
 yc-core@yandex-team.ru, pbonzini@redhat.com, raphael.norwitz@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the vhost-user-blk daemon provides only one virtqueue, but device was
added with several queues, then QEMU will send more VHOST-USER command
than expected by daemon side. The vhost_virtqueue_start() routine
handles such case by checking the return value from the
virtio_queue_get_desc_addr() function call. Add the same check to the
vhost_dev_set_log() routine.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
---
 hw/virtio/vhost.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index ffef7ab..a33ffd4 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -825,12 +825,24 @@ static int vhost_dev_set_features(struct vhost_dev *dev,
 static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
 {
     int r, i, idx;
+    hwaddr addr;
+
     r = vhost_dev_set_features(dev, enable_log);
     if (r < 0) {
         goto err_features;
     }
     for (i = 0; i < dev->nvqs; ++i) {
         idx = dev->vhost_ops->vhost_get_vq_index(dev, dev->vq_index + i);
+        addr = virtio_queue_get_desc_addr(dev->vdev, idx);
+        if (!addr) {
+            /*
+             * The queue might not be ready for start. If this
+             * is the case there is no reason to continue the process.
+             * The similar logic is used by the vhost_virtqueue_start()
+             * routine.
+             */
+            break;
+        }
         r = vhost_virtqueue_set_addr(dev, dev->vqs + i, idx,
                                      enable_log);
         if (r < 0) {
-- 
2.7.4


