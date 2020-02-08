Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208E1C3F68F
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:01:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29113217BA
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tisg0nLu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29113217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Pjk-0005nm-8W
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 08:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgp-0000So-8T
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgo-0004ie-5b
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:27 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j0Pgn-0004g7-Vw
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:26 -0500
Received: by mail-wm1-x343.google.com with SMTP id a5so5226679wmb.0
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 04:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tvJQ3fhZEDoIAjBPdFLswJao5LtCHZt/hd8CPib7dDo=;
 b=tisg0nLuaHHslptN22cKKGj9BdulPfWBJNYsmnMp7rvOGOLPIptYW6HKdOCVVM9rT7
 oZLsCiyD+C0UVBFlhST7eN8bj6l6Eb15cWHm3LjOVkyhLb1Y2nZU4IqOTkYk43DZ42vz
 QX5PNyseqm/g65N6fnU5nKjJO7N++okggK3h4AbBkiTSiWBoV1T/Cul+F1ShKlERsLb3
 kK4VwpKjMnoKONfjB2CR8AcKh8lvdOriCEtghEBI7TBUDknFQr7QAgca1Ms31/AzdvdT
 1vtIOeyEr2IFB2l2QquPuHA1cUCzaw4AdLypPkk61pH3bB/YofPplDFMspm9BcXhjur7
 NT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tvJQ3fhZEDoIAjBPdFLswJao5LtCHZt/hd8CPib7dDo=;
 b=PO984tcPZYhnYz53tPN/RUXHAI43WId2X7Ago5swuvehoW2xmL7KOO7FdBv1g3/TEg
 WqLghR9WfUoGmB1wFh3kcEUMQmEb07oCkmZFxk/Bee3wXHnyhUVwP+jT+oEWQgHX7xtl
 fDh3ELZzsj9wBGUrl04GWACihn730mqMuQJo2LD8CBxROst0NzvO72cwzWQlMU5nBZ/e
 cfrSs2OR17AGBrucxeMknVI814qqiH0EDiDOhKqKiBfv6yDBaxyNnTI/KUdVz7NR1BEG
 5B+8cizyFKtlxhJH6bQ1pu+8tQpKMVpPu+PjnXG/CbzYwGzai9iToU27hJpZY/CAL2ne
 yIjA==
X-Gm-Message-State: APjAAAX+Hl6s8k6SRKSgJHkjTNISXFLgqjPRn+4+P31gBX74R9ZXQn8L
 VhCn8nrF05R6juWd/NQ52AS1zTMj7OW5HQ==
X-Google-Smtp-Source: APXvYqynNI+9w2GRGVyDtA31aT3FdlQniRbh0uN/pnpEP3uCmKxUxEKx2hnRfqkpk4Dfu3mTBjkQRg==
X-Received: by 2002:a05:600c:23ce:: with SMTP id
 p14mr4269683wmb.114.1581166704693; 
 Sat, 08 Feb 2020 04:58:24 -0800 (PST)
Received: from localhost.localdomain ([82.3.55.76])
 by smtp.gmail.com with ESMTPSA id p5sm7490534wrt.79.2020.02.08.04.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 04:58:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 07/20] target/arm: Replace CPSR_ERET_MASK with
 aarch32_cpsr_valid_mask
Date: Sat,  8 Feb 2020 12:58:03 +0000
Message-Id: <20200208125816.14954-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200208125816.14954-1-richard.henderson@linaro.org>
References: <20200208125816.14954-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CPSR_ERET_MASK was a useless renaming of CPSR_RESERVED.
The function also takes into account bits that the cpu
does not support.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h       | 2 --
 target/arm/op_helper.c | 5 ++++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 08b2f5d73e..694b074298 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1209,8 +1209,6 @@ void pmu_init(ARMCPU *cpu);
 #define CPSR_USER (CPSR_NZCV | CPSR_Q | CPSR_GE)
 /* Execution state bits.  MRS read as zero, MSR writes ignored.  */
 #define CPSR_EXEC (CPSR_T | CPSR_IT | CPSR_J | CPSR_IL)
-/* Mask of bits which may be set by exception return copying them from SPSR */
-#define CPSR_ERET_MASK (~CPSR_RESERVED)
 
 /* Bit definitions for M profile XPSR. Most are the same as CPSR. */
 #define XPSR_EXCP 0x1ffU
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 27d16ad9ad..acf1815ea3 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -400,11 +400,14 @@ void HELPER(cpsr_write)(CPUARMState *env, uint32_t val, uint32_t mask)
 /* Write the CPSR for a 32-bit exception return */
 void HELPER(cpsr_write_eret)(CPUARMState *env, uint32_t val)
 {
+    uint32_t mask;
+
     qemu_mutex_lock_iothread();
     arm_call_pre_el_change_hook(env_archcpu(env));
     qemu_mutex_unlock_iothread();
 
-    cpsr_write(env, val, CPSR_ERET_MASK, CPSRWriteExceptionReturn);
+    mask = aarch32_cpsr_valid_mask(env->features, &env_archcpu(env)->isar);
+    cpsr_write(env, val, mask, CPSRWriteExceptionReturn);
 
     /* Generated code has already stored the new PC value, but
      * without masking out its low bits, because which bits need
-- 
2.20.1


