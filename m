Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837BCC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 04:41:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55DB920716
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 04:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55DB920716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHgoe-0002Zs-Gl
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 00:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1jHgnp-0001hA-1d
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 00:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1jHgnn-0003CN-Qt
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 00:41:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43142 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1jHgnn-00033l-Fx
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 00:41:03 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 449544A81CAF0EEFD45A;
 Fri, 27 Mar 2020 12:40:58 +0800 (CST)
Received: from localhost.huawei.com (10.175.104.216) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Fri, 27 Mar 2020 12:40:52 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2 2/2] virtio-iommu: delete vqs in unrealize to fix memleak
Date: Fri, 27 Mar 2020 12:56:20 +0800
Message-ID: <20200327045620.9082-3-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200327045620.9082-1-pannengyuan@huawei.com>
References: <20200327045620.9082-1-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.216]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: Eric Auger <eric.auger@redhat.com>, euler.robot@huawei.com,
 Pan Nengyuan <pannengyuan@huawei.com>, zhang.zhanghailiang@huawei.com,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

req_vq/event_vq forgot to free in unrealize. Fix that.

Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
Cc: Eric Auger <eric.auger@redhat.com>
---
 hw/virtio/virtio-iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 4cee8083bc..9d2ff0693c 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -696,6 +696,8 @@ static void virtio_iommu_device_unrealize(DeviceState *dev, Error **errp)
     g_tree_destroy(s->domains);
     g_tree_destroy(s->endpoints);
 
+    virtio_delete_queue(s->req_vq);
+    virtio_delete_queue(s->event_vq);
     virtio_cleanup(vdev);
 }
 
-- 
2.18.2


