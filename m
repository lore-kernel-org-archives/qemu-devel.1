Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BBCC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:43:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE980206E3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e+XIJuFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE980206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOJTh-0004RU-SS
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 07:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJN5-0006oA-97
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:37:10 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:38349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJMw-0007bo-Tc
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:37:05 -0400
Received: by mail-wr1-x42f.google.com with SMTP id g4so1450662wrs.5
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 04:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9XYcghb9sPJN20tF//vvqdPEa8XcJlWcmFIQZkg5CNk=;
 b=e+XIJuFzO7HYKqOrVIBNrn7BA7JZdRjUCZOdnvZ5ybfOR3XGYyLbFySqDnF/iReaZy
 bKNb5Tv8MwB5Hvcb7wZx9fpABVa3onszeclvdiA6OIVbOP/9bYddSWttqitxdYOIrNU/
 cqhwzcI7bh83RijWETnZ0iWgjW6VFJOZSAuKkvxN9q5Ub8zUEoUCWK4DWEZ36EEQyDDC
 YY1TKHs4JImXX4liAjU8ZWjKGFpeA3TIYrhcUX6FOfuC7KxJFUggLtYZsWrByrvnpYD/
 kA7saAmgfCiM2O38TAEOXPRR/dHgXzLfU0gP8JI+6m8yFyNS6+cOLGbpyVn1rHCqKcgr
 JM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9XYcghb9sPJN20tF//vvqdPEa8XcJlWcmFIQZkg5CNk=;
 b=n7IZIw+3OiAKKpAzuiqhHn4VB9OBuID7OyZFeggZxuseD+qZQq1uGdjO7KczAiVY2N
 iMe2D6pgB7QsfYMvK935k4V9w656cOVzR9OgbBu7TpplYMs42k7YNYxrwXMeaMzboArG
 MzFrbtKZMDfREVJ0RaNTgNVfZx4d4oTkngO+g5TT728yZYf7Ry4tSQRL4so6n/F8SlS5
 x8RO1uUWv76wJdQCXOeKCwkL8ZZQxg38K6yx2KCbJvdLCCk7vCALPtQV+Rn6om89Mibi
 Aq/s0AAE1KgfjO2hlgzdaeWvsjwkjkdsXC7SKAOex4nWjlOpBgG0FdI0SMsODxzZN5jp
 soaw==
X-Gm-Message-State: AOAM532BMH7jrNWIfMOGaOhXUSWei3fha8t/g2ZF6bXg9+ohlVHNS07G
 J/WuNfLxTDBp/oRIMCS8i7d0XQ==
X-Google-Smtp-Source: ABdhPJzIluFM9wcsfkyRV2r8Jv0DGCHn9vTyMQxV4G6yFLZuXwgAwuor9MxxGLrXYxHNsBNj1ouFhw==
X-Received: by 2002:a5d:5404:: with SMTP id g4mr2459003wrv.134.1601638611573; 
 Fri, 02 Oct 2020 04:36:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u66sm1504837wme.12.2020.10.02.04.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 04:36:46 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1E7091FF8C;
 Fri,  2 Oct 2020 12:36:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 02/14] travis.yml: Drop the default softmmu builds
Date: Fri,  2 Oct 2020 12:36:33 +0100
Message-Id: <20201002113645.17693-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201002113645.17693-1-alex.bennee@linaro.org>
References: <20201002113645.17693-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The total runtime of all Travis jobs is very long and we are testing
all softmmu targets in the gitlab-CI already - so we can speed up the
Travis testing a little bit by not testing the softmmu targets here
anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200918103430.297167-5-thuth@redhat.com>
Message-Id: <20200925154027.12672-6-alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index bd9a6fc06c..b2d492f8c6 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -123,20 +123,6 @@ jobs:
         - CONFIG="--disable-system --static"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
-
-    # we split the system builds as it takes a while to build them all
-    - name: "GCC (main-softmmu)"
-      env:
-        - CONFIG="--disable-user --target-list=${MAIN_SOFTMMU_TARGETS}"
-        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
-
-
-    - name: "GCC (other-softmmu)"
-      env:
-       - CONFIG="--disable-user --target-list-exclude=${MAIN_SOFTMMU_TARGETS}"
-        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
-
-
     # Just build tools and run minimal unit and softfloat checks
     - name: "GCC check-unit and check-softfloat"
       env:
-- 
2.20.1


