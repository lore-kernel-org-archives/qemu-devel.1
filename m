Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC89C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 20:03:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C9C42072D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 20:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BCJkSyIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9C42072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9DFd-0004Kw-BZ
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 16:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9D8H-0008CE-6U
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:55:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24268
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9D8B-0002sE-2K
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598039717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z6xkWpwBlZzkhFi5oKqD8l8Ej8buVWdRi+BzbsrCC3Q=;
 b=BCJkSyIPqe26F9/YQvN4q2sb6aWGSVKoMC1cSAN5fxg4Nm+zdg8u+J3GDJ31G4TiMTnDmu
 20PUjgxUjYK00d6lgHhe9K1aQ8jEXxZdFV7kHRrr4/RE4WSKCwzrPOj49R6wXtbNImaJlx
 936NLEzU1bo+hQRR4TpWFCWuPYcVcNM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-QbqD46IONj-gg17BdnBSdw-1; Fri, 21 Aug 2020 15:55:16 -0400
X-MC-Unique: QbqD46IONj-gg17BdnBSdw-1
Received: by mail-wm1-f69.google.com with SMTP id b73so1042545wmb.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 12:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z6xkWpwBlZzkhFi5oKqD8l8Ej8buVWdRi+BzbsrCC3Q=;
 b=rLosndNYWAgwuLtG8940Pz2Xc1oLq3B+aKkuiIxFMh6Nrvw1w9fL98fjwVjZB9Aj5s
 qI4NnPlPh9pvGTZivq1/PmC1/N/IzEinhyl6K0GFRpDkCv3rBzbsTY/nMqAMtlLOA23O
 PJQR1t6YkInwGaANXvGDqDF1+5QR7r9dSHVJVQEj5AIOXBmsdQV3E2+vHXjk81u8w2Tc
 zTBRaLuLh/Ue4busd0zIp/1/LZ7e5/iLx0IbvOnZ4SC9HQPyAQ2kYyqBO2GV6Sa/za8s
 k738FRnB/SwR1aSQu2avzeemZUkWVeIjnoQxrMsiyLNeTbzXqidGxtHLaTSzDaVqxiWA
 QDDg==
X-Gm-Message-State: AOAM530gEmA1Q8nhPk1kbKFuv8S7G1UsqM6n0fx+DfKkRHCp328VLHFv
 RLbD2+9CwNaRFjTc+BNT3IDdwGUuRKc6Lds5WRcwoJ45wBQ54KJD3ikmwJYhOo47lyUXSrmuWk4
 ggNgI+fKTvR6hVDU=
X-Received: by 2002:a1c:7915:: with SMTP id l21mr5564008wme.50.1598039714673; 
 Fri, 21 Aug 2020 12:55:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZfSW+NJGIBaC+n4RDM9u1snPu4BoDTlXjjnSOilHbdh9a4EFTx8ZFLFS9nbPoRU0Sr1QUUQ==
X-Received: by 2002:a1c:7915:: with SMTP id l21mr5563998wme.50.1598039714485; 
 Fri, 21 Aug 2020 12:55:14 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id m1sm7070832wmc.28.2020.08.21.12.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 12:55:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 14/15] block/nvme: Extract nvme_poll_queue()
Date: Fri, 21 Aug 2020 21:53:58 +0200
Message-Id: <20200821195359.1285345-15-philmd@redhat.com>
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

As we want to do per-queue polling, extract the nvme_poll_queue()
method which operates on a single queue.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 44 +++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 85b235c8e6d..1cc2e9493d0 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -590,31 +590,41 @@ out:
     qemu_vfree(id);
 }
 
+static bool nvme_poll_queue(NVMeQueuePair *q)
+{
+    bool progress = false;
+
+    const size_t cqe_offset = q->cq.head * NVME_CQ_ENTRY_BYTES;
+    NvmeCqe *cqe = (NvmeCqe *)&q->cq.queue[cqe_offset];
+
+    /*
+     * Do an early check for completions. q->lock isn't needed because
+     * nvme_process_completion() only runs in the event loop thread and
+     * cannot race with itself.
+     */
+    if ((le16_to_cpu(cqe->status) & 0x1) == q->cq_phase) {
+        return false;
+    }
+
+    qemu_mutex_lock(&q->lock);
+    while (nvme_process_completion(q)) {
+        /* Keep polling */
+        progress = true;
+    }
+    qemu_mutex_unlock(&q->lock);
+
+    return progress;
+}
+
 static bool nvme_poll_queues(BDRVNVMeState *s)
 {
     bool progress = false;
     int i;
 
     for (i = 0; i < s->nr_queues; i++) {
-        NVMeQueuePair *q = s->queues[i];
-        const size_t cqe_offset = q->cq.head * NVME_CQ_ENTRY_BYTES;
-        NvmeCqe *cqe = (NvmeCqe *)&q->cq.queue[cqe_offset];
-
-        /*
-         * Do an early check for completions. q->lock isn't needed because
-         * nvme_process_completion() only runs in the event loop thread and
-         * cannot race with itself.
-         */
-        if ((le16_to_cpu(cqe->status) & 0x1) == q->cq_phase) {
-            continue;
-        }
-
-        qemu_mutex_lock(&q->lock);
-        while (nvme_process_completion(q)) {
-            /* Keep polling */
+        if (nvme_poll_queue(s->queues[i])) {
             progress = true;
         }
-        qemu_mutex_unlock(&q->lock);
     }
     return progress;
 }
-- 
2.26.2


