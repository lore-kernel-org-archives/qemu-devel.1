Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478CDC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 01:20:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F1C12146E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 01:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1C12146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibaOB-0007eg-86
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 20:20:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1ibaNW-0007AA-Su
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 20:19:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1ibaNV-0000RV-J2
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 20:19:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2204 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1ibaNV-0000LG-7F
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 20:19:53 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 6EC64E21F0F5C89F5AD2;
 Mon,  2 Dec 2019 09:19:46 +0800 (CST)
Received: from HGHY2P002143101.china.huawei.com (10.184.39.213) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Mon, 2 Dec 2019 09:19:38 +0800
From: <pannengyuan@huawei.com>
To: <kraxel@redhat.com>, <mst@redhat.com>
Subject: [PATCH] virtio-input: fix memory leak in
 virtio_input_device_unrealize()
Date: Mon, 2 Dec 2019 09:19:28 +0800
Message-ID: <1575249568-52136-1-git-send-email-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.7.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
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
Cc: liyiting@huawei.com, kuhn.chenqun@huawei.com,
 PanNengyuan <pannengyuan@huawei.com>, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: PanNengyuan <pannengyuan@huawei.com>

vdev->vq[i] is forgot to cleanup in
virtio_input_device_unrealize, the memory leak stack is as bellow:

Direct leak of 3584 byte(s) in 1 object(s) allocated from:
    #0 0x7f84a49f6560 in calloc (/usr/lib64/libasan.so.3+0xc7560)
    #1 0x7f84a3b3e015 in g_malloc0 (/usr/lib64/libglib-2.0.so.0+0x50015)
    #2 0x559c0f0b33e7 in virtio_add_queue /mnt/sdb/qemu-4.2.0-rc0/hw/virtio/virtio.c:2327
    #3 0x559c0f205c24 in virtio_input_device_realize /mnt/sdb/qemu-4.2.0-rc0/hw/input/virtio-input.c:262
    #4 0x559c0f0b06a7 in virtio_device_realize /mnt/sdb/qemu-4.2.0-rc0/hw/virtio/virtio.c:3504
    #5 0x559c0f1ba031 in device_set_realized  /mnt/sdb/qemu-4.2.0-rc0/hw/core/qdev.c:876
    #6 0x559c0f32cedd in property_set_bool /mnt/sdb/qemu-4.2.0-rc0/qom/object.c:2080
    #7 0x559c0f3314ee in object_property_set_qobject /mnt/sdb/qemu-4.2.0-rc0/qom/qom-qobject.c:26

Direct leak of 3584 byte(s) in 1 object(s) allocated from:
    #0 0x7f84a49f6560 in calloc (/usr/lib64/libasan.so.3+0xc7560)
    #1 0x7f84a3b3e015 in g_malloc0 (/usr/lib64/libglib-2.0.so.0+0x50015)
    #2 0x559c0f0b33e7 in virtio_add_queue /mnt/sdb/qemu-4.2.0-rc0/hw/virtio/virtio.c:2327
    #3 0x559c0f205c3f in virtio_input_device_realize /mnt/sdb/qemu-4.2.0-rc0/hw/input/virtio-input.c:263
    #4 0x559c0f0b06a7 in virtio_device_realize /mnt/sdb/qemu-4.2.0-rc0/hw/virtio/virtio.c:3504
    #5 0x559c0f1ba031 in device_set_realized /mnt/sdb/qemu-4.2.0-rc0/hw/core/qdev.c:876
    #6 0x559c0f32cedd in property_set_bool /mnt/sdb/qemu-4.2.0-rc0/qom/object.c:2080
    #7 0x559c0f3314ee in object_property_set_qobject /mnt/sdb/qemu-4.2.0-rc0/qom/qom-qobject.c:26

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: PanNengyuan <pannengyuan@huawei.com>
---
 hw/input/virtio-input.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index 51617a5..da94da4 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -288,6 +288,9 @@ static void virtio_input_device_unrealize(DeviceState *dev, Error **errp)
             return;
         }
     }
+    
+    virtio_del_queue(vdev, 0);
+    virtio_del_queue(vdev, 1);
     virtio_cleanup(vdev);
 }
 
-- 
2.7.2.windows.1



