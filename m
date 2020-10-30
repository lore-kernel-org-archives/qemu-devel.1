Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB0CC4742C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:28:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5540B20704
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brZEivHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5540B20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYRe7-0001HA-4c
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 06:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kYRbj-000782-Ex
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:26:07 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kYRbg-00018s-Cp
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:26:07 -0400
Received: by mail-pg1-x542.google.com with SMTP id 15so4797279pgd.12
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 03:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Wl5vrXj5I7jgEasYbHvlAgBYlGrHMUwzyqbD7XKobzs=;
 b=brZEivHq26S614gHIosRGcb+k6TMM1WCu2cjKb+qMYg6lojSyBmYyy2GtmKAjHodvr
 PE6Xoqk2agiE5acDq538Oc1f1//DA0MgtQjDQn3IcgaLt/RR7BHKtpkv6UiACIvkpBS3
 JodWtLxpFkOwabf2iyBVf00FwBeM/c06dskCUxMkqZ+FBwPZr8lRbm+gqYeZvID/Aplp
 /UPRDy3j9FX9+XgAzBlIxPQ4hqLSpUOdmuQErNq12k1NTK4VpBAZQopY/a3vhYuW4ypF
 aJCYth7C6iRT2ZSg7QCnLw8JJeoyJdQedY7rskZeriwzZ6L1sNdWnqV02QaBh4V2FHn4
 SCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Wl5vrXj5I7jgEasYbHvlAgBYlGrHMUwzyqbD7XKobzs=;
 b=R3dWj4j5O1mpW4YEBhddMcLayP+NuRsmufIgDHAUd/j+M+sShpdSdnWh0UrvPADOt/
 C3ulUukzFhkdOUn5UMQvFGbNG7e+P28EjMG499evjzYJZButiq4eC0RUmY8aaJKtogIW
 Gjgyxigc3Q1/ZX6O4qf4Hv863FRcNRTjFLBewOZkwFqYoVbB6+gpAOTVZ/Nx6irdkSCa
 cUicO2mknGxKBB5U67blyyCsCImos00+2ogWIFWYJOR35Nbzu8IwXfu5gzwMoPDQARik
 FRxR3npAsHyWo3WZVZ/j3svPvsJv22eYt/1Qq8lc2hu0bGNyOauWqf/i2UyemIpEglza
 2Zpw==
X-Gm-Message-State: AOAM530MBU+ZOqng4QzIhJr3oOF0KHsZ/mSYNltqmy80i94bIJRracZR
 FEdjZ7Hic4LxR3jMbJJWY48=
X-Google-Smtp-Source: ABdhPJx1inKrDrXauoX41i/ku5BoGkIeNBfOM3VpdaHrehbsRAFKhZnFJWZjmRnYEa6KBhaHyvkI9g==
X-Received: by 2002:aa7:97ba:0:b029:152:879f:4789 with SMTP id
 d26-20020aa797ba0000b0290152879f4789mr8681649pfq.81.1604053562937; 
 Fri, 30 Oct 2020 03:26:02 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
 by smtp.gmail.com with ESMTPSA id v79sm6062146pfc.197.2020.10.30.03.25.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Oct 2020 03:26:02 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V16 1/6] target/mips: Fix PageMask with variable page size
Date: Fri, 30 Oct 2020 18:25:36 +0800
Message-Id: <1604053541-27822-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1604053541-27822-1-git-send-email-chenhc@lemote.com>
References: <1604053541-27822-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Our current code assumed the target page size is always 4k
when handling PageMask and VPN2, however, variable page size
was just added to mips target and that's no longer true.

Fixes: ee3863b9d414 ("target/mips: Support variable page size")
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 target/mips/cp0_helper.c | 36 +++++++++++++++++++++++++++++-------
 target/mips/cpu.h        |  1 +
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
index 12143ac..d90ddd9 100644
--- a/target/mips/cp0_helper.c
+++ b/target/mips/cp0_helper.c
@@ -892,13 +892,31 @@ void helper_mtc0_memorymapid(CPUMIPSState *env, target_ulong arg1)
 
 void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pagemask)
 {
-    uint64_t mask = arg1 >> (TARGET_PAGE_BITS + 1);
-    if (!(env->insn_flags & ISA_MIPS32R6) || (arg1 == ~0) ||
-        (mask == 0x0000 || mask == 0x0003 || mask == 0x000F ||
-         mask == 0x003F || mask == 0x00FF || mask == 0x03FF ||
-         mask == 0x0FFF || mask == 0x3FFF || mask == 0xFFFF)) {
-        env->CP0_PageMask = arg1 & (0x1FFFFFFF & (TARGET_PAGE_MASK << 1));
+    unsigned long mask;
+    int maskbits;
+
+    if (env->insn_flags & ISA_MIPS32R6) {
+        return;
+    }
+    /* Don't care MASKX as we don't support 1KB page */
+    mask = extract32((uint32_t)arg1, CP0PM_MASK, 16);
+    maskbits = find_first_zero_bit(&mask, 32);
+
+    /* Ensure no more set bit after first zero */
+    if (mask >> maskbits) {
+        goto invalid;
+    }
+    /* We don't support VTLB entry smaller than target page */
+    if ((maskbits + 12) < TARGET_PAGE_BITS) {
+        goto invalid;
     }
+    env->CP0_PageMask = mask << CP0PM_MASK;
+
+    return;
+
+invalid:
+    /* When invalid, set to default target page size. */
+    env->CP0_PageMask = (~TARGET_PAGE_MASK >> 12) << CP0PM_MASK;
 }
 
 void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index d41579d..23f8c6f 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -619,6 +619,7 @@ struct CPUMIPSState {
  * CP0 Register 5
  */
     int32_t CP0_PageMask;
+#define CP0PM_MASK 13
     int32_t CP0_PageGrain_rw_bitmask;
     int32_t CP0_PageGrain;
 #define CP0PG_RIE 31
-- 
2.7.0


