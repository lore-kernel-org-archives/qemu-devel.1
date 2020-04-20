Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C146CC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 21:25:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80E1C207FC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 21:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lMhoM1tr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E1C207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQdut-0002Tq-ML
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 17:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQdrp-0006nX-8M
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 17:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQdro-0006my-JD
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 17:22:13 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jQdro-0006k7-5z
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 17:22:12 -0400
Received: by mail-wr1-x442.google.com with SMTP id x18so14047698wrq.2
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 14:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g25xx+IbQ36/3S818ce09veNakgmIRGfyJNXoNjOE3o=;
 b=lMhoM1trFpGPR441mTxkus+s2KnaNfFLUfBiME74Lrh2FIwePepyuJXydluRmH8zVf
 6dO6gS8jF1T5/vSZ9TM9XfzsEBbJ4/LobmAeR12tT3WKqVcxqd0LisvNRMplMbun8ZWm
 GHUQwDDDtUrjBRbDCcGIL8mixkjmH/vnjgNGRd6n+0UDgbZYlDtXyRMAHlNi6ikPOXvc
 eyBmQB/bc/QyXa3U9BoS7iWD4/tmnnBYPCxUWzbADcGnDMnBdDnYH08NxMAADzXmT6hy
 RmWXFzch0+vMV0QPR4WaAAMzw5sgcVd8TCTkvkuj8uYrkQOx2uFKz0yn2pfk0muLLqdS
 uqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g25xx+IbQ36/3S818ce09veNakgmIRGfyJNXoNjOE3o=;
 b=I9HsS9wjv0NgElQnZco6cG6xmOGHVaMDQKBjc9Ptj1fl9mJmV9CEMPtDpodHRRsCzg
 0KxZs0fThNGVOwP6WzPb4bC6i26WVSjX3C7q4yei0tq1gX5VUb74bKtiZwA7if6R4q0X
 m5rSusev/5TAcGJ+yhgNsIbQvtis52nUY//hzi86K67k4jFZvvskLaCzAHHA8r+F0dzs
 LBAhhjFLgafaD5NXUz9OPIH3uLEpnEuX22Acg3ZMsvAXn6JI9s3VEV8DGplr+Mxfmv/T
 ohWmtf87W8fIQV1+nFB1Lwfs2VKZzBRQnYWAq56CHaxtOhlNR5H29eZwN5YCJOcNyqaZ
 5jwg==
X-Gm-Message-State: AGi0PuaHbHdTLiEITleoDU7QnSGe5n+G2y4W8JJjU52FVuWPwXUZGq47
 A4VgWZr93nUC7m3SX/NzMr7f5A==
X-Google-Smtp-Source: APiQypKgmdm6zB/NJ1cX+17Ujgca+HhU4wMKq/TJWubEN/8GWqgdqXGiMlIMPtdODC7e45/SyOj1Fw==
X-Received: by 2002:adf:9cc8:: with SMTP id h8mr19974679wre.167.1587417730598; 
 Mon, 20 Apr 2020 14:22:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j10sm823663wmi.18.2020.04.20.14.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 14:22:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/4] linux-user/arm: BKPT should cause SIGTRAP,
 not be a syscall
Date: Mon, 20 Apr 2020 22:22:03 +0100
Message-Id: <20200420212206.12776-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200420212206.12776-1-peter.maydell@linaro.org>
References: <20200420212206.12776-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: omerg681@gmail.com, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In linux-user/arm/cpu-loop.c we incorrectly treat EXCP_BKPT similarly
to EXCP_SWI, which means that if the guest executes a BKPT insn then
QEMU will perform a syscall for it (which syscall depends on what
value happens to be in r7...). The correct behaviour is that the
guest process should take a SIGTRAP.

This code has been like this (more or less) since commit
06c949e62a098f in 2006 which added BKPT in the first place.  This is
probably because at the time the same code path was used to handle
both Linux syscalls and semihosting calls, and (on M profile) BKPT
with a suitable magic number is used for semihosting calls.  But
these days we've moved handling of semihosting out to an entirely
different codepath, so we can fix this bug by simply removing this
handling of EXCP_BKPT and instead making it deliver a SIGTRAP like
EXCP_DEBUG (as we do already on aarch64).

Reported-by: <omerg681@gmail.com>
Fixes: https://bugs.launchpad.net/qemu/+bug/1873898
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/arm/cpu_loop.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index cf618daa1ca..82d0dd3c312 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -295,32 +295,17 @@ void cpu_loop(CPUARMState *env)
             }
             break;
         case EXCP_SWI:
-        case EXCP_BKPT:
             {
                 env->eabi = 1;
                 /* system call */
-                if (trapnr == EXCP_BKPT) {
-                    if (env->thumb) {
-                        /* FIXME - what to do if get_user() fails? */
-                        get_user_code_u16(insn, env->regs[15], env);
-                        n = insn & 0xff;
-                        env->regs[15] += 2;
-                    } else {
-                        /* FIXME - what to do if get_user() fails? */
-                        get_user_code_u32(insn, env->regs[15], env);
-                        n = (insn & 0xf) | ((insn >> 4) & 0xff0);
-                        env->regs[15] += 4;
-                    }
+                if (env->thumb) {
+                    /* FIXME - what to do if get_user() fails? */
+                    get_user_code_u16(insn, env->regs[15] - 2, env);
+                    n = insn & 0xff;
                 } else {
-                    if (env->thumb) {
-                        /* FIXME - what to do if get_user() fails? */
-                        get_user_code_u16(insn, env->regs[15] - 2, env);
-                        n = insn & 0xff;
-                    } else {
-                        /* FIXME - what to do if get_user() fails? */
-                        get_user_code_u32(insn, env->regs[15] - 4, env);
-                        n = insn & 0xffffff;
-                    }
+                    /* FIXME - what to do if get_user() fails? */
+                    get_user_code_u32(insn, env->regs[15] - 4, env);
+                    n = insn & 0xffffff;
                 }
 
                 if (n == ARM_NR_cacheflush) {
@@ -396,6 +381,7 @@ void cpu_loop(CPUARMState *env)
             }
             break;
         case EXCP_DEBUG:
+        case EXCP_BKPT:
         excp_debug:
             info.si_signo = TARGET_SIGTRAP;
             info.si_errno = 0;
-- 
2.20.1


