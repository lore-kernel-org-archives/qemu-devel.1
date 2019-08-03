Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE82C433FF
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 21:09:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA5121726
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 21:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cwcnxi5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA5121726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hu1Gw-0002cG-Ja
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 17:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51917)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hu1GC-0000xW-9Y
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 17:08:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hu1G6-0005Mk-5H
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 17:08:12 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45611)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hu1G5-0005Ly-J7
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 17:08:10 -0400
Received: by mail-pf1-x443.google.com with SMTP id r1so37694468pfq.12
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 14:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+x0WGSWw36fXqg8sJBr/e/px4PQ5p89CEe43iMHBL7I=;
 b=Cwcnxi5Ll9OoC5PykIu9TfQLHldwMsAvoEc5GYdHrv0oEpkGdUvSWDZOHssZzXVhSA
 ZwhC9Gh7AdPJde9++OK0GnIhE3yzaWgrAI7Z/Re9IIvsMm8PwOIpoO9qBU8sSy4S0nMS
 4jPbOD05A/lQ116UAkRA1qAe042pCBEOa9ey7y8RWftADpaZ+XcVZqCVXeKbsIEcfUib
 lsZv8Itprsc/qgMfYyBtYJmWuS9G9zMCLYm+f5GdXhfnNlRFsYX50Ok+lxHfjdZaL2Yg
 GvvXTJ+6V3nBSG29NGko2nj08Yn7bI6B7mGob9evEDVkRrrHMkUCEsNRR7JaB9ESvqNL
 CSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+x0WGSWw36fXqg8sJBr/e/px4PQ5p89CEe43iMHBL7I=;
 b=b5k+UQBZt3ZlFMkyN5ROThO7Hqia2fzRDDkpx64yBHhIT35S9Medb85Zfc/rfQE12J
 qmSBX9vhvB4F2NV3VGeCWvKhyR8E0l4fe4s+f7Vc94DxLaN4QiBkkIVRT5/S/DEhBu2k
 S9LtZe4HxLWc5+uMbKstYD11/WoY29rji7u/3vdLR2TplNC4Ez8GUxspbEUqP/HL+q23
 kI6zZIbgkDacBrlgWu73vFpY83YNn8SIOWidq00irTVQDd7JbXMVTPA8UWX7WYjFtB4c
 chGH7ahme/yXKd/G7HTneSDZvx+h9l5pCaku6x/mMuH3fAZAddbi+wQAhIj0t3/RkBbq
 2ZNQ==
X-Gm-Message-State: APjAAAVm1ARYbmRStOUaWIAq2FeBgrWNuwVB4gD8jkOmcNajN81tXHfd
 bmwpNM74kk5G79EGS2rqYTSWF/MDdqA=
X-Google-Smtp-Source: APXvYqxWqqWPuBOLdRQc/hJXfPoBdGtaq4fiuoS0mDfuRQj9NKrBc2K0oy/9Xr5Ai6Lkek3SZ7VJxw==
X-Received: by 2002:a17:90a:5884:: with SMTP id
 j4mr11266253pji.142.1564866488176; 
 Sat, 03 Aug 2019 14:08:08 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id x25sm110129644pfa.90.2019.08.03.14.08.07
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 03 Aug 2019 14:08:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat,  3 Aug 2019 14:07:58 -0700
Message-Id: <20190803210803.5701-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190803210803.5701-1-richard.henderson@linaro.org>
References: <20190803210803.5701-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v7 1/6] linux-user/aarch64: Reset btype for
 signals
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The kernel sets btype for the signal handler as if for a call.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/signal.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index cd521ee42d..2c596a7088 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -506,10 +506,16 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
             + offsetof(struct target_rt_frame_record, tramp);
     }
     env->xregs[0] = usig;
-    env->xregs[31] = frame_addr;
     env->xregs[29] = frame_addr + fr_ofs;
-    env->pc = ka->_sa_handler;
     env->xregs[30] = return_addr;
+    env->xregs[31] = frame_addr;
+    env->pc = ka->_sa_handler;
+
+    /* Invoke the signal handler as if by indirect call.  */
+    if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
+        env->btype = 2;
+    }
+
     if (info) {
         tswap_siginfo(&frame->info, info);
         env->xregs[1] = frame_addr + offsetof(struct target_rt_sigframe, info);
-- 
2.17.1


