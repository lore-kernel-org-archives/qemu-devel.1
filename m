Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9596C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:08:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ABD5206F5
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E3c4FUrb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABD5206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIxtR-0002ML-G2
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 13:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jIxsH-0000FF-3a
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jIxsF-0001mk-RM
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:06:56 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56062)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jIxsF-0001i8-HJ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:06:55 -0400
Received: by mail-wm1-x343.google.com with SMTP id r16so2923744wmg.5
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 10:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mfnVD714sPEUmYFC+jPaoOlpvFWNuI8yQfnoLWvtCfw=;
 b=E3c4FUrbBuI/MXLpgfCXVYWmmmqP4DHNhJccTqwnbuMpX66Iyv04l77kxirnKAKQCc
 3aD6Nh9UfpHb+dKVylZVbCd5hQ3FIr8VIpzlLRpCEwr72VwcPy7BPGrJBK5TDerhrM/T
 WrT1Ld/3EkIIinONtTtYRRerITgO7Z+fuGW/c6k7kyOWQOhWemAplSPPS98V7NDcz330
 EFRjOTLLR9L6hf10L9gYXftEXnXKnM8XMBq8ok1MEm0NLipSGXxEDG+CgakYd/gNPtPQ
 4I4pL5FzCHxLJf+9lJcAqOG82YJmJ2uldsQ083UuOEOV++wiqAjoIBGFn1f+3scOcsVe
 0YYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mfnVD714sPEUmYFC+jPaoOlpvFWNuI8yQfnoLWvtCfw=;
 b=piPZZf8aE1j5ccXAXzp4Q+ymE6ckaR5lcZXAMmRisiukSNNkC5umEyjN+ChoV7GOc5
 vVprW5AHHx+Ig5HGADmt+VtJFGgQlBeXdQUmKW/+O/RxfkC2I1yvHdRfedn7E1CGTJwZ
 YTsDHKTaG/2yYhyKb4PJ7Ex1BuVNEbOq531YgxBH2CV6FTrnII5BOJfjfl+QKK6BxRSY
 +Wc+YcreRyYDyf1fUi8/lDMpe9RUXVZW5yUMZ9LWYpBsdaJFKCMxBjgZm26lzALMey1D
 mYys9otFpPbyQ4G8hj2VyZQJweiHXcj3FNdd+KbW2rvI5tc35Q8dmX5bP8vCxhaSFXi7
 bscw==
X-Gm-Message-State: ANhLgQ3/VgO9Vx/KzHOyMrPLxytA4SIx/LDF7WO5EmnmxslONxaCxeR3
 MGKJaClIMJBjQHOE2c80gEsrOw==
X-Google-Smtp-Source: ADFU+vtLyKOtAmUvXrJIhySVfmda1r2Fq5UxyNY89KoYDpfVO5sP6wlNgHdVxURDm5AVJXL8cK5tiA==
X-Received: by 2002:a1c:9658:: with SMTP id y85mr245194wmd.63.1585588013996;
 Mon, 30 Mar 2020 10:06:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 61sm24550033wrn.82.2020.03.30.10.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 10:06:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-5.0] target/arm: PSTATE.PAN should not clear exec bits
Date: Mon, 30 Mar 2020 18:06:51 +0100
Message-Id: <20200330170651.20901-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Our implementation of the PSTATE.PAN bit incorrectly cleared all
access permission bits for privileged access to memory which is
user-accessible.  It should only affect the privileged read and write
permissions; execute permission is dealt with via XN/PXN instead.

Fixes: 81636b70c226dc27d7ebc8d
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Compare the pseudocode AArch64.CheckPermission().
---
 target/arm/helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 163c91a1ccd..ed7eb8ab54e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10025,9 +10025,11 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
         prot_rw = user_rw;
     } else {
         if (user_rw && regime_is_pan(env, mmu_idx)) {
-            return 0;
+            /* PAN forbids data accesses but doesn't affect insn fetch */
+            prot_rw = 0;
+        } else {
+            prot_rw = simple_ap_to_rw_prot_is_user(ap, false);
         }
-        prot_rw = simple_ap_to_rw_prot_is_user(ap, false);
     }
 
     if (ns && arm_is_secure(env) && (env->cp15.scr_el3 & SCR_SIF)) {
-- 
2.20.1


