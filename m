Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E482C5517A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098CF2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRVbNQKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098CF2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPuA-0002Jd-Tr
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPSk-0003BU-0b
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:56:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59658)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPSe-0004IV-Bw
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603806987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WBWP7KBMIQI6YRPnFGQwZbxBBXEh8CIfDLyp5hJxrI0=;
 b=VRVbNQKuJJWBjmJ96IPkNvmBeYQW1qHE2ndaa47a2YlZ9+uZSG8EKe72X3ltONpU7jULOt
 3zMW3kUEu4Glvfbi8fSOtIi4bLC3Q3U3f5ijjIPxHvsOZ1SjiYIOIDUTOzq9KH18lG0X+0
 iRcwxvfKRSA3oSIzZ2RZ+aJ2CfB/PVo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-p_Pz2hkeMmW3O3ByINQU0w-1; Tue, 27 Oct 2020 09:56:24 -0400
X-MC-Unique: p_Pz2hkeMmW3O3ByINQU0w-1
Received: by mail-ed1-f71.google.com with SMTP id y8so730445edj.5
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WBWP7KBMIQI6YRPnFGQwZbxBBXEh8CIfDLyp5hJxrI0=;
 b=V/Y+BIP8C7iIX9DZJ4ovJjk/5SvGnPq6Y4aIlTr6H3P+EkDm1oQC6qotB9J64ZfSkE
 NhSjSG4f6t5Vbp5j8P4lRpAXbUEYBpW5+FbUBT4OaTBLNDMVPwx80atRoOC+I3nALp0U
 yNkX5wewNFl9pknWE3MvSlP46Mrtjk6l5K9mpE7xDiZJhZ2e9Ygu8JpfecYAOcEXLZoD
 7ppDgAwMPhAM+knd+GUldThdfxsLC6Fmy2ywoSP7OmdGZ3n2fFEnmKYr6pJ8l14mKSvE
 a/u2w3HV8QH6FMwOS2wCh8IQEAyhvoGDQgTksS9/7R9nTfB4Iqt+AnloxJz+8+Bx+JPI
 g/wQ==
X-Gm-Message-State: AOAM530nxIkmzeNRh0vCSJrZzFaDPQ1tNsIVF1C9EbbghXhI2mjmx3mG
 IdqjyxDTSYbUo8U8oIJR65QqnSPM0zoovQv1HwPCdHEe4bd6zL006XH0cFKjfj0GUZqS+cnfgvk
 AsHPMKF9w8N+v528=
X-Received: by 2002:a17:906:5594:: with SMTP id
 y20mr2650653ejp.196.1603806982302; 
 Tue, 27 Oct 2020 06:56:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQSZcVQU+o3Hk7rvmzMGq3IlquhDlUEgCoHtlKGQdLsCnzA4YKsJOo+FZo8KxtT0R5NaJ0lA==
X-Received: by 2002:a17:906:5594:: with SMTP id
 y20mr2650638ejp.196.1603806982089; 
 Tue, 27 Oct 2020 06:56:22 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id h15sm1088318ejf.50.2020.10.27.06.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 06:56:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/25] block/nvme: Improve nvme_free_req_queue_wait() trace
 information
Date: Tue, 27 Oct 2020 14:55:28 +0100
Message-Id: <20201027135547.374946-7-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027135547.374946-1-philmd@redhat.com>
References: <20201027135547.374946-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 qemu-block@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

What we want to trace is the block driver state and the queue index.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c       | 2 +-
 block/trace-events | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 8d74401ae7a..29d2541b911 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -292,7 +292,7 @@ static NVMeRequest *nvme_get_free_req(NVMeQueuePair *q)
 
     while (q->free_req_head == -1) {
         if (qemu_in_coroutine()) {
-            trace_nvme_free_req_queue_wait(q);
+            trace_nvme_free_req_queue_wait(q->s, q->index);
             qemu_co_queue_wait(&q->free_req_queue, &q->lock);
         } else {
             qemu_mutex_unlock(&q->lock);
diff --git a/block/trace-events b/block/trace-events
index 86292f3312b..cc5e2b55cb5 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -154,7 +154,7 @@ nvme_rw_done(void *s, int is_write, uint64_t offset, uint64_t bytes, int ret) "s
 nvme_dsm(void *s, uint64_t offset, uint64_t bytes) "s %p offset 0x%"PRIx64" bytes %"PRId64""
 nvme_dsm_done(void *s, uint64_t offset, uint64_t bytes, int ret) "s %p offset 0x%"PRIx64" bytes %"PRId64" ret %d"
 nvme_dma_map_flush(void *s) "s %p"
-nvme_free_req_queue_wait(void *q) "q %p"
+nvme_free_req_queue_wait(void *s, unsigned q_index) "s %p q #%u"
 nvme_cmd_map_qiov(void *s, void *cmd, void *req, void *qiov, int entries) "s %p cmd %p req %p qiov %p entries %d"
 nvme_cmd_map_qiov_pages(void *s, int i, uint64_t page) "s %p page[%d] 0x%"PRIx64
 nvme_cmd_map_qiov_iov(void *s, int i, void *page, int pages) "s %p iov[%d] %p pages %d"
-- 
2.26.2


