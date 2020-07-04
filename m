Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE76C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:38:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8614720724
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AcyF/swf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8614720724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrprn-0007Od-Qk
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 17:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrplH-0003Iy-Jl
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:31:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40870
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrplG-00045z-3v
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593898309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KMa3yNwCNdnEQnAOsKRyk2u/lQpm0dom4ME9xGYTEfY=;
 b=AcyF/swf3B8F0rKXxgX+8/ltHAvuXxg+4djbW/azgzBw6Tol6M4FQwJ6lK2Luh8PKSnl4i
 aGVak0Qmt9tLdeIn3YEOCRrOZ312C+zBY+3IAWaBQzqS0kWZiwqIt0x9U3QJ2+ULWWTuiv
 eM1P2QBaqsKjchL3b4yUDH0gaHc4Y6A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-PXmjHMfnPO6KtDB4AFy2NA-1; Sat, 04 Jul 2020 17:31:48 -0400
X-MC-Unique: PXmjHMfnPO6KtDB4AFy2NA-1
Received: by mail-wr1-f71.google.com with SMTP id y13so36932363wrp.13
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 14:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KMa3yNwCNdnEQnAOsKRyk2u/lQpm0dom4ME9xGYTEfY=;
 b=GeJTK+VflWhzCn13lMKAfaRgCJ3NYwGmLXvuRcPPsFO4zx1XL6rfDvhW11iFG3FxFK
 K18GXygJI6+2h4HG0zSqUpiovHENuiBk+dTHQUAurdNCOI3FmIzsBFB+JsqjtyQ9GkEa
 tLYe0GHa+5HGxcjt9L5/ljSPmoDRhoL/7SdHwolYwha+5zAPwKE5zkXtf9vk181OaByj
 xLIqm6d1r0wGQeCSJl0wZ+6P7qg/6In4A7eFaDx3MRFuGp7xLQYhN4p1WsZ35iiAM+9u
 enQsZTl7hpX+tM2232PSWq2mIcYQEnRt5vW7mSt/MZEDGAmN1FP+UHZcOawafa7TO5XF
 DcVQ==
X-Gm-Message-State: AOAM533V5wMnaERhpxv9zpE12mzIyOCPVuTbWlCnn5erLyqJhx+wqFxt
 HQIcI4GpNrXBTEdtq5Yu/QQeH5Mk/YLvVPa6wsAcPbsYQfod2DwJJNA1eU4eoyaOsxtiW17LODR
 SavSWlKGXSA9nmqE=
X-Received: by 2002:a1c:7706:: with SMTP id t6mr1700052wmi.3.1593898306661;
 Sat, 04 Jul 2020 14:31:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzy4n66+oUCV6z6QscLxmjAXBlqtT6LIwTglcpd2ABRnavWmNcU7UAPcpaRzgRlikFbz2CT+g==
X-Received: by 2002:a1c:7706:: with SMTP id t6mr1700040wmi.3.1593898306517;
 Sat, 04 Jul 2020 14:31:46 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id h84sm18654307wme.22.2020.07.04.14.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 14:31:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 11/16] block/nvme: Simplify nvme_init_queue() arguments
Date: Sat,  4 Jul 2020 23:30:46 +0200
Message-Id: <20200704213051.19749-12-philmd@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 17:28:04
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

nvme_init_queue() doesn't require BlockDriverState anymore.
Replace it by BDRVNVMeState to simplify.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 9566001ba6..97a63be9d8 100644
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
2.21.3


