Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765F4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 10:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC0520768
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 10:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NIXZ17l6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC0520768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwNzB-0005tn-GU
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 06:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jwNy5-0004c2-Lq
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 06:51:53 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45508)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jwNxy-0003qo-NK
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 06:51:52 -0400
Received: by mail-wr1-x444.google.com with SMTP id s10so10444634wrw.12
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 03:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UTNNPLj2+kMWz6js2JQCoZUUX1PoT8XdOIXnTvMqmsw=;
 b=NIXZ17l6w7bFZH1D8zBLzMJzrl7b3jZYQqstvAHrqyCxRJ2cYeBXYAc30Kc2j+P7Ky
 I0azmjLxTv6ZfNUTmCKEahVToM1J1IsxKMC+QWODp2iaeHFg80l9esf2iwg9gvPNM81X
 lrZRRK9sWmtZ3n3tdC2UchMjzwEox+ACAUNmrWQtKB11dGDtvCmi7Uy0nG6lFUFtcTrT
 56Tr3Ho4lQwEsmMqh3Y0m7AirWYrPXIaap8rWGJ4IiR8Svd3qz5uts24Ycfagdofncda
 jZI01uFq1aLEXu7VIzQf2ubHwmbY3bf3YEMz8oksbKzup6pAQic8IcNRRAjqTsxO3RlK
 TwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UTNNPLj2+kMWz6js2JQCoZUUX1PoT8XdOIXnTvMqmsw=;
 b=k4Q1NVGtU61nkFR37+jR3lKwiDR+Wh+PkWWTd+v+lTW5fzkfWbhyjbJPQ/ESwtVEwM
 EmK41oHOssr9PWtF4NbZrhWcUIwY+Xj5xQ7R+HpKzDO4AEQ2PxALGo6f0IpI48OjCJ+X
 MhC/VulT5SsB7eQvDj5djV4+lASx5XJTeuv6BneNI55V2Y/fhDEWdBTZf3SNjU7zJNOF
 hvvEGHXe8HJ3hN29Ato2c+uHOzjLx6BU4xHT92HQDqIGj3uyurVodagROoufuCEtngDc
 z9CA08cSdWddFElqnyFWrO8B5ru+0mn9pYpQVPSdVWVoVJpE7YEVPaFpQ9Kny73jBcC4
 my9Q==
X-Gm-Message-State: AOAM530L+3F7y1/lC2UlP2OKigVD2EP08PxaVP98/+obKrlRc1bbWOmR
 e+PSCHmi92/8BS4oytr3akEB4w==
X-Google-Smtp-Source: ABdhPJzJekrXgd8UkGDZidqSD+I/3umaYrZkM0HxRuVVJ/2Qf7kkrLfeTDsRVb7D+OnI2zOwsVOZhA==
X-Received: by 2002:adf:e684:: with SMTP id r4mr9657478wrm.68.1594983102355;
 Fri, 17 Jul 2020 03:51:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f14sm14343778wro.90.2020.07.17.03.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 03:51:40 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A77241FF87;
 Fri, 17 Jul 2020 11:51:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 1/5] shippable: add one more qemu to registry url
Date: Fri, 17 Jul 2020 11:51:35 +0100
Message-Id: <20200717105139.25293-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200717105139.25293-1-alex.bennee@linaro.org>
References: <20200717105139.25293-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The registry url is <project>/<repo>/qemu/<image>

Perhaps we should rationalise that some day but for now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .shippable.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.shippable.yml b/.shippable.yml
index f6b742432e5..89d8be4291b 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -27,7 +27,7 @@ env:
       TARGET_LIST=ppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
 build:
   pre_ci_boot:
-    image_name: registry.gitlab.com/qemu-project/qemu/${IMAGE}
+    image_name: registry.gitlab.com/qemu-project/qemu/qemu/${IMAGE}
     image_tag: latest
     pull: true
     options: "-e HOME=/root"
-- 
2.20.1


