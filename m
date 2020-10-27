Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6756C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:20:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F14206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1op0+tG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F14206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPqC-0004wG-4t
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPUB-00046N-59
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:58:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46784)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPU7-0004XC-2c
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603807077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NAlvgmTt63VVhwmPwsffm7y53PiDjihV7pQ2MmamgE4=;
 b=C1op0+tGH1Ki4Z5YcRgXi8B3tJVZEoxB4pmPt2vIluFsRsGYDe4sRnXIYqWW8Iqs9jFYdU
 DFMnS5Qjh4jPZhNnypzybRzgk80leIhPgwzrwqiOSr9udEcqID2mmiMIqCEqWYTo3YI8+x
 /cFWYZei6/0/4kD+8v07+Hox4SrMwCU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-ULHAFdV0NTGt1oKlHOo_0Q-1; Tue, 27 Oct 2020 09:57:55 -0400
X-MC-Unique: ULHAFdV0NTGt1oKlHOo_0Q-1
Received: by mail-ej1-f69.google.com with SMTP id i21so936480ejb.5
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NAlvgmTt63VVhwmPwsffm7y53PiDjihV7pQ2MmamgE4=;
 b=tli7CPzZD6Yc0rtvQILVdxPDBJzXas501ibNeeqMBiI60VllgTadkFx+cID+PJJ936
 QpzHA68VY1ojN4Sxey0sDSqPG/Sp2P+r2yCr/TPtBHHf7LR0DlLUgPKNvkb6rcSbEz3q
 f14OuP4zMPlUdlyehfMx9sAO9tt+S4QlyzHns5Osor+WwoFQ8abtAGPEbw14zn+oyzXM
 X+3BAmQN6H3g/3FfZrTbva52QAMuQK8zJQRAgVvC+cvg7lsec450RX57nqFQM9WSCOsL
 2U72ZJ1p3hye1UaIj0LPFjiOtLsT53zIz3h1fGp0ZPSOosD0/aadeZHm9I2NXXrRxEFi
 ePSg==
X-Gm-Message-State: AOAM530b2NJedTnD4sEEnI49G+RO0A389Oc7Z59l5EK+COVvLOGN9rxA
 R7NgD3fdy2AUDtnm/Op759j82i3XTxXo/IH4y5PeR/cZqVFA8DHhATxyeNERWYQObLFwMjrx/a/
 lXRs3t/LeNzVfBgk=
X-Received: by 2002:a17:906:b0d7:: with SMTP id
 bk23mr2685810ejb.103.1603807074332; 
 Tue, 27 Oct 2020 06:57:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyINoOPF8wNVWokkj+IKWIMIktCGQC5/gJ7yK7HdRpYJqPJ0+waXXQhdA3r2TV4/fs/s5Gn6A==
X-Received: by 2002:a17:906:b0d7:: with SMTP id
 bk23mr2685783ejb.103.1603807074086; 
 Tue, 27 Oct 2020 06:57:54 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id i5sm1086357ejs.121.2020.10.27.06.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 06:57:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 23/25] block/nvme: Change size and alignment of prp_list_pages
Date: Tue, 27 Oct 2020 14:55:45 +0100
Message-Id: <20201027135547.374946-24-philmd@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

In preparation of 64kB host page support, let's change the size
and alignment of the prp_list_pages so that the VFIO DMA MAP succeeds
with 64kB host page size. We align on the host page size.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 941f96b4c92..e3626045565 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -214,6 +214,7 @@ static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
     int i, r;
     NVMeQueuePair *q;
     uint64_t prp_list_iova;
+    size_t bytes;
 
     q = g_try_new0(NVMeQueuePair, 1);
     if (!q) {
@@ -221,19 +222,19 @@ static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
     }
     trace_nvme_create_queue_pair(idx, q, size, aio_context,
                                  event_notifier_get_fd(s->irq_notifier));
-    q->prp_list_pages = qemu_try_memalign(s->page_size,
-                                          s->page_size * NVME_NUM_REQS);
+    bytes = QEMU_ALIGN_UP(s->page_size * NVME_NUM_REQS,
+                          qemu_real_host_page_size);
+    q->prp_list_pages = qemu_try_memalign(qemu_real_host_page_size, bytes);
     if (!q->prp_list_pages) {
         goto fail;
     }
-    memset(q->prp_list_pages, 0, s->page_size * NVME_NUM_REQS);
+    memset(q->prp_list_pages, 0, bytes);
     qemu_mutex_init(&q->lock);
     q->s = s;
     q->index = idx;
     qemu_co_queue_init(&q->free_req_queue);
     q->completion_bh = aio_bh_new(aio_context, nvme_process_completion_bh, q);
-    r = qemu_vfio_dma_map(s->vfio, q->prp_list_pages,
-                          s->page_size * NVME_NUM_REQS,
+    r = qemu_vfio_dma_map(s->vfio, q->prp_list_pages, bytes,
                           false, &prp_list_iova);
     if (r) {
         goto fail;
-- 
2.26.2


