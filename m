Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891E5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 19:15:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 539DA206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 19:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehMtRkpT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 539DA206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqLiq-0007wR-F5
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 15:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqLhF-0005yF-7H
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 15:13:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21438
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqLhD-0005Vj-Oo
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 15:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593544411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oDXkElBCSL5Fje+j3PutyCwM6gIK6a01PpGIaTigzW4=;
 b=ehMtRkpT+yxnnQNe2BF5uLiESR7RM7pYYMwjBLiFNJ49DNuUEqbXoVcypZLR032lz5v2bD
 0ztpqMKx80uLxOfjMmJxT+O6h8QM768V4b8LqxI/VlC4tmeHDxxOICKtX/63B4RVzRMdfx
 YkNnQXS76oBgtpgy547Ytvkx0S5QKfs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-f6_TNI6BPDeCH-0mQYI7wA-1; Tue, 30 Jun 2020 15:13:27 -0400
X-MC-Unique: f6_TNI6BPDeCH-0mQYI7wA-1
Received: by mail-wm1-f70.google.com with SMTP id q20so11579753wme.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 12:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oDXkElBCSL5Fje+j3PutyCwM6gIK6a01PpGIaTigzW4=;
 b=SBNfuebIkC1irm3UTEOvWnVvl9RF3yvvaEO7jRBpliQKBJRDMp6fNfOafVbkTcKEeO
 3h5czwDCovyK/a3TGR0KNWXSOnk8hNdUoZPq8+mJkRyNDnS+bd/V9gWygMNZIqhPCMIl
 rnPIXA4Niiwwl++o8ivRXFAw79oGxlSjeB4W0rgbC1f/6eKRY9gCA5RyClRQM3zXlvaL
 GIGPWVr+2pGwg/iQh6wZvCjQM+zVDMaAdzaT8Wwn0Otywy6YNip64isuP1Sc1M9dSoUc
 4TSzx/qaRi7MYNz7h5Y63o/cxao6gX6VnytlmsugMOMzsOag2kvp1LzfxlTSxxWu7kET
 Pnxg==
X-Gm-Message-State: AOAM531y2anAWzlhqRvzMmVhSe5v4mMOMr9nPV9AHTmsEO1UHhFP2kWV
 eDLQjm5RPJCXNGcBkDtvEfxGoOOlfN8pvEzC0MMt7cZpz5+1j+VhnChZbPVSqwkZ3jXY/5KigNY
 nKSEjc4rO039zPEc=
X-Received: by 2002:a7b:c055:: with SMTP id u21mr22142438wmc.132.1593544405935; 
 Tue, 30 Jun 2020 12:13:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjM85LW5DmxOv6Awt6/4b1jhrOzm3MXlEFAr2qP7AdnzrwJJ62ZtEn+gKE2mBtaPe1hxsz9g==
X-Received: by 2002:a7b:c055:: with SMTP id u21mr22142408wmc.132.1593544405652; 
 Tue, 30 Jun 2020 12:13:25 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w17sm4989638wra.42.2020.06.30.12.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 12:13:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 01/12] block/nvme: Replace magic value by SCALE_MS
 definition
Date: Tue, 30 Jun 2020 21:13:07 +0200
Message-Id: <20200630191318.30021-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630191318.30021-1-philmd@redhat.com>
References: <20200630191318.30021-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
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

Use self-explicit SCALE_MS definition instead of magic value.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/nvme.c b/block/nvme.c
index 374e268915..2f5e3c2adf 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -715,7 +715,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     /* Reset device to get a clean state. */
     s->regs->cc = cpu_to_le32(le32_to_cpu(s->regs->cc) & 0xFE);
     /* Wait for CSTS.RDY = 0. */
-    deadline = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + timeout_ms * 1000000ULL;
+    deadline = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + timeout_ms * SCALE_MS;
     while (le32_to_cpu(s->regs->csts) & 0x1) {
         if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
             error_setg(errp, "Timeout while waiting for device to reset (%"
-- 
2.21.3


