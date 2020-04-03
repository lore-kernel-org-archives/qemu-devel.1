Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28691C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 19:13:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E48412076E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 19:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K5NNnLA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48412076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60131 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKRl3-0005DG-Ux
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 15:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRjT-0003GB-5y
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRjS-000284-59
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:11:59 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39787)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jKRjR-00022w-UO
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:11:58 -0400
Received: by mail-wm1-x342.google.com with SMTP id e9so8904410wme.4
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 12:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9yYReGEoMkqsfZWblGMzvHlMGSzTNisl1Y211B1bnEY=;
 b=K5NNnLA8kQ8cHlQxExClBCwKnhdlLhBVE/KiPCZLBWC7OV0Ye9YRL4HMB0BNPgkHOk
 AB+OFaWl6BtYt9R7R9o/ykTr7SU8tykYfVrwo1NebcRsrl3UTeXItTsWo2LlRB6suiR2
 8N2hy/ICndn/3hLTMMSkXrm/SeFnMbDWYlotLSrl3V0ccOxbLqJPp6Tlc05gw9i+ijW3
 s1aq//oJ1IDWdfjjBftYFlf1bFVA8ixQyRtsdX+wz0o5ZjuAOq/08C5umO15A+UAifec
 sgADKKoDVtbe6y5XqGlopGhguRyYP62/6Ho6mFIND5iylHj4Kp7Y0YGj4XtmGPT4JqtM
 1bww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9yYReGEoMkqsfZWblGMzvHlMGSzTNisl1Y211B1bnEY=;
 b=UuNB7ar7mlv64jOdhjiiY5t0e75LdK6zx4mezRve+ng/ZIfWWxIsHtS7YclEZpt+WF
 XGa0x5se2i56wEq/o6wIN3rtMnvWub6J9cAVarIw3h55jK9sGf99LpnkASX+qKGWDMAI
 xrsBTYVygMNQW7FAG8KVuRYlp0kZzy644BYH4aW/L0qHlTiG4DGG/0bSnPrfBYg2unyD
 CFpA9M/apLPEP3YDAi4c2gdV39/fJt5z1tCqfwTfiVo/NK+uJmsZBfGDP99YcQwmtVWr
 pvjgcAcQNCiXGWGoNa/SJsjshFW9AC72jGTgf6iIzcDtJzaOuGrjHQ7cg6aCRxjWTHSJ
 116Q==
X-Gm-Message-State: AGi0PuYo1EPKV2kysy3nOjB+hY2NInkOwq0GDnsc61FhBLIiSEdkPI+B
 h3W/EFOk8EtboWAPZb+lnv0ZKA==
X-Google-Smtp-Source: APiQypKbM8zHCiBvPk7890MlBrTiuB25FciqWLJe8Xw/gZUPyllw8r+X1ESdySjGpOHYtzHc0OOzhw==
X-Received: by 2002:a7b:c2a1:: with SMTP id c1mr9774878wmk.138.1585941115898; 
 Fri, 03 Apr 2020 12:11:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w15sm2587012wra.25.2020.04.03.12.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 12:11:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C29BC1FF8C;
 Fri,  3 Apr 2020 20:11:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 02/12] linux-user: protect fcntl64 with an #ifdef
Date: Fri,  3 Apr 2020 20:11:40 +0100
Message-Id: <20200403191150.863-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200403191150.863-1-alex.bennee@linaro.org>
References: <20200403191150.863-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Checking TARGET_ABI_BITS is sketchy - we should check for the presence
of the define to be sure. Also clean up the white space while we are
there.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5af55fca781..b679bc6b136 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11331,11 +11331,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
            This is a hint, so ignoring and returning success is ok.  */
         return 0;
 #endif
-#if TARGET_ABI_BITS == 32
+#ifdef TARGET_NR_fcntl64
     case TARGET_NR_fcntl64:
     {
-	int cmd;
-	struct flock64 fl;
+        int cmd;
+        struct flock64 fl;
         from_flock64_fn *copyfrom = copy_from_user_flock64;
         to_flock64_fn *copyto = copy_to_user_flock64;
 
@@ -11346,7 +11346,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
 #endif
 
-	cmd = target_to_host_fcntl_cmd(arg2);
+        cmd = target_to_host_fcntl_cmd(arg2);
         if (cmd == -TARGET_EINVAL) {
             return cmd;
         }
-- 
2.20.1


