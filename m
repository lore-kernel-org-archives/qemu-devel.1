Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD72C35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:15:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9957A2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s5GZtK5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9957A2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j589A-0002j7-Mr
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:15:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582E-0006iZ-7P
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582A-0002bU-Ck
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:02 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:33353)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582A-0002a9-60
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:07:58 -0500
Received: by mail-wm1-x333.google.com with SMTP id m10so5157548wmc.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=w1YmYCcAKRBV1EX92vhM6AptB/gtkq7KXvJqv02+0/4=;
 b=s5GZtK5q4skwH/fcsDQhTuvnjwKdeuabFxbjd0n7oJvtEdGRKVJW8dN7u3nv8vMMlk
 hYdcwO10xhNPNpJmM8OTb8oh1N4k8Y62gIK7AeGs5h4JZN+z0WrQ/u0MYEBek9QyZkEn
 XHCGRPT63yec2F/RliFJP0XR5N75NTKptR3Convnqfn/DKEoPfG1YuwJhi7WpXK3tXFS
 USRSr12yz0m/bsUDmgCBBq2/RZ0gxivCwC0yg1hp0UIJafRXMbgOF/dGYnOFnIuZYP+9
 LAOBGoqImMpETsf1nk/WtqW5S4xJ/8oDr19svsEuBgpbbCkCcTaZxCvWBkv0aa77HeEY
 mmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w1YmYCcAKRBV1EX92vhM6AptB/gtkq7KXvJqv02+0/4=;
 b=cIuzNj9voNX7zIuGNkEjTK9wVuZPR872ZK+CxBXRN23FvbhSHIfDqusV3uF09EnsFW
 FqhLMdOlZv0/xItaOGmLL+wGjJN4FsCa9hvEVMeA8Lyl/195ljaNpRjMdkX4ETWhTw6w
 7ZCSlPWqrZ+Ewp5IZdwHpDtkz2tcQdj3afS6v8h3AkJ8cZhTov9/MRyoMjVUhm1dZcx8
 tZqJn53eWVrVKE6lTpLb+zwyrUpKxLNltsIatkai/ppn2/QOAiEkQk25FKs17R/I//pA
 3Bbfz18ZPHf4Yf/Ei5dkXRiChvu+XnkD4hRpa+y5nb+y6iTVAHyKtYd45UleNlLsnEZ3
 7ztg==
X-Gm-Message-State: APjAAAV3a6uvY+a7v7LBwzmdrNA4FpeP4HGap8LHXt7Fg2p4qtb7T0Cf
 D6ugWbV0hM5ERVqX6z72KcVclcrVt5Eopw==
X-Google-Smtp-Source: APXvYqyYxMNFn8RarhmAthdqVSRsbGbrPw8/vBDz3qQi+24Rcv3IKiMgPki5R05U1UA5iAgY13NpIg==
X-Received: by 2002:a1c:5f41:: with SMTP id t62mr3922182wmb.42.1582290476756; 
 Fri, 21 Feb 2020 05:07:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.07.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:07:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/52] target/arm: Remove ttbr1_valid check from
 get_phys_addr_lpae
Date: Fri, 21 Feb 2020 13:07:00 +0000
Message-Id: <20200221130740.7583-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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

From: Richard Henderson <richard.henderson@linaro.org>

Now that aa64_va_parameters_both sets select based on the number
of ranges in the regime, the ttbr1_valid check is redundant.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200216194343.21331-4-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b09a5012841..eec7b01ab35 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10390,7 +10390,6 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     TCR *tcr = regime_tcr(env, mmu_idx);
     int ap, ns, xn, pxn;
     uint32_t el = regime_el(env, mmu_idx);
-    bool ttbr1_valid;
     uint64_t descaddrmask;
     bool aarch64 = arm_el_is_aa64(env, el);
     bool guarded = false;
@@ -10405,14 +10404,11 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         param = aa64_va_parameters(env, address, mmu_idx,
                                    access_type != MMU_INST_FETCH);
         level = 0;
-        ttbr1_valid = regime_has_2_ranges(mmu_idx);
         addrsize = 64 - 8 * param.tbi;
         inputsize = 64 - param.tsz;
     } else {
         param = aa32_va_parameters(env, address, mmu_idx);
         level = 1;
-        /* There is no TTBR1 for EL2 */
-        ttbr1_valid = (el != 2);
         addrsize = (mmu_idx == ARMMMUIdx_Stage2 ? 40 : 32);
         inputsize = addrsize - param.tsz;
     }
@@ -10429,7 +10425,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     if (inputsize < addrsize) {
         target_ulong top_bits = sextract64(address, inputsize,
                                            addrsize - inputsize);
-        if (-top_bits != param.select || (param.select && !ttbr1_valid)) {
+        if (-top_bits != param.select) {
             /* The gap between the two regions is a Translation fault */
             fault_type = ARMFault_Translation;
             goto do_fault;
-- 
2.20.1


