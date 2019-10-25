Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7231BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 427E82070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lorccuDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427E82070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNxyg-000235-4f
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNxwJ-0006KR-L0
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNxwE-0006aR-K0
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:30 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:40944)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNxwD-0006Zo-8V
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:25 -0400
Received: by mail-qt1-x844.google.com with SMTP id o49so2704427qta.7
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 04:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=eYlJyuG0D2jRtROBHsXLKAoXJWfo30B11DHLmtIIcdc=;
 b=lorccuDTMLh+8D/MRvn/3jcXAo7cRKC5jenoqK7271yUwJicWS74fBvv2mdCMT5AaV
 L/9VjuFt3KSawxcv3i76NZ1d2zvFJQkkWPnP1vRaXDxVo+ss82JqG0hD8I/I9TMPKfmC
 pQv6v1govTTV8SjyWSINJYG4CR1Sy46GtKUvechu2oz8qAjwDThTPZMwC8a6ei46Hdv8
 VJ5e2V6ESs7s7KOs1NiWEzKnrQj+AfCmdakFzrr1wiQjD6U81dMy5Grda0L+iWRHCtQN
 1awF1gprZVYDTwviGFVd/0KjZfEAgA7L5XcKZiRYBdc97mH7zDr0UQ5lA83LS8r2Na6L
 ewKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=eYlJyuG0D2jRtROBHsXLKAoXJWfo30B11DHLmtIIcdc=;
 b=KOHquydTdYTbXmaQaE9a4+gKzjUrn9O/VXaSC+RIWyQO4qKy6XDauygrDuw0dofI2f
 Kg+uNuyt3q0qeqhBDgt8yXbnj2pdOvtUMtXjmbf7n7owmC26Z5/E/N+9G/uJY4vdDjzi
 54wlyjfSNupnNNoMdFhQhI+F/aJmpT8H71qVDtR2qqEtQCg64eQXsncOX7w7+1U167fM
 lqZc0rOEid0wAyuXtM+Cw5eMDLV7ihc5Qtlib99qgiBlHb1ag3uagnvXS2v8vLI/pN3b
 K8jUnQeQIOvTOjVbAeoePR8LZoXsXgkUiKcaV+S8qzkSMEsPJXzzzX7O6IjOBIqqgJ0+
 WYLQ==
X-Gm-Message-State: APjAAAX4Ee6CnP30yD+YuRLGQdoxheijfibfRFNl81ehgcRcRcdoAxTL
 ws1XBzjBvhUTQ3LQTQO5Lg1yCjRvweM=
X-Google-Smtp-Source: APXvYqzzVG40aEcH6EubCiVYH7CCZx5WbXgbca20sBIe4BoH6UxBD05OKgAjW3eAKf/wIWOQobC7Hg==
X-Received: by 2002:a0c:b918:: with SMTP id u24mr2759288qvf.212.1572003563868; 
 Fri, 25 Oct 2019 04:39:23 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id x38sm1473335qtc.64.2019.10.25.04.39.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 04:39:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/12] scripts/qemu-binfmt-conf: Update for sparc64
Date: Fri, 25 Oct 2019 07:39:10 -0400
Message-Id: <20191025113921.9412-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025113921.9412-1-richard.henderson@linaro.org>
References: <20191025113921.9412-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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
Cc: alex.bennee@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Also note that we were missing the qemu_target_list entry
for plain sparc; fix that at the same time.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/qemu-binfmt-conf.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index b5a16742a1..9f1580a91c 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -1,8 +1,8 @@
 #!/bin/sh
 # Enable automatic program execution by the kernel.
 
-qemu_target_list="i386 i486 alpha arm armeb sparc32plus ppc ppc64 ppc64le m68k \
-mips mipsel mipsn32 mipsn32el mips64 mips64el \
+qemu_target_list="i386 i486 alpha arm armeb sparc sparc32plus sparc64 \
+ppc ppc64 ppc64le m68k mips mipsel mipsn32 mipsn32el mips64 mips64el \
 sh4 sh4eb s390x aarch64 aarch64_be hppa riscv32 riscv64 xtensa xtensaeb \
 microblaze microblazeel or1k x86_64"
 
@@ -38,6 +38,10 @@ sparc32plus_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x
 sparc32plus_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
 sparc32plus_family=sparc
 
+sparc64_magic='\x7fELF\x02\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x2b'
+sparc64_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
+sparc64_family=sparc
+
 ppc_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x14'
 ppc_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
 ppc_family=ppc
-- 
2.17.1


