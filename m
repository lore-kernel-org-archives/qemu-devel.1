Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CBCC55178
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79E6C20754
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fK6t4ldT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E6C20754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY4NO-0003K0-ES
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 05:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4Jl-00066R-FA
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:34:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39665)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4Jh-0006Ws-79
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603964030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EBb5GrRIOVLLA2GDg9frMwfzobl3y/7Xq37zU2+GEk8=;
 b=fK6t4ldTLnsIUojM9BdKo85YWSRKbkkEqtS1Ub/OXA9wXkaF+RpRphGgXAwqbB+1Zpxwb/
 m2mhiIOV+3dAHrRkFy4x2Gj5cgg9IqcLOO/ygbjMaeynF9e3cLnlzMIxktut8pKRtHwoVE
 09pxQBzTDb6tqXC6IkvGMD/wrnEPyAc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-hzDqeQQHNP-jJ6YQpfE_yA-1; Thu, 29 Oct 2020 05:33:48 -0400
X-MC-Unique: hzDqeQQHNP-jJ6YQpfE_yA-1
Received: by mail-ej1-f70.google.com with SMTP id b17so929466ejb.20
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 02:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EBb5GrRIOVLLA2GDg9frMwfzobl3y/7Xq37zU2+GEk8=;
 b=kc1Kxhg73K9avrf1wLP0/4ZqDUk4d5/Je/kqPk9OGwZrIYeTm4MRz5q9G/EYs2yJ3f
 ioOfglg3NCxl9JeNcAbAMtm2xJR/WjdOR0y6L19jxmGAjLfAHzPyGAiBWvaJqqLfDFgD
 QigX+FKzcG6PYb3KNzQWj8FoBexIshzWcZF5GNycihYuwcYGWD9Pbl31oEOH74uP+x4D
 AdzfB+BJgq/fkhssH6NOQkueqnBYQsUvr3vKlhkTC29HOJzCdnOZms7potrXiGJX6AAq
 0c0dQXoyKDaMwgV56g8tSimRFTWjCDouN/+VqJFySfUAj28OeJdHKdjHsd9NGzKewncK
 gXeg==
X-Gm-Message-State: AOAM530nYZsaarjAilI9JC4dZuzqLMrVaHbbS0iqI5RQTwDSvE6KGcmb
 jDrbjIDxzK2QFBFUQm1uMldalkBvALp85qFhcC580S3XkKd/FIBamxzFHPFfgswlBrmxiLtPmpP
 HOIbJX2u13s6asl4=
X-Received: by 2002:a17:906:7210:: with SMTP id
 m16mr3319986ejk.490.1603964026928; 
 Thu, 29 Oct 2020 02:33:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwimITMNtQ8O1OpBtiouA1FKrkJa7uHuXVtHe9G82z1AC8mSDLoBSF94Qk2MLwKAL7koIYlpw==
X-Received: by 2002:a17:906:7210:: with SMTP id
 m16mr3319980ejk.490.1603964026799; 
 Thu, 29 Oct 2020 02:33:46 -0700 (PDT)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id j20sm1184367edt.4.2020.10.29.02.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 02:33:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2 07/25] block/nvme: Trace queue pair
 creation/deletion
Date: Thu, 29 Oct 2020 10:32:48 +0100
Message-Id: <20201029093306.1063879-8-philmd@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Eric Auger <eric.auger@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c       | 3 +++
 block/trace-events | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/block/nvme.c b/block/nvme.c
index 29d2541b911..e95d59d3126 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -181,6 +181,7 @@ static void nvme_init_queue(BDRVNVMeState *s, NVMeQueue *q,
 
 static void nvme_free_queue_pair(NVMeQueuePair *q)
 {
+    trace_nvme_free_queue_pair(q->index, q);
     if (q->completion_bh) {
         qemu_bh_delete(q->completion_bh);
     }
@@ -216,6 +217,8 @@ static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
     if (!q) {
         return NULL;
     }
+    trace_nvme_create_queue_pair(idx, q, size, aio_context,
+                                 event_notifier_get_fd(s->irq_notifier));
     q->prp_list_pages = qemu_try_memalign(s->page_size,
                                           s->page_size * NVME_NUM_REQS);
     if (!q->prp_list_pages) {
diff --git a/block/trace-events b/block/trace-events
index cc5e2b55cb5..f6a0f99df1a 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -155,6 +155,8 @@ nvme_dsm(void *s, uint64_t offset, uint64_t bytes) "s %p offset 0x%"PRIx64" byte
 nvme_dsm_done(void *s, uint64_t offset, uint64_t bytes, int ret) "s %p offset 0x%"PRIx64" bytes %"PRId64" ret %d"
 nvme_dma_map_flush(void *s) "s %p"
 nvme_free_req_queue_wait(void *s, unsigned q_index) "s %p q #%u"
+nvme_create_queue_pair(unsigned q_index, void *q, unsigned size, void *aio_context, int fd) "index %u q %p size %u aioctx %p fd %d"
+nvme_free_queue_pair(unsigned q_index, void *q) "index %u q %p"
 nvme_cmd_map_qiov(void *s, void *cmd, void *req, void *qiov, int entries) "s %p cmd %p req %p qiov %p entries %d"
 nvme_cmd_map_qiov_pages(void *s, int i, uint64_t page) "s %p page[%d] 0x%"PRIx64
 nvme_cmd_map_qiov_iov(void *s, int i, void *page, int pages) "s %p iov[%d] %p pages %d"
-- 
2.26.2


