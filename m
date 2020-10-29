Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE0CC55178
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BC372076B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cg5uRFWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC372076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY4S8-0001dH-2X
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 05:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4Jz-0006RA-Mg
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:34:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4Jw-0006cM-Jb
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:34:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603964051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kaU4zZuJB4tESn4H6GCPctUQ4pXRnoC4EnBxMdQNjsg=;
 b=Cg5uRFWqOQAwrfYSnxEX26TGHaNuCV0osUcgeFtPPjcJ2o/lXkhqF/hQnABjcnXgb43eEM
 mrHhJn3zO14ojJ3KilXOIc/scm5TzCVcIkrPpcZZCP6hILg8FlQmGxclyzIbAI2Vq5RBHr
 R+VfHpcuh11K2XX42hZ0Boo/VKpy82c=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-HVuzqqCJPQWDKQxTkQSi4g-1; Thu, 29 Oct 2020 05:34:10 -0400
X-MC-Unique: HVuzqqCJPQWDKQxTkQSi4g-1
Received: by mail-ej1-f69.google.com with SMTP id x12so919020eju.22
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 02:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kaU4zZuJB4tESn4H6GCPctUQ4pXRnoC4EnBxMdQNjsg=;
 b=KhZeraOpZQx2+NfDhdc7QZ0yKPDsx8L2IgrudWMTVOeZnNyXXIEomOpWsO4cdZ9SCD
 MSoud+I0PHV1BukIMTf7+vElT0Iwk51Ts7vH1cktiOt5UF1NUjBdSrg4NKOTclk5Fb73
 JRx5pOFvUMAt4aTdPVCEU8YJb+G0TzXHafKS8fJy1T91f8HnrfoCP9qp3fGE/InMDcKo
 +0RHXop6CC0v8zugEwYOirv+b7pbZKclthxk4Fll+Bv4pHeKZzC5R9fQHqYbmzqjqk9K
 8nl95PWQdCwqu0Sj4nuPosKGIHWwSloOjGMKUI39ZEG0Mp3tzETm51a7CEA1aEl+3GDp
 3lkg==
X-Gm-Message-State: AOAM533CiEH59YV+EX8SABWu4edbSW5X7oYV6pNnf6G4RExcdARYWVk+
 FVxMyYCnf9k2dM7OJlf68nO7D/CTY2iu3Hxb/ltbgVpF6A/mhWu0qlySUG1vwo5bRYLBAo7pqih
 teCM0k8AkgsEZFY4=
X-Received: by 2002:a05:6402:141:: with SMTP id
 s1mr2884124edu.87.1603964048409; 
 Thu, 29 Oct 2020 02:34:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjcgH2rmz4jkf1kCqXySw/RvA8JU3syM6Ue6HVP6EL2HofhsUzs21j0aQXfQ0C/Q3T4kMnhQ==
X-Received: by 2002:a05:6402:141:: with SMTP id
 s1mr2884116edu.87.1603964048257; 
 Thu, 29 Oct 2020 02:34:08 -0700 (PDT)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id v2sm1134551ejh.57.2020.10.29.02.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 02:34:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2 11/25] block/nvme: Make nvme_init_queue() return
 boolean indicating error
Date: Thu, 29 Oct 2020 10:32:52 +0100
Message-Id: <20201029093306.1063879-12-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029093306.1063879-1-philmd@redhat.com>
References: <20201029093306.1063879-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Keith Busch <kbusch@kernel.org>, Eric Auger <eric.auger@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just for consistency, following the example documented since
commit e3fe3988d7 ("error: Document Error API usage rules"),
return a boolean value indicating an error is set or not.
Directly pass errp as the local_err is not requested in our
case. This simplifies a bit nvme_create_queue_pair().

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 98335012457..6eaba4e7039 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -160,7 +160,8 @@ static QemuOptsList runtime_opts = {
     },
 };
 
-static void nvme_init_queue(BDRVNVMeState *s, NVMeQueue *q,
+/* Returns true on success, false on failure. */
+static bool nvme_init_queue(BDRVNVMeState *s, NVMeQueue *q,
                             unsigned nentries, size_t entry_bytes, Error **errp)
 {
     size_t bytes;
@@ -171,13 +172,15 @@ static void nvme_init_queue(BDRVNVMeState *s, NVMeQueue *q,
     q->queue = qemu_try_memalign(s->page_size, bytes);
     if (!q->queue) {
         error_setg(errp, "Cannot allocate queue");
-        return;
+        return false;
     }
     memset(q->queue, 0, bytes);
     r = qemu_vfio_dma_map(s->vfio, q->queue, bytes, false, &q->iova);
     if (r) {
         error_setg(errp, "Cannot map queue");
+        return false;
     }
+    return true;
 }
 
 static void nvme_free_queue_pair(NVMeQueuePair *q)
@@ -210,7 +213,6 @@ static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
                                              Error **errp)
 {
     int i, r;
-    Error *local_err = NULL;
     NVMeQueuePair *q;
     uint64_t prp_list_iova;
 
@@ -247,16 +249,12 @@ static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
         req->prp_list_iova = prp_list_iova + i * s->page_size;
     }
 
-    nvme_init_queue(s, &q->sq, size, NVME_SQ_ENTRY_BYTES, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!nvme_init_queue(s, &q->sq, size, NVME_SQ_ENTRY_BYTES, errp)) {
         goto fail;
     }
     q->sq.doorbell = &s->doorbells[idx * s->doorbell_scale].sq_tail;
 
-    nvme_init_queue(s, &q->cq, size, NVME_CQ_ENTRY_BYTES, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!nvme_init_queue(s, &q->cq, size, NVME_CQ_ENTRY_BYTES, errp)) {
         goto fail;
     }
     q->cq.doorbell = &s->doorbells[idx * s->doorbell_scale].cq_head;
-- 
2.26.2


