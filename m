Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48A3C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:16:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC312146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BtTq1HMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC312146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCsAX-0007ux-8B
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 17:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrw3-0002Zw-Ld
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrw1-0004Vc-6S
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:23 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCrw0-0004TY-RK
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:21 -0400
Received: by mail-wr1-x441.google.com with SMTP id i1so3630398wro.4
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 14:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wJdzvAZ41TKUWvjFeoNAGSzCvO5q5Lz+7iIWbJ7Vp+g=;
 b=BtTq1HMz6PswalfgUpIfNccBybOf+X/TTBdcbFTHcWtgymgEW8i2sDfcJcYqp1Ml8r
 WHkq1/qkqeXZ+Qmdjnj1AQt6JSpnytCtuJo8ja08mYnnWgVAoW19X+sGc+uVJvAmGDLY
 GPXgrTnrRoy2G1MJ4kJmIYdEUVV25tns103j2Wydyuj2lfU0vK2d0TR68nQ+4pj7/GTR
 67nWItoUA/pnDniJ+QLXV2QHcSPhWfkROJr5xxSlkTolpCQs639SVKIC8P6kGICfC/TN
 Jg1qmQ9oziWhNP1Tzq1gv1pNJ0kMP9MjxSMPGBoyS6P24am/jOY+mL3KEDvHn7NZQ2rq
 XzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wJdzvAZ41TKUWvjFeoNAGSzCvO5q5Lz+7iIWbJ7Vp+g=;
 b=FNkatTEn3fIR0qey5r0LvNAhSgjCBpQPO378AKpPCFojDCRsAvpN/dmvWQdbciX17X
 gG6tL1BrkyZGLG3/psxYb0UunqtzRgrXl98fnaUtrfZc292KOL4T6FJdVDKdHWWlZ0WY
 UeRtfsyG1hzp16zxHvg8qoMoI92UF4fvj03kOyW43awWLu9GQOg1L6pW5BE0GHTdDHFN
 hgzXCocKdWvLLGN7xJpbN9ZwIV25yDhBlJm/KPSBSEQ/HdjCqdSt25S0nXqNXKteZcXY
 0xwvhh78zWpqXSjrSPSUT5JUay+ikVIaGkpEGhQMMcWtgdjIpB1/aTVhP/TiroiNu+wO
 l53w==
X-Gm-Message-State: APjAAAWIwS8bv0AYtTNDQf7vWW0FbMK+oVIKchqk4+STDRHJRnKRYhQ4
 wkYQLTE9KCA3RvIbqltGiCqhWQ==
X-Google-Smtp-Source: APXvYqxpmi+ZwD+Mos3e+LbS9u9I1p5RH6f5/H2bxHVUSQCbtGSKfyaWu+mXL7dYNF7p42ui0cRlBQ==
X-Received: by 2002:adf:e546:: with SMTP id z6mr4629559wrm.113.1569358877629; 
 Tue, 24 Sep 2019 14:01:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d9sm5349354wrf.62.2019.09.24.14.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:01:14 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CA5241FF9B;
 Tue, 24 Sep 2019 22:01:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 11/33] target/ppc: fix signal delivery for ppc64abi32
Date: Tue, 24 Sep 2019 22:00:44 +0100
Message-Id: <20190924210106.27117-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924210106.27117-1-alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: jsnow@redhat.com, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>, f4bug@amsat.org,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We were incorrectly using the 64-bit AIX ABI instead of the 32-bit
SYSV ABI for setting NIP for the signal handler.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
v2
  - change to wording
---
 linux-user/ppc/signal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
index 619a56950df..5b82af6cb62 100644
--- a/linux-user/ppc/signal.c
+++ b/linux-user/ppc/signal.c
@@ -501,7 +501,9 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     int i, err = 0;
 #if defined(TARGET_PPC64)
     struct target_sigcontext *sc = 0;
+#if !defined(TARGET_ABI32)
     struct image_info *image = ((TaskState *)thread_cpu->opaque)->info;
+#endif
 #endif
 
     rt_sf_addr = get_sigframe(ka, env, sizeof(*rt_sf));
@@ -557,7 +559,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     env->gpr[5] = (target_ulong) h2g(&rt_sf->uc);
     env->gpr[6] = (target_ulong) h2g(rt_sf);
 
-#if defined(TARGET_PPC64)
+#if defined(TARGET_PPC64) && !defined(TARGET_ABI32)
     if (get_ppc64_abi(image) < 2) {
         /* ELFv1 PPC64 function pointers are pointers to OPD entries. */
         struct target_func_ptr *handler =
-- 
2.20.1


