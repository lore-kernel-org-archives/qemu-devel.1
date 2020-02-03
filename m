Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C37C3524E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:11:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D9852070A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kkam3Opx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D9852070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyXlC-0001IF-Ao
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:11:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXji-0006XY-MC
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXjh-0000wY-Ob
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:42 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34610)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iyXjh-0000v0-Iw
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:41 -0500
Received: by mail-wr1-x441.google.com with SMTP id t2so16939331wrr.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 01:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1wLWmDgRiIkKucwCgJ//XrBy92vKXWVigFdXtGHpocQ=;
 b=Kkam3OpxsqDYIcXjwqZ1R5kUUHUGx1ubFtUKYjMl4F2g8O1HCJUOoJVWKIfr/zIdxk
 nUD8Ea9If0JhfimnME8QKPSlKHMYOMnS+L38GYwgSMbZ/U0h99b7jOrSa2gcEzzxC+qM
 aFqCghYsNqnQJ0tbQb1BQT3VO1IeRDqRebJJtERlaP6vlpmyj3HfveUIS4F4DsqlWFO8
 Zxxg9nI/FXb4fBIsSAzcVO3xtNBr4/NMOJGFUYymk2FxQgADRNTBAd32HzvEntgPvN6g
 MQKMU/wbocFSRNvPRYJ75bts8TbKs2h2Af17dOclnZhldbUb/k30PURqViylJUPdRxs3
 bzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1wLWmDgRiIkKucwCgJ//XrBy92vKXWVigFdXtGHpocQ=;
 b=czg/CNQnnXhmxp3WJs4u0Fvbzw8nNfYAibXDFKkeiSQ8ByTpnnr78KdpTDJQFW+x/k
 xj1D9lQPhlIloAT2aFlscgdUbAsrQwriMHynKKLlarQM+Soi/hiuqXPxosuAVGc+36yZ
 Mw95YQ/SpOYkgAvlbdGq2+V0VMet7CYB12/Lcy2FXCcJBQsE7iNcY8Eob7v342TnBQA+
 R0U0stXIDUkqV5Mi7ePsHew9W7mnCCeoC3qobovy6q58ag09o1FRZPFasRYUiUH1gmUK
 BBZFeRDX1vffewacAlwcNl3lDxiM5uE0n/ztWuScAOMylVT4ICC0+AfhgxE6DhxTJpPt
 3vow==
X-Gm-Message-State: APjAAAULJuWWVgJk3fqA+LdrPPAV2Pxk25wYVroNXY8Ep4AXSpdvYruK
 NnOpwAgzzctDQpSEoe8MxALS2w==
X-Google-Smtp-Source: APXvYqypV9sgvz7WR8cwqv3rcVyHkEZ1CRKxY8csxlIq6Vvp3wXmYiDyM60JaiHOLoqVNQKgYVdsZw==
X-Received: by 2002:a5d:62d0:: with SMTP id o16mr14067204wrv.197.1580720980664; 
 Mon, 03 Feb 2020 01:09:40 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f14sm5146807wrt.7.2020.02.03.01.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 01:09:37 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C4E631FF92;
 Mon,  3 Feb 2020 09:09:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 05/17] .shippable: --disable-docs for cross-compile tests
Date: Mon,  3 Feb 2020 09:09:20 +0000
Message-Id: <20200203090932.19147-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203090932.19147-1-alex.bennee@linaro.org>
References: <20200203090932.19147-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The sphinx support is fairly new and we don't seem to have all the
bugs worked out for cross development environments right now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .shippable.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.shippable.yml b/.shippable.yml
index 83aae08bb4c..2cce7b56890 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -37,5 +37,5 @@ build:
     - unset CC
     - mkdir build
     - cd build
-    - ../configure ${QEMU_CONFIGURE_OPTS} --target-list=${TARGET_LIST}
+    - ../configure --disable-docs ${QEMU_CONFIGURE_OPTS} --target-list=${TARGET_LIST}
     - make -j$(($(getconf _NPROCESSORS_ONLN) + 1))
-- 
2.20.1


