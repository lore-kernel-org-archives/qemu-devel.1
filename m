Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C80C3F2CF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 07:55:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E17E2467B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 07:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d0s+ej69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E17E2467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7aUS-0007V0-GD
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 02:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j7aTq-0006xh-TE
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 02:54:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j7aTp-0004f6-IT
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 02:54:42 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:50405)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j7aTp-0004eh-Bv
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 02:54:41 -0500
Received: by mail-wm1-x331.google.com with SMTP id a5so2175620wmb.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 23:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D/37ZLET/1jFXo3Uwd+h+EYFN2kJmfE6XMxTBWo9EAc=;
 b=d0s+ej69DN65O3+vZSCBgP7bkOeh934Bj5a0VSd/zNJ32P14vE9JF6I5Tp0I25vfQh
 6TbYI2axcRjTkDaAsm71PQ/bsd15wFb2jWvyiXShB0T9fIDSZVOwOYoptW+I87Ar3wH0
 Cy5e6a5qMLAR6yKZCvOQDrUudGgrkc2ZASZCI+0XFjxviJS0UnaxXpnkvq4FD2PyJ1Gm
 WhmX4n9+Qtid1+S3tN+GHX1+9RH17oRWTqDVNsWbRaQsZkMCr9vis1PkOJaNL7YLNQMC
 9QGB8tVZzkz1WtZjU4idOIyQCQ3gfAbNGOSwcBGcWhzOoALCZpIPI9uiK2/RjBigdm+S
 LT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D/37ZLET/1jFXo3Uwd+h+EYFN2kJmfE6XMxTBWo9EAc=;
 b=n7/iU4mAce08T3GE9Bw0W9Mg+k+CPU+2+J9E2XxpM0271DwGsZqqux0EmFDoMF7et4
 ucR75F8vYE6dg/j/9faYinIddkJUAYAl8OAGQt6gEV4MlqiOU28SHnynAEkE2Yc1f0Zu
 zZZPVinD+jx+mdXs4/xuwwAExBbxhH6XH9PEM0UCABL8/ORSNrqo7NEW6LNEdTP+XiWP
 OWwb+thN9MaX3xMejpnXR1ZAkdLl502r+9C99XGYxMGfE/DCh0JJElKN7UHGgue7jJeS
 GlvZQpgyediCH2/L858KEErMbgt4f56jzsZ9KvaRYgSG5f2RsaA9nmfleUTh19Hiz7vR
 yxwQ==
X-Gm-Message-State: APjAAAW9EPqoMXaFet5IH5JegyfOvzacGStxIjTHE3MtmVvDwhK2GW3W
 B+2cnMt0LKzTwN0n5PMUNzhRhQ==
X-Google-Smtp-Source: APXvYqx7nImTpMTZFX2Dq1ZKLEKrS7Q8V0zDVOAVqlhfEHwBXqg149LSU27FIJTBsxO6wnYbjGez4Q==
X-Received: by 2002:a7b:cb93:: with SMTP id m19mr3628052wmi.133.1582876479407; 
 Thu, 27 Feb 2020 23:54:39 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k7sm11446527wrq.12.2020.02.27.23.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2020 23:54:38 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 509EB1FF87;
 Fri, 28 Feb 2020 07:54:37 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] accel/tcg: increase default code gen buffer size for 64 bit
Date: Fri, 28 Feb 2020 07:54:30 +0000
Message-Id: <20200228075430.17832-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <56f5e355-9357-e212-e92b-9db1d8424dea@linaro.org>
References: <56f5e355-9357-e212-e92b-9db1d8424dea@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: richard.henderson@linaro.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While 32mb is certainly usable a full system boot ends up flushing the
codegen buffer nearly 100 times. Increase the default on 64 bit hosts
to take advantage of all that spare memory. After this change I can
boot my tests system without any TB flushes.

As we usually run more CONFIG_USER binaries at a time in typical usage
we aren't quite as profligate for user-mode code generation usage. We
also bring the static code gen defies to the same place to keep all
the reasoning in the comments together.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>

---
v3
  - 2gb->1gb for system emulation
  - split user and system emulation buffer sizes
---
 accel/tcg/translate-all.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 4ce5d1b3931..78914154bfc 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -892,15 +892,6 @@ static void page_lock_pair(PageDesc **ret_p1, tb_page_addr_t phys1,
     }
 }
 
-#if defined(CONFIG_USER_ONLY) && TCG_TARGET_REG_BITS == 32
-/*
- * For user mode on smaller 32 bit systems we may run into trouble
- * allocating big chunks of data in the right place. On these systems
- * we utilise a static code generation buffer directly in the binary.
- */
-#define USE_STATIC_CODE_GEN_BUFFER
-#endif
-
 /* Minimum size of the code gen buffer.  This number is randomly chosen,
    but not so small that we can't have a fair number of TB's live.  */
 #define MIN_CODE_GEN_BUFFER_SIZE     (1 * MiB)
@@ -929,7 +920,33 @@ static void page_lock_pair(PageDesc **ret_p1, tb_page_addr_t phys1,
 # define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
 #endif
 
+#if TCG_TARGET_REG_BITS == 32
 #define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32 * MiB)
+#ifdef CONFIG_USER_ONLY
+/*
+ * For user mode on smaller 32 bit systems we may run into trouble
+ * allocating big chunks of data in the right place. On these systems
+ * we utilise a static code generation buffer directly in the binary.
+ */
+#define USE_STATIC_CODE_GEN_BUFFER
+#endif
+#else /* TCG_TARGET_REG_BITS == 64 */
+#ifdef CONFIG_USER_ONLY
+/*
+ * As user-mode emulation typically means running multiple instances
+ * of the translator don't go too nuts with our default code gen
+ * buffer lest we make things too hard for the OS.
+ */
+#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (128 * MiB)
+#else
+/*
+ * We expect most system emulation to run one or two guests per host.
+ * Users running large scale system emulation may want to tweak their
+ * runtime setup via the tb-size control on the command line.
+ */
+#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (1 * GiB)
+#endif
+#endif
 
 #define DEFAULT_CODE_GEN_BUFFER_SIZE \
   (DEFAULT_CODE_GEN_BUFFER_SIZE_1 < MAX_CODE_GEN_BUFFER_SIZE \
-- 
2.20.1


