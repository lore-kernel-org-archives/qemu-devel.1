Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57717C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:05:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25E9A208A9
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GH0dcBlF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E9A208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8o0I-0004nX-Eg
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 13:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8nv7-0004sh-JE
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:00:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36256
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8nv4-0006Iq-5J
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597942805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=89Wjp5YSaeU8EmV0B/KKiK2s/vD3kpR2gM6yq2fyUAE=;
 b=GH0dcBlFVvTQnrHkvliw6VwvFwoC3c7MqaBFvEx6Hx+cXeDrpAzZUY1UzyKYN0+6QXBp+b
 ZaLcB7APcvbkM5omp4c2V9GhmIHhcbj8ndIGLpFLos3Vui/iMDyNLuxQipPlmUHuL85GUB
 IT3JwKqSTo3qYUO2KPIvoXIL4Ph4Z6I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-5KdO5mE0MR6DKTnkYekTyg-1; Thu, 20 Aug 2020 13:00:03 -0400
X-MC-Unique: 5KdO5mE0MR6DKTnkYekTyg-1
Received: by mail-wr1-f71.google.com with SMTP id t12so863101wrp.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 10:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=89Wjp5YSaeU8EmV0B/KKiK2s/vD3kpR2gM6yq2fyUAE=;
 b=ZTVRwQgWdXqAeQDBdmv95aCNZ52j02/sll3y5t7kLGwEsa0Lotg+7X5zn5Sl5+fnCh
 6beN/vApGOj0dJIRmJRItpDV+5c9NDoNE2p/5j7k0iJfK9dsW+TyagimhCIEUpMcl+ne
 3DibJIrRwZwhfmibV738K3jqBNftfYBSelq/e/sv1afciTQY31m6pY7LsDQap9Xb6LVP
 vt9UK51GeWO+rpcpYH03fpBu/fIpyMlj4LmNBMZE4Grlt8J0s9FeGtAXoYwXrbbCEcBU
 DAAISBrMs9Quju6osZGtLdSVkRlpiMVFNLPdkn8z4TNTyQeSp5kpHHqHTM5LtQpl/+nL
 lTew==
X-Gm-Message-State: AOAM530iVdn63Qzygy66U3ehHPVeob/Jy1VhYutecLMt4exT/ldyC0Wo
 9B+5Fdwo/yCkZ/uyIEWRvqU4BbNKlk9toAjP0mTCbZ3cUl93VVhQhpyHwG3STBAigNDswsgZMF7
 RjBJQhPzBZCy7Bew=
X-Received: by 2002:a1c:4e10:: with SMTP id g16mr4082112wmh.146.1597942802268; 
 Thu, 20 Aug 2020 10:00:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+ZuOvD8GbaS8VltipExEIdiLWXcqS8uRCrSOJugg9wZ4Kxifn7KyGDPRqBu/5p5Ah7YHxzg==
X-Received: by 2002:a1c:4e10:: with SMTP id g16mr4082097wmh.146.1597942802068; 
 Thu, 20 Aug 2020 10:00:02 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id k4sm5776361wrd.72.2020.08.20.10.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 10:00:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 11/15] block/nvme: Simplify nvme_init_queue() arguments
Date: Thu, 20 Aug 2020 18:58:57 +0200
Message-Id: <20200820165901.1139109-12-philmd@redhat.com>
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

nvme_init_queue() doesn't require BlockDriverState anymore.
Replace it by BDRVNVMeState to simplify.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index f180078e781..5b69fc75a60 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -165,10 +165,9 @@ static QemuOptsList runtime_opts = {
     },
 };
 
-static void nvme_init_queue(BlockDriverState *bs, NVMeQueue *q,
+static void nvme_init_queue(BDRVNVMeState *s, NVMeQueue *q,
                             int nentries, int entry_bytes, Error **errp)
 {
-    BDRVNVMeState *s = bs->opaque;
     size_t bytes;
     int r;
 
@@ -251,14 +250,14 @@ static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
         req->prp_list_iova = prp_list_iova + i * s->page_size;
     }
 
-    nvme_init_queue(bs, &q->sq, size, NVME_SQ_ENTRY_BYTES, &local_err);
+    nvme_init_queue(s, &q->sq, size, NVME_SQ_ENTRY_BYTES, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto fail;
     }
     q->sq.doorbell = &s->regs->doorbells[idx * 2 * s->doorbell_scale];
 
-    nvme_init_queue(bs, &q->cq, size, NVME_CQ_ENTRY_BYTES, &local_err);
+    nvme_init_queue(s, &q->cq, size, NVME_CQ_ENTRY_BYTES, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto fail;
-- 
2.26.2


