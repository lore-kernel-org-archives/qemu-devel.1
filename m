Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C0DC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:45:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AF6D214DE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vFnuQT0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF6D214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9sGA-0000Ij-O3
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 10:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnK-0004OW-0f
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnH-0006vG-PE
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:15:57 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51322)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i9rnH-0006ul-Ar
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:15:55 -0400
Received: by mail-wm1-x343.google.com with SMTP id 7so10362965wme.1
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0pnYN3RXjA7UBIBYIotlAccmHjY/D9vmktQW67WnPW8=;
 b=vFnuQT0g/Orap8IjExRqmdI34nHdbzHGbhHrdxgnPl8mUNzUHemHSufsbFpNGyVBzZ
 p+VhiaMzzb0db9sssSs/mNIk0OMZDaCQAdFn/5GDQfOW9LfUI4G75o6WFQVAw5jf+7sG
 c5tXEo7p2xCAi2h01z6IK9u5ofhDIaT/HeySZRe5ZAsP1oBAkRkt3HDEoWdEsggu1Z2z
 1norD/19SkaKw52p58sMonFoZ7JzK0dS0Snu/hLQeq5ZKnzy7syHW6HlfL39SjiEzN6k
 PFtA6uHr9Vwyd4Dibe1OpF1712mXE0nHe84BSjfLqINpgFKx9CGN9c1MUEinnXv9NYy4
 /eNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0pnYN3RXjA7UBIBYIotlAccmHjY/D9vmktQW67WnPW8=;
 b=XFMJVchOJtpmLf48OzZ3Znsfr0TDgaiRt2y24tIyvM0z3Jt1/qrfYWw4tC9LEHVdPG
 nxhH+O3k6oDuVY5mxzIUQ/HlkNBEqvjBs9Ot1Z3bNxLJF3zhq+ogi4NeIMOmZA6vV4Q8
 OG60FhLTAdkKEDUT4SR9C9O66nsEkDbJszRAvRpmthNUDJibERAn8+CmbB7/OSVeLRSv
 ywTftUYTkMYYYKY1Ldflvp6TA7jb0yrqho81nAQPMGThbIGM8J3aan9hzSSCC39PYBzS
 GPEfcY54lbHhiQxEx3kl01CH2C8lCRhokoUHlXSklMdEjFcOvpWHOu/5qwlHzh4f98Ks
 Tupg==
X-Gm-Message-State: APjAAAXoI2BpGL4mdca3LOebUlPagvLeGhnlQGUYJC5lbXRMSto3Djw2
 JCnH3lFCBxJGmP3yKJ/ai1eIsf5nbH3acQ==
X-Google-Smtp-Source: APXvYqwmvGsfZ7KdIUo76pgt70Vxt3/hitTHVvURlDbfnmtf9AyvQrpzaITmB2t4hiTzoCZLsiz5dg==
X-Received: by 2002:a1c:a546:: with SMTP id o67mr14871998wme.55.1568643354347; 
 Mon, 16 Sep 2019 07:15:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s9sm15185884wme.36.2019.09.16.07.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 07:15:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 15:15:35 +0100
Message-Id: <20190916141544.17540-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916141544.17540-1-peter.maydell@linaro.org>
References: <20190916141544.17540-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v2 06/15] target/arm/arm-semi: Use
 set_swi_errno() in gdbstub callback functions
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we are routing semihosting operations through the gdbstub, the
work of sorting out the return value and setting errno if necessary
is done by callback functions which are invoked by the gdbstub code.
Clean up some ifdeffery in those functions by having them call
set_swi_errno() to set the semihosting errno.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/arm-semi.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 2618588076f..02cd673d47d 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -259,17 +259,11 @@ static void arm_semi_cb(CPUState *cs, target_ulong ret, target_ulong err)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
-#ifdef CONFIG_USER_ONLY
-    TaskState *ts = cs->opaque;
-#endif
     target_ulong reg0 = is_a64(env) ? env->xregs[0] : env->regs[0];
 
     if (ret == (target_ulong)-1) {
-#ifdef CONFIG_USER_ONLY
-        ts->swi_errno = err;
-#else
-        syscall_err = err;
-#endif
+        errno = err;
+        set_swi_errno(env, -1);
         reg0 = ret;
     } else {
         /* Fixup syscalls that use nonstardard return conventions.  */
@@ -326,11 +320,8 @@ static void arm_semi_flen_cb(CPUState *cs, target_ulong ret, target_ulong err)
     } else {
         env->regs[0] = size;
     }
-#ifdef CONFIG_USER_ONLY
-    ((TaskState *)cs->opaque)->swi_errno = err;
-#else
-    syscall_err = err;
-#endif
+    errno = err;
+    set_swi_errno(env, -1);
 }
 
 static int arm_semi_open_guestfd;
@@ -339,15 +330,9 @@ static void arm_semi_open_cb(CPUState *cs, target_ulong ret, target_ulong err)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
-#ifdef CONFIG_USER_ONLY
-    TaskState *ts = cs->opaque;
-#endif
     if (ret == (target_ulong)-1) {
-#ifdef CONFIG_USER_ONLY
-        ts->swi_errno = err;
-#else
-        syscall_err = err;
-#endif
+        errno = err;
+        set_swi_errno(env, -1);
         dealloc_guestfd(arm_semi_open_guestfd);
     } else {
         associate_guestfd(arm_semi_open_guestfd, ret);
-- 
2.20.1


