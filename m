Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D1AC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:57:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7651922404
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+IxzdyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7651922404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0Bc-0000Ul-E3
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX09o-0006w2-FX
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX09l-0007yG-GX
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603709716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RehUHE9smya/dLsky2IXktduYA/iO28rTmGbzKYGc9c=;
 b=K+IxzdyWMw62NoT6I61Xv4eBSglX2uei9ehh7dm9AUeYwaBM3nSTOi1yaDSDWbuPeGlZCT
 LjzNAKJQN0XSrmF5ZvwbD6N4nZC0MOeKYKdtGYsk1FkUmNu6Ybl6AVkDOz6XsSzcGeTEOP
 3j9n1dxBe6C+s9zpTcKSruoOeKS/nDI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-T55Gtx7ZOqu6zuvGArDsbA-1; Mon, 26 Oct 2020 06:55:13 -0400
X-MC-Unique: T55Gtx7ZOqu6zuvGArDsbA-1
Received: by mail-wm1-f72.google.com with SMTP id r19so6172227wmh.9
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 03:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RehUHE9smya/dLsky2IXktduYA/iO28rTmGbzKYGc9c=;
 b=gdWwct0/VQxpjx5o/Bn73Fgm/Da0CXrXbdt2XsMM1an/m4KnD3gEjCKFQYfS+nULpr
 DX7lhD9hBI7gvuWwU+0Th3JEL7IO+5haJz4AuimlHjjqsweQLRwNkxDk0T70DrQ2JLx4
 tGl0RE0b5X4wUo+GPO7DYneXu1cFIpQMvSit5Sv+u/m34FR9/kTarre33awh4oGMz4SN
 A4dXgGLLk8KLXkaZzRs51a0WiMpdKYO2oTVUcQI3rSNg8Kc6yIncN6c1CJKIWSde2BvT
 CIoVsDanN47X3BYZUo+RKGyt7RIlEqzKJNLOFzc6HVfS4BOwSkORsEAuwsVNjLJXNzFD
 BVqw==
X-Gm-Message-State: AOAM530+88P+MtnrldjqOCKcwnqtSWKxwjfTfPvzHO9QK2z8KucT57rn
 pQAINftsGxcZTgYvroeks0D1Nx+c3LgarVF7x6tNBGFxXVu/sLzrbyJwqrLDk1IL0h8+z2aiubm
 oEjJDdhJIDnzQIxc=
X-Received: by 2002:a1c:3d0b:: with SMTP id k11mr16527956wma.155.1603709711813; 
 Mon, 26 Oct 2020 03:55:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkJnI+75GNifqeIxOa5vyOW++22eYcXgv7c+VGmme8smKEu4b4HgE7XX5HtMH91aJ5X4PWyQ==
X-Received: by 2002:a1c:3d0b:: with SMTP id k11mr16527937wma.155.1603709711669; 
 Mon, 26 Oct 2020 03:55:11 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id o184sm19666112wmo.37.2020.10.26.03.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 03:55:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/19] block/nvme: Correct minimum device page size
Date: Mon, 26 Oct 2020 11:54:46 +0100
Message-Id: <20201026105504.4023620-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026105504.4023620-1-philmd@redhat.com>
References: <20201026105504.4023620-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While trying to simplify the code using a macro, we forgot
the 12-bit shift... Correct that.

Fixes: fad1eb68862 ("block/nvme: Use register definitions from 'block/nvme.h'")
Reported-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/nvme.c b/block/nvme.c
index b48f6f25881..029694975b9 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -724,7 +724,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
         goto out;
     }
 
-    s->page_size = MAX(4096, 1 << NVME_CAP_MPSMIN(cap));
+    s->page_size = MAX(4096, 1u << (12 + NVME_CAP_MPSMIN(cap)));
     s->doorbell_scale = (4 << NVME_CAP_DSTRD(cap)) / sizeof(uint32_t);
     bs->bl.opt_mem_alignment = s->page_size;
     timeout_ms = MIN(500 * NVME_CAP_TO(cap), 30000);
-- 
2.26.2


