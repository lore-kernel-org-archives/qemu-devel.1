Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE204C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B62DC2189D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GKH+sTqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B62DC2189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i342t-0003S5-Bl
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Gp-0003wP-8w
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Gn-0000fR-Bd
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:14 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42557)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33Gm-0000cB-91
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:12 -0400
Received: by mail-pl1-x644.google.com with SMTP id y1so390059plp.9
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kPR1JZrIaEB+BsbI73Fszb6T54V+9F/FGo5zTSmXHS0=;
 b=GKH+sTqS1LkwzkoPmwBjTfcQjHuO5EnBQ47PEUjUG1h6Z5MeS06ilHdYA0dnouacph
 sDOSn8/+suzG2qxNGgc9XqtVFRvrk92bCQ/Dz7HgI0XSbdgbRp1AITAVTNdgJ9Jr/NuI
 wvStruOUnlRwK7D5MxVrF25hGaZsy47Z94U8KaxYSzM9ooSSksNLfBVpvDLe27Hlzwz1
 fbfgQbRm41QYm+CA3QHpMAzwIpno0UIUU9KM4crW1q1iBAfAfVA2HiSy0U61joiDFrh6
 jjYnnyFAA29umgEjl2K5VHXeNXmLIC958BJCO6mFqp+XW5CajfUQWvYTdRuaCuFIo/n4
 /gsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=kPR1JZrIaEB+BsbI73Fszb6T54V+9F/FGo5zTSmXHS0=;
 b=jlkjlCtPBcB8iL+MmDjk/ziC1cO0tQNp3y3uEICiH2oMjN250Tc3mzHp/JG1NJE5T8
 opmNwdNJYjL+oOKsXCzl8fBTBhdJQGkav3MH2f1OBT3amkUyAqO8dmrHDS5+cH+Wo5k/
 aoUti/4sx/9krNN4KhBziDMlqWuuqp+w/WCZojXftg+dqa+R02F5vS8Y5SpxQJ6/++He
 emvh7LO6JYpRzFxtrknDVwUp99gg978mngfjXQy93k0QL9z94VOTxmMrPgOFHzWxrup5
 Q5/xwJmCtZWZUn2HYeUPwnzXVZbiDfg2sCJ3YzSRmGPVUo0MjWq1NJnXmtf5OlbO3QJW
 HuGQ==
X-Gm-Message-State: APjAAAUDYn/V7sqeItQXdG33v/DOqwUmHEerMRAgbn7CLIW6WCyNCita
 phIT7GhbK8svkzisAmTRbjUmQyE1uSE=
X-Google-Smtp-Source: APXvYqxWwzzfjewnTUNP7SmCfTh4iy5koYhRV3+7mGAkkhJXdg3y+vJEWJrY9h+DamyTxGxOoUEyVg==
X-Received: by 2002:a17:902:20e3:: with SMTP id
 v32mr5596520plg.142.1567019169701; 
 Wed, 28 Aug 2019 12:06:09 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:06:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:42 -0700
Message-Id: <20190828190456.30315-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v3 55/69] target/arm: Convert T16 adjust sp
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 15 ++-------------
 target/arm/t16.decode  |  9 +++++++++
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index cf19f1f777..b7e2c72f35 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10742,19 +10742,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
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


