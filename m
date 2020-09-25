Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBE2C4727D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:40:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53BE3206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aoFRQTk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53BE3206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqll-0001Ye-FR
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVV-0006kO-Am
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:37 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:34299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVT-0006pZ-FQ
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:37 -0400
Received: by mail-wr1-x42b.google.com with SMTP id t10so4270846wrv.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 09:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FBXPGy4Klp9jR272eFs+vFXX4JatTC9w4gnl2L3wGwM=;
 b=aoFRQTk8aCC3CHzz0MKU/jnPXCmTb8bzpkTpPXd+TvFw3NfehyZi6fOH1f+Fxwvkk4
 dNCx8BEuf601p05FQMPvGD7OZx1fWaoBrdCxgsE80tSu6yyFN83anJeVNz8hwUKJjp1R
 ejN+/kd7rG90qE4p8PtwREKV2otmIX4i9BlwTo4Pbfkdw1OYCnebXlJSNcyAjKsaDT8U
 oNIirMulqWpHYSRXjDznDpvzg22JT0AFsDQIXdvGCtFKFLvg/ZAsxZ9TYh8US/ExMKJv
 T/z6N1kef+urrraW1mbQOaVxFbwnMAIwOmbQ+oDsFxyHBZvkwvslXzXO+HzRb2dRUp+w
 8VmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FBXPGy4Klp9jR272eFs+vFXX4JatTC9w4gnl2L3wGwM=;
 b=lUBdEYlEGKpOfm6N8AjtRjESWgesj1eiX+XZDD14EL3Iaz7ypd6xZ4dPZAzNSYWktl
 yMCB1vmTJr/4N3RGwj3dOj+lSqmUE+r2TLbr69DxEDm+2/JKND5wf6Bad9W1Epz4xVLY
 wSqp2KD4yYOt2h6nHzy8oE2G2cbmuh/bxQ19/IfPIEoYf1XkSe+NgaIM4AVVFQp3Y1R0
 zz1cygy7JPlvvNOKG1FgRzzbkG4g5eTxIHcDiNBX4nINYr7M/imxbVEmW3PYJCJV/qnK
 vxnAOzGiZ0Ffec0H95AKn8geVrAQySgr0Pzh6DkEMii9MWHcDTeIZ4bZexBwCxIvxAMV
 ROTg==
X-Gm-Message-State: AOAM532SZYYZPqSmlFYOM8+5KtCPgkqgxz7GJ4Rea6ArAIAKXvmJLyiL
 1you0nlbJ8wWYq7YDcrVTSPxNa9jLjIJ4lmX
X-Google-Smtp-Source: ABdhPJztB7Nfdn+wqkAa4jjRlgpJGNfZ647xrloJJWdmyWDZEbmnaL5/KvLHNMtTfGGGwAvHIYfBDw==
X-Received: by 2002:adf:8b1d:: with SMTP id n29mr5156184wra.383.1601051013686; 
 Fri, 25 Sep 2020 09:23:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d6sm3565824wrq.67.2020.09.25.09.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 09:23:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 13/21] meson.build: Move SPHINX_ARGS to top level
 meson.build file
Date: Fri, 25 Sep 2020 17:23:08 +0100
Message-Id: <20200925162316.21205-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925162316.21205-1-peter.maydell@linaro.org>
References: <20200925162316.21205-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We're going to want to use SPHINX_ARGS in both docs/meson.build
and tests/qapi-schema/meson.build. Move the definition up to the
top level file so it is available to both subdirectories.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/meson.build | 8 --------
 meson.build      | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/docs/meson.build b/docs/meson.build
index 69097e2ca07..99da609e813 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -1,11 +1,3 @@
-SPHINX_ARGS = [config_host['SPHINX_BUILD'],
-               '-Dversion=' + meson.project_version(),
-               '-Drelease=' + config_host['PKGVERSION']]
-
-if get_option('werror')
-  SPHINX_ARGS += [ '-W' ]
-endif
-
 if build_docs
   configure_file(output: 'index.html',
                  input: files('index.html.in'),
diff --git a/meson.build b/meson.build
index 73d675ca834..6408ad442ea 100644
--- a/meson.build
+++ b/meson.build
@@ -671,6 +671,14 @@ foreach d : hx_headers
 endforeach
 genh += hxdep
 
+SPHINX_ARGS = [config_host['SPHINX_BUILD'],
+               '-Dversion=' + meson.project_version(),
+               '-Drelease=' + config_host['PKGVERSION']]
+
+if get_option('werror')
+  SPHINX_ARGS += [ '-W' ]
+endif
+
 # Collect sourcesets.
 
 util_ss = ss.source_set()
-- 
2.20.1


