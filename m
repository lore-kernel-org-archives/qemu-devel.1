Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC64C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:58:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A98E20774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLmH1TmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A98E20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5vwp-0005ij-Bt
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 14:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5vqZ-0001rN-GE
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:51:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53091
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5vqW-0004jl-S0
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597258292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f5FO5rty5Ar7TciGd3Lqn1E0+Iz/xqO7slj9hUfb3Ds=;
 b=gLmH1TmD40bMiQGWKjbGHlD6Q74OyjBEuzETlrjG9BMA5eI8O+XFwNp1CiksbYeI9CyUzv
 l978coek53cQacRVZNzPi2hu50bItje4uz8opJKywssJqEoq/tdgnHEQfk1MgIJtrycf3p
 g7hAXHYK0hafLqPfVQYKUvEAKrV3T9o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-qIAwEWyAPfCFktWnOeDciA-1; Wed, 12 Aug 2020 14:51:29 -0400
X-MC-Unique: qIAwEWyAPfCFktWnOeDciA-1
Received: by mail-wm1-f71.google.com with SMTP id c124so974711wme.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 11:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=f5FO5rty5Ar7TciGd3Lqn1E0+Iz/xqO7slj9hUfb3Ds=;
 b=Bv2crZ+b4K0t7i2C7Iquf1KCDLizog4l66CRUX29Ygz0jTBH59ka/kWRAzYjlaketd
 kzhUf/VS2eJd/eoRUV0FMKhwGmXkw58o2crr85UkHf/YVQXezhH21Ka35KiUkQBU2XP1
 45zS2RZSLW7X1PJNJJLK+8CVTLcZvspUnf5pmFhjpQcLQ+H5kaXfMELtnjs/gr4yMgkY
 bpHu/orLXg9Kieb4BuRKTY2ZWdar8PSw/l4oPYiTMBDsWdB3jjR/Kq8QkjihVhUeCgwn
 qWi2Yi+1wDGVT6fQhJMf2CI1RGpFKl93kNQkRlhKVjuiyAzMSUdQTGRWoY4rMl08NE9w
 YupA==
X-Gm-Message-State: AOAM530JIRDHW5U3RMrxSwAEZ90ak9YjR8/OXYeI6fFwr5MaaSX8GBD7
 msCPmI8jm3L4gLdyAVXuaac6Q7nUNfbdz+rPoa2EFgHau3ilj2uJbJMnKFVaGlU7if0ePRfhg+0
 2JFUBGiEGx3dW5rs=
X-Received: by 2002:a1c:740c:: with SMTP id p12mr911142wmc.53.1597258288154;
 Wed, 12 Aug 2020 11:51:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzILqBk6iAgxnBog8iUVej/zWrbjqKDei4oAwRMUsfCEmErDvVNwXAI4RkHx4GS/aGA5jzcjw==
X-Received: by 2002:a1c:740c:: with SMTP id p12mr911124wmc.53.1597258287923;
 Wed, 12 Aug 2020 11:51:27 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id j5sm5477025wmb.12.2020.08.12.11.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 11:51:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 14/14] block/nvme: Extract nvme_poll_queue()
Date: Wed, 12 Aug 2020 20:50:14 +0200
Message-Id: <20200812185014.18267-15-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200812185014.18267-1-philmd@redhat.com>
References: <20200812185014.18267-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
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
index 1f67e888c8..a61e86a83e 100644
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
2.21.3


