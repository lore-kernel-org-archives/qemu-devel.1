Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E908DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:22:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B447C2184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FSB1IPeU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B447C2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMzjZ-0008AD-6p
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 15:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iMzef-0002Qc-JA
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iMzee-0005LI-9a
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:17 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45625)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iMzee-0005Fu-1j
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:16 -0400
Received: by mail-wr1-x444.google.com with SMTP id q13so14346553wrs.12
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 12:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=To1y6osBAB74ZdPanXvzGu0hmS7AhXWKsdyOl06cDGM=;
 b=FSB1IPeUqSMD7J1d3ONhrFn6KsuiP9WaIlBlDw+mn/MhvafRRcoblRV8MWfZi41Lei
 Oi7EfC1gdrzOc2FskvLhKqOOpmOSxXTKkmHWQnE/fPT+GCfzlAAyJZ6ubrQp40NAdJrT
 Kcm8ph+ZpjqH9cq8ofBWf8NQIeKdRC1cjq9PZXkbE5qzG3PUeDt7U1pLHLis4hs6CL/P
 JxCtoWgNAZWwbjk39FYbl15FJ/lpIKZB6P/VpJ3fGFTFlGvdKEeYywL85EKm9ieGwT1w
 gmWINCDuSfYnndZQbeKJ1lcab7QLLxuPjNsdBIugPBATzVA23NQEDPRqBlsx2H87y+2y
 PG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=To1y6osBAB74ZdPanXvzGu0hmS7AhXWKsdyOl06cDGM=;
 b=by+D2qBWMiIU3IIcOUbbu9AFZ2b4jC1ThwOBKWwFn3ypbsfL0yy0SSdJ5kYBQVkh+3
 /36X1qA8Wj8GLRAvKYxNKPzwX7Ce6x7FZm+JLYIBdApIj2KKeKh37r4SkMHdZOcti7Tt
 BHwwpt3L50x7UGGoVM5u8OyQQ+loccBMknqTwXyFBngUFFzsieZSRSmGMwRJL9DwXNz6
 3WR5K+3LFVev1VzcIvBUoFXidBBR82uIt4MNQFW0IRekd/3SJkOzUh+52qq7reEXtav/
 uWA/R1XM4NiOL6BjmdkWNAlc0TjkuuBwps3FeT1LsAsv89DCRPAYJJBvNs7wHZbwQiRX
 AyOg==
X-Gm-Message-State: APjAAAV/T7xYrAck/4dqhYQpeQlmtRbGX9lSsZXsQUcTWUYgbuGgzfw1
 TPp8yqlhNa5lENHPH4Ds9J0W2w==
X-Google-Smtp-Source: APXvYqyl9LUxlCkcxfLVHgYohj8o2VIR03OAYcCWp4f+2IdGk79jUpf0t6XPlgeUW70BrcFjKaVfvg==
X-Received: by 2002:a5d:62c5:: with SMTP id o5mr986972wrv.388.1571771830970;
 Tue, 22 Oct 2019 12:17:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j19sm35467507wre.0.2019.10.22.12.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 12:17:08 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BD6341FF93;
 Tue, 22 Oct 2019 20:17:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 06/19] travis.yml: Test the release tarball
Date: Tue, 22 Oct 2019 20:16:51 +0100
Message-Id: <20191022191704.6134-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022191704.6134-1-alex.bennee@linaro.org>
References: <20191022191704.6134-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Add a job to generate the release tarball and build/install few
QEMU targets from it.

Ideally we should build the 'efi' target from the 'roms' directory,
but it is too time consuming.

This job is only triggered when a tag starting with 'v' is pushed,
which is the case with release candidate tags.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191007160450.3619-1-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 7e0d4ad2b31..f2b679fe701 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -343,3 +343,26 @@ matrix:
         - CONFIG="--target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
         - TEST_CMD="make -j3 check-tcg V=1"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
+
+
+    # Release builds
+    # The make-release script expect a QEMU version, so our tag must start with a 'v'.
+    # This is the case when release candidate tags are created.
+    - if: tag IS present AND tag =~ /^v\d+\.\d+(\.\d+)?(-\S*)?$/
+      env:
+        # We want to build from the release tarball
+        - BUILD_DIR="release/build/dir" SRC_DIR="../../.."
+        - BASE_CONFIG="--prefix=$PWD/dist"
+        - CONFIG="--target-list=x86_64-softmmu,aarch64-softmmu,armeb-linux-user,ppc-linux-user"
+        - TEST_CMD="make install -j3"
+        - QEMU_VERSION="${TRAVIS_TAG:1}"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
+      before_script:
+        - command -v ccache && ccache --zero-stats
+        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
+      script:
+        - make -C ${SRC_DIR} qemu-${QEMU_VERSION}.tar.bz2
+        - ls -l ${SRC_DIR}/qemu-${QEMU_VERSION}.tar.bz2
+        - tar -xf ${SRC_DIR}/qemu-${QEMU_VERSION}.tar.bz2 && cd qemu-${QEMU_VERSION}
+        - ./configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
+        - make install
-- 
2.20.1


