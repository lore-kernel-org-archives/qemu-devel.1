Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEECDC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:45:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 782B5208E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PoXG7lu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782B5208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cA2-0005zi-32
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bvC-00088l-JM
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bv9-0006dj-Bd
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:30 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:35471)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5bv7-0006WO-JQ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:26 -0400
Received: by mail-wr1-x431.google.com with SMTP id g7so204759wrx.2
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XbPV2t+F7ljq0HCAxTum9zmKwOphxxVJo57tiv6WLRU=;
 b=PoXG7lu5Oz9qsutsTGqexR+n94adVB9Cvp2O5KYtgi9bmhrzCAqC1h2z3fg3ZZgaRR
 9qKc8FGYOCaSF1YxfOrlWKdh88cGQl6Cp0Zt35evBgWNU94XyN2b/PgJ++j8JrVEYeqe
 whXdP8BabODG7g8EliCsevvB5+uRBjsCeRU1l4lRsD/R8GizVGfzVUS7T3sHvIKOByJY
 g+IzvC7sXNfLvrLsfcv2sWxyY4gVzszT1DXnWYCYYiNgDaxxwHt6NCnEvS08cmx6/wDt
 fw53oOzZFQb5++car1NBAtTqDjBIzT0RpEvRQZi5ymsRIV1192Oz9pTi9csrUr6sAzgz
 psHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XbPV2t+F7ljq0HCAxTum9zmKwOphxxVJo57tiv6WLRU=;
 b=ZPf/HaWcOxw0parWYXNas2QKM2UmjuJMXfVVXxIKWuoZ3csn0vmhCyVU3BnVT9bo3S
 7RRKIG78PctfL4SgUxvGeJNycxj9iIRCfIz967dzHGuvNanCnlcwDhCTuTnts4ruCbpp
 QyhrHEipl6rzaMTkxqUs0p4XOxWnYkVE5gNNAZn5ODp0pdZLoJxwCZLiYFE1NidoZ3Yc
 zGjLoknIVSou4AJTulwclSbyIB8hZNM1+u3aVkCQaLVOV/uvF9ZSfBH1fdmbnIQxqI3N
 GoEnotj8uB020iZpEw8v5veCrdkiXfVYGCRe3YD3676APMW+fYXj3dOu/aLFos8q/U4J
 9qgQ==
X-Gm-Message-State: APjAAAW/FhJ/7EGBB7IOEZPrunDVKAhPX64iUtyusWkXPioz9k7Bdpm8
 7E4S/HIEZ/wtXBajsgbcOAnL5w==
X-Google-Smtp-Source: APXvYqwf7JmH0Jhs3SOglng5XJEjXvXdOgb9UD+oUX3yn8ujuIQRy2oY39OEI39nWf0/qBRj9WpyjA==
X-Received: by 2002:a05:6000:49:: with SMTP id k9mr2235236wrx.21.1567629020700; 
 Wed, 04 Sep 2019 13:30:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d18sm31755088wra.91.2019.09.04.13.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:30:18 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 361241FF98;
 Wed,  4 Sep 2019 21:30:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:29:39 +0100
Message-Id: <20190904203013.9028-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: [Qemu-devel] [PATCH v1 08/42] tests/docker: move DEF_TARGET_LIST
 setting to common.rc
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We might as well not repeat ourselves. At the same time allow it to be
overridden which we will use later from docker targets.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/docker/common.rc  | 4 ++++
 tests/docker/test-build | 1 -
 tests/docker/test-mingw | 1 -
 tests/docker/test-quick | 1 -
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 4011561587a..512202b0a19 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -11,6 +11,10 @@
 # or (at your option) any later version. See the COPYING file in
 # the top-level directory.
 
+# This might be set by ENV of a docker container... it is always
+# overriden by TARGET_LIST if the user sets it.
+DEF_TARGET_LIST=${DEF_TARGET_LIST:-"x86_64-softmmu,aarch64-softmmu"}
+
 requires()
 {
     for c in $@; do
diff --git a/tests/docker/test-build b/tests/docker/test-build
index 22766cfacc0..2b2a7832f15 100755
--- a/tests/docker/test-build
+++ b/tests/docker/test-build
@@ -15,7 +15,6 @@
 
 cd "$BUILD_DIR"
 
-DEF_TARGET_LIST="x86_64-softmmu,aarch64-softmmu"
 TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
 build_qemu
 install_qemu
diff --git a/tests/docker/test-mingw b/tests/docker/test-mingw
index fdb1c2c879d..c30eb654eb7 100755
--- a/tests/docker/test-mingw
+++ b/tests/docker/test-mingw
@@ -16,7 +16,6 @@
 requires mingw dtc
 
 cd "$BUILD_DIR"
-DEF_TARGET_LIST="x86_64-softmmu,aarch64-softmmu"
 
 for prefix in x86_64-w64-mingw32- i686-w64-mingw32-; do
     TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
diff --git a/tests/docker/test-quick b/tests/docker/test-quick
index eee59c55fba..feee44b2476 100755
--- a/tests/docker/test-quick
+++ b/tests/docker/test-quick
@@ -15,7 +15,6 @@
 
 cd "$BUILD_DIR"
 
-DEF_TARGET_LIST="x86_64-softmmu,aarch64-softmmu"
 TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
 build_qemu
 check_qemu
-- 
2.20.1


