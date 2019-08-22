Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF92C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 19:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FCCF233A2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 19:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="brt0UGnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCCF233A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0sLU-0006sd-3Z
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 15:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0sJ6-0005Pt-T1
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 14:59:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0sJ5-0004Qm-SQ
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 14:59:36 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44764)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0sJ5-0004Pz-Mt
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 14:59:35 -0400
Received: by mail-pg1-x542.google.com with SMTP id i18so4182225pgl.11
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 11:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1Ly/U6ykcHLVzGazIt39CUi/LITjT+MWMWABpH7UFOY=;
 b=brt0UGnHo1XONAee1WLeKYbX6nr1rx5j7oiFXVVvG1sBHfuG2ubLZTcyb+R/7Zs1nL
 scsmqpP2YtZt1Hjqpi/u/z6Hz9DvNUffYn4b3XBy12E5fxKHO4jv6fNAx2Or8QFX2NT6
 Jg4jBZmfkrRAy4pd9Km/Y/Kb/czEGTHZBfyxfkuHRdY7kieI80oQhBVY8/M4RnxX2h/2
 0d20VOY6sJZ8Uk71Xte7XRQgDY0qHUSfmA0xfhyPRUdLcYiTjWbBqbEgue0/3w3/lSfp
 +hm1Y15pJed1J8tt4IGzF8wftb1maP0qcWOTm5bCW6sbAF3eVLHtuNarGmJ4il9HYPeq
 WYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=1Ly/U6ykcHLVzGazIt39CUi/LITjT+MWMWABpH7UFOY=;
 b=Ly3XPBEcSF7r8MQ8TO/AIHFPqDK6WX1q6jdgwdTWlh7xZ6UPGAWlWQ+/Bu5DTSpgsT
 wiMwsQLZ0CVvjSkoghmy39g3EEpdd8mORbShCQdySqf8cQStjXyCbF+XnlPehDdz9I+I
 rrdm9Q9BF2X9YRnjrcTsVnNDvv4BlWa9hwPRRqwF8PJZQuKgQWTmRhYOqdo9KEiqI3ob
 0PmyU74/BRDqLWLnVgm8yG5j82c9bf/CEx1NR4l62v5fQJeNWKX7fhW18HC3pXZiychh
 egaLy83l55Zpxivax/+HLvY3UqQhPm9I0gtB31WZWfos87Vyh0AF7y+XGPuR0PN/TCgf
 lhSw==
X-Gm-Message-State: APjAAAWqeUUOr23YNVR8ZtpZnTRsJts8RHH0MBawdeoOhar9qA7otiH7
 Y5OV5VHxePn9ppVzotprdgam/s/NjjM=
X-Google-Smtp-Source: APXvYqyriG6fhxD/YfLbPZ2IZPOVfzGu/eSropSX2vjv6GxGlxM+CdlmD+rRQbg2PPuBaZPjl8bApw==
X-Received: by 2002:a62:1858:: with SMTP id 85mr761268pfy.120.1566500374282;
 Thu, 22 Aug 2019 11:59:34 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z14sm287172pjr.23.2019.08.22.11.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2019 11:59:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 11:59:29 -0700
Message-Id: <20190822185929.16891-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190822185929.16891-1-richard.henderson@linaro.org>
References: <20190822185929.16891-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH 2/2] linux-user/arm: Adjust MAX_RESERVED_VA for
 M-profile
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
Cc: peter.maydell@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Limit the virtual address space for M-profile cpus to 2GB,
so that we avoid all of the magic addresses in the top half
of the M-profile system map.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/target_cpu.h | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/linux-user/arm/target_cpu.h b/linux-user/arm/target_cpu.h
index 279ea532d5..3f79356a07 100644
--- a/linux-user/arm/target_cpu.h
+++ b/linux-user/arm/target_cpu.h
@@ -19,9 +19,27 @@
 #ifndef ARM_TARGET_CPU_H
 #define ARM_TARGET_CPU_H
 
-/* We need to be able to map the commpage.
-   See validate_guest_space in linux-user/elfload.c.  */
-#define MAX_RESERVED_VA(CPU)  0xffff0000ul
+static inline unsigned long arm_max_reserved_va(CPUState *cs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    if (arm_feature(&cpu->env, ARM_FEATURE_M)) {
+        /*
+         * There are magic return addresses above 0xfe000000,
+         * and in general a lot of M-profile system stuff in
+         * the high addresses.  Restrict linux-user to the
+         * cached write-back RAM in the system map.
+         */
+        return 0x80000000ul;
+    } else {
+        /*
+         * We need to be able to map the commpage.
+         * See validate_guest_space in linux-user/elfload.c.
+         */
+        return 0xffff0000ul;
+    }
+}
+#define MAX_RESERVED_VA  arm_max_reserved_va
 
 static inline void cpu_clone_regs(CPUARMState *env, target_ulong newsp)
 {
-- 
2.17.1


