Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944A1C31E44
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 00:54:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A2B721721
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 00:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2B721721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55996 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1harWb-0007Ez-Gx
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 20:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46849)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1harUf-0006EY-PZ
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 20:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1harMb-0004xP-6s
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 20:43:42 -0400
Received: from [192.146.154.1] (port=33243 helo=mcp01.nutanix.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1harMb-0004wx-1V
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 20:43:41 -0400
Received: from raphael-norwitz.dev.nutanix.com (unknown [10.41.25.241])
 by mcp01.nutanix.com (Postfix) with ESMTP id 849E1100941A;
 Wed, 12 Jun 2019 00:35:20 +0000 (UTC)
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 17:35:17 -0700
Message-Id: <1560299717-177734-1-git-send-email-raphael.norwitz@nutanix.com>
X-Mailer: git-send-email 1.9.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 192.146.154.1
Subject: [Qemu-devel] [PATCH] vhost-user-scsi: prevent using uninitialized
 vqs
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Of the 3 virtqueues, seabios only sets cmd, leaving ctrl
and event without a physical address. This can cause
vhost_verify_ring_part_mapping to return ENOMEM, causing
the following logs:

qemu-system-x86_64: Unable to map available ring for ring 0
qemu-system-x86_64: Verify ring failure on region 0

The qemu commit e6cc11d64fc998c11a4dfcde8fda3fc33a74d844
has already resolved the issue for vhost scsi devices but
the fix was never applied to vhost-user scsi devices.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 hw/scsi/vhost-user-scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index a9fd8ea..e4aae95 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -91,7 +91,7 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
     }
 
     vsc->dev.nvqs = 2 + vs->conf.num_queues;
-    vsc->dev.vqs = g_new(struct vhost_virtqueue, vsc->dev.nvqs);
+    vsc->dev.vqs = g_new0(struct vhost_virtqueue, vsc->dev.nvqs);
     vsc->dev.vq_index = 0;
     vsc->dev.backend_features = 0;
     vqs = vsc->dev.vqs;
-- 
1.9.4


