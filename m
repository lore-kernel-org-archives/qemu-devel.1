Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF302C55178
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:48:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 253C32076D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJNepoLM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253C32076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY4Xc-0001n1-Vc
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 05:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4LA-0007z7-LV
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36941)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4L8-0006zK-S8
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603964126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6CxG9NMayv7lNoH0p7bnq04QWgTt0XfGriSybRVHEeM=;
 b=BJNepoLMw+gvZQgS1jOoYInFYD2+n5tW90+RHkd5AEfGQb460j8OWwd1cx8LEppz04Skw2
 A7UbeZsMw0PZiVXYWKQGtEfBUvwatzVQgVs37NqxjCcSMC/Lbxld9ckhYiUDqyMbVP+LjT
 Rv/ls88VdhXW7uGUZJDgdoBX/glltA8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-oIpCnK5QM5aNNpAUET7iHg-1; Thu, 29 Oct 2020 05:35:24 -0400
X-MC-Unique: oIpCnK5QM5aNNpAUET7iHg-1
Received: by mail-ed1-f72.google.com with SMTP id o2so956557edw.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 02:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6CxG9NMayv7lNoH0p7bnq04QWgTt0XfGriSybRVHEeM=;
 b=omHZR1KMc4fO26jm/hDi+OhuudA5ZuR1XKtoLtmal13YUGZG23XdztAWC6quJrYSx7
 wx3iIKFQB/dGTtXtIcIpLvdFrIHAYKxYF47DGn8+T4RX5vy0A6KEBQokcUI7DzlyBFWe
 22sbEqIe9o72iu87C3dIEwwWYYEAeXnE2X4VpWHNn/H0SY04VSqP9wX7p9fwYWlEAVaA
 x9ytj566FADBSXtVAMuySc8btn0UESN5w6WDFo92UaMURjRCsULsltsgAlwh3hpSEZoH
 wkEKkNAHs3GMuSO3o4CyzVqW+kKj83B1eyX9JYC/GooB46ExwqF0lHp6Z808M50EjlzK
 9R3A==
X-Gm-Message-State: AOAM533qeq6e638KMUPlAbgnvomuXfeJLpitgpYa00ivZqwlmIep+2K0
 8Gc77OH1jpV8kk4uyv1YNG8RixB11vI5b+U9+Oh1NsEkIpdb1S4iEHYxB+8fjqkokrUmxYChI+n
 T3YwVaRzDIog2LgM=
X-Received: by 2002:a17:906:ad8:: with SMTP id
 z24mr3088364ejf.222.1603964123089; 
 Thu, 29 Oct 2020 02:35:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwC+IWVYnxsFiNYMeoq8eRoPda2VfeSkfVEOq2EjdCKwWfduPOmGFFbe830j93S6av6NEoJ0A==
X-Received: by 2002:a17:906:ad8:: with SMTP id
 z24mr3088349ejf.222.1603964122892; 
 Thu, 29 Oct 2020 02:35:22 -0700 (PDT)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id z26sm1132422ejr.95.2020.10.29.02.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 02:35:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 v2 25/25] block/nvme: Simplify Completion Queue
 Command Identifier field use
Date: Thu, 29 Oct 2020 10:33:06 +0100
Message-Id: <20201029093306.1063879-26-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029093306.1063879-1-philmd@redhat.com>
References: <20201029093306.1063879-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Eric Auger <eric.auger@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The "Completion Queue Entry: DW 2" describes it as:

  This identifier is assigned by host software when
  the command is submitted to the Submission

As the is just an opaque cookie, it is pointless to byte-swap it.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index a06a188d530..e7723c42a6d 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -344,7 +344,7 @@ static inline int nvme_translate_error(const NvmeCqe *c)
         trace_nvme_error(le32_to_cpu(c->result),
                          le16_to_cpu(c->sq_head),
                          le16_to_cpu(c->sq_id),
-                         le16_to_cpu(c->cid),
+                         c->cid,
                          le16_to_cpu(status));
     }
     switch (status) {
@@ -401,7 +401,7 @@ static bool nvme_process_completion(NVMeQueuePair *q)
         if (!q->cq.head) {
             q->cq_phase = !q->cq_phase;
         }
-        cid = le16_to_cpu(c->cid);
+        cid = c->cid;
         if (cid == 0 || cid > NVME_QUEUE_SIZE) {
             warn_report("NVMe: Unexpected CID in completion queue: %"PRIu32", "
                         "queue size: %u", cid, NVME_QUEUE_SIZE);
@@ -469,7 +469,7 @@ static void nvme_submit_command(NVMeQueuePair *q, NVMeRequest *req,
     assert(!req->cb);
     req->cb = cb;
     req->opaque = opaque;
-    cmd->cid = cpu_to_le16(req->cid);
+    cmd->cid = req->cid;
 
     trace_nvme_submit_command(q->s, q->index, req->cid);
     nvme_trace_command(cmd);
-- 
2.26.2


