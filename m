Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667A8C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:51:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F2420774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ee1cUGlo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F2420774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5vqi-0001fe-DP
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 14:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5vpg-0008Eq-8W
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:50:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50526
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5vpe-0004cZ-II
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597258237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KdE6JsIw8dAhfeVIz93JjPSKDmry/14DEkZ0JE7PkKI=;
 b=Ee1cUGlo6yaPlsg1lGDro5rXH1eIov6lw3z2Zlz5rbAhU/dcQ7RvyKhJga54Hk4LEPLYaT
 qu3UvGKWe+w5LhTOxtBWuHFWNA13f8nZ2rKaBg2U9KLacALsTEt4DCkuJk6I7Ys2RP3Unh
 0xoGm2xICe40157f0mGMAKz/cdnW2JU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-4PT-R6mRNJO79Ga6YvfN3g-1; Wed, 12 Aug 2020 14:50:35 -0400
X-MC-Unique: 4PT-R6mRNJO79Ga6YvfN3g-1
Received: by mail-wr1-f72.google.com with SMTP id o10so1216133wrs.21
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 11:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KdE6JsIw8dAhfeVIz93JjPSKDmry/14DEkZ0JE7PkKI=;
 b=m0w263zOqblybzLCBAsIAjfniSJy/DE5SF0fBF3QSLqoPpCO94LO5qvIgjmeWCjWjT
 2CCMTmPD90IBAFGZ7pEyg6MUvwXxYtt3RbwAKaNTFSluFMJMK+m32T4ai12mxbUtTbI2
 36eRLI5nVdWYwnq0KKjUOtuAKmF0AMi6eteKPKJyZboEfX8UmyZZYni9Dymy7pdw1wbY
 sEKH6gRLdHjr2DakPrFf8/TbAsAicrdXFbM7xgKEmLRJ46kpfijzP3yFi52XY3yUHkKH
 G38gUCBR3Vxk39n7AoBFqsJR6Yn0i+nJRTl05y/GhphaZN0lynO2zrl/X7dptJNqk7Vo
 tfkA==
X-Gm-Message-State: AOAM533opauQKUf7TDSA/H8NF8nmlgXirNTO5mY19pGDtRVbFdmcrT6V
 T2+7dlGKioTGXb9WWU9lPwRzOck2Vm9Ydr6FnGmQIigD9CH6xXCimiWrD54zoosg9qoNSszqZby
 0CA+h9Rz/sVdwD48=
X-Received: by 2002:a1c:b6c4:: with SMTP id g187mr856368wmf.149.1597258234180; 
 Wed, 12 Aug 2020 11:50:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwH+WSxwaIsIMZgjZBqE7qkEXnw1TmzlQbnC8G4zDELwtT/LimrLyVTmEp4fxE5/H0sEvvXHA==
X-Received: by 2002:a1c:b6c4:: with SMTP id g187mr856359wmf.149.1597258234036; 
 Wed, 12 Aug 2020 11:50:34 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id m8sm5249145wro.75.2020.08.12.11.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 11:50:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 03/14] block/nvme: Let nvme_create_queue_pair() fail
 gracefully
Date: Wed, 12 Aug 2020 20:50:03 +0200
Message-Id: <20200812185014.18267-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200812185014.18267-1-philmd@redhat.com>
References: <20200812185014.18267-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
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

As nvme_create_queue_pair() is allowed to fail, replace the
alloc() calls by try_alloc() to avoid aborting QEMU.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 8c30a5fee2..e1893b4e79 100644
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
+                                          s->page_size * NVME_QUEUE_SIZE);
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
2.21.3


