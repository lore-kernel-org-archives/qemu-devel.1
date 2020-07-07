Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD48AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88714206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E5hT2WR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88714206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshsx-0007bq-MP
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshjG-0004yR-DN
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:09:22 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:33746)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshjE-00046Y-P0
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:09:22 -0400
Received: by mail-wr1-x42c.google.com with SMTP id f18so35909508wrs.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+0XGMSv3TRBxSJ9urnyaVy5rxmKlhWwkj3bUWyiYszA=;
 b=E5hT2WR9I5bKLy+mT2XtTMUCmIJcWX/FjdORNIjdTbCjHTzA2f+k/Yl8hD23prS/o5
 zqkysJG8jE7vZUBrPMVRR4R0EgAoMkDI/JX4ILUlPTeoCDn8QzrET34ROJToZzJt2zxt
 EN2DDqFXwmG6DcW9GkuJxRyJPPo6Kj+ojHCJ+qJfQExw7qxPNcmN2jqMgPzMYEuDirSx
 ttZtsfe62qROvPoiv79KrVZtOOijzELEebEmzhBPvTYY4envK3KnAKdCF/t9sBVEKCMo
 bnqXTXIqGRRCMtD4ZTirEK3aPbnhdxD/0sNxZnoeD//nZ0HMv4iddj6synJyS6C/H3O2
 yblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+0XGMSv3TRBxSJ9urnyaVy5rxmKlhWwkj3bUWyiYszA=;
 b=ATE2VaL3q22ZHHRUQ2jdgicCfUPjJ6kWobQOT93l0G1OrxpBCquHo9uTU6fAY6sZAu
 c+nJIRTrE0znJfIlBPUBmk/2wf3wAcVjfJ3FXKXNpl1GN+pDypWDEGKznXBtR/35ed4E
 lkV/OnAUXN9xFiWoxIQR0MCe+GqlYxFnmkZ+zSbffo2q1m0QFC0eOhZlTwISMo4v/iBn
 wuYXCR3qWSdXdD46F+0RFIZIMHlhuq5hS36VyCkXPKuFOylZkrr4fyWtRr844GjGvWqa
 LhA7b4fFzoJwVhBN3kQtTb5XougDZfrmPxMrjIE30659+76HbGp94Db7L0WMAvZ1uNj8
 kTDg==
X-Gm-Message-State: AOAM532vMS5pTKnOo+KoySzHOnDyYlf4HIKllsRgP5cgN08p+tEDhyuz
 UDpSg+3Y9s/8NyVa6PXCW+TJ8BGhQnQ=
X-Google-Smtp-Source: ABdhPJyGeUlcREDvRkdBnE6WDVKjUL5LIUAmjg2QiKuwkm54X461iItp/l9QFKRj5jftG6OKp+v9Dg==
X-Received: by 2002:adf:e6c8:: with SMTP id y8mr55612131wrm.40.1594105759396; 
 Tue, 07 Jul 2020 00:09:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 33sm28737937wri.16.2020.07.07.00.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:09:12 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BCB221FF9C;
 Tue,  7 Jul 2020 08:08:59 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 13/41] tests/vm: allow us to take advantage of MTTCG
Date: Tue,  7 Jul 2020 08:08:30 +0100
Message-Id: <20200707070858.6622-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Robert Foley <robert.foley@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We currently limit TCG guests to -smp 1 but now we have added some
aarch64 guests we can do better when running on x86_64 hardware.
Raise the limit for TCG guests when it is safe to do so.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Message-Id: <20200701135652.1366-16-alex.bennee@linaro.org>

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 890bbc5549a6..21f46d1957d9 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -551,8 +551,15 @@ def parse_config(config, args):
 def parse_args(vmcls):
 
     def get_default_jobs():
-        if kvm_available(vmcls.arch):
-            return multiprocessing.cpu_count() // 2
+        if multiprocessing.cpu_count() > 1:
+            if kvm_available(vmcls.arch):
+                return multiprocessing.cpu_count() // 2
+            elif os.uname().machine == "x86_64" and \
+                 vmcls.arch in ["aarch64", "x86_64", "i386"]:
+                # MTTCG is available on these arches and we can allow
+                # more cores. but only up to a reasonable limit. User
+                # can always override these limits with --jobs.
+                return min(multiprocessing.cpu_count() // 2, 8)
         else:
             return 1
 
-- 
2.20.1


