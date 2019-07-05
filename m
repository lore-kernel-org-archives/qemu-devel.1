Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5901BC5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 09:50:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2466E218C3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 09:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cnl+Xprr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2466E218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjKrV-0000zz-8q
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 05:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45247)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hjKpe-0008UA-KX
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 05:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hjKpS-0007gj-Io
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 05:48:34 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39418)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hjKpQ-0007dV-Cy
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 05:48:28 -0400
Received: by mail-wm1-x344.google.com with SMTP id z23so8675420wma.4
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 02:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DJgQt7YL6iWlivZMktmp+6RLn8cya2C11mFjRx5RqMo=;
 b=cnl+XprrN7uiZs+5WlwwepCMKFBSOxpjXOndEN3uA2itR5tJsJvqTvccm1+mvJeqh9
 kidp/NsCD9ebJ+jjH35wrDh5r+7LlZ8XPaDH0psZMwECud0zYnq1u265XuKGVDu+JL+D
 MtsOBeZUIplC1ncSHn+40YBq8fxeZVBaXAxeQRepo10i6oJIP3MpJ2CbbF21pTxCfNGq
 Zsz1Ieidq6+V+u+UYFsPh2eTIntvt8826grN2VEd4BSEo+qHO8QELdkoucT0UOKu7t9/
 m4qejkexxvBuoRt7XjF3TXvOj4k894xQaMguJ2MaRTOB/Kp+UbTu82vVNkSm/mewxZBk
 8MIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DJgQt7YL6iWlivZMktmp+6RLn8cya2C11mFjRx5RqMo=;
 b=mH87OManGtUIjZ/ceBHFze7WBnIUSluKK42ELniFqrL9Zz21ZfahkNv55XAISU/Sry
 KNPnf8BpZG0xeEKfL50+6nqE8fLqFr+7lLDoMB8pBCRKB/Bo+zIoCLC+RuyDs1eHSzYP
 1yETDdSVD0J4laONbJ5KrEa4nckFiRu9OKtLTMQqP8eLJQzlEWlGvWdC6y3hx+gql8Ob
 mGw8fwv5RftZTYDNpCux/p6vBMoC2lqLDKkNvaEH0HeOmRNLg53AlGC5sZMXXHhGZ/W4
 kAJQiE5MELfBvAYrrWZrDRS363HygFbVovg/vdYSH4Sfgvpa8iw4Y6UymmG+rl/923Dy
 zeWQ==
X-Gm-Message-State: APjAAAUE/1+4Ei6YYbqaWXMim2VSCA3MNRDglwr3nzjXNs/aNCy43XVq
 ybUKm6g92jNWSSxU8J5mD1sJopwY60VNFA==
X-Google-Smtp-Source: APXvYqzpFwGJXBkFpt9LxebrpEjjA5DiSwKuAkjwnYivx/0vrHzfuo5QyP+orRhGmOFmOct3++IElg==
X-Received: by 2002:a05:600c:114f:: with SMTP id
 z15mr2675364wmz.131.1562320106509; 
 Fri, 05 Jul 2019 02:48:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v204sm9430455wma.20.2019.07.05.02.48.24
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 05 Jul 2019 02:48:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 10:48:23 +0100
Message-Id: <20190705094823.28905-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v2 for-4.1] target/arm: NS BusFault on vector
 table fetch escalates to NS HardFault
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

In the M-profile architecture, when we do a vector table fetch and it
fails, we need to report a HardFault.  Whether this is a Secure HF or
a NonSecure HF depends on several things.  If AIRCR.BFHFNMINS is 0
then HF is always Secure, because there is no NonSecure HardFault.
Otherwise, the answer depends on whether the 'underlying exception'
(MemManage, BusFault, SecureFault) targets Secure or NonSecure.  (In
the pseudocode, this is handled in the Vector() function: the final
exc.isSecure is calculated by looking at the exc.isSecure from the
exception returned from the memory access, not the isSecure input
argument.)

We weren't doing this correctly, because we were looking at
the target security domain of the exception we were trying to
load the vector table entry for. This produces errors of two kinds:
 * a load from the NS vector table which hits the "NS access
   to S memory" SecureFault should end up as a Secure HardFault,
   but we were raising an NS HardFault
 * a load from the S vector table which causes a BusFault
   should raise an NS HardFault if BFHFNMINS == 1 (because
   in that case all BusFaults are NonSecure), but we were raising
   a Secure HardFault

Correct the logic.

We also fix a comment error where we claimed that we might
be escalating MemManage to HardFault, and forgot about SecureFault.
(Vector loads can never hit MPU access faults, because they're
always aligned and always use the default address map.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is the one remaining patch from my earlier 'minor M-profile
bugfixes' series; the rest are in master now.

Changes v1->v2:
 * rebased on master (function has moved to m_helper.c)
 * fixed logic bug pointed out by rth
---
 target/arm/m_helper.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/target/arm/m_helper.c b/target/arm/m_helper.c
index 1867435db7d..84609f446e6 100644
--- a/target/arm/m_helper.c
+++ b/target/arm/m_helper.c
@@ -624,7 +624,11 @@ static bool arm_v7m_load_vector(ARMCPU *cpu, int exc, bool targets_secure,
         if (sattrs.ns) {
             attrs.secure = false;
         } else if (!targets_secure) {
-            /* NS access to S memory */
+            /*
+             * NS access to S memory: the underlying exception which we escalate
+             * to HardFault is SecureFault, which always targets Secure.
+             */
+            exc_secure = true;
             goto load_fail;
         }
     }
@@ -632,6 +636,11 @@ static bool arm_v7m_load_vector(ARMCPU *cpu, int exc, bool targets_secure,
     vector_entry = address_space_ldl(arm_addressspace(cs, attrs), addr,
                                      attrs, &result);
     if (result != MEMTX_OK) {
+        /*
+         * Underlying exception is BusFault: its target security state
+         * depends on BFHFNMINS.
+         */
+        exc_secure = !(cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK);
         goto load_fail;
     }
     *pvec = vector_entry;
@@ -641,13 +650,17 @@ load_fail:
     /*
      * All vector table fetch fails are reported as HardFault, with
      * HFSR.VECTTBL and .FORCED set. (FORCED is set because
-     * technically the underlying exception is a MemManage or BusFault
+     * technically the underlying exception is a SecureFault or BusFault
      * that is escalated to HardFault.) This is a terminal exception,
      * so we will either take the HardFault immediately or else enter
      * lockup (the latter case is handled in armv7m_nvic_set_pending_derived()).
+     * The HardFault is Secure if BFHFNMINS is 0 (meaning that all HFs are
+     * secure); otherwise it targets the same security state as the
+     * underlying exception.
      */
-    exc_secure = targets_secure ||
-        !(cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK);
+    if (!(cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK)) {
+        exc_secure = true;
+    }
     env->v7m.hfsr |= R_V7M_HFSR_VECTTBL_MASK | R_V7M_HFSR_FORCED_MASK;
     armv7m_nvic_set_pending_derived(env->nvic, ARMV7M_EXCP_HARD, exc_secure);
     return false;
-- 
2.20.1


