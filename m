Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1397CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:44:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8942070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rWe0ZgTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8942070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtKK-0000iu-16
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 02:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtDr-0002sj-0Y
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtDp-0008Lh-OC
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:18 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:36908)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtDp-0008LL-GW
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:17 -0400
Received: by mail-wm1-x32a.google.com with SMTP id q130so761429wme.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5I5UoFas/oMecYMX9Nd86Bz4Y4H1FsmbDV1CnX/LR6E=;
 b=rWe0ZgTkAlC8UfOmc3669+jDAnTAMhu92Nq9Ql6zv0px97u6z1Kc7pplBlWpukVzRB
 ccxh0JxUV//cZPwen8Eykkp/gIhdPjv0Lpx0MxCMlg1FxRcTxFD16sXZs3uvgjIKIP9k
 zd5LBoGH1VlobU5F1kezHIBs9kwbClyasfRDucJvWSfxn18blCdXL/02jv8iGo/yHBnL
 DErmJFLBGO5OwJTZZAD7b9ASMVCnKMjrD1xX1mu98V7bXWkCtxqqTrm5pZSTs5APiX7h
 sGmDoVqtFPLPaK4eU84VY3Iafobgnz4XSb+1T3jBVS1D2m0NL9gCoUPEhmRVu5Tzj10j
 zIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5I5UoFas/oMecYMX9Nd86Bz4Y4H1FsmbDV1CnX/LR6E=;
 b=c+KBZG3yL87DBJQsb21Fie2WjdFP7uUeVHSmaTNHDBb6rZZbIudnaWonyCk5aBx8Rg
 lnYvVDlly5dI6EazdK4fTNAFSCPlJa+FaBzZE7ugAYRqyJBJNNcA1K7RWsYxyMvlPrOi
 xf8j2MPq5SCRmjjEBE8nfoBmJ0c9KKUL3jXm5JmIoqZYPKj/ZFR+aIs4i28bplphzhvB
 2FfCHZgetilQ1lO2Dkf8ikK9THDqXnfHMUhLCHDJ89vS7o0hpDWEmp51zDG9bqcWylWX
 yq5a/EqAwoKarUaWU90/XotP3Twe7KZaWngXIwL1U53hndjg7LKJPPwiCgFfKEMDR1jW
 iiSg==
X-Gm-Message-State: APjAAAXZtoBuQRhSGAcTiJuJkTOrcGmd728AhQyoLuWOTJNBfHPdnOM2
 7+Ei8kdsRjj1d5omEMt+8l0HbQ==
X-Google-Smtp-Source: APXvYqyoDZNtgZVqxgNCpdWOIuCpZDIeNmXIYVykAOSIs/o5S6KrACTrUZ0MGY2tdnnmGHybRz+amw==
X-Received: by 2002:a1c:398b:: with SMTP id g133mr1971190wma.130.1571985436029; 
 Thu, 24 Oct 2019 23:37:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q14sm1445345wre.27.2019.10.24.23.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:37:14 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CB5631FF8C;
 Fri, 25 Oct 2019 07:37:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 01/73] travis.yml: reduce scope of the --enable-debug build
Date: Fri, 25 Oct 2019 07:36:01 +0100
Message-Id: <20191025063713.23374-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adding debug makes things run a bit slower so lets not hammer all the
targets.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/.travis.yml b/.travis.yml
index d0b9e099b9c..7d90b87540f 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -124,12 +124,13 @@ matrix:
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
 
+    # --enable-debug implies --enable-debug-tcg, also runs quite a bit slower
     - env:
-        - CONFIG="--enable-debug --enable-debug-tcg --disable-user"
+        - CONFIG="--enable-debug --target-list=${MAIN_SOFTMMU_TARGETS}"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug"
 
 
-    # TCG debug can be run just on it's own and is mostly agnostic to user/softmmu distinctions
+    # TCG debug can be run just on its own and is mostly agnostic to user/softmmu distinctions
     - env:
         - CONFIG="--enable-debug-tcg --disable-system"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug"
-- 
2.20.1


