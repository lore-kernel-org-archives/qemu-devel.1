Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207FBC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 09:17:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B28F82068E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 09:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YZNNgv2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28F82068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOHCN-0002RE-TA
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 05:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOHAO-0008Um-On
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 05:15:52 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOHAM-00085U-Fn
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 05:15:52 -0400
Received: by mail-wr1-x443.google.com with SMTP id j2so960147wrx.7
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 02:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=K/NN3NZEzXuiMEuQI3WFpeqHPOu1g3wsQaoHfhJznyM=;
 b=YZNNgv2xtX53o+Z41JVjOR7YbBV4ge05CqmnD4Hh2z0ekuID0/fK2wdNkEeTb9h6sD
 cCjdLoYNekyvbjpRHmXl0vshD3dsABBN1Xk9jI3QsNIYYUYMvnj5Mv9zdM/ZmL2AOaRq
 bZxxiP6zcOgUTvtjfEfxkelu3nFNsrzf99a1KTaU7XLthMZES4DcH+TVAm+I8xCf53Vv
 0ZLbcjVlt11oShR/AwzLqLiqJvwdkUoDwitMpqrR+5loSGsv+67HMVF/3JsM6ztC+IYz
 mcz8PLhvPxJJycUMxqkJPnr0LzQXyr9rGdHdfEX9S0ENTI3wL1Kq6QFvkSpQkFxkV7V6
 eR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=K/NN3NZEzXuiMEuQI3WFpeqHPOu1g3wsQaoHfhJznyM=;
 b=kcV6862rGU1Wx3eghpX4rGiSwkPPaO+DLVmvOUf5SAkx80Qr7m3qEKJ7E/ZEckakL3
 oMx50cvKcybbno4+/Jyh33bIHwGSuhTZRfhGaat4tZAaVMoIgMWYeEl0rL2QC1Yj97im
 9img3dlBUCBjbzZDoxoKCFFCXmPE3FcvnMWs52aoXVh/KO2RQCWGSrlGkGrz0BgRriP3
 zef1WO1BIULMqzxTsJmfN3CEtRfMjvpseK8DW21uBhW/RV+bICzyb7yaYJHwAc1/HjJa
 VIX6RyTnunH9AIs+cKsOyNz+LBnhyC2fyW/UAI0JzAZCVSjQujTALTakn5C+ZuDELBPI
 hHqw==
X-Gm-Message-State: AOAM533ck9guIWSvcd3yLEnJqN6oTtxVGZvCCxmYN52f9FkwfkNjehPF
 vf+GY86TCEg0lHtInttQLHuzpw==
X-Google-Smtp-Source: ABdhPJw7fbIJIopjs76xpyhqBry6x93LCgnyxCP0Ol9+3xxnclTHvjeFS4vojlv/lD+OIGmti2mHhw==
X-Received: by 2002:adf:e7ca:: with SMTP id e10mr1829354wrn.236.1601630147133; 
 Fri, 02 Oct 2020 02:15:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m18sm1188642wmg.32.2020.10.02.02.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 02:15:45 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 48CB21FF7E;
 Fri,  2 Oct 2020 10:15:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] gitlab: split deprecated job into build/check stages
Date: Fri,  2 Oct 2020 10:15:38 +0100
Message-Id: <20201002091538.3017-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While the job is pretty fast for only a few targets we still want to
catch breakage of the build. By splitting the test step we can
allow_failures for that while still ensuring we don't miss the build
breaking.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.yml | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 346f23acf7..a51c89554f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -270,9 +270,24 @@ build-deprecated:
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --disable-docs --disable-tools
-    MAKE_CHECK_ARGS: check-tcg
+    MAKE_CHECK_ARGS: build-tcg
     TARGETS: ppc64abi32-linux-user tilegx-linux-user lm32-softmmu
       unicore32-softmmu
+  artifacts:
+    expire_in: 2 days
+    paths:
+      - build
+
+# We split the check-tcg step as test failures are expected but we still
+# want to catch the build breaking.
+check-deprecated:
+  <<: *native_test_job_definition
+  needs:
+    - job: build-deprecated
+      artifacts: true
+  variables:
+    IMAGE: debian-all-test-cross
+    MAKE_CHECK_ARGS: check-tcg
   allow_failure: true
 
 build-oss-fuzz:
-- 
2.20.1


