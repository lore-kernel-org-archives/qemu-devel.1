Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A04EC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA70E2072D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6zVdcFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA70E2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9D9q-00039a-1m
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 15:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9D7I-0006b6-4N
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:54:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55808
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9D7G-0002fp-Ia
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598039661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3lqHxzXh/lLTVxijpUS4Uwli7GjtQ2LdijRLIbNHx/E=;
 b=h6zVdcFhhblpK9sJ9AVbaQ6Ot2O6Gr00Kb8zw39flcLBAzKfoqSM4OQDOfWYc4AOKcSy/N
 QcOkpfOV5GH3YoaSoepXidCUh9Bbt9T5hPLQjQTNxfKoo3pMIwfrx1yiPfQorTEOzXyBlG
 cOxeh3yNVi+55OmhZm2R92IffKh+x1Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-ew029iKJObeiDAEqWM-Xjw-1; Fri, 21 Aug 2020 15:54:19 -0400
X-MC-Unique: ew029iKJObeiDAEqWM-Xjw-1
Received: by mail-wr1-f70.google.com with SMTP id l14so904913wrp.9
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 12:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3lqHxzXh/lLTVxijpUS4Uwli7GjtQ2LdijRLIbNHx/E=;
 b=oYzBr7zfh/o0rNunrYfIkCH4p/mEEgjTfNYuCfIwJH+vUfL15JKrVNAKFob8gaH15E
 +mDTuy5v1inX0C3Sw+/ws2W1mzfHIt2jH9TGB1Kv6U7Xm/HJBU6G2Gwua2sY5n3X4V/w
 tks6NslmknswUHWlDCjBaKPlGi52jj/B7EL7PGTmEZzQeoX4dEqKAvYt8G067JLXGDqC
 CGrgvymbi/LTc2A0aQXi/X4hC8RsAzdKIdOdEHFOX+2075H4fqbivmiYbhyiV1+mvU6f
 CKt8yb0skI6ESTHYlxt5G+tKa5j4lcRWx1Pbc4Xix43zGbSv57dqRoiy2592XvxmKJ+g
 ZnoA==
X-Gm-Message-State: AOAM5315XrEfFEn6HaP2kD+gqdQkHvehvA77LytDosY6b7lDEeu9bvp+
 Nr4Xus5DvnWdxAfv6hx85LbKtiFMsNTiFrDJCxK6EqmStZOmfurrXVv3Uhd2oKMX7FgmDAkHyOa
 o6WAN4Fe3Dz3xVec=
X-Received: by 2002:a5d:6348:: with SMTP id b8mr4014930wrw.362.1598039658339; 
 Fri, 21 Aug 2020 12:54:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWiZLnWDYHHdpRqC3K0ok/pfI8IjezKPPXbRz6Kir7dS5BmYBBoS0KzcNcyp4AXd5qchq9CA==
X-Received: by 2002:a5d:6348:: with SMTP id b8mr4014912wrw.362.1598039658133; 
 Fri, 21 Aug 2020 12:54:18 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id x133sm7604709wmg.39.2020.08.21.12.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 12:54:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 03/15] block/nvme: Let nvme_create_queue_pair() fail
 gracefully
Date: Fri, 21 Aug 2020 21:53:47 +0200
Message-Id: <20200821195359.1285345-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821195359.1285345-1-philmd@redhat.com>
References: <20200821195359.1285345-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 01:00:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As nvme_create_queue_pair() is allowed to fail, replace the
alloc() calls by try_alloc() to avoid aborting QEMU.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 8c30a5fee28..a6e5537aaaf 100644
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
2.26.2


