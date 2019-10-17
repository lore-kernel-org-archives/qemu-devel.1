Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AEDFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:01:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B282067B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAkTgFK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B282067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50111 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL7Gs-00011T-Ex
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL6FW-0004eQ-58
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL6FV-0004Ew-4p
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:55:30 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36041)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL6FU-0004Dg-Ta
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:55:29 -0400
Received: by mail-wr1-x444.google.com with SMTP id w18so1909863wrt.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=X0Zojohlrp9hFXtLnwWUFyqJ6AI3VRmKHspf1lmW8O0=;
 b=YAkTgFK8cdQ4XRc7ABRysChOsklvrvrjaWLHy2ocyi9fUsZxjmV/S7J9VEa/AVTYXo
 k1hdzuOj5UC40sXLDJdLbpr9pybP8+1WTKrcYrhcpdT9ZBPHflDILpyL7tWuOq7ALQk8
 aQyenGGtQuqjI4I04g3Lo2nUrjfmyJYwY8kns2llX8g6T35NNTyYy1LKUrJ62PI/XKVX
 G5KceYoOkuWoF/H/Y5QQ2wkR0/91BaTqa5p77HszLxJFqatu8E3/xLCCG+05pgxzVOq2
 wE+QzL4KQrnC0XLbnetumR4Hu1SOqGYRmLiWH1UzQIxbAE5iRlHqoPe8Nhhpp6cNDOHe
 9ePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=X0Zojohlrp9hFXtLnwWUFyqJ6AI3VRmKHspf1lmW8O0=;
 b=uaE1cTyvQWR5jiFbQrtF8hebGMCoLTDjxoBC+qCVYY77TDUZ8Xq2SCYTzpL1XJ5/MF
 RnLVHaVf/jmuoZq/KkeEH6nLvfUXqzpQb6lkXF48yMWKh07Yb2UGeq9koh19DYuSkKOg
 4Ee7DvJvlMeoFWMqdHpFJSJWB8igC4L2j0XaAk8Relo5On5jwnW0CZ3XbYdlEGjkvow+
 ftLzftAYS0tYB9XI0v2cUrYyydiCxuDALKmCzMa8bjIbK/4g+sOKhzR10mYM9lqEIdRe
 CUoQiHVJp9nA5wkWdrRh97yZ0lQ7DbOddi+NtlxhxKy9466FBM6I8tVVjHOOejFgS6xO
 +Tfg==
X-Gm-Message-State: APjAAAX8ANV8XQ+0tR9jmpX2Vm+FDdlKXVw3Rlly542WwNhrAODrW6Nl
 WZtBkVcVVEFf7wmRGbbdpIkfig==
X-Google-Smtp-Source: APXvYqwcNgSP/5/Gg1Rn4SePio61klSnyFtQORMsrnSAepF3PCzPenuOpOtnuAULabuVWKs6rMi+tQ==
X-Received: by 2002:a5d:44c5:: with SMTP id z5mr3036840wrr.252.1571320523468; 
 Thu, 17 Oct 2019 06:55:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t203sm2701881wmf.42.2019.10.17.06.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:55:21 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7321E1FF8F;
 Thu, 17 Oct 2019 14:16:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 27/54] target/hppa: fetch code with translator_ld
Date: Thu, 17 Oct 2019 14:15:48 +0100
Message-Id: <20191017131615.19660-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index c1b2822f60..2f8d407a82 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4221,7 +4221,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     {
         /* Always fetch the insn, even if nullified, so that we check
            the page permissions for execute.  */
-        uint32_t insn = cpu_ldl_code(env, ctx->base.pc_next);
+        uint32_t insn = translator_ldl(env, ctx->base.pc_next);
 
         /* Set up the IA queue for the next insn.
            This will be overwritten by a branch.  */
-- 
2.20.1


