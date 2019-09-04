Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEC2C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 491F2206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fnGC5dr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491F2206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5c2a-00079m-6y
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b15-0005dr-Bp
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b13-0003N7-BP
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:30 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:44811)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b11-0003J3-9w
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:29 -0400
Received: by mail-pf1-x435.google.com with SMTP id q21so8881001pfn.11
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ubjb98obYB0wcr0PkhZrvGjTKBKP700KuYx4LrhjRCk=;
 b=fnGC5dr5sDsjett47yIJEN9Of0JrUcyoeppmr5Qh4LB6cNBWhsckqvU5cTE8lpAHEx
 r8Ih/AEiuDrykNM3qjQWxFWR+jjJaLlsjxe9mg1TpwaVsT+RnZl9huleOuQSAG835P79
 d/C2lrMy6NecLtog9sLd5wE6f7q4Gn2O/7ukzRdFtk7Fv54Pts+pFWsnar2VZ0ESCn1Y
 hei9Pgi0PcyBK4QHejEVrCVuOs+5re1vjz8E42CHCLQRvE7jXnBOvgH1sISdNxGI6hyw
 TcS9ct4nuGS6ZuqPUww/QbokyjRXMtnjhQ7/Z1CxLsP5FXm73LahSLKzsgvasxXST37I
 U79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ubjb98obYB0wcr0PkhZrvGjTKBKP700KuYx4LrhjRCk=;
 b=dqXP83yZQKTgevfEVDVVHHCUElCN+ZpJ11Y8EyOlWsL6+xQe1CDrcQGsQ11sGe2RYI
 VGA8VPtSJBLI6JvrH5TVdLAFe914m1oOKxvaiu0xnAgsBIh378snfv+v7uecTr/qqNhA
 Fum5j2aS/MYEuQZxA2KGvNzzVAmB669pbCKtRXmIkJ0qZamZqdHuCu4kAcozsetIkWF2
 hreKiaINWdLE9R72Ri0l+Bx5KnIMHa5JnuzocdjdqddJoy6vMl4PRpRfSYP6d0O5m+Cj
 /M4weMCraVyeCerSHmae9uz6ZpwoGE83Olyhgc3qIGL3n0RU89vJjR5nDWe6U08ytJCI
 lABg==
X-Gm-Message-State: APjAAAUepV2WpSrHkJLKF24Ysdex7ZBg+d5jtTe+hTFteq+g/ykGW0RW
 qXVRaDwW3mDBzcBbTEcUOGCmN7MJ2Zo=
X-Google-Smtp-Source: APXvYqzUkpyiUrSHb6gzJRa9DtGOUg+tXICQVH0ofPcFhNpasc+qZOnqsyYZkf3F2t5yIjU3dZ6YVQ==
X-Received: by 2002:a63:6f8f:: with SMTP id k137mr36325209pgc.90.1567625544802; 
 Wed, 04 Sep 2019 12:32:24 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:32:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:56 -0700
Message-Id: <20190904193059.26202-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::435
Subject: [Qemu-devel] [PATCH v4 66/69] target/arm: Convert T16,
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 9 ++-------
 target/arm/t16.decode  | 6 ++++++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4f4c77fc89..3238ccbf1e 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10736,7 +10736,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t val;
     int32_t offset;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
@@ -10780,12 +10779,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
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
index 0b4da411e0..a4c89dba61 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -266,3 +266,9 @@ LDM_t16         1011 110 ......... \
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


