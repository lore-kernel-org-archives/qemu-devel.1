Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13D2C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:39:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A77206DA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAZxXj7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A77206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAci-00053n-A9
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:39:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60245)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWH-0003bm-Ls
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWG-0004Ep-Mw
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:05 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:35591)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWG-0004ER-H4
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:04 -0500
Received: by mail-wm1-x332.google.com with SMTP id p17so2337011wmb.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NqwSzhoujF6+WywSNH6TKtDufZjSTHCCK+sRGZfnoPY=;
 b=DAZxXj7gnqOqrfE2txCQIkjez8OwjzF0b4VDAcJV+BK0p/zKjgDmbIPl3iAVwr2odH
 Oi1QV60/xLcpEcbtmJR5vsnYjG0ISNiHdSqeUELZzCn3RCl9wuO8WafqhNM8hnUGnICv
 64vFFp7cWrrhE2q8zt/cL2X4nepeCQ1VhA8WjIRCZPRdlrfkXnhPmaX1LtT7/86pun+s
 R9pRwWlti6j60ri9TxMKcI9X+axqM0br/I6c997j+6CsWhYEiWZRbeqx5TIbIOaqlc81
 TUnQJAjB86ZO/5tpafe+22ujXfnQhN1wFNVALRyQvaWdyTvLoU8kO5srNcsRC6o5eNpS
 cwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NqwSzhoujF6+WywSNH6TKtDufZjSTHCCK+sRGZfnoPY=;
 b=TRHyPHroTB0FFV51XkTFF3XA2gmKdcHEF4crP53nfqhKZWaqAX0hVFHvfmcAU9MZXe
 wNN+78UMM2k/WC5mgmNZHJcs9TKorsXdo7+m6flav4n7e3nD80XHs1utU3Y6I02kTKTb
 WxIWmqQEtxKaGFr71o3wiDJKGSY7EXkRmlpumLavB1x/Mo9dpUeSQtqBIqjQuB6O/vcR
 +aGaa1U2K3fV1Ak2bIgB3SlM6bLpbPKWoNzF1Vnw0WCyHM1RR3BAeCJpqPGwF0l1pjf7
 0YnqNWBwTa0o4IDBL+9L0GGU/uara4ZgNAce8+1pcv3GuRRaQFK8fSY3xqgFWIcJP3oY
 B15g==
X-Gm-Message-State: APjAAAX1BPpbtHlu5qg7QU6p/idejsuYgrtoMdO32NACXzGN5CHnCnhK
 nKyYXfghhKS4va1EnXuMwR0Siu20
X-Google-Smtp-Source: APXvYqz200Eevm7NCYaOAYm6y77rg31Vk2H3dLaoxIZlhvcH3sb9+hHAyOLTCwA1UaHhfdzv1th7ow==
X-Received: by 2002:a1c:9c87:: with SMTP id f129mr3547620wme.26.1578486783328; 
 Wed, 08 Jan 2020 04:33:03 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/38] hw/i386/x86-iommu: Add missing stubs
Date: Wed,  8 Jan 2020 13:32:23 +0100
Message-Id: <1578486775-52247-7-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

In commit 6c730e4af9 we introduced a stub to build the MicroVM
machine without Intel IOMMU. This stub is incomplete for the
other PC machines. Add the missing stubs.

Fixes: 6c730e4af9 ("pc: stubify x86 iommu", 2019-12-17)
Reported-by: Travis-CI
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191220154225.25879-1-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/x86-iommu-stub.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/i386/x86-iommu-stub.c b/hw/i386/x86-iommu-stub.c
index 03576cd..c5ba077 100644
--- a/hw/i386/x86-iommu-stub.c
+++ b/hw/i386/x86-iommu-stub.c
@@ -32,3 +32,12 @@ X86IOMMUState *x86_iommu_get_default(void)
     return NULL;
 }
 
+bool x86_iommu_ir_supported(X86IOMMUState *s)
+{
+    return false;
+}
+
+IommuType x86_iommu_get_type(void)
+{
+    abort();
+}
-- 
1.8.3.1



