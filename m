Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC87C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:27:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0830C20830
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z6QiG4cz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0830C20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9ryf-0007Qb-8U
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 10:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnO-0004VM-V1
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnL-0006x9-Mr
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:16:02 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41185)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i9rnL-0006we-7S
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:15:59 -0400
Received: by mail-wr1-x443.google.com with SMTP id h7so38066956wrw.8
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d79b3/60OcgZi0kSBOpUac2GXUI7BcbnkzcVSckh0N8=;
 b=z6QiG4cz5z1YPXxxfB10SFsVNe2Z7jRMcRTgkpEbQTpGvVB7zayX0K7NtcuhvWIOvN
 8oLXTUJh2aGQc+F9+9tX/xBJDbqPV6eqJvGcU5NwWu2jjOhK+QA6AYEKgyR5uh743N3N
 RaGxXUZiSj9eWhut60RDy22D18jIOqhg4Vjs0syS3wQLxndoCG879Dwaimo2cCrOOqy9
 O81eJp0zmMLNuZPDx8QYqL0j5e51lcYb9CjNkttaJC0TcwmhSG4n+RXgwlt7siJQF1Ut
 iR43qwSZNkYUTbhc+V8VWsXLMjB66cIHG5kITHVOdSMoj9hvIrnnz9/ycZ3rw4vqsosY
 G3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d79b3/60OcgZi0kSBOpUac2GXUI7BcbnkzcVSckh0N8=;
 b=LosfR1TeRhlrlkUneJlaZ7/DJQ38IBTbwDJaBOYuoAxAWS2SVP5T8bv2EmLoeGSTxH
 haG7vYnGg44V/pic357CeOztJV5r6mmhpWS6BA7+hLjZiBSC1KiFV71x+FUMnLoKoUNW
 WDmBctY03QPp7ooZOfYBufzxYvAwbkQeZwZ/cH97fX87yegqV4ENxBr+2lBVKf7vSSaM
 QXVHl3PaLgSKIdLPrwHCwtZDf5vetvwUkIUJXvNJ4hJLYMgVUZGaLWFF70e2SvFbQdTT
 YsQ2vESnkvRnJRukojIXuUvpsjE+hLVlnlsjipfyNSOkARt2b9iC9KmmXIXNXZfIqtDL
 hCLg==
X-Gm-Message-State: APjAAAVGldEzO3TzX4T2xmtyPy3sC9MFB142sSwIXmbuP1232Q59CzHz
 PuQC4dl+5g+2fz4wqKZPdFRPpA==
X-Google-Smtp-Source: APXvYqwtqQC2+RA5oqHQfLvTqxMY9Dozm/yeQNdACN+Z+mpU10ZGibo9mI3z1iVXRghRKplQJL4dEw==
X-Received: by 2002:a5d:6ac8:: with SMTP id u8mr33141wrw.104.1568643358160;
 Mon, 16 Sep 2019 07:15:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s9sm15185884wme.36.2019.09.16.07.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 07:15:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 15:15:38 +0100
Message-Id: <20190916141544.17540-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916141544.17540-1-peter.maydell@linaro.org>
References: <20190916141544.17540-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v2 09/15] target/arm/arm-semi: Factor out
 implementation of SYS_READ
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

Factor out the implementation of SYS_READ via the
new function tables.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/arm-semi.c | 55 +++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index c21cbb97bc1..958083a105c 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -386,6 +386,8 @@ static target_ulong arm_gdb_syscall(ARMCPU *cpu, gdb_syscall_complete_cb cb,
 typedef uint32_t sys_closefn(ARMCPU *cpu, GuestFD *gf);
 typedef uint32_t sys_writefn(ARMCPU *cpu, GuestFD *gf,
                              target_ulong buf, uint32_t len);
+typedef uint32_t sys_readfn(ARMCPU *cpu, GuestFD *gf,
+                            target_ulong buf, uint32_t len);
 
 static uint32_t host_closefn(ARMCPU *cpu, GuestFD *gf)
 {
@@ -413,6 +415,27 @@ static uint32_t host_writefn(ARMCPU *cpu, GuestFD *gf,
     return len - ret;
 }
 
+static uint32_t host_readfn(ARMCPU *cpu, GuestFD *gf,
+                            target_ulong buf, uint32_t len)
+{
+    uint32_t ret;
+    CPUARMState *env = &cpu->env;
+    char *s = lock_user(VERIFY_WRITE, buf, len, 0);
+    if (!s) {
+        /* return bytes not read */
+        return len;
+    }
+    do {
+        ret = set_swi_errno(env, read(gf->hostfd, s, len));
+    } while (ret == -1 && errno == EINTR);
+    unlock_user(s, buf, len);
+    if (ret == (uint32_t)-1) {
+        ret = 0;
+    }
+    /* Return bytes not read */
+    return len - ret;
+}
+
 static uint32_t gdb_closefn(ARMCPU *cpu, GuestFD *gf)
 {
     return arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
@@ -426,19 +449,30 @@ static uint32_t gdb_writefn(ARMCPU *cpu, GuestFD *gf,
                            gf->hostfd, buf, len);
 }
 
+static uint32_t gdb_readfn(ARMCPU *cpu, GuestFD *gf,
+                           target_ulong buf, uint32_t len)
+{
+    arm_semi_syscall_len = len;
+    return arm_gdb_syscall(cpu, arm_semi_cb, "read,%x,%x,%x",
+                           gf->hostfd, buf, len);
+}
+
 typedef struct GuestFDFunctions {
     sys_closefn *closefn;
     sys_writefn *writefn;
+    sys_readfn *readfn;
 } GuestFDFunctions;
 
 static const GuestFDFunctions guestfd_fns[] = {
     [GuestFDHost] = {
         .closefn = host_closefn,
         .writefn = host_writefn,
+        .readfn = host_readfn,
     },
     [GuestFDGDB] = {
         .closefn = gdb_closefn,
         .writefn = gdb_writefn,
+        .readfn = gdb_readfn,
     },
 };
 
@@ -584,26 +618,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             return set_swi_errno(env, -1);
         }
 
-        if (use_gdb_syscalls()) {
-            arm_semi_syscall_len = len;
-            return arm_gdb_syscall(cpu, arm_semi_cb, "read,%x,%x,%x",
-                                   gf->hostfd, arg1, len);
-        } else {
-            s = lock_user(VERIFY_WRITE, arg1, len, 0);
-            if (!s) {
-                /* return bytes not read */
-                return len;
-            }
-            do {
-                ret = set_swi_errno(env, read(gf->hostfd, s, len));
-            } while (ret == -1 && errno == EINTR);
-            unlock_user(s, arg1, len);
-            if (ret == (uint32_t)-1) {
-                ret = 0;
-            }
-            /* Return bytes not read */
-            return len - ret;
-        }
+        return guestfd_fns[gf->type].readfn(cpu, gf, arg1, len);
     case TARGET_SYS_READC:
         qemu_log_mask(LOG_UNIMP, "%s: SYS_READC not implemented", __func__);
         return 0;
-- 
2.20.1


