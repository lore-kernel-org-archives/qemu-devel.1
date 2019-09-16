Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1A8C4CECD
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:57:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69DC120650
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kf9+AQja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69DC120650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9sRQ-0004DW-0S
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 10:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnQ-0004Z3-N8
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnO-0006yl-KV
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:16:04 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43377)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i9rnO-0006xw-0o
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:16:02 -0400
Received: by mail-wr1-x444.google.com with SMTP id q17so34389121wrx.10
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ip9jGRYToznbvcQb9Dd6OoDNrfiOnhYep+7awl0RM0k=;
 b=kf9+AQjapHnLSJepUg9Ij8zh9vnVRKvM+sVCbvC3rij9e9PyS/mvVwWyLLTMoHQnoD
 MhGphVE9I7gngIBYakS/MAND+GSUnNwu4H41iAL8nl/hQwuyz4V3WhLQPInnZ8bK8cXg
 fnhd26wgV46VSSGaTi3LyEG5O3oteFCwUoK442xbHa6YsVtlP3+Id0k0yXHjTLpKWzwt
 +hl4w5y7l4p0pmKs7iWFLp6FlM1WhxXrHKNekb2ISsuJuDoGwPahs98cQZEf5Lkj8xOx
 q7Gr0py8XkmvRUIgalhet7ZTgDHroyoqc3PT8y/nuWhBGMg7CUvTrw8yEjt9pYrKSy/l
 3U0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ip9jGRYToznbvcQb9Dd6OoDNrfiOnhYep+7awl0RM0k=;
 b=Z78JYemCE7o8LY2YXFlnBrrwT1n4tOo2LSiLc1HUNkBdL8+VRDTBIdW9SMu53gWGz0
 VsaZyZvBlmtQpQ6XyuVEc8B+l2TS4H3V2TD5DJzDdKdaGoK2/Ml3ZgIueg0gcCnzhHEc
 zjLdqJy8cYu/bG2V9cBIRcVC8/gmqbPRVujhxHQ4Z6eFme8A9kcnpItq/j56FQ6ZAoII
 DDyBKbYi70VxApfAeaI1llhdWpI4jWDj30OVwf4ODZOC0W/FCcmPBMfL890eCp97Gq5W
 j0mJITLu/4qDnTN1vSKK3OlqaykeK8JdlproNl5LrCo/6w8wuxWxmh9Mx+755zrqw13O
 n1+w==
X-Gm-Message-State: APjAAAVvMaSCsMynQiHcjX/sCpAw34/tGJv8g+fpAnwUK405oXP8XLp/
 UqCYNerHF05sZlgB5Vj4p7/yAbDQLi1Icw==
X-Google-Smtp-Source: APXvYqxnWFi+SskkTJ5YyQzWzOg98RX3GJdvbf742QnBOCKKoFe4vrKpdZf5eSIPWUBXItKcJDnbHw==
X-Received: by 2002:adf:f5ca:: with SMTP id k10mr22034wrp.236.1568643360563;
 Mon, 16 Sep 2019 07:16:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s9sm15185884wme.36.2019.09.16.07.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 07:16:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 15:15:40 +0100
Message-Id: <20190916141544.17540-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916141544.17540-1-peter.maydell@linaro.org>
References: <20190916141544.17540-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v2 11/15] target/arm/arm-semi: Factor out
 implementation of SYS_SEEK
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

Factor out the implementation of SYS_SEEK via the new function
tables.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/arm-semi.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index ecd51338fd3..b5e1d73eb80 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -389,6 +389,8 @@ typedef uint32_t sys_writefn(ARMCPU *cpu, GuestFD *gf,
 typedef uint32_t sys_readfn(ARMCPU *cpu, GuestFD *gf,
                             target_ulong buf, uint32_t len);
 typedef uint32_t sys_isattyfn(ARMCPU *cpu, GuestFD *gf);
+typedef uint32_t sys_seekfn(ARMCPU *cpu, GuestFD *gf,
+                            target_ulong offset);
 
 static uint32_t host_closefn(ARMCPU *cpu, GuestFD *gf)
 {
@@ -442,6 +444,16 @@ static uint32_t host_isattyfn(ARMCPU *cpu, GuestFD *gf)
     return isatty(gf->hostfd);
 }
 
+static uint32_t host_seekfn(ARMCPU *cpu, GuestFD *gf, target_ulong offset)
+{
+    CPUARMState *env = &cpu->env;
+    uint32_t ret = set_swi_errno(env, lseek(gf->hostfd, offset, SEEK_SET));
+    if (ret == (uint32_t)-1) {
+        return -1;
+    }
+    return 0;
+}
+
 static uint32_t gdb_closefn(ARMCPU *cpu, GuestFD *gf)
 {
     return arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
@@ -468,11 +480,18 @@ static uint32_t gdb_isattyfn(ARMCPU *cpu, GuestFD *gf)
     return arm_gdb_syscall(cpu, arm_semi_cb, "isatty,%x", gf->hostfd);
 }
 
+static uint32_t gdb_seekfn(ARMCPU *cpu, GuestFD *gf, target_ulong offset)
+{
+    return arm_gdb_syscall(cpu, arm_semi_cb, "lseek,%x,%x,0",
+                           gf->hostfd, offset);
+}
+
 typedef struct GuestFDFunctions {
     sys_closefn *closefn;
     sys_writefn *writefn;
     sys_readfn *readfn;
     sys_isattyfn *isattyfn;
+    sys_seekfn *seekfn;
 } GuestFDFunctions;
 
 static const GuestFDFunctions guestfd_fns[] = {
@@ -481,12 +500,14 @@ static const GuestFDFunctions guestfd_fns[] = {
         .writefn = host_writefn,
         .readfn = host_readfn,
         .isattyfn = host_isattyfn,
+        .seekfn = host_seekfn,
     },
     [GuestFDGDB] = {
         .closefn = gdb_closefn,
         .writefn = gdb_writefn,
         .readfn = gdb_readfn,
         .isattyfn = gdb_isattyfn,
+        .seekfn = gdb_seekfn,
     },
 };
 
@@ -656,15 +677,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             return set_swi_errno(env, -1);
         }
 
-        if (use_gdb_syscalls()) {
-            return arm_gdb_syscall(cpu, arm_semi_cb, "lseek,%x,%x,0",
-                                   gf->hostfd, arg1);
-        } else {
-            ret = set_swi_errno(env, lseek(gf->hostfd, arg1, SEEK_SET));
-            if (ret == (uint32_t)-1)
-              return -1;
-            return 0;
-        }
+        return guestfd_fns[gf->type].seekfn(cpu, gf, arg1);
     case TARGET_SYS_FLEN:
         GET_ARG(0);
 
-- 
2.20.1


