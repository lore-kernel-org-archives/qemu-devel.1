Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14710C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:48:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B2D2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h0kwz5Z2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B2D2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOJXv-0000sf-RO
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 07:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJTs-00056T-W3
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:44:09 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:44791)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJTq-0008Jx-QS
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:44:08 -0400
Received: by mail-wr1-x42a.google.com with SMTP id s12so1453943wrw.11
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 04:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Sw/3goSUiCxY/MVA9ukyQAGw3H0eg7e1C2bUH/esumY=;
 b=h0kwz5Z2kppQG2VBDmsPvSw6XMjfCg8NXGr4jGnhp3TzOgNlmn077LDEETklAme38q
 VON3EQrj2MRLN/2yQLywLHDNS+FdVTePHiJdGALGSPxoc/I/6SIBcEv6L+T9dxNyg6jd
 23z1P0nwX+2FA2dpN3zq/AgV9XGH8/Gx24p7lGGquxWtPG0P6W3Qo0FSyfCwfmGa+JmL
 qLm6nckKXCupP7Q1J/k+ilViqo0f7PDeMYsMreuUKZwhUy6zQRlZl67QcekHEPbgGQ/Y
 1C2E96+TJewjXEooP2hf0jAyeE9pueNIVcoiemfqwEAHtlMmzyurCIgyGs+FJsAgCjrj
 7o5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Sw/3goSUiCxY/MVA9ukyQAGw3H0eg7e1C2bUH/esumY=;
 b=Myd9CufteZP76r5byhTpIzJJE3FGn9MkEOVQeWxcyV+iyb1/krOgumkJ7/rrUkTx56
 uyv1fmMgJO+5io8obafvjmUj3nKA9QBaLbtxAHKjKLZOCeddjSM7qDCSAg1xTR7g9c4Z
 eJ409DG2O7RWiTyNVP0HM3GXlRyfvvUBGkTcCPlUJf9yF/0/tWMOfIq8nYf0xkoy2fL4
 8EqqXf32woPj15oKq3eUQ/5p+cWeQ96JNGzzIAOv4PZrx/lISxuPOkTYxCH5W7tfS+/e
 2EYWo6WNlF9pO3g1FROSKAdUwj9rpKrQhb416rDz9BEmDL8sY2LvqE52d0qW813dBfIc
 tdMg==
X-Gm-Message-State: AOAM531FOdGY3pwy7i/8ey+XfcXftVvSaRd78CusKNPhCJyAWvHz7FHq
 mORQ0VYsf/TCb2P3WPszF0tZVQ==
X-Google-Smtp-Source: ABdhPJyp6XatdRTqCgcSHZStStMo2sZI/YqZCQPFwNQGslpx+80xjB4BeX1rhIBFNBbxViFx1PePmw==
X-Received: by 2002:adf:f802:: with SMTP id s2mr2487065wrp.328.1601639044868; 
 Fri, 02 Oct 2020 04:44:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 91sm1603548wrq.9.2020.10.02.04.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 04:44:03 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 401FE1FF9D;
 Fri,  2 Oct 2020 12:36:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 14/14] gitlab: split deprecated job into build/check stages
Date: Fri,  2 Oct 2020 12:36:45 +0100
Message-Id: <20201002113645.17693-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201002113645.17693-1-alex.bennee@linaro.org>
References: <20201002113645.17693-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While the job is pretty fast for only a few targets we still want to
catch breakage of the build. By splitting the test step we can
allow_failures for that while still ensuring we don't miss the build
breaking.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20201002091538.3017-1-alex.bennee@linaro.org>

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


