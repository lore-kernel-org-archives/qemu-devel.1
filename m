Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AABFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:59:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E7C204EA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKqzdiEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E7C204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joX6F-0000Ha-EE
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWwV-0000Xx-5l
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:49:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58261
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWwT-0001Eb-GG
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593110984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nIyn1saCYFaGdm81Oq09Kelp7+BVTinz9yQeBa0Ppdk=;
 b=eKqzdiEHYDpWr3eIunwBJWZb0yNTIcwCtLx1rrJwB/5w8QlE01b53zlfxWg1FfMNWHpRMb
 u8stBlaTS3DtRL6KHjuRSaATYRfMMnSN9cnqftv6E3UawXyHEHo8mvgxC1OErjbJjiPA5S
 wMXDzAr+c/I1yw5utVgj76thyOvrBdw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-rM6LbJIcMcOQalWV-RDAtA-1; Thu, 25 Jun 2020 14:49:43 -0400
X-MC-Unique: rM6LbJIcMcOQalWV-RDAtA-1
Received: by mail-wm1-f71.google.com with SMTP id b13so5759504wme.9
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 11:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nIyn1saCYFaGdm81Oq09Kelp7+BVTinz9yQeBa0Ppdk=;
 b=hHUenbVKrDVisnSYffdkjRsimUqdSoxG1pbrN0LeCDGz5Kl/mUBHZBkAkMPQVe5KYC
 hqfA8beUiwz9PC7onmSevtdBKpD7PGkY03S4WGcSjU5vf2lf5rSgzCcDxWkbqqczUOsN
 v+fQQScUA8AniqXBY5YMbGnjz85hBU0Ox6kJdq/++FkoBFUCVGexMn1BVzfVzC5eKpFQ
 2Bn6Zcq9tLCqq3dXY2GSXpKxkqZEQ68Ig2Vx+5o4LLkelNuvkNan8RHncYP7g8b1ch64
 zE2nE1vD2khnVgbE+17OrYFcrolDBz9Hatnzs+4vxRI+BJrY/FjQTo4D+IlPQmkteSbt
 OyMQ==
X-Gm-Message-State: AOAM532Ql3yikNOYn30RP+5O5A2AHTheZzb0M657+xmVMKPgD4TVSQBf
 EpsdnKBQJLD150K/AQ9tNiZxTsb4+flLFCZRO+G4zsl3cnPyEAMelBw+hig0JI3LsD+ZA6cKz7q
 sdFffur5Ow1BRsIY=
X-Received: by 2002:a7b:cc92:: with SMTP id p18mr5116307wma.4.1593110981539;
 Thu, 25 Jun 2020 11:49:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrN5WhKifX3bF6GBGntQNfgDBAxDswnG/6+iyql1L1EUDXPF1e2r0kZ4ACoEUb4ZtxxdaK4A==
X-Received: by 2002:a7b:cc92:: with SMTP id p18mr5116294wma.4.1593110981383;
 Thu, 25 Jun 2020 11:49:41 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o9sm32321361wrs.1.2020.06.25.11.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 11:49:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 13/17] block/nvme: Simplify completion trace events
Date: Thu, 25 Jun 2020 20:48:34 +0200
Message-Id: <20200625184838.28172-14-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200625184838.28172-1-philmd@redhat.com>
References: <20200625184838.28172-1-philmd@redhat.com>
MIME-Version: 1.0
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

The queues are tied to the hardware, logging the block
driver using them is irrelevant.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c       | 6 +++---
 block/trace-events | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 4d2f31a9b3..7b983ba4e1 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -323,9 +323,9 @@ static bool nvme_process_completion(BDRVNVMeState *s, NVMeQueuePair *q)
     NVMeRequest req;
     NvmeCqe *c;
 
-    trace_nvme_process_completion(s, q->index, q->inflight);
+    trace_nvme_process_completion(q->index, q->inflight);
     if (q->busy || s->plugged) {
-        trace_nvme_process_completion_queue_busy(s, q->index);
+        trace_nvme_process_completion_queue_busy(q->index);
         return false;
     }
     q->busy = true;
@@ -347,7 +347,7 @@ static bool nvme_process_completion(BDRVNVMeState *s, NVMeQueuePair *q)
             continue;
         }
         assert(cid <= NVME_QUEUE_SIZE);
-        trace_nvme_complete_command(s, q->index, cid);
+        trace_nvme_complete_command(q->index, cid);
         preq = &q->reqs[cid - 1];
         req = *preq;
         assert(req.cid == cid);
diff --git a/block/trace-events b/block/trace-events
index f0c476110b..8c29818093 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -157,9 +157,9 @@ vxhs_get_creds(const char *cacert, const char *client_key, const char *client_ce
 nvme_kick(int queue) "queue %d"
 nvme_dma_flush_queue_wait(void *s) "s %p"
 nvme_error(int cmd_specific, int sq_head, int sqid, int cid, int status) "cmd_specific %d sq_head %d sqid %d cid %d status 0x%x"
-nvme_process_completion(void *s, int index, int inflight) "s %p queue %d inflight %d"
-nvme_process_completion_queue_busy(void *s, int index) "s %p queue %d"
-nvme_complete_command(void *s, int index, int cid) "s %p queue %d cid %d"
+nvme_process_completion(int index, int inflight) "queue %d inflight %d"
+nvme_process_completion_queue_busy(int index) "queue %d"
+nvme_complete_command(int index, int cid) "queue %d cid %d"
 nvme_submit_command(void *s, int index, int cid) "s %p queue %d cid %d"
 nvme_submit_command_raw(int c0, int c1, int c2, int c3, int c4, int c5, int c6, int c7) "%02x %02x %02x %02x %02x %02x %02x %02x"
 nvme_handle_event(void *s) "s %p"
-- 
2.21.3


