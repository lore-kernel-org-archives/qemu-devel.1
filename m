Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144DEC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:46:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844A52076D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZB+lcUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844A52076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY4VW-0006TI-6L
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 05:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4Kw-0007XO-Tk
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:35:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57547)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4Kt-0006v9-AW
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603964110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ebpGRl8V/SQHWtFmQyZ24PuNhlns0+asaugWNkot24=;
 b=YZB+lcUH/UulU+lYN7O22YvOniWGaSgxlJ6ydxU49Nvxa7joArMHd3M56bSHY2hWVhsiBK
 oMFWfqzW8N1j+jFASntG0zZJJkvr90277PDUNgdZO+PQFSs1FGeH1I1Ozl8yvHwBP8MEpc
 ZsJO47V9JUrIf8UBak2pKxsfCpG1rzc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-FSQNrRK4NRq85nPtBPBi4A-1; Thu, 29 Oct 2020 05:35:08 -0400
X-MC-Unique: FSQNrRK4NRq85nPtBPBi4A-1
Received: by mail-ej1-f70.google.com with SMTP id o27so929514eji.12
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 02:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8ebpGRl8V/SQHWtFmQyZ24PuNhlns0+asaugWNkot24=;
 b=ifRLNHcyaryjsYGtgZ8WVkn2KbeQOLxAtMODKYudMULzH+OSW/CpCbMVPj418UAPUj
 yioWcjcLQW3fyFPE08fhdMlKRRqanvuEAUxe82kFsyrMrZyunJYxpOwbZH5bZQUSt8OJ
 udn2ZoZkld9neLlf48h3XMqJpqg+5SXa55JHFaPrPKxoFFLyoEsJEL0c+VUCvX8AO6Zo
 y8eutgjcsQq9z8AFkxG/NUbFKl6WBFdadfhp9G/Ylp3ALm436sZVJvPjeEIGer1zeL8E
 VXyvPlGgarYPQ7MiSTHJNiOKNplSlgzRGTZvy8hJtuyjjVKoJkfihR5ZGttcLj2ZXEg0
 LiMQ==
X-Gm-Message-State: AOAM533ZSaKCf2gTl+m/p90vuk5cSnGcqW3PWZtpjqd/9p8CG9YJLOPq
 ObvRDOcSlIMl6whotDzeHI8g+U0mLZHPvmHiCL7+1gdPdSV1gcSGwx080HiQy+qPUeRBdswWndx
 uOiAQ8/ayEQCHTHE=
X-Received: by 2002:a05:6402:1004:: with SMTP id
 c4mr3001094edu.149.1603964107186; 
 Thu, 29 Oct 2020 02:35:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydv1/hzCveV0yJGEQIelPM8p1TF/vx6Lv0Ya7VjwzOzBrXzGv+iGdES7KEf2jLrzvvLRSAlA==
X-Received: by 2002:a05:6402:1004:: with SMTP id
 c4mr3001077edu.149.1603964107030; 
 Thu, 29 Oct 2020 02:35:07 -0700 (PDT)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id ds7sm1162895ejc.83.2020.10.29.02.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 02:35:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2 22/25] block/nvme: Align iov's va and size on host
 page size
Date: Thu, 29 Oct 2020 10:33:03 +0100
Message-Id: <20201029093306.1063879-23-philmd@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

Make sure iov's va and size are properly aligned on the
host page size.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index e807dd56dfe..f1e2fd34cdf 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1015,11 +1015,12 @@ static coroutine_fn int nvme_cmd_map_qiov(BlockDriverState *bs, NvmeCmd *cmd,
     for (i = 0; i < qiov->niov; ++i) {
         bool retry = true;
         uint64_t iova;
+        size_t len = QEMU_ALIGN_UP(qiov->iov[i].iov_len,
+                                   qemu_real_host_page_size);
 try_map:
         r = qemu_vfio_dma_map(s->vfio,
                               qiov->iov[i].iov_base,
-                              qiov->iov[i].iov_len,
-                              true, &iova);
+                              len, true, &iova);
         if (r == -ENOMEM && retry) {
             retry = false;
             trace_nvme_dma_flush_queue_wait(s);
@@ -1163,8 +1164,9 @@ static inline bool nvme_qiov_aligned(BlockDriverState *bs,
     BDRVNVMeState *s = bs->opaque;
 
     for (i = 0; i < qiov->niov; ++i) {
-        if (!QEMU_PTR_IS_ALIGNED(qiov->iov[i].iov_base, s->page_size) ||
-            !QEMU_IS_ALIGNED(qiov->iov[i].iov_len, s->page_size)) {
+        if (!QEMU_PTR_IS_ALIGNED(qiov->iov[i].iov_base,
+                                 qemu_real_host_page_size) ||
+            !QEMU_IS_ALIGNED(qiov->iov[i].iov_len, qemu_real_host_page_size)) {
             trace_nvme_qiov_unaligned(qiov, i, qiov->iov[i].iov_base,
                                       qiov->iov[i].iov_len, s->page_size);
             return false;
@@ -1180,7 +1182,7 @@ static int nvme_co_prw(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     int r;
     uint8_t *buf = NULL;
     QEMUIOVector local_qiov;
-
+    size_t len = QEMU_ALIGN_UP(bytes, qemu_real_host_page_size);
     assert(QEMU_IS_ALIGNED(offset, s->page_size));
     assert(QEMU_IS_ALIGNED(bytes, s->page_size));
     assert(bytes <= s->max_transfer);
@@ -1190,7 +1192,7 @@ static int nvme_co_prw(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     }
     s->stats.unaligned_accesses++;
     trace_nvme_prw_buffered(s, offset, bytes, qiov->niov, is_write);
-    buf = qemu_try_memalign(s->page_size, bytes);
+    buf = qemu_try_memalign(qemu_real_host_page_size, len);
 
     if (!buf) {
         return -ENOMEM;
-- 
2.26.2


