Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303C8C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:05:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E18B720A8B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wh+Xx2FT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18B720A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlBGw-0004jc-4O
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 09:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlBDj-0008Dj-VA
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:01:44 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:34588)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlBDe-0001cW-Cy
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:01:43 -0400
Received: by mail-wm1-x32c.google.com with SMTP id u26so2227377wmn.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 06:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RbNElvIGkjlXKRGPXZgBVVIssKrGvTSw+jbb+dSxtd8=;
 b=wh+Xx2FTQv/Ndc3ibp1IaOIQSeojGsciSxJa8uvAQR3b+Im0UdSFYceFXUXufljQnp
 p99KO2Rgr/JiMwoCCsHrWKa4oxTpbkANIc/s32W1ZmiabDgtRBxzwUOssUoaVoky6l9T
 WmcqOJ18xjMOrs/8xjjjT70DA8KCxUiFS/hQvg1qwBoESJaFn4e1EHYIeiXJCqB7rK6Z
 lWoxCI4GpA4CtkkiY0KhpaNnmUXBC21fLzO1nGqSJbYAxE6R5yN9eESCu6cXMIkBkrQW
 r3Tv+mteK/ByNWLD96593m+4SV+5gB4ztdYZfEDhoOKVpTBVqL01Tj0xI4n/BsGk9z9w
 JNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RbNElvIGkjlXKRGPXZgBVVIssKrGvTSw+jbb+dSxtd8=;
 b=Dh+v+E5Obyye94t2GJ6gZhfxR/NMSR164WyGRPqLSBDcJMbWgCCQIO5A4xyqAtFcI6
 q2aHdQ8HR9297Qs8AjOwEmd7nE4WICxBSnlDJlzqAiAYU0/mKMf3cookNFpfN+HaaCq3
 IajedoHyuRnYbYYp7Dl5q+uAmrdOfjjuQlZZocD09ImBwkQZuYlm4YDOiyNfzZm7aZ/T
 4Bkq1YXZ2LYaHldx2E8h6m2tk4hq7BxMew9acqjSOOLUjiG+ydQd2ZjidU1qKjpiWwHj
 MlX4oSl3S5OD6XrrPmvJg/qnInII9oNltTtfsNJT7NVWIYB3kXZ/49vW19KR5lxHHdKf
 B46w==
X-Gm-Message-State: AOAM531/DYyUPuH5zW5qlZfVYgFVlDMic13WRZj7aFV0fd+hcQ6KTw6H
 VX8DjCtbyE+jS9a/gMstZSNHjQ==
X-Google-Smtp-Source: ABdhPJz0Ij32DlYGd/URguH07tF6c/5GuDkHQbtmTKX/6RBt3IB4S0brGopnoIlox3rD0I0OepOF0Q==
X-Received: by 2002:a7b:cb56:: with SMTP id v22mr3217325wmj.180.1592312496060; 
 Tue, 16 Jun 2020 06:01:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c68sm3907750wmd.12.2020.06.16.06.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 06:01:34 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2F49B1FFA9;
 Tue, 16 Jun 2020 13:53:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 20/21] tests/tcg: ensure -cpu max also used for plugin run
Date: Tue, 16 Jun 2020 13:53:23 +0100
Message-Id: <20200616125324.19045-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616125324.19045-1-alex.bennee@linaro.org>
References: <20200616125324.19045-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The check-tcg plugins build was failing because some special case
tests that needed -cpu max failed because the plugin variant hadn't
carried across the QEMU_OPTS tweak.

Guests which globally set QEMU_OPTS=-cpu FOO where unaffected.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200615141922.18829-3-alex.bennee@linaro.org>

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 6d60a2f2eed..b617f2ac7e0 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -20,8 +20,9 @@ run-fcvt: fcvt
 # Pauth Tests
 ifneq ($(DOCKER_IMAGE)$(CROSS_CC_HAS_ARMV8_3),)
 AARCH64_TESTS += pauth-1 pauth-2 pauth-4
-run-pauth-%: QEMU_OPTS += -cpu max
 pauth-%: CFLAGS += -march=armv8.3-a
+run-pauth-%: QEMU_OPTS += -cpu max
+run-plugin-pauth-%: QEMU_OPTS += -cpu max
 endif
 
 # Semihosting smoke test for linux-user
diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index 53efec06683..1a6463a7dc1 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -12,6 +12,7 @@ X86_64_TESTS:=$(filter test-i386-ssse3, $(ALL_X86_TESTS))
 
 test-i386-pcmpistri: CFLAGS += -msse4.2
 run-test-i386-pcmpistri: QEMU_OPTS += -cpu max
+run-plugin-test-i386-pcmpistri-%: QEMU_OPTS += -cpu max
 
 #
 # hello-i386 is a barebones app
-- 
2.20.1


