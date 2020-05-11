Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66425C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 08:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35443206F5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 08:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFwVbt/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35443206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY3eI-00056S-ES
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 04:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY3cy-0002qD-R9
 for qemu-devel@nongnu.org; Mon, 11 May 2020 04:17:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21645
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY3cy-0002mY-5b
 for qemu-devel@nongnu.org; Mon, 11 May 2020 04:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589185051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+fMs+TwjNvZEraJaaspwuJO6dVzcXbnuMZr1UsCS+CM=;
 b=SFwVbt/7W8k1CkwCfEd022vC9Q1laoyFsqwkkLPsE05SqbIuN7ZtpDgs1tvXOkPIYV6C3d
 6APtYzErHQlvUIDxpEjFA3VOlAkb7VZ+E+IDb8A0cbFCZQPtKh/uS75kLoAoCRDcbLRY/M
 Fn42K3p+k75/40HsuImt8MPhXixm6aE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-WXtdgJhPMZa9QtaQ1Vjn-Q-1; Mon, 11 May 2020 04:17:28 -0400
X-MC-Unique: WXtdgJhPMZa9QtaQ1Vjn-Q-1
Received: by mail-wm1-f69.google.com with SMTP id h6so7952602wmi.7
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 01:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+fMs+TwjNvZEraJaaspwuJO6dVzcXbnuMZr1UsCS+CM=;
 b=MR0mOdoh1M9jbQe5/Qebofd8b0Rwz9Z5Jic75EiQZFc1sWFTKKIz//lm7mSBSIqFzq
 MDWFEQ1VVxxtHhZr0xUh/N52B5eTAzIleFrNumT8GX/LNur4mqDNGauZKGtBuCe45x/J
 BtczJst2bobnni02DHMEXleStJYg/9DnS393VaggqcAOVCqJ4fVH+Zi7u6BF5dNT91OT
 L8x8m8Di/e4xS0KM+ALIDFxU9ANo+JkA9v7eFFUPEd2yYrVIHbNw5v9Np8RM2t7wNzxX
 Yc8+cKYzjPfiqdPY2IbwlJYWYDEFjVgMcovmMeu6hxH5qXkK4k8OFk9AJ93DT/XXreaC
 6reg==
X-Gm-Message-State: AGi0PubVF513QosbejmgojfzME4dOXvD+AT6fL5reBdIaiuNe2QGHCUn
 VYFLKE/Zppsgoe0meZMdDO2CSJ5EsRn1F7lumjwAhgZxwhCchLhyLLCOUawr3pv+ZzGedrTOdzu
 aQ7qp+dGYeRaAtXU=
X-Received: by 2002:a1c:4b0e:: with SMTP id y14mr2991810wma.170.1589185046525; 
 Mon, 11 May 2020 01:17:26 -0700 (PDT)
X-Google-Smtp-Source: APiQypIn0Y/28d5DxPAhNDphSVBi5qhiHQW7Kx7b9TJdKXTsNzqKUVijBVzE0idKRUD9nudyAmwxaQ==
X-Received: by 2002:a1c:4b0e:: with SMTP id y14mr2991788wma.170.1589185046328; 
 Mon, 11 May 2020 01:17:26 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id z22sm24828742wma.20.2020.05.11.01.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 01:17:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] memory: Simplify memory_region_do_writeback()
Date: Mon, 11 May 2020 10:17:16 +0200
Message-Id: <20200511081719.31641-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200511081719.31641-1-philmd@redhat.com>
References: <20200511081719.31641-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 00:05:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Beata Michalska <beata.michalska@linaro.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

mr->dirty_log_mask tells if dirty tracking has been enabled,
not if the page is dirty. It would always be true during live
migration and when running on TCG, but otherwise it would
always be false.
As the value of mr->dirty_log_mask does not matter, remove
the check.

Cc: Beata Michalska <beata.michalska@linaro.org>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/memory.c b/memory.c
index 601b749906..fd5c3af535 100644
--- a/memory.c
+++ b/memory.c
@@ -2204,7 +2204,7 @@ void memory_region_do_writeback(MemoryRegion *mr, hwaddr addr, hwaddr size)
      * Might be extended case needed to cover
      * different types of memory regions
      */
-    if (mr->ram_block && mr->dirty_log_mask) {
+    if (mr->ram_block) {
         qemu_ram_writeback(mr->ram_block, addr, size);
     }
 }
-- 
2.21.3


