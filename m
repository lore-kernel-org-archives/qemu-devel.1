Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AFCC35DF8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 07:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1F5521744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 07:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F5521744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Uqw-0001tu-0l
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 02:42:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j6Upm-00009J-9Y
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:40:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j6Upl-0003dx-6p
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:40:50 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:55772 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j6Upk-0003dM-RH
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:40:49 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id ADAF1A2DFF4E42C25089;
 Tue, 25 Feb 2020 15:40:46 +0800 (CST)
Received: from localhost.localdomain (10.175.104.216) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Tue, 25 Feb 2020 15:40:38 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <mst@redhat.com>
Subject: [PATCH 4/4] virtio-crypto: do delete ctrl_vq in
 virtio_crypto_device_unrealize
Date: Tue, 25 Feb 2020 15:55:54 +0800
Message-ID: <20200225075554.10835-5-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200225075554.10835-1-pannengyuan@huawei.com>
References: <20200225075554.10835-1-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.216]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: "Gonglei \(Arei\)" <arei.gonglei@huawei.com>, euler.robot@huawei.com,
 Pan Nengyuan <pannengyuan@huawei.com>, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similar to other virtio-deivces, ctrl_vq forgot to delete in virtio_crypto_device_unrealize, this patch fix it.
This device has aleardy maintained vq pointers. Thus, we use the new virtio_delete_queue function directly to do the cleanup.

The leak stack:
Direct leak of 10752 byte(s) in 3 object(s) allocated from:
    #0 0x7f4c024b1970 in __interceptor_calloc (/lib64/libasan.so.5+0xef970)
    #1 0x7f4c018be49d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
    #2 0x55a2f8017279 in virtio_add_queue /mnt/sdb/qemu-new/qemu_test/qemu/hw/virtio/virtio.c:2333
    #3 0x55a2f8057035 in virtio_crypto_device_realize /mnt/sdb/qemu-new/qemu_test/qemu/hw/virtio/virtio-crypto.c:814
    #4 0x55a2f8005d80 in virtio_device_realize /mnt/sdb/qemu-new/qemu_test/qemu/hw/virtio/virtio.c:3531
    #5 0x55a2f8497d1b in device_set_realized /mnt/sdb/qemu-new/qemu_test/qemu/hw/core/qdev.c:891
    #6 0x55a2f8b48595 in property_set_bool /mnt/sdb/qemu-new/qemu_test/qemu/qom/object.c:2238
    #7 0x55a2f8b54fad in object_property_set_qobject /mnt/sdb/qemu-new/qemu_test/qemu/qom/qom-qobject.c:26
    #8 0x55a2f8b4de2c in object_property_set_bool /mnt/sdb/qemu-new/qemu_test/qemu/qom/object.c:1390
    #9 0x55a2f80609c9 in virtio_crypto_pci_realize /mnt/sdb/qemu-new/qemu_test/qemu/hw/virtio/virtio-crypto-pci.c:58

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>
---
 hw/virtio/virtio-crypto.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 7351ab0a19..4c65114de5 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -831,12 +831,13 @@ static void virtio_crypto_device_unrealize(DeviceState *dev, Error **errp)
 
     max_queues = vcrypto->multiqueue ? vcrypto->max_queues : 1;
     for (i = 0; i < max_queues; i++) {
-        virtio_del_queue(vdev, i);
+        virtio_delete_queue(vcrypto->vqs[i].dataq);
         q = &vcrypto->vqs[i];
         qemu_bh_delete(q->dataq_bh);
     }
 
     g_free(vcrypto->vqs);
+    virtio_delete_queue(vcrypto->ctrl_vq);
 
     virtio_cleanup(vdev);
     cryptodev_backend_set_used(vcrypto->cryptodev, false);
-- 
2.18.2


