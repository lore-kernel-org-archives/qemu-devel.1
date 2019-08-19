Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB94CC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:30:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A0122CE3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="irfuP3oR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A0122CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzqAQ-0006VH-SR
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpN2-000360-5Q
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpN1-0006z6-5K
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:20 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:37991)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpN1-0006ya-0D
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:19 -0400
Received: by mail-pf1-x42e.google.com with SMTP id o70so1949909pfg.5
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=F8Uj+UTtvG6sIw1y6R0jwFOyJpam+CLYahliKmILVI4=;
 b=irfuP3oRrcyd33uu9iKXwEpcdxetk2P0tjB0PoYBA546Oze5UHJwMuU/0t4BOy78aU
 vjNdc99u84aTm0H7+HVl/T6U8xmzkS6RaU9DH0N1qn8vqucC+t3Gthb886tdpXOxBZtU
 n6zW3vN2+hDzdY63rwXQu0SmeuFs6iAwRzB8t6vvPJi8T8r34M1JOx4/Fx20L0avAHGj
 8r14fbeXS1tNhIBLS0SL/CnMzDQeclXn7wqk2gsSvvE5sHsokxkRwiR+wGyeM1uEYN+J
 KFvTEOSNf/FjtzvZIuA03Gm30a+vihXvfc5uOQfkvbOAnZYDDTz5wfN79E/oUqv9A/5G
 J4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=F8Uj+UTtvG6sIw1y6R0jwFOyJpam+CLYahliKmILVI4=;
 b=SlTH0pxMnav/N7KegjMV+0UHF0H8QMlAa7hQp//vjlcaiFSx7MQKdKElf9XP+279iS
 a37V6uLnOAnnp7bTIAa4L0euLQ/KhAOOMCkfY8pg2rpukDcPivzgtFJSAOQLK301anu1
 E9OuhoONecb9ntcGzUFeuVoJHBMn2UuXh1dIlP8HsdHIF19ZRvCuuxeug2Y5epSgcEPX
 yUcoTyQQS8FTcVjfiDD2JW0TtXYRFjjztptC0bKgD3yA/yErZucVFZRhIHfUXe39MOK+
 23bIA0i2nI5bzQ2KcQ2QUxzfeOt1/O7QE8hYLXcys8iMdVKhPQVYpUht0dRYhaXqoieV
 hg1g==
X-Gm-Message-State: APjAAAXhGhdcieQR1k5ffEsgp1Fz+3pdp14Hm7nohPx62st+22tg3q1u
 dDrNUWHFBUMubLIHX37EstL8V03dTDE=
X-Google-Smtp-Source: APXvYqzGJ9JCKs57Z+yEEmKol3q9IyWbFYiRMjnVKEdZPVyvgk5uIZJNDY9PWE+yC0Rt6HAnb8l+Ng==
X-Received: by 2002:a63:b64:: with SMTP id a36mr22298999pgl.215.1566250757679; 
 Mon, 19 Aug 2019 14:39:17 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:39:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:52 -0700
Message-Id: <20190819213755.26175-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42e
Subject: [Qemu-devel] [PATCH v2 65/68] target/arm: Convert T16,
 Unconditional branch
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
 target/arm/translate.c | 9 ++-------
 target/arm/t16.decode  | 6 ++++++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 1882057402..51b14d409f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10612,7 +10612,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t val;
     int32_t offset;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
@@ -10656,12 +10655,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             gen_bx(s, tmp);
             break;
         }
-        /* unconditional branch */
-        val = read_pc(s);
-        offset = ((int32_t)insn << 21) >> 21;
-        val += offset << 1;
-        gen_jmp(s, val);
-        break;
+        /* unconditional branch, in decodetree */
+        goto illegal_op;
 
     case 15:
         /* thumb_insn_is_16bit() ensures we can't get here for
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index f87e6fde50..35a5b03118 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -268,3 +268,9 @@ LDM_t16         1011 110 ......... \
   SVC           1101 1111 imm:8                 &i
   B_cond_thumb  1101 cond:4 ........            &ci imm=%imm8_0x2
 }
+
+# Unconditional Branch
+
+%imm11_0x2      0:s11 !function=times_2
+
+B               11100 ...........               &i imm=%imm11_0x2
-- 
2.17.1


