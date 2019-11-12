Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CA1C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21A3620656
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="krw2ZxDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A3620656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUXYE-0006U5-6v
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 09:53:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUXVC-0003Wa-BY
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:50:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUXVB-00036l-Af
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:50:42 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:50408)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUXVB-00036A-4M
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:50:41 -0500
Received: by mail-wm1-x32c.google.com with SMTP id l17so3523389wmh.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 06:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vY7V32XD/jc7g4KIqXW4kFH1SEbrWpPCQjXNemV53O0=;
 b=krw2ZxDySkm3o9mNFrQqb7DUTW05rIj8SuopYbqsUmq+xzJZoiH2moT5v2ygMq+btH
 FhZoJr4CQN6hZFI+Euq1KUOTQK7OV0QpxrA1lnDfSq+RcZd1aYvJf20EY25Tpdd9E0C3
 8pq4gwblHCtFQxZQ0WZ61s5iaFplAXJ0HH/bxPPxAc5AszScJWJDU5CZcHXW7ZdLurU+
 tRuECfAgiMtbpMkoodPuInL/tgGasaSAFPRiCo9mX3UlAEjtyuAV+ypFifJ7tBReeCh5
 2VfcMDa6TLxATw/scvbbqUfT018OLPzNFWxv3+2uoI/STwBFD6VrmPfRvzA2mAe0ob5I
 Wy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vY7V32XD/jc7g4KIqXW4kFH1SEbrWpPCQjXNemV53O0=;
 b=N8Emk9LWRMVmODcm/Vv3wkbZ8jZh2LWwVGT5qw7fvwCrZNRvgislDcpEiI49dhATuI
 Xx00s7AUOGo3gaLPPEjn1tRwhViY/AuB3msxN1MARCyXSfVwb6b0WsZNXBbAYwScKHDp
 BgpCIzHeiwX0bvAjU9htUwaLD4IOrL9pPLmLwEwkovJ58j4nJ2TpsFjt92QgNLCngjQ4
 p1O82kuroMtm8tZrJfqupCNDtp1ouxbQI2BnvYP3HsW9aQDWTHZBiGcGsPOF4ZNEXSay
 5ButaL3rwKkvlK6FlvtQD5irwjXHxmun2dgsHoqF1lWPMhmECDUC+2a3cxfhZXYoHrKs
 dktg==
X-Gm-Message-State: APjAAAUI5hnNSwr/b44GdEhNacOU2csPZaA2RHUz9UsF3hx1hgliTyBI
 oFziGT8m78TH7WynHFac/uKS7w==
X-Google-Smtp-Source: APXvYqyVr/Xtke1Iyd9e99ZL37bUKeYRvRJx4iJCROPZeMMlPDysS3UsayQV9kYuleXO9dHlhKx7VQ==
X-Received: by 2002:a1c:6588:: with SMTP id z130mr3888853wmb.87.1573570239990; 
 Tue, 12 Nov 2019 06:50:39 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x9sm19479424wru.32.2019.11.12.06.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 06:50:35 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A17C31FF96;
 Tue, 12 Nov 2019 14:50:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 7/8] .travis.yml: don't run make check with multiple jobs
Date: Tue, 12 Nov 2019 14:50:27 +0000
Message-Id: <20191112145028.26386-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191112145028.26386-1-alex.bennee@linaro.org>
References: <20191112145028.26386-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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

Let's challenge the convention that doing more at a time helps. It
certainly doesn't tell you unambiguously where in the test cycle you
were before the test hangs and exceeds the job time limit.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 678e33decc2..b9a026c8eeb 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -77,7 +77,7 @@ env:
     - SRC_DIR="."
     - BUILD_DIR="."
     - BASE_CONFIG="--disable-docs --disable-tools"
-    - TEST_CMD="make check -j3 V=1"
+    - TEST_CMD="make check V=1"
     # This is broadly a list of "mainline" softmmu targets which have support across the major distros
     - MAIN_SOFTMMU_TARGETS="aarch64-softmmu,arm-softmmu,i386-softmmu,mips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
     - CCACHE_SLOPPINESS="include_file_ctime,include_file_mtime"
-- 
2.20.1


