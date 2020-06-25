Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AF0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:59:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 033D9204EA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RkordxYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033D9204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joX6J-0000Og-9w
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWwj-00011P-CL
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:50:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54712
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWwg-0001Hy-W5
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593110998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W4wec89u4s96YVwMymO+Q5mdvwnxmENfWLL0RnTiJ8Y=;
 b=RkordxYH0w+0SRM/pxwP4JHP1fJoEvXweA1WjHupvwaswkbmMakxp+Hqy3+UkPnO+r4XXc
 whO59NMx+Z+dROunUEbklovfWM8rEdz+f1XIS5/XjZn4s4i6WSuPphF0yM/rnDa+nNA3ML
 nWDE98UCuYEDMs+65A022tF/Q4b1YEQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-hdrtvRq8PwuNm1bFcQ4V8A-1; Thu, 25 Jun 2020 14:49:56 -0400
X-MC-Unique: hdrtvRq8PwuNm1bFcQ4V8A-1
Received: by mail-wr1-f70.google.com with SMTP id y16so7685830wrr.20
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 11:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W4wec89u4s96YVwMymO+Q5mdvwnxmENfWLL0RnTiJ8Y=;
 b=hCPgfROVMI5WV/dbSoLmQC68uU0qadGdFQj0EVXO5PVJH0wdKTyRxFSycEMykm/TiS
 sPfKMVDWUot0ZBOOQ1e2KcHzW2Ibpf1Pc9VYWdGlMxeasxTIFQgFFfbN9aEmZU6CyGnL
 KNcXl4H25CqVzF5py7MTLapESzctQRLtaW3Bxx0Ycn2MLqH682MQ639LmzdB55xtDlq2
 wSLCC7SdhKPwaIVHQ0hO/WGA0wK8HqpH0Pe6DMJADDbB+LQt4ZZSqQqXxLrE/1T67yT3
 1FtZz5qpTBD0p7N9zVVXmZl0DxvhHWA2rjhanR+TV6o+JtuC2ERU1JVXfe9eQOcYalzE
 ft2w==
X-Gm-Message-State: AOAM5329MTrDxw0ihI3d+2O7Zk/tzEfkZerH2xK5hPmwmKvx2SwodGBg
 //BrmySRa8xmRup7QvTc/jmq1yBhVXcCUc5eYG8pn4FtlJEXbChbTzrW3QnwXTsgs8kfGDMUDiw
 eKqWf5RGDOQePZG0=
X-Received: by 2002:adf:dd83:: with SMTP id x3mr37799049wrl.292.1593110995503; 
 Thu, 25 Jun 2020 11:49:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQ8HuyoF1owJXlan8Mtv2B7sWMA6iZuvUTAzosX7lgFT6esWUQ6gxu10pFu5ntVniIChwEyA==
X-Received: by 2002:adf:dd83:: with SMTP id x3mr37799031wrl.292.1593110995352; 
 Thu, 25 Jun 2020 11:49:55 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id z132sm7830713wmb.21.2020.06.25.11.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 11:49:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 16/17] block/nvme: Check BDRVNVMeState::plugged out of
 nvme_kick()
Date: Thu, 25 Jun 2020 20:48:37 +0200
Message-Id: <20200625184838.28172-17-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200625184838.28172-1-philmd@redhat.com>
References: <20200625184838.28172-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
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
Since in nvme_aio_unplug() we know that s->plugged is false,
we don't need the check.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 0f7cc568ef..b335dfdb73 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -246,9 +246,9 @@ fail:
 }
 
 /* With q->lock */
-static void nvme_kick(BDRVNVMeState *s, NVMeQueuePair *q)
+static void nvme_kick(NVMeQueuePair *q)
 {
-    if (s->plugged || !q->need_kick) {
+    if (!q->need_kick) {
         return;
     }
     trace_nvme_kick(q->index);
@@ -406,7 +406,9 @@ static void nvme_submit_command(BDRVNVMeState *s, NVMeQueuePair *q,
            q->sq.tail * NVME_SQ_ENTRY_BYTES, cmd, sizeof(*cmd));
     q->sq.tail = (q->sq.tail + 1) % NVME_QUEUE_SIZE;
     q->need_kick++;
-    nvme_kick(s, q);
+    if (!s->plugged) {
+        nvme_kick(q);
+    }
     nvme_process_completion(s, q);
     qemu_mutex_unlock(&q->lock);
 }
@@ -1311,7 +1313,7 @@ static void nvme_aio_unplug(BlockDriverState *bs)
     for (i = QUEUE_INDEX_IO(0); i < s->nr_queues; i++) {
         NVMeQueuePair *q = s->queues[i];
         qemu_mutex_lock(&q->lock);
-        nvme_kick(s, q);
+        nvme_kick(q);
         nvme_process_completion(s, q);
         qemu_mutex_unlock(&q->lock);
     }
-- 
2.21.3


