Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A154C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:09:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24012208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cduasaV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24012208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrAh-000419-Dy
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40239)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8U-00022J-2V
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8O-0000dM-P9
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:29 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35770)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsr8O-0000bI-7S
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:24 -0400
Received: by mail-wm1-x344.google.com with SMTP id l2so60318606wmg.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JEIhsoUVe/t2uBROzqs6p6wGD1/psRv2lgg50pkn0Cw=;
 b=cduasaV5SuAXu9fYxB4y5rpUSMxkR6CW9rKalNPPx1C5RQfwqkQGImFKAgSfPNNKmV
 lVrCEJmDXp8/Dg49ixeYLENJTKVgSSB5wz5z1fHnaLUR2FxKuhLsO21jmOZRbHfI16Vk
 kVQONHFlMVsfT8qFawZo28BrUphomvyR1MQnhOSJZO9g020DnxIRdO+QXOmbxlNwIETc
 AcD2tAsB1irO6er6Nc6zIQAJbXiHwijRwBLSa/3EldfS+keboB8ftABk8vV9NTwcTaIA
 W6pF7I6j186Dt5vbNBLIGnDYyiUA8cwo17xESMFSN9ZvyQbbAEoY0BVMhElBM7bRib0m
 Z6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JEIhsoUVe/t2uBROzqs6p6wGD1/psRv2lgg50pkn0Cw=;
 b=tqo9jSr17RR6NTDJ2w+106y2fq5AvKER/Nld2rMOUkaMatNONKnl0IrnRtFySFAaYm
 wlJSrYuoNKUo7wtvwjRvFXGChgFOvQ34jOpjpXJOObD6EIBKDD7a6uijym0y99zhmxDT
 Fbqcn2nbHJCvUZQGs3M1GNqkvCD9r7iYr/a9YGwEuJuK6VSvcZxLUT2zkdGl5IIvKTUe
 FJDUCLNqBGxAiroTh9bmVnP+C48j/SxSLTqQVwMnxen/ZFgEjhNjclgvHbLGHsx+JFvS
 6/pBRD74MY8w7/sjbAfqTJ6YxVzZpi5wnNiGypkSDaPpc3uolYa0C8Y3ihCK/2ONDRkM
 SMJQ==
X-Gm-Message-State: APjAAAVLQ38m9Cj2E0qcqUCZtlZsLQUqVHOKxNnUQ9Q2xbY15lGnlPJK
 1ct2dyHCYnS7MEMFzis3UDe3ROPjHfI=
X-Google-Smtp-Source: APXvYqyX0VwEQ5jcPnSFugLIR8CX/1cAaIk7a4XUdejJxpHFgqHEsaj7brqle0Pjwld1DAMgv0dx/A==
X-Received: by 2002:a7b:cb94:: with SMTP id
 m20mr107284760wmi.144.1564589242451; 
 Wed, 31 Jul 2019 09:07:22 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id i12sm81289977wrx.61.2019.07.31.09.07.20
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:07:20 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B50E01FF90;
 Wed, 31 Jul 2019 17:07:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:06:28 +0100
Message-Id: <20190731160719.11396-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v4 03/54] target/arm: handle A-profile A32
 semihosting at translate time
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, aaron@os.amperecomputing.com,
 cota@braap.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 bobby.prani@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As for the other semihosting calls we can resolve this at translate
time.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 662d6f49115..4cb0e6fd835 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7698,6 +7698,22 @@ static void arm_skip_unless(DisasContext *s, uint32_t cond)
     arm_gen_test_cc(cond ^ 1, s->condlabel);
 }
 
+static inline void gen_arm_swi(DisasContext *s, int imm24)
+{
+    if (semihosting_enabled() &&
+#ifndef CONFIG_USER_ONLY
+        s->current_el != 0 &&
+#endif
+        (imm24 == 0x123456)) {
+        gen_exception_internal_insn(s, 0, EXCP_SEMIHOST);
+        return;
+    }
+
+    gen_set_pc_im(s, s->pc);
+    s->svc_imm = imm24;
+    s->base.is_jmp = DISAS_SWI;
+}
+
 static void disas_arm_insn(DisasContext *s, unsigned int insn)
 {
     unsigned int cond, val, op1, i, shift, rm, rs, rn, rd, sh;
@@ -9248,9 +9264,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             break;
         case 0xf:
             /* swi */
-            gen_set_pc_im(s, s->pc);
-            s->svc_imm = extract32(insn, 0, 24);
-            s->base.is_jmp = DISAS_SWI;
+            gen_arm_swi(s, extract32(insn, 0, 24));
             break;
         default:
         illegal_op:
-- 
2.20.1


