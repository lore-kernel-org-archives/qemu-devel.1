Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF31C49ED8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB7120872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CPOae9hg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB7120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7hQv-0007t3-AA
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 10:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7hNo-0005Sx-8E
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7hNm-00051D-Rc
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:39 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40572)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7hNm-00050t-Lt
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id w13so20818660wru.7
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=YWOXDYdgItfE8+407vkIvvnaRwn01B+C3RlPpmYpG/U=;
 b=CPOae9hgzuSC0OuDGe9BwP3BNIZQOP1fwo3SjCfxBWaL621js/y1AppTZuhJF3YbXx
 TEQZHopJll6otD2jmKBXQ6+eldWQm2EOTurJXMwBt9IPolSIWRkthFi6Q6m25paKoNfI
 M+yvPrZXHR8w5y69dXowBN/1N22jRoAM61LgnZClKts3ccSs+x+hpFUJM+7wUiHUzWtN
 tG56sqp6K7DNFTHkrgKnQhZV/Z848IvOOQZe6ENchdYbKhzLdNeGGQP9NHQacBaeIddc
 V0XIDgJa7uBgT+7HH1etQGK45TbEws3VGphBaZ63UTv1Wm21qXQ0rcWZFw2nZJsTp1ub
 M39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YWOXDYdgItfE8+407vkIvvnaRwn01B+C3RlPpmYpG/U=;
 b=uOtIsAqxKp/97xw4fttffkhPwZq5lH7EfVgkS5f/vWigjFnqehgqQoI1CmJtzbuQjl
 bs+3vj3VFvtyCE4+IFAQAU6szpAXCjDg2ui2oz3LmpTlQQTYz6aIvopCiqUlzYaBNYIH
 qwbj4VuuzYkpIgg6TuZiOczENut7nfZld6MJmaNQ1MZoT4JjMCvguEq4pbl3ElNHSFjQ
 7K7c7ZOJCERnlBZJZfFJ7lO5PGQHmN19VaL3v9pEN+6JS/KLlrmxNbU5KDquNIfjjXg7
 UiI5BEbLDL6dJLq1rqchtbSoG2MTbuA2j0TzPtIbNoIFEPK5002wSk+Mo6ezSdH1fhtD
 /JYw==
X-Gm-Message-State: APjAAAVVwkO1aQCSyxlvqG5fA9pp6ze9W81cNTgYOpjQ+/+4K4oU8Tb3
 mQhPGYSsnse8tX54VUusQpKnUg==
X-Google-Smtp-Source: APXvYqxKsofOQZNo4pBVTaX1Za9eMs/R4U9WqJQdmm4UaZ99Zyq+vzjvdWa9QsTphSX1fARW9MZVCw==
X-Received: by 2002:a5d:548d:: with SMTP id h13mr9677544wrv.215.1568126677826; 
 Tue, 10 Sep 2019 07:44:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a192sm5703814wma.1.2019.09.10.07.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 07:44:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 15:44:21 +0100
Message-Id: <20190910144428.32597-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910144428.32597-1-peter.maydell@linaro.org>
References: <20190910144428.32597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 06/13] target/arm/arm-semi: Factor out
 implementation of SYS_WRITE
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Factor out the implementation of SYS_WRITE via the
new function tables.

The #ifdef around the declaration/initialization of the
local 'env' variable is unfortunate but necessary, because
the softmmu-semi.h version of lock_user implicitly uses 'env',
but the user-only version doesn't need it. Without the ifdefs
we'd get a warning about the unused variable for the user-only
compilation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/arm-semi.c | 53 ++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index f3e0bf77cd3..0dec4c04e2f 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -345,27 +345,61 @@ static target_ulong arm_gdb_syscall(ARMCPU *cpu, gdb_syscall_complete_cb cb,
  * setting the guest errno if appropriate.
  */
 typedef uint32_t sys_closefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf);
+typedef uint32_t sys_writefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
+                             target_ulong buf, uint32_t len);
 
 static uint32_t host_closefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf)
 {
     return set_swi_errno(ts, close(gf->hostfd));
 }
 
+static uint32_t host_writefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
+                             target_ulong buf, uint32_t len)
+{
+    uint32_t ret;
+#ifndef CONFIG_USER_ONLY
+    CPUARMState *env = &cpu->env;
+#endif
+    char *s = lock_user(VERIFY_READ, buf, len, 1);
+    if (!s) {
+        /* Return bytes not written on error */
+        return len;
+    }
+    ret = set_swi_errno(ts, write(gf->hostfd, s, len));
+    unlock_user(s, buf, 0);
+    if (ret == (uint32_t)-1) {
+        ret = 0;
+    }
+    /* Return bytes not written */
+    return len - ret;
+}
+
 static uint32_t gdb_closefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf)
 {
     return arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
 }
 
+static uint32_t gdb_writefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
+                            target_ulong buf, uint32_t len)
+{
+    arm_semi_syscall_len = len;
+    return arm_gdb_syscall(cpu, arm_semi_cb, "write,%x,%x,%x",
+                           gf->hostfd, buf, len);
+}
+
 typedef struct GuestFDFunctions {
     sys_closefn *closefn;
+    sys_writefn *writefn;
 } GuestFDFunctions;
 
 static const GuestFDFunctions guestfd_fns[] = {
     [GuestFDHost] = {
         .closefn = host_closefn,
+        .writefn = host_writefn,
     },
     [GuestFDGDB] = {
         .closefn = gdb_closefn,
+        .writefn = gdb_writefn,
     },
 };
 
@@ -504,24 +538,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             return set_swi_errno(ts, -1);
         }
 
-        if (use_gdb_syscalls()) {
-            arm_semi_syscall_len = len;
-            return arm_gdb_syscall(cpu, arm_semi_cb, "write,%x,%x,%x",
-                                   gf->hostfd, arg1, len);
-        } else {
-            s = lock_user(VERIFY_READ, arg1, len, 1);
-            if (!s) {
-                /* Return bytes not written on error */
-                return len;
-            }
-            ret = set_swi_errno(ts, write(gf->hostfd, s, len));
-            unlock_user(s, arg1, 0);
-            if (ret == (uint32_t)-1) {
-                ret = 0;
-            }
-            /* Return bytes not written */
-            return len - ret;
-        }
+        return guestfd_fns[gf->type].writefn(ts, cpu, gf, arg1, len);
     case TARGET_SYS_READ:
         GET_ARG(0);
         GET_ARG(1);
-- 
2.20.1


