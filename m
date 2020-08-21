Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80849C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 20:01:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 467F52072D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 20:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XeiuPO1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467F52072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9DER-0002zu-Gx
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 16:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9D7x-0007zW-UZ
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:55:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9D7v-0002mP-0f
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598039702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NuSKQWVrMs8vraRihCSu39r/qzyDiytcvGfDb3sY9wM=;
 b=XeiuPO1SL6neUUNNyzRjHTzor04Xeij2Tx6XEW72CT6h+DsVSBtR+ZZF+xY5tCAsG+oyv8
 8VmaSCSRRDY1DXJ8fJ37zpFVWRlNLJQkSYD/1dA8iB74i54M2d95MTf64HZgkjfSe0iQAI
 LyTNAGykhpZHzCk+VaBsB58S/TYZyJQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-_bOBlJhcNEOaFUTa3gqKrQ-1; Fri, 21 Aug 2020 15:55:01 -0400
X-MC-Unique: _bOBlJhcNEOaFUTa3gqKrQ-1
Received: by mail-wm1-f71.google.com with SMTP id q23so967027wmj.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 12:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NuSKQWVrMs8vraRihCSu39r/qzyDiytcvGfDb3sY9wM=;
 b=gROBEX350gF5osRbDppfsJ4w3xPvAcJcyvUCC2xjkoMTmC6y5nLAv2p8SHH1Bivs0l
 uHB0/TMpgfTquZYkFxbt3J3kd076v3Wz1jw5Q2uM03QcoxAac5oKScEFGBygZyu8XEz8
 1zS1MhUtMPzU5Wm+k8JNF6OJqbOEO9eINQaLP8Sa/KYiHNWbqsuRLyP9AFOSwOxJUJIe
 5YLU6MR1KbI198frhGST9oSvyfu7RAXHFY1ziylSCbmHIzy/qO4AojW/DVIleSLybcxO
 iCkCiWYWKpjaka1/iAhf17lzeXJsO9WG38/oVKC4U4XvGE/4A9pjU0qxLkIWClC4aeKI
 u6SQ==
X-Gm-Message-State: AOAM533nEVuk0VPmxobBZrgA/SFPDGvZiamXAoKw3Ze3m3M/ai5C+Pgf
 2DQT3ojAoXOrBRSpEgpfEu4R02QTxrh4vI+rZam9ywoip3Yp8Vc+86fK29b+VeUAXpmTFye9F6E
 6cw3iJwwq0VY5tDI=
X-Received: by 2002:a7b:cc0b:: with SMTP id f11mr5583590wmh.31.1598039699485; 
 Fri, 21 Aug 2020 12:54:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6ulkCCJMaE+uybsKbrr7aGFvRoA2uMVEhGiA76MIX/fwbV0O9u2wfNic3WNs75VeOjcSQTQ==
X-Received: by 2002:a7b:cc0b:: with SMTP id f11mr5583570wmh.31.1598039699286; 
 Fri, 21 Aug 2020 12:54:59 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id x11sm6353387wrl.28.2020.08.21.12.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 12:54:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 11/15] block/nvme: Simplify nvme_init_queue() arguments
Date: Fri, 21 Aug 2020 21:53:55 +0200
Message-Id: <20200821195359.1285345-12-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821195359.1285345-1-philmd@redhat.com>
References: <20200821195359.1285345-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:26:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

nvme_init_queue() doesn't require BlockDriverState anymore.
Replace it by BDRVNVMeState to simplify.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 3742e0535aa..f98ca067144 100644
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


