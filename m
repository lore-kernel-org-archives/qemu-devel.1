Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137B9C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:26:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDA7C20872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vfmlnHjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA7C20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cPo-0002TN-Pr
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7c0a-0004b9-GO
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:00:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7c0Z-0004pO-5h
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:00:20 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:41475)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7c0Y-0004oi-W1
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:00:19 -0400
Received: by mail-wr1-x42b.google.com with SMTP id h7so17457978wrw.8
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 02:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w4GW8O3X3F3KkRkiz9wz/TX8TfH1LO9RjHL0INlIqjs=;
 b=vfmlnHjE649K/P0jJHtY0/ri3vPVyO7swcvNatznW8G9KdIkriZCDHF9ogVGoIRxAM
 ZMAjUC7GozgfgNAqUVu1ZSgr4mcgrC8VteF5E9xCl3Mj+sXYF2sE/heNTanNHURLrW8x
 2b4p7P8+8e+0FsyiQd3zKY9t2g8IR1pOFacXjls0vAcBUSmCbXCui2v0tmzGFgcyRDw9
 p/RltCZ+eZR3OJ6zp3DvOhoCHB7fpddJ53YdCnp/J93vPJfIm7wjLhD9xBjyR5/zzEY9
 CbKF/NQh06NUzj44/eARJ1eJnE5O+WUu+4ijk2PQIZWhnA0CRzI9TxDNpumqPMnBtdI0
 +AfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w4GW8O3X3F3KkRkiz9wz/TX8TfH1LO9RjHL0INlIqjs=;
 b=riw7XSVG4lf778y8kgc0yekpzE2q4pYJaRbpVACFB0HCC3bpbRIrxoY4tSH8IS2fDb
 vahSSH+wKqEKqPbm14eHk7yaddyukqS0pH8Wrl04aKhFxtPAD7N/IxfBrRkKZ/aVOiQ7
 dFnOUcFtUaSCf+oYS0SzDO4e/5Xi5yyt5e+QjhghIdorU7cw1Gpmp9lnnrpNXwg2U9Gy
 LDydtfXUwX2ZstQyRTAcevl7+Cc1ddRhuMSQqPSI3lM22rm8gO8nqdLVw4KWmtTLR9yI
 n7Kdjd4OCewBeHEWhtlKb7PKoKmSCxjkgG4pj07V2k0WC3NxPwHv7vfXJEWXR2WvoDGq
 +saQ==
X-Gm-Message-State: APjAAAXXtVyVEwXKjCa/TSTX55nxc3PYktdihsbFA8Tl90ma4EFfjl4+
 CiiseBAPxvymmH4LGn0+jfiD9g==
X-Google-Smtp-Source: APXvYqx/DM5YajX763bkew1umA6Y+7197nyVLpFgdoZdhfgwjCL2eOO1xlPm4U3gci98s9WJRhkkLQ==
X-Received: by 2002:a05:6000:a:: with SMTP id
 h10mr2971441wrx.226.1568106017896; 
 Tue, 10 Sep 2019 02:00:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 189sm2677059wmz.19.2019.09.10.02.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 02:00:14 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2E0FE1FFBE;
 Tue, 10 Sep 2019 09:43:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:43 +0100
Message-Id: <20190910084349.28817-40-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
Subject: [Qemu-devel] [PULL 39/45] .travis.yml: Enable ccache on OSX
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

By default, ccache is not installed on macOS environments.

See https://docs.travis-ci.com/user/caching/#ccache-on-macos

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 7d6c63a2803..3d1c7f0d7e0 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -45,6 +45,7 @@ addons:
       - gcovr
   homebrew:
     packages:
+      - ccache
       - glib
       - pixman
       - gnu-sed
@@ -80,6 +81,7 @@ git:
 
 
 before_script:
+  - if [ "$TRAVIS_OS_NAME" == "osx" ] ; then export PATH="/usr/local/opt/ccache/libexec:$PATH" ; fi
   - command -v ccache && ccache --zero-stats
   - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
   - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
-- 
2.20.1


