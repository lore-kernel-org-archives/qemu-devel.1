Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8BFC47095
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:27:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D6FC2064E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qacvBNVs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6FC2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCHX-0006Es-8J
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQC0o-0004Oc-Uw
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:09:54 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:41082)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQC0n-0003De-7w
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:09:54 -0400
Received: by mail-wr1-x42c.google.com with SMTP id w5so2845236wrp.8
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 09:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M8BJz88tNpwx06kkxJHIQnU1OBsb0ZN2jgNx+Hq3Dfs=;
 b=qacvBNVsL20jcXizndb0qoPPgoRdFKL65pqycifo24e6QoGMUnoqxvdA+S7LGwq6wp
 L5lJNPc6dA9+s5pZAdICKigg1FbfJxjSdB/uOZFhGXW6zuIuWr/4L8cJFfNyU3urfXrS
 a7pWHM4dMGhmpxJQv6Y3eQvqYlpaRxSw+YGzZg+3iTcb40X+AfS8QOd1dnm3TfWal5Qg
 +TN+E6qnjcG/KZwxd5QnOjHNHER4H53Hoh6GIRYUwH4y4VhBSzG/Fjm9lib3BNcMNgmV
 2vjX9JUKMs4oXtEJn0cMz4MlvQ8hFrNFJVhDNKie2zoB7fMkaYTvcLbBPotbwZ2UxJcT
 hKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M8BJz88tNpwx06kkxJHIQnU1OBsb0ZN2jgNx+Hq3Dfs=;
 b=fGjNqCd+c7XeL0VraH54+DfAYbPTjMGfhvmJIbaK4Ll9fgqGjQt1TsYAXLssyOGSjb
 4SrnkX+nND34H34Dpw35keA+VMi7YfQ6n0T07RyCGQVJKKOqUr3HxvAv8eEJsgyEap43
 aUq77Ujz8n/v+e5bZEUzrrdBvvFYMAK4dkb9oH3e2IlF/b+E1yAOgKtfofeEMMFh1Jif
 3OPoW6hoJHp5gHo+iXE7JTta9ra1vuXp+3aJeObgDOYdqtctPJMXeoxzyw8CtY+kdshf
 uUayqdnOoo/kN6Y6a3lkzKPwlaJ2qp5yHzOwT2BgYJq9tX34xjknFRw/xgaW4wofOW9S
 yj3g==
X-Gm-Message-State: AOAM531b4fZKuSWxkPNCZFta0ffEfiW3inKmXcob6fE9pW0Y4VMk8EDt
 wdjmtRw2dhg50Em0rDcmJ9asnA==
X-Google-Smtp-Source: ABdhPJx5joaxSl0BC4CoXDQhwS5kJL4AuNBrZixFkqmZBLWUXk42TepuJMKWBO8GdF2pi4hzl7gxZg==
X-Received: by 2002:a5d:6592:: with SMTP id q18mr4365106wru.293.1602086991366; 
 Wed, 07 Oct 2020 09:09:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y7sm3271494wmg.40.2020.10.07.09.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:09:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 136B61FF7E;
 Wed,  7 Oct 2020 17:00:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 21/22] cirrus: use V=1 when running tests on FreeBSD and
 macOS
Date: Wed,  7 Oct 2020 17:00:37 +0100
Message-Id: <20201007160038.26953-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007160038.26953-1-alex.bennee@linaro.org>
References: <20201007160038.26953-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
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
Message-Id: <20201007140103.711142-1-pbonzini@redhat.com>
---
 .cirrus.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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


