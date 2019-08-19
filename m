Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E8CC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD58214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aGlqZbDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD58214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzpue-0007KP-LW
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMo-0002gY-7h
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMn-0006nO-42
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:06 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36035)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpMm-0006mH-VK
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:05 -0400
Received: by mail-pf1-x442.google.com with SMTP id w2so1951547pfi.3
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QRvE4bPnAygv+cSuTTykDcVWK0tGfB+nP3/t4TESwEQ=;
 b=aGlqZbDFxybV4P2d9J24RQQdDpkbqfnLL4iI4CN+Fq7lduLYhOpmGM3DQbHzICYjSY
 3BjzaGj0ObmBarpaF03V8Xq0xnlZj0nk4YtqMqFL2a+X1bBVFz/Np4YFZ24v3plrCb+4
 yYrRwbhBopexLLggm+tk778AIAnD2Kgpn8ImVaulgnxhigCuIo0aZAI55zikfh5+qPhq
 yFIw6u3F5DWdR0GcylBFl4ChPyUzy56+rb83rZBy3RTT905EkNVyP3X4PrBf4dAOnzs/
 6CjSZONx2L9mKDvE3gCYjfqQJmmCroGAQnbwoURPL/YppLDtuaBlmXu51zzAu9niL2ha
 kfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=QRvE4bPnAygv+cSuTTykDcVWK0tGfB+nP3/t4TESwEQ=;
 b=kZCDUCF3lh8KBpF5U4qAOc3SNNQ5gBg9jL+F+0RP8zMTFzgtWqiSpZwhlskU4zqN6o
 bxMkg6boCEKMBEIZ/fnAEwuLb+et8DGzgNQPesTynOfsAyOCtvC/sLbsbZbwKxtCo4Xa
 EI0EUifNMmhzo675bqCwwjOK8wcC+cBjrQxd+e1l6tThxrSPL+oC0NCo9CnfXaZI0UTn
 gWWi4y7TvbSVMQ4Ka8YCl6ijdznSIc1oMYgO7CCvUj8eqSMHfU9S+Y6dYwAinQ1PftVv
 w5Cjqb/wfakBbUrisMAXEzqwDoIHFGG+/jYhpBX6rpzSNK6cwV0rMRl6t9Wv9oaUAVvm
 dTQg==
X-Gm-Message-State: APjAAAVwJuVsjkScReC9+fA2ekYlphsYvFGhFkauGcJ6rQjqEnvJIbXx
 wo933MXkPe0Wp1yWuJi2SaZJl5nwvBs=
X-Google-Smtp-Source: APXvYqxXqVGsSYmi7NiO3kcOQmAHVCAY6Ly/VhXU5PvkVqEeCfunJL7k2eJAvlR1sT2g5OGBD+HYtQ==
X-Received: by 2002:a65:6458:: with SMTP id s24mr21623711pgv.158.1566250743538; 
 Mon, 19 Aug 2019 14:39:03 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:39:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:41 -0700
Message-Id: <20190819213755.26175-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v2 54/68] target/arm: Convert T16 adjust sp
 (immediate)
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 15 ++-------------
 target/arm/t16.decode  |  9 +++++++++
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index e639059a5a..cac3893386 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10640,19 +10640,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         /* misc */
         op = (insn >> 8) & 0xf;
         switch (op) {
-        case 0:
-            /*
-             * 0b1011_0000_xxxx_xxxx
-             *  - ADD (SP plus immediate)
-             *  - SUB (SP minus immediate)
-             */
-            tmp = load_reg(s, 13);
-            val = (insn & 0x7f) * 4;
-            if (insn & (1 << 7))
-                val = -(int32_t)val;
-            tcg_gen_addi_i32(tmp, tmp, val);
-            store_sp_checked(s, tmp);
-            break;
+        case 0: /* add/sub (sp, immediate), in decodetree */
+            goto illegal_op;
 
         case 2: /* sign/zero extend.  */
             ARCH(6);
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 5a570484e3..b425b86795 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -156,6 +156,15 @@ ADD_rrri        0100 0100 . .... ...            @addsub_2h s=0
 CMP_xrri        0100 0101 . .... ...            @addsub_2h s=1
 MOV_rxri        0100 0110 . .... ...            @addsub_2h s=0
 
+# Adjust SP (immediate)
+
+%imm7_0x4       0:7 !function=times_4
+@addsub_sp_i    .... .... . ....... \
+                &s_rri_rot s=0 rd=13 rn=13 rot=0 imm=%imm7_0x4
+
+ADD_rri         1011 0000 0 .......             @addsub_sp_i
+SUB_rri         1011 0000 1 .......             @addsub_sp_i
+
 # Branch and exchange
 
 @branchr        .... .... . rm:4 ...            &r
-- 
2.17.1


