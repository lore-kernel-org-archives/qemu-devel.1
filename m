Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586BBC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E975922265
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0Yqr9he"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E975922265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPic-0004Ij-2F
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPTC-0003Pi-PL
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:57:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25535)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPT9-0004MF-JV
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603807017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5UNrRYGfWn9M8qfpcFzDzOyggHy+DoEp25W1xSNXQns=;
 b=Z0Yqr9he0hGartmW0UQiTM59H3oJahK10kw01rQ9ilL/qKVtR8sl5kPErOmEti99R3/NuK
 GLg6+lWq43byGVZpdSu1oTRY3chUetJXViYryFnZT9g8QjtaVxGxeAU4RQ/5fJVIqhdzTV
 XUTlK42iETBGiKGbUbdTWKG0ghANLiE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-NVA_UoT7O165KWQe9EN8xA-1; Tue, 27 Oct 2020 09:56:55 -0400
X-MC-Unique: NVA_UoT7O165KWQe9EN8xA-1
Received: by mail-ej1-f71.google.com with SMTP id f11so858280eja.23
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5UNrRYGfWn9M8qfpcFzDzOyggHy+DoEp25W1xSNXQns=;
 b=ijcCwOIrXo16ETyG/KEkSHjJA1nutDuE/1hFuz/eV0vp4HpMJT9FM4u2g4vuxdfM5c
 3jLZcq0tj8vQ/S5WpA5m2yribzLMAfYlzgcc4I0IGVdgtj87NkrtaTG7utw3JnCp3rPm
 ARmWwijS7r7/lxUHg/wVYQCHNK/AXUwbc2CMGweFmND/VOS7bp7jcPDlYfs8XAOsfT4+
 p2a5JZDXvMAKz0w+Td/N8ME3lJVyuGFz3V1Q8FmCL3OL1dliNxGuLMeGgguLjAshHMPJ
 R6uW8XNNc8sQYfGNjWIGzhAcEfgv37k0u2M0VKkTHzFqhcRf8DpUlTLrjG9vD7+IfC26
 pazA==
X-Gm-Message-State: AOAM533ftU6mADkXv40RDTP3WP3uCNHrgjNuogoHMT1uPJuc8o5NilTC
 GGyq5adxVfFWA3Pzd+5xskRNkj/+9t+U+1PpqOvgpS5Oogwvp/CPe4AaEJqJAIdT+rWfO+Go768
 44y/t13jtvYQZaQs=
X-Received: by 2002:a17:906:1cca:: with SMTP id
 i10mr2568903ejh.487.1603807014413; 
 Tue, 27 Oct 2020 06:56:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfu8uTTNbTc5SUgHNwN75/s0cC36p9ImYoAKcTKZOBsnKGav5H8mbnFW+m90c+b40ULMAJrQ==
X-Received: by 2002:a17:906:1cca:: with SMTP id
 i10mr2568885ejh.487.1603807014202; 
 Tue, 27 Oct 2020 06:56:54 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id b15sm945058edz.97.2020.10.27.06.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 06:56:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/25] block/nvme: Make nvme_init_queue() return boolean
 indicating error
Date: Tue, 27 Oct 2020 14:55:34 +0100
Message-Id: <20201027135547.374946-13-philmd@redhat.com>
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

Just for consistency, following the example documented since
commit e3fe3988d7 ("error: Document Error API usage rules"),
return a boolean value indicating an error is set or not.
This simplifies a bit nvme_create_queue_pair().

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 74994c442e5..9324f0bfdc4 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -160,7 +160,8 @@ static QemuOptsList runtime_opts = {
     },
 };
 
-static void nvme_init_queue(BDRVNVMeState *s, NVMeQueue *q,
+/* Returns true on success, false on failure. */
+static bool nvme_init_queue(BDRVNVMeState *s, NVMeQueue *q,
                             unsigned nentries, size_t entry_bytes, Error **errp)
 {
     size_t bytes;
@@ -171,13 +172,14 @@ static void nvme_init_queue(BDRVNVMeState *s, NVMeQueue *q,
     q->queue = qemu_try_memalign(s->page_size, bytes);
     if (!q->queue) {
         error_setg(errp, "Cannot allocate queue");
-        return;
+        return false;
     }
     memset(q->queue, 0, bytes);
     r = qemu_vfio_dma_map(s->vfio, q->queue, bytes, false, &q->iova);
     if (r) {
         error_setg(errp, "Cannot map queue");
     }
+    return r == 0;
 }
 
 static void nvme_free_queue_pair(NVMeQueuePair *q)
@@ -210,7 +212,6 @@ static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
                                              Error **errp)
 {
     int i, r;
-    Error *local_err = NULL;
     NVMeQueuePair *q;
     uint64_t prp_list_iova;
 
@@ -247,16 +248,12 @@ static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
         req->prp_list_iova = prp_list_iova + i * s->page_size;
     }
 
-    nvme_init_queue(s, &q->sq, size, NVME_SQ_ENTRY_BYTES, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!nvme_init_queue(s, &q->sq, size, NVME_SQ_ENTRY_BYTES, errp)) {
         goto fail;
     }
     q->sq.doorbell = &s->doorbells[idx * s->doorbell_scale].sq_tail;
 
-    nvme_init_queue(s, &q->cq, size, NVME_CQ_ENTRY_BYTES, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!nvme_init_queue(s, &q->cq, size, NVME_CQ_ENTRY_BYTES, errp)) {
         goto fail;
     }
     q->cq.doorbell = &s->doorbells[idx * s->doorbell_scale].cq_head;
-- 
2.26.2


