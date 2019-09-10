Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8032C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:08:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1CF9206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WtQUS8RG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1CF9206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7c8g-0004QY-BS
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqx-0000q3-Jj
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqw-0000ea-Gl
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:23 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:44459)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bqw-0000dA-AJ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:22 -0400
Received: by mail-wr1-x435.google.com with SMTP id k6so6265148wrn.11
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l8xD4JKTs5aV1GPbbelxFIDDOIFZEGHKpHk8K7Sxfm0=;
 b=WtQUS8RGkW54NVZMDmj+tsszuXxUnh2t/ouVeaAn+bZ7w/O7TCclqPDEFlqSM1+ZGv
 Hbs38bAfSYbBr8d1sGJo9rV9ce2kPdX65/komC4p+9awc0KvX7lZv69Ej/x0HVRgsxk9
 c4eAFD8MRluy+qg8qoSqLoeTom5CghEx8nqGLQ43oJLinFg+YCDm4dgEk23Jz6eTfo5O
 OHAWrRd1u7T9AcsPiP/Kz3JPASYv2dLxHB4tBbuO75BmG4naYVLGwOwsFqPCpeyoTgcu
 OIsM3oGh4z28gg07GwKcUac01KfF6uf+2Rhwtj0qaZqA94f3kAcyoanXFl7JHJJNcun7
 hZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l8xD4JKTs5aV1GPbbelxFIDDOIFZEGHKpHk8K7Sxfm0=;
 b=MlZu2X1MpbF51XbgSEiALmyi7LLPVPCfwccaw/aKdHRBUNIbRonkhtBuLJe7FFyY30
 9T1wm/Teh84DogzxOOwr4n3UCM3XikaMN9v7z/X7vInqehpNDTQqob4wF4cck1m8oj0Q
 CaoUEGancySVOhRPMQE7UzPcg2DvsZP3eHJKv8H+7jCEFJnjbKTcxiTGIU3L7kpXPKUV
 Oaooapk3vgWA1BgWRtIf0yJw7BJeJwzBAkOOoDnfde9yb/2iu0S1GZyx/TQjy97Q6nuT
 qMeFoDehDJL1mrhDzN7dAClXVBNcM2VSMWOfYDRiFf7hc0d7owF2o2ltZeYm7jBZYQZv
 EJ9g==
X-Gm-Message-State: APjAAAWX3fgunyOCesO21ES61EGbX27kdEnWESfEf91EuO0cNvcSs/WS
 mYE9vKi4PHj0ei2sThiYKy7zGA==
X-Google-Smtp-Source: APXvYqyhwdvQiYNcwFwtmbVpshEPnAmiCqMXJQxqG9EvppAjxYUZ84x29ei/PgNlaNKLvrj9GUglZg==
X-Received: by 2002:adf:bc84:: with SMTP id g4mr24879833wrh.135.1568105421337; 
 Tue, 10 Sep 2019 01:50:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e3sm24590515wrh.12.2019.09.10.01.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:50:19 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B7D621FFBA;
 Tue, 10 Sep 2019 09:43:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:38 +0100
Message-Id: <20190910084349.28817-35-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
Subject: [Qemu-devel] [PULL 34/45] .travis.yml: Enable multiple caching
 features
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Using the 'multiple caching features' means explode the YAML array,
thus it eases the git workflow (it is easier to move patches around).

See https://docs.travis-ci.com/user/caching#enabling-multiple-caching-features

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20170809202712.6951-4-f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 106f9b5d01e..c60cf2ec135 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -5,7 +5,8 @@ dist: xenial
 language: c
 compiler:
   - gcc
-cache: ccache
+cache:
+  ccache: true
 
 
 addons:
-- 
2.20.1


