Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DFAC35DF0
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 03:15:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE03E206E6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 03:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JbDM96Hs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE03E206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6QhB-0004Mo-Vg
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 22:15:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6Qfs-0002tl-0Y
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 22:14:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6Qfr-0005LC-2D
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 22:14:19 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37958)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6Qfq-0005Kj-To
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 22:14:19 -0500
Received: by mail-pg1-x541.google.com with SMTP id d6so6169996pgn.5
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 19:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YzJYu08ie6LvTeM6gnMWpOdweYPWQCMbZiS6xrkcAUI=;
 b=JbDM96Hsf8HKbiln4DC22ceoPZKszaEOKEcMoknWi+08zzlPErxAaUWrA7hHrJCxJk
 vZ4mx1QsjVmQx0J0euSesWiPIfyw+qx7U50MrWKlaDaOCtSpRhajooXgQk+rf7NhOcur
 2Vmw6gtuBmbKNAsvITBEJyEcGhBxDJraMj6r/ImAdsf80pfxzAyf6cqnAs1tn6Pj/ZXX
 SbTiNAHDVexPl7MQ4oBgUdAtmxPkojAfyNYGKSjAiR10j8un5YKo5q8ooFtJGxpR/EOy
 cJnUITn+is+sgmlP+lhGisSycXV6oI4Lei0gpSfODJoYDAPPdLYUnqe8TeMy4bN4VObx
 lG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YzJYu08ie6LvTeM6gnMWpOdweYPWQCMbZiS6xrkcAUI=;
 b=EBAt00zjH2Mv5weWExZMVPLYB94+v+Ky/ghfJxmdFzqG1A8O3+ohG0vkutQR90tFve
 //WkvXZs6U/5OzOKFHh4FvSdVWPiTrRcj9kigJ4o66iEwm7/OcJ+5k4tMfyPBQxg4nJ4
 YLtGJ0RymjT9c9Ek7MnJZP6Yjn5F4sbzf1TodsP822z9hQyKyRTkUfqQeFIqgJItrKvH
 2ZfRwTYcw92RZbiw/i632+sEc5GzCHWVVqc4iUK5yYksi2Bn5/3wTUBeizBQepbz7SYB
 RsNwICxbeWvRcywhtbp1RK1ztMQQFy77rEvqZC1asytn0UnhQeClUJN/YikNqMD+gcRr
 zAgg==
X-Gm-Message-State: APjAAAVVroUxjXq32AFpsYJFhxOu3G05UbxjhZFWbknYmTM4YnJQ6Hro
 MjTmV4aLctU2kuKqIRdEQZ8v4qwugaM=
X-Google-Smtp-Source: APXvYqwOU8ip1mvXA4zN+EHSWDGAhLDycKHGKdeNPoIiwiqJ6zY7bUEA5wFLNnK/AT86zW5FbOHF7A==
X-Received: by 2002:a63:b257:: with SMTP id t23mr53950267pgo.17.1582600457561; 
 Mon, 24 Feb 2020 19:14:17 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id q66sm14975242pfq.27.2020.02.24.19.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 19:14:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/8] target/arm: Apply TBI to ESR_ELx in
 helper_exception_return
Date: Mon, 24 Feb 2020 19:14:09 -0800
Message-Id: <20200225031414.15649-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225031414.15649-1-richard.henderson@linaro.org>
References: <20200225031222.15434-1-richard.henderson@linaro.org>
 <20200225031414.15649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
index 509ae93069..95e9e879ca 100644
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
+            if (regime_has_2_ranges(core_mmu_idx | ARM_MMU_IDX_A)) {
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


