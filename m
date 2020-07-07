Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EDFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:18:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AA8E206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eIcbOXwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA8E206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshrs-00052v-7I
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoE-0006Yu-EY
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:30 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:40246)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoC-0004qZ-Mo
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:30 -0400
Received: by mail-wm1-x32b.google.com with SMTP id f139so45346276wmf.5
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0Du9+TDok3/8t4BiL1lqGOO2m2hHyL++J15tcPz/gDI=;
 b=eIcbOXwJFxzs4KDjejfWky8SJqCIhYrm8YWjqtSH6Td/fYGRBYErOJrPZAQDc875SF
 DZlZXjfYAX6z3LfpSrZ7f869T5vFUSVFdD+vTAizykmqO02KIfGVb9q+N842pw/1+Nj8
 DsE2yozOeFS9JjX53dZvy1I0nLnG+9HOGgMxWsrFEaqJhvMRUar+AihtKoVjrgRRkG4j
 k59ByDfC6nXz4Xdu/WF2rzTaBsmKSGrkpe5f2eHVkJNzkML8GN/fQcjW14YPjN0285OJ
 todiyxB/kSgwYSIUSo7G9DGuXZ1KAvQ3zVOGSU864EtemWB0usJUe1l2CZLpw7HqGiwZ
 67Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0Du9+TDok3/8t4BiL1lqGOO2m2hHyL++J15tcPz/gDI=;
 b=OVi1e8IQPKLXHgMVk7T7sK4uu1W8Cv5zYn/F78sSLhwzQMYcxBc0lUIGhzwkVHcI8U
 3FStUWhhUvLvJYGkCbRfFPb5hcYr8/DW2f3xo3Z3p8I0mbDsTUvHGOALTHOTHJpasHqi
 Dfq6LbmiSeFBzBBuNUpwZp64zz0VMr4qlTCr1jUuiM383q7oX9svu7nDqjLVefmXGZm2
 7BoU0AzRCQu/2JmWSYwAFD4xRhhugZa/YnnVDVqQFty8oJu8/00KJtOJsVoBcMkzAN9/
 CPVcKM3TqskExHzuF4mnSS5y8cxi2eKhEE9e4tanKqTJeXQOrVuo356mfErRaZbjaihP
 YqgQ==
X-Gm-Message-State: AOAM532Kfm304UNhELQDB65h15GXbZGXqB6ot/FqO26DpSWE7rj3qdD6
 /NaaRJY07La35wnFbgcxGYOH4g==
X-Google-Smtp-Source: ABdhPJxi84PU07FYwFBGm783rJzKofVfrmzXPKgWhrSP3UO8OJjTEepxr5lL9Rj9cs16g/5IfpNPyg==
X-Received: by 2002:a05:600c:2209:: with SMTP id
 z9mr2613163wml.178.1594106066199; 
 Tue, 07 Jul 2020 00:14:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w7sm2283183wmc.32.2020.07.07.00.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:14:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 595E81FFC0;
 Tue,  7 Jul 2020 08:09:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 39/41] travis.yml: Test also the other targets on s390x
Date: Tue,  7 Jul 2020 08:08:56 +0100
Message-Id: <20200707070858.6622-40-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

s390x is our only big endian host in our CI, so building and testing QEMU
there is quite valuable. Thus let's also test the other targets with
additional jobs (also using different sets of pre-installed libraries to
get a better coverage of the things that we test).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200608114049.4693-1-thuth@redhat.com>

diff --git a/.travis.yml b/.travis.yml
index c24dfbe377f3..ab429500fc3c 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -482,6 +482,45 @@ jobs:
               $(exit $BUILD_RC);
           fi
 
+    - name: "[s390x] GCC (other-softmmu)"
+      arch: s390x
+      dist: bionic
+      addons:
+        apt_packages:
+          - libaio-dev
+          - libattr1-dev
+          - libcap-ng-dev
+          - libgnutls28-dev
+          - libiscsi-dev
+          - liblttng-ust-dev
+          - liblzo2-dev
+          - libncurses-dev
+          - libnfs-dev
+          - libnss3-dev
+          - libpixman-1-dev
+          - libsdl2-dev
+          - libsdl2-image-dev
+          - libseccomp-dev
+          - libsnappy-dev
+          - libzstd-dev
+          - nettle-dev
+          - xfslibs-dev
+          # Tests dependencies
+          - genisoimage
+      env:
+        - CONFIG="--disable-containers --audio-drv-list=sdl --disable-user
+                  --target-list-exclude=${MAIN_SOFTMMU_TARGETS}"
+
+    - name: "[s390x] GCC (user)"
+      arch: s390x
+      dist: bionic
+      addons:
+        apt_packages:
+          - libgcrypt20-dev
+          - libgnutls28-dev
+      env:
+        - CONFIG="--disable-containers --disable-system"
+
     - name: "[s390x] Clang (disable-tcg)"
       arch: s390x
       dist: bionic
-- 
2.20.1


