Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B914C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:53:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8CC0206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBnfH4pC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8CC0206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joX09-0006OW-2y
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWwo-00019t-2W
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:50:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31461
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWwm-0001KX-9Z
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593111003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tl+gLEZwGkUrjAxE+tzn7ayeWCnvtfJEgm2So8A1ED8=;
 b=PBnfH4pCtCmkQp1EEPTFLKf7KtDeMHxmQ1oUBmdlHvRFVOytVzqqGHhIPmISyRs9w5mHFm
 tXtv7TsGWhw42SvRXFlLVFwgx3q+YIkwQ1nFIk85yp2EBU5L9xVgM2bCaQUlN0cXIAZ+pk
 zbDxBi9+dlTKV1m5YFzhFUqpewvLGwg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-DYkX4lxGPk6rJDLB6ffBuQ-1; Thu, 25 Jun 2020 14:50:01 -0400
X-MC-Unique: DYkX4lxGPk6rJDLB6ffBuQ-1
Received: by mail-wr1-f69.google.com with SMTP id g14so7728427wrp.8
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 11:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tl+gLEZwGkUrjAxE+tzn7ayeWCnvtfJEgm2So8A1ED8=;
 b=eG3KoY1Ua5rDBOu5/sNWPsFwTDDNmdChiG8BbTasmwplyW0oGE9A065nPKsgS5WXMx
 +eK6iF/DdRXokYdYUb5xFfZuObeRtJqygbpAgwQFUBg1+sP5vm7ZcFhNPAORMlbpSqrF
 ktV4EM0IB4GQvkoS1LsFtXa6FWbrQPQDrN13ckZuYUnFpB7J6wI/XS9/w+GzeXsTGxWk
 3VxE0Hkgr0HtwQrD0Cu9MViN8Dl0Y0WgnQfWtND+Txzm2X3y88Eqi7v/1HwCeCsN+Q4j
 pSRfnMY1p4kvPC83g8qeIi/MxUxwch+McK36phZfnRzWZp5xKLkTvdnUoHF6FTbl02mo
 jkLg==
X-Gm-Message-State: AOAM5334n1/bT9VLV4uIRaovzeAGZC9yB7cuqqL2DL6NbF+w9XFKiNKr
 TiDDgMFAwnI4Im7IntwXtC7CxuH0v2wB5Db9MGoSD+nOCgZQh7AjXRKOPQardmjfVsTYAeHpHNF
 9r75mt4tOLL5EnOk=
X-Received: by 2002:a5d:4845:: with SMTP id n5mr21970120wrs.353.1593111000139; 
 Thu, 25 Jun 2020 11:50:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxl/+O6qurqDErKCYYuBGgege6IM/0PYqI0v8PHqM7CAKpQAyJqyb57LgVC4vM/g6Ftdca9JQ==
X-Received: by 2002:a5d:4845:: with SMTP id n5mr21970104wrs.353.1593110999984; 
 Thu, 25 Jun 2020 11:49:59 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id c65sm13273274wme.8.2020.06.25.11.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 11:49:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 17/17] block/nvme: Check BDRVNVMeState::plugged out of
 nvme_process_completion
Date: Thu, 25 Jun 2020 20:48:38 +0200
Message-Id: <20200625184838.28172-18-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200625184838.28172-1-philmd@redhat.com>
References: <20200625184838.28172-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 01:47:53
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

The queues are tied to the hardware, not to the block driver.
As this function doesn't need to know about the BDRVNVMeState,
move the 'plugged' check to the caller.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index b335dfdb73..03658776f4 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -318,7 +318,7 @@ static inline int nvme_translate_error(const NvmeCqe *c)
 }
 
 /* With q->lock */
-static bool nvme_process_completion(BDRVNVMeState *s, NVMeQueuePair *q)
+static bool nvme_process_completion(NVMeQueuePair *q)
 {
     bool progress = false;
     NVMeRequest *preq;
@@ -326,7 +326,7 @@ static bool nvme_process_completion(BDRVNVMeState *s, NVMeQueuePair *q)
     NvmeCqe *c;
 
     trace_nvme_process_completion(q->index, q->inflight);
-    if (q->busy || s->plugged) {
+    if (q->busy) {
         trace_nvme_process_completion_queue_busy(q->index);
         return false;
     }
@@ -408,8 +408,8 @@ static void nvme_submit_command(BDRVNVMeState *s, NVMeQueuePair *q,
     q->need_kick++;
     if (!s->plugged) {
         nvme_kick(q);
+        nvme_process_completion(q);
     }
-    nvme_process_completion(s, q);
     qemu_mutex_unlock(&q->lock);
 }
 
@@ -529,10 +529,13 @@ static bool nvme_poll_queues(BDRVNVMeState *s)
     bool progress = false;
     int i;
 
+    if (s->plugged) {
+        return false;
+    }
     for (i = 0; i < s->nr_queues; i++) {
         NVMeQueuePair *q = s->queues[i];
         qemu_mutex_lock(&q->lock);
-        while (nvme_process_completion(s, q)) {
+        while (nvme_process_completion(q)) {
             /* Keep polling */
             progress = true;
         }
@@ -1314,7 +1317,7 @@ static void nvme_aio_unplug(BlockDriverState *bs)
         NVMeQueuePair *q = s->queues[i];
         qemu_mutex_lock(&q->lock);
         nvme_kick(q);
-        nvme_process_completion(s, q);
+        nvme_process_completion(q);
         qemu_mutex_unlock(&q->lock);
     }
 }
-- 
2.21.3


