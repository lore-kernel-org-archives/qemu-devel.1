Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E62C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:44:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B47A5208C4
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="loVYDKjB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47A5208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw73p-0004RY-2t
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 11:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50852)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hw71q-0000hf-Au
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hw71n-0008VP-QQ
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:42:06 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38649)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hw71n-0008SG-I2
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:42:03 -0400
Received: by mail-pg1-x542.google.com with SMTP id z14so8816700pga.5
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 08:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=x8MCVdcm8N9Wdyzx80ABjmXcKcOIg3c8JF8kLGEmqDw=;
 b=loVYDKjBaQT2QJuvWNv441HJ4opYXwOlNGJtXF7TcgVjOtY/Q5TxH1B3gcaIIE10s8
 4m/5mFet2d2doJgS+C7NHkl71dKMhvcKFXA9Cr53VFJN+bVv4Vo27vSxAGBbL9PRYb9R
 9F6ljy04E0bDeWuXq1sfdNfwEMZLm9tyB7Ex4sQOJhsOvB7M4VSNPYK+djHYFg7VojU0
 MtuBefnWTW4Co+HtG0+4tUDiJto32DH8EbT6YlEY56i3H8I9otXAc6YMStZIMkGMzd0b
 G0IIyIQ1nPIUoYGART9l/srPZAUjoKTxhODqXrdGJIPuaE7XzdtI5niKqJo4YbJAeSUR
 uRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=x8MCVdcm8N9Wdyzx80ABjmXcKcOIg3c8JF8kLGEmqDw=;
 b=YsItIPIlEI5yTWCQhLRX9wnob0v9uvvcObTxw/46DQKrEtr/8Bb+15jGA5imCcUH/W
 Sb5LAaxhpZzVXWFXdmslwqxg4K8KuYXqB4gbAlA2kwjaTFVVHjWjqy3a+42x5AerXZyK
 usJYi0lD1D0XBC2vvcbgRVDtJOMlSfv536oc77HnMGFKWWnffuKBfRdEtEluyd4gaOzv
 cSWsqsGdM2h4gLPiYcljqpGGkM8xGPqJY0dngfuCpWmMvMjH92GHGhwpsm7F2PJ8c8Oi
 eZFfWYyyYXbLAG9ATIltFcnQ0/9eN6H0EdFwdTD/jPOR963jY1EU9gYUSw5nesWh6EVs
 GYKA==
X-Gm-Message-State: APjAAAVfoy7rGcYByXzzhrW1igWa3OVz7G6PKe/mw5QqtU9BKLswtAGI
 c+3bwoTUp309ne7OUOdfl9/ArzCxel0=
X-Google-Smtp-Source: APXvYqzJVhYqToS78pzH02Vs71Z/uZx52a0m66lcCtV4A+/Z27nVRPbT6MRCBpVpPAQrEkMFlyM2xA==
X-Received: by 2002:a17:90a:360b:: with SMTP id
 s11mr9919689pjb.51.1565365320410; 
 Fri, 09 Aug 2019 08:42:00 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 67sm80452179pfd.177.2019.08.09.08.41.58
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 08:41:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 08:41:53 -0700
Message-Id: <20190809154153.31763-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190809154153.31763-1-richard.henderson@linaro.org>
References: <20190809154153.31763-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH 3/3] target/riscv: Remove redundant declaration
 pragmas
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
Cc: peter.maydell@linaro.org, Alistair.Francis@wdc.com, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These are now generated by decodetree itself.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/translate.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 8d6ab73258..adeddb85f6 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -708,26 +708,9 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
 #include "insn_trans/trans_rvd.inc.c"
 #include "insn_trans/trans_privileged.inc.c"
 
-/*
- * Auto-generated decoder.
- * Note that the 16-bit decoder reuses some of the trans_* functions
- * initially declared by the 32-bit decoder, which results in duplicate
- * declaration warnings.  Suppress them.
- */
-#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
-# pragma GCC diagnostic push
-# pragma GCC diagnostic ignored "-Wredundant-decls"
-# ifdef __clang__
-#  pragma GCC diagnostic ignored "-Wtypedef-redefinition"
-# endif
-#endif
-
+/* Include the auto-generated decoder for 16 bit insn */
 #include "decode_insn16.inc.c"
 
-#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
-# pragma GCC diagnostic pop
-#endif
-
 static void decode_opc(DisasContext *ctx)
 {
     /* check for compressed insn */
-- 
2.17.1


