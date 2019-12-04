Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FABEC0044D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 07:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 249132084F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 07:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249132084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icPUv-0007uz-7k
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 02:54:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1icPAE-0001jW-8R
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 02:33:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1icPAD-0001By-4G
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 02:33:34 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60714 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1icPAB-00016g-2Y
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 02:33:31 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id C67153C20B4AC2A03616;
 Wed,  4 Dec 2019 15:33:25 +0800 (CST)
Received: from HGHY2P002143101.china.huawei.com (10.184.39.213) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Wed, 4 Dec 2019 15:33:15 +0800
From: <pannengyuan@huawei.com>
To: <mst@redhat.com>
Subject: [PATCH v2 2/3] virtio-balloon: fix memory leak while attach
 virtio-balloon device
Date: Wed, 4 Dec 2019 15:31:55 +0800
Message-ID: <1575444716-17632-2-git-send-email-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.7.2.windows.1
In-Reply-To: <1575444716-17632-1-git-send-email-pannengyuan@huawei.com>
References: <1575444716-17632-1-git-send-email-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.39.213]
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
Cc: liyiting@huawei.com, kuhn.chenqun@huawei.com,
 Pan Nengyuan <pannengyuan@huawei.com>, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

ivq/dvq/svq/free_page_vq is forgot to cleanup in
virtio_balloon_device_unrealize, the memory leak stack is as follow:

Direct leak of 14336 byte(s) in 2 object(s) allocated from:
    #0 0x7f99fd9d8560 in calloc (/usr/lib64/libasan.so.3+0xc7560)
    #1 0x7f99fcb20015 in g_malloc0 (/usr/lib64/libglib-2.0.so.0+0x50015)
    #2 0x557d90638437 in virtio_add_queue hw/virtio/virtio.c:2327
    #3 0x557d9064401d in virtio_balloon_device_realize hw/virtio/virtio-balloon.c:793
    #4 0x557d906356f7 in virtio_device_realize hw/virtio/virtio.c:3504
    #5 0x557d9073f081 in device_set_realized hw/core/qdev.c:876
    #6 0x557d908b1f4d in property_set_bool qom/object.c:2080
    #7 0x557d908b655e in object_property_set_qobject qom/qom-qobject.c:26

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
Change v2 to v1:
- use virtio_delete_queue to cleanup vq through a vq pointer (suggested by
  Michael S. Tsirkin)
---
 hw/virtio/virtio-balloon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 40b04f5..57f3b9f 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -831,6 +831,13 @@ static void virtio_balloon_device_unrealize(DeviceState *dev, Error **errp)
     }
     balloon_stats_destroy_timer(s);
     qemu_remove_balloon_handler(s);
+
+    virtio_delete_queue(s->ivq);
+    virtio_delete_queue(s->dvq);
+    virtio_delete_queue(s->svq);
+    if (s->free_page_vq) {
+        virtio_delete_queue(s->free_page_vq);
+    }
     virtio_cleanup(vdev);
 }
 
-- 
2.7.2.windows.1



