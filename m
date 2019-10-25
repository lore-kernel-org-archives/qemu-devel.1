Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DC5CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1901D2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BVJvA2yq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1901D2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtGW-0008DI-Nq
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 02:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtDv-00033N-1j
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtDt-0008Ni-Vw
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:22 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:40998)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtDt-0008NI-Pq
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:21 -0400
Received: by mail-wr1-x429.google.com with SMTP id p4so902806wrm.8
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HDnFETyoSIS8dCFtwOkMGxSV5Cme4iWm+VQG9FYgBJY=;
 b=BVJvA2yqHYZAiaGEyIppJbFRs4G+yCx49/V6avT4Sa/D/zgUQeoKJiakUZdu3stBEy
 QoYV+/8yFVQ71uaUzZEyZZpnGuxBl6aN4/9hHDjeLE4TPoNLi1uRqIxoQrFc6EqBXl/6
 KolpLIlmKhkYiJ2G0VNF+cVjziA6AAmohYAXo27QUiS6Pw0mOVJIoYOpIypWiRwT4Z2D
 sQAE+2gAkPm4epyr5jB1M0Mwula1HFBfRA0EsQzLR8Nz2AqzFbcGAdSUS/6TJxCdw+HN
 8m9Ht7qHz/O45FWX3DtRvjNb0XV3s0H63EHypDR46CL84DB6DAghqeBgvfWOJ8DYDIHx
 lHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HDnFETyoSIS8dCFtwOkMGxSV5Cme4iWm+VQG9FYgBJY=;
 b=p7LQ8ECa8NWWlv0cQ+nPPCqal2c9Itc5fcqvQqa3qu3IRQgI91vU4bfFCpmz5zIAic
 kpj7eczMzUFoPsPVABV7gilJFmoj5BJuFNhoag0PTAxw5E3JAQy62rkWidwdb2CcFuyG
 90PZKNv51a4jam60B59njqXbNChi8BPjV/DdHkdrltP2xi4DBn69gCDuTqUERoF18Er2
 iO6NFUrer9y4Ue3MtncMiY2JHEFqURcEakSYcaXfjKLMG2/WrycTtl/ezLI2jgbbvjCK
 kQKn2X9gVsJ4ga2CPrgBOiGT18hZe6MSJI4I90+jG0TT1LGkqVkvYLnliaM4PAUGNOuJ
 ViBw==
X-Gm-Message-State: APjAAAVuw2PChG4Hr7snabMMTwd1rO1h7kyE6ry6m+hmoJlcgJlApVqa
 GjaZMK014JCaj/QM47GqWFLmDg==
X-Google-Smtp-Source: APXvYqzvnQA7cEtuiXQPHTC06pAqXiIAkUSd+m3DbTr3PyLveYkGD0xDHxT/zj2VAYgnUs5VpIlbvQ==
X-Received: by 2002:adf:b21a:: with SMTP id u26mr1300646wra.119.1571985440635; 
 Thu, 24 Oct 2019 23:37:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d11sm1269265wrf.80.2019.10.24.23.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:37:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 312AA1FF92;
 Fri, 25 Oct 2019 07:37:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 05/73] travis.yml: Fix the ccache lines
Date: Fri, 25 Oct 2019 07:36:05 +0100
Message-Id: <20191025063713.23374-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The "command -v ccache && ccache ..." likely were supposed to test
the availability of ccache before running the program. But this
shell construct causes Travis to abort if ccache is not available.
Use an if-statement instead to fix this problem.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191009170701.14756-5-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index e65e53f3d7e..7e0d4ad2b31 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -91,13 +91,13 @@ git:
 
 before_script:
   - if [ "$TRAVIS_OS_NAME" == "osx" ] ; then export PATH="/usr/local/opt/ccache/libexec:$PATH" ; fi
-  - command -v ccache && ccache --zero-stats
+  - if command -v ccache ; then ccache --zero-stats ; fi
   - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
   - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
 script:
   - make -j3 && travis_retry ${TEST_CMD}
 after_script:
-  - command -v ccache && ccache --show-stats
+  - if command -v ccache ; then ccache --show-stats ; fi
 
 
 matrix:
-- 
2.20.1


