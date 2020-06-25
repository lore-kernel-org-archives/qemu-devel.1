Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF011C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:54:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95BF1206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doMsI7QA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BF1206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joX0g-0007d6-Rd
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWvf-0007iS-QQ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:48:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39266
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWve-0000vF-3F
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593110933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vQ6c0CyjjoCdHr4XROOCTHk87bmAQz91kRF02NzcbuY=;
 b=doMsI7QAPkM2ccU+wa5EFLC9b1SA6yDgDkZT9V8sZ1v9cnSc2cGRKJqX0i64AGo/a+uACM
 B+1qNVGEJlq8t5S0uC614zoGKcm+6wOyX0LXc1qFOW/T0CqpsggzVL+GdaiS3hoMFfLZUb
 xfKmHb4cqUvFKo+4TEvqnahNrOtdQP0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-R91-rndePDWreOKgZe0T6g-1; Thu, 25 Jun 2020 14:48:51 -0400
X-MC-Unique: R91-rndePDWreOKgZe0T6g-1
Received: by mail-wr1-f71.google.com with SMTP id d6so7725507wrn.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 11:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vQ6c0CyjjoCdHr4XROOCTHk87bmAQz91kRF02NzcbuY=;
 b=pp97AAnfF1qDzvm+bVq1jBPbyHjKguuUq0fjU5rgK6RTAyhWQvL+N4DlV3dIeb9Oxv
 70TqWgLaTjPu5WdqF7hbWm7ULOHKG7sSX6Ph3eFRcKU5FZ83fvpIA7On8fKaFzq6dz7B
 KYNcO2R98oPf2+hmZvdpxwbakpRUQZqXIIZ5HvjALjO6i5B5CHyrhcbKN1sBcfVK/SHM
 siuSHGjLXDA57xNeWJ7GkbZeuWlb7x7sIFjcLCs45MXB7n89SRexQoFEjLYl5Whl7f7m
 V55XCuUFUjm5P/JNKrZJ3MdgGIRaQwTEMhPe4gRQfIHl4CWQuvz4C+7s3dvjIHkgathJ
 p35w==
X-Gm-Message-State: AOAM531B0gJKyyJP1fIyLIcr3MhgQnijgNJlpBY/jZaHry/mvk4idpBN
 obrsffFDdpzn+3NOhncE4AF+gxMDG6hYPc4ZDrmaekyespHtaYDJRyMcQqEtKtiJH7n3x0BnAU/
 IZkr2y7/0EN9+cVk=
X-Received: by 2002:a5d:4b4f:: with SMTP id w15mr16756720wrs.84.1593110930146; 
 Thu, 25 Jun 2020 11:48:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0SVV+5TXqKTHuoUbKpT5QSyAfugCpdL0rBfSXC1w9+gEwZWxYjC9lHVd6if2zsfwH4LX+wQ==
X-Received: by 2002:a5d:4b4f:: with SMTP id w15mr16756704wrs.84.1593110930015; 
 Thu, 25 Jun 2020 11:48:50 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id d201sm13353323wmd.34.2020.06.25.11.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 11:48:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 02/17] block/nvme: Let nvme_create_queue_pair() fail gracefully
Date: Thu, 25 Jun 2020 20:48:23 +0200
Message-Id: <20200625184838.28172-3-philmd@redhat.com>
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

As nvme_create_queue_pair() is allowed to fail, replace the
alloc() calls by try_alloc() to avoid aborting QEMU.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 1e5b40f61c..ec0dd21b6e 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -194,13 +194,21 @@ static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
     int i, r;
     BDRVNVMeState *s = bs->opaque;
     Error *local_err = NULL;
-    NVMeQueuePair *q = g_new0(NVMeQueuePair, 1);
+    NVMeQueuePair *q;
     uint64_t prp_list_iova;
 
+    q = g_try_new0(NVMeQueuePair, 1);
+    if (!q) {
+        return NULL;
+    }
+    q->prp_list_pages = qemu_try_blockalign0(bs,
+                                          s->page_size * NVME_QUEUE_SIZE);
+    if (!q->prp_list_pages) {
+        goto fail;
+    }
     qemu_mutex_init(&q->lock);
     q->index = idx;
     qemu_co_queue_init(&q->free_req_queue);
-    q->prp_list_pages = qemu_blockalign0(bs, s->page_size * NVME_QUEUE_SIZE);
     r = qemu_vfio_dma_map(s->vfio, q->prp_list_pages,
                           s->page_size * NVME_QUEUE_SIZE,
                           false, &prp_list_iova);
-- 
2.21.3


