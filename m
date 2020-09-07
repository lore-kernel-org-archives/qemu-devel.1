Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C503EC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:13:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CE3A217BA
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KuaMuqQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE3A217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFF5U-0007rl-L5
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 07:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF22-0001qu-A7
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:09:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44300
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF20-0007rx-PN
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599476992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PX2fmYlA0yeGTtRzJFDSwPnCWCqOYxS3IScYZfCgZ2E=;
 b=KuaMuqQNr9lH+OqMp/3LAS5h2/dWBE/QWXVnJaIolkc6xQ4QZnZeuDHttE2LZznFxK21JF
 WePKn2ZmfuyxnC6hcSirhZO6l/Ir51L+/UyToNxnlOgSJ4uOMu9f72LgYgJ2/ZNFTr05gI
 YQ0c5c7noIDRrsCxyk922isOyIZlDIU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187--4V9dWKGMa6A92hQP7fQdw-1; Mon, 07 Sep 2020 07:09:48 -0400
X-MC-Unique: -4V9dWKGMa6A92hQP7fQdw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED307801ADA;
 Mon,  7 Sep 2020 11:09:46 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-154.ams2.redhat.com
 [10.36.114.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05B887E43B;
 Mon,  7 Sep 2020 11:09:45 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 04/64] block/nvme: Let nvme_create_queue_pair() fail gracefully
Date: Mon,  7 Sep 2020 13:08:36 +0200
Message-Id: <20200907110936.261684-5-kwolf@redhat.com>
In-Reply-To: <20200907110936.261684-1-kwolf@redhat.com>
References: <20200907110936.261684-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 02:54:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

As nvme_create_queue_pair() is allowed to fail, replace the
alloc() calls by try_alloc() to avoid aborting QEMU.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200821195359.1285345-4-philmd@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/nvme.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 4d4f728159..ca8b039f4f 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -213,14 +213,22 @@ static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
     int i, r;
     BDRVNVMeState *s = bs->opaque;
     Error *local_err = NULL;
-    NVMeQueuePair *q = g_new0(NVMeQueuePair, 1);
+    NVMeQueuePair *q;
     uint64_t prp_list_iova;
 
+    q = g_try_new0(NVMeQueuePair, 1);
+    if (!q) {
+        return NULL;
+    }
+    q->prp_list_pages = qemu_try_blockalign0(bs,
+                                          s->page_size * NVME_NUM_REQS);
+    if (!q->prp_list_pages) {
+        goto fail;
+    }
     qemu_mutex_init(&q->lock);
     q->s = s;
     q->index = idx;
     qemu_co_queue_init(&q->free_req_queue);
-    q->prp_list_pages = qemu_blockalign0(bs, s->page_size * NVME_NUM_REQS);
     q->completion_bh = aio_bh_new(bdrv_get_aio_context(bs),
                                   nvme_process_completion_bh, q);
     r = qemu_vfio_dma_map(s->vfio, q->prp_list_pages,
-- 
2.25.4


