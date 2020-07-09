Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D5CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:22:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4046D206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gZAdFkz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4046D206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtXRT-0005ey-F8
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 10:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtXJ6-0000X4-4V
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:13:48 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtXJ4-0001Lw-BD
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:13:47 -0400
Received: by mail-wm1-x342.google.com with SMTP id 22so1989935wmg.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 07:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D9RzuX/3jxkQtQdTH0rTmm3wMB62+kPBSn4Xf4Inji8=;
 b=gZAdFkz7gRtleAGVUtsnPlJAPrRIuvAGIW3mF3xRHMEZ6lpCwAu5KKkqOawxGgjumC
 yZQsBebJ8tCQuGLUpNSbZAM6FAL2YQ59hxUvf255zCFSwIK7BIxAouLIWx8gQsd/4Qd5
 vyg3WN7lmuWPYqbkQgITLDpTuostWwVNpZ0S+lPDq93j0GnlbOSwAtTY5Wv3bMC01DPB
 LX1bLFQ9egXfkA4C6bhQbYiLsWZHXB8L4qMX7YeHJ6RRC1MKxTp3m0d0UvFqv/vGb2xa
 CNJ07x7EvRiiH14T+2xhOh+wTCkFwcgrK8LCHIiIIl9gagloDG0w0pFD4NVpDZJmlQ9m
 80qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D9RzuX/3jxkQtQdTH0rTmm3wMB62+kPBSn4Xf4Inji8=;
 b=FXCw2snWQSPglyImYM/DSU0KfpwbWMJjrB8yL58lbr0qPFrimIJCx2QUXV7RflWmkb
 GQdhwxvkK+GhQxsMn0LdP7aqX9HFhO8mnb6xlp8F6UAN+6Y030wW9xEyL0qNJRnBy5IW
 BiAamGpOpnzY4hLDDMT+/YAx7xRdjtKRHxqyI5BOkBaqJKEgsCqrDx2my6cs0EtfSxdd
 uDOU9TYWDtMdMdIO7zn2MA7MFj79nky1CISNOe5xQkVYDMeMvLflg0rwIBrIQkHTYaAY
 9ZnimYKQAjv773pYDijLvWxLWTgMiGLamXeXEY38ozyz495PgoBbuzqE7QcJd0MneGvf
 L/4w==
X-Gm-Message-State: AOAM531eUii4xuw+ysA4/ALUvk0LLXRNjt4NQa0vu4K0kdsYNk61MyOS
 w0nFU4iEruwI3yXr9MbjYJz1Zw==
X-Google-Smtp-Source: ABdhPJzLY9yGGHDOfv/Vyv4KiaL1g5I1Oda6K54Mkn1jaVQT2uuTtCvtcoBGTW08lD05ydMZ8BMAkg==
X-Received: by 2002:a1c:2392:: with SMTP id j140mr259414wmj.6.1594304024625;
 Thu, 09 Jul 2020 07:13:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j16sm5710714wrt.7.2020.07.09.07.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 07:13:34 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 867251FF9B;
 Thu,  9 Jul 2020 15:13:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 12/13] tests/docker: update toolchain set in
 debian-xtensa-cross
Date: Thu,  9 Jul 2020 15:13:26 +0100
Message-Id: <20200709141327.14631-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200709141327.14631-1-alex.bennee@linaro.org>
References: <20200709141327.14631-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, aaron@os.amperecomputing.com,
 cota@braap.org, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Filippov <jcmvbkbc@gmail.com>

Switch to the prebuilt xtensa toolchains release 2020.07.
Drop csp toolchain as the csp core is not a part of QEMU.
Add de233_fpu and dsp3400 toolchains to enable DFPU and FPU2000 tests.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200708082347.27318-1-jcmvbkbc@gmail.com>
---
 tests/docker/dockerfiles/debian-xtensa-cross.docker | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
index beb73f46baa6..ba4148299c5a 100644
--- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
+++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
@@ -18,12 +18,12 @@ RUN apt-get update && \
         git \
         python3-minimal
 
-ENV CPU_LIST csp dc232b dc233c
-ENV TOOLCHAIN_RELEASE 2018.02
+ENV CPU_LIST dc232b dc233c de233_fpu dsp3400
+ENV TOOLCHAIN_RELEASE 2020.07
 
 RUN for cpu in $CPU_LIST; do \
         curl -#SL http://github.com/foss-xtensa/toolchain/releases/download/$TOOLCHAIN_RELEASE/x86_64-$TOOLCHAIN_RELEASE-xtensa-$cpu-elf.tar.gz \
         | tar -xzC /opt; \
     done
 
-ENV PATH $PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-csp-elf/bin
+ENV PATH $PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-de233_fpu-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dsp3400-elf/bin
-- 
2.20.1


