Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8CDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:55:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7D1204EA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVUceE/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7D1204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joX1y-0001pS-Mt
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWwB-00007Y-VY
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:49:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30134
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWwA-00018B-C7
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593110965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yoUDU1XDMhr7CKTebb62prsbDCjR4+uEbV6Q6F/b8bw=;
 b=eVUceE/gyC+GVzQFowxo2R83i4PsgW9Q9i/Pp2QAGwk8x+pCEK8N0GIzAvsZP3lXnkBwty
 o21Jy1qmkabQqDBktL0iS2OnoHBkc1zq5/fTvuGfYxruVJjOjNhfG3fWpq/qO875uZoKjy
 drC9s7jtBoJT8xXnPKN63h4tdTPPsH8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-LZuUYq87Nae6WQmwDZ_nMQ-1; Thu, 25 Jun 2020 14:49:24 -0400
X-MC-Unique: LZuUYq87Nae6WQmwDZ_nMQ-1
Received: by mail-wm1-f69.google.com with SMTP id g124so7723352wmg.6
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 11:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yoUDU1XDMhr7CKTebb62prsbDCjR4+uEbV6Q6F/b8bw=;
 b=B40vxBYZ+ZpdPTg32qrL3JErQxWmbCEryKLzY7Ujp+tNNKNmcl68LWYrQGyfBm/v/a
 UW9T7GV6bVAR9FGy/YlGi9/qqVWiGXc5sD4+nA8VPC8LjXtMwzzZF7riogNdTBdlhAyp
 Xv9eavf0g4UmV02sRqwbPie/fp+vcGQ/KeAvw34z24oP1w/BM7ZHdcbBaut/2+Kng4pf
 QkUfibTUyFAlsfGmfEsNlyPPFEtEyKqRTA7TkhAPhaspu58MbcyfRZmXFRoeJjmQIHAF
 tq62yM5Pkt0IPl7crGj6m5fkQr5bFUZlvrgV6zqSgBkeB5zFwIHqTzpGM/ZZaIK9jiEi
 z50w==
X-Gm-Message-State: AOAM533AGn7A/VHohNIRdQbW+9DAHuCFDQckSVPceqqJuAPaIEyuHi9l
 6oDRmj4P9nVHC88l73bEuBOuh7qkBLz6SDm3whSMjvBa6nYIEx3wvBv8HIE+SHhZT91A18NIFiC
 w3pNOUXwSNfG4YLA=
X-Received: by 2002:a5d:538e:: with SMTP id d14mr8379355wrv.21.1593110962748; 
 Thu, 25 Jun 2020 11:49:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoU5iUkj0bHZa2q/m94iqBeEZtccFsP/QiM8/PgeLbfW4o5odLxTXnlO9YPKAQkMkk6slJGQ==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr8379343wrv.21.1593110962612; 
 Thu, 25 Jun 2020 11:49:22 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id a81sm13905148wmf.30.2020.06.25.11.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 11:49:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 09/17] block/nvme: Remove unused argument from
 nvme_free_queue_pair()
Date: Thu, 25 Jun 2020 20:48:30 +0200
Message-Id: <20200625184838.28172-10-philmd@redhat.com>
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

nvme_free_queue_pair() doesn't use BlockDriverState, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 095a8ec024..f87f157dc0 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -170,7 +170,7 @@ static void nvme_init_queue(BlockDriverState *bs, NVMeQueue *q,
     }
 }
 
-static void nvme_free_queue_pair(BlockDriverState *bs, NVMeQueuePair *q)
+static void nvme_free_queue_pair(NVMeQueuePair *q)
 {
     qemu_vfree(q->prp_list_pages);
     qemu_vfree(q->sq.queue);
@@ -241,7 +241,7 @@ static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
 
     return q;
 fail:
-    nvme_free_queue_pair(bs, q);
+    nvme_free_queue_pair(q);
     return NULL;
 }
 
@@ -568,7 +568,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
     };
     if (nvme_cmd_sync(bs, s->queues[QUEUE_INDEX_ADMIN], &cmd)) {
         error_setg(errp, "Failed to create io queue [%d]", n);
-        nvme_free_queue_pair(bs, q);
+        nvme_free_queue_pair(q);
         return false;
     }
     cmd = (NvmeCmd) {
@@ -579,7 +579,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
     };
     if (nvme_cmd_sync(bs, s->queues[QUEUE_INDEX_ADMIN], &cmd)) {
         error_setg(errp, "Failed to create io queue [%d]", n);
-        nvme_free_queue_pair(bs, q);
+        nvme_free_queue_pair(q);
         return false;
     }
     s->queues = g_renew(NVMeQueuePair *, s->queues, n + 1);
@@ -776,7 +776,7 @@ static void nvme_close(BlockDriverState *bs)
     BDRVNVMeState *s = bs->opaque;
 
     for (i = 0; i < s->nr_queues; ++i) {
-        nvme_free_queue_pair(bs, s->queues[i]);
+        nvme_free_queue_pair(s->queues[i]);
     }
     g_free(s->queues);
     aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
-- 
2.21.3


