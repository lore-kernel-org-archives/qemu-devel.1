Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0118C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:33:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66AD820639
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxpGBcXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66AD820639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDoQi-0006JZ-Dg
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoMj-0001Dl-Kg
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:29:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20049
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoMf-0007uO-RI
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599136157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D/1bfeigNPBAr+CZsKwZjr8MJ2jC3u5ha14iMiW2Qnc=;
 b=DxpGBcXWsrVOtynwsKnJOm+AqE2gmrgslrN//II7gjmbk5kj/yiNbFFxD5mKU101l5EBRx
 /swcMREj4evgjFAzAfNRDazvoXxnDe1ORyFkuz8tEIlZrH/9h02xI04dJeQXjuj9YHYjXt
 Z3d52E9DfsKSqsS+DN2oLdNyojrUe2w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-CpwtmEBqMKqwXnD6rWm0cw-1; Thu, 03 Sep 2020 08:29:15 -0400
X-MC-Unique: CpwtmEBqMKqwXnD6rWm0cw-1
Received: by mail-wr1-f71.google.com with SMTP id v12so1025444wrm.9
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D/1bfeigNPBAr+CZsKwZjr8MJ2jC3u5ha14iMiW2Qnc=;
 b=pdC/UH1TQ/8upoirurG3iJSnJ1ISfCtym/euf9fFA7KQnAeVBW2Oq65DsQjBM7XGmL
 nEZcTdTzsVqE7IyFWNUok/q1LN/pArSIzUVjxEJ+W4NXrdKB3SBLAZ7NIIyweqPZnxZx
 6h+mF6+mtTVQ6Y8zj2Dm05Wr9ZnSOfmGwZ/Qa1FjINIKEQwCWacIFN8JqyIIqPiPCIho
 4kjko3bhbS07kXTG4nIsz/3DAZq+bajCMPklGZksZteZaoLnJ6IpbX3ldaGdZWS0j16C
 XVBTuGqdTuipzUt4CG0jZGbJLHRm2CmT65JVqrcgj1zhb2qTsTMbjCi+pxvSAe7iGQ0h
 md4A==
X-Gm-Message-State: AOAM530IsABzw+te4z4iOErhyxxaBX8Bq0wZLaZiE8aAOVJHEG3hSxuo
 SNGoLGcB8DIaDmFBkmyUNwRKm3OP6oHhkZbAy9qkzxhiPyayOOJYed+qZuaV1dyGzKzy0AdCKa7
 bVdNxxJ+tCJWraiI=
X-Received: by 2002:a5d:56cd:: with SMTP id m13mr2161731wrw.261.1599136154258; 
 Thu, 03 Sep 2020 05:29:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTPgSinKaIRHqtaXlf7sopCZGc1ejfatwJo/w0wG4f1Xj7w3z5sSAL1AT7yvfuRQwI3YvN5Q==
X-Received: by 2002:a5d:56cd:: with SMTP id m13mr2161703wrw.261.1599136154021; 
 Thu, 03 Sep 2020 05:29:14 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id o6sm2969158wrm.76.2020.09.03.05.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 05:29:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 14/15] block/nvme: Extract nvme_poll_queue()
Date: Thu,  3 Sep 2020 14:28:02 +0200
Message-Id: <20200903122803.405265-15-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903122803.405265-1-philmd@redhat.com>
References: <20200903122803.405265-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 00:24:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>,
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
index 914a3c4ab31..e3719d3bd14 100644
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


