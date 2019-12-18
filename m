Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCFAC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E1A2072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFY8pY0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E1A2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihgWq-000401-KT
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 16:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ihgUa-0001rF-Pr
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:04:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ihgUX-0000v7-2Y
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:04:22 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34429)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ihgUV-0000tz-5O
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:04:20 -0500
Received: by mail-wr1-x442.google.com with SMTP id t2so3810240wrr.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 13:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=iwbDw77M05X4ILw3CJVyKfJZVf46CVzdXEm5un6HUYk=;
 b=AFY8pY0kXTn7ywG24ZX3bnFKca+JBt7dBKMb/qcDMGVx30+/9/517pkEUBdCePnl/l
 RRdxnqsSvu3P1N2d0U+bQa1KADv9UEHqiSzl4Zb3xsc+nlW1DJ6Row6PHpzYxg5prVCL
 HduDOWCdkDcedEDxtYHgKbsMr0IAuhUzadWNFDbypuEc61/wvdVPNOrZau4JdasUHZuj
 w1GKdZcoqCFHYL6w73TqU/2SL6ySkmAsos1TgJAvpLGCBbwX37MMK/tZBjqWV9XVAAkY
 ren7OTIMKMTxKVytIpafIPwd3nPcQQLt60KfWiF8+egstsfmMLcpDXJ7e1ryNT6zH6va
 pMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=iwbDw77M05X4ILw3CJVyKfJZVf46CVzdXEm5un6HUYk=;
 b=pWLkR5+NIdrVzPfBMBVZmnp/MgF6yFrFCiSxE0NIZR4d/nsJwTpnwLwuxYIYg2T90V
 iDYYixrDJwjtGvzqOGBtjt80Z1mlWoRQr4MceYdXC2oj754+Wvim5J7uUKXgLERO1PtU
 e7SSKmNW1+2qqt+FyOMMO50O9/mR0KK642axRAzjqlutw+wMs2S1qteHrwNiRnFgvdJg
 nMCyTI/R/xa7CJctgWyShAXKCB0EEGZYmS1aiLJQ6PCZhT9c7LW9ZhoQ3VjN50ANcKhy
 5qhnteDFJbBeC6tQ73rP3pIOw0Hrls9QFaXfc7xYLiQc8+dsa9yHbFXTe9gylLoAbVhl
 AEkw==
X-Gm-Message-State: APjAAAX3tL2YvcG50rm2VSvdPuviCs/V1R2dKAlJtHaswSfe9dBcWmGi
 4Vr6tThPnnKrGWKr/BMfK0xmCJJgyiXvGA==
X-Google-Smtp-Source: APXvYqz1+vX0wusvqDGP3pNhHULcgxrzL4DSduGpgyg6lpCHJ6KAAlnKjyrSW/TQUMLAVx6Kv5k+5A==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr4968136wrm.210.1576703056921; 
 Wed, 18 Dec 2019 13:04:16 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-109-65-2-109.red.bezeqint.net. [109.65.2.109])
 by smtp.gmail.com with ESMTPSA id a133sm3808933wme.29.2019.12.18.13.04.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 18 Dec 2019 13:04:16 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v39 09/22] target/avr: Add instruction translation - MCU
 Control Instructions
Date: Wed, 18 Dec 2019 23:03:16 +0200
Message-Id: <20191218210329.1960-10-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191218210329.1960-1-mrolnik@gmail.com>
References: <20191218210329.1960-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 me@xcancerberox.com.ar, richard.henderson@linaro.org, dovgaluk@ispras.ru,
 imammedo@redhat.com, philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This includes:
    - BREAK
    - NOP
    - SLEEP
    - WDR

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
---
 target/avr/translate.c | 68 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index e303a1f4cc..46cbcc9305 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2606,3 +2606,71 @@ static bool trans_BCLR(DisasContext *ctx, arg_BCLR *a)
 
     return true;
 }
+
+/*
+ * MCU Control Instructions
+ */
+
+/*
+ *  The BREAK instruction is used by the On-chip Debug system, and is
+ *  normally not used in the application software. When the BREAK instruction is
+ *  executed, the AVR CPU is set in the Stopped Mode. This gives the On-chip
+ *  Debugger access to internal resources.  If any Lock bits are set, or either
+ *  the JTAGEN or OCDEN Fuses are unprogrammed, the CPU will treat the BREAK
+ *  instruction as a NOP and will not enter the Stopped mode.  This instruction
+ *  is not available in all devices. Refer to the device specific instruction
+ *  set summary.
+ */
+static bool trans_BREAK(DisasContext *ctx, arg_BREAK *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_BREAK)) {
+        return true;
+    }
+
+#ifdef BREAKPOINT_ON_BREAK
+    tcg_gen_movi_tl(cpu_pc, ctx->npc - 1);
+    gen_helper_debug(cpu_env);
+    ctx->bstate = DISAS_EXIT;
+#else
+    /* NOP */
+#endif
+
+    return true;
+}
+
+
+/*
+ *  This instruction performs a single cycle No Operation.
+ */
+static bool trans_NOP(DisasContext *ctx, arg_NOP *a)
+{
+
+    /* NOP */
+
+    return true;
+}
+
+
+/*
+ *  This instruction sets the circuit in sleep mode defined by the MCU
+ *  Control Register.
+ */
+static bool trans_SLEEP(DisasContext *ctx, arg_SLEEP *a)
+{
+    gen_helper_sleep(cpu_env);
+    ctx->bstate = DISAS_NORETURN;
+    return true;
+}
+
+
+/*
+ *  This instruction resets the Watchdog Timer. This instruction must be
+ *  executed within a limited time given by the WD prescaler. See the Watchdog
+ *  Timer hardware specification.
+ */
+static bool trans_WDR(DisasContext *ctx, arg_WDR *a)
+{
+    gen_helper_wdr(cpu_env);
+
+    return true;
+}
-- 
2.17.2 (Apple Git-113)


