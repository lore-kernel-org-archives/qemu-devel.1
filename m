Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B25CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E2621906
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aA8bhEtj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E2621906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbcs-0006IR-SZ
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaGY-0002AN-Gf
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaGW-00045m-BC
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33705)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNaGW-00045D-4o
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:48 -0400
Received: by mail-wr1-x444.google.com with SMTP id s1so16670546wro.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 03:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=To1y6osBAB74ZdPanXvzGu0hmS7AhXWKsdyOl06cDGM=;
 b=aA8bhEtjrDcmWFgVQMq5HMDOBRpV3DEJO/pOlvSX0VFp/Lnqs4Bx1u06x2BVEG37fD
 0Zw4fORCBtun7I8V8gPSkGEPVAAIvtxxzo/nO0UpNFygjo2gXVZhva3/9etLW9krG+QY
 LaicMqeVTscNDfMx2/+m0xr3+vu12Woawbeg6XCY4XLUF27iBIO1tTxrY6fI9E8dkPw+
 n7hpjj47fjcIIpt454qoRII/EaoarNTgC7UlZXy65rmBCJDCywwABab+lwdece9h7v2p
 161pw59/p5NOTZrOeHshJtkn+lDUdr3P925Tmct7ralWBGb+Kq1mY6BU2rBvGSvZ2yAT
 AvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=To1y6osBAB74ZdPanXvzGu0hmS7AhXWKsdyOl06cDGM=;
 b=eQVifnE803FNslmMkF3CW7+P42FldqfL7odXmOHJIdnsNe1SVN2PYMgSrFEaYxh0Lk
 7uOGJ0FUlG8akthqgZCmUYZFeJ/xJGe7qgmRiD9lSV8pQiKUkFYBQQ+1j+nzppYabE5m
 Y5viUDfWTmHxGCAQQDAKXf8oKbOiT+cfEkXW9byS8KcMOtkrdJKMTtW04hj8X6ypZHjt
 5zn1zDpNk97s0kW7b13tfbpX+8t8LoXChTCD7KecFu+fR3LHFa/bhUBh8aC3BIevNbiQ
 WznbQMpT7QDtQ473kDIHEX8ZDSzwpytlJTEl1u4EwUVtm2KwFsHD4ZBXfEAp8lBRGkfw
 QlJQ==
X-Gm-Message-State: APjAAAWWsZjHBFZqX3fxCVOT7roIGpGY8cdMXyMBQeTLw/8b9k+YWdXJ
 2jm5GpIkMa08dn4q3Xk4f6qyGQ==
X-Google-Smtp-Source: APXvYqxmKQJUDWH+zc/G20e+c0TqsBQuHUjh3LwNLX2r0+qaym7ptlW9wqtjnEXK/x9jmGUJykpscw==
X-Received: by 2002:adf:f192:: with SMTP id h18mr3331237wro.148.1571912567017; 
 Thu, 24 Oct 2019 03:22:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q6sm4845037wrx.30.2019.10.24.03.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 03:22:45 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D5EAE1FF93;
 Thu, 24 Oct 2019 11:22:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 06/17] travis.yml: Test the release tarball
Date: Thu, 24 Oct 2019 11:22:29 +0100
Message-Id: <20191024102240.2778-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024102240.2778-1-alex.bennee@linaro.org>
References: <20191024102240.2778-1-alex.bennee@linaro.org>
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


