Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771DEC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:10:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01CEB22263
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HpW8flWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01CEB22263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPg6-0000Rw-UA
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPTh-0003dj-0A
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:57:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32093)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPTW-0004PH-Tn
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603807041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/EHBGSZvo5pKndYIooWnkiWED77TLxl9oiYOVAV+Eso=;
 b=HpW8flWRfpoa9u2o7KX4URX4PtS5g0VA76eXhrYYseyc36uzW2C2Dixjsck6QB/v4LkFjD
 rjZgoNZlQFS2FY/cjijmg3Zp5/Fr8LR26qmzy5KLcUAlZyuUdlt6G9nelKuRsfN0UZ4riZ
 lFSfjd+k4pgD2p6VbAM+D72PvozmWOk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-lf8vuzYHOpWTLR-H5vH-_Q-1; Tue, 27 Oct 2020 09:57:18 -0400
X-MC-Unique: lf8vuzYHOpWTLR-H5vH-_Q-1
Received: by mail-ej1-f72.google.com with SMTP id lf18so901529ejb.13
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/EHBGSZvo5pKndYIooWnkiWED77TLxl9oiYOVAV+Eso=;
 b=WkzQJ6q/WTBPqHYKaPPRjXGO9+IGZHKfW/cDcxo5wXpdV2qH+MsPzfGNVUYC1K+EaS
 X4J2YZP6y7lMnR6HshX4lQDsjEdsdDsVVtYcByIKtjotWgyihNlbHTq+TfYOzFIlGS0/
 OyrUCgDrc3XiT944s2JoSt2zDcvxMY+JN1DuMiYPJPxd3DqjgpASSO+HpLofNRoOdtbY
 wSbmEzjDYH1WhbJksKIaeJ3+C7L/s7Q41O83MffSLlbwRQpOzkAHUJPZ4efP+tpFgrLA
 9jx2Igztf3FH//GTW6ErLmv7mpGyqmcCO8e/+9AeLZgR2hZ+4+JNHIWkSKVodAHVv2Wy
 M1Zw==
X-Gm-Message-State: AOAM533DUnJtsfJBCiSW2ujau5pasYJlX8U0BFmhq5hZRC4dlbJltDJW
 HbM0OZqnrEhcVuZ+r6trxflatBuQl7LsaCiGCRTYHGPgY8lz5B8gFzISMeG7ruDejkzLnHp0dPP
 xW9/yFww/ymjZz5o=
X-Received: by 2002:a17:906:5488:: with SMTP id
 r8mr2433103ejo.483.1603807036882; 
 Tue, 27 Oct 2020 06:57:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznhdT7kCjIKpYOx1f/kNIFvxHnb34e5y9kXY9ny+ANQXmIn4CXj22Z8oighEJrD2uIwAenyA==
X-Received: by 2002:a17:906:5488:: with SMTP id
 r8mr2433086ejo.483.1603807036689; 
 Tue, 27 Oct 2020 06:57:16 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id p20sm1129638ejd.78.2020.10.27.06.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 06:57:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/25] block/nvme: Simplify ADMIN queue access
Date: Tue, 27 Oct 2020 14:55:38 +0100
Message-Id: <20201027135547.374946-17-philmd@redhat.com>
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

We don't need to dereference from BDRVNVMeState each time.
Use a NVMeQueuePair pointer to the admin queue and use it.
The nvme_init() becomes easier to review, matching the style
of nvme_add_io_queue().

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index d5df30ec074..2d3648694b0 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -699,6 +699,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
                      Error **errp)
 {
     BDRVNVMeState *s = bs->opaque;
+    NVMeQueuePair *q;
     AioContext *aio_context = bdrv_get_aio_context(bs);
     int ret;
     uint64_t cap;
@@ -781,19 +782,18 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
 
     /* Set up admin queue. */
     s->queues = g_new(NVMeQueuePair *, 1);
-    s->queues[INDEX_ADMIN] = nvme_create_queue_pair(s, aio_context, 0,
-                                                          NVME_QUEUE_SIZE,
-                                                          errp);
-    if (!s->queues[INDEX_ADMIN]) {
+    q = nvme_create_queue_pair(s, aio_context, 0, NVME_QUEUE_SIZE, errp);
+    if (!q) {
         ret = -EINVAL;
         goto out;
     }
+    s->queues[INDEX_ADMIN] = q;
     s->queue_count = 1;
     QEMU_BUILD_BUG_ON((NVME_QUEUE_SIZE - 1) & 0xF000);
     regs->aqa = cpu_to_le32(((NVME_QUEUE_SIZE - 1) << AQA_ACQS_SHIFT) |
                             ((NVME_QUEUE_SIZE - 1) << AQA_ASQS_SHIFT));
-    regs->asq = cpu_to_le64(s->queues[INDEX_ADMIN]->sq.iova);
-    regs->acq = cpu_to_le64(s->queues[INDEX_ADMIN]->cq.iova);
+    regs->asq = cpu_to_le64(q->sq.iova);
+    regs->acq = cpu_to_le64(q->cq.iova);
 
     /* After setting up all control registers we can enable device now. */
     regs->cc = cpu_to_le32((ctz32(NVME_CQ_ENTRY_BYTES) << CC_IOCQES_SHIFT) |
-- 
2.26.2


