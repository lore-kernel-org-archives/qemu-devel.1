Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B0FC76195
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:44:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E922067C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FXrfPeEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E922067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1H5-0007TJ-Ll
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 09:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51835)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hn1FK-00089k-N2
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:42:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hn1FI-0006DK-Uk
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:42:26 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46350)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hn1FI-0006CL-O1
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:42:24 -0400
Received: by mail-wr1-x443.google.com with SMTP id z1so17123348wru.13
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=RbzdNTC0vW9Lf4ZRZ1X4p6Xxj5ih0UlUuNAgV7FoLIU=;
 b=FXrfPeEpNgg3OKHKq5K0dTwaVYN06LJ2be1JoD3H6ymf09RbfoSkIAF4SjS/ohrvTT
 dhVWtwFtLUHfzGPorgU+o37FDXuZ3s/9j0jadvl7+h4cj/0MIl+137i7+dOf/czPLr7C
 zMtDoR3tiN6W9nBBcdRJsD2uzR7XdXWvFieC1jVvNm8dcRXR2WJIeuS94UB2siYq4dEm
 VpeJUfnbGJI6lTDgHukYpMk2sgV3w6JGnyxvSjD9zupzT3KfaEiQQo6y0PGwVBrvo/Y0
 wkulsYpFgKbb71IWLt2pym8JnavCXK4AnKtoo6SIzI4AnCrdNntcHeMTPoZ5DVo0SaTC
 uPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RbzdNTC0vW9Lf4ZRZ1X4p6Xxj5ih0UlUuNAgV7FoLIU=;
 b=MIaK1AFPGjykyBqYp00J2z6LIrLlWPYdIwwqRuTE41trB6TcntoYGS9e5YVFY6o4Jw
 sqmKLyCbLlu77iUiLSQ4uyvBy2foNf9d5l1ACZnu4KsdVv53J3JsaS2yEiBaVqiTr9Da
 5W7durcN0wKDduy1LV1gSkiCytwcV3B5DVsp4nSQQj3+uVh2BU5Mrga8dmQ04lJRFPii
 t7uPJOtkOpfEPYxuFGX0eeqgAVJgJWB/KfRKH6Neuz7/pmkKRTXJRZhy89lapa0zowqR
 MS4ErMuHEKHnkXhZyhMtfn1RTV4Alw3ff82Phfdv3U7HmZNAlLqO8BuGTCb8T154o9+Q
 j/MA==
X-Gm-Message-State: APjAAAXyotQW0FmXSYyB+TpJorS9pVlAPZYIM7U3mrYHhyeVAn3ru91e
 /gJh2lJl/KfBHReZIZD/wwRSnls8KpQSNg==
X-Google-Smtp-Source: APXvYqwswnLhQSGrKgjkrZ1xrsv24Pw//8wKuAgIoxJEVedlAogpgFp74xRzb5djqivsNpg/HgPQqQ==
X-Received: by 2002:a5d:6b07:: with SMTP id v7mr29455852wrw.169.1563198142518; 
 Mon, 15 Jul 2019 06:42:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c7sm14221808wro.70.2019.07.15.06.42.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 15 Jul 2019 06:42:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 14:42:11 +0100
Message-Id: <20190715134211.23063-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134211.23063-1-peter.maydell@linaro.org>
References: <20190715134211.23063-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PULL 10/10] target/arm: NS BusFault on vector table
 fetch escalates to NS HardFault
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
Message-id: 20190705094823.28905-1-peter.maydell@linaro.org
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


