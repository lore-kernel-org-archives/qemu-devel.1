Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9815C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DEA520673
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v0ORVjcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DEA520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHVmV-00031o-1U
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 12:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHVXZ-00047e-9L
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:07:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHVXX-0007l7-Rb
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:07:16 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:35283)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHVXX-0007kq-Fp
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:07:15 -0400
Received: by mail-wm1-x32d.google.com with SMTP id y21so92105wmi.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 09:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0P+yCHvg6Zq0/M0VZGGhX2NWbAulJ6mBTNGWb6Tu3QM=;
 b=v0ORVjcHaIczIYNipaLwDIDfeuMb9Im9Rkwnklxf8ofGebRRLmxrWpt2NiKuErm1G5
 BibpUOAerS3dPqTiU7ZdT7sMWjNXaEbETD9Jmd3NskOOu9xJFBsGixFCN0Fkz7tU0JYl
 owkkOJvZSGMsmrvyPva/njmnxdg0LTIzYDoDzkg3PZ6e2iaZM+aLE1wUjN5ho+LAqjDG
 OW69ajnWYvvPEOPEzmoGe7szl9JXdwma3r/mWH033xQsVzxIUMCyHRMddpV9VUXGybfV
 +XMI6xl0w/5xT/64/Pw8bCFYdvpAzkseXLMsr8X6li/TQjsnp825uXhO0XeeW3ybO7is
 +gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0P+yCHvg6Zq0/M0VZGGhX2NWbAulJ6mBTNGWb6Tu3QM=;
 b=hAGl9YHf5jU70/Mw/fj73fra40yY2ADSSDpX9XAA41uFpUjjAGvw6klQWPfu/Z02Pj
 4SfGV11OFFj9yThsSPkO4kMgAFBS6GgzyAvqW+HV2Q5zWcrE0NHLYDuUqBvoGSwEzyE4
 teE5yw2l6c27Wfb6YfbR7IGRMXIayZHkwpTFi1jRDv/apcps3sd3gggLLeUutKkCSJUc
 ayc2Df7IQ4Yl5wWVmVImsN43Fla5OnDGfaC+H1Rcz5MyhWqZfmEud+JEI399Tc3NWjQo
 Yibs4O0ixzZQoaAkSmm83rmoNCfP2aeZ8FBTZvtcrzcl5gbNkpnJtG5KuGn3gmknD6Tp
 gWoA==
X-Gm-Message-State: APjAAAV11LVnnwKJ+vUW3Tig4o1y77+HAtPfERj0FieKwcuh50WpQg66
 gXvWH2pnEO8BNUDThAGMPqb94g==
X-Google-Smtp-Source: APXvYqwANr/3WnYKNPm0VfCc77KdPgu/3nKw0WK4MRb63hoVGwenHnfSjXEn656fmB4k/28xU95tkw==
X-Received: by 2002:a7b:c112:: with SMTP id w18mr52102wmi.88.1570464433220;
 Mon, 07 Oct 2019 09:07:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e15sm18928955wrt.94.2019.10.07.09.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 09:07:12 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B68381FF87;
 Mon,  7 Oct 2019 17:07:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] .travis.yml: reduce scope of the --enable-debug build
Date: Mon,  7 Oct 2019 17:07:08 +0100
Message-Id: <20191007160708.26208-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adding debug makes things run a bit slower so lets not hammer all the
targets.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index d0b9e099b9..fc0888aff5 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -124,12 +124,13 @@ matrix:
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
 
+    # --enable-debug implies --enable-debug-tcg, also runs quite a bit slower
     - env:
-        - CONFIG="--enable-debug --enable-debug-tcg --disable-user"
+        - CONFIG="--enable-debug --enable-debug-tcg --target-list=${MAIN_SOFTMMU_TARGETS}"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug"
 
 
-    # TCG debug can be run just on it's own and is mostly agnostic to user/softmmu distinctions
+    # TCG debug can be run just on its own and is mostly agnostic to user/softmmu distinctions
     - env:
         - CONFIG="--enable-debug-tcg --disable-system"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug"
-- 
2.20.1


