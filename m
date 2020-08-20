Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745B4C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:06:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E9C5208A9
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2t580QT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9C5208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8o1V-0007b4-Hr
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 13:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8nvN-0005Fz-5n
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:00:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46285
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8nvL-0006S8-18
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597942822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ijWvbXbwV2OfcKpjugDRX3POUSdELxpfYooH/g+NfK0=;
 b=L2t580QTdCuN9H8AbPxZeZ88EiC0U7atuKAFDXMSx0ttmnCnRYLgccf3oaey5Yxggs81A2
 kudI3JYuaWeqLlsKHiXoseMMNUjuakjUdEQf7V/KFKPELHpoq21M/BDxodAYyoXMbiTDfy
 22tOwxO+Mdt9G+R2PsYJ5inNYlHls8A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-M0eL0UuINCuG97BGSN8IcA-1; Thu, 20 Aug 2020 13:00:20 -0400
X-MC-Unique: M0eL0UuINCuG97BGSN8IcA-1
Received: by mail-wr1-f71.google.com with SMTP id s23so855307wrb.12
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 10:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ijWvbXbwV2OfcKpjugDRX3POUSdELxpfYooH/g+NfK0=;
 b=mcqZDhC19chKhZ0FugwW8swxQopweadUDy1bW69WioC/DsanIRERlJMbJQWyl9+VCh
 ALV1yjJ9G++CqM4329RWE2vOnv36EognFkHQzcN+IxVT3wMgXXDETjmoUdBbUvakcO2g
 U+ZrxpHNd2HAxkzRYQfF9vs6MffEkLHIWNT4rRGzFJJiRmV8Lzqy3MNfF3B4pimJcN5V
 VSyKQTeMHTnKXVGUzaF4EOSDCVmvfGwhGD3XgDIOUXC044HzhCNnLfDKbbRuubGgc4l9
 T2VeGFPrjNsY8mXNRatcqHsXW+5yIYCLMgRqD+87HQinmn61M0STauBoXUs41hw/SpKu
 3MUg==
X-Gm-Message-State: AOAM531y3m8RKEKrOxZQb7bc/VtWMAiowsVaFuSADrQ5+46JVmRzRvEm
 0CynRdpiotqayhkrIJjgOpnlQeT8Hc2IA1Nvyjxo/8EYVIxk9nJIu8kyc9QafC7NRh6XWcphrQo
 OZ7cpJN6Lih/O2+0=
X-Received: by 2002:a1c:e0c2:: with SMTP id x185mr4311630wmg.124.1597942819152; 
 Thu, 20 Aug 2020 10:00:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxwV1nFDYWSnyq0i+pIn/lNjE0rC92S0Mdf8EylvWZhroUjF6fcDU6uCiMbVD2+bpQ5WZC1A==
X-Received: by 2002:a1c:e0c2:: with SMTP id x185mr4311611wmg.124.1597942818939; 
 Thu, 20 Aug 2020 10:00:18 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 32sm5960798wrh.18.2020.08.20.10.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 10:00:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 14/15] block/nvme: Extract nvme_poll_queue()
Date: Thu, 20 Aug 2020 18:59:00 +0200
Message-Id: <20200820165901.1139109-15-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200820165901.1139109-1-philmd@redhat.com>
References: <20200820165901.1139109-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:12:44
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we want to do per-queue polling, extract the nvme_poll_queue()
method which operates on a single queue.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 44 +++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 1f67e888c84..a61e86a83eb 100644
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


