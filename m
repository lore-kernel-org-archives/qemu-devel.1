Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59B9C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D4F1214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FrMhe1sV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4F1214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzq3q-00056W-Gx
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMj-0002Vn-1D
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMh-0006hb-KY
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:00 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38131)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpMh-0006gX-CC
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:59 -0400
Received: by mail-pg1-x541.google.com with SMTP id e11so1931400pga.5
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=R8HoRqd/AoFmWYfXPK5hhE5318TDJ9BrfYUZdys1jYA=;
 b=FrMhe1sVfA6OZy+SANvMDtN3xGxjlWOmeMn5GOFTm/hi0WmNcVopCVhmgQGAfcul/f
 xTXZP+nsOop00FozGbAoI8NrjdCEiN7T0Gq37a5ueJdF6meg7mZ70n5ZyPqMbnRzxUls
 XmxHnkGjAbA8wLUk025hbucB/GxdoHOeNYdcqlMIeZcjfXuy2K3iokfBmtPVyyvjyKut
 IOEILkEOgCzZY7aQVMnCoxy673kKnCv+3Rc/uqsOcB9ltFO8Y6u7XKYsfNVYbZ+HWGip
 H6QqkO3ZITRfCsvvHhL1SPltV4HOzmkJ3RpmoOYoqn1HvAQyEfFdc6QoCoMMLAfPuk68
 +YZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=R8HoRqd/AoFmWYfXPK5hhE5318TDJ9BrfYUZdys1jYA=;
 b=qQpHx0pBHlCjNA1g5GUqewTdaO5q7tTq1GIsXhlHMtQsJLCViKycbnZrrjVVvWg68u
 NMN2p0oLnZTSEGi10toCwC2A2EJYWL786DzD03VGQNa9V8p/Z4HDb2ico24H4KHjHhZH
 r4wX4L5F4npcrnG1OVC29pvQHGXZl9eSkGyiX733y0tFJiSqPeLRLkQLDBRbITpUyDSj
 bqD/TOOhKnmZmQDwRfiLjhHSsU9RQwB2IJHZxqDFy8dXM4MBAVVn4kmiPRKaANpyADaA
 sbsHhxCSqcvne+RzkBwe1+dQTTzbkF/x5m1LyBDwKVHlmcDQvGAb5wIRg8RnUFv9WYFO
 XzBA==
X-Gm-Message-State: APjAAAXtc4u1clvM/k9lP6qqxwLMA0Je0XOnRQjWaTd9mEpcvEcGA4QO
 oAn8jNjJARrZwOMPGBci+HgrAQZlRO0=
X-Google-Smtp-Source: APXvYqxWBbL3+O2409oudtd80kjjfnVnZQEAXavVMACa4xu0SWlQUd59/5aiPF+ShUBfT6FdCCNxtQ==
X-Received: by 2002:a17:90a:be06:: with SMTP id
 a6mr23028467pjs.92.1566250737948; 
 Mon, 19 Aug 2019 14:38:57 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:38:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:37 -0700
Message-Id: <20190819213755.26175-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v2 50/68] target/arm: Convert T16 add/sub (3
 low, 2 low and imm)
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
 target/arm/translate.c | 26 ++------------------------
 target/arm/t16.decode  | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index d417958b23..6f30415371 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10572,31 +10572,9 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
              * 0b0001_1xxx_xxxx_xxxx
              *  - Add, subtract (three low registers)
              *  - Add, subtract (two low registers and immediate)
+             * In decodetree.
              */
-            rn = (insn >> 3) & 7;
-            tmp = load_reg(s, rn);
-            if (insn & (1 << 10)) {
-                /* immediate */
-                tmp2 = tcg_temp_new_i32();
-                tcg_gen_movi_i32(tmp2, (insn >> 6) & 7);
-            } else {
-                /* reg */
-                rm = (insn >> 6) & 7;
-                tmp2 = load_reg(s, rm);
-            }
-            if (insn & (1 << 9)) {
-                if (s->condexec_mask)
-                    tcg_gen_sub_i32(tmp, tmp, tmp2);
-                else
-                    gen_sub_CC(tmp, tmp, tmp2);
-            } else {
-                if (s->condexec_mask)
-                    tcg_gen_add_i32(tmp, tmp, tmp2);
-                else
-                    gen_add_CC(tmp, tmp, tmp2);
-            }
-            tcg_temp_free_i32(tmp2);
-            store_reg(s, rd, tmp);
+            goto illegal_op;
         } else {
             /* shift immediate */
             rm = (insn >> 3) & 7;
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index a7a437f930..2b5f368d31 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -117,3 +117,19 @@ ADD_rri         10101 rd:3 ........ \
 
 STM             11000 ... ........              @ldstm
 LDM_t16         11001 ... ........              @ldstm
+
+# Add/subtract (three low registers)
+
+@addsub_3       ....... rm:3 rn:3 rd:3 \
+                &s_rrr_shi %s shim=0 shty=0
+
+ADD_rrri        0001100 ... ... ...             @addsub_3
+SUB_rrri        0001101 ... ... ...             @addsub_3
+
+# Add/subtract (two low registers and immediate)
+
+@addsub_2i      ....... imm:3 rn:3 rd:3 \
+                &s_rri_rot %s rot=0
+
+ADD_rri         0001 110 ... ... ...            @addsub_2i
+SUB_rri         0001 111 ... ... ...            @addsub_2i
-- 
2.17.1


