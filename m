Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F95C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F06520674
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cg4oz1JE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F06520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg9JM-0003JL-BJ
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 11:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jg9Hz-00024b-8v
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:57:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45429
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jg9Hy-0001Tt-B1
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591113437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9ZrbSNIPo8XU4Y5RaXAFzlgvCAK46llYw9ANIsbKyuw=;
 b=cg4oz1JEwkHy/MzWxlAWdfri8XlT4D1l59UNd8ZB7ByaCJbsC4vk2iKopD/hQu6w+uemDe
 rPCeC6S9TVWMtg1BS07+w1lw49YSUgrOzg6AiMuZydYw+nINt5PTYeEijpqEUkrS9kFJP3
 M8Oo3v7+SjJK3eN50+XOvb2jfPzkTy4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-16uwhoxzN0GO0oqPFwEoZg-1; Tue, 02 Jun 2020 11:57:13 -0400
X-MC-Unique: 16uwhoxzN0GO0oqPFwEoZg-1
Received: by mail-wm1-f71.google.com with SMTP id v23so1124110wmj.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 08:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9ZrbSNIPo8XU4Y5RaXAFzlgvCAK46llYw9ANIsbKyuw=;
 b=CBvGfGoDh0iYOEuVKDTryb0AhkPU5figjLh4d1BxS9S6AKAqaByIz3/RldBeHxd35f
 EHlhBZgGaVYKupaZ5N3BEfVQlArg3z+NCHyjJSqr2Ws2+HzkA0ba+JUaONVdCJoBCQJ3
 KzeyNBhykQoV1RE17W2WKtaQi8Vi9jn5PjWin8gxTnbRcNkFobMGbkLGEgzK2yjS62eH
 dT+ftSMD79ZoElppdhONbjr+q82ss5qidiu47AH1duebTILq50Bgq0BciQic2F4+D41e
 V9bl3+JggGfdev6x27YlFMaPdXvG/jG4CMM8PlMrLylKffuBTjUrQQ6u754tQH9N3G1k
 atoA==
X-Gm-Message-State: AOAM53162d4LQDjQkkG0jiEOtbcnT1f1wX3cPRqyxP4YT0ZjHJj49FeP
 C1Gztd08a22OuqHEYyCzHawPE5kZvCjm6CCCthlKmeEhQc2OhlFM/nUBrHmPaidGIvzpf6P6hyM
 VvKjawDQt7qlA9rI=
X-Received: by 2002:a1c:9e52:: with SMTP id h79mr4727484wme.84.1591113431773; 
 Tue, 02 Jun 2020 08:57:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJPh4NiiAOy5cr7Kbo0emuHdL+KO7DQ5DYIYpCMqZ+gpBJ6jD75M2SZ6wWbGlNvgnsKhxCCA==
X-Received: by 2002:a1c:9e52:: with SMTP id h79mr4727464wme.84.1591113431596; 
 Tue, 02 Jun 2020 08:57:11 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id w3sm168052wmg.44.2020.06.02.08.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 08:57:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/block/nvme: Verify msix_vector_use() returned value
Date: Tue,  2 Jun 2020 17:57:09 +0200
Message-Id: <20200602155709.9776-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 03:23:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

msix_vector_use() returns -EINVAL on error. Assert it won't.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Notes taken while reviewing:
https://www.mail-archive.com/qemu-block@nongnu.org/msg66831.html
Based-on: <20200514044611.734782-1-its@irrelevant.dk>
---
 hw/block/nvme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 0cb54d902d..5fee563e99 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -613,6 +613,10 @@ static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeCmd *cmd)
 static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
     uint16_t cqid, uint16_t vector, uint16_t size, uint16_t irq_enabled)
 {
+    int ret;
+
+    ret = msix_vector_use(&n->parent_obj, vector);
+    assert(ret == 0);
     cq->ctrl = n;
     cq->cqid = cqid;
     cq->size = size;
@@ -623,7 +627,6 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
     cq->head = cq->tail = 0;
     QTAILQ_INIT(&cq->req_list);
     QTAILQ_INIT(&cq->sq_list);
-    msix_vector_use(&n->parent_obj, cq->vector);
     n->cq[cqid] = cq;
     cq->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_post_cqes, cq);
 }
-- 
2.21.3


