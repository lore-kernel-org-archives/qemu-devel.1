Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D65C3A5AB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76DF22CED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lTWfIa2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76DF22CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cB8-00077t-Ej
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0s-0005TY-QD
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0r-00037a-21
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:18 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35004)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b0n-00033Q-7B
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:15 -0400
Received: by mail-pl1-x644.google.com with SMTP id gn20so12566plb.2
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RL68ZjIe5eYQCwpJOU1fJcxAoSZgrEZ6K/Zv64QpDaE=;
 b=lTWfIa2pWo2pbpDe4pKDm6+5ng3WPcvQoomnpn10Z5+lnjJSvGRsjZZLg7k3yIZQ8O
 uSEQeU8szEGbE2vnejP1A3nN0obosyYzhaUqazOMa4ty3TXXFBAH24Tk8NXy0BmHSqhp
 S74Ic3fKz5gXaDGfPEh94FZtDdL9oZjV2STV5YJGVcDpokqw463lUAI9WjqqeDVhe1Ii
 XNezTwdbDr98Mb+vAFSgu+QTgPvJyK0O2RSnjCC2sOC7EcQkvUnfk+9TZwKK/U0VPTzX
 trRrBujBNBtBWV0MIO4EQ7aQPrah0V6lH8yqYPqdRV0ceHDnXuPyGx0IPDkkDtocMJ8Y
 Wppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RL68ZjIe5eYQCwpJOU1fJcxAoSZgrEZ6K/Zv64QpDaE=;
 b=NMoQinaLZvg3erbnr7Z6nugGv0fScX9E6BjhmuLlYoHVulctp/Zpe/ley7C4ToTnX2
 WoaArBRh2x+vZWKXrc0FeJugZKb0wr0OAahos+spLG8gmfibd5TfmzEsY5zXQMLJtbur
 jXXmjmAwshYkWQjxmjDUd1sZH7RZqPs7xLow1M5Xc+nQaX3h3pLI5gDnK5Jr/CL9ZU4C
 ug2XyDh8EMUbInZ6m32P1SYz8Vj4sFjSKdmXjWKz2EhCrObgJLw4bJ/lA6VlKU6JdX95
 ML3Vu+JP1Qu4qrFb4hTwRBdsaC+kyzhZmzd2vulUIjpQcOYAaO8kCT+pcNHu14p1Udpg
 ZMAw==
X-Gm-Message-State: APjAAAXlsG9bGjirg3yG2O+AmrH6GRGlFi1QbIITkj6xBLmRs0PTFR/8
 4AXJshGVhju/OqsD4CikwJwFdRlO3CE=
X-Google-Smtp-Source: APXvYqx9SzLbM7rNnNEN1Li9ZRvI/ttiopHp++wr5doGmlC/SoAD2lJDqZuUtWOs4OYN42ilq8PJbw==
X-Received: by 2002:a17:902:6842:: with SMTP id
 f2mr43503402pln.39.1567625531017; 
 Wed, 04 Sep 2019 12:32:11 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:32:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:45 -0700
Message-Id: <20190904193059.26202-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v4 55/69] target/arm: Convert T16 adjust sp
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
index 73c8863134..8399a2c1f6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10765,19 +10765,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
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


