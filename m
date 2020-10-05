Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA323C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B73F20853
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="NSIREmTx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B73F20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPX1X-0000YK-3b
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 16:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kPWaH-0004y7-TG; Mon, 05 Oct 2020 15:55:45 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:35982)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kPWaG-0007ZX-14; Mon, 05 Oct 2020 15:55:45 -0400
Received: from sekoia-pc.home.lmichel.fr (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id 006A1C60F1B;
 Mon,  5 Oct 2020 19:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1601927720;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sXZbbcIcfJa9fmuyQ/jkFubTz3/tLARdyvfrI2boCtg=;
 b=NSIREmTxom20lxgcpeVoX620QlQ+XM9XQnrLwl0sdMgU5dQOIYwd3QfInbt+Wv11H2VNjX
 r4OkHA/a9ZVi/QlmpCeptTF9iMyZEMoPqSV96mY5UcWeX8USz4cFX2SAX0mmUUjCWJZfi3
 sTfrvXnDMROEnkBFPXtW9SX6IgKosRcMKYUjExA2q+MXhIJxIBpEfWp0lufCWnSh5lDwtq
 TUQu28CyjPYGCE/JESCKTxqtsGvS0NZ3D5uzSfTmTQU8EAj5xB7EhQYH8l/JFHSAnyou78
 vE3T7Df5zf+ren8ROQjDXpoP1qa/S26/cy1xG2Fj8cUJ2Ix4e8sBsfEQGrqdlQ==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/15] hw/misc/bcm2835_cprman: implement clock mux behaviour
Date: Mon,  5 Oct 2020 21:56:08 +0200
Message-Id: <20201005195612.1999165-12-luc@lmichel.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005195612.1999165-1-luc@lmichel.fr>
References: <20201005195612.1999165-1-luc@lmichel.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1601927720;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sXZbbcIcfJa9fmuyQ/jkFubTz3/tLARdyvfrI2boCtg=;
 b=cuaktJghC3KIS8Q4gEWOvwQ7F8Ez/oG/QosnmU1raegC/jsWJyeRW9lSO54XmKL5oMJ7d8
 MkKLzdG1qClFzkTNCwPYAIiNehdIhwnlelSwCvIqz9ihU1TBPHL73ctKNb/T8Yy4vP9IZe
 unTM4vziHQ8M7T3UwUsjv0oEoaKGhQQbIi3TB/r1kPcW1cqcphmme/k3t8tEQJY0Rd7Lu1
 ONwE+zPGfHCtY4QlzH4yBYo4ZQ5Fb9ZNltkkiBY/ERwxmV2+ts8UyOTdW7ejktZq4PuYz6
 RxY9usIA+wp0VqYOzPmvZRIrJ+TY6cDY9zpW/LCjgIs5AjJNr213xVTt/sHUKg==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1601927720; a=rsa-sha256; cv=none;
 b=EeNOZrywYdSfvZajZ+tAE07XNrtZDue3TqKIMOmgUARksP12jX72OWOCj5759fuKT7DPYh/z67cw6zvhfguCSlSbVrtl8Ms7q1wMRiwPEX5FrxO0Tm3tC8Ij7oIhda7KVUgLiT4UAAjWL4Mv0laHSyYe5f4TzOTTdnv35PzrFdVsoxRCs4rm12hM43sp6+aifBWma6/t2BcVjGBih/Xt2aEjT32ogiV7zMHlXZ5veN06C/j0mpr3qtaR84luH5+4m0KCTcB0QSVJnBfdG7ychQ9eRiBStBgLN2XlW26cw25IFudOje3LhY72w/tYzQOs8VR/g81eJVdZ/GpvoBfoeQ==
ARC-Authentication-Results: i=1;
	pharaoh.lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 15:49:50
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Havard Skinnemoen <hskinnemoen@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A clock mux can be configured to select one of its 10 sources through
the CM_CTL register. It also embeds yet another clock divider, composed
of an integer part and a fractional part. The number of bits of each
part is mux dependent.

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Luc Michel <luc@lmichel.fr>
---
 hw/misc/bcm2835_cprman.c | 44 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index a470ce2026..7d59423367 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -229,19 +229,61 @@ static const TypeInfo cprman_pll_channel_info = {
 };
 
 
 /* clock mux */
 
+static bool clock_mux_is_enabled(CprmanClockMuxState *mux)
+{
+    return FIELD_EX32(*mux->reg_cm, CM_CLOCKx_CTL, ENABLE);
+}
+
 static void clock_mux_update(CprmanClockMuxState *mux)
 {
-    clock_update(mux->out, 0);
+    uint64_t freq;
+    uint32_t div, src = FIELD_EX32(*mux->reg_cm, CM_CLOCKx_CTL, SRC);
+    bool enabled = clock_mux_is_enabled(mux);
+
+    *mux->reg_cm = FIELD_DP32(*mux->reg_cm, CM_CLOCKx_CTL, BUSY, enabled);
+
+    if (!enabled) {
+        clock_update(mux->out, 0);
+        return;
+    }
+
+    freq = clock_get_hz(mux->srcs[src]);
+
+    if (mux->int_bits == 0 && mux->frac_bits == 0) {
+        clock_update_hz(mux->out, freq);
+        return;
+    }
+
+    /*
+     * The divider has an integer and a fractional part. The size of each part
+     * varies with the muxes (int_bits and frac_bits). Both parts are
+     * concatenated, with the integer part always starting at bit 12.
+     */
+    div = mux->reg_cm[1] >> (R_CM_CLOCKx_DIV_FRAC_LENGTH - mux->frac_bits);
+    div &= (1 << (mux->int_bits + mux->frac_bits)) - 1;
+
+    if (!div) {
+        clock_update(mux->out, 0);
+    }
+
+    freq = muldiv64(freq, 1 << mux->frac_bits, div);
+
+    clock_update_hz(mux->out, freq);
 }
 
 static void clock_mux_src_update(void *opaque)
 {
     CprmanClockMuxState **backref = opaque;
     CprmanClockMuxState *s = *backref;
+    CprmanClockMuxSource src = backref - s->backref;
+
+    if (FIELD_EX32(*s->reg_cm, CM_CLOCKx_CTL, SRC) != src) {
+        return;
+    }
 
     clock_mux_update(s);
 }
 
 static void clock_mux_init(Object *obj)
-- 
2.28.0


