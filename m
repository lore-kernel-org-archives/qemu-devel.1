Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E05EC55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:37:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A93B622264
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OeKM1+nq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93B622264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQ64-0007Xq-Dw
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPUE-0004Eh-EO
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:58:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37994)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPUC-0004YD-Ks
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603807083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xm7DOhBe3iyYOLIHKljm0VOmYGJ+D2G+GQFpjtxbZOQ=;
 b=OeKM1+nqEkXHzq9XnLfViWsIrbUzNNfSJGmPQfswKOFILRN3ZpXUFKVjSdkvmm+usxKh3i
 lpGVcn7vtQ9mwq3xRO/SmiH01GbSEKeeLUPymiXhv0ovtFen+3qGN5pWI8IwBXjHyTJY7X
 qursqU6kV3E+b4zEdIWHqR7HA49Uk/M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-Yn09YSNgN3yxCmQUL7MaOA-1; Tue, 27 Oct 2020 09:58:01 -0400
X-MC-Unique: Yn09YSNgN3yxCmQUL7MaOA-1
Received: by mail-ej1-f72.google.com with SMTP id d12so880966ejr.19
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xm7DOhBe3iyYOLIHKljm0VOmYGJ+D2G+GQFpjtxbZOQ=;
 b=RQirgzKnk1bKLsk8sU5ojnZTI45Cvm0GAOynY2uBMydhhs9giCF9/hc3PSO24M+cit
 r3jtlpiknQ2F+vLdxsumv4qP00eCkzMzDhdrHkYcm/Gls3zMblQrZR4za2dkCM0vT6Hi
 WkvcsG8QjhmNW0RKszt9zwUf2e8ZHjqgSYTi507CPZCvfMt9RVOIlrshCxuOLEROc0Vs
 nNxSAOXcIx4bvzhWX/S/iOQLMXvylW9TTUwz54PFhVImr+8sSTr+8NZvQUwkjoNZYXjS
 vjDm4g1O08TGX3hY5R823C59ZOL2yNwLDDwMHInYgQNORUBa+KzIbAuJKBPE4ghV2rOl
 USDQ==
X-Gm-Message-State: AOAM532NOZXXtcA/AGW+ve0mB93qDMcHRLrJgwfPDIBBDVTOCc7kKgrT
 MfBinu/JzNUWosA2FIfsTvkQde9TRLw54jBLq7wvhBAf0tNDmTQ9fcu6L/sAN5cCCCbf1fXkSgp
 Vm7zboUjW8//h+uQ=
X-Received: by 2002:a17:906:2dc7:: with SMTP id
 h7mr2638991eji.546.1603807079522; 
 Tue, 27 Oct 2020 06:57:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWKxF53GuI7DB3LBnIlx/SCjKP14ed38wRlih8sAJZ/8YOthHVUwVuFSqQQTeiaC3xnaIDFw==
X-Received: by 2002:a17:906:2dc7:: with SMTP id
 h7mr2638968eji.546.1603807079354; 
 Tue, 27 Oct 2020 06:57:59 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id e2sm1095439ejd.81.2020.10.27.06.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 06:57:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 24/25] block/nvme: Align iov's va and size on host page size
Date: Tue, 27 Oct 2020 14:55:46 +0100
Message-Id: <20201027135547.374946-25-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027135547.374946-1-philmd@redhat.com>
References: <20201027135547.374946-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
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
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index e3626045565..c1c52bae44f 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1018,11 +1018,12 @@ static coroutine_fn int nvme_cmd_map_qiov(BlockDriverState *bs, NvmeCmd *cmd,
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
@@ -1166,8 +1167,9 @@ static inline bool nvme_qiov_aligned(BlockDriverState *bs,
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
@@ -1183,7 +1185,7 @@ static int nvme_co_prw(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     int r;
     uint8_t *buf = NULL;
     QEMUIOVector local_qiov;
-
+    size_t len = QEMU_ALIGN_UP(bytes, qemu_real_host_page_size);
     assert(QEMU_IS_ALIGNED(offset, s->page_size));
     assert(QEMU_IS_ALIGNED(bytes, s->page_size));
     assert(bytes <= s->max_transfer);
@@ -1193,7 +1195,7 @@ static int nvme_co_prw(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     }
     s->stats.unaligned_accesses++;
     trace_nvme_prw_buffered(s, offset, bytes, qiov->niov, is_write);
-    buf = qemu_try_memalign(s->page_size, bytes);
+    buf = qemu_try_memalign(qemu_real_host_page_size, len);
 
     if (!buf) {
         return -ENOMEM;
-- 
2.26.2


