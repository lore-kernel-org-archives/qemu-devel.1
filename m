Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC20C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:00:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EBB42173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lzo2x0RU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EBB42173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36343 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8pMN-0000kl-LT
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:00:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j8pKw-0006dW-Q6
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j8pKv-0007ZT-NB
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:38 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42568)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j8pKv-0007Z9-IA
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:37 -0500
Received: by mail-pg1-x542.google.com with SMTP id h8so173094pgs.9
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 09:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Xb4MZkBU7c3SsPvbbpOINi23WCHWKuPEyPWHI7rJrJg=;
 b=lzo2x0RUxzilhpgFVTN4QYmyqJjuqg1RBfGHJzW9ioWN2CpVjgwp/jz/psxx9r+m/2
 rdPP2kEKvlq2CfqxQAWsYlAZQUP4AE6HJYBS3dOSu1pfEDMhMQdITg/SjJG3TuuWQRYn
 fAun+xHZNpHxWDep7FcS8owD75Wn0VDVMau4w2c1nM+Lvw1xOI3NVMaiRKTk3lti1hJ5
 BaphvzV1T5ZuuYLC5wWPDWQhm8hvf2/pHshDIVIW6Qedcfhs2NB4wzgNFfgRc22T4kF5
 cyucm2PRyh8xygFz8amS86X7NP4+reSephwQs36H/X4zDMo4BFGwjpr2kSK/63PCHUDe
 TExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Xb4MZkBU7c3SsPvbbpOINi23WCHWKuPEyPWHI7rJrJg=;
 b=PXi1+sFGhetszmkVrVRdRy3VQHvE2NR5SJO7Z1qaAAVZSDkURgqzMgvq2M/s+mWoO4
 EsHjWkyBjMFgnQxwAHJCqWd2zxhodD+V+Yj59Cyx76Af5KN6fHOojBn5M6UxcWPcxu6X
 Bdgi2HnxbXv3MdKAn6VC1E9UPunK3uox0JIl/+4gsmRaWwt8IJcK1aOMMbVrWjf9j6Y/
 YicjF7uE9BGHZsg28WOPkaSUBhn1bNaUswxhy+kkn1NgJztgJHfhApK5zX/+KTtBpRa/
 9zMa2GEUnr08tRTbgtUCKByko9nw3OAJ2yg0lwT5j+Jb7nVU8aLh3tMaGuRpxx3Ogqa9
 kQhw==
X-Gm-Message-State: ANhLgQ0uS7xkYWjtopZE6Coj7i5/1vHeMyARKm06FEOsMogZUTgIeT8O
 EHFchbnx3oiumFduLAB5w1o68L9Ag+s=
X-Google-Smtp-Source: ADFU+vv3iLnhNolBrBcjQO8XIq71zVeXC+xGHZfKtv6ij3AFnORcPkH6C1HduiYU52RbaGJCGS0tYg==
X-Received: by 2002:a63:d0b:: with SMTP id c11mr103192pgl.296.1583171916269;
 Mon, 02 Mar 2020 09:58:36 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id s18sm99510pjp.24.2020.03.02.09.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 09:58:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/9] target/arm: Apply TBI to ESR_ELx in
 helper_exception_return
Date: Mon,  2 Mar 2020 09:58:24 -0800
Message-Id: <20200302175829.2183-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200302175829.2183-1-richard.henderson@linaro.org>
References: <20200302175829.2183-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We missed this case within AArch64.ExceptionReturn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 509ae93069..123ce50e7a 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -1031,6 +1031,8 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
                       "AArch32 EL%d PC 0x%" PRIx32 "\n",
                       cur_el, new_el, env->regs[15]);
     } else {
+        int tbii;
+
         env->aarch64 = 1;
         spsr &= aarch64_pstate_valid_mask(&env_archcpu(env)->isar);
         pstate_write(env, spsr);
@@ -1038,8 +1040,27 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
             env->pstate &= ~PSTATE_SS;
         }
         aarch64_restore_sp(env, new_el);
-        env->pc = new_pc;
         helper_rebuild_hflags_a64(env, new_el);
+
+        /*
+         * Apply TBI to the exception return address.  We had to delay this
+         * until after we selected the new EL, so that we could select the
+         * correct TBI+TBID bits.  This is made easier by waiting until after
+         * the hflags rebuild, since we can pull the composite TBII field
+         * from there.
+         */
+        tbii = FIELD_EX32(env->hflags, TBFLAG_A64, TBII);
+        if ((tbii >> extract64(new_pc, 55, 1)) & 1) {
+            /* TBI is enabled. */
+            int core_mmu_idx = cpu_mmu_index(env, false);
+            if (regime_has_2_ranges(core_to_aa64_mmu_idx(core_mmu_idx))) {
+                new_pc = sextract64(new_pc, 0, 56);
+            } else {
+                new_pc = extract64(new_pc, 0, 56);
+            }
+        }
+        env->pc = new_pc;
+
         qemu_log_mask(CPU_LOG_INT, "Exception return from AArch64 EL%d to "
                       "AArch64 EL%d PC 0x%" PRIx64 "\n",
                       cur_el, new_el, env->pc);
-- 
2.20.1


