Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D01CC43457
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:52:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 993DF22248
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fvDoTtuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993DF22248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvcr-00028c-K8
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvRA-00033e-Pn
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:40:08 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:38912)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvR9-0006H4-2E
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:40:08 -0400
Received: by mail-wm1-x330.google.com with SMTP id d3so10453647wma.4
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gHr5Clb8CT0UT8wg/mAAv1w3wI0wvP0zCeIH//ggdSo=;
 b=fvDoTtuLfkYNklLMvzJF3rZ6Kx8jqnuNC7m/KB9OGNjyFKoUfqkRCBUF6N2xfq0FdO
 79hQW0jl7F790c9AWeL1vUMz7wYtrw6OGK6Xk029ZZqNhR07U0V4qWJbT5tO5U6BMQIR
 rujZvsDD+sBZIk51x3oQ3Eg2/OpFVbil85jheGhKnZkSgQ4sAkVwFkDNhZtJ+tCHDoTy
 ZZolLRMf4l/DjxUt7b/7IqHvkEQ65ueaAREV1qiul8Au7Lc9/dUiBkWrjiFgCdIDyaMf
 sQLJRMr/bY3mtqrp0WufgW5LqKItSPFlpVp1QPLGtXwKodMBGVgEXtm757RefGs9yW2C
 Yiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gHr5Clb8CT0UT8wg/mAAv1w3wI0wvP0zCeIH//ggdSo=;
 b=s+fZti7BF8LON7LJgx3pAoJGf06nB+WRTS140zykpoZniH3VgDk49ZVlm304NHg6Lr
 EbeEBAcRTdPt6i5mlFUZD8+AWGf2tnSMYmeJt531Nv4IwIGOiY3dbKYfUSVdSW33AU01
 /zI4ALG8VMWlTO1ITlxZOrkohicnCnXsOj3Lc8op0fNgZzAe+B/6Rwspm9Kq7LRNbngj
 Klip/UlJF7z7vQRwfrYQmedCXFQyAY+hFzYLAnkbXea5PuKULz0Sh03T3K0f+9dC2PyU
 hKOCdzYfKBupW+hhTzRZe7UFtbZ0kmAcONk9ISQt+PYg0yfIpMm0HDnrAqAdGzzysz2j
 aazw==
X-Gm-Message-State: AOAM533wzvDLoBtp3jN+yeudzUZ97hwk2NBbaBNIrmb7OVtG4k3omK2a
 F+3YDzJR7ZqZkpxBFWrtwLnNTA==
X-Google-Smtp-Source: ABdhPJzx0Z0XZJi+AkIzOnOt08A19QbPbHdsEC93n1VLb8mOcZzoLJSvuXEL50X063ZMGP9/2+CJYQ==
X-Received: by 2002:a1c:7c09:: with SMTP id x9mr15640352wmc.181.1602261605576; 
 Fri, 09 Oct 2020 09:40:05 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 13sm11934156wmk.20.2020.10.09.09.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 09:40:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F0FFA1FFAB;
 Fri,  9 Oct 2020 17:31:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 21/22] cirrus: use V=1 when running tests on FreeBSD and macOS
Date: Fri,  9 Oct 2020 17:31:46 +0100
Message-Id: <20201009163147.28512-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201009163147.28512-1-alex.bennee@linaro.org>
References: <20201009163147.28512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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
Cc: Ed Maste <emaste@freebsd.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Using "V=1" makes it easier to identify hanging tests, especially
since they are run with -j1.  It is already used on Windows builds,
do the same for FreeBSD and macOS.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Ed Maste <emaste@FreeBSD.org>
Message-Id: <20201007140103.711142-1-pbonzini@redhat.com>
Message-Id: <20201007160038.26953-22-alex.bennee@linaro.org>

diff --git a/.cirrus.yml b/.cirrus.yml
index 301a64f104..99d118239c 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -15,7 +15,7 @@ freebsd_12_task:
     - cd build
     - ../configure --enable-werror || { cat config.log; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
-    - gmake -j$(sysctl -n hw.ncpu) check
+    - gmake -j$(sysctl -n hw.ncpu) check V=1
 
 macos_task:
   osx_instance:
@@ -29,7 +29,7 @@ macos_task:
                    --extra-cflags='-Wno-error=deprecated-declarations'
                    || { cat config.log; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
-    - gmake check
+    - gmake check V=1
 
 macos_xcode_task:
   osx_instance:
@@ -43,7 +43,7 @@ macos_xcode_task:
     - ../configure --extra-cflags='-Wno-error=deprecated-declarations'
                    --enable-werror --cc=clang || { cat config.log; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
-    - gmake check
+    - gmake check V=1
 
 windows_msys2_task:
   timeout_in: 90m
-- 
2.20.1


