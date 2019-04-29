Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB1DC004C9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 731062147A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JyNEaW5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731062147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60903 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL9zA-0005dO-JH
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:22:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eo-0004pl-9r
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9em-0006jI-R6
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:34 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:38459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9ej-0006Vi-F4
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:30 -0400
Received: by mail-wm1-x32f.google.com with SMTP id w15so170689wmc.3
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=wfZGjZjpdLCjdXEeesmFo4Ry2RVknHweQyO88Vd/F6I=;
	b=JyNEaW5i6k6vLDovHLir1Bw4x8hXLDVsGq30R1yzxG+BoRcCcjgEMjal4hew92jufi
	aXfYvaGGu6g105YSqJJavyrfdm6/QkKUX195FXcBIeqxQgyPkOpxkHnVxNmTsfn5tLpU
	8y3VcWsHcpb9yqjIlOAJDwmOzeZbqCJuRBo4QqRgqQfPG86RW02oN9dowfF++xOFZoAX
	A1Brhe6ZrV9I8iWvwMZQeLen6jfS6ZRJZWwKfwSoVD9fKqzItcHmN7yckN8SjqP/IpLU
	nK4IWJT6qQ8My6/1e7vOP2y2EZG2QHPlGqmSjqM97Gcut/C2a1jA1plr0EoiSz+Ll4f/
	RkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=wfZGjZjpdLCjdXEeesmFo4Ry2RVknHweQyO88Vd/F6I=;
	b=FkXDNbSCwycZELRlEIWxXACIS/AW+ANKPCYIt7nCQrBlXCcXYKA6DmZq9ktmA1OxQ/
	TXckgCJZ1Lh0QaVn4hd3oV3f6GZcV4Jh4HZ+QuqEEIuSjccpScjZfVl+LQTM+Pip75Fu
	GdqF2fXLEAkQXnUPfRprpwlQwxwkGgqLodQYTyfve7Kn+6rAYDVmkI1SywtQrDFhUKkc
	WdHoLBUjaCRSWxn6o7TnMCyZs5Wb3u7XwO2BfLN/LCnogvnOGnirEl7wuS/iS/yuQW3e
	dw0b9fXDEZSbR1IHkFDogWFyU6EDvj19X3WM/7WYrt8EWVNRT5d0yipSfoiu1elvfkEc
	zACw==
X-Gm-Message-State: APjAAAXlLY1JqAmWdHjhT+S1HbLAjrsQSkMvQjE5KXtAkxin7ZNhhuRB
	sSi+xE3QAJEUauInFhLgDCSVGN9oGTE=
X-Google-Smtp-Source: APXvYqzoeCZT2XbD5LIetFWsCV9MmLA2GHpHv5d21zNWL4MHVgS788GRsO6A+DPj0T3H/G9ST8L/+Q==
X-Received: by 2002:a7b:cb04:: with SMTP id u4mr66761wmj.0.1556557263111;
	Mon, 29 Apr 2019 10:01:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.01.01
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:01:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 18:00:12 +0100
Message-Id: <20190429170030.11323-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32f
Subject: [Qemu-devel] [PULL 24/42] target/arm: New function
 armv7m_nvic_set_pending_lazyfp()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190429170012.gRv0R5T70hJb5LjR9yQVKs1ZCEviSmc2fuv6HcRGnL4@z>

In the v7M architecture, if an exception is generated in the process
of doing the lazy stacking of FP registers, the handling of
possible escalation to HardFault is treated differently to the normal
approach: it works based on the saved information about exception
readiness that was stored in the FPCCR when the stack frame was
created. Provide a new function armv7m_nvic_set_pending_lazyfp()
which pends exceptions during lazy stacking, and implements
this logic.

This corresponds to the pseudocode TakePreserveFPException().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-22-peter.maydell@linaro.org
---
 target/arm/cpu.h      | 12 ++++++
 hw/intc/armv7m_nvic.c | 96 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 920cf367020..ed3069341d2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2008,6 +2008,18 @@ void armv7m_nvic_set_pending(void *opaque, int irq, bool secure);
  * a different exception).
  */
 void armv7m_nvic_set_pending_derived(void *opaque, int irq, bool secure);
+/**
+ * armv7m_nvic_set_pending_lazyfp: mark this lazy FP exception as pending
+ * @opaque: the NVIC
+ * @irq: the exception number to mark pending
+ * @secure: false for non-banked exceptions or for the nonsecure
+ * version of a banked exception, true for the secure version of a banked
+ * exception.
+ *
+ * Similar to armv7m_nvic_set_pending(), but specifically for exceptions
+ * generated in the course of lazy stacking of FP registers.
+ */
+void armv7m_nvic_set_pending_lazyfp(void *opaque, int irq, bool secure);
 /**
  * armv7m_nvic_get_pending_irq_info: return highest priority pending
  *    exception, and whether it targets Secure state
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 53b4631dace..fff6e694e60 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -655,6 +655,102 @@ void armv7m_nvic_set_pending_derived(void *opaque, int irq, bool secure)
     do_armv7m_nvic_set_pending(opaque, irq, secure, true);
 }
 
+void armv7m_nvic_set_pending_lazyfp(void *opaque, int irq, bool secure)
+{
+    /*
+     * Pend an exception during lazy FP stacking. This differs
+     * from the usual exception pending because the logic for
+     * whether we should escalate depends on the saved context
+     * in the FPCCR register, not on the current state of the CPU/NVIC.
+     */
+    NVICState *s = (NVICState *)opaque;
+    bool banked = exc_is_banked(irq);
+    VecInfo *vec;
+    bool targets_secure;
+    bool escalate = false;
+    /*
+     * We will only look at bits in fpccr if this is a banked exception
+     * (in which case 'secure' tells us whether it is the S or NS version).
+     * All the bits for the non-banked exceptions are in fpccr_s.
+     */
+    uint32_t fpccr_s = s->cpu->env.v7m.fpccr[M_REG_S];
+    uint32_t fpccr = s->cpu->env.v7m.fpccr[secure];
+
+    assert(irq > ARMV7M_EXCP_RESET && irq < s->num_irq);
+    assert(!secure || banked);
+
+    vec = (banked && secure) ? &s->sec_vectors[irq] : &s->vectors[irq];
+
+    targets_secure = banked ? secure : exc_targets_secure(s, irq);
+
+    switch (irq) {
+    case ARMV7M_EXCP_DEBUG:
+        if (!(fpccr_s & R_V7M_FPCCR_MONRDY_MASK)) {
+            /* Ignore DebugMonitor exception */
+            return;
+        }
+        break;
+    case ARMV7M_EXCP_MEM:
+        escalate = !(fpccr & R_V7M_FPCCR_MMRDY_MASK);
+        break;
+    case ARMV7M_EXCP_USAGE:
+        escalate = !(fpccr & R_V7M_FPCCR_UFRDY_MASK);
+        break;
+    case ARMV7M_EXCP_BUS:
+        escalate = !(fpccr_s & R_V7M_FPCCR_BFRDY_MASK);
+        break;
+    case ARMV7M_EXCP_SECURE:
+        escalate = !(fpccr_s & R_V7M_FPCCR_SFRDY_MASK);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (escalate) {
+        /*
+         * Escalate to HardFault: faults that initially targeted Secure
+         * continue to do so, even if HF normally targets NonSecure.
+         */
+        irq = ARMV7M_EXCP_HARD;
+        if (arm_feature(&s->cpu->env, ARM_FEATURE_M_SECURITY) &&
+            (targets_secure ||
+             !(s->cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK))) {
+            vec = &s->sec_vectors[irq];
+        } else {
+            vec = &s->vectors[irq];
+        }
+    }
+
+    if (!vec->enabled ||
+        nvic_exec_prio(s) <= exc_group_prio(s, vec->prio, secure)) {
+        if (!(fpccr_s & R_V7M_FPCCR_HFRDY_MASK)) {
+            /*
+             * We want to escalate to HardFault but the context the
+             * FP state belongs to prevents the exception pre-empting.
+             */
+            cpu_abort(&s->cpu->parent_obj,
+                      "Lockup: can't escalate to HardFault during "
+                      "lazy FP register stacking\n");
+        }
+    }
+
+    if (escalate) {
+        s->cpu->env.v7m.hfsr |= R_V7M_HFSR_FORCED_MASK;
+    }
+    if (!vec->pending) {
+        vec->pending = 1;
+        /*
+         * We do not call nvic_irq_update(), because we know our caller
+         * is going to handle causing us to take the exception by
+         * raising EXCP_LAZYFP, so raising the IRQ line would be
+         * pointless extra work. We just need to recompute the
+         * priorities so that armv7m_nvic_can_take_pending_exception()
+         * returns the right answer.
+         */
+        nvic_recompute_state(s);
+    }
+}
+
 /* Make pending IRQ active.  */
 void armv7m_nvic_acknowledge_irq(void *opaque)
 {
-- 
2.20.1


