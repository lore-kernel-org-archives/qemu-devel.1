Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C4DC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 06:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DCBF2053B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 06:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCBF2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isKqR-0002ys-Ae
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 01:10:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1isKpP-0001zg-Lk
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 01:09:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1isKpM-0005m9-7T
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 01:09:55 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2682 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1isKpL-0005jS-T1
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 01:09:52 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 2714B9DA85DC519D696C;
 Fri, 17 Jan 2020 14:09:48 +0800 (CST)
Received: from DESKTOP-9NTIQGG.china.huawei.com (10.173.221.136) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Fri, 17 Jan 2020 14:09:37 +0800
From: <pannengyuan@huawei.com>
To: <mst@redhat.com>, <groug@kaod.org>
Subject: [PATCH v2 1/2] virtio-9p-device: fix memleak in
 virtio_9p_device_unrealize
Date: Fri, 17 Jan 2020 14:09:26 +0800
Message-ID: <20200117060927.51996-2-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200117060927.51996-1-pannengyuan@huawei.com>
References: <20200117060927.51996-1-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.136]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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

v->vq forgot to cleanup in virtio_9p_device_unrealize, the memory leak
stack is as follow:

Direct leak of 14336 byte(s) in 2 object(s) allocated from:
  #0 0x7f819ae43970 (/lib64/libasan.so.5+0xef970)  ??:?
  #1 0x7f819872f49d (/lib64/libglib-2.0.so.0+0x5249d)  ??:?
  #2 0x55a3a58da624 (./x86_64-softmmu/qemu-system-x86_64+0x2c14624)  /mnt=
/sdb/qemu/hw/virtio/virtio.c:2327
  #3 0x55a3a571bac7 (./x86_64-softmmu/qemu-system-x86_64+0x2a55ac7)  /mnt=
/sdb/qemu/hw/9pfs/virtio-9p-device.c:209
  #4 0x55a3a58e7bc6 (./x86_64-softmmu/qemu-system-x86_64+0x2c21bc6)  /mnt=
/sdb/qemu/hw/virtio/virtio.c:3504
  #5 0x55a3a5ebfb37 (./x86_64-softmmu/qemu-system-x86_64+0x31f9b37)  /mnt=
/sdb/qemu/hw/core/qdev.c:876

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
Changes V2 to V1:
- use old function virtio_del_queue to make it easier for stable branch
to merge (suggested by Christian Schoenebeck)
---
 hw/9pfs/virtio-9p-device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index b5a7c03f26..910dc5045e 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -215,6 +215,7 @@ static void virtio_9p_device_unrealize(DeviceState *d=
ev, Error **errp)
     V9fsVirtioState *v =3D VIRTIO_9P(dev);
     V9fsState *s =3D &v->state;
=20
+    virtio_del_queue(vdev, 0);
     virtio_cleanup(vdev);
     v9fs_device_unrealize_common(s, errp);
 }
--=20
2.21.0.windows.1



