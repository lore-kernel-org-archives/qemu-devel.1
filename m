Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC72ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:31:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E952089C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QvPugaYo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E952089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3G8-0004OY-0U
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qK-0004X5-04
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qI-0007hx-QR
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:07 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37614)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qI-0007gn-Jy
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:06 -0400
Received: by mail-wm1-x343.google.com with SMTP id f22so17300362wmc.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=3D3m/iybZ+hM7qlbVG2lqTZoquy7HtGTE5BO5uYktZ4=;
 b=QvPugaYovlafcAjrNHBMP+Nds9djCCuMgShYyrB/IjwG8cknMbv9WQye912SRSCt0Q
 HiupMeg0Mo08CDk39CjudM5DllSLblQIIOiCrgcy9Qfy5mEQ3K5ZoFfQQudXnNqLShl0
 qG4hxX+zvOFQdJaka0+wFJ1QM2274H/Qj1BzshgiLOFcxCZ/1Xey1eQALdbSguEfv/eq
 Dezq0DxsuRAhl4uWTSG7EZYkQDM5cTl37Od3qasRd42zFk7U9Nj1ZawGhku/ECSmmxq7
 U5dIwxEIyLEUPc6CijVXU12/Ig3r7OaiusRxMFpz+lSdRBlZ180fBRTSffDg5RBFSjXu
 ZtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3D3m/iybZ+hM7qlbVG2lqTZoquy7HtGTE5BO5uYktZ4=;
 b=Igd2tk0TY9YLeldpS4ExqBT3uHG43NRMsW3uFR5y3L/XpG909839InBJjRQggq91DO
 /vUw6gsTKUcWhuL5B685622bD+B6ZydJBcO0ao3KrjV3U1HomoDDPwcD2YdgYs9f1NvV
 Br5X+A9jFVr/kMhdG/eFzYQEfigBeIwGFjobZI4WVQecadnG0nSU0uXxM6TcEKkRxDWc
 el9t7GNt2YptWGw1zDL+Ey/rdDUPFGo9y+bW1EsTcd+rdyHzOBIWq54gWEALAW7NBPpd
 rH4gmZe8oDR+xjW9LMfj76uTmXRxAg6Omx7Ch6OD38IZycZkf3cU6CuosplEKStc1dH4
 ld+w==
X-Gm-Message-State: APjAAAVL/PxCwOVSrkRTGLe9OCdIevS4+g86gCLQKZ52J/qxRox5IVCo
 dSGGWNlkR/QT0T2s7aTHv5V+Xaldi3gp1A==
X-Google-Smtp-Source: APXvYqzYskLq8X0B1Fd0QJfb7M6dRLB0CkZw5RMomGbDWmZ3OmZ+O+jwaaDz0VPhpTjCVKqQmx4rFQ==
X-Received: by 2002:a7b:c006:: with SMTP id c6mr16049205wmb.45.1571069104845; 
 Mon, 14 Oct 2019 09:05:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/68] target/arm/arm-semi: Factor out implementation of
 SYS_READ
Date: Mon, 14 Oct 2019 17:03:29 +0100
Message-Id: <20191014160404.19553-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

Factor out the implementation of SYS_READ via the
new function tables.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190916141544.17540-10-peter.maydell@linaro.org
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


