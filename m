Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5E4C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:22:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69B6C20661
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x7TN+Hkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B6C20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipYhk-0005Qh-3v
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 09:22:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipYeS-00012I-4P
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipYeR-0005jq-05
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:08 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:35286)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipYeQ-0005ff-NE
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:06 -0500
Received: by mail-wr1-x433.google.com with SMTP id g17so7587712wro.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 06:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vCZ03FZMpXvXS7V1teIe+01LLQlAQMNX0fTq6xTsm/I=;
 b=x7TN+HktNU+968wNq/jBuGKEUOnRuP90Y2nhH8dey7TYn4RC4btxBopLZiZMMcO0FX
 Ws0LnammDJbxIyt2iJqIB3uioz4hj6syFgDevd7iVGtasIX1pZmdAuQwOFDuB0+TspMt
 T4AlHx1biEUuACBHegiacTtA+crhBFP1sbIstQ1v/sir4d3ol6VibSJ56tqT2xGPLTzV
 wyB6vgHZQT+LanrFk4EecrNfKGmhNAXoDZ/7G0Pg8B99Dlxz+cxvRYwWEiV+xMCf7Zd/
 vjzBx8WR2Lpj6B/ULEhK0/qWs1loKLFyY95yG00fM7mO9Jv016eICKp3Bs8cX5gTV5PX
 Sm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vCZ03FZMpXvXS7V1teIe+01LLQlAQMNX0fTq6xTsm/I=;
 b=EzCEniiTktfzd9hos3HzaJTu0ywAJpzB2YVGtd1NhW2zts9isaG10EIR+FcM+UGl9t
 p3eIIJi+uxPqKo6zjfmdzc7GkG2KDykityw7LSq3jFLnoOfMcgGnc2Eaid5yJ/b1lWZL
 CJMDMkb26LKfqPTmlzlmTLT+vi7Y04QGN38fkMCHkArGWrK1i8lssdOS0+O2UvO9gyZy
 tB2OpI+rKRRbKy3NTt4mwlbMvTUZfPEm7JGux6gSBeHDhbJVk8ijUqVeSKnLZ+bMgcs6
 Uv5JRIYWzMhfVyxknuP1hlbFu5Ae+cQelnwKtXiJ2BDvcizPiUtarFDFIeOcgfbJga89
 8H9A==
X-Gm-Message-State: APjAAAXe5wGe0LXguTksv77o3wg5RwJvi9x82inUDrZqDX16Szu5Wk+o
 XhlsMiuB8234R3ssTZc/rhf8og==
X-Google-Smtp-Source: APXvYqwnMgQPBCoYIZeuflF5r4aNM4x1Pud2np5pNJIwLd8C0j4od+v+vaQ4KUFPmpCPOJipFzyaQA==
X-Received: by 2002:adf:f581:: with SMTP id f1mr11667475wro.264.1578579545686; 
 Thu, 09 Jan 2020 06:19:05 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 18sm2928300wmf.1.2020.01.09.06.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 06:18:59 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4C9FD1FF91;
 Thu,  9 Jan 2020 14:18:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 04/14] travis.yml: avocado: Print logs of non-pass tests only
Date: Thu,  9 Jan 2020 14:18:48 +0000
Message-Id: <20200109141858.14376-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200109141858.14376-1-alex.bennee@linaro.org>
References: <20200109141858.14376-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wainer dos Santos Moschetta <wainersm@redhat.com>

The acceptance tests build on Travis is configured to print
the entire Avocado's job log in case any test fail. Usually one is
interested on failed tests only though. So this change the Travis
configuration in order to show the log of tests which status is
different from 'PASS' and 'SKIP' only. Note that 'CANCEL'-ed tests
will have the log printed too because it can help to debug some
condition on CI environment which is not being fulfilled.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20191230184327.2800-2-wainersm@redhat.com>

diff --git a/.travis.yml b/.travis.yml
index 638fba4799a..93838bf0f8b 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -262,8 +262,8 @@ matrix:
     - env:
         - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
         - TEST_CMD="make check-acceptance"
-      after_failure:
-        - cat tests/results/latest/job.log
+      after_script:
+        - python3 -c 'import json; r = json.load(open("tests/results/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"] not in ("PASS", "SKIP")]' | xargs cat
       addons:
         apt:
           packages:
-- 
2.20.1


