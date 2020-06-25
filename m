Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E53C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:57:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76C6B204EA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwxrOI0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C6B204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joX4P-0005st-Nk
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWwI-0000MX-OB
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:49:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29464
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWwH-0001C4-3d
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593110972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=izV+fRnoW0opUs4fFUxBkpZIhd4njeKjvqFWAFiEQRg=;
 b=GwxrOI0hvdnyAojoGEwu+mMQ57nV1eTXh8LeeyvT75jDU/OzqqYqjWtdz1AANkIu3yHxCx
 E5BIFdNDziVznECRNdyp4qw4wn4GItGERga5Bs/xRUud9wNHu4jx+tCiR0bIMqv8wTtaKT
 ot4q5AXtXAwT7a35Q1i5Yuw81Y9C6+w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-XJFKTFZAP4invq0XXM3ofw-1; Thu, 25 Jun 2020 14:49:28 -0400
X-MC-Unique: XJFKTFZAP4invq0XXM3ofw-1
Received: by mail-wr1-f69.google.com with SMTP id 59so1077947wrp.4
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 11:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=izV+fRnoW0opUs4fFUxBkpZIhd4njeKjvqFWAFiEQRg=;
 b=PQYadaF+omZBuZZnbAXBhf4RiAlGJUxvxB6nIAkflYU2WE8dYiPu+Cpl935P1V6XiO
 v84Mr6/SS8ivWmgvgELCodSeXp4UGhbgA6H6k8Z09eBw6pPeD9CHYRNQfB75esN/hWhE
 /bmy3JT+gDDPiJa1jD2HU5LM91mo+YiwADd+cHq+SAigTFk2HoSGrV5Av4mp2+M+4pGk
 F/558BDfWzm+0S8297hHamoDnO7ycuWRMyTPCbTLX6x49NBFawRLw5mqsUWazorr8Znx
 cYwIKdMnXLajtIol09lDVyusz+F2k+s1vDPUTIEuIw8y0IRYDVnZYWqtUSzNS5OD1VA6
 prvw==
X-Gm-Message-State: AOAM532e8gVwVGuLb/8wMmLI2brZZTIhcLqnI/7Kn90b+cznNMCKnzXM
 SZNBGzAQRnXqf2c9K5TWjJA8IIKYDhORAxbXqNt8gBSz9Zwmo5DdHPedMaY7qFm/VS+PBf9AjrO
 Yn5z8djZkXbPM1pc=
X-Received: by 2002:adf:df10:: with SMTP id y16mr1397294wrl.225.1593110967486; 
 Thu, 25 Jun 2020 11:49:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsPYlJcNfRMt6ytvc3Zunww4+rLme7PDADNfN3PUo5K+rcY2b9DhEMJxwSGoKtG+u2p498cg==
X-Received: by 2002:adf:df10:: with SMTP id y16mr1397277wrl.225.1593110967334; 
 Thu, 25 Jun 2020 11:49:27 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id c70sm13236668wme.32.2020.06.25.11.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 11:49:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 10/17] block/nvme: Simplify nvme_init_queue() arguments
Date: Thu, 25 Jun 2020 20:48:31 +0200
Message-Id: <20200625184838.28172-11-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200625184838.28172-1-philmd@redhat.com>
References: <20200625184838.28172-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
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

nvme_init_queue() doesn't require BlockDriverState anymore.
Replace it by BDRVNVMeState to simplify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index f87f157dc0..8b6cf4c34b 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -149,10 +149,9 @@ static QemuOptsList runtime_opts = {
     },
 };
 
-static void nvme_init_queue(BlockDriverState *bs, NVMeQueue *q,
+static void nvme_init_queue(BDRVNVMeState *s, NVMeQueue *q,
                             int nentries, int entry_bytes, Error **errp)
 {
-    BDRVNVMeState *s = bs->opaque;
     size_t bytes;
     int r;
 
@@ -225,14 +224,14 @@ static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
         req->prp_list_page = q->prp_list_pages + i * s->page_size;
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
2.21.3


