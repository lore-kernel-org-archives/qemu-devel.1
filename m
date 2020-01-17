Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3096CC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:57:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 055042073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055042073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isMVY-00079u-Qj
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 02:57:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1isMUH-0005Ol-Fv
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1isMUF-0006Z1-CY
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:56:13 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2738 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1isMUF-0006WR-0o
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:56:11 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 87C81BE1F8C51382B902;
 Fri, 17 Jan 2020 15:56:06 +0800 (CST)
Received: from DESKTOP-9NTIQGG.china.huawei.com (10.173.221.136) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Fri, 17 Jan 2020 15:55:54 +0800
From: <pannengyuan@huawei.com>
To: <mst@redhat.com>, <pbonzini@redhat.com>, <fam@euphon.net>
Subject: [PATCH 1/2] virtio-scsi: delete vqs in unrealize to avoid memleaks
Date: Fri, 17 Jan 2020 15:55:46 +0800
Message-ID: <20200117075547.60864-2-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200117075547.60864-1-pannengyuan@huawei.com>
References: <20200117075547.60864-1-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.136]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: Euler Robot <euler.robot@huawei.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

This patch fix memleaks when attaching/detaching virtio-scsi device, the
memory leak stack is as follow:

Direct leak of 21504 byte(s) in 3 object(s) allocated from:
  #0 0x7f491f2f2970 (/lib64/libasan.so.5+0xef970)  ??:?
  #1 0x7f491e94649d (/lib64/libglib-2.0.so.0+0x5249d)  ??:?
  #2 0x564d0f3919fa (./x86_64-softmmu/qemu-system-x86_64+0x2c3e9fa)  /mnt=
/sdb/qemu/hw/virtio/virtio.c:2333
  #3 0x564d0f2eca55 (./x86_64-softmmu/qemu-system-x86_64+0x2b99a55)  /mnt=
/sdb/qemu/hw/scsi/virtio-scsi.c:912
  #4 0x564d0f2ece7b (./x86_64-softmmu/qemu-system-x86_64+0x2b99e7b)  /mnt=
/sdb/qemu/hw/scsi/virtio-scsi.c:924
  #5 0x564d0f39ee47 (./x86_64-softmmu/qemu-system-x86_64+0x2c4be47)  /mnt=
/sdb/qemu/hw/virtio/virtio.c:3531
  #6 0x564d0f980224 (./x86_64-softmmu/qemu-system-x86_64+0x322d224)  /mnt=
/sdb/qemu/hw/core/qdev.c:865

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
 hw/scsi/virtio-scsi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 4bc73a370e..858b3aaccb 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -943,7 +943,13 @@ void virtio_scsi_common_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
     VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
+    int i;
=20
+    virtio_del_queue(vdev, 0);
+    virtio_del_queue(vdev, 1);
+    for (i =3D 0; i < vs->conf.num_queues; i++) {
+        virtio_del_queue(vdev, i + 2);
+    }
     g_free(vs->cmd_vqs);
     virtio_cleanup(vdev);
 }
--=20
2.21.0.windows.1



