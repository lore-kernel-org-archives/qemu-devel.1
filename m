Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D629CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DEE72067B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W65GZhjn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DEE72067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg9Dg-0004FT-Sh
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 11:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jg97g-0003m9-IY
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:46:40 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jg97e-0007dh-Uc
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:46:40 -0400
Received: by mail-wr1-x444.google.com with SMTP id x14so3922887wrp.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 08:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D7IUd/fMXoOGoaV/5qSVVzKkzaDzbDEGnaTAgX8XWeQ=;
 b=W65GZhjnZ98xwCzBbH0fHzuuUkAIA01tNSHq/Alu6fN+EyyuvKkcLCdAt+278dEtDe
 0+k/ch+rEK6wYrP0EAWYowzRCfgz1/keWSt1+beEc+/SqG4jC4+vqSqH7024pgM6872R
 z4pXloEmu4sKFxCiNrcugWNfF0At/sO4LANKLsRpvBVNpNHUnqK14pM14eCTRnJ6f8x1
 VkVVQKjBnizmQEKccSUJyVw3rtHAQS9IxL22OBiAD52Yr/ZGf0Ho94Cp+Fe28XmZPBIR
 ayU5x7AJAdoZf/k/UqImCpYsxFkHMXumgpW2807LQ6FM6DzlPI3TF951XFsB6n7enTSZ
 W0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D7IUd/fMXoOGoaV/5qSVVzKkzaDzbDEGnaTAgX8XWeQ=;
 b=BDBT/ZiwpUc6f4FevCcD2alw+Xk1XdleceFhbzAQVPnEj+wA04gRpV9JTPF3nNSo6t
 Vxca52OKQV4xsqo6aeEPyCyV5QgOOhJWfZQ3hCvn2XNxTe7mQRQPlierMiAWYkjgq5tc
 XBcXhs00fMrUpwLEabg5SD71nbMzw/KPsNCWVKPA5uMf+Jd7J+qy+Wui+nuXaEe5upS9
 F5ALB1bCqTUX0NVaJPQhRbgO6Ca3uJRrQ5pME8M2BkNiQwHHzWOaE4IgFFDOf2dcQblk
 skz5nEwHTAvfj2fGFuqQ8BDSC+kG3Id9w2GwLhJ3IHxyI/nfhKhr/nxkLaLZQ0kyj3WU
 hZGQ==
X-Gm-Message-State: AOAM531Tcr+/UbbjIZSpzcgEBHMywItjcYHrKHt0TGwribt8kgUVXBmi
 BzGbXbBoIX8JxUwTmjBvy+7EbA==
X-Google-Smtp-Source: ABdhPJwXTKriSjywj7DPAmySKxgQ5vcoi4Iv/lES/7bRkQ6tS7IQsvgbHA3J5VqLG1z9zsVZvgioBg==
X-Received: by 2002:adf:fdcd:: with SMTP id i13mr25544969wrs.190.1591112797582; 
 Tue, 02 Jun 2020 08:46:37 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 37sm4682599wrk.61.2020.06.02.08.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 08:46:32 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 10D451FF98;
 Tue,  2 Jun 2020 16:46:25 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 9/9] .travis.yml: allow failure for unreliable hosts
Date: Tue,  2 Jun 2020 16:46:24 +0100
Message-Id: <20200602154624.4460-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200602154624.4460-1-alex.bennee@linaro.org>
References: <20200602154624.4460-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: Fam Zheng <fam@euphon.net>, robert.foley@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 robhenry@microsoft.com, aaron@os.amperecomputing.com, cota@braap.org,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

They will still run but they won't get in the way of the result.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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


