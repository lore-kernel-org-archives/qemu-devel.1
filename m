Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F74FC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5611A2184D
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0HZS9nK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5611A2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrpvV-0003ZO-M8
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 17:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrplW-0003n8-QU
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:32:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35010
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrplU-00048k-FL
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593898323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xumHQmie22PgCKek0cikqjiB9L+Aua1bZGi1TBEXwDY=;
 b=W0HZS9nKw//NDadOhbLbOPsiAi9HCESy/hvwjFKHdQFo02BTZdw/SszDZwIO43VuCemaMG
 c7nlneCaXIl3jwN46sKpxOHAVwi/+5cWOZfbsNJ/NQG4HawxHUu1yYlbKG+bmQzC9WEJCN
 SpeEgXlBSiONyt3FVGqq8w9fzOxCq+U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-x4s2x__rMJaiduv2p7hwxQ-1; Sat, 04 Jul 2020 17:32:02 -0400
X-MC-Unique: x4s2x__rMJaiduv2p7hwxQ-1
Received: by mail-wr1-f71.google.com with SMTP id i14so36772298wru.17
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 14:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xumHQmie22PgCKek0cikqjiB9L+Aua1bZGi1TBEXwDY=;
 b=bAGh7HnlAFn3lQkiCWfvyoMp9r1kAIqnMyH5KZ52a4bs2daL6UXsmx0QIhNrGaUxIJ
 cNToiXeltJZ7+pgjFNfcFBf0Fjgla6+fclhu0W/73tAXa0fYBxQZmPVPKaNea+I8Jc8N
 XhXwOxYL0vjzgUurJBLe/lPuQsGusMMhTAorJ0AkhNxGr0siOh/HHb+6HWx1bMx/N68q
 Lvpeg/YsMb9H93h5CIxUxo39GhirDkty96Z/af0to7QiR3b0FyirF/GFHpwKc+89xEYz
 QoT13PF5xvtZdHLzWN441fzXLT0RAz6hlpe4ZJS226uPKJ3OnLIwi77vqYAhnI56Ply7
 ANqA==
X-Gm-Message-State: AOAM531c71dvJWe6HMm9M5td23gM/R563U30pNz+wYcXrSKzlMgXM1ey
 3ozPBre3rqe7mHrPiouW0vkeDcmu6QoUhPCdTKWyCI6zrt+favQauBNsVPRW84F4ePGCOfYfqnC
 OOlEA51x26HO74kE=
X-Received: by 2002:a1c:bb03:: with SMTP id l3mr3490456wmf.24.1593898320850;
 Sat, 04 Jul 2020 14:32:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIy31XjAsBCygF2UiTow0NHzpb0WF2Sggq9OgMLZpL353dfgIwqImG6oj2PaQfz81zEsHWeg==
X-Received: by 2002:a1c:bb03:: with SMTP id l3mr3490446wmf.24.1593898320690;
 Sat, 04 Jul 2020 14:32:00 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id l190sm17325089wml.12.2020.07.04.14.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 14:32:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 14/16] block/nvme: Extract nvme_poll_queue()
Date: Sat,  4 Jul 2020 23:30:49 +0200
Message-Id: <20200704213051.19749-15-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704213051.19749-1-philmd@redhat.com>
References: <20200704213051.19749-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 17:28:04
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we want to do per-queue polling, extract the nvme_poll_queue()
method which operates on a single queue.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Stefan better double check here!
---
 block/nvme.c | 44 +++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 51ac36dc4f..a6ff660ad2 100644
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


