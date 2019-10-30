Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1F2CA9EAF
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 08:14:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3855E218DE
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 08:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3855E218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPj7x-0003GP-E8
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 04:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wang.yi59@zte.com.cn>) id 1iPj7J-0002b0-KR
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 04:14:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wang.yi59@zte.com.cn>) id 1iPj7H-00013c-Q3
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 04:14:09 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:41000 helo=mxct.zte.com.cn)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wang.yi59@zte.com.cn>)
 id 1iPj7H-0000gm-EJ
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 04:14:07 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
 by Forcepoint Email with ESMTPS id AC843CB086ADFCEB0E4D;
 Wed, 30 Oct 2019 16:07:04 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
 by mse-fl2.zte.com.cn with ESMTP id x9U86pDr077982;
 Wed, 30 Oct 2019 16:06:51 +0800 (GMT-8)
 (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2019103016071191-197903 ;
 Wed, 30 Oct 2019 16:07:11 +0800 
From: Yi Wang <wang.yi59@zte.com.cn>
To: mst@redhat.com
Subject: [PATCH] virtio: add check for inconsistent VQ in virtio_save()
Date: Wed, 30 Oct 2019 16:09:47 +0800
Message-Id: <1572422987-19683-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2019-10-30 16:07:11,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-10-30 16:06:54, Serialize complete at 2019-10-30 16:06:54
X-MAIL: mse-fl2.zte.com.cn x9U86pDr077982
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 202.103.147.172
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
Cc: wang.yi59@zte.com.cn, wang.liang82@zte.com.cn,
 Cheng Lin <cheng.lin130@zte.com.cn>, qemu-devel@nongnu.org,
 xue.zhihong@zte.com.cn
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cheng Lin <cheng.lin130@zte.com.cn>

In a case, we have an not enabled VQ (virtio-net) which desc is NULL
and get a last_avail_idx is not 0 from dpdk.

As a result, it is successed to create a snapshot, but failed to revert it.
Because in virtio_load(), there is an inconsistent check for VQ.
(call virtio_load() in revert, and virtio_save() in create.)

Correspondly, in virtio_save() should also do this check to find the error
as early as possible.

Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
---
 hw/virtio/virtio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 2e91dec..eadbf64 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2792,6 +2792,12 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
          * Save desc now, the rest of the ring addresses are saved in
          * subsections for VIRTIO-1 devices.
          */
+        if (!vdev->vq[i].vring.desc && vdev->vq[i].last_avail_idx) {
+            error_report("VQ %d address 0x0 "
+                         "inconsistent with Host index 0x%x",
+                         i, vdev->vq[i].last_avail_idx);
+            return -1;
+        }
         qemu_put_be64(f, vdev->vq[i].vring.desc);
         qemu_put_be16s(f, &vdev->vq[i].last_avail_idx);
         if (k->save_queue) {
-- 
2.7.2.windows.1


