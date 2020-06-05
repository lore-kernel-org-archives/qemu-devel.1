Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2937EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9955206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vsZrDVTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9955206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEd9-0006Tl-6Q
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhEbG-0003dV-SE
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:49:42 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39966)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhEbF-0004L2-Uw
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:49:42 -0400
Received: by mail-wr1-x442.google.com with SMTP id h5so10258911wrc.7
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 08:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SBVEeYPoldaG/TiWA5+kJpoxCO4a8QJPKMV9RJr0Iiw=;
 b=vsZrDVTPsML+JdLwdRQe6UKs6PwFAdy9bXFGvKnat1v6RItY9uYbkpK/c7WkfOYr0Z
 OKSrsy3ZN6RR4jFiqzRG6PqMpMq4Lp5jpB59z1WRUvDGhMv+bTbkuikUC60+j9YT+Wfe
 NrEdTbbsoO+T3AYLj9hA7cBglT0p9AM2GLIrzjHPuo5cUxBkNzSnR5y6FXWfSZdLviYG
 AajPNz7QY9QPXXVrD7g4nH3RLfyJB0Jun8yAwygLlYDlH2uynhKHYDRwrhpHqEIDiPYC
 gCMZtxOGih8VKhXJ/X6DNmmdvGIZzN+IXTyHeOCv/khHV57O6dwnW0WiJdc0reVUz7HG
 TBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SBVEeYPoldaG/TiWA5+kJpoxCO4a8QJPKMV9RJr0Iiw=;
 b=BrbVnTwU2dwJSjyWRn+AZv0APB27HFDqbYqwgaHYyMm2ZT+6jGwfj0Z6h84MMuhcrf
 I8AGJpHE0dX7/Ln6k6cwo3Ze/pgbfJB2liMpI9A7TvAA3/SBzwnrNzl4qoY452yZDNfJ
 bpOZDO7AoT2y+AQZu3WBJ/ZHgeLmoDYNXfr/Xmlr4sfV9P6Ps3QPvtWIdLdejHda0nEp
 DdQdEE81xlsFfvJc+evSW+iWR9ifh5VN9QyxrAA2pXvyjujxVVE6WnIdSTMWtIf16EVc
 +DWLkrr3NGrR78nmGhX/bWvOaVfbpwIWJdvMYXMbskYFkr+hK1jDHUHYkKtDqK8MTXtA
 0uyA==
X-Gm-Message-State: AOAM532ZNTMHUje9P8Lay/m+VNB6w83kQwRWgg4yAgizXqVYHfTPloW9
 HFmhCPOx8EJ0R7FQOL8/e2NVdA==
X-Google-Smtp-Source: ABdhPJyB/HoW5PPycQWRNIFxsYs+6Wih//k2vMP1yBjcue8HqexaLHymLHcHogkQg5H9QBSy8AAg0A==
X-Received: by 2002:a5d:69ca:: with SMTP id s10mr10492564wrw.203.1591372180565; 
 Fri, 05 Jun 2020 08:49:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 40sm13226948wrc.15.2020.06.05.08.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 08:49:38 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8A3661FF91;
 Fri,  5 Jun 2020 16:49:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 05/14] .travis.yml: allow failure for unreliable hosts
Date: Fri,  5 Jun 2020 16:49:20 +0100
Message-Id: <20200605154929.26910-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605154929.26910-1-alex.bennee@linaro.org>
References: <20200605154929.26910-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

They will still run but they won't get in the way of the result.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 564be50a3c1..ec6367af1f0 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -429,6 +429,7 @@ jobs:
       env:
         - TEST_CMD="make check check-tcg V=1"
         - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS}"
+        - UNRELIABLE=true
 
     - name: "[ppc64] GCC check-tcg"
       arch: ppc64le
@@ -493,6 +494,7 @@ jobs:
       env:
         - TEST_CMD="make check check-tcg V=1"
         - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},s390x-linux-user"
+        - UNRELIABLE=true
       script:
         - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
         - BUILD_RC=0 && make -j${JOBS} || BUILD_RC=$?
@@ -535,6 +537,7 @@ jobs:
         - TEST_CMD="make check-unit"
         - CONFIG="--disable-containers --disable-tcg --enable-kvm
                   --disable-tools --host-cc=clang --cxx=clang++"
+        - UNRELIABLE=true
 
     # Release builds
     # The make-release script expect a QEMU version, so our tag must start with a 'v'.
@@ -556,3 +559,5 @@ jobs:
         - mkdir -p release-build && cd release-build
         - ../configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
         - make install
+  allow_failures:
+    - env: UNRELIABLE=true
-- 
2.20.1


