Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EC3CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:03:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46DF021929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eaVEqL4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46DF021929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtdc-0000Wi-En
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36907)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtMr-0007l9-D9
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtMp-00037q-NI
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:36 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:37501)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtMp-00037C-GT
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:35 -0400
Received: by mail-wr1-x430.google.com with SMTP id e11so947858wrv.4
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a+CNlZHOsvnPAzo+1k2Dke9GSSUrs8d4XRw46Zp2gXU=;
 b=eaVEqL4dgXXp0wqHt21xpcwDfEqgH6Wc8jxwn2b1RM2bQ9mGZakHuwEJaiK3lkeBBd
 ljJ9epTY7OvH/NDMmP/hDld0Yt2ZNr9pkRVKP1K47BFn273Kpqa5EyJKWG7Vz4E8aAXh
 Wci5e1Ng8M0EKVP6BcddPxpGGq+PUACrZ/V15Y6VVfzg/hc0T5z0NvWL6ZPWhMvNJGyd
 mqKrYNDaoCyWgCevr2w3rjOmq48mUhdth50v5myfoLKZxLdL/mRRLG8gD7HqiJowwgHR
 9BMoIe6Dj/2tBfbYgPuhmqDr47QO5xIh5+NJ5ZRbrGXZLPEePBatswaX/ndEP2QXID/3
 EaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a+CNlZHOsvnPAzo+1k2Dke9GSSUrs8d4XRw46Zp2gXU=;
 b=OLSQcZbllcGn9b8yHhWZiD1kRZqV0sOx5/gV4rbdjtWV7EkMVNQb/7O3seG/XVRadz
 OMVig/BFxScCZ3EPH6GuP7gK+g3uBbwnKKo73hSLwVk1B+EO8E0pMaGfohKDk+oqp9xv
 /kRByZPBeOHmGLI3JvlrVOcBA49gyN99Lm4vZCmKtKfWhyKHRYMrG37Q14hVmq5Jyj57
 z/DuLFe8UsjM+FLS8eadK9CU/ONLIfU6L8z0yisUzsiSTGpJIEPn+87k3gj5bpp6WWsm
 DgN4m0eP08XScFSP4aQVbBenxRvmT8a5ce94Lefjkz3Rxfx1tbfk8yY2fwYfUT8K8b4M
 WFjw==
X-Gm-Message-State: APjAAAWRLO6SUMpXwhc+RnbJWhj9Khp9gYTuQeM/805BEs7jLANxgdXh
 5GUvBNcrwbvstfcwnuMCyPorEQ==
X-Google-Smtp-Source: APXvYqzBG7c07ZV5j8HYAHOV9Ri93wKmGvqiEEIvvArV67DO8x1EPK4NWD3NfytRaz6A2ksqhRQreA==
X-Received: by 2002:a5d:498e:: with SMTP id r14mr1279313wrq.36.1571985993857; 
 Thu, 24 Oct 2019 23:46:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w8sm1779491wrr.44.2019.10.24.23.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:46:33 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 918D11FFAA;
 Fri, 25 Oct 2019 07:37:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 20/73] translate-all: use cpu_in_exclusive_work_context() in
 tb_flush
Date: Fri, 25 Oct 2019 07:36:20 +0100
Message-Id: <20191025063713.23374-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

tb_flush will be called by the plugin module from a safe
work environment. Prepare for that.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 66d4bc4341a..0a08fcda3e8 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1268,8 +1268,13 @@ void tb_flush(CPUState *cpu)
 {
     if (tcg_enabled()) {
         unsigned tb_flush_count = atomic_mb_read(&tb_ctx.tb_flush_count);
-        async_safe_run_on_cpu(cpu, do_tb_flush,
-                              RUN_ON_CPU_HOST_INT(tb_flush_count));
+
+        if (cpu_in_exclusive_context(cpu)) {
+            do_tb_flush(cpu, RUN_ON_CPU_HOST_INT(tb_flush_count));
+        } else {
+            async_safe_run_on_cpu(cpu, do_tb_flush,
+                                  RUN_ON_CPU_HOST_INT(tb_flush_count));
+        }
     }
 }
 
-- 
2.20.1


