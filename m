Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F68C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E757204EA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYrjrHri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E757204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joX2f-00036O-7H
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWvy-00089O-8T
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:49:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59954
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWvw-000105-JN
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593110951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kMFGIAe9F8Mx1E0ELN020rjYS3A4x5nkx01FgAd9ah8=;
 b=HYrjrHriCDSkcOn0MkTloLhUncUOCtsHX9HjKPKWaIB49FvqC/T+8/a4olEkHIldoGlHCR
 pM03oj2mv7O+/TIE/BW85mPzL5+olIyHHZaa5CAuirq2xcY8KQa8mYgEzODQQwWZwcdFKV
 oXDRjl4ZAjCGrGmpz0wXc9nraiFncwA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-Ysx1IbTnMWaYsYQvie3BYg-1; Thu, 25 Jun 2020 14:49:10 -0400
X-MC-Unique: Ysx1IbTnMWaYsYQvie3BYg-1
Received: by mail-wr1-f69.google.com with SMTP id y16so7681434wrr.20
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 11:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kMFGIAe9F8Mx1E0ELN020rjYS3A4x5nkx01FgAd9ah8=;
 b=ZZ8hPa6tc+Z0Jo/zj6sgvx4sFutY3Cj9Hw4Ze5Uj3ywXk67xNtd4HHxu2vNYtUNhwg
 ri7Zf48Kuf5wVecx6wERYexF6zuJ2XhvKKfdJSzZJVAQNUiYG0XdHFdVHHFkL3wItbiU
 ITFYDqlWWI3LZPsv+d11XuyBOgUljQx3h9aC3LDV54iKDhwjOcUVoiDBXH+aLU8qMmnX
 YT0qyxsK1io/7lfm17rN77fm+Ys8vEB5CORMSekgA5OUsSn4D8eS3Qc2h3WfZCUb06q/
 9ZxBsf3pcNlCz7Eu7TlstnnsAxXc/gDkFl7vfDcwsPSHtWercS1bNR8Hn2RA6f+ncw4T
 GWow==
X-Gm-Message-State: AOAM532P5GJpV+cfUHPVG+fSnkqGxQ2+fnDnv0P+8yEti1vmAm3gGA2v
 al6jQhFC/ewk5a2MpDWpxEplGjS9eST7LE4OjRxUH3kOnEn45OB9I+8reRodDrHVojiflFXrBLF
 A/auy16y9Tz1kESA=
X-Received: by 2002:adf:e701:: with SMTP id c1mr35470512wrm.350.1593110948671; 
 Thu, 25 Jun 2020 11:49:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZqCcd9hr13Iv6RBV39StHBd2PX84SsmW5r/RttbrT+dc/MtrAZzt386IwyUPEY0pXfHXCUg==
X-Received: by 2002:adf:e701:: with SMTP id c1mr35470500wrm.350.1593110948516; 
 Thu, 25 Jun 2020 11:49:08 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id a128sm3836778wmd.16.2020.06.25.11.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 11:49:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 06/17] block/nvme: Replace qemu_try_blockalign(bs) by
 qemu_try_memalign(pg_sz)
Date: Thu, 25 Jun 2020 20:48:27 +0200
Message-Id: <20200625184838.28172-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200625184838.28172-1-philmd@redhat.com>
References: <20200625184838.28172-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu_try_blockalign() is a generic API that call back to the
block driver to return its page alignment. As we call from
within the very same driver, we already know to page alignment
stored in our state. Remove indirections and use the value from
BDRVNVMeState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index bdddcd975d..cec9ace3dd 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -158,7 +158,7 @@ static void nvme_init_queue(BlockDriverState *bs, NVMeQueue *q,
 
     bytes = ROUND_UP(nentries * entry_bytes, s->page_size);
     q->head = q->tail = 0;
-    q->queue = qemu_try_blockalign(bs, bytes);
+    q->queue = qemu_try_memalign(s->page_size, bytes);
     if (!q->queue) {
         error_setg(errp, "Cannot allocate queue");
         return;
@@ -204,7 +204,7 @@ static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
     if (!q) {
         return NULL;
     }
-    q->prp_list_pages = qemu_try_blockalign(bs,
+    q->prp_list_pages = qemu_try_memalign(s->page_size,
                                           s->page_size * NVME_QUEUE_SIZE);
     if (!q->prp_list_pages) {
         goto fail;
@@ -451,7 +451,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     };
 
     idsz_max = MAX_CONST(sizeof(NvmeIdCtrl), sizeof(NvmeIdNs));
-    resp = qemu_try_blockalign(bs, idsz_max);
+    resp = qemu_try_memalign(s->page_size, idsz_max);
     if (!resp) {
         error_setg(errp, "Cannot allocate buffer for identify response");
         goto out;
@@ -1061,7 +1061,7 @@ static int nvme_co_prw(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
         return nvme_co_prw_aligned(bs, offset, bytes, qiov, is_write, flags);
     }
     trace_nvme_prw_buffered(s, offset, bytes, qiov->niov, is_write);
-    buf = qemu_try_blockalign(bs, bytes);
+    buf = qemu_try_memalign(s->page_size, bytes);
 
     if (!buf) {
         return -ENOMEM;
@@ -1205,7 +1205,7 @@ static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
 
     assert(s->nr_queues > 1);
 
-    buf = qemu_try_blockalign(bs, s->page_size);
+    buf = qemu_try_memalign(s->page_size, s->page_size);
     if (!buf) {
         return -ENOMEM;
     }
-- 
2.21.3


