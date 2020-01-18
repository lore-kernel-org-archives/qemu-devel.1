Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B119CC32771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:27:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7213D24679
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvdph8/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7213D24679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1istkv-0005NU-6k
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 14:27:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1istdk-0004Ks-GH
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1istdj-0006Fq-4x
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:20:12 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34106)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1istdi-0006Dm-VA
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:20:11 -0500
Received: by mail-wr1-x443.google.com with SMTP id t2so25742136wrr.1
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 11:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CeCJIWj7KEsbYgi+WRu8j/SFE70+Y+4bb7FIq+Fj++s=;
 b=gvdph8/6CB7tTUmABDfI0RjsCMG37bjnGz3rwyKw1W+w3mDD56nAQmOEZN5jSrIAPj
 xE6LogXs8tyffxrek24+k9QtYg5AD4RBCz4SdHmqPh6Lp6Nz8IyjZVQWXsPgIMzDFeV6
 3Q7t5ScyIdIvrpLNnxlGOf0SF61hgxva+IZtAGdNopKPSrxWqyhyJmTeWJ/Itlznv7cV
 XSkQSnsdXnhTpCP/WQfyTDWqXM47DEXTpi/NZN7aXYo5Fo3/gLRXoI/yjYc9OcW4BZQ5
 M86v8KJqphXw49za2YLTfohlzjxZgrKBe2gWoio6ikzBJdeN4wwju3tFPuh400Tc/rNj
 AIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=CeCJIWj7KEsbYgi+WRu8j/SFE70+Y+4bb7FIq+Fj++s=;
 b=o1PwXuIltN683U67BRehRL+mAbmHthQs0bRcF+PRkeMDZepfzI8J47X6qtc2uOvz6m
 H+FtVDHHXlisN5ehqjfv+GNvCAHSiaflSQTnBiE6MP2d2JwoXLAAYiGEat7z1/NNzBQC
 YBIWr5RLgWclt8v5dUHrPXYwGrcRmPjsDxLTiXh2UsPav4NCbckAhrdPKjPPn0JsjNqk
 02KrUPKnKCMNVKFPx0QN/66vZmnAyWk6VBdwcY8Zv6vVdMg/jjlWNtLfdUyejjfKBqSV
 cVr6u58NSTGwH4UxzbXo5LO/qGcSORJwL38l05yj3cdlmXMhJLer3Ll3h5ODL2Pl49j3
 3LRA==
X-Gm-Message-State: APjAAAXXw+nDwDrVhiQ5Safi+1iNoLNrUKMjL9ogQDTAShGoLjxO9Rss
 l+i0bw7tFJO8VPFTVjzea6g3sxXSD7YyBYgB
X-Google-Smtp-Source: APXvYqxZV4ciit8T30CCoHZjmYWHZUER8dFKWpM6SUHv0nG+UCCB9jaWrXBDqJJpOpPsL+tgKRXWhw==
X-Received: by 2002:adf:e6d2:: with SMTP id y18mr9769815wrm.262.1579375209751; 
 Sat, 18 Jan 2020 11:20:09 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-109-65-108-13.red.bezeqint.net. [109.65.108.13])
 by smtp.gmail.com with ESMTPSA id o16sm2875468wmc.18.2020.01.18.11.20.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 18 Jan 2020 11:20:09 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v41 08/21] target/avr: Add instruction translation - MCU
 Control Instructions
Date: Sat, 18 Jan 2020 21:14:03 +0200
Message-Id: <20200118191416.19934-9-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20200118191416.19934-1-mrolnik@gmail.com>
References: <20200118191416.19934-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 target/avr/insn.decode |  9 ++++++
 2 files changed, 77 insertions(+)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index 58775af17c..4c680070e2 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2681,3 +2681,71 @@ static bool trans_BCLR(DisasContext *ctx, arg_BCLR *a)
 
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
diff --git a/target/avr/insn.decode b/target/avr/insn.decode
index 4ee55862b2..0e4ec9ddf0 100644
--- a/target/avr/insn.decode
+++ b/target/avr/insn.decode
@@ -172,3 +172,12 @@ BST             1111 101 rd:5 0 bit:3
 BLD             1111 100 rd:5 0 bit:3
 BSET            1001 0100 0 bit:3 1000
 BCLR            1001 0100 1 bit:3 1000
+
+#
+# MCU Control Instructions
+#
+BREAK           1001 0101 1001 1000
+NOP             0000 0000 0000 0000
+SLEEP           1001 0101 1000 1000
+WDR             1001 0101 1010 1000
+
-- 
2.17.2 (Apple Git-113)


