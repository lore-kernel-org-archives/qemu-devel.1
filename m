Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9046C76199
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 09:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82B82086A
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 09:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SlkNVgPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82B82086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3GRj-00028F-SP
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 04:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3GQw-0000s4-HM
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 04:41:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3GQv-00024F-F3
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 04:41:50 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41876)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3GQv-000249-9O
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 04:41:49 -0500
Received: by mail-pg1-x542.google.com with SMTP id 70so7460423pgf.8
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 01:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IdSf2yKwv5OJi0nRJR1iJoDfBBS6iWeqmjTw8o6ae1c=;
 b=SlkNVgPwrex617z7RVoeSa2r8wU3+Crqsf2bbWx2NwNTPexHbMLrwe7BWYLkli4pMN
 W4V1vWOy97O6s1MZzY+VJvRy2ySyJCwhl8Ytpw5QV5IU2dPUoN5kEAxtZKdjGFT0GHCQ
 oglK2OVQWx/8Y2Jx9wDhECpqIMTvF1brcVRWPBOuE4opPRIIoCEyAEb2nAdCM5XesO1F
 IRt9moLIw0axSHTGJqkvqTbdooNR1ZmPdKx5SQ19Nnl7/IOuXzB/k0mcj5aSTZBVO+6v
 UFhazmJPYLMn/m98h3iKS1cJu8HqYMRcKrtm/5+Nr+WZvJYroapA/SMGYXQ815vaEJ/8
 1C8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IdSf2yKwv5OJi0nRJR1iJoDfBBS6iWeqmjTw8o6ae1c=;
 b=Muyt+wus6g1wWy5dcIz4GsXBZlvj1U0HviqYbTaa9+bcoNBjbri1+6TCYr67ctk0Wl
 oDK+iuAEZBFy/pBZs26OzgVvaIt4OQN0vhLKuhErRFk7uxMzMwd6A9nKjylYjxtLEe+K
 dEgSgtnP4Wyzbc8QX72fPHtMyBhQZzZe0SHOTWrxxnOwgey1y5HNE4r80yZaTK8yf5u2
 qstThgrj+5UFdnLm8WHNqBVRFVvZsRe36NNYtWYMvzFZ6jwSR5KJp9YarJZGJQTK5Kg9
 DnMnO+DZ++UNIzGUYtzMEnRmv7wReqKwi8tELxrAKMeBywng+Q1w51xZos2HlXRMib03
 CUsA==
X-Gm-Message-State: APjAAAWx/A/tKkQT9sZuMEjS9qW0xR4jo4dQHlQpCU8ujgycno8YLva3
 3AvDlsewpRcTej9twjgWCVijtnaHmyY=
X-Google-Smtp-Source: APXvYqyHszOs6EtWlNCZXE5O3Ne68L659EiYsoItuNw3rr/WtyC9S8HBQJAfrmcdAw02qX6lOfGYbQ==
X-Received: by 2002:a63:2bc3:: with SMTP id
 r186mr12299951pgr.294.1581846108098; 
 Sun, 16 Feb 2020 01:41:48 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l15sm13023553pgi.31.2020.02.16.01.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2020 01:41:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] tcg/arm: Expand epilogue inline
Date: Sun, 16 Feb 2020 01:41:43 -0800
Message-Id: <20200216094143.14201-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200216094143.14201-1-richard.henderson@linaro.org>
References: <20200216094143.14201-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: philmd@redhat.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <rth@twiddle.net>

It is, after all, just two instructions.

Profiling on a cortex-a15, using -d nochain to increase the number
of exit_tb that are executed, shows a minor improvement of 0.5%.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/arm/tcg-target.inc.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index e1aa740ba4..6aa7757aac 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1745,7 +1745,6 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
 #endif
 }
 
-static tcg_insn_unit *tb_ret_addr;
 static void tcg_out_epilogue(TCGContext *s);
 
 static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
@@ -1756,14 +1755,8 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     switch (opc) {
     case INDEX_op_exit_tb:
-        /* Reuse the zeroing that exists for goto_ptr.  */
-        a0 = args[0];
-        if (a0 == 0) {
-            tcg_out_goto(s, COND_AL, s->code_gen_epilogue);
-        } else {
-            tcg_out_movi32(s, COND_AL, TCG_REG_R0, args[0]);
-            tcg_out_goto(s, COND_AL, tb_ret_addr);
-        }
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R0, args[0]);
+        tcg_out_epilogue(s);
         break;
     case INDEX_op_goto_tb:
         {
@@ -2309,7 +2302,6 @@ static void tcg_target_qemu_prologue(TCGContext *s)
      */
     s->code_gen_epilogue = s->code_ptr;
     tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R0, 0);
-    tb_ret_addr = s->code_ptr;
     tcg_out_epilogue(s);
 }
 
-- 
2.23.0


