Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E88C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C59D120830
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lrn07EFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C59D120830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9s37-0003MP-Cj
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 10:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnO-0004U2-AX
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnK-0006wo-RL
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:16:01 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53673)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i9rnK-0006vq-1v
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:15:58 -0400
Received: by mail-wm1-x344.google.com with SMTP id i16so4440069wmd.3
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Gh+oqgc2n48QT9sSy2M1g0ivWpPv75MEqogioo212qA=;
 b=lrn07EFyqGs0lOp4gEBmuBJWHYn1TV/RG3gvC6NFQv54xa/h97HYn3lSE0D45H+Aak
 /ZGFBk+FhlmEoPpJaTxbmCMBakBgN/JFba1irR5Bzlh4HuEgxT4f5benQ+MHBzS6ziR0
 +W4FDtc+u4aSOexVFb6y+pfmyjq5pRx1VUzV3K0v1oEa0eYjTQXhieyJ3npGQ5/TFyJv
 yOk5/rT7aO1KpIlHzvXc5qh03qgmW4+ft84zepll6Uj4ne+HKzC1lR8ZOL23FcqjmLIG
 aVIVPMkhYOVzdKyUv8IefU0+BYQPvXliCU26IDXrsS3If2EqBWDKyx6EZlu+eEHv1dGA
 rMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Gh+oqgc2n48QT9sSy2M1g0ivWpPv75MEqogioo212qA=;
 b=EoZ5L0J0+SEsCpDAvq8dt4Ad4zr3/t77VSGT/ijwe49ddpxqyiAXkHSpJrUtoZVpwY
 mtHR/HDyq8jSEP7qqaBCNYS9YOrA6EQhAUz74BEBlyjuZHqGWq22IZ2+lyGLT1Oapg9c
 D+hLP9iSN1how8uLcFW19xAjIEVt1el+5U5Fb6zsZJx2OFQ+uCUVnZMzVqPp6xRuPbul
 pM8yJvyFS/yVnXXctaDrhMZlU6guBRLm/K1ELuZ3S+Jg8OxUKlc9PnEN+frpfWNEyTrz
 1SX4jlJf1dok4LgYwecnn+W0igSzETLA2YO9rp0fzij7fljH0jYiMzKNa1hXJ8oUHl66
 4sJw==
X-Gm-Message-State: APjAAAVw9HTFkY0j3RnwqenXh13F0+c+0O8e4/mxg8FA9Ee3g3taSW09
 NT0O/MhxESqtfRDC5hj41tS3nPKaHZ9Rvw==
X-Google-Smtp-Source: APXvYqxThPDe4JH2aEwcTLb4azIdpIzI5Kf3kh+42a8EMA9KZxDuUiG8itJbugrR9+yOgsk5/k5+6g==
X-Received: by 2002:a1c:2d44:: with SMTP id t65mr8151256wmt.12.1568643357065; 
 Mon, 16 Sep 2019 07:15:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s9sm15185884wme.36.2019.09.16.07.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 07:15:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 15:15:37 +0100
Message-Id: <20190916141544.17540-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916141544.17540-1-peter.maydell@linaro.org>
References: <20190916141544.17540-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v2 08/15] target/arm/arm-semi: Factor out
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Factor out the implementation of SYS_WRITE via the
new function tables.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/arm-semi.c | 51 ++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index e5f1e2aaaf2..c21cbb97bc1 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -384,6 +384,8 @@ static target_ulong arm_gdb_syscall(ARMCPU *cpu, gdb_syscall_complete_cb cb,
  * setting the guest errno if appropriate.
  */
 typedef uint32_t sys_closefn(ARMCPU *cpu, GuestFD *gf);
+typedef uint32_t sys_writefn(ARMCPU *cpu, GuestFD *gf,
+                             target_ulong buf, uint32_t len);
 
 static uint32_t host_closefn(ARMCPU *cpu, GuestFD *gf)
 {
@@ -392,21 +394,51 @@ static uint32_t host_closefn(ARMCPU *cpu, GuestFD *gf)
     return set_swi_errno(env, close(gf->hostfd));
 }
 
+static uint32_t host_writefn(ARMCPU *cpu, GuestFD *gf,
+                             target_ulong buf, uint32_t len)
+{
+    uint32_t ret;
+    CPUARMState *env = &cpu->env;
+    char *s = lock_user(VERIFY_READ, buf, len, 1);
+    if (!s) {
+        /* Return bytes not written on error */
+        return len;
+    }
+    ret = set_swi_errno(env, write(gf->hostfd, s, len));
+    unlock_user(s, buf, 0);
+    if (ret == (uint32_t)-1) {
+        ret = 0;
+    }
+    /* Return bytes not written */
+    return len - ret;
+}
+
 static uint32_t gdb_closefn(ARMCPU *cpu, GuestFD *gf)
 {
     return arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
 }
 
+static uint32_t gdb_writefn(ARMCPU *cpu, GuestFD *gf,
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
 
@@ -539,24 +571,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             return set_swi_errno(env, -1);
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
-            ret = set_swi_errno(env, write(gf->hostfd, s, len));
-            unlock_user(s, arg1, 0);
-            if (ret == (uint32_t)-1) {
-                ret = 0;
-            }
-            /* Return bytes not written */
-            return len - ret;
-        }
+        return guestfd_fns[gf->type].writefn(cpu, gf, arg1, len);
     case TARGET_SYS_READ:
         GET_ARG(0);
         GET_ARG(1);
-- 
2.20.1


