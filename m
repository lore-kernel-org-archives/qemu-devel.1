Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7776C5DF64
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:41:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 690F02077C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vizkZqci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690F02077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJgo-0004vX-G0
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:41:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iSJZH-0003vL-9G
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iSJZG-0007Xt-5v
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:43 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42881)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iSJZF-0007XZ-WB
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:42 -0500
Received: by mail-wr1-x442.google.com with SMTP id a15so25308657wrf.9
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 03:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=y3Wn+08sAN9VokvpvlBwbpJiSQsLtcSXLgAihEQXJkk=;
 b=vizkZqciyORoUPekFYkVrRLuEtCWJoBGDpDvfORmyh2xOd52JUWYURK1ffc2mBqRl+
 mJiB7fNIpSoch6xjSY55tFFN7Bu4sc+gZVxt0dHkECRaqLvojqKtJwKYRwzST9EbndPM
 z8efbz4nfKqMYLoub1Mu0+XA+RYKsznbiUtrAPNxngrWxfcSD3a63QeWDAE8Osg/QG6W
 XjT72QRlXHYVvtv5cJIIhFmbG4XgzxtSJNWYo6fbFNbY1QXiUVrKU4+JxXjvHEQWBO59
 nw98OPqHOp3NiEMHu8ihME3jcmuR+A74beGCwvDDDcuulXWsj9ZMnsaKqUt0uNOf4a41
 pJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=y3Wn+08sAN9VokvpvlBwbpJiSQsLtcSXLgAihEQXJkk=;
 b=l6Aq74mZqxEhG+kiKnO+G76W9PcDA/N/STOcwwwNuiGGxOD5h+7bY0uvbCz3QnUpgG
 d0CoHHYuWP45uVPTaR/Ob0f00bbEKMUTPQc8oJUCBH3dyVFCeu9D6R3hzGsi/oPudLYZ
 i8u04E85icXycQZtP6oThDTfEWOD497u74R9jNt4ADOvZ5mviOKfhKAKUTAbiSj4zcnL
 2kfx7wQs0sn+kl81bD8JbWMmivjkMOpZNivFrlRBaft4XxbKejjv0Fzji/UxWzOM45h/
 KxakQ4q4LJ0+rphiFbW2OzHhufKURgvBLw+HAU7EG2MseF38ubrOXE1DVs568qH8NZGa
 4bMA==
X-Gm-Message-State: APjAAAXLGAyIR+NhD178cESYkJ0Yx3c7sBXAJqtp1TlkIIc5sJsMC9X9
 iXnokIhqeBltTSxgfgTjFdF9pdwelS2qtQ==
X-Google-Smtp-Source: APXvYqxBQpCyV1vgZemRU9LBPK2RaetAt52fHULjZ6nPY1rUOcNfxiSlgVuMNrYbD7oKqSBzrTttww==
X-Received: by 2002:a5d:674d:: with SMTP id l13mr2287358wrw.170.1573040020767; 
 Wed, 06 Nov 2019 03:33:40 -0800 (PST)
Received: from localhost.localdomain
 (31.red-176-87-122.dynamicip.rima-tde.net. [176.87.122.31])
 by smtp.gmail.com with ESMTPSA id q124sm1776907wme.13.2019.11.06.03.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 03:33:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/12] linux-user/sparc64: Fix target_signal_frame
Date: Wed,  6 Nov 2019 12:33:14 +0100
Message-Id: <20191106113318.10226-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106113318.10226-1-richard.henderson@linaro.org>
References: <20191106113318.10226-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instructions are always 4 bytes; use uint32_t not abi_ulong.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20191025113921.9412-9-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/sparc/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index 238d0ba00c..d796f50f66 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -87,7 +87,7 @@ struct target_signal_frame {
     struct sparc_stackf ss;
     __siginfo_t         info;
     abi_ulong           fpu_save;
-    abi_ulong           insns[2] __attribute__ ((aligned (8)));
+    uint32_t            insns[2] QEMU_ALIGNED(8);
     abi_ulong           extramask[TARGET_NSIG_WORDS - 1];
     abi_ulong           extra_size; /* Should be 0 */
     qemu_siginfo_fpu_t fpu_state;
@@ -98,7 +98,7 @@ struct target_rt_signal_frame {
     abi_ulong           regs[20];
     sigset_t            mask;
     abi_ulong           fpu_save;
-    unsigned int        insns[2];
+    uint32_t            insns[2];
     stack_t             stack;
     unsigned int        extra_size; /* Should be 0 */
     qemu_siginfo_fpu_t  fpu_state;
-- 
2.17.1


