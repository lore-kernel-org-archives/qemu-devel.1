Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4631EC00454
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13099206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="szfytI2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13099206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if5gj-0005aH-PL
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 12:22:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1if5Qk-0005Gm-Lu
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:05:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1if5Qi-0003Sj-3r
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:05:42 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39582)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1if5Qh-0003RZ-LJ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:05:39 -0500
Received: by mail-wr1-x442.google.com with SMTP id y11so24840718wrt.6
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 09:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j13MxIT63cJVQtqoXk9rT91dRsa42qzR98g1LmrKW3s=;
 b=szfytI2xfhQGFPkJUKKT1ZNdYFU3Cua+yEo1hEn1l8LkAr+LLIl8Tlm42ZbpQ45J2T
 56GCiJRFgnrscbDRgrNiSnklYL50gXT9Akq0CFZ9BnHZxyexl0Bjy7OdF6uts4LBc8au
 zuK9Z7IQtZwCEkK4IFj//cOtSQIVob9rRQQMxCV5zc6V6kg34SuQPVLpG+byqseUnK4x
 IlyN8pSsnu7aeQ/E4YHQcZrRjqjYS7a+4yK4Zn3MmVrvElCvnFB1x599Z5phmTRcyjcY
 uYr5WMq5jpsdtzaLt1focgexq+zfL0LtEeEaLCWg8a3w1SI/Ts9UtY0DbaqJhT0dw2SO
 Etvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j13MxIT63cJVQtqoXk9rT91dRsa42qzR98g1LmrKW3s=;
 b=I7ylJ5f1vY0Ly7uShuvO58oIYl1YUWgfPkb2yiMlgb8/iEMtjJXfJhNX4n/LNYTg2X
 3XFsaxKz1Z7Kb5XVEW67KScBpDdLNboL1WR0e4tfAhZu8NAwyzHmodMA0FQQgVDPWpKd
 fqMml5Rh5MuMFXxEQ2Vz7E7DPmh69MAYsOOjwaWXee8EpoldKs1eR3FY2dIyh/3Zm4qE
 ViI8k320cbsdkubrMIT2qkDTFBKaBAl3sZJEecIbMbHlGsr+zGLUmNnY1U/1xlJD0zRo
 B9Twp8frPdp37CZSpfobkJSUH5sjP2uBtzo/isUA5wJ/q0+phtIcFH31DFoOLWWjLzLv
 rKCQ==
X-Gm-Message-State: APjAAAUJW4VitKNGLaKbm8SRJDtc5lMVf+eHUEeHkxSSma1nSoCmrKO2
 i+iwAewM9X9FK53ZWTNW4P8rFA==
X-Google-Smtp-Source: APXvYqz0A4F0FkpenO+ygX8MAVVZHY3wSV31tKKsTNo43mv5urPQlCvNebxWXJZer/IXZkFKb+KjQQ==
X-Received: by 2002:adf:b591:: with SMTP id c17mr881914wre.108.1576083938527; 
 Wed, 11 Dec 2019 09:05:38 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l17sm2853519wme.45.2019.12.11.09.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 09:05:30 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E587F1FF9C;
 Wed, 11 Dec 2019 17:05:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/20] tests/tcg: add a configure compiler check for
 ARMv8.1 and SVE
Date: Wed, 11 Dec 2019 17:05:13 +0000
Message-Id: <20191211170520.7747-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211170520.7747-1-alex.bennee@linaro.org>
References: <20191211170520.7747-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: damien.hedde@greensocs.com, luis.machado@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will need this for some tests later. The docker images already
support it by default.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/configure.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index 6c4a471aeae..79140db6684 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -214,6 +214,20 @@ for target in $target_list; do
       echo "CROSS_CC_GUEST_STATIC=y" >> $config_target_mak
     fi
     echo "CROSS_CC_GUEST=$target_compiler" >> $config_target_mak
+
+    # Test for compiler features for optional tests. We only do this
+    # for cross compilers because ensuring the docker containers based
+    # compilers is a requirememt for adding a new test that needs a
+    # compiler feature.
+    case $target in
+        aarch64-*)
+            if do_compiler "$target_compiler" $target_compiler_cflags \
+               -march=armv8.1-a+sve -o $TMPE $TMPC; then
+                echo "CROSS_CC_HAS_SVE=y" >> $config_target_mak
+            fi
+        ;;
+    esac
+
     enabled_cross_compilers="$enabled_cross_compilers $target_compiler"
     got_cross_cc=yes
     break
-- 
2.20.1


