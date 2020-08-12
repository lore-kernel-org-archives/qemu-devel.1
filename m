Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A82C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D60132080C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFK8obzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60132080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5vst-0006zW-0Q
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 14:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5vqS-0001Zu-JO
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:51:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54964
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5vqQ-0004iy-Sl
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597258286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VEUrcl7BjVjnko2JLqVVNTkVRJAa4/7WyKfrp+mSwaU=;
 b=AFK8obzw94FC0a5vr8AtYUqRLfIZlX3o+ffzQEWzIs8+qX4VfTrNP02oK6Jn8C5q7Z9Fuq
 472YCC9Lqu99gXVd7ofr63GAPdQuae/WeUSJZ62+3LyRVQKyQtDi1vRGiGMkCbEmvb67tU
 9aQ6XZlWepK6PMjyrMP1MN77jtd6Zww=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-Dr7skakVPhqIFLV32tcLmQ-1; Wed, 12 Aug 2020 14:51:24 -0400
X-MC-Unique: Dr7skakVPhqIFLV32tcLmQ-1
Received: by mail-wm1-f72.google.com with SMTP id s4so972451wmh.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 11:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VEUrcl7BjVjnko2JLqVVNTkVRJAa4/7WyKfrp+mSwaU=;
 b=qwzNS4GiIy4EAnFMmfWyku1SYnVsShdMxzSJjagAix8iRP0HPAl0NrnCLOdn2At1h2
 Gq8EiNXZ9ihbovy4S5vTyh8fXWfYw2TPRBv+Y1vcx8S7cfexfttZjaA8WSDioHluYwxI
 SE+msSVaAJFcLRQDIpbk6K9O05LaUb+U+c60aRtwL79gcfcDOM/qYpVCyUB/LSHOInjc
 4asH0qWfTsYVuWOHtWFQ7FSOC9f5XpcDoGEfwmc/wDICZO5fI2NfrnOObjv8yhwEwhf7
 CUULAphN14sgE6Vj/9uTx0yAHHtpbD+5KkoUdS2dIcD99GnHTRIk72J0sOzLK86SOq7m
 K8JQ==
X-Gm-Message-State: AOAM531y7bxXHspZu3LpzSkNJ59JK/VFlPhxsihRNcZxGbyI8If3hdUm
 28/nD33MSWR7qVJ663JIx3tPjIv8jhcxgcGZCl18W0Zb/JejvGJWxcqfe8k2Nb8I36efF/yfExa
 4xoxq3FzRLc3vE/4=
X-Received: by 2002:a1c:720d:: with SMTP id n13mr918160wmc.103.1597258283234; 
 Wed, 12 Aug 2020 11:51:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJHkGM5+H6h+VHMtkdgJGVeveIsSBtafSFspF4zvZ+XTVbrvbufzrTkrVQY+biacIVeiODsg==
X-Received: by 2002:a1c:720d:: with SMTP id n13mr918150wmc.103.1597258283061; 
 Wed, 12 Aug 2020 11:51:23 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 130sm5231502wme.26.2020.08.12.11.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 11:51:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 13/14] block/nvme: Simplify nvme_create_queue_pair()
 arguments
Date: Wed, 12 Aug 2020 20:50:13 +0200
Message-Id: <20200812185014.18267-14-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200812185014.18267-1-philmd@redhat.com>
References: <20200812185014.18267-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 10:32:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

nvme_create_queue_pair() doesn't require BlockDriverState anymore.
Replace it by BDRVNVMeState and AioContext to simplify.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 456fe61f5e..1f67e888c8 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -208,12 +208,12 @@ static void nvme_free_req_queue_cb(void *opaque)
     qemu_mutex_unlock(&q->lock);
 }
 
-static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
+static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
+                                             AioContext *aio_context,
                                              int idx, int size,
                                              Error **errp)
 {
     int i, r;
-    BDRVNVMeState *s = bs->opaque;
     Error *local_err = NULL;
     NVMeQueuePair *q;
     uint64_t prp_list_iova;
@@ -232,8 +232,7 @@ static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
     q->s = s;
     q->index = idx;
     qemu_co_queue_init(&q->free_req_queue);
-    q->completion_bh = aio_bh_new(bdrv_get_aio_context(bs),
-                                  nvme_process_completion_bh, q);
+    q->completion_bh = aio_bh_new(aio_context, nvme_process_completion_bh, q);
     r = qemu_vfio_dma_map(s->vfio, q->prp_list_pages,
                           s->page_size * NVME_NUM_REQS,
                           false, &prp_list_iova);
@@ -637,7 +636,8 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
     NvmeCmd cmd;
     int queue_size = NVME_QUEUE_SIZE;
 
-    q = nvme_create_queue_pair(bs, n, queue_size, errp);
+    q = nvme_create_queue_pair(s, bdrv_get_aio_context(bs),
+                               n, queue_size, errp);
     if (!q) {
         return false;
     }
@@ -683,6 +683,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
                      Error **errp)
 {
     BDRVNVMeState *s = bs->opaque;
+    AioContext *aio_context = bdrv_get_aio_context(bs);
     int ret;
     uint64_t cap;
     uint64_t timeout_ms;
@@ -743,7 +744,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
 
     /* Set up admin queue. */
     s->queues = g_new(NVMeQueuePair *, 1);
-    s->queues[INDEX_ADMIN] = nvme_create_queue_pair(bs, 0,
+    s->queues[INDEX_ADMIN] = nvme_create_queue_pair(s, aio_context, 0,
                                                           NVME_QUEUE_SIZE,
                                                           errp);
     if (!s->queues[INDEX_ADMIN]) {
-- 
2.21.3


