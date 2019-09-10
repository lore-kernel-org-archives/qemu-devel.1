Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31DBC49ED8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:01:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DFAC20863
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S1W9+GjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFAC20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7heL-00062U-U6
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 11:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7hNp-0005UH-1a
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7hNn-00051t-QD
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:40 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36223)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7hNn-00051U-Ki
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:39 -0400
Received: by mail-wr1-x442.google.com with SMTP id y19so20839190wrd.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 07:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=7yOOhdKlBIYO8WFMmpn39kOmkjcRHpZcI7p0s8duWdE=;
 b=S1W9+GjIQ6Q1+v2erJ8a8p45+tj3PFe1rle3T4TYKuUvrNPQ7Kw88ydslBiCo08oJS
 AnFATCxYou1iuoeTX7wauXIkGk5wQ1hT0f7vKK0Ft8VVHUjTi9YSMz4yyspTLPhT1kv2
 BmVqnCkOpefUdL5WOHjgRVj04HX5GjBuNJPCq23TvsNGBE0+p71t7L37o411Ad0GimlX
 OFN+SOpA24d92oo5LwlJdKVX0OtQlrbfZb502feAxRpcKkCnJ9ayL8YEslcX+mN1kt2M
 Lqz21sYS3zCpmNkXLLVB151z2FPn7UZAyTX8O2TgQWgAT0L0/JpYi4hCGakerpNXA/3+
 iKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7yOOhdKlBIYO8WFMmpn39kOmkjcRHpZcI7p0s8duWdE=;
 b=CvqypKaItjDyBNFbb7iQfuM05QBGKFdN0LhYQK/RxC90L/T6J6wncaaFGYVmNLqkHp
 JsAoTA/LLILUJV4+kHzwgz+RXQQDSWN454ji0Zzpx8gULkADQuXpY8ykl4tzU7Jp3ue8
 ULFIhDyJw+66UcIkvc7esFyf4I1WEFXg0kSRYTAVkPegs0GDyC6ZXaJkTSN+W5lMilgC
 UHYa0aTce+rUgkPDqpV23hAPOgtGuH6xkPF61hQ3gdfUOtbLhkQGuEToqkb1eBXC0TAK
 8SzR/1A+FgZH1VIiqCNfBkzQS/sMGpAaKA42oivPvdBg5oI5IGD1jAy1VfBLjUgI6IK2
 z14w==
X-Gm-Message-State: APjAAAWei3qBVeTblUSsfQtffxOaK43VjwEGJRBf6Hfky7xFdGVcJjeD
 WrffOrPrQKjEKv/prRzLBa6IVCM0L2TvdA==
X-Google-Smtp-Source: APXvYqzH0+2tPkyNL7Q3ztPaK4uYqBJuC6i0Blg1Ihi3fBIF0jLBm/GHXUJ+mp4eEWSEFBRwZqCIMg==
X-Received: by 2002:a5d:49c7:: with SMTP id t7mr276133wrs.229.1568126678753;
 Tue, 10 Sep 2019 07:44:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a192sm5703814wma.1.2019.09.10.07.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 07:44:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 15:44:22 +0100
Message-Id: <20190910144428.32597-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910144428.32597-1-peter.maydell@linaro.org>
References: <20190910144428.32597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 07/13] target/arm/arm-semi: Factor out
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Factor out the implementation of SYS_READ via the
new function tables.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/arm-semi.c | 57 ++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 0dec4c04e2f..48a10dd3c3a 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -347,6 +347,8 @@ static target_ulong arm_gdb_syscall(ARMCPU *cpu, gdb_syscall_complete_cb cb,
 typedef uint32_t sys_closefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf);
 typedef uint32_t sys_writefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
                              target_ulong buf, uint32_t len);
+typedef uint32_t sys_readfn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
+                            target_ulong buf, uint32_t len);
 
 static uint32_t host_closefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf)
 {
@@ -374,6 +376,29 @@ static uint32_t host_writefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
     return len - ret;
 }
 
+static uint32_t host_readfn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
+                            target_ulong buf, uint32_t len)
+{
+    uint32_t ret;
+#ifndef CONFIG_USER_ONLY
+    CPUARMState *env = &cpu->env;
+#endif
+    char *s = lock_user(VERIFY_WRITE, buf, len, 0);
+    if (!s) {
+        /* return bytes not read */
+        return len;
+    }
+    do {
+        ret = set_swi_errno(ts, read(gf->hostfd, s, len));
+    } while (ret == -1 && errno == EINTR);
+    unlock_user(s, buf, len);
+    if (ret == (uint32_t)-1) {
+        ret = 0;
+    }
+    /* Return bytes not read */
+    return len - ret;
+}
+
 static uint32_t gdb_closefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf)
 {
     return arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
@@ -387,19 +412,30 @@ static uint32_t gdb_writefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
                            gf->hostfd, buf, len);
 }
 
+static uint32_t gdb_readfn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
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
 
@@ -551,26 +587,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             return set_swi_errno(ts, -1);
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
-                ret = set_swi_errno(ts, read(gf->hostfd, s, len));
-            } while (ret == -1 && errno == EINTR);
-            unlock_user(s, arg1, len);
-            if (ret == (uint32_t)-1) {
-                ret = 0;
-            }
-            /* Return bytes not read */
-            return len - ret;
-        }
+        return guestfd_fns[gf->type].readfn(ts, cpu, gf, arg1, len);
     case TARGET_SYS_READC:
         qemu_log_mask(LOG_UNIMP, "%s: SYS_READC not implemented", __func__);
         return 0;
-- 
2.20.1


