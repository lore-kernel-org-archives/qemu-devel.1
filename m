Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A3DC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEF7520724
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddZa1q92"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF7520724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrpqH-0004b6-Vt
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 17:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrpkt-0002Ss-Pv
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:31:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29984
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrpks-00041u-BO
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593898285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ob08smN6ZI4g8NRDF6m5BXTc3kBCbtPED0vqHga8qI4=;
 b=ddZa1q92yv8xAU+4Q8ywTGL+VNQ6Xohw57FJkPcnt0o78xIPYBOrCS7pUYx8x3Q7FS9/7n
 qEfCzGzeUM9boBgG/7/3ui9MPSvpltz5ZUMzop3C+nCtNnqEXuUMAFepA1JGGvM908UccW
 GxuTPIC8N998tVOs2r8idHEiykAH9ak=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-A_dqm35kOYq-NhZsHV3UVg-1; Sat, 04 Jul 2020 17:31:24 -0400
X-MC-Unique: A_dqm35kOYq-NhZsHV3UVg-1
Received: by mail-wr1-f69.google.com with SMTP id i14so36770482wru.17
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 14:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ob08smN6ZI4g8NRDF6m5BXTc3kBCbtPED0vqHga8qI4=;
 b=ehymDbht1HakxtZqzVUBLji+GxF6JA99MI1XpLumhZEjWd82yDF4zCTgg2B9jeaflb
 PSw5TRg2vfkOBDVG+TxhpQ1sbyhT/TEpDQa0SMWD2gIc2PKCeqCGqwGAGWqR/o6mRRUJ
 AD73o4gyW1Z3ZkBdoRec3+hL/v9nT3S9Q+T6O2moRSFArCUv+sGsU4a2aiekXW053LP8
 0drCLIyYtMpIvpfHbham1r1aFPkxueWZhhBFKuTiFRwIrgw3SMRfk6HmvIHnNFENgD0U
 d7wmGMaLLkDYE0lMr2KucBe9gyIUUSyK5bd7DL6FBljbi5aWdA/cPGdRvRHTRV/O+vVD
 C/gg==
X-Gm-Message-State: AOAM531j+Ehq3EXdFTERY4hqdeQskFSjS6K12RSQ+WwKrzFw3BPfK+bw
 F65zERowsBEfe5UTOGXfamgADWMAH/5ztSI71j4Rs0+5sEEfuOiClwk+rblRPRXDRLldzPyhxvO
 bsUxB8Bn7E7/+SpQ=
X-Received: by 2002:a1c:bb03:: with SMTP id l3mr3489137wmf.24.1593898282742;
 Sat, 04 Jul 2020 14:31:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzl4HZ2txqGViex8mKQYu2TxvYxlPMKyqf1QmlkIm0hWfj/7F37fIVVT9nHKtxTMtk7davrcg==
X-Received: by 2002:a1c:bb03:: with SMTP id l3mr3489123wmf.24.1593898282541;
 Sat, 04 Jul 2020 14:31:22 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 22sm18442029wmb.11.2020.07.04.14.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 14:31:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 06/16] block/nvme: Use common error path in
 nvme_add_io_queue()
Date: Sat,  4 Jul 2020 23:30:41 +0200
Message-Id: <20200704213051.19749-7-philmd@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 08:57:02
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

Rearrange nvme_add_io_queue() by using a common error path.
This will be proven useful in few commits where we add IRQ
notification to the IO queues.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 5898a2eab9..7bec52ca35 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -649,8 +649,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
     };
     if (nvme_cmd_sync(bs, s->queues[QUEUE_INDEX_ADMIN], &cmd)) {
         error_setg(errp, "Failed to create CQ io queue [%d]", n);
-        nvme_free_queue_pair(q);
-        return false;
+        goto out_error;
     }
     cmd = (NvmeCmd) {
         .opcode = NVME_ADM_CMD_CREATE_SQ,
@@ -660,13 +659,15 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
     };
     if (nvme_cmd_sync(bs, s->queues[QUEUE_INDEX_ADMIN], &cmd)) {
         error_setg(errp, "Failed to create SQ io queue [%d]", n);
-        nvme_free_queue_pair(q);
-        return false;
+        goto out_error;
     }
     s->queues = g_renew(NVMeQueuePair *, s->queues, n + 1);
     s->queues[n] = q;
     s->nr_queues++;
     return true;
+out_error:
+    nvme_free_queue_pair(q);
+    return false;
 }
 
 static bool nvme_poll_cb(void *opaque)
-- 
2.21.3


