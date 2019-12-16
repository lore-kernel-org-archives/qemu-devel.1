Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F133C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 02:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11FD62067C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 02:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FD62067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baidu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iggBV-0003Tg-2v
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 21:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lihangjing@baidu.com>) id 1iggAd-00033V-8S
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 21:31:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lihangjing@baidu.com>) id 1iggAX-0001BC-Bx
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 21:31:34 -0500
Received: from mx24.baidu.com ([111.206.215.185]:53500 helo=baidu.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <lihangjing@baidu.com>)
 id 1iggAW-0008SU-Ts; Sun, 15 Dec 2019 21:31:33 -0500
Received: from BC-Mail-Ex07.internal.baidu.com (unknown [172.31.51.47])
 by Forcepoint Email with ESMTPS id C89E09132E2D8EE03B4D;
 Mon, 16 Dec 2019 10:31:17 +0800 (CST)
Received: from BJHW-Mail-Ex03.internal.baidu.com (10.127.64.13) by
 BC-Mail-EX07.internal.baidu.com (172.31.51.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1531.3; Mon, 16 Dec 2019 10:31:17 +0800
Received: from DDAFF7EBB9FF247.internal.baidu.com (172.31.63.8) by
 BJHW-Mail-Ex03.internal.baidu.com (10.127.64.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 16 Dec 2019 10:31:17 +0800
From: Li hangjing <lihangjing@baidu.com>
To: <qemu-devel@nongnu.org>, <stefanha@redhat.com>
Subject: [PATCH] virtio-blk: fix out-of-bounds access to bitmap in
 notify_guest_bh
Date: Mon, 16 Dec 2019 10:30:50 +0800
Message-ID: <20191216023050.48620-1-lihangjing@baidu.com>
X-Mailer: git-send-email 2.15.1.windows.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex21.internal.baidu.com (172.31.51.15) To
 BJHW-Mail-Ex03.internal.baidu.com (10.127.64.13)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex03_2019-12-16 10:31:17:609
X-Baidu-BdMsfe-VirusCheck: BJHW-Mail-Ex03_GRAY_Inside_WithoutAtta_2019-12-16
 10:31:17:640
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex03_2019-12-16 10:31:17:672
X-Baidu-BdMsfe-DateCheck: 1_BC-Mail-Ex07_2019-12-16 10:31:17:787
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 111.206.215.185
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
Cc: lihangjing@baidu.com, xieyongji@baidu.com, qemu-stable@nongnu.org,
 chaiwen@baidu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Hangjing <lihangjing@baidu.com>

When the number of a virtio-blk device's virtqueues is larger than
BITS_PER_LONG, the out-of-bounds access to bitmap[ ] will occur.

Fixes: e21737ab15 ("virtio-blk: multiqueue batch notify")
Cc: qemu-stable@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Li Hangjing <lihangjing@baidu.com>
Reviewed-by: Xie Yongji <xieyongji@baidu.com>
Reviewed-by: Chai Wen <chaiwen@baidu.com>
---
 hw/block/dataplane/virtio-blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index 119906a5fe..1b52e8159c 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -67,7 +67,7 @@ static void notify_guest_bh(void *opaque)
     memset(s->batch_notify_vqs, 0, sizeof(bitmap));
 
     for (j = 0; j < nvqs; j += BITS_PER_LONG) {
-        unsigned long bits = bitmap[j];
+        unsigned long bits = bitmap[j / BITS_PER_LONG];
 
         while (bits != 0) {
             unsigned i = j + ctzl(bits);
-- 
2.15.1.windows.2


