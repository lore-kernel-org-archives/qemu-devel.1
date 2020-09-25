Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA2DC4727C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0AA421D91
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="bQh+xYff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0AA421D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLkpx-0004qa-Ne
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 06:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kLknJ-00015W-9T; Fri, 25 Sep 2020 06:17:37 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:58230)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kLknD-0007Ri-Si; Fri, 25 Sep 2020 06:17:36 -0400
Received: from sekoia-pc.bar.greensocs.com (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id 52DAEC60F1E;
 Fri, 25 Sep 2020 10:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1601029040;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FcBIzmQAZtEmj8qCZRpqLApGyCCP0+6Pwhqm+5t6clU=;
 b=bQh+xYffT7DzsX3tbkSjp6Whl4VXzh71EhhJjvDnZ6MR7F6aT/RYhphYo7IGk2Pq2ULAHf
 JW0GZkNLT8vn7SHIMVkTgvt8uoYAEC1i3jMGNHnWRWERguzHZCP2za1hmiG7F5PRf6Enxy
 2S3l+W82/8VM0XqihegViKe/i+BrCBCvo3D5jIRJEcXve6Cjf7kPurWAcfAd+ocestfSlS
 r/nLRimb7+c2aBJao2FQ7cxZO+OOiHGS4iDUOJQd71AoYoOPpdut5+hUy6CRmaAZtPhFmH
 iG8MdWHfFIW+D6B+bH9bDe5Q+o757jriRGk5nHL4NJ6mmkuJjzJC87i+mZlFag==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/14] hw/misc/bcm2835_cprman: implement PLLs behaviour
Date: Fri, 25 Sep 2020 12:17:23 +0200
Message-Id: <20200925101731.2159827-7-luc@lmichel.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925101731.2159827-1-luc@lmichel.fr>
References: <20200925101731.2159827-1-luc@lmichel.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1601029040;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FcBIzmQAZtEmj8qCZRpqLApGyCCP0+6Pwhqm+5t6clU=;
 b=MQQy2NJkSTrUBjcMLhmMkVPWGC+M8WLIuBYVh0TRq94RJXuTM+nS6TRFZtE3aei+DGlIP2
 kMzaFZCFGAwjTxcfnSfi0k8sjSut+UEqSD4mDRYU8IIiPmDlEVwpC+Ng8jHc94Q2HOAdJe
 shCbn5U8QjR+00WV74DoH8JY2DKaE+wTfDTCm2V/qdsMJJHW6h7eWzYdyuqOhnzMddLD/c
 phbm38Lz5aW+Tcd4zckcbwPDhlFBGUcz0I+gecJJB4Ev+ZymZgBg0Rj56oyDDVOwvLDft7
 VAnRw8CLgoXICY1amOn1NQAKo5BwKh46P1hdaU4LZ85/TU1WNyIsbnYjk21otw==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1601029040; a=rsa-sha256; cv=none;
 b=ABKocZKBspjBpwdV3Vm9KlcAHubFk7ylIe5IyrJMfKd3vcZtHDKswXM6H8en/v5MJ1hxMJP5czI3dOdYmH3C6r97LH8cSXhMobIqeder0oRDr84yohDb+iNJj9PBlOyqq+IL0dRA3UxzKEAof+1RexBGa+s5voi2gcDlMitr1gJozy+wivj/Qc/D5X7aAZALrbBQK0Mp2cYjAcRdTV8+jkepepBqyJHcMuD9ZdLwbVwOCe7HdREvEdaBM1JivNT6Egl7O/Vd5pqYg/2D87lQ6cxczJlvWiCRwtFZyd31Or+knCgV8kFuJGqGzICZCKvZl9qfmk2LNJ+UvMQTd4dkqw==
ARC-Authentication-Results: i=1;
	pharaoh.lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 06:17:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The cprman PLLs generate a clock based on a prescaler, a multiplier and
a divider. The prescaler doubles the parent (xosc) frequency, then the
multiplier/divider are applied. The multiplier has an integer and a
fractionnal part.

This commit also implements the cprman CM_LOCK register. This register
reports which PLL is currently locked. We consider a PLL has being
locked as soon as it is enabled (on real hardware, there is a delay
after turning a PLL on, for it to stabilise).

Signed-off-by: Luc Michel <luc@lmichel.fr>
---
 include/hw/misc/bcm2835_cprman_internals.h |  8 +++
 hw/misc/bcm2835_cprman.c                   | 64 +++++++++++++++++++++-
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/include/hw/misc/bcm2835_cprman_internals.h b/include/hw/misc/bcm2835_cprman_internals.h
index 5cfa849492..22a2500ab0 100644
--- a/include/hw/misc/bcm2835_cprman_internals.h
+++ b/include/hw/misc/bcm2835_cprman_internals.h
@@ -98,10 +98,18 @@ REG32(A2W_PLLA_FRAC, 0x1200)
 REG32(A2W_PLLC_FRAC, 0x1220)
 REG32(A2W_PLLD_FRAC, 0x1240)
 REG32(A2W_PLLH_FRAC, 0x1260)
 REG32(A2W_PLLB_FRAC, 0x12e0)
 
+/* misc registers */
+REG32(CM_LOCK, 0x114)
+    FIELD(CM_LOCK, FLOCKH, 12, 1)
+    FIELD(CM_LOCK, FLOCKD, 11, 1)
+    FIELD(CM_LOCK, FLOCKC, 10, 1)
+    FIELD(CM_LOCK, FLOCKB, 9, 1)
+    FIELD(CM_LOCK, FLOCKA, 8, 1)
+
 /*
  * This field is common to all registers. Each register write value must match
  * the CPRMAN_PASSWORD magic value in its 8 MSB.
  */
 FIELD(CPRMAN, PASSWORD, 24, 8)
diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index ad71d30a86..ba82522eb1 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -48,13 +48,51 @@
 #include "hw/misc/bcm2835_cprman_internals.h"
 #include "trace.h"
 
 /* PLL */
 
+static bool pll_is_locked(const CprmanPLLState *pll)
+{
+    return !FIELD_EX32(*pll->reg_a2w_ctrl, A2W_PLLx_CTRL, PWRDN)
+        && !FIELD_EX32(*pll->reg_cm, CM_PLLx, ANARST);
+}
+
 static void pll_update(CprmanPLLState *pll)
 {
-    clock_update(pll->out, 0);
+    uint64_t freq, ndiv, fdiv, pdiv;
+
+    if (!pll_is_locked(pll)) {
+        clock_update(pll->out, 0);
+        return;
+    }
+
+    pdiv = FIELD_EX32(*pll->reg_a2w_ctrl, A2W_PLLx_CTRL, PDIV);
+
+    if (!pdiv) {
+        clock_update(pll->out, 0);
+        return;
+    }
+
+    ndiv = FIELD_EX32(*pll->reg_a2w_ctrl, A2W_PLLx_CTRL, NDIV);
+    fdiv = FIELD_EX32(*pll->reg_a2w_frac, A2W_PLLx_FRAC, FRAC);
+
+    if (pll->reg_a2w_ana[1] & pll->prediv_mask) {
+        /* The prescaler doubles the parent frequency */
+        ndiv *= 2;
+        fdiv *= 2;
+    }
+
+    /*
+     * We have a multiplier with an integer part (ndiv) and a fractional part
+     * (fdiv), and a divider (pdiv).
+     */
+    freq = clock_get_hz(pll->xosc_in) *
+        ((ndiv << R_A2W_PLLx_FRAC_FRAC_LENGTH) + fdiv);
+    freq /= pdiv;
+    freq >>= R_A2W_PLLx_FRAC_FRAC_LENGTH;
+
+    clock_update_hz(pll->out, freq);
 }
 
 static void pll_xosc_update(void *opaque)
 {
     pll_update(CPRMAN_PLL(opaque));
@@ -94,18 +132,42 @@ static const TypeInfo cprman_pll_info = {
 };
 
 
 /* CPRMAN "top level" model */
 
+static uint32_t get_cm_lock(const BCM2835CprmanState *s)
+{
+    static const int CM_LOCK_MAPPING[] = {
+        [CPRMAN_PLLA] = R_CM_LOCK_FLOCKA_SHIFT,
+        [CPRMAN_PLLC] = R_CM_LOCK_FLOCKC_SHIFT,
+        [CPRMAN_PLLD] = R_CM_LOCK_FLOCKD_SHIFT,
+        [CPRMAN_PLLH] = R_CM_LOCK_FLOCKH_SHIFT,
+        [CPRMAN_PLLB] = R_CM_LOCK_FLOCKB_SHIFT,
+    };
+
+    uint32_t r = 0;
+    size_t i;
+
+    for (i = 0; i < CPRMAN_NUM_PLL; i++) {
+        r |= pll_is_locked(&s->plls[i]) << CM_LOCK_MAPPING[i];
+    }
+
+    return r;
+}
+
 static uint64_t cprman_read(void *opaque, hwaddr offset,
                                     unsigned size)
 {
     BCM2835CprmanState *s = CPRMAN(opaque);
     uint64_t r = 0;
     size_t idx = offset / sizeof(uint32_t);
 
     switch (idx) {
+    case R_CM_LOCK:
+        r = get_cm_lock(s);
+        break;
+
     default:
         r = s->regs[idx];
     }
 
     trace_bcm2835_cprman_read(offset, r);
-- 
2.28.0


