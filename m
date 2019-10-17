Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9F0ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACE2E20854
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDdOyxys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE2E20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL73m-0000io-GT
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5wH-00064X-5q
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5wF-0004ZG-1R
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:37 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36066)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5wD-0004Tr-08
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:33 -0400
Received: by mail-wm1-x342.google.com with SMTP id m18so2583023wmc.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DKDSgoO4X4mkmor+GmSjidzV3ElN8/JotjJqlZ/rV+M=;
 b=fDdOyxyslCaLjYImUfgtMRcY8xcqNA8jKLeVNarCrrUu7SIyH8A6LfzwxY+joqt7O8
 U/91QMBkHMVEmdyuNm9yHsaqb1kONfPgck4pR1YPVS6rqUhOsrGg9yU7LNRpsvzRPx6c
 7+Qr1n6pBkJgmdPeQr/r7KKYTq63Kcu6unWhRGpcFRv53gFYf9qvOsmBTqHzPeGqtp2/
 Gxq1XySM15t1D4WMZ4eqpwBf08ebWiPv1K6ilelwGQddEiEa/300+ZDmAwWfA1bMd533
 ElWC0HXHosvaAbgkV5Dt5NC57NfjVypTyI6OhH2g+SB6hZo1HX4v/W5sCv4eQPX6B8ck
 I00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DKDSgoO4X4mkmor+GmSjidzV3ElN8/JotjJqlZ/rV+M=;
 b=ai3UdLew4uT03KXhXKfYWE8GdiDEJA4btqo3l7sbtD0KZ+8N5/xxe0SVeiZzhZI/Zx
 q4PAWvtE0ckeV8I22/udku7JL/DlCy7vwyBMBPOefc62p/+HpBp3rZ7JgcDKrzKdGzvv
 oUPZkavaYlj3V4TtloUxDCIpZTmlAFfsbo0UKEa4fQ9Pfn3Qz62jnheP/pAe2sksrnML
 V0v7ijMpKxpXipk4o6UZ2+z+VXZ4zY+GRhwzEI1OmpJALZdGIkQ2m/rnT1vl7Vg5if/S
 GOygG/pnSC6b8H30KADdt/nwJ/wk55eOEnTkaxUXf++D7xY+KXcJVv6l36ZJlaSAo2sZ
 YUgQ==
X-Gm-Message-State: APjAAAXRnSJMoMn6df0+jK/hwYfaF39gEzqk1IdPKnq8w5ZMmQ8FCvFe
 t5QKwY3Z2W+Xx9zAFHJfQ+k8pg==
X-Google-Smtp-Source: APXvYqxhLYSE+BUeUh41owM1JcqMsnESOSkX0AAeXTOHr4YBiFVRNtuhpJnukVImcJR7RYwFs3QaRw==
X-Received: by 2002:a1c:ed04:: with SMTP id l4mr3096433wmh.116.1571319331023; 
 Thu, 17 Oct 2019 06:35:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e17sm2256294wma.15.2019.10.17.06.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:35:26 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E15171FFCA;
 Thu, 17 Oct 2019 14:16:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 53/54] .travis.yml: add --enable-plugins tests
Date: Thu, 17 Oct 2019 14:16:14 +0100
Message-Id: <20191017131615.19660-54-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
 robert.foley@futurewei.com, Richard Henderson <richard.henderson@linaro.org>,
 peter.puhov@futurewei.com, aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

check-tcg will automatically run the plugins against most TCG tests if
it is enabled in the build. We exclude sparc64-linux-user for now as
there are pending patches that need to be merged fixing it's fork
implementation.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 .travis.yml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index d0b9e099b9..37bca1ca1c 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -334,8 +334,23 @@ matrix:
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
 
+    # Run check-tcg against linux-user (with plugins)
+    # we skip sparc64-linux-user until it has been fixed somewhat
+    - env:
+        - CONFIG="--disable-system --enable-plugins --target-list-exclude=sparc64-linux-user"
+        - TEST_CMD="make -j3 check-tcg V=1"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
+
+
     # Run check-tcg against softmmu targets
     - env:
         - CONFIG="--target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
         - TEST_CMD="make -j3 check-tcg V=1"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
+
+
+    # Run check-tcg against softmmu targets (with plugins)
+    - env:
+        - CONFIG="--enable-plugins --target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
+        - TEST_CMD="make -j3 check-tcg V=1"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
-- 
2.20.1


