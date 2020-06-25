Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6497C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:51:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E359206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glvhgNhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E359206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joWxr-0002Ui-R6
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWwL-0000Q0-63
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:49:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58121
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWwJ-0001Ct-Jw
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593110975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yhVxBJvHaMprPq0QsBU2YvfiwAoYvUlawZjaw5wxXvI=;
 b=glvhgNhwDQXWcrEAceNLoM3YJVJr4y3Ny4gMe1dWoXkuaSKKVrNNtcBinIM1qMeYSve7yr
 ro3W1JukLTMS0UvqnpSE2fNWjzQhJbsRvvzoK02+XDoIeGwKwV4Uhd2QbH47YDGQzdFpMs
 CyIzIW8lzcTs4Rg/7qZfAw7hYUyHIEM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-IzRar4haO22VLlb3lMbqag-1; Thu, 25 Jun 2020 14:49:33 -0400
X-MC-Unique: IzRar4haO22VLlb3lMbqag-1
Received: by mail-wr1-f71.google.com with SMTP id a18so7732794wrm.14
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 11:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yhVxBJvHaMprPq0QsBU2YvfiwAoYvUlawZjaw5wxXvI=;
 b=K4EpiHFaFoZGg4NS8zfr4CtKrsR+uWUvUA/DOgYVuS2fMiJi8zFqgAF7+Huvr2wDLf
 dp64Wh5ZXYBjyKQdENs5sPZP3kQyd/03VcuRazV2BBdyU5xEamaUuYEVbCA8sTIMT/vV
 5kKiXCNDKqzDmGIPgpa5KzNQIPKPwYtXqNX3gjfFI4x2yNVSr3fxg0cM2kRKZK7UuZgx
 MpUjboZ8Pyvow9xo4TKRZTFMxcOulCwcjh1eNKdpK5syOlTqzTI4o1iwg/wTBp2Mw+pT
 +1n0TlKkYCsEf1nLdv8T8mJK2/NHl3cPmUPUbHHwIlOqqLWb36TjkMQ+buGKaIQPIXXr
 j4yg==
X-Gm-Message-State: AOAM53369PlD5A6Mef4REg4ah4UR9WKbBN9jUOOWHm3g64ssixQcKWJv
 1PEReOGDrGJdzgDAzWmeXValGXhwzYHK7VZiyTtMFZl9xQtkDU4kIWr7wQuYwQ9sAi9af8tRvCM
 nOEDPs0vlhcnw7mY=
X-Received: by 2002:a7b:cbcb:: with SMTP id n11mr4686002wmi.99.1593110972125; 
 Thu, 25 Jun 2020 11:49:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6POyqdvauFTVFDCZsPZR2UnEhQWtss0Y5W6sr2ytfyzTAilIIy129pKwSq8oLsKQGZ1jkLg==
X-Received: by 2002:a7b:cbcb:: with SMTP id n11mr4685989wmi.99.1593110971962; 
 Thu, 25 Jun 2020 11:49:31 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p25sm13334331wmg.39.2020.06.25.11.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 11:49:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 11/17] block/nvme: Simplify nvme_create_queue_pair() arguments
Date: Thu, 25 Jun 2020 20:48:32 +0200
Message-Id: <20200625184838.28172-12-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200625184838.28172-1-philmd@redhat.com>
References: <20200625184838.28172-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
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

nvme_create_queue_pair() doesn't require BlockDriverState anymore.
Replace it by BDRVNVMeState to simplify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 8b6cf4c34b..1b7b23cea4 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -189,12 +189,11 @@ static void nvme_free_req_queue_cb(void *opaque)
     qemu_mutex_unlock(&q->lock);
 }
 
-static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
+static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
                                              int idx, int size,
                                              Error **errp)
 {
     int i, r;
-    BDRVNVMeState *s = bs->opaque;
     Error *local_err = NULL;
     NVMeQueuePair *q;
     uint64_t prp_list_iova;
@@ -555,7 +554,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
     NvmeCmd cmd;
     int queue_size = NVME_QUEUE_SIZE;
 
-    q = nvme_create_queue_pair(bs, n, queue_size, errp);
+    q = nvme_create_queue_pair(s, n, queue_size, errp);
     if (!q) {
         return false;
     }
@@ -660,7 +659,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
 
     /* Set up admin queue. */
     s->queues = g_new(NVMeQueuePair *, 1);
-    s->queues[QUEUE_INDEX_ADMIN] = nvme_create_queue_pair(bs, 0,
+    s->queues[QUEUE_INDEX_ADMIN] = nvme_create_queue_pair(s, 0,
                                                           NVME_QUEUE_SIZE,
                                                           errp);
     if (!s->queues[QUEUE_INDEX_ADMIN]) {
-- 
2.21.3


